import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

const SUPER_ADMIN_EMAIL = 'aakarsh545@gmail.com';

serve(async (req) => {
  // Handle CORS
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

    // Get requesting user's email from auth
    const requestingUserEmail = requestingUser.email;

    // ONLY super admin can grant admin privileges
    if (requestingUserEmail !== SUPER_ADMIN_EMAIL) {
      console.error(`Unauthorized admin grant attempt by user ${requestingUser.id} (${requestingUserEmail})`);
      return new Response(JSON.stringify({ error: 'Forbidden: Only super admin can grant admin privileges' }), {
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

    console.log(`Super admin ${requestingUserEmail} granting admin to user ${userId}`);

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
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });
  }
});
