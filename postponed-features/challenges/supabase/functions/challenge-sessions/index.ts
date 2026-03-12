import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getCorsHeaders,
  handleOptions,
  validateOrigin,
  checkRateLimit,
  rateLimitResponse,
  logAuthFailure,
  logRateLimitViolation,
  logSuspiciousActivity,
  handleDatabaseError,
  handleAuthError,
  extractUserId,
} from "../_shared/security.ts";


const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

interface QuizQuestion {
  question: string;
  options: string[];
  correct: number;
  explanation: string;
}

// Rate limit configuration
const RATE_LIMITS = {
  START_CHALLENGE: { max: 10, window: 3600 }, // 10 per hour
  SUBMIT_ANSWER: { max: 100, window: 60 }, // 100 per minute
};

// Abuse detection configuration
const ABUSE_THRESHOLDS = {
  MAX_DAILY_CHALLENGES: 10,
  COOLDOWN_SECONDS: 3600, // 1 hour
  MAX_PERFECT_SCORES_DAILY: 5,
  MAX_ACCURACY_FOR_ADVANCED: 95,
  MIN_TIME_FOR_ADVANCED_SEC: 300, // 5 minutes
};

// Using shared checkRateLimit from _shared/security.ts

// Helper function to check challenge limits and detect farming
async function checkChallengeLimits(
  supabase: any,
  userId: string
): Promise<{
  allowed: boolean;
  reason?: string;
  retryAfter?: number;
  flaggedForFraud: boolean;
  penaltyMultiplier: number;
}> {
  const { data, error } = await supabase.rpc('check_challenge_limits', {
    p_user_id: userId,
  });

  if (error) {
    console.error('Challenge limit check error:', error);
    // Allow request if check fails (fail open)
    return { allowed: true, flaggedForFraud: false, penaltyMultiplier: 1 };
  }

  if (!data.allowed) {
    return {
      allowed: false,
      reason: data.reason,
      retryAfter: data.retry_after,
      flaggedForFraud: data.flagged_for_fraud || false,
      penaltyMultiplier: data.penalty_multiplier || 1,
    };
  }

  return {
    allowed: true,
    flaggedForFraud: data.flagged_for_fraud || false,
    penaltyMultiplier: data.penalty_multiplier || 1,
  };
}

