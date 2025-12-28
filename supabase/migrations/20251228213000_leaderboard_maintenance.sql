-- Leaderboard Maintenance and Verification
-- This script helps verify that leaderboards are working correctly

-- Test query to check if leaderboards exist and have data
SELECT
  'leaderboard_all_time' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_all_time
UNION ALL
SELECT
  'leaderboard_weekly' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_weekly
UNION ALL
SELECT
  'leaderboard_monthly' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_monthly
UNION ALL
SELECT
  'leaderboard_streaks' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_streaks
UNION ALL
SELECT
  'leaderboard_challenges' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_challenges
UNION ALL
SELECT
  'leaderboard_physics' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_physics
UNION ALL
SELECT
  'leaderboard_chemistry' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_chemistry
UNION ALL
SELECT
  'leaderboard_biology' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_biology
UNION ALL
SELECT
  'leaderboard_astronomy' as view_name,
  COUNT(*) as row_count,
  MAX(rank) as max_rank
FROM public.leaderboard_astronomy;

-- Note: The refresh_leaderboards_safely() function is created in migration 20251228214000
