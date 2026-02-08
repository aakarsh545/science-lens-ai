/**
 * Quiz Generation Script
 *
 * This script generates placement quizzes for all courses using the Gemini API.
 * Run with: npm run generate-quizzes
 *
 * Environment variables required:
 * - LOVABLE_API_KEY: Gemini API key from Lovable
 * - SUPABASE_URL: Supabase project URL
 * - SUPABASE_SERVICE_ROLE_KEY: Supabase service role key for admin access
 */

import { createClient } from '@supabase/supabase-js';
import fetch from 'node-fetch';

// Configuration
const QUIZ_QUESTIONS_PER_COURSE = 10;
const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent';

interface Course {
  id: string;
  title: string;
  slug: string;
  category: string;
  description: string;
}

interface QuizQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: number;
  difficulty: 'easy' | 'medium' | 'hard';
}

interface CourseQuiz {
  course_id: string;
  questions: QuizQuestion[];
  metadata: {
    generated_by: string;
    model: string;
    generated_at: string;
    total_questions: number;
  };
}

// Initialize Supabase client
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const geminiApiKey = process.env.LOVABLE_API_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase credentials. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY.');
  process.exit(1);
}

if (!geminiApiKey) {
  console.error('❌ Missing LOVABLE_API_KEY. Please set LOVABLE_API_KEY environment variable.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

/**
 * Generate a quiz for a single course using Gemini API
 */
async function generateQuizForCourse(course: Course): Promise<CourseQuiz | null> {
  console.log(`\n🎯 Generating quiz for: ${course.title} (${course.category})`);

  const prompt = `You are an expert science educator creating a placement quiz for "${course.title}" in ${course.category}.

Generate exactly ${QUIZ_QUESTIONS_PER_COURSE} multiple-choice questions to assess a student's knowledge level.

CRITICAL REQUIREMENTS:
1. Create REAL, educational questions about actual topics in ${course.title}
2. Each question must test genuine knowledge (definitions, concepts, calculations, applications)
3. Every answer option must be a complete, realistic choice (NOT "Option A", "Option B")
4. Questions must progress from EASY → MEDIUM → HARD
5. First 3 questions: EASY (basic definitions, concepts)
6. Next 4 questions: MEDIUM (applications, relationships, simple problems)
7. Last 3 questions: HARD (complex problems, analysis, synthesis)

JSON FORMAT (return ONLY this JSON array, no markdown, no explanation):
[
  {
    "id": "1",
    "question": "What is the SI unit of force?",
    "options": ["Newton", "Joule", "Watt", "Pascal"],
    "correctAnswer": 0,
    "difficulty": "easy"
  }
]

EXAMPLE REAL QUESTIONS for ${course.title}:
- Easy: "What is the primary unit of measurement in this topic?" → [real unit options]
- Medium: "Calculate/solve a basic problem" → [real calculation options]
- Hard: "Analyze/apply a concept to a complex scenario" → [real analysis options]

Course context: ${course.description}

Generate ${QUIZ_QUESTIONS_PER_COURSE} REAL questions NOW. Return ONLY the JSON array.`;

  try {
    const response = await fetch(`${GEMINI_API_URL}?key=${geminiApiKey}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        contents: [{
          parts: [{
            text: prompt
          }]
        }],
        generationConfig: {
          temperature: 0.7,
          maxOutputTokens: 4000,
        },
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error(`❌ Gemini API error for ${course.title}:`, response.status, errorText);
      return null;
    }

    const data = await response.json();
    const content = data.candidates?.[0]?.content?.parts?.[0]?.text || '';

    console.log(`📝 Generated ${content.length} characters for ${course.title}`);

    // Parse JSON response
    let questions: QuizQuestion[];
    try {
      // Try direct parse
      questions = JSON.parse(content);
    } catch (directError) {
      // Try to extract JSON from markdown code blocks
      const codeBlockMatch = content.match(/```(?:json)?\s*(\[[\s\S]*\])\s*```/);
      if (codeBlockMatch) {
        questions = JSON.parse(codeBlockMatch[1]);
      } else {
        // Try to find JSON array
        const jsonMatch = content.match(/\[[\s\S]*\]/);
        if (jsonMatch) {
          questions = JSON.parse(jsonMatch[0]);
        } else {
          throw new Error('Could not extract valid JSON from AI response');
        }
      }
    }

    // Validate and format questions
    const formattedQuestions = questions
      .filter((q: any) => {
        return q.question &&
               Array.isArray(q.options) &&
               q.options.length === 4 &&
               typeof q.correctAnswer === 'number';
      })
      .map((q: any, idx: number) => {
        // Check for placeholder options
        const options = q.options.map((opt: string) => String(opt).trim());
        const hasPlaceholders = options.some((opt: string) =>
          /^(Option|Choice|Answer)\s+[A-Z]$/i.test(opt) ||
          /^(A|B|C|D):\s*$/i.test(opt) ||
          opt.length < 3
        );

        if (hasPlaceholders) {
          console.warn(`⚠️  Question ${idx + 1} has placeholder options, skipping`);
          return null;
        }

        return {
          id: q.id || String(idx + 1),
          question: String(q.question).trim(),
          options: options,
          correctAnswer: Number(q.correctAnswer),
          difficulty: ['easy', 'medium', 'hard'].includes(q.difficulty) ? q.difficulty : 'medium'
        };
      })
      .filter((q: QuizQuestion | null): q is QuizQuestion => q !== null);

    if (formattedQuestions.length === 0) {
      throw new Error('No valid questions could be extracted');
    }

    console.log(`✅ Successfully generated ${formattedQuestions.length} valid questions for ${course.title}`);

    return {
      course_id: course.id,
      questions: formattedQuestions.slice(0, QUIZ_QUESTIONS_PER_COURSE),
      metadata: {
        generated_by: 'gemini-2.0-flash-exp',
        model: 'gemini-2.0-flash-exp',
        generated_at: new Date().toISOString(),
        total_questions: formattedQuestions.length
      }
    };

  } catch (error) {
    console.error(`❌ Error generating quiz for ${course.title}:`, error);
    return null;
  }
}

/**
 * Save or update quiz in database
 */
async function saveQuiz(quiz: CourseQuiz): Promise<boolean> {
  try {
    // Check if quiz already exists
    const { data: existing } = await supabase
      .from('course_quizzes')
      .select('id')
      .eq('course_id', quiz.course_id)
      .single();

    if (existing) {
      // Update existing quiz
      const { error } = await supabase
        .from('course_quizzes')
        .update({
          questions: quiz.questions,
          metadata: quiz.metadata,
          updated_at: new Date().toISOString()
        })
        .eq('course_id', quiz.course_id);

      if (error) throw error;
      console.log(`  🔄 Updated existing quiz in database`);
    } else {
      // Insert new quiz
      const { error } = await supabase
        .from('course_quizzes')
        .insert(quiz);

      if (error) throw error;
      console.log(`  ➕ Inserted new quiz into database`);
    }

    return true;
  } catch (error) {
    console.error(`  ❌ Error saving quiz to database:`, error);
    return false;
  }
}

/**
 * Main function to generate quizzes for all courses
 */
async function generateAllQuizzes() {
  console.log('🚀 Starting quiz generation for all courses...\n');

  // Fetch all courses
  const { data: courses, error } = await supabase
    .from('courses')
    .select('id, title, slug, category, description')
    .order('title');

  if (error) {
    console.error('❌ Error fetching courses:', error);
    process.exit(1);
  }

  if (!courses || courses.length === 0) {
    console.log('⚠️  No courses found in database');
    process.exit(0);
  }

  console.log(`📚 Found ${courses.length} courses to process\n`);

  // Generate quizzes for each course
  const results = {
    total: courses.length,
    success: 0,
    failed: 0
  };

  for (const course of courses) {
    const quiz = await generateQuizForCourse(course);

    if (quiz) {
      const saved = await saveQuiz(quiz);
      if (saved) {
        results.success++;
      } else {
        results.failed++;
      }
    } else {
      results.failed++;
    }

    // Small delay to avoid rate limiting
    await new Promise(resolve => setTimeout(resolve, 500));
  }

  // Summary
  console.log('\n' + '='.repeat(60));
  console.log('📊 QUIZ GENERATION SUMMARY');
  console.log('='.repeat(60));
  console.log(`Total courses: ${results.total}`);
  console.log(`✅ Successfully generated: ${results.success}`);
  console.log(`❌ Failed: ${results.failed}`);
  console.log('='.repeat(60));

  if (results.failed > 0) {
    console.log('\n⚠️  Some quizzes failed to generate. Check the logs above for details.');
    process.exit(1);
  } else {
    console.log('\n🎉 All quizzes generated successfully!');
    process.exit(0);
  }
}

// Run the script
generateAllQuizzes().catch((error) => {
  console.error('💥 Fatal error:', error);
  process.exit(1);
});
