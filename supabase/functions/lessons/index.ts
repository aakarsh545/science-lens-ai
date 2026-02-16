import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Max-Age': '86400',
};

serve(async (req) => {
  // Handle OPTIONS preflight request
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  // Helper function to create JSON responses with CORS
  const jsonResponse = (data: any, status = 200) => {
    return new Response(JSON.stringify(data), {
      status,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  };

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Verify authentication for all requests except OPTIONS (handled above)
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      console.error('[lessons] Missing authorization header');
      return jsonResponse({ error: 'Authentication required' }, 401);
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);

    if (userError || !user) {
      console.error('[lessons] Invalid token:', userError?.message);
      return jsonResponse({ error: 'Invalid authentication token' }, 401);
    }

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

      // Handle complete action (requires auth - already verified above)
      if (body.action === 'complete') {

        const { data: lesson } = await supabase
          .from('lessons')
          .select('xp_reward, title')
          .eq('id', lessonId)
          .maybeSingle();

        const xpEarned = lesson?.xp_reward || 10;

        // Check if user is admin (skip credit check/deduction for admins)
        const { data: isAdmin } = await supabase.rpc('has_role', {
          _user_id: user.id,
          _role: 'admin'
        });

        if (!isAdmin) {
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
            return jsonResponse({
              error: 'credits_exhausted',
              message: 'No credits remaining. Daily credits refresh at midnight.'
            }, 402);
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
        } else {
          console.log(`Admin user ${user.id} - skipping credit check/deduction for lesson`);
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
          const { data: existingStats } = await supabase
            .from('user_stats')
            .select('*')
            .eq('user_id', user.id)
            .single();

          return jsonResponse({
            alreadyCompleted: true,
            stats: existingStats
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
        const { data: currentStats } = await supabase
          .from('user_stats')
          .select('*')
          .eq('user_id', user.id)
          .single();

        const newXpTotal = (currentStats?.xp_total || 0) + xpEarned;

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

        // Award coins by updating profiles directly
        await supabase
          .from('profiles')
          .update({ credits: (currentStats?.credits || 0) + coinReward })
          .eq('user_id', user.id);

        return jsonResponse({
          success: true,
          xpEarned,
          stats: updatedStats
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
        return jsonResponse({ error: 'Lesson not found' }, 404);
      }

      return jsonResponse(lesson);
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
        return jsonResponse({ error: 'Lesson not found' }, 404);
      }

      return jsonResponse(lesson);
    }

    return jsonResponse({ error: 'Not found' }, 404);

  } catch (error: unknown) {
    // Log detailed error server-side only
    console.error('[lessons] Error:', {
      error: error instanceof Error ? {
        name: error.name,
        message: error.message,
        stack: error.stack,
      } : error,
      url: req.url,
      method: req.method,
      timestamp: new Date().toISOString(),
    });

    // Return generic error to client (hide internals)
    return jsonResponse({
      error: 'An error occurred. Please try again.',
    }, 500);
  }
});