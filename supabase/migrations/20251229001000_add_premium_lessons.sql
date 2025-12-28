-- Add Premium Flag to Lessons
-- This migration marks 50% of lessons as premium content

-- Add is_premium column to lessons
ALTER TABLE public.lessons
  ADD COLUMN IF NOT EXISTS is_premium BOOLEAN DEFAULT false;

-- Mark every second lesson as premium (50% of content)
-- This strategy gives free users access to foundational content
UPDATE public.lessons
SET is_premium = true
WHERE MOD(order_index, 2) = 0;

-- Create index for filtering premium lessons
CREATE INDEX IF NOT EXISTS idx_lessons_is_premium
  ON public.lessons(is_premium);

-- Add comment
COMMENT ON COLUMN public.lessons.is_premium IS 'Whether this lesson requires premium access';
