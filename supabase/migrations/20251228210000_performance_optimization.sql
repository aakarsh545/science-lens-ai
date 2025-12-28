-- Performance Optimization for Science Lens AI
-- Adds missing indexes, validation constraints, and optimizes database queries

-- ============================================
-- MISSING INDEXES FOR PERFORMANCE
-- ============================================

-- Lessons table indexes
-- Note: lessons already has UNIQUE(course_id, slug) constraint which creates an index
-- Adding a separate slug index for faster slug-only lookups
CREATE INDEX IF NOT EXISTS idx_lessons_slug ON public.lessons(slug);
CREATE INDEX IF NOT EXISTS idx_lessons_course_id ON public.lessons(course_id);

-- Courses table indexes
-- Note: courses already has UNIQUE(slug) constraint which creates an index
-- Adding additional index for slug searches (redundant but explicit)
CREATE INDEX IF NOT EXISTS idx_courses_slug ON public.courses(slug);
CREATE INDEX IF NOT EXISTS idx_courses_category ON public.courses(category);

-- User progress composite index for faster user lesson lookups
-- Note: user_progress already has UNIQUE(user_id, lesson_id) which creates an index
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON public.user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson_id ON public.user_progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_status ON public.user_progress(status);

-- User topic progress composite index for faster user topic lookups
-- Note: user_topic_progress already has UNIQUE(user_id, topic_id) which creates an index
CREATE INDEX IF NOT EXISTS idx_user_topic_progress_user_id ON public.user_topic_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_topic_progress_topic_id ON public.user_topic_progress(topic_id);

-- Profiles table indexes
CREATE INDEX IF NOT EXISTS idx_profiles_display_name ON public.profiles(display_name);
CREATE INDEX IF NOT EXISTS idx_profiles_level ON public.profiles(level);
CREATE INDEX IF NOT EXISTS idx_profiles_user_id ON public.profiles(user_id);

-- Challenge sessions indexes (already exist, skipping to avoid conflicts)
-- Note: These indexes were already created in challenge_sessions migration
-- CREATE INDEX IF NOT EXISTS idx_challenge_sessions_user_id ON public.challenge_sessions(user_id);
-- CREATE INDEX IF NOT EXISTS idx_challenge_sessions_status ON public.challenge_sessions(status);
-- CREATE INDEX IF NOT EXISTS idx_challenge_sessions_topic_id ON public.challenge_sessions(topic_id);
-- CREATE INDEX IF NOT EXISTS idx_challenge_sessions_started_at ON public.challenge_sessions(started_at DESC);
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_completed_at ON public.challenge_sessions(completed_at);

-- Quiz results indexes (already exist, skipping to avoid conflicts)
-- Note: These indexes were already created in quiz_results migration
-- CREATE INDEX IF NOT EXISTS idx_quiz_results_user_id ON public.quiz_results(user_id);
-- CREATE INDEX IF NOT EXISTS idx_quiz_results_lesson_id ON public.quiz_results(lesson_id);
-- CREATE INDEX IF NOT EXISTS idx_quiz_results_challenge_session_id ON public.quiz_results(challenge_session_id);
-- CREATE INDEX IF NOT EXISTS idx_quiz_results_completed_at ON public.quiz_results(completed_at DESC);
-- CREATE INDEX IF NOT EXISTS idx_quiz_results_user_type ON public.quiz_results(user_id, quiz_type);

-- Activity log indexes (already exist, skipping to avoid conflicts)
-- Note: These indexes were already created in activity_log migration
-- CREATE INDEX IF NOT EXISTS idx_activity_log_user_id ON public.activity_log(user_id);
-- CREATE INDEX IF NOT EXISTS idx_activity_log_activity_type ON public.activity_log(activity_type);
-- CREATE INDEX IF NOT EXISTS idx_activity_log_created_at ON public.activity_log(created_at DESC);
-- CREATE INDEX IF NOT EXISTS idx_activity_log_user_created ON public.activity_log(user_id, created_at DESC);

-- Learning topics indexes
CREATE INDEX IF NOT EXISTS idx_learning_topics_category ON public.learning_topics(category);
CREATE INDEX IF NOT EXISTS idx_learning_topics_difficulty_level ON public.learning_topics(difficulty_level);

-- Challenges indexes
CREATE INDEX IF NOT EXISTS idx_challenges_difficulty ON public.challenges(difficulty);
CREATE INDEX IF NOT EXISTS idx_challenges_related_lesson ON public.challenges(related_lesson);

-- Lessons model_type index (already exists, skipping to avoid conflicts)
-- Note: This index was already created in add_lesson_3d_model_mapping migration
-- CREATE INDEX IF NOT EXISTS lessons_model_type_idx ON public.lessons(model_type);

-- ============================================
-- VALIDATION CONSTRAINTS FOR DATA INTEGRITY
-- ============================================

-- Profiles table validation constraints
ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_xp_points_nonnegative
  CHECK (xp_points >= 0);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_level_range
  CHECK (level >= 1 AND level <= 100);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_streak_count_nonnegative
  CHECK (streak_count >= 0);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_xp_earned_week_nonnegative
  CHECK (xp_earned_week >= 0);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_xp_earned_month_nonnegative
  CHECK (xp_earned_month >= 0);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_challenges_completed_nonnegative
  CHECK (challenges_completed >= 0);

ALTER TABLE public.profiles
  ADD CONSTRAINT IF NOT EXISTS check_challenges_success_rate_range
  CHECK (challenges_success_rate >= 0 AND challenges_success_rate <= 100);

-- User stats validation constraints
ALTER TABLE public.user_stats
  ADD CONSTRAINT IF NOT EXISTS check_xp_total_nonnegative
  CHECK (xp_total >= 0);

ALTER TABLE public.user_stats
  ADD CONSTRAINT IF NOT EXISTS check_credits_nonnegative
  CHECK (credits >= 0);

ALTER TABLE public.user_stats
  ADD CONSTRAINT IF NOT EXISTS check_streak_nonnegative
  CHECK (streak >= 0);

-- Lessons validation constraints
ALTER TABLE public.lessons
  ADD CONSTRAINT IF NOT EXISTS check_xp_reward_nonnegative
  CHECK (xp_reward >= 0);

ALTER TABLE public.lessons
  ADD CONSTRAINT IF NOT EXISTS check_order_index_nonnegative
  CHECK (order_index >= 0);

-- Challenges validation constraints
ALTER TABLE public.challenges
  ADD CONSTRAINT IF NOT EXISTS check_xp_reward_nonnegative
  CHECK (xp_reward >= 0);

-- User progress validation constraints
ALTER TABLE public.user_progress
  ADD CONSTRAINT IF NOT EXISTS check_score_range
  CHECK (score >= 0 AND score <= 100);

ALTER TABLE public.user_progress
  ADD CONSTRAINT IF NOT EXISTS check_xp_earned_nonnegative
  CHECK (xp_earned >= 0);

-- User topic progress validation constraints
ALTER TABLE public.user_topic_progress
  ADD CONSTRAINT IF NOT EXISTS check_questions_answered_nonnegative
  CHECK (questions_answered >= 0);

ALTER TABLE public.user_topic_progress
  ADD CONSTRAINT IF NOT EXISTS check_correct_answers_nonnegative
  CHECK (correct_answers >= 0);

ALTER TABLE public.user_topic_progress
  ADD CONSTRAINT IF NOT EXISTS check_correct_answers_not_exceed_questions
  CHECK (correct_answers <= questions_answered);

ALTER TABLE public.user_topic_progress
  ADD CONSTRAINT IF NOT EXISTS check_completion_percentage_range
  CHECK (completion_percentage >= 0 AND completion_percentage <= 100);

-- Quiz results validation constraints
-- Note: quiz_results uses accuracy_percentage column, not score
ALTER TABLE public.quiz_results
  ADD CONSTRAINT IF NOT EXISTS check_accuracy_percentage_range
  CHECK (accuracy_percentage >= 0 AND accuracy_percentage <= 100);

ALTER TABLE public.quiz_results
  ADD CONSTRAINT IF NOT EXISTS check_correct_answers_nonnegative
  CHECK (correct_answers >= 0);

ALTER TABLE public.quiz_results
  ADD CONSTRAINT IF NOT EXISTS check_incorrect_answers_nonnegative
  CHECK (incorrect_answers >= 0);

