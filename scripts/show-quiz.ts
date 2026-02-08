import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey);

async function showQuiz() {
  // Get Basic Physics quiz
  const { data: course } = await supabase
    .from('courses')
    .select('id')
    .eq('slug', 'basic-physics')
    .single();

  if (!course) {
    console.log('Course not found');
    return;
  }

  const { data: quiz } = await supabase
    .from('course_quizzes')
    .select('questions')
    .eq('course_id', course.id)
    .single();

  if (!quiz) {
    console.log('Quiz not found');
    return;
  }

  console.log('📚 Basic Physics Quiz Sample:\n');
  quiz.questions.slice(0, 3).forEach((q: any, i: number) => {
    console.log(`Question ${i + 1}: ${q.question}`);
    console.log(`Difficulty: ${q.difficulty}`);
    console.log('Options:');
    q.options.forEach((opt: string, idx: number) => {
      const marker = idx === q.correctAnswer ? '✓' : ' ';
      console.log(`  ${marker} ${String.fromCharCode(65 + idx)}. ${opt}`);
    });
    console.log('');
  });
}

showQuiz();
