-- Add lesson-level onboarding and quiz tracking
-- This migration adds support for per-lesson onboarding surveys and placement quizzes

-- Add lesson onboarding tracking to user_progress table
ALTER TABLE user_progress
ADD COLUMN IF NOT EXISTS onboarding_completed BOOLEAN DEFAULT FALSE NOT NULL,
ADD COLUMN IF NOT EXISTS onboarding_data JSONB DEFAULT '{}' NOT NULL,
ADD COLUMN IF NOT EXISTS quiz_score INTEGER,
ADD COLUMN IF NOT EXISTS quiz_total_questions INTEGER,
ADD COLUMN IF NOT EXISTS quiz_percentage INTEGER,
ADD COLUMN IF NOT EXISTS recommended_starting_section VARCHAR(255),
ADD COLUMN IF NOT EXISTS quiz_completed_at TIMESTAMPTZ;

-- Create index for efficient queries
CREATE INDEX IF NOT EXISTS idx_user_progress_onboarding ON user_progress(lesson_id, user_id, onboarding_completed);
CREATE INDEX IF NOT EXISTS idx_user_progress_quiz ON user_progress(lesson_id, user_id, quiz_completed_at);

-- Add comment to document onboarding_data structure
COMMENT ON COLUMN user_progress.onboarding_data IS $$JSONB object containing lesson onboarding survey responses:
{
  "knowledge_level": "new" | "basic" | "explain_simple" | "discuss_various" | "advanced",
  "starting_preference": "basics" | "find_my_level",
  "quiz_answers": [
    { "question": "...", "user_answer": "...", "is_correct": true/false, "difficulty": "easy|medium|hard" }
  ]
}$$;

COMMENT ON COLUMN user_progress.onboarding_completed IS 'Whether the user has completed the onboarding for this specific lesson';
COMMENT ON COLUMN user_progress.quiz_score IS 'Number of correct answers in placement quiz';
COMMENT ON COLUMN user_progress.quiz_total_questions IS 'Total questions in placement quiz';
COMMENT ON COLUMN user_progress.quiz_percentage IS 'Score as percentage (0-100)';
COMMENT ON COLUMN user_progress.recommended_starting_section IS 'Recommended lesson section to start based on quiz performance';
COMMENT ON COLUMN user_progress.quiz_completed_at IS 'Timestamp when placement quiz was completed';

-- Add constraint to ensure quiz_percentage is valid
ALTER TABLE user_progress
DROP CONSTRAINT IF EXISTS check_user_progress_quiz_percentage;
ALTER TABLE user_progress
ADD CONSTRAINT check_user_progress_quiz_percentage
CHECK (quiz_percentage IS NULL OR (quiz_percentage >= 0 AND quiz_percentage <= 100));

-- Add constraint for quiz score
ALTER TABLE user_progress
DROP CONSTRAINT IF EXISTS check_user_progress_quiz_score;
ALTER TABLE user_progress
ADD CONSTRAINT check_user_progress_quiz_score
CHECK (quiz_score IS NULL OR (quiz_score >= 0 AND quiz_score <= quiz_total_questions));
