import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Max-Age': '86400',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);
    const grokApiKey = Deno.env.get('GROK_API_KEY');

    // Verify authentication
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Authentication required' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);

    if (userError || !user) {
      return new Response(JSON.stringify({ error: 'Invalid authentication token' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    if (!grokApiKey) {
      return new Response(JSON.stringify({ error: 'xAI Grok API key not configured' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const body = await req.json();
    const { question, context } = body;

    if (!question) {
      return new Response(JSON.stringify({ error: 'Question is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    console.log('[grok-hint] Processing hint for user:', user.id, 'question:', question);

    // Call xAI Grok API
    const grokApiUrl = Deno.env.get('GROK_API_ENDPOINT') || 'https://api.x.ai/v1';

    const response = await fetch(`${grokApiUrl}/messages`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${grokApiKey}`
      },
      body: JSON.stringify({
        messages: [
          {
            role: 'system',
            content: `You are a helpful AI assistant for a science learning platform called Science Lens AI. A user is asking for help understanding this lesson topic: "${question}". ${context ? `Lesson context: ${context}` : ''} Provide a clear, educational hint that helps them understand the concept better. Keep your response concise (under 150 words) and focus on the key scientific concepts.`
          }
        ]
      })
    );

    if (!response.ok) {
      console.error('[grok-hint] API error:', response.status, await response.text());
      return new Response(JSON.stringify({ error: 'Failed to get hint from xAI Grok' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const data = await response.json();

    // Extract the assistant's response
    const hint = data.choices[0]?.message?.content || 'No hint available';

    console.log('[grok-hint] Generated hint for user:', user.id);

    return new Response(JSON.stringify({
      success: true,
      hint: `🤖 xAI Grok Hint:\n\n${hint}`,
      source: 'grok'
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    console.error('[grok-hint] Error:', {
      error: error instanceof Error ? {
        name: error.name,
        message: error.message,
        stack: error.stack,
      } : error,
      url: req.url,
      method: req.method,
      timestamp: new Date().toISOString(),
    });

    return new Response(JSON.stringify({
      error: 'An error occurred while generating hint'
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
