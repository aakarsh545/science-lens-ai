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

    const url = new URL(req.url);
    const path = url.pathname.split('/').filter(Boolean);

    // GET/POST /courses - list all courses
    if ((req.method === 'GET' || req.method === 'POST') && path.length === 0) {
      const { data: courses, error } = await supabase
        .from('courses')
        .select(`
          *,
          lessons:lessons(count)
        `)
        .order('created_at', { ascending: true });

      if (error) throw error;

      return new Response(JSON.stringify(courses), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // GET /courses/:slug - get course details with lessons
    if (req.method === 'GET' && path.length === 1) {
      const slug = path[0];
      
      const { data: course, error: courseError } = await supabase
        .from('courses')
        .select('*')
        .eq('slug', slug)
        .single();

      if (courseError) throw courseError;

      const { data: lessons, error: lessonsError } = await supabase
        .from('lessons')
        .select('id, slug, title, order_index, xp_reward')
        .eq('course_id', course.id)
        .order('order_index', { ascending: true });

      if (lessonsError) throw lessonsError;

      return new Response(JSON.stringify({ ...course, lessons }), {
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