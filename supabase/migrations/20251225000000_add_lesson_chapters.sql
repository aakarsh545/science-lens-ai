-- Add chapter column to lessons table
-- This enables organizing lessons into logical chapters within each course

ALTER TABLE public.lessons
ADD COLUMN chapter TEXT;

-- Add index for better querying by chapter
CREATE INDEX IF NOT EXISTS lessons_chapter_idx ON public.lessons(course_id, chapter);

-- Add comment
COMMENT ON COLUMN public.lessons.chapter IS 'Chapter name for grouping related lessons (e.g., "Introduction", "Basics", "Advanced")';
