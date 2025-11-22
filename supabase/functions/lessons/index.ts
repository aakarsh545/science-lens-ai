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

    const url = new URL(req.url);
    const path = url.pathname.split('/').filter(Boolean);
    
    // Handle POST with body.id or body.action
    if (req.method === 'POST') {
      const body = await req.json();
      const lessonId = body.id || path[0];

      // GET lesson details (via POST with id)
      if (!body.action || body.action === 'get') {
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

    // POST /lessons/:id/complete OR POST with action=complete
    const body = req.method === 'POST' ? await req.json() : null;
    if ((req.method === 'POST' && path[1] === 'complete') || (body?.action === 'complete')) {
      const completeLessonId = body?.id || lessonId;
      const token = authHeader.replace('Bearer ', '');
      const { data: { user }, error: userError } = await supabase.auth.getUser(token);
      
      if (userError || !user) throw new Error('Unauthorized');

      const { data: lesson } = await supabase
        .from('lessons')
        .select('xp_reward')
        .eq('id', completeLessonId)
        .maybeSingle();

      const xpEarned = lesson?.xp_reward || 10;

      // Check if already completed
      const { data: existing } = await supabase
        .from('user_progress')
        .select('*')
        .eq('user_id', user.id)
        .eq('lesson_id', completeLessonId)
        .eq('status', 'completed')
        .maybeSingle();

      if (existing) {
        // Already completed, just return current stats
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
          lesson_id: completeLessonId,
          status: 'completed',
          xp_earned: xpEarned,
          last_practiced: new Date().toISOString(),
        });

      if (progressError) throw progressError;

      // Update user_stats
      const { data: stats, error: statsError } = await supabase
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

      return new Response(JSON.stringify({ 
        success: true, 
        xpEarned,
        stats: updatedStats 
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