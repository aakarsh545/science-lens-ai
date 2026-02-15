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
    const wolframApiKey = Deno.env.get('WOLFRAM_ALPHA_API_KEY');

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

    if (!wolframApiKey) {
      return new Response(JSON.stringify({ error: 'Wolfram Alpha API key not configured' }), {
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

    console.log('[wolfram-hint] Processing hint for user:', user.id, 'question:', question);

    // Construct Wolfram Alpha query
    const query = `${question}`;
    if (context) {
      query += ` context: ${context}`;
    }

    // Call Wolfram Alpha API
    const wolframUrl = `https://api.wolframalpha.com/v2/query?input=${encodeURIComponent(query)}&format=plaintext&output=JSON&appid=${wolframApiKey}`;

    const wolframResponse = await fetch(wolframUrl);
    const wolframData = await wolframResponse.json();

    if (wolframData.queryresult?.success === false) {
      return new Response(JSON.stringify({
        error: 'Wolfram Alpha could not process the query',
        hint: 'This question might be too complex for Wolfram Alpha. Try rephrasing it or ask for a simpler hint.'
      }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Extract the answer from Wolfram Alpha response
    const pods = wolframData.queryresult?.pods || [];
    let hintText = '';

    if (pods.length > 0) {
      // Get the primary result pod
      const primaryPod = pods.find((pod: any) => pod.primary) || pods[0];
      const subpods = primaryPod?.subpods || [];

      if (subpods.length > 0) {
        hintText = subpods
          .map((subpod: any) => subpod.plaintext || '')
          .filter((text: string) => text.length > 0)
          .join('\n\n');
      } else if (primaryPod.plaintext) {
        hintText = primaryPod.plaintext;
      }
    }

    if (!hintText) {
      hintText = 'No clear answer found. Try asking a more specific question.';
    }

    // Format the hint for the user
    const formattedHint = `🔬 Wolfram Alpha Hint:\n\n${hintText}`;

    console.log('[wolfram-hint] Generated hint for user:', user.id);

    return new Response(JSON.stringify({
      success: true,
      hint: formattedHint,
      source: 'wolfram-alpha'
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    console.error('[wolfram-hint] Error:', {
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
