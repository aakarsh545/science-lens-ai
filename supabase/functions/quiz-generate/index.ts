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

    if (req.method !== 'POST') {
      return new Response(JSON.stringify({ error: 'Method not allowed' }), {
        status: 405,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const { lessonId, questionCount = 10 } = await req.json();

    if (!lessonId) {
      return new Response(JSON.stringify({ error: 'lessonId is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Fetch lesson content and course info
    const { data: lesson, error: lessonError } = await supabase
      .from('lessons')
      .select('id, title, content, chapter, course_id')
      .eq('id', lessonId)
      .single();

    if (lessonError || !lesson) {
      return new Response(JSON.stringify({ error: 'Lesson not found' }), {
        status: 404,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Fetch course title for better context
    const { data: course } = await supabase
      .from('courses')
      .select('title, category')
      .eq('id', lesson.course_id)
      .single();

    const courseTitle = course?.title || lesson.title;
    const category = course?.category || 'Science';

    // Generate quiz questions using AI
    const openAIKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAIKey) {
      return new Response(JSON.stringify({
        error: 'Quiz generation service unavailable'
      }), {
        status: 503,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const prompt = `You are an expert educator creating a placement quiz for "${courseTitle}" in ${category}.

Generate exactly ${questionCount} multiple-choice questions to assess a student's knowledge level.

IMPORTANT REQUIREMENTS:
1. Create REAL, educational questions about actual topics in ${courseTitle}
2. Each question must test genuine knowledge (definitions, concepts, calculations, applications)
3. Every answer option must be a complete, realistic choice
4. Questions must progress from EASY → MEDIUM → HARD
5. Format: First 3 questions easy, next 4 medium, last 3 hard

REQUIRED JSON FORMAT (return ONLY this JSON array, no markdown):
[
  {
    "id": "1",
    "question": "What is the SI unit of force?",
    "options": ["Newton", "Joule", "Watt", "Pascal"],
    "correctAnswer": 0,
    "difficulty": "easy"
  },
  {
    "id": "2",
    "question": "Which of Newton's laws states that an object at rest stays at rest?",
    "options": [
      "First Law (Inertia)",
      "Second Law (F=ma)",
      "Third Law (Action-Reaction)",
      "Law of Gravitation"
    ],
    "correctAnswer": 0,
    "difficulty": "easy"
  }
]

EXAMPLE REAL QUESTIONS:
- Easy: "What measures force?" → [Newton, Joule, Watt, Pascal]
- Medium: "A 10kg object accelerates at 5m/s². What force is applied?" → [10N, 15N, 50N, 100N]
- Hard: "Calculate the work done by a 50N force moving an object 3 meters." → [15J, 53J, 150J, 153J]

${lesson.content ? `Lesson context: ${lesson.content.substring(0, 500)}` : ''}

Generate ${questionCount} REAL questions NOW. Return ONLY the JSON array.`;

    try {
      const response = await fetch('https://api.openai.com/v1/chat/completions', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${openAIKey}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          model: 'gpt-4o-mini',
          messages: [
            {
              role: 'system',
              content: 'You are an expert science educator. Always respond with valid JSON arrays of multiple-choice questions. Every question must be real and educational with specific answer choices. Never use generic placeholders.'
            },
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: 0.7,
          max_tokens: 4000,
        }),
      });

      if (!response.ok) {
        const errorText = await response.text();
        console.error('OpenAI API error:', response.status, errorText);
        throw new Error(`Quiz generation failed: ${response.statusText}`);
      }

      const data = await response.json();
      const content = data.choices[0]?.message?.content || '';

      console.log('AI Response length:', content.length);
      console.log('AI Response sample:', content.substring(0, 200));

      // Parse JSON response with multiple fallback strategies
      let questions;
      try {
        // Try direct parse first
        questions = JSON.parse(content);
      } catch (directParseError) {
        console.warn('Direct JSON parse failed, trying extraction strategies');

        // Strategy 1: Extract from markdown code blocks
        const codeBlockMatch = content.match(/```(?:json)?\s*(\[[\s\S]*\])\s*```/);
        if (codeBlockMatch) {
          console.log('Extracted JSON from markdown code block');
          questions = JSON.parse(codeBlockMatch[1]);
        } else {
          // Strategy 2: Find JSON array in response
          const jsonMatch = content.match(/\[[\s\S]*\]/);
          if (jsonMatch) {
            console.log('Extracted JSON array from response');
            questions = JSON.parse(jsonMatch[0]);
          } else {
            throw new Error('Could not extract valid JSON from AI response');
          }
        }
      }

      // Validate questions array
      if (!Array.isArray(questions) || questions.length === 0) {
        throw new Error('AI response did not return a valid questions array');
      }

      // Validate and format each question
      const formattedQuestions = questions
        .filter((q: any) => {
          // Filter out invalid questions
          return q.question &&
                 Array.isArray(q.options) &&
                 q.options.length === 4 &&
                 typeof q.correctAnswer === 'number';
        })
        .map((q: any, idx: number) => {
          // Validate that options are real text, not placeholders
          const options = q.options.map((opt: string) => String(opt).trim());
          const hasPlaceholders = options.some((opt: string) =>
            /^(Option|Choice|Answer)\s+[A-Z]$/i.test(opt) ||
            /^(A|B|C|D):\s*$/i.test(opt) ||
            opt.length < 3
          );

          if (hasPlaceholders) {
            console.warn(`Question ${idx + 1} has placeholder options, skipping`);
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
        .filter((q: any) => q !== null);

      if (formattedQuestions.length === 0) {
        throw new Error('No valid questions could be extracted from AI response');
      }

      console.log(`Successfully generated ${formattedQuestions.length} valid questions`);

      // Ensure we have the requested number of questions
      const finalQuestions = formattedQuestions.slice(0, questionCount);

      return new Response(JSON.stringify({ questions: finalQuestions }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });

    } catch (aiError) {
      console.error('AI generation error:', aiError);
      throw aiError;
    }

  } catch (error) {
    console.error('Quiz generation error:', error);
    return new Response(JSON.stringify({
      error: error.message || 'Failed to generate quiz'
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
