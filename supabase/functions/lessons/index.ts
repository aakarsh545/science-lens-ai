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

    // Parse body once and reuse
    let body: any = null;
    if (req.method === 'POST') {
      body = await req.json();
    }

    const url = new URL(req.url);
    const path = url.pathname.split('/').filter(Boolean);

    // Handle POST requests
    if (req.method === 'POST' && body) {
      const lessonId = body.id || path[0];

      // Handle complete action (requires auth)
      if (body.action === 'complete') {
        if (!authHeader) {
          throw new Error('No authorization header');
        }
        const token = authHeader.replace('Bearer ', '');
        const { data: { user }, error: userError } = await supabase.auth.getUser(token);
        
        if (userError || !user) throw new Error('Unauthorized');

        const { data: lesson } = await supabase
          .from('lessons')
          .select('xp_reward')
          .eq('id', lessonId)
          .maybeSingle();

        const xpEarned = lesson?.xp_reward || 10;

        // Refresh daily credits
        await supabase.rpc('refresh_daily_credits', { p_user_id: user.id });

        // Check if user has enough credits (1 credit per lesson)
        const { data: stats } = await supabase
          .from('user_stats')
          .select('credits')
          .eq('user_id', user.id)
          .single();

        const currentCredits = stats?.credits || 0;
        if (currentCredits < 1) {
          return new Response(JSON.stringify({
            error: 'credits_exhausted',
            message: 'No credits remaining. Daily credits refresh at midnight.'
          }), {
            status: 402,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          });
        }

        // Deduct 1 credit for lesson completion
        const { error: deductError } = await supabase.rpc('deduct_credits', {
          p_user_id: user.id,
          p_amount: 1
        });

        if (deductError) {
          console.error('[lessons] Error deducting credits:', deductError);
          throw new Error('Failed to deduct credits');
        }

        // Check if already completed
        const { data: existing } = await supabase
          .from('user_progress')
          .select('*')
          .eq('user_id', user.id)
          .eq('lesson_id', lessonId)
          .eq('status', 'completed')
          .maybeSingle();

        if (existing) {
          const { data: stats } = await supabase
            .from('user_stats')
            .select('*')
            .eq('user_id', user.id)
            .single();

          return new Response(JSON.stringify({ 
            alreadyCompleted: true, 
            stats 
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          });
        }

        // Upsert user_progress
        const { error: progressError } = await supabase
          .from('user_progress')
          .upsert({
            user_id: user.id,
            lesson_id: lessonId,
            status: 'completed',
            xp_earned: xpEarned,
            last_practiced: new Date().toISOString(),
          });

        if (progressError) throw progressError;

        // Update user_stats
        const { data: stats } = await supabase
          .from('user_stats')
          .select('*')
          .eq('user_id', user.id)
          .single();

        const newXpTotal = (stats?.xp_total || 0) + xpEarned;

        const { data: updatedStats, error: updateError } = await supabase
          .from('user_stats')
          .upsert({
            user_id: user.id,
            xp_total: newXpTotal,
            updated_at: new Date().toISOString(),
          })
          .select()
          .single();

        if (updateError) throw updateError;

        // Award coins for lesson completion (10 base coins, 2x for premium)
        const { data: profile } = await supabase
          .from('profiles')
          .select('is_premium')
          .eq('user_id', user.id)
          .single();

        const isPremium = profile?.is_premium || false;
        const coinReward = isPremium ? 20 : 10;

        await supabase.rpc('award_coins', {
          user_id: user.id,
          amount: coinReward,
          source: 'lesson',
          metadata: { lesson_id: lessonId, lesson_title: lesson?.title }
        });

        return new Response(JSON.stringify({ 
          success: true, 
          xpEarned,
          stats: updatedStats 
        }), {
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      // GET lesson details (via POST with id)
      const { data: lesson, error } = await supabase
        .from('lessons')
        .select('*')
        .eq('id', lessonId)
        .maybeSingle();

      if (error) {
        console.error('[lessons] Error fetching lesson:', error, { lessonId });
        throw error;
      }

      if (!lesson) {
        return new Response(JSON.stringify({ error: 'Lesson not found' }), {
          status: 404,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      return new Response(JSON.stringify(lesson), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const lessonId = path[0];

    // GET /lessons/:id - get lesson details
    if (req.method === 'GET') {
      const { data: lesson, error } = await supabase
        .from('lessons')
        .select('*')
        .eq('id', lessonId)
        .maybeSingle();

      if (error) {
        console.error('[lessons] Error fetching lesson:', error, { lessonId });
        throw error;
      }

      if (!lesson) {
        return new Response(JSON.stringify({ error: 'Lesson not found' }), {
          status: 404,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      return new Response(JSON.stringify(lesson), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify({ error: 'Not found' }), {
      status: 404,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    console.error('[lessons] Error:', error, { 
      url: req.url, 
      method: req.method 
    });
    return new Response(JSON.stringify({ 
      error: errorMessage,
      code: 'LESSONS_ERROR'
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});