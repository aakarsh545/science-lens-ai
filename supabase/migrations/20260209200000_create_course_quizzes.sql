-- Create course_quizzes table for pre-generated placement quizzes
-- This table stores quizzes that are generated once and reused for all users

CREATE TABLE IF NOT EXISTS course_quizzes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  questions JSONB NOT NULL,
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create unique index on course_id (one quiz per course)
CREATE UNIQUE INDEX IF NOT EXISTS idx_course_quizzes_course_id ON course_quizzes(course_id);

-- Create index for efficient queries
CREATE INDEX IF NOT EXISTS idx_course_quizzes_created_at ON course_quizzes(created_at DESC);

-- Add comments
COMMENT ON TABLE course_quizzes IS 'Pre-generated placement quizzes for each course. Contains 8-10 MCQs with difficulty progression.';

COMMENT ON COLUMN course_quizzes.course_id IS 'Reference to the course this quiz belongs to';
COMMENT ON COLUMN course_quizzes.questions IS 'JSON array of quiz questions: [{id, question, options[], correctAnswer, difficulty}, ...]';
COMMENT ON COLUMN course_quizzes.metadata IS 'Additional metadata like generation method, model used, etc.';
COMMENT ON COLUMN course_quizzes.created_at IS 'When the quiz was first generated';
COMMENT ON COLUMN course_quizzes.updated_at IS 'When the quiz was last updated';

-- Enable Row Level Security
ALTER TABLE course_quizzes ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Allow authenticated users to read quizzes
CREATE POLICY "Allow authenticated users to read course quizzes"
ON course_quizzes FOR SELECT
TO authenticated
USING (true);

-- RLS Policies: Allow service role to insert/update quizzes
CREATE POLICY "Allow service role to manage course quizzes"
ON course_quizzes FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_course_quizzes_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to auto-update updated_at
DROP TRIGGER IF EXISTS update_course_quizzes_updated_at_trigger ON course_quizzes;
CREATE TRIGGER update_course_quizzes_updated_at_trigger
BEFORE UPDATE ON course_quizzes
FOR EACH ROW
EXECUTE FUNCTION update_course_quizzes_updated_at();
