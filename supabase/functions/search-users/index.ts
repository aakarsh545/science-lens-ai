import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getCorsHeaders,
  handleOptions,
  validateOrigin,
  checkRateLimit,
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
  SEARCH_USERS: { max: 30, window: 60 }, // 30 requests per minute (admin only)
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
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    );

    const { data: { user } } = await supabaseClient.auth.getUser();
    if (!user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 403,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // Check rate limit
    const rateLimitCheck = await checkRateLimit(
      supabaseClient,
      user.id,
      'search-users',
      RATE_LIMITS.SEARCH_USERS.max,
      RATE_LIMITS.SEARCH_USERS.window
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
          'Retry-After': rateLimitCheck.retryAfter?.toString() || "60",
        },
      });
    }

    // Check if user is admin
    const { data: profile } = await supabaseClient
      .from('profiles')
      .select('is_admin')
      .eq('user_id', user.id)
      .single();

    // RATE LIMITING: 30 requests per minute
    const rateLimitResult = await checkRateLimit(
      supabaseClient,
      user.id,
      "search-users",
      30,
      60
    );

    if (!rateLimitResult.allowed) {
      await logRateLimitViolation(supabaseClient, user.id, "search-users", 30, 60);
      return rateLimitResponse(rateLimitResult.resetAt, corsHeaders);
    }

    if (!profile || !profile.is_admin) {
      return new Response(JSON.stringify({ error: 'Forbidden: Admin access required' }), {
        status: 403,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    if (req.method === 'GET') {
      // Get all profiles with their auth emails
      const { data: profiles } = await supabaseClient
        .from('profiles')
        .select('id, level, coins, is_admin, is_premium')
        .order('level', { ascending: false })
        .limit(50);

      // Get all auth users
      const { data: { users: authUsers }, error: authError } = await supabaseClient.auth.admin.listUsers();

      if (authError) {
        // If service role isn't available, return profiles without emails
        const usersWithEmail = (profiles || []).map((profile: any) => ({
          ...profile,
          email: 'Hidden (no service role)'
        }));

        return new Response(JSON.stringify({ users: usersWithEmail }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
      }

      // Match emails to profiles
      const usersWithEmail = (profiles || []).map((profile: any) => {
        const authUser = authUsers?.find((u: any) => u.id === profile.id);
        return {
          ...profile,
          email: authUser?.email || 'Unknown'
        };
      });

      return new Response(JSON.stringify({ users: usersWithEmail }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });

  } catch (error) {
    console.error('Error in search-users:', error);
    return new Response(
      JSON.stringify({ error: "An error occurred while processing your request" }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );
  }
});
