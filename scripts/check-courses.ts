import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkCourses() {
  const { data, error } = await supabase
    .from('courses')
    .select('id, title, slug, category');

  if (error) {
    console.error('Error:', error);
    process.exit(1);
  }

  if (!data || data.length === 0) {
    console.log('No courses found in database');
    console.log('You may need to run migrations that seed the courses table');
    process.exit(0);
  }

  console.log(`Found ${data.length} courses:`);
  data.forEach(course => {
    console.log(`- ${course.title} (${course.category}) [${course.slug}]`);
  });
}

checkCourses();
