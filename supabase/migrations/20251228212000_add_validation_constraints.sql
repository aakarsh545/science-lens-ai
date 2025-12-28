-- Add Validation Constraints for Data Integrity
-- This migration adds validation constraints to ensure data quality
-- Note: Using DO blocks to safely add constraints only if they don't exist

-- Profiles table validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_xp_points_nonnegative'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_xp_points_nonnegative
      CHECK (xp_points >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_level_range'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_level_range
      CHECK (level >= 1 AND level <= 100);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_streak_count_nonnegative'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_streak_count_nonnegative
      CHECK (streak_count >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_xp_earned_week_nonnegative'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_xp_earned_week_nonnegative
      CHECK (xp_earned_week >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_xp_earned_month_nonnegative'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_xp_earned_month_nonnegative
      CHECK (xp_earned_month >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_challenges_completed_nonnegative'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_challenges_completed_nonnegative
      CHECK (challenges_completed >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_challenges_success_rate_range'
    AND conrelid = 'public.profiles'::regclass
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT check_challenges_success_rate_range
      CHECK (challenges_success_rate >= 0 AND challenges_success_rate <= 100);
  END IF;
END $$;

-- User stats validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_xp_total_nonnegative'
    AND conrelid = 'public.user_stats'::regclass
  ) THEN
    ALTER TABLE public.user_stats
      ADD CONSTRAINT check_xp_total_nonnegative
      CHECK (xp_total >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_credits_nonnegative'
    AND conrelid = 'public.user_stats'::regclass
  ) THEN
    ALTER TABLE public.user_stats
      ADD CONSTRAINT check_credits_nonnegative
      CHECK (credits >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_streak_nonnegative'
    AND conrelid = 'public.user_stats'::regclass
  ) THEN
    ALTER TABLE public.user_stats
      ADD CONSTRAINT check_streak_nonnegative
      CHECK (streak >= 0);
  END IF;
END $$;

-- Lessons validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_lessons_xp_reward_nonnegative'
    AND conrelid = 'public.lessons'::regclass
  ) THEN
    ALTER TABLE public.lessons
      ADD CONSTRAINT check_lessons_xp_reward_nonnegative
      CHECK (xp_reward >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_order_index_nonnegative'
    AND conrelid = 'public.lessons'::regclass
  ) THEN
    ALTER TABLE public.lessons
      ADD CONSTRAINT check_order_index_nonnegative
      CHECK (order_index >= 0);
  END IF;
END $$;

-- Challenges validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_challenges_xp_reward_nonnegative'
    AND conrelid = 'public.challenges'::regclass
  ) THEN
    ALTER TABLE public.challenges
      ADD CONSTRAINT check_challenges_xp_reward_nonnegative
      CHECK (xp_reward >= 0);
  END IF;
END $$;

-- User progress validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_user_progress_score_range'
    AND conrelid = 'public.user_progress'::regclass
  ) THEN
    ALTER TABLE public.user_progress
      ADD CONSTRAINT check_user_progress_score_range
      CHECK (score >= 0 AND score <= 100);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_user_progress_xp_earned_nonnegative'
    AND conrelid = 'public.user_progress'::regclass
  ) THEN
    ALTER TABLE public.user_progress
      ADD CONSTRAINT check_user_progress_xp_earned_nonnegative
      CHECK (xp_earned >= 0);
  END IF;
END $$;

-- User topic progress validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_questions_answered_nonnegative'
    AND conrelid = 'public.user_topic_progress'::regclass
  ) THEN
    ALTER TABLE public.user_topic_progress
      ADD CONSTRAINT check_questions_answered_nonnegative
      CHECK (questions_answered >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_topic_correct_answers_nonnegative'
    AND conrelid = 'public.user_topic_progress'::regclass
  ) THEN
    ALTER TABLE public.user_topic_progress
      ADD CONSTRAINT check_topic_correct_answers_nonnegative
      CHECK (correct_answers >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_correct_answers_not_exceed_questions'
    AND conrelid = 'public.user_topic_progress'::regclass
  ) THEN
    ALTER TABLE public.user_topic_progress
      ADD CONSTRAINT check_correct_answers_not_exceed_questions
      CHECK (correct_answers <= questions_answered);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_topic_completion_percentage_range'
    AND conrelid = 'public.user_topic_progress'::regclass
  ) THEN
    ALTER TABLE public.user_topic_progress
      ADD CONSTRAINT check_topic_completion_percentage_range
      CHECK (completion_percentage >= 0 AND completion_percentage <= 100);
  END IF;
END $$;

-- Quiz results validation constraints
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_accuracy_percentage_range'
    AND conrelid = 'public.quiz_results'::regclass
  ) THEN
    ALTER TABLE public.quiz_results
      ADD CONSTRAINT check_accuracy_percentage_range
      CHECK (accuracy_percentage >= 0 AND accuracy_percentage <= 100);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_quiz_results_correct_nonnegative'
    AND conrelid = 'public.quiz_results'::regclass
  ) THEN
    ALTER TABLE public.quiz_results
      ADD CONSTRAINT check_quiz_results_correct_nonnegative
      CHECK (correct_answers >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_quiz_results_incorrect_nonnegative'
    AND conrelid = 'public.quiz_results'::regclass
  ) THEN
    ALTER TABLE public.quiz_results
      ADD CONSTRAINT check_quiz_results_incorrect_nonnegative
      CHECK (incorrect_answers >= 0);
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'check_quiz_time_taken_nonnegative'
    AND conrelid = 'public.quiz_results'::regclass
  ) THEN
    ALTER TABLE public.quiz_results
      ADD CONSTRAINT check_quiz_time_taken_nonnegative
      CHECK (time_taken_seconds >= 0);
  END IF;
END $$;
