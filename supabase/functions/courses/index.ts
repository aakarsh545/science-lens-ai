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

    // Parse request body to check for slug parameter
    const { slug } = await req.json().catch(() => ({}));

    if (slug) {
      // Fetch single course by slug with lessons
      const { data: course, error } = await supabase
        .from('courses')
        .select('id, slug, title, description, category, difficulty')
        .eq('slug', slug)
        .single();

      if (error) throw error;

      if (!course) {
        return new Response(JSON.stringify({ error: 'Course not found' }), {
          status: 404,
          headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        });
      }

      // Fetch lessons for this course
      const { data: lessons } = await supabase
        .from('lessons')
        .select('id, slug, title, order_index, xp_reward, chapter')
        .eq('course_id', course.id)
        .order('order_index', { ascending: true });

      const courseWithLessons = {
        ...course,
        lessons: lessons || [],
        lesson_count: lessons?.length || 0,
      };

      return new Response(JSON.stringify(courseWithLessons), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    } else {
      // Fetch all courses with lesson counts
      const { data: courses, error } = await supabase
        .from('courses')
        .select('id, slug, title, description, category, difficulty');

      if (error) throw error;

      // Get lesson count for each course
      const coursesWithCounts = await Promise.all(
        (courses || []).map(async (course) => {
          const { count } = await supabase
            .from('lessons')
            .select('*', { count: 'exact', head: true })
            .eq('course_id', course.id);

          return {
            ...course,
            lesson_count: count || 0,
          };
        })
      );

      return new Response(JSON.stringify(coursesWithCounts), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

  } catch (error) {
    console.error('Error fetching courses:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
