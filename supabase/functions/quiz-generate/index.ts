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

    const { lessonId, lessonTitle, questionCount = 5 } = await req.json();

    if (!lessonId) {
      return new Response(JSON.stringify({ error: 'lessonId is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Fetch lesson content
    const { data: lesson, error: lessonError } = await supabase
      .from('lessons')
      .select('id, title, content, chapter')
      .eq('id', lessonId)
      .single();

    if (lessonError || !lesson) {
      return new Response(JSON.stringify({ error: 'Lesson not found' }), {
        status: 404,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Generate quiz questions using AI
    const openAIKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAIKey) {
      return new Response(JSON.stringify({
        error: 'AI service not available',
        questions: generateFallbackQuestions(lessonTitle || lesson.title, questionCount)
      }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    try {
      const prompt = `Generate ${questionCount} multiple choice questions to test knowledge level for a lesson about "${lesson.title || lessonTitle}".

Lesson context (first 500 chars):
${(lesson.content || '').substring(0, 500)}

Requirements:
- Create questions ranging from easy to hard difficulty
- Each question should have 4 options (A, B, C, D)
- Indicate the correct answer (0-3)
- Include difficulty level: easy, medium, or hard

Return ONLY a JSON array in this exact format:
[
  {
    "id": "1",
    "question": "Question text here?",
    "options": ["Option A", "Option B", "Option C", "Option D"],
    "correctAnswer": 0,
    "difficulty": "easy"
  }
]`;

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
              content: 'You are an educational content creator specializing in science. Generate multiple choice questions to assess knowledge level. Always return valid JSON arrays only.'
            },
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: 0.7,
          max_tokens: 2000,
        }),
      });

      if (!response.ok) {
        throw new Error(`OpenAI API error: ${response.statusText}`);
      }

      const data = await response.json();
      const content = data.choices[0]?.message?.content || '';

      // Parse JSON response
      let questions;
      try {
        // Extract JSON from response (in case there's extra text)
        const jsonMatch = content.match(/\[[\s\S]*\]/);
        if (jsonMatch) {
          questions = JSON.parse(jsonMatch[0]);
        } else {
          questions = JSON.parse(content);
        }
      } catch (parseError) {
        console.error('Failed to parse AI response:', content);
        questions = generateFallbackQuestions(lesson.title || lessonTitle, questionCount);
      }

      // Validate and format questions
      const formattedQuestions = questions.map((q: any, idx: number) => ({
        id: q.id || String(idx + 1),
        question: q.question || `Question ${idx + 1}`,
        options: Array.isArray(q.options) ? q.options : ['A', 'B', 'C', 'D'],
        correctAnswer: typeof q.correctAnswer === 'number' ? q.correctAnswer : 0,
        difficulty: ['easy', 'medium', 'hard'].includes(q.difficulty) ? q.difficulty : 'medium'
      }));

      return new Response(JSON.stringify({ questions: formattedQuestions }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });

    } catch (aiError) {
      console.error('AI generation error:', aiError);

      // Return fallback questions on AI error
      return new Response(JSON.stringify({
        questions: generateFallbackQuestions(lesson.title || lessonTitle, questionCount)
      }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

  } catch (error) {
    console.error('Quiz generation error:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});

function generateFallbackQuestions(topic: string, count: number) {
  const difficulties: Array<'easy' | 'medium' | 'hard'> = ['easy', 'medium', 'hard'];
  const questions = [];

  for (let i = 0; i < count; i++) {
    questions.push({
      id: String(i + 1),
      question: `What is a key concept in ${topic}?`,
      options: [
        `Concept A for ${topic}`,
        `Concept B for ${topic}`,
        `Concept C for ${topic}`,
        `Concept D for ${topic}`
      ],
      correctAnswer: 0,
      difficulty: difficulties[i % difficulties.length]
    });
  }

  return questions;
}
