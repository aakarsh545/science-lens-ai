import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const SUPER_ADMIN_EMAIL = 'aakarsh545@gmail.com';

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

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

    // SERVER-SIDE AUTHORIZATION: Check if requesting user is super admin
    const requestingUserEmail = requestingUser.email;

    // ONLY super admin can revoke admin privileges
    if (requestingUserEmail !== SUPER_ADMIN_EMAIL) {
      console.error(`Unauthorized admin revoke attempt by user ${requestingUser.id} (${requestingUserEmail})`);
      return new Response(JSON.stringify({ error: 'Forbidden: Only super admin can revoke admin privileges' }), {
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

    console.log(`Super admin ${requestingUserEmail} revoking admin from user ${userId}`);

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
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });
  }
});
