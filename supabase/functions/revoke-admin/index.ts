import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getCorsHeaders,
  handleOptions,
  validateOrigin,
  checkRateLimit as sharedCheckRateLimit,
  rateLimitResponse,
  logAuthFailure,
  logRateLimitViolation,
  logSuspiciousActivity,
  logPrivilegeEscalationAttempt,
  handleDatabaseError,
  handleAuthError,
  extractUserId,
} from "../_shared/security.ts";


const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

// Rate limit configuration
const RATE_LIMITS = {
  REVOKE_ADMIN: { max: 5, window: 3600 }, // 5 requests per hour (admin only)
};

// Helper function to check rate limit
async function checkRateLimit(
  supabase: any,
  userId: string,
  endpoint: string,
  maxRequests: number,
  windowSeconds: number
): Promise<{ allowed: boolean; retryAfter?: number; message?: string }> {
  const { data, error } = await supabase.rpc('check_rate_limit', {
    p_user_id: userId,
    p_endpoint: endpoint,
    p_max_requests: maxRequests,
    p_window_seconds: windowSeconds,
  });

  if (error) {
    console.error('Rate limit check error:', error);
    // Allow request if rate limit check fails (fail open)
    return { allowed: true };
  }

  if (!data.allowed) {
    return {
      allowed: false,
      retryAfter: data.retry_after,
      message: data.message || 'Rate limit exceeded',
    };
  }

  return { allowed: true };
}

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
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    );

    // Get requesting user from auth
    const { data: { user: requestingUser }, error: authError } = await supabaseClient.auth.getUser();
    if (authError || !requestingUser) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // Check rate limit
    const rateLimitCheck = await checkRateLimit(
      supabaseClient,
      requestingUser.id,
      'revoke-admin',
      RATE_LIMITS.REVOKE_ADMIN.max,
      RATE_LIMITS.REVOKE_ADMIN.window
    );

    if (!rateLimitCheck.allowed) {
      return new Response(JSON.stringify({
        error: rateLimitCheck.message || "Rate limit exceeded",
        retryAfter: rateLimitCheck.retryAfter,
      }), {
        status: 429,
        headers: {
          ...corsHeaders,
          'Content-Type': 'application/json',
          'Retry-After': rateLimitCheck.retryAfter?.toString() || "3600",
        },
      });
    }

    // SERVER-SIDE AUTHORIZATION: Check if requesting user is an admin
    const { data: requestingProfile, error: profileError } = await supabaseClient
      .from('profiles')
      .select('is_admin')
      .eq('user_id', requestingUser.id)
      .single();

    if (profileError || !requestingProfile) {
      return new Response(JSON.stringify({ error: 'Failed to verify admin status' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // Only admins can revoke admin privileges
    if (!requestingProfile.is_admin) {
      console.error(`Unauthorized admin revoke attempt by user ${requestingUser.id} (${requestingUser.email})`);
      return new Response(JSON.stringify({ error: 'Forbidden: Only admins can revoke admin privileges' }), {
        status: 403,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // Get target user ID from request body
    const { userId } = await req.json();

    if (!userId) {
      return new Response(JSON.stringify({ error: 'userId is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    console.log(`Admin ${requestingUser.email} revoking admin from user ${userId}`);

    // RATE LIMITING: 5 requests per hour
    const rateLimitResult = await checkRateLimit(
      supabaseClient,
      requestingUser.id,
      "revoke-admin",
      5,
      3600
    );

    if (!rateLimitResult.allowed) {
      await logRateLimitViolation(supabaseClient, requestingUser.id, "revoke-admin", 5, 3600);
      const resetAt = new Date(Date.now() + (rateLimitResult.retryAfter || 3600) * 1000);
      return rateLimitResponse(resetAt, corsHeaders);
    }
    // Get current user state to restore later
    const { data: currentProfile } = await supabaseClient
      .from('profiles')
      .select('level, xp_points, coins, is_premium')
      .eq('user_id', userId)
      .single();

    if (currentProfile) {
      // Save original state before revoking
      await supabaseClient
        .from('user_stats')
        .update({
          is_admin: false,
          original_state: currentProfile
        })
        .eq('user_id', userId);
    }

    // Revoke admin privileges from target user
    await supabaseClient
      .from('profiles')
      .update({
        is_admin: false
      })
      .eq('user_id', userId);

    return new Response(JSON.stringify({
      success: true,
      message: 'Admin privileges revoked successfully!'
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });

  } catch (error) {
    console.error('Error revoking admin:', error);
    return new Response(
      JSON.stringify({ error: "An error occurred while processing your request" }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );
  }
});
