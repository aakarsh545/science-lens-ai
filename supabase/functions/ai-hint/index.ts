import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getCorsHeaders,
  handleOptions,
  validateOrigin,
  createHardenedSystemPrompt,
  validatePromptInjection,
  sanitizeAIInput,
  logAuthFailure,
  logSuspiciousActivity,
} from "../_shared/security.ts";

serve(async (req) => {
  // Handle CORS preflight
  const optionsResponse = handleOptions(req);
  if (optionsResponse) return optionsResponse;

  // Validate origin
  const originValidation = validateOrigin(req);
  if (originValidation) return originValidation;

  // Get CORS headers for this origin
  const origin = req.headers.get("Origin");
  const corsHeaders = getCorsHeaders(origin);

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      await logAuthFailure(supabase, undefined, "ai-hint", "No authorization header");
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);

    if (userError || !user) {
      await logAuthFailure(supabase, undefined, "ai-hint", "Invalid token");
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const { question, context } = await req.json();

    // ==============================================================================
    // PROMPT INJECTION & AI SECURITY LAYER
    // ==============================================================================

    // Validate question input
    if (!question || typeof question !== 'string') {
      return new Response(JSON.stringify({ error: 'Question is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Validate for prompt injection
    const questionValidation = validatePromptInjection(question, 500);
    if (!questionValidation.allowed) {
      console.error(`[AI SECURITY] Blocked question - User: ${user.id}, Reason: ${questionValidation.blockedReason}`);
      await logSuspiciousActivity(
        supabase,
        user.id,
        "ai-hint",
        "Prompt injection attempt in question",
        { blockedReason: questionValidation.blockedReason }
      );
      return new Response(JSON.stringify({ error: questionValidation.error || 'Invalid input' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Validate context if provided
    if (context) {
      if (typeof context !== 'string') {
        return new Response(JSON.stringify({ error: 'Context must be a string' }), {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      const contextValidation = validatePromptInjection(context, 1000);
      if (!contextValidation.allowed) {
        console.error(`[AI SECURITY] Blocked context - User: ${user.id}, Reason: ${contextValidation.blockedReason}`);
        await logSuspiciousActivity(
          supabase,
          user.id,
          "ai-hint",
          "Prompt injection attempt in context",
          { blockedReason: contextValidation.blockedReason }
        );
        return new Response(JSON.stringify({ error: contextValidation.error || 'Invalid input' }), {
          status: 400,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }
    }

    // Sanitize inputs (defense in depth)
    const sanitizedQuestion = sanitizeAIInput(question, 500);
    const sanitizedContext = context ? sanitizeAIInput(context, 1000) : '';

    // ------------------------------------------------------------------------------
    // END PROMPT INJECTION & AI SECURITY LAYER
    // ==============================================================================

    // Check if user is admin (skip credit check/deduction for admins)
    const { data: isAdmin } = await supabase.rpc('has_role', {
      _user_id: user.id,
      _role: 'admin'
    });

    if (!isAdmin) {
      // Check credits
      const { data: stats } = await supabase
        .from('user_stats')
        .select('credits')
        .eq('user_id', user.id)
        .single();

      if (!stats || stats.credits < 1) {
        return new Response(JSON.stringify({
          error: 'credits_exhausted',
          message: "You've run out of learning credits. Recharge to continue receiving AI-powered hints and full explanations. Visit Pricing to buy credits."
        }), {
          status: 402,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      // Deduct credit
      await supabase
        .from('user_stats')
        .update({
          credits: stats.credits - 1,
          questions_asked: (stats as any).questions_asked + 1,
          updated_at: new Date().toISOString()
        })
        .eq('user_id', user.id);
    } else {
      console.log(`Admin user ${user.id} - skipping credit check/deduction`);
    }
    // Call OpenAI
    const openaiApiKey = Deno.env.get('OPENAI_API_KEY');
    if (!openaiApiKey) {
      throw new Error('OPENAI_API_KEY not configured');
    }

    console.log('Calling OpenAI gpt-4o-mini for hint...');

    // Create hardened system prompt
    const baseSystemPrompt = 'You are a helpful science tutor. Provide clear, concise hints and explanations. Keep answers educational and encouraging. If you\'re unsure about something, admit it rather than guessing. Keep hints under 150 words.';
    const hardenedSystemPrompt = createHardenedSystemPrompt(baseSystemPrompt);

    // SECURITY: Context isolation - user input is NEVER included in system message
    // System prompt is static and separate from user messages
    const userContent = sanitizedContext
      ? `Context: ${sanitizedContext}\n\nQuestion: ${sanitizedQuestion}`
      : sanitizedQuestion;

    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${openaiApiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          {
            role: 'system',
            content: hardenedSystemPrompt
          },
          {
            role: 'user',
            content: userContent
          }
        ],
        max_tokens: 1024,
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error('AI API error:', response.status, errorText);
      throw new Error('AI service error');
    }

    const data = await response.json();
    const hint = data.choices?.[0]?.message?.content || 'Unable to generate hint at this time.';

    return new Response(JSON.stringify({ hint }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    // Log detailed error server-side only
    console.error('AI hint error:', {
      error: error instanceof Error ? {
        name: error.name,
        message: error.message,
        stack: error.stack,
      } : error,
      timestamp: new Date().toISOString(),
    });

    // Return generic error to client (hide internals)
    return new Response(JSON.stringify({ error: 'Unable to generate hint. Please try again.' }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
