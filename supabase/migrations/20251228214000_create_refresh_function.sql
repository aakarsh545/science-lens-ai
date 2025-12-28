-- Create Safe Leaderboard Refresh Function
-- This function safely refreshes all leaderboard materialized views with error handling

CREATE OR REPLACE FUNCTION public.refresh_leaderboards_safely()
RETURNS JSON AS $$
DECLARE
  result JSON := '{}'::JSON;
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
    REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_challenges;
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

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.refresh_leaderboards_safely() TO authenticated;

-- Add helpful comment
COMMENT ON FUNCTION public.refresh_leaderboards_safely() IS 'Safely refreshes all leaderboard materialized views with error handling. Returns JSON with results for each view. Call this after major data updates to keep leaderboards current.';
