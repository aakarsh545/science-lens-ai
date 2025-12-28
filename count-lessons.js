// Quick script to count lessons in Supabase
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL || 'https://your-project.supabase.co';
const supabaseKey = process.env.SUPABASE_ANON_KEY || 'your-anon-key';

const supabase = createClient(supabaseUrl, supabaseKey);

async function countLessons() {
  try {
    // Count total lessons
    const { count, error } = await supabase
      .from('lessons')
      .select('*', { count: 'exact', head: true });

    if (error) {
      console.error('Error:', error);
      return;
    }

    console.log(`Total lessons in database: ${count}`);

    // Count lessons per course
    const { data: courses, error: coursesError } = await supabase
      .from('courses')
      .select('id, title, slug, lessons(count)');

    if (coursesError) {
      console.error('Error fetching courses:', coursesError);
      return;
    }

    console.log('\nLessons per course:');
    courses.forEach(course => {
      const lessonCount = course.lessons?.[0]?.count || 0;
      console.log(`  - ${course.title} (${course.slug}): ${lessonCount} lessons`);
    });

  } catch (err) {
    console.error('Error:', err);
  }
}

countLessons();
