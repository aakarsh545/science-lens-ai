import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    );

    const { data: { user } } = await supabaseClient.auth.getUser();
    if (!user || user.email !== 'aakarsh545@gmail.com') {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
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
    console.error('Error:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    });
  }
});
