-- Activity Log Migration
-- Tracks all user activities for the profile analytics dashboard

-- Create activity_log table
CREATE TABLE IF NOT EXISTS activity_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_type TEXT NOT NULL CHECK (activity_type IN ('lesson_completed', 'quiz_taken', 'challenge_completed', 'level_up', 'streak_milestone', 'achievement_unlocked', 'daily_goal_reached', 'topic_mastered')),
  related_id UUID, -- Can reference lessons, challenges, achievements, etc.
  xp_earned INTEGER DEFAULT 0,
  metadata JSONB DEFAULT '{}', -- Store additional context (lesson title, quiz score, etc.)
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- Add index for faster queries
  CONSTRAINT valid_xp CHECK (xp_earned >= 0)
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_activity_log_user_id ON activity_log(user_id);
CREATE INDEX IF NOT EXISTS idx_activity_log_created_at ON activity_log(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_activity_log_activity_type ON activity_log(activity_type);
CREATE INDEX IF NOT EXISTS idx_activity_log_user_created ON activity_log(user_id, created_at DESC);

-- Enable RLS
ALTER TABLE activity_log ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view own activity logs"
  ON activity_log FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activity logs"
  ON activity_log FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Comment
COMMENT ON TABLE activity_log IS 'Tracks user learning activities for analytics and progress tracking';
COMMENT ON COLUMN activity_log.activity_type IS 'Type of activity: lesson_completed, quiz_taken, challenge_completed, level_up, streak_milestone, achievement_unlocked, daily_goal_reached, topic_mastered';
COMMENT ON COLUMN activity_log.related_id IS 'Optional ID referencing related entity (lesson, challenge, achievement, etc.)';
COMMENT ON COLUMN activity_log.metadata IS 'Additional context about the activity (JSONB)';
