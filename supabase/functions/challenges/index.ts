import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      throw new Error('No authorization header');
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);
    
    if (userError || !user) throw new Error('Unauthorized');

    const url = new URL(req.url);
    const path = url.pathname.split('/').filter(Boolean);

    // GET /challenges/next - get next challenge
    if (req.method === 'GET' && path[0] === 'next') {
      const { data: stats } = await supabase
        .from('user_stats')
        .select('xp_total')
        .eq('user_id', user.id)
        .single();

      const xpTotal = stats?.xp_total || 0;
      
      // Simple algorithm: choose challenge based on XP level
      let difficulty = 'easy';
      if (xpTotal > 100) difficulty = 'medium';
      if (xpTotal > 500) difficulty = 'hard';

      const { data: challenge, error } = await supabase
        .from('challenges')
        .select('*')
        .eq('difficulty', difficulty)
        .limit(1)
        .single();

      if (error) {
        // If no challenge found, return random one
        const { data: anyChallenge } = await supabase
          .from('challenges')
          .select('*')
          .limit(1)
          .single();

        return new Response(JSON.stringify(anyChallenge || {}), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      return new Response(JSON.stringify(challenge), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // POST /challenges/:id/attempt - submit challenge attempt
    if (req.method === 'POST' && path[1] === 'attempt') {
      const challengeId = path[0];
      const { answer } = await req.json();

      const { data: challenge } = await supabase
        .from('challenges')
        .select('*')
        .eq('id', challengeId)
        .single();

      if (!challenge) throw new Error('Challenge not found');

      // Simple evaluation - check if answer matches expected
      const payload = challenge.payload as any;
      const isCorrect = payload?.correctAnswer === answer;

      if (isCorrect) {
        const xpReward = challenge.xp_reward || 20;

        // Award XP
        const { data: stats } = await supabase
          .from('user_stats')
          .select('xp_total')
          .eq('user_id', user.id)
          .single();

        const newXpTotal = (stats?.xp_total || 0) + xpReward;

        await supabase
          .from('user_stats')
          .upsert({
            user_id: user.id,
            xp_total: newXpTotal,
            updated_at: new Date().toISOString(),
          });

        return new Response(JSON.stringify({ 
          success: true, 
          isCorrect: true,
          xpEarned: xpReward 
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      return new Response(JSON.stringify({ 
        success: true, 
        isCorrect: false 
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify({ error: 'Not found' }), {
      status: 404,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    console.error('Error:', error);
    return new Response(JSON.stringify({ error: errorMessage }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});