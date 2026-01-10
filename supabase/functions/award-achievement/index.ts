import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getCorsHeaders,
  handleOptions,
  validateOrigin,
  extractUserId,
} from "../_shared/security.ts";

// ============================================================================
// SERVER-SIDE ACHIEVEMENT DEFINITIONS
// ============================================================================
// Client NEVER sends these. Server owns all achievement data.
// ============================================================================

interface AchievementDefinition {
  type: string;
  title: string;
  description: string;
  icon: string;
  category: string;
  points: number;
  credits: number;
}

// Achievement definition map - server-authoritative
const ACHIEVEMENTS: Record<string, AchievementDefinition> = {
  first_question: {
    type: "first_question",
    title: "First Steps",
    description: "Asked your first question",
    icon: "🎯",
    category: "milestone",
    points: 10,
    credits: 1,
  },
  curious_mind: {
    type: "curious_mind",
    title: "Curious Mind",
    description: "Asked 10 questions",
    icon: "🤔",
    category: "milestone",
    points: 50,
    credits: 5,
  },
  knowledge_seeker: {
    type: "knowledge_seeker",
    title: "Knowledge Seeker",
    description: "Asked 50 questions",
    icon: "🎓",
    category: "milestone",
    points: 100,
    credits: 10,
  },
};

// Valid event types that client can request
const VALID_EVENTS = Object.keys(ACHIEVEMENTS);

serve(async (req) => {
  // Handle CORS preflight
  const optionsResponse = handleOptions(req);
  if (optionsResponse) return optionsResponse;

  // Validate origin
  const originValidation = validateOrigin(req);
  if (originValidation) return originValidation;

  const origin = req.headers.get("Origin");
  const corsHeaders = getCorsHeaders(origin);

  try {
    // Get auth token
    const authHeader = req.headers.get("authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "Missing authorization header" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Extract user ID
    const userId = extractUserId(authHeader);
    if (!userId) {
      return new Response(
        JSON.stringify({ error: "Invalid token" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Parse request body - client only sends event + metadata
    const { event, metadata } = await req.json();

    // VALIDATE: Event must be recognized
    if (!event || typeof event !== "string") {
      return new Response(
        JSON.stringify({ error: "Event is required" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // VALIDATE: Event must be in whitelist
    if (!VALID_EVENTS.includes(event)) {
      console.error(`Invalid event: ${event} from user ${userId}`);
      return new Response(
        JSON.stringify({ error: "Invalid event" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Get achievement definition from server-side map
    const achievement = ACHIEVEMENTS[event];

    // Initialize Supabase client with SERVICE ROLE for mutations
    // This bypasses RLS and ensures server can always write
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    if (!supabaseServiceKey) {
      console.error("SUPABASE_SERVICE_ROLE_KEY not configured");
      return new Response(
        JSON.stringify({ error: "Server configuration error" }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey, {
      global: {
        headers: { Authorization: authHeader }
      }
    });

    // VALIDATE: Check if user already earned this achievement
    // This prevents farming via retries
    const { data: existing } = await supabase
      .from("achievements")
      .select("id")
      .eq("user_id", userId)
      .eq("achievement_type", achievement.type)
      .maybeSingle();

    if (existing) {
      console.warn(`User ${userId} already earned achievement ${achievement.type}`);
      return new Response(
        JSON.stringify({ error: "Achievement already earned" }),
        { status: 409, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Insert achievement record using server-side data
    const { error: insertError } = await supabase
      .from("achievements")
      .insert({
        user_id: userId,
        achievement_type: achievement.type,
        title: achievement.title,
        description: achievement.description,
        icon: achievement.icon,
        category: achievement.category,
        points: achievement.points,
      });

    // Handle unique constraint violation (race condition protection)
    if (insertError) {
      // Postgres unique constraint error code = "23505"
      if (insertError.code === "23505") {
        console.warn(`Race condition: Achievement ${achievement.type} already earned by user ${userId}`);
        return new Response(
          JSON.stringify({ error: "Achievement already earned" }),
          { status: 409, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
      }
      console.error("Failed to insert achievement:", insertError);
      throw insertError;
    }

    // Award credits via RPC (server-authoritative)
    const { error: creditError } = await supabase.rpc("add_credits", {
      p_user_id: userId,
      p_amount: achievement.credits,
    });

    if (creditError) {
      console.error("Failed to award credits:", creditError);
      throw creditError;
    }

    console.log(`Awarded achievement ${achievement.type} to user ${userId}, +${achievement.credits} credits`);

    return new Response(
      JSON.stringify({
        success: true,
        achievement: {
          type: achievement.type,
          title: achievement.title,
          description: achievement.description,
          credits: achievement.credits,
        }
      }),
      { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );

  } catch (error) {
    console.error("Error in award-achievement:", error);
    return new Response(
      JSON.stringify({ error: "Failed to award achievement" }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
