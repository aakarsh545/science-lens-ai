import "https://deno.land/x/xhr@0.1.0/mod.ts";
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const { message, conversationId, panelContext = "dashboard" } = await req.json();

    // Input validation
    if (!message || typeof message !== "string") {
      return new Response(
        JSON.stringify({ error: "Message is required" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const trimmedMessage = message.trim();
    if (trimmedMessage.length === 0) {
      return new Response(
        JSON.stringify({ error: "Message cannot be empty" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    if (trimmedMessage.length > 2000) {
      return new Response(
        JSON.stringify({ error: "Message must be less than 2000 characters" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Check for suspicious prompt injection patterns
    if (/ignore (previous|all) (instructions|prompts)/i.test(trimmedMessage)) {
      return new Response(
        JSON.stringify({ error: "Invalid message format" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }
    
    const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY");
    // Debug: log API key presence (not the key itself)
    console.log("OpenAI API key present:", !!OPENAI_API_KEY && OPENAI_API_KEY.startsWith("sk-"));
    if (!OPENAI_API_KEY) {
      console.error("OPENAI_API_KEY is not configured");
      return new Response(
        JSON.stringify({ error: "OpenAI API key not configured" }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Get auth token from request
    const authHeader = req.headers.get("authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "Missing authorization header" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Initialize Supabase client
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: authHeader } } }
    );

    // Get user
    const { data: { user }, error: userError } = await supabase.auth.getUser();
    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Unauthorized" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Save user message to database
    const { data: userMessage, error: userMsgError } = await supabase
      .from("messages")
      .insert({
        conversation_id: conversationId,
        user_id: user.id,
        role: "user",
        content: trimmedMessage,
      })
      .select()
      .single();

    if (userMsgError) {
      console.error("Error saving user message:", userMsgError);
      return new Response(
        JSON.stringify({ error: "Failed to save message" }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Get conversation history for context
    const { data: history } = await supabase
      .from("messages")
      .select("role, content")
      .eq("conversation_id", conversationId)
      .order("created_at", { ascending: true })
      .limit(10);

    const messages = history || [];

    // Call OpenAI with streaming
    const model = Deno.env.get("MODEL") ?? "gpt-4o-mini";
    console.log(`ask invoked by ${user.id} convo=${conversationId} panel=${panelContext} msgLen=${trimmedMessage.length}`);

    // Context-aware system prompts
    const systemPrompts = {
      dashboard: "You are Science Lens AI, a helpful general assistant. Keep responses concise and friendly. If the user asks about learning science topics in depth, suggest: 'For detailed educational content with examples and visuals, check out the Learn panel.'",
      learn: "You are Science Lens AI, an enthusiastic science educator. Provide detailed explanations with examples, analogies, and encourage curiosity. Use emojis 🔬🌟 to make learning engaging. Break down complex concepts step-by-step.",
      test: "You are Science Lens AI in quiz mode. Provide direct, factual answers suitable for evaluation. Keep responses concise and accurate. Focus on key facts and concepts.",
    };

    const systemPrompt = systemPrompts[panelContext as keyof typeof systemPrompts] || systemPrompts.dashboard;

    const openaiPayload = {
      model,
      messages: [
        {
          role: "system",
          content: systemPrompt,
        },
        ...messages,
      ],
      stream: true,
    } as const;

    // Debug: log model and payload summary (not full content)
    console.log("OpenAI model:", model);
    console.log("OpenAI payload summary:", {
      messageCount: openaiPayload.messages.length,
      hasSystem: openaiPayload.messages[0]?.role === "system",
    });

    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${OPENAI_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(openaiPayload),
    });

    if (!response.ok) {
      const errorText = await response.text();

      // Try to parse OpenAI error JSON for a clearer message
      let errMsg = "";
      try {
        const parsed = JSON.parse(errorText);
        errMsg = parsed?.error?.message || parsed?.message || errorText;
      } catch {
        errMsg = errorText;
      }

      // Log detailed error server-side only
      console.error("OpenAI API error:", {
        status: response.status,
        error: errMsg,
        raw: errorText,
        timestamp: new Date().toISOString(),
        userId: user.id,
        model,
      });

      // Optional fallback to Lovable AI when rate limited or out of quota
      if (response.status === 429 || response.status === 402) {
        const LOVABLE_API_KEY = Deno.env.get("LOVABLE_API_KEY");
        if (LOVABLE_API_KEY) {
          try {
            console.log("Falling back to Lovable AI gateway (google/gemini-2.5-flash)");
            const lbPayload = {
              // default model if not provided
              model: "google/gemini-2.5-flash",
              messages: openaiPayload.messages,
              stream: true,
            } as const;

            const lbResp = await fetch("https://ai.gateway.lovable.dev/v1/chat/completions", {
              method: "POST",
              headers: {
                Authorization: `Bearer ${LOVABLE_API_KEY}`,
                "Content-Type": "application/json",
              },
              body: JSON.stringify(lbPayload),
            });

            if (!lbResp.ok) {
              const lbText = await lbResp.text();
              console.error("Lovable AI gateway error:", lbResp.status, lbText);
              return new Response(
                JSON.stringify({ error: `AI fallback failed: ${lbText}` }),
                { status: lbResp.status, headers: { ...corsHeaders, "Content-Type": "application/json" } }
              );
            }

            // Return the Lovable AI stream
            return new Response(lbResp.body, {
              headers: {
                ...corsHeaders,
                "Content-Type": "text/event-stream",
                "Cache-Control": "no-cache",
                "Connection": "keep-alive",
              },
            });
          } catch (fallbackErr) {
            console.error("Lovable AI fallback exception:", fallbackErr);
            return new Response(
              JSON.stringify({ error: "AI fallback exception" }),
              { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
          }
        }
      }

      // Surface specific error back to client with proper status code
      const status = response.status === 0 ? 500 : response.status;
      return new Response(
        JSON.stringify({ error: errMsg || "AI provider error" }),
        { status, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Return the stream directly to client
    return new Response(response.body, {
      headers: { 
        ...corsHeaders, 
        "Content-Type": "text/event-stream",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive"
      },
    });

  } catch (error) {
    console.error("Error in ask function:", error);
    return new Response(
      JSON.stringify({ error: error instanceof Error ? error.message : "Unknown error" }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});