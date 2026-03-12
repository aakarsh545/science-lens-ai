-- Add challenge difficulty requirements and categorization

-- Create enum for challenge difficulty levels
CREATE TYPE public.challenge_difficulty AS ENUM ('beginner', 'intermediate', 'advanced');

-- Add columns to challenges table
ALTER TABLE public.challenges
  ADD COLUMN IF NOT EXISTS challenge_level challenge_difficulty DEFAULT 'beginner',
  ADD COLUMN IF NOT EXISTS level_requirement integer DEFAULT 0,
  ADD COLUMN IF NOT EXISTS topic_id uuid REFERENCES public.learning_topics(id);

-- Update existing challenges to have proper difficulty levels
-- Beginner challenges (no level requirement)
UPDATE public.challenges
SET
  challenge_level = 'beginner',
  level_requirement = 0
WHERE difficulty IN ('easy', 'beginner') OR challenge_level = 'beginner';

-- Intermediate challenges (require level 10+)
UPDATE public.challenges
SET
  challenge_level = 'intermediate',
  level_requirement = 10
WHERE difficulty IN ('medium', 'intermediate');

-- Advanced challenges (require level 20+)
UPDATE public.challenges
SET
  challenge_level = 'advanced',
  level_requirement = 20
WHERE difficulty IN ('hard', 'advanced');

-- Ensure all challenges have a challenge_level set
UPDATE public.challenges
SET challenge_level = 'beginner'
WHERE challenge_level IS NULL;

-- Add index for better query performance
CREATE INDEX IF NOT EXISTS idx_challenges_difficulty ON public.challenges(challenge_level);
CREATE INDEX IF NOT EXISTS idx_challenges_level_requirement ON public.challenges(level_requirement);

-- Add comment for documentation
COMMENT ON COLUMN public.challenges.challenge_level IS 'Difficulty level: beginner (no requirement), intermediate (level 10+), advanced (level 20+)';
COMMENT ON COLUMN public.challenges.level_requirement IS 'Minimum user level required to access this challenge';
COMMENT ON COLUMN public.challenges.topic_id IS 'Optional reference to learning topic';