serve(async (req) => {
  // Handle CORS preflight
  const optionsResponse = handleOptions(req);
  if (optionsResponse) return optionsResponse;

  // Validate origin
  const originValidation = validateOrigin(req);
  if (originValidation) return originValidation;

  // Get CORS headers for this origin
  const origin = req.headers.get("Origin");
  const corsHeaders = getCorsHeaders(origin);

  try {
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      throw new Error('No authorization header');
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);

    if (userError || !user) {
      await logAuthFailure(supabase, undefined, "challenge-sessions", "Invalid token");
      return handleAuthError(corsHeaders, "Authentication required");
    }

    const url = new URL(req.url);
    const path = url.pathname.split('/').filter(Boolean);

    // POST /challenge-sessions/start - Start a new challenge session
    if (req.method === 'POST' && path[0] === 'start') {
      // Check rate limit
      const rateLimitCheck = await checkRateLimit(
        supabase,
        user.id,
        'challenge-sessions/start',
        RATE_LIMITS.START_CHALLENGE.max,
        RATE_LIMITS.START_CHALLENGE.window
      );

      if (!rateLimitCheck.allowed) {
        const retryAfter = Math.ceil((rateLimitCheck.resetAt.getTime() - Date.now()) / 1000);
        return new Response(JSON.stringify({
          error: rateLimitCheck.error || 'Rate limit exceeded',
          retryAfter,
        }), {
          status: 429,
          headers: {
            ...corsHeaders,
            'Content-Type': 'application/json',
            'Retry-After': retryAfter.toString(),
          },
        });
      }

      // Check challenge limits and fraud detection
      const challengeLimitCheck = await checkChallengeLimits(supabase, user.id);

      if (!challengeLimitCheck.allowed) {
        return new Response(JSON.stringify({
          error: challengeLimitCheck.reason || 'Challenge limit exceeded',
          retryAfter: challengeLimitCheck.retryAfter,
          flaggedForFraud: challengeLimitCheck.flaggedForFraud,
        }), {
          status: 429,
          headers: {
            ...corsHeaders,
            'Content-Type': 'application/json',
            'Retry-After': challengeLimitCheck.retryAfter?.toString() || '3600',
          },
        });
      }

      const { topicId, topicName, difficulty = 'beginner' } = await req.json();

      // Determine question count and XP reward based on difficulty
      let questionCount = 15;
      let xpReward = 100;

      if (difficulty === 'intermediate') {
        questionCount = 30;
        xpReward = 200;
      } else if (difficulty === 'advanced') {
        questionCount = 45;
        xpReward = 500;
      }

      // Fetch questions from lessons related to the topic
      let questions: QuizQuestion[] = [];

      if (topicId) {
        // Get lessons for this topic/course
        const { data: lessons, error: lessonsError } = await supabase
          .from('lessons')
          .select('quiz, title, slug')
          .eq('course_id', topicId)
          .not('quiz', 'is', null)
          .limit(50);

        if (!lessonsError && lessons) {
          // Extract questions from lesson quizzes
          lessons.forEach((lesson: any) => {
            if (lesson.quiz && lesson.quiz.questions) {
              questions.push(...lesson.quiz.questions);
            }
          });
        }
      }

      // If we don't have enough questions from the database, generate AI questions
      if (questions.length < questionCount) {
        const aiQuestions = await generateAIQuestions(topicName || 'General Science', questionCount - questions.length, difficulty);
        questions = [...questions, ...aiQuestions];
      }

      // Shuffle and take the required number of questions
      const shuffledQuestions = shuffleArray(questions).slice(0, questionCount);

      // Create challenge session
      const { data: session, error: sessionError } = await supabase
        .from('challenge_sessions')
        .insert({
          user_id: user.id,
          topic_id: topicId,
          topic_name: topicName,
          difficulty: difficulty,
          challenge_difficulty: difficulty,
          status: 'active',
          current_question: 1,
          total_questions: questionCount,
          hearts_remaining: 3,
          correct_answers: 0,
          questions: shuffledQuestions,
          answers: [],
          xp_reward: xpReward,
          started_at: new Date().toISOString(),
        })
        .select()
        .single();

      if (sessionError) throw sessionError;

      return new Response(JSON.stringify({
        success: true,
        session: {
          id: session.id,
          currentQuestion: session.current_question,
          totalQuestions: session.total_questions,
          heartsRemaining: session.hearts_remaining,
          question: shuffledQuestions[0],
          xpReward: session.xp_reward,
          difficulty: session.challenge_difficulty,
        },
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // POST /challenge-sessions/:sessionId/answer - Submit an answer
    if (req.method === 'POST' && path[1] === 'answer') {
      // Check rate limit for answer submissions
      const rateLimitCheck = await checkRateLimit(
        supabase,
        user.id,
        'challenge-sessions/answer',
        RATE_LIMITS.SUBMIT_ANSWER.max,
        RATE_LIMITS.SUBMIT_ANSWER.window
      );

      if (!rateLimitCheck.allowed) {
        const retryAfter = Math.ceil((rateLimitCheck.resetAt.getTime() - Date.now()) / 1000);
        return new Response(JSON.stringify({
          error: rateLimitCheck.error || 'Rate limit exceeded',
          retryAfter,
        }), {
          status: 429,
          headers: {
            ...corsHeaders,
            'Content-Type': 'application/json',
            'Retry-After': retryAfter.toString(),
          },
        });
      }

      const sessionId = path[0];
      const { answerIndex } = await req.json();

      // Get current session
      const { data: session, error: sessionError } = await supabase
        .from('challenge_sessions')
        .select('*')
        .eq('id', sessionId)
        .eq('user_id', user.id)
        .single();

      if (sessionError || !session) {
        throw new Error('Session not found');
      }

      if (session.status !== 'active') {
        throw new Error('Session is not active');
      }

      const questions = session.questions as QuizQuestion[];
      const currentQuestion = questions[session.current_question - 1];
      const isCorrect = answerIndex === currentQuestion.correct;

      // Calculate new hearts and correct answers
      const newHearts = isCorrect ? session.hearts_remaining : Math.max(0, session.hearts_remaining - 1);
      const newCorrectAnswers = isCorrect ? session.correct_answers + 1 : session.correct_answers;
      const answers = session.answers as any[];
      answers.push({
        questionIndex: session.current_question - 1,
        answerIndex,
        isCorrect,
        timestamp: new Date().toISOString(),
      });

      // Determine session status
      let newStatus = session.status;
      let newCurrentQuestion = session.current_question;
      let completedAt = null;

      if (newHearts === 0) {
        // Out of hearts - challenge failed
        newStatus = 'failed';
        completedAt = new Date().toISOString();
      } else if (session.current_question >= session.total_questions) {
        // All questions answered - challenge completed
        newStatus = 'completed';
        completedAt = new Date().toISOString();
      } else {
        // Continue to next question
        newCurrentQuestion = session.current_question + 1;
      }

      // Calculate XP based on difficulty and completion
      let xpEarned = 0;
      const baseXpReward = session.xp_reward || 100;

      if (newStatus === 'completed') {
        // Completed all questions: full XP reward
        xpEarned = baseXpReward;
      } else if (newStatus === 'failed') {
        // Partial completion: proportional XP
        xpEarned = Math.round((newCorrectAnswers / session.total_questions) * baseXpReward);
      }

      const completionPercentage = Math.round((newCorrectAnswers / session.total_questions) * 100);

      // Update session
      const { data: updatedSession, error: updateError } = await supabase
        .from('challenge_sessions')
        .update({
          current_question: newCurrentQuestion,
          hearts_remaining: newHearts,
          correct_answers: newCorrectAnswers,
          answers,
          status: newStatus,
          xp_earned: xpEarned,
          completion_percentage: completionPercentage,
          completed_at: completedAt,
        })
        .eq('id', sessionId)
        .select()
        .single();

      if (updateError) throw updateError;

      // Award XP if session is complete
      if (newStatus !== 'active' && xpEarned > 0) {
        // IDEMPOTENCY CHECK: Verify rewards haven't been awarded yet
        const { data: existingSession } = await supabase
          .from('challenge_sessions')
          .select('rewards_awarded')
          .eq('id', sessionId)
          .single();

        if (existingSession?.rewards_awarded) {
          // Rewards already awarded - skip but return success
          console.log(`Rewards already awarded for session ${sessionId} - idempotency check`);
        } else {
          // Check for fraud and get penalty multiplier
          const fraudCheck = await checkChallengeLimits(supabase, user.id);
          let finalXpEarned = xpEarned;
          let penaltyApplied = false;

          // Apply penalty multiplier if flagged for fraud
          if (fraudCheck.flaggedForFraud && fraudCheck.penaltyMultiplier < 1.0) {
            finalXpEarned = Math.round(xpEarned * fraudCheck.penaltyMultiplier);
            penaltyApplied = true;
            console.log(`Fraud detected for user ${user.id}: applying ${fraudCheck.penaltyMultiplier}x penalty to XP`);
          }

          // Server-side validation: Detect suspicious patterns
          const timeTaken = new Date().getTime() - new Date(session.started_at).getTime();
          const timeTakenSeconds = Math.floor(timeTaken / 1000);

          // Flag advanced challenges completed too quickly with perfect scores
          if (session.challenge_difficulty === 'advanced' &&
              completionPercentage === 100 &&
              timeTakenSeconds < ABUSE_THRESHOLDS.MIN_TIME_FOR_ADVANCED_SEC) {
            console.warn(`Suspicious activity: User ${user.id} completed advanced challenge in ${timeTakenSeconds}s with 100% accuracy`);

            // Log suspicious activity
            await supabase
              .from('abuse_detection')
              .insert({
                user_id: user.id,
                detection_type: 'suspicious_pattern',
                severity: 'high',
                description: `Advanced challenge completed too quickly with perfect score (${timeTakenSeconds}s)`,
                metadata: {
                  session_id: sessionId,
                  time_taken_seconds: timeTakenSeconds,
                  accuracy: completionPercentage,
                  difficulty: session.challenge_difficulty
                },
                status: 'flagged'
              });
            console.log('Suspicious activity logged');
          }

          // Award XP (with penalty if applicable)
          const { data: stats } = await supabase
            .from('user_stats')
            .select('xp_total')
            .eq('user_id', user.id)
            .single();

          const newXpTotal = (stats?.xp_total || 0) + finalXpEarned;

          await supabase
            .from('user_stats')
            .upsert({
              user_id: user.id,
              xp_total: newXpTotal,
              updated_at: new Date().toISOString(),
            });

          // Award coins for challenge completion
          const { data: profile } = await supabase
            .from('profiles')
            .select('is_premium')
            .eq('user_id', user.id)
            .single();

          const isPremium = profile?.is_premium || false;

          // Calculate coin reward based on difficulty and completion
          // Beginner: 25 coins (50 for premium)
          // Intermediate: 50 coins (100 for premium)
          // Advanced: 100 coins (200 for premium)
          let baseCoinReward = 25;
          if (session.challenge_difficulty === 'intermediate') {
            baseCoinReward = 50;
          } else if (session.challenge_difficulty === 'advanced') {
            baseCoinReward = 100;
          }

          let coinReward = isPremium ? baseCoinReward * 2 : baseCoinReward;

          // Apply penalty to coins if flagged for fraud
          if (fraudCheck.flaggedForFraud && fraudCheck.penaltyMultiplier < 1.0) {
            coinReward = Math.round(coinReward * fraudCheck.penaltyMultiplier);
          }

          // Only award coins if challenge was completed (not failed)
          if (newStatus === 'completed') {
            await supabase.rpc('award_coins', {
              user_id: user.id,
              amount: coinReward,
              source: 'challenge',
              metadata: {
                session_id: sessionId,
                difficulty: session.challenge_difficulty,
                topic_name: session.topic_name,
                penalty_applied: penaltyApplied ? fraudCheck.penaltyMultiplier : 1,
              }
            });
          }

          // Log completion for farming metrics (async, don't await)
          supabase.rpc('log_challenge_completion', {
            p_user_id: user.id,
            p_session_id: sessionId,
            p_correct_answers: newCorrectAnswers,
            p_total_questions: session.total_questions,
            p_time_taken_seconds: timeTakenSeconds,
            p_difficulty: session.challenge_difficulty
          });
          console.log('Challenge completion logged');

          // Mark rewards as awarded (idempotency protection)
          await supabase
            .from('challenge_sessions')
            .update({ rewards_awarded: true })
            .eq('id', sessionId);

          // Include penalty info in response if applicable
          if (penaltyApplied) {
            xpEarned = finalXpEarned;
          }
        }
      }

      // Prepare response
      const response: any = {
        success: true,
        isCorrect,
        explanation: currentQuestion.explanation,
        heartsRemaining: newHearts,
        correctAnswers: newCorrectAnswers,
        status: newStatus,
      };

      if (newStatus !== 'active') {
        response.sessionEnded = true;
        response.xpEarned = xpEarned;
        response.completionPercentage = completionPercentage;
      } else {
        response.nextQuestion = questions[newCurrentQuestion - 1];
        response.currentQuestion = newCurrentQuestion;
      }

      return new Response(JSON.stringify(response), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // GET /challenge-sessions/:sessionId - Get session details
    if (req.method === 'GET' && path.length === 1) {
      const sessionId = path[0];

      const { data: session, error } = await supabase
        .from('challenge_sessions')
        .select('*')
        .eq('id', sessionId)
        .eq('user_id', user.id)
        .single();

      if (error || !session) {
        throw new Error('Session not found');
      }

      return new Response(JSON.stringify({ success: true, session }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify({ error: 'Not found' }), {
      status: 404,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error: unknown) {
    console.error('Error in challenge-sessions:', error);
    return new Response(
      JSON.stringify({ error: "An error occurred while processing your request" }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      }
    );
  }
});

// Helper function to generate AI questions
async function generateAIQuestions(topic: string, count: number, difficulty: string = 'beginner'): Promise<QuizQuestion[]> {
  const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');
  if (!OPENAI_API_KEY) {
    // Return fallback questions if no API key
    throw new Error('OPENAI_API_KEY not configured');
  }

  try {
    let difficultyPrompt = '';
    if (difficulty === 'beginner') {
      difficultyPrompt = 'basic concepts and fundamentals';
    } else if (difficulty === 'intermediate') {
      difficultyPrompt = 'moderately complex concepts and applications';
    } else if (difficulty === 'advanced') {
      difficultyPrompt = 'complex concepts, advanced theories, and problem-solving';
    }

    const prompt = `Generate ${count} multiple choice quiz questions about ${topic} at ${difficultyPrompt} level.
Each question should have:
- A clear question text
- 4 answer options (A, B, C, D)
- The correct answer index (0-3)
- A brief explanation

Return as a JSON array with this structure:
[
  {
    "question": "question text",
    "options": ["option A", "option B", "option C", "option D"],
    "correct": 0,
    "explanation": "explanation text"
  }
]`;

    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          { role: 'system', content: 'You are a science quiz generator. Generate clear, accurate multiple choice questions at the appropriate difficulty level.' },
          { role: 'user', content: prompt }
        ],
        temperature: 0.7,
      }),
    });

    if (!response.ok) {
      console.error('OpenAI API error:', await response.text());
      throw new Error('Failed to parse AI questions');
    }

    const data = await response.json();
    const content = data.choices[0].message.content;
    const questions = JSON.parse(content);
    return questions;
  } catch (error) {
    console.error('Error generating AI questions:', error);
    // Throw error instead of returning placeholder questions
    // This prevents deceptive UX with fake questions
    throw new Error('Failed to generate challenge questions. The AI service is currently unavailable. Please try again later.');
  }
}

// Fisher-Yates shuffle
function shuffleArray<T>(array: T[]): T[] {
  const shuffled = [...array];
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
  }
  return shuffled;
}
