import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

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

    // Get user from auth
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser();
    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      });
    }

    const userId = user.id;

    // Grant admin privileges
    // 1. Set max level and coins in profiles
    const { error: profileError } = await supabaseClient
      .from('profiles')
      .update({
        is_admin: true,
        level: 1000,
        xp_points: 100000,
        coins: 999999999,
        is_premium: true
      })
      .eq('user_id', userId);

    if (profileError) {
      throw profileError;
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
      const inventoryItems = shopItems.map(item => ({
        user_id: userId,
        item_id: item.id
      }));

      await supabaseClient
        .from('user_inventory')
        .insert(inventoryItems, { count: 'exact' })
        .ignoreDuplicates();
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
