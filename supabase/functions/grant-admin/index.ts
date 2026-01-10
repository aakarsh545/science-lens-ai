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


// Rate limit configuration
const RATE_LIMITS = {
  GRANT_ADMIN: { max: 5, window: 3600 }, // 5 requests per hour (admin only)
};

serve(async (req) => {
  // Handle CORS preflight using shared security
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

    // Check rate limit using shared fail-closed function
    const rateLimitCheck = await checkRateLimit(
      supabaseClient,
      requestingUser.id,
      'grant-admin',
      RATE_LIMITS.GRANT_ADMIN.max,
      RATE_LIMITS.GRANT_ADMIN.window
    );

    if (!rateLimitCheck.allowed) {
      await logRateLimitViolation(
        supabaseClient,
        requestingUser.id,
        "grant-admin",
        RATE_LIMITS.GRANT_ADMIN.max,
        RATE_LIMITS.GRANT_ADMIN.window
      );
      return rateLimitResponse(rateLimitCheck.resetAt, corsHeaders);
    }

    // SERVER-SIDE AUTHORIZATION: Check if requesting user is super admin
    const { data: requestingProfile, error: profileError } = await supabaseClient
      .from('profiles')
      .select('is_admin, email')
      .eq('user_id', requestingUser.id)
      .single();

    if (profileError || !requestingProfile) {
      return new Response(JSON.stringify({ error: 'Failed to verify admin status' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    // SERVER-SIDE AUTHORIZATION: Check if requesting user is an admin
    // Uses is_admin field from database, not hardcoded email
    if (!requestingProfile.is_admin) {
      console.error(`Unauthorized admin grant attempt by user ${requestingUser.id} (${requestingUser.email})`);
      return new Response(JSON.stringify({ error: 'Forbidden: Only admins can grant admin privileges' }), {
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

    console.log(`Admin ${requestingUser.email} granting admin to user ${userId}`);

    // Grant admin privileges to target user
    // 1. Set max level and coins in profiles
    const { error: profileError2 } = await supabaseClient
      .from('profiles')
      .update({
        is_admin: true,
        level: 1000,
        xp_points: 100000,
        coins: 999999999,
        is_premium: true
      })
      .eq('user_id', userId);

    if (profileError2) {
      throw profileError2;
    }

    // 2. Set admin flag in user_stats
    await supabaseClient
      .from('user_stats')
      .update({ is_admin: true })
      .eq('user_id', userId);

    // 3. Get all shop items
    const { data: shopItems, error: itemsError } = await supabaseClient
      .from('shop_items')
      .select('id');

    if (itemsError) {
      throw itemsError;
    }

    // 4. Add all items to user inventory
    if (shopItems && shopItems.length > 0) {
      for (const item of shopItems) {
        try {
          await supabaseClient
            .from('user_inventory')
            .insert({ user_id: userId, item_id: item.id });
        } catch (err) {
          // Ignore duplicate errors
          if (!err.message?.includes('duplicate')) {
            console.warn('Failed to add item:', err);
          }
        }
      }
    }

    // Log successful privilege escalation
    await logPrivilegeEscalationAttempt(
      supabaseClient,
      requestingUser.id,
      "grant-admin",
      userId,
      true
    );

    return new Response(JSON.stringify({
      success: true,
      message: 'Admin privileges granted successfully!',
      privileges: {
        level: 1000,
        coins: 999999999,
        is_premium: true,
        all_items_unlocked: true
      }
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });

  } catch (error) {
    console.error('Error granting admin:', error);
    return new Response(
      JSON.stringify({ error: "An error occurred while processing your request" }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      }
    );
  }
});
