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

    // Parse body for slug if POST request
    let bodySlug: string | null = null;
    if (req.method === 'POST') {
      try {
        const body = await req.json();
        bodySlug = body?.slug || null;
      } catch {
        // No body or invalid JSON
      }
    }

    // If slug provided in body, get single course
    if (bodySlug) {
      const { data: course, error: courseError } = await supabase
        .from('courses')
        .select('*')
        .eq('slug', bodySlug)
        .single();

      if (courseError) throw courseError;

      const { data: lessons, error: lessonsError } = await supabase
        .from('lessons')
        .select('id, slug, title, order_index, xp_reward, chapter')
        .eq('course_id', course.id)
        .order('order_index', { ascending: true });

      if (lessonsError) throw lessonsError;

      return new Response(JSON.stringify({ ...course, lessons }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // GET/POST /courses - list all courses
    const { data: courses, error } = await supabase
      .from('courses')
      .select(`
        *,
        lessons:lessons(count)
      `)
      .order('created_at', { ascending: true });

    if (error) throw error;

    // Transform lessons count to flat lesson_count
    const coursesWithCount = courses?.map(course => ({
      ...course,
      lesson_count: course.lessons?.[0]?.count || 0,
      lessons: undefined // Remove nested lessons array
    })) || [];

    return new Response(JSON.stringify(coursesWithCount), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    console.error('[courses] Error:', error, { 
      url: req.url, 
      method: req.method 
    });
    return new Response(JSON.stringify({ 
      error: errorMessage,
      code: 'COURSES_ERROR'
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});