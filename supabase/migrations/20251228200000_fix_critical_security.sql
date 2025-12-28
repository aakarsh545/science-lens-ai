-- ============================================================================
-- CRITICAL DATABASE SECURITY FIXES
-- ============================================================================
-- This migration addresses critical security issues:
-- 1. Enable RLS on lessons and courses tables
-- 2. Fix overly permissive challenges RLS policy
-- 3. Add missing foreign key constraints
-- 4. Add unique constraints to prevent duplicate data
-- 5. Fix quiz_results foreign key constraint
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. ENABLE RLS ON LESSONS TABLE
-- ----------------------------------------------------------------------------
-- Lessons table currently has RLS enabled but policies allow public read
-- We're keeping public read for courses/lessons as they are educational content
-- But we need to ensure RLS is actually enabled

DO $$
BEGIN
  -- Check if RLS is enabled, if not enable it
  IF NOT EXISTS (
    SELECT 1 FROM pg_class
    WHERE relname = 'lessons'
    AND relrowsecurity = true
  ) THEN
    ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
    RAISE NOTICE 'Enabled RLS on lessons table';
  ELSE
    RAISE NOTICE 'RLS already enabled on lessons table';
  END IF;
END $$;

-- Ensure proper policies exist for lessons
DROP POLICY IF EXISTS "public_select_lessons" ON public.lessons;
CREATE POLICY "Allow authenticated users to read lessons"
  ON public.lessons FOR SELECT
  TO authenticated
  USING (true);

-- Only admins can modify lessons
DROP POLICY IF EXISTS "Authenticated users can modify lessons" ON public.lessons;
CREATE POLICY "Allow only admins to modify lessons"
  ON public.lessons FOR ALL
  TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ----------------------------------------------------------------------------
-- 2. ENABLE RLS ON COURSES TABLE
-- ----------------------------------------------------------------------------

DO $$
BEGIN
  -- Check if RLS is enabled, if not enable it
  IF NOT EXISTS (
    SELECT 1 FROM pg_class
    WHERE relname = 'courses'
    AND relrowsecurity = true
  ) THEN
    ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
    RAISE NOTICE 'Enabled RLS on courses table';
  ELSE
    RAISE NOTICE 'RLS already enabled on courses table';
  END IF;
END $$;

-- Ensure proper policies exist for courses
DROP POLICY IF EXISTS "public_select_courses" ON public.courses;
CREATE POLICY "Allow authenticated users to read courses"
  ON public.courses FOR SELECT
  TO authenticated
  USING (true);

-- Only admins can modify courses
DROP POLICY IF EXISTS "Authenticated users can modify courses" ON public.courses;
CREATE POLICY "Allow only admins to modify courses"
  ON public.courses FOR ALL
  TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ----------------------------------------------------------------------------
-- 3. FIX CHALLENGES RLS POLICY
-- ----------------------------------------------------------------------------
-- Current policy allows ANY authenticated user to modify challenges
-- This is a CRITICAL security issue - only admins should modify challenges

-- First, ensure RLS is enabled
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_class
    WHERE relname = 'challenges'
    AND relrowsecurity = true
  ) THEN
    ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
    RAISE NOTICE 'Enabled RLS on challenges table';
  END IF;
END $$;

-- Drop the overly permissive policy
DROP POLICY IF EXISTS "public_select_challenges" ON public.challenges;
DROP POLICY IF EXISTS "Authenticated users can modify challenges" ON public.challenges;

-- Create proper policies
CREATE POLICY "Allow authenticated users to read challenges"
  ON public.challenges FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow only admins to modify challenges"
  ON public.challenges FOR ALL
  TO authenticated
  USING (public.has_role(auth.uid(), 'admin'))
  WITH CHECK (public.has_role(auth.uid(), 'admin'));

-- ----------------------------------------------------------------------------
-- 4. ADD MISSING FOREIGN KEY CONSTRAINTS
-- ----------------------------------------------------------------------------

-- Add foreign key for user_stats.user_id if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'user_stats_user_id_fkey'
  ) THEN
    ALTER TABLE public.user_stats
      ADD CONSTRAINT user_stats_user_id_fkey
      FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    RAISE NOTICE 'Added foreign key: user_stats_user_id_fkey';
  ELSE
    RAISE NOTICE 'Foreign key user_stats_user_id_fkey already exists';
  END IF;
END $$;

-- Add foreign key for profiles.user_id if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'profiles_user_id_fkey'
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT profiles_user_id_fkey
      FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;
    RAISE NOTICE 'Added foreign key: profiles_user_id_fkey';
  ELSE
    RAISE NOTICE 'Foreign key profiles_user_id_fkey already exists';
  END IF;
END $$;

-- ----------------------------------------------------------------------------
-- 5. ADD UNIQUE CONSTRAINTS TO PREVENT DUPLICATE DATA
-- ----------------------------------------------------------------------------

-- Unique constraint for user_progress (user_id, lesson_id)
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_progress_user_lesson_unique
  ON public.user_progress(user_id, lesson_id);

-- Unique constraint for user_topic_progress (user_id, topic_id)
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_topic_progress_user_topic_unique
  ON public.user_topic_progress(user_id, topic_id);

-- Unique constraint for daily_streaks (user_id, date)
CREATE UNIQUE INDEX IF NOT EXISTS idx_daily_streaks_user_date_unique
  ON public.daily_streaks(user_id, date);

-- ----------------------------------------------------------------------------
-- 6. FIX QUIZ_RESULTS FOREIGN KEY CONSTRAINT
-- ----------------------------------------------------------------------------

-- Add foreign key for quiz_results.challenge_session_id if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'quiz_results_challenge_session_id_fkey'
  ) THEN
    ALTER TABLE public.quiz_results
      ADD CONSTRAINT quiz_results_challenge_session_id_fkey
      FOREIGN KEY (challenge_session_id) REFERENCES public.challenge_sessions(id) ON DELETE SET NULL;
    RAISE NOTICE 'Added foreign key: quiz_results_challenge_session_id_fkey';
  ELSE
    RAISE NOTICE 'Foreign key quiz_results_challenge_session_id_fkey already exists';
  END IF;
END $$;

-- ----------------------------------------------------------------------------
-- 7. VERIFY ALL POLICIES ARE CORRECT
-- ----------------------------------------------------------------------------

-- Display summary of changes
DO $$
DECLARE
  lessons_rls boolean;
  courses_rls boolean;
  challenges_rls boolean;
BEGIN
  SELECT relrowsecurity INTO lessons_rls
  FROM pg_class WHERE relname = 'lessons';

  SELECT relrowsecurity INTO courses_rls
  FROM pg_class WHERE relname = 'courses';

  SELECT relrowsecurity INTO challenges_rls
  FROM pg_class WHERE relname = 'challenges';

  RAISE NOTICE '=== SECURITY FIXES APPLIED ===';
  RAISE NOTICE 'RLS Status:';
  RAISE NOTICE '  - lessons: %', lessons_rls;
  RAISE NOTICE '  - courses: %', courses_rls;
  RAISE NOTICE '  - challenges: %', challenges_rls;
  RAISE NOTICE '==============================';
END $$;

-- ============================================================================
-- END OF SECURITY FIXES
-- ============================================================================
