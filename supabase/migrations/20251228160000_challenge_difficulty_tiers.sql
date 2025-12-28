-- Add 3-tier challenge system (beginner/intermediate/advanced)
-- Each topic will have 3 challenge difficulties with different question counts and XP rewards

-- Add columns to challenges table for tier system
ALTER TABLE public.challenges
  ADD COLUMN IF NOT EXISTS question_count INTEGER DEFAULT 15,
  ADD COLUMN IF NOT EXISTS max_hearts INTEGER DEFAULT 3,
  ADD COLUMN IF NOT EXISTS estimated_time_minutes INTEGER DEFAULT 10;

-- Update challenge_sessions table to support variable question counts
ALTER TABLE public.challenge_sessions
  ADD COLUMN IF NOT EXISTS challenge_difficulty TEXT DEFAULT 'beginner',
  ADD COLUMN IF NOT EXISTS xp_reward INTEGER DEFAULT 100;

-- Drop old constraints that assume fixed 15 questions
ALTER TABLE public.challenge_sessions
  DROP CONSTRAINT IF EXISTS valid_question,
  DROP CONSTRAINT IF EXISTS valid_correct_answers;

-- Add new dynamic constraints
ALTER TABLE public.challenge_sessions
  ADD CONSTRAINT valid_question_range CHECK (current_question >= 1 AND current_question <= total_questions),
  ADD CONSTRAINT valid_correct_answers_range CHECK (correct_answers >= 0 AND correct_answers <= total_questions),
  ADD CONSTRAINT valid_hearts_range CHECK (hearts_remaining >= 0 AND hearts_remaining <= 3);

-- Update comments to reflect dynamic nature
COMMENT ON COLUMN public.challenges.question_count IS 'Number of questions: 15 (beginner), 30 (intermediate), 45 (advanced)';
COMMENT ON COLUMN public.challenges.xp_reward IS 'XP reward: 100 (beginner), 200 (intermediate), 500 (advanced)';
COMMENT ON COLUMN public.challenges.challenge_level IS 'Difficulty tier: beginner, intermediate, or advanced';
COMMENT ON COLUMN public.challenges.max_hearts IS 'Maximum hearts allowed (default 3 for all difficulties)';
COMMENT ON COLUMN public.challenges.estimated_time_minutes IS 'Estimated completion time';
COMMENT ON COLUMN public.challenge_sessions.challenge_difficulty IS 'Difficulty level of this session: beginner, intermediate, advanced';
COMMENT ON COLUMN public.challenge_sessions.xp_reward IS 'XP reward for completing this challenge';
COMMENT ON COLUMN public.challenge_sessions.total_questions IS 'Dynamic total based on difficulty (15, 30, or 45)';

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_challenges_tier ON public.challenges(challenge_level, question_count);
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_difficulty ON public.challenge_sessions(challenge_difficulty);
