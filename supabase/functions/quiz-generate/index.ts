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

    const { lessonId, lessonTitle, questionCount = 10 } = await req.json();

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

    const courseTitle = course?.title || lessonTitle || lesson.title;
    const category = course?.category || 'Science';

    // Generate quiz questions using AI
    const openAIKey = Deno.env.get('OPENAI_API_KEY');
    if (!openAIKey) {
      console.warn('OPENAI_API_KEY not set, using fallback questions');
      return new Response(JSON.stringify({
        questions: generateFallbackQuestions(courseTitle, questionCount, category)
      }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    try {
      const prompt = `You are an expert science educator creating a placement quiz for "${courseTitle}" (${category}).

Generate ${questionCount} multiple-choice questions to assess a student's knowledge level in this topic.

CRITICAL REQUIREMENTS:
1. Questions must start EASY and get progressively HARDER
2. Write REAL, educational questions about actual topics in ${courseTitle}
3. Each option must be a complete, realistic answer choice (NOT "Option A", "Option B")
4. Cover fundamental concepts, theories, formulas, scientists, applications
5. Mix of: definition, calculation, conceptual, application, and comparison questions

Difficulty distribution:
- First 3 questions: EASY (basic definitions, concepts)
- Next 4 questions: MEDIUM (applications, relationships, simple problems)
- Last 3 questions: HARD (complex problems, analysis, synthesis)

Return ONLY a valid JSON array (no markdown, no explanation text):
[
  {
    "id": "1",
    "question": "What is the primary unit of force in the SI system?",
    "options": [
      "Newton (N)",
      "Joule (J)",
      "Watt (W)",
      "Pascal (Pa)"
    ],
    "correctAnswer": 0,
    "difficulty": "easy"
  },
  {
    "id": "2",
    "question": "Which of the following best describes Newton's First Law of Motion?",
    "options": [
      "Force equals mass times acceleration",
      "An object at rest stays at rest unless acted upon",
      "For every action there is an equal and opposite reaction",
      "Energy cannot be created or destroyed"
    ],
    "correctAnswer": 1,
    "difficulty": "easy"
  }
]

Course context for reference:
${(lesson.content || '').substring(0, 800)}

Remember: REAL questions only, no placeholders. Every option must be a complete, meaningful answer.`;

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
              content: 'You are an expert science educator creating placement quizzes. Always respond with valid JSON arrays only. Never include placeholders like "Option A" or "Concept B". All answers must be complete, realistic choices.'
            },
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature: 0.8,
          max_tokens: 3500,
        }),
      });

      if (!response.ok) {
        const errorText = await response.text();
        console.error('OpenAI API error:', response.status, errorText);
        throw new Error(`OpenAI API error: ${response.statusText}`);
      }

      const data = await response.json();
      const content = data.choices[0]?.message?.content || '';

      console.log('AI Response length:', content.length);

      // Parse JSON response
      let questions;
      try {
        // Try to parse directly first
        questions = JSON.parse(content);
      } catch (directParseError) {
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
            throw new Error('Could not extract JSON from AI response');
          }
        }
      }

      if (!Array.isArray(questions)) {
        throw new Error('AI response did not return an array');
      }

      // Validate and format questions
      const formattedQuestions = questions
        .filter((q: any) => q.question && Array.isArray(q.options) && q.options.length === 4)
        .map((q: any, idx: number) => {
          // Ensure correctAnswer is a number
          let correctAnswer = 0;
          if (typeof q.correctAnswer === 'number') {
            correctAnswer = q.correctAnswer;
          } else if (typeof q.correctAnswer === 'string') {
            const letterToNum: Record<string, number> = { 'A': 0, 'B': 1, 'C': 2, 'D': 3 };
            correctAnswer = letterToNum[q.correctAnswer.toUpperCase()] || 0;
          }

          return {
            id: q.id || String(idx + 1),
            question: q.question,
            options: q.options,
            correctAnswer,
            difficulty: ['easy', 'medium', 'hard'].includes(q.difficulty) ? q.difficulty : 'medium'
          };
        });

      if (formattedQuestions.length === 0) {
        throw new Error('No valid questions generated');
      }

      console.log('Successfully generated', formattedQuestions.length, 'questions');

      return new Response(JSON.stringify({ questions: formattedQuestions }), {
        status: 200,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });

    } catch (aiError) {
      console.error('AI generation error:', aiError);

      // Return fallback questions on AI error
      return new Response(JSON.stringify({
        questions: generateFallbackQuestions(courseTitle, questionCount, category)
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

function generateFallbackQuestions(topic: string, count: number, category: string = 'Science') {
  const difficulties: Array<'easy' | 'medium' | 'hard'> = ['easy', 'easy', 'easy', 'medium', 'medium', 'medium', 'hard', 'hard', 'hard', 'hard'];
  const questions = [];

  const topicQuestions: Record<string, any[]> = {
    'physics': [
      { q: "What is the SI unit of force?", a: "Newton (N)", b: "Joule (J)", c: "Watt (W)", d: "Pascal (Pa)", correct: 0 },
      { q: "What is the acceleration due to gravity on Earth?", a: "9.8 m/s²", b: "10 m/s²", c: "8.5 m/s²", d: "11.2 m/s²", correct: 0 },
      { q: "Which law describes action-reaction pairs?", a: "Newton's First Law", b: "Newton's Second Law", c: "Newton's Third Law", d: "Newton's Fourth Law", correct: 2 },
      { q: "What is the formula for kinetic energy?", a: "KE = mv", b: "KE = ½mv²", c: "KE = mgh", d: "KE = ma", correct: 1 },
      { q: "What type of wave is sound?", a: "Transverse", b: "Longitudinal", c: "Electromagnetic", d: "Standing", correct: 1 },
      { q: "What is the speed of light in vacuum?", a: "3×10⁶ m/s", b: "3×10⁸ m/s", c: "3×10¹⁰ m/s", d: "3×10⁴ m/s", correct: 1 },
      { q: "Which quantity is measured in Joules?", a: "Force", b: "Power", c: "Energy", d: "Pressure", correct: 2 },
      { q: "What is the unit of electrical resistance?", a: "Volt", b: "Ampere", c: "Ohm", d: "Watt", correct: 2 },
    ],
    'chemistry': [
      { q: "What is the atomic number of an element?", a: "Number of protons", b: "Number of neutrons", c: "Number of electrons", d: "Total mass", correct: 0 },
      { q: "What is the pH of a neutral solution?", a: "0", b: "7", c: "14", d: "1", correct: 1 },
      { q: "What type of bond involves sharing electrons?", a: "Ionic", b: "Covalent", c: "Metallic", d: "Hydrogen", correct: 1 },
      { q: "What is Avogadro's number?", a: "6.022×10²³", b: "3.14159", c: "9.8 m/s²", d: "299,792,458 m/s", correct: 0 },
    ],
    'biology': [
      { q: "What is the basic unit of life?", a: "Atom", b: "Cell", c: "Tissue", d: "Organ", correct: 1 },
      { q: "What organelle contains DNA?", a: "Ribosome", b: "Mitochondria", c: "Nucleus", d: "Golgi apparatus", correct: 2 },
      { q: "What process do plants use to make food?", a: "Respiration", b: "Photosynthesis", c: "Digestion", d: "Fermentation", correct: 1 },
      { q: "What is the powerhouse of the cell?", a: "Nucleus", b: "Ribosome", c: "Mitochondria", d: "Endoplasmic reticulum", correct: 2 },
    ],
    'default': [
      { q: `What is a fundamental concept in ${topic}?`, a: "A basic principle", b: "A derived formula", c: "An advanced theory", d: "A misconception", correct: 0 },
      { q: `Which statement about ${topic} is true?`, a: "Statement 1", b: "Statement 2", c: "Statement 3", d: "Statement 4", correct: 0 },
    ]
  };

  // Try to match category
  const categoryLower = category.toLowerCase();
  const topicLower = topic.toLowerCase();
  let questionBank = topicQuestions['default'];

  if (categoryLower.includes('physic') || topicLower.includes('physic')) {
    questionBank = topicQuestions['physics'];
  } else if (categoryLower.includes('chem') || topicLower.includes('chem')) {
    questionBank = topicQuestions['chemistry'];
  } else if (categoryLower.includes('biolog') || topicLower.includes('bio')) {
    questionBank = topicQuestions['biology'];
  }

  for (let i = 0; i < Math.min(count, questionBank.length); i++) {
    const qb = questionBank[i % questionBank.length];
    questions.push({
      id: String(i + 1),
      question: qb.q,
      options: [qb.a, qb.b, qb.c, qb.d],
      correctAnswer: qb.correct,
      difficulty: difficulties[i % difficulties.length]
    });
  }

  // If we need more questions than available, add variations
  while (questions.length < count) {
    const baseQ = questionBank[questions.length % questionBank.length];
    questions.push({
      id: String(questions.length + 1),
      question: `${baseQ.q} (Advanced)`,
      options: [baseQ.a, baseQ.b, baseQ.c, baseQ.d],
      correctAnswer: baseQ.correct,
      difficulty: 'hard'
    });
  }

  return questions;
}
