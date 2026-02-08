-- Add onboarding columns to profiles table
-- This migration adds support for storing user onboarding survey responses

-- Add onboarding completion flag
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS onboarding_completed BOOLEAN DEFAULT FALSE NOT NULL;

-- Add onboarding data JSONB column to store survey responses
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS onboarding_data JSONB DEFAULT '{}' NOT NULL;

-- Add daily learning goal in minutes
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS daily_goal_minutes INTEGER DEFAULT 10 NOT NULL;

-- Create index on onboarding_completed for quick lookups
CREATE INDEX IF NOT EXISTS idx_profiles_onboarding_completed ON profiles(onboarding_completed);

-- Add constraint to ensure daily_goal_minutes is reasonable
ALTER TABLE profiles
ADD CONSTRAINT check_daily_goal_minutes
CHECK (daily_goal_minutes >= 1 AND daily_goal_minutes <= 120);

-- Add comment to document the onboarding_data structure
COMMENT ON COLUMN profiles.onboarding_data IS $$JSONB object containing onboarding survey responses:
{
  "how_hear_about": "youtube" | "friends_family" | "tv" | "tiktok" | "google_search" | "news_article" | "facebook_instagram" | "other",
  "how_hear_about_other": "string (only if how_hear_about = 'other')",
  "motivation": "school_exam" | "career_boost" | "personal_curiosity" | "support_education" | "connect_others" | "just_fun" | "other",
  "motivation_other": "string (only if motivation = 'other')",
  "knowledge_level": "new" | "basic" | "explain_simple" | "discuss_various" | "advanced_details",
  "daily_goal_minutes": 5 | 10 | 15 | 20,
  "starting_point": "basics" | "find_my_level"
}$$;

COMMENT ON COLUMN profiles.onboarding_completed IS 'Whether the user has completed the onboarding survey';

COMMENT ON COLUMN profiles.daily_goal_minutes IS 'User daily learning goal in minutes (5, 10, 15, or 20)';
