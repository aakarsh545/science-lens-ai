import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

const courses = [
  { slug: 'basic-physics', title: 'Basic Physics', description: 'Fundamental concepts of motion, forces, and energy', category: 'Physics' },
  { slug: 'quantum-mechanics', title: 'Quantum Mechanics', description: 'Explore quantum physics and subatomic particles', category: 'Physics' },
  { slug: 'astronomy', title: 'Astronomy', description: 'Study celestial objects and the universe', category: 'Astronomy' },
  { slug: 'thermodynamics', title: 'Thermodynamics', description: 'Heat, energy transfer, and thermodynamic laws', category: 'Physics' },
  { slug: 'chemistry-basics', title: 'Chemistry Basics', description: 'Matter, reactions, and periodic table', category: 'Chemistry' },
  { slug: 'organic-chemistry', title: 'Organic Chemistry', description: 'Carbon-based compounds and reactions', category: 'Chemistry' },
  { slug: 'biochemistry', title: 'Biochemistry', description: 'Chemical processes in living organisms', category: 'Chemistry' },
  { slug: 'cell-biology', title: 'Cell Biology', description: 'Structure and function of cells', category: 'Biology' },
  { slug: 'genetics', title: 'Genetics', description: 'Heredity and variation in organisms', category: 'Biology' },
  { slug: 'ecology', title: 'Ecology', description: 'Interactions between organisms and environment', category: 'Biology' },
  { slug: 'robotics', title: 'Robotics', description: 'Design and operation of robots', category: 'Technology' },
  { slug: 'neurobiology', title: 'Neurobiology', description: 'Nervous system and brain function', category: 'Biology' },
  { slug: 'materials-science', title: 'Materials Science', description: 'Properties and applications of materials', category: 'Technology' },
  { slug: 'environmental-science', title: 'Environmental Science', description: 'Environmental systems and sustainability', category: 'Earth Science' },
  { slug: 'astrophysics', title: 'Astrophysics', description: 'Physics of celestial bodies', category: 'Astronomy' },
  { slug: 'planetary-science', title: 'Planetary Science', description: 'Study of planets and moons', category: 'Astronomy' },
];

async function seedCourses() {
  console.log('🌱 Seeding courses...\n');

  for (const course of courses) {
    const { data, error } = await supabase
      .from('courses')
      .insert(course)
      .select()
      .single();

    if (error) {
      if (error.code === '23505') {
        console.log(`✓ ${course.title} already exists`);
      } else {
        console.error(`❌ Error inserting ${course.title}:`, error.message);
      }
    } else {
      console.log(`✓ Inserted: ${course.title} [${data.id}]`);
    }
  }

  console.log('\n✅ Done seeding courses!');
}

seedCourses();
