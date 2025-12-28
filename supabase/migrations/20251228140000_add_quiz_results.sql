-- Create quiz_results table to track detailed quiz attempt data
-- This is a fix for the failed migration

CREATE TABLE IF NOT EXISTS quiz_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES lessons(id) ON DELETE SET NULL,
  challenge_session_id UUID,

  -- Quiz metadata
  quiz_type TEXT NOT NULL CHECK (quiz_type IN ('lesson', 'challenge')),
  total_questions INTEGER NOT NULL,
  correct_answers INTEGER NOT NULL,
  incorrect_answers INTEGER NOT NULL,
  accuracy_percentage INTEGER NOT NULL,

  -- Timing data
  time_taken_seconds INTEGER NOT NULL,
  average_time_per_question DECIMAL(10, 2),

  -- XP and rewards
  xp_earned INTEGER NOT NULL DEFAULT 0,
  streak_bonus INTEGER DEFAULT 0,

  -- Detailed answers (JSONB for flexible storage)
  answers JSONB NOT NULL DEFAULT '[]'::jsonb,

  -- Comparison data
  previous_attempt_id UUID,
  improvement_percentage INTEGER,

  -- Metadata
  difficulty_level TEXT CHECK (difficulty_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
  completed_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

  -- Performance metrics
  questions_per_minute DECIMAL(10, 2),
  perfect_streaks INTEGER DEFAULT 0,

  -- Topics for review (array of topic IDs or names)
  topics_to_review TEXT[] DEFAULT ARRAY[]::TEXT[]
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_quiz_results_user_id ON quiz_results(user_id);
CREATE INDEX IF NOT EXISTS idx_quiz_results_lesson_id ON quiz_results(lesson_id);
CREATE INDEX IF NOT EXISTS idx_quiz_results_challenge_session_id ON quiz_results(challenge_session_id);
CREATE INDEX IF NOT EXISTS idx_quiz_results_completed_at ON quiz_results(completed_at DESC);
CREATE INDEX IF NOT EXISTS idx_quiz_results_user_type ON quiz_results(user_id, quiz_type);

-- Add comments for documentation
COMMENT ON TABLE quiz_results IS 'Stores detailed results from quiz attempts for both lessons and challenges';
COMMENT ON COLUMN quiz_results.answers IS 'JSONB array of answer objects with question, user_answer, correct_answer, is_correct, time_spent';
COMMENT ON COLUMN quiz_results.previous_attempt_id IS 'Links to previous attempt for comparison';
COMMENT ON COLUMN quiz_results.improvement_percentage IS 'Percentage improvement compared to previous attempt';
COMMENT ON COLUMN quiz_results.perfect_streaks IS 'Number of streaks where user answered multiple questions correctly in a row';
COMMENT ON COLUMN quiz_results.topics_to_review IS 'Array of topic names or questions that user got wrong and should review';
