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
    // Verify authentication
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "Authentication required" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: authHeader } } }
    );

    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return new Response(
        JSON.stringify({ error: "Invalid authentication" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const { question, topic = "General Science", testConnection } = await req.json();
    
    const OPENAI_API_KEY = Deno.env.get("OPENAI_API_KEY");
    if (!OPENAI_API_KEY) {
      console.error("OPENAI_API_KEY is not configured");
      return new Response(
        JSON.stringify({ error: "OpenAI API key not configured. Please add your key in settings." }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Test connection endpoint
    if (testConnection) {
      console.log("Testing OpenAI connection...");
      try {
        const testResponse = await fetch("https://api.openai.com/v1/models", {
          method: "GET",
          headers: {
            Authorization: `Bearer ${OPENAI_API_KEY}`,
          },
        });

        if (!testResponse.ok) {
          const errorText = await testResponse.text();
          console.error("OpenAI connection test failed:", testResponse.status, errorText);
          return new Response(
            JSON.stringify({ error: "Invalid OpenAI API key. Please check your key." }),
            { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
          );
        }

        return new Response(
          JSON.stringify({ success: true, message: "✅ OpenAI Connected Successfully" }),
          { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
      } catch (error) {
        console.error("OpenAI connection test error:", error);
        return new Response(
          JSON.stringify({ error: "Failed to connect to OpenAI. Please check your key." }),
          { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
      }
    }

    // Input validation
    if (!question || typeof question !== "string") {
      return new Response(
        JSON.stringify({ error: "Question is required" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const trimmedQuestion = question.trim();
    if (trimmedQuestion.length === 0) {
      return new Response(
        JSON.stringify({ error: "Question cannot be empty" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    if (trimmedQuestion.length > 2000) {
      return new Response(
        JSON.stringify({ error: "Question must be less than 2000 characters" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Check for suspicious prompt injection patterns
    if (/ignore (previous|all) (instructions|prompts)/i.test(trimmedQuestion)) {
      return new Response(
        JSON.stringify({ error: "Invalid question format" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const systemPrompt = `You are Science Lens AI, an enthusiastic and engaging science tutor${topic !== "General Science" ? ` specializing in ${topic}` : ""}. Your goal is to make complex scientific concepts easy to understand and exciting to learn about.

Guidelines:
- Provide clear, accurate scientific explanations
- Use analogies and real-world examples
- Keep answers concise but informative (2-3 paragraphs max)
- Encourage curiosity and critical thinking
${topic !== "General Science" ? `- Focus on ${topic} but draw connections to related topics when helpful` : "- If the question is not science-related, politely redirect to science topics"}
- Use emojis occasionally to keep things fun (🔬, 🌟, 🧬, ⚡, 🌊, etc.)
- End with a follow-up question to keep the learning going

Current topic: ${topic}`;

    console.log(`Question from ${user.id}: ${trimmedQuestion.substring(0, 50)}... Topic: ${topic}`);

    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${OPENAI_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "gpt-4-turbo-preview",
        messages: [
          { role: "system", content: systemPrompt },
          { role: "user", content: trimmedQuestion },
        ],
        stream: true,
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      
      // Log detailed error server-side only
      console.error("OpenAI API error:", {
        status: response.status,
        error: errorText,
        timestamp: new Date().toISOString(),
        userId: user.id
      });
      
      // Return generic errors to client
      let clientMessage = "Unable to process your question. Please try again.";
      let statusCode = 500;
      
      if (response.status === 429) {
        clientMessage = "Service is busy. Please try again in a moment.";
        statusCode = 429;
      } else if (response.status === 401) {
        clientMessage = "Service configuration error. Please contact support.";
        statusCode = 500;
      }

      return new Response(
        JSON.stringify({ error: clientMessage }),
        { status: statusCode, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Return the streaming response
    return new Response(response.body, {
      headers: { ...corsHeaders, "Content-Type": "text/event-stream" },
    });

  } catch (error) {
    console.error("Error in science-chat function:", error);
    return new Response(
      JSON.stringify({ error: error instanceof Error ? error.message : "Unknown error" }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