ALTER TABLE public.quiz_results
  ADD CONSTRAINT IF NOT EXISTS check_time_taken_nonnegative
  CHECK (time_taken_seconds >= 0);

-- ============================================
-- CREATE REFRESH SCHEDULED FUNCTION
-- ============================================

-- Create a function to refresh all materialized views safely
-- This version handles the case where views don't exist yet
CREATE OR REPLACE FUNCTION public.refresh_leaderboards_safely()
RETURNS JSON AS $$
DECLARE
  result JSON := '{}'::JSON;
  view_name TEXT;
  view_count INTEGER := 0;
BEGIN
  -- Refresh leaderboard_all_time if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_all_time;
    result := result || jsonb_build_object('leaderboard_all_time', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_all_time', SQLERRM);
  END;

  -- Refresh leaderboard_weekly if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_weekly;
    result := result || jsonb_build_object('leaderboard_weekly', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_weekly', SQLERRM);
  END;

  -- Refresh leaderboard_monthly if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_monthly;
    result := result || jsonb_build_object('leaderboard_monthly', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_monthly', SQLERRM);
  END;

  -- Refresh leaderboard_streaks if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_streaks;
    result := result || jsonb_build_object('leaderboard_streaks', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_streaks', SQLERRM);
  END;

  -- Refresh leaderboard_challenges if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_challenges;
    result := result || jsonb_build_object('leaderboard_challenges', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_challenges', SQLERRM);
  END;

  -- Refresh leaderboard_physics if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_physics;
    result := result || jsonb_build_object('leaderboard_physics', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_physics', SQLERRM);
  END;

  -- Refresh leaderboard_chemistry if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_chemistry;
    result := result || jsonb_build_object('leaderboard_chemistry', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_chemistry', SQLERRM);
  END;

  -- Refresh leaderboard_biology if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_biology;
    result := result || jsonb_build_object('leaderboard_biology', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_biology', SQLERRM);
  END;

  -- Refresh leaderboard_astronomy if it exists
  BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_astronomy;
    result := result || jsonb_build_object('leaderboard_astronomy', 'success');
    view_count := view_count + 1;
  EXCEPTION WHEN OTHERS THEN
    result := result || jsonb_build_object('leaderboard_astronomy', SQLERRM);
  END;

  RETURN jsonb_build_object(
    'views_refreshed', view_count,
    'results', result
  );
END;
$$ LANGUAGE plpgsql;

-- Grant execute permission on the safe refresh function
GRANT EXECUTE ON FUNCTION public.refresh_leaderboards_safely() TO authenticated;

-- ============================================
-- PERFORMANCE IMPROVEMENT: ANALYZE TABLES
-- ============================================

-- Run ANALYZE to update statistics for the query planner
ANALYZE public.profiles;
ANALYZE public.lessons;
ANALYZE public.courses;
ANALYZE public.user_progress;
ANALYZE public.user_topic_progress;
ANALYZE public.challenges;
ANALYZE public.challenge_sessions;
ANALYZE public.quiz_results;
ANALYZE public.activity_log;

-- ============================================
-- PERFORMANCE IMPROVEMENT: VACUUM ANALYZE
-- ============================================

-- Run VACUUM ANALYZE to reclaim space and update statistics
-- Note: This is non-blocking VACUUM (without FULL)
VACUUM ANALYZE public.profiles;
VACUUM ANALYZE public.lessons;
VACUUM ANALYZE public.courses;
VACUUM ANALYZE public.user_progress;
VACUUM ANALYZE public.user_topic_progress;

-- ============================================
-- DOCUMENTATION
-- ============================================

-- View indexes for a table:
-- SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'profiles';

-- View table size:
-- SELECT pg_size_pretty(pg_total_relation_size('public.profiles'));

-- View index usage:
-- SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
-- FROM pg_stat_user_indexes
-- ORDER BY idx_scan DESC;

-- View missing indexes (potential candidates):
-- SELECT schemaname, tablename, attname, n_distinct, correlation
-- FROM pg_stats
-- WHERE schemaname = 'public'
-- ORDER BY n_distinct DESC;

-- Refresh all leaderboards:
-- SELECT public.refresh_leaderboards_safely();

-- Manual refresh of specific leaderboard:
-- REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_all_time;
