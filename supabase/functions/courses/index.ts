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

    // Verify authentication
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Authentication required' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);

    if (userError || !user) {
      return new Response(JSON.stringify({ error: 'Invalid authentication token' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

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
    // Log detailed error server-side only
    console.error('[courses] Error:', {
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
    return new Response(JSON.stringify({
      error: 'An error occurred. Please try again.',
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});