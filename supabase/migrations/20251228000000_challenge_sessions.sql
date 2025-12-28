-- Create challenge_sessions table for tracking 15-question quiz sessions
-- This enables the new challenge session feature with 3 hearts/lives system

CREATE TABLE IF NOT EXISTS public.challenge_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  topic_id TEXT,

  -- Session metadata
  topic_name TEXT,
  difficulty TEXT DEFAULT 'medium',
  status TEXT DEFAULT 'active', -- 'active', 'completed', 'failed'

  -- Progress tracking
  current_question INTEGER DEFAULT 1,
  total_questions INTEGER DEFAULT 15,
  hearts_remaining INTEGER DEFAULT 3,
  correct_answers INTEGER DEFAULT 0,

  -- Question data (stores the 15 questions for this session)
  questions JSONB DEFAULT '[]'::jsonb,
  answers JSONB DEFAULT '[]'::jsonb, -- Stores user answers and whether they were correct

  -- Results
  xp_earned INTEGER DEFAULT 0,
  completion_percentage INTEGER DEFAULT 0,

  -- Timestamps
  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,

  -- Indexes for performance
  CONSTRAINT valid_hearts CHECK (hearts_remaining >= 0 AND hearts_remaining <= 3),
  CONSTRAINT valid_question CHECK (current_question >= 1 AND current_question <= 15),
  CONSTRAINT valid_correct_answers CHECK (correct_answers >= 0 AND correct_answers <= 15)
);

-- Create index for user's challenge history
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_user_id ON public.challenge_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_status ON public.challenge_sessions(status);
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_topic_id ON public.challenge_sessions(topic_id);
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_started_at ON public.challenge_sessions(started_at DESC);

-- Add helpful comments
COMMENT ON TABLE public.challenge_sessions IS 'Stores 15-question challenge sessions with 3 hearts system';
COMMENT ON COLUMN public.challenge_sessions.user_id IS 'User attempting the challenge';
COMMENT ON COLUMN public.challenge_sessions.topic_id IS 'Selected topic/course ID for questions';
COMMENT ON COLUMN public.challenge_sessions.topic_name IS 'Human-readable topic name';
COMMENT ON COLUMN public.challenge_sessions.status IS 'Session status: active, completed, or failed';
COMMENT ON COLUMN public.challenge_sessions.current_question IS 'Current question number (1-15)';
COMMENT ON COLUMN public.challenge_sessions.hearts_remaining IS 'Lives remaining (0-3)';
COMMENT ON COLUMN public.challenge_sessions.correct_answers IS 'Number of correctly answered questions';
COMMENT ON COLUMN public.challenge_sessions.questions IS 'Array of 15 quiz questions';
COMMENT ON COLUMN public.challenge_sessions.answers IS 'Array of user answers with correctness';
COMMENT ON COLUMN public.challenge_sessions.xp_earned IS 'Total XP earned from session';
COMMENT ON COLUMN public.challenge_sessions.completion_percentage IS 'Percentage of questions answered correctly';

-- Enable Row Level Security
ALTER TABLE public.challenge_sessions ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own challenge sessions"
  ON public.challenge_sessions
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own challenge sessions"
  ON public.challenge_sessions
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own challenge sessions"
  ON public.challenge_sessions
  FOR UPDATE
  USING (auth.uid() = user_id);
