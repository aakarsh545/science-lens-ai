-- Leaderboard Enhancements for Science Lens AI
-- Adds comprehensive leaderboard functionality with multiple ranking categories

-- Add weekly/monthly XP tracking to profiles table
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS xp_earned_week INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS xp_earned_month INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS week_start_date TIMESTAMPTZ DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS month_start_date TIMESTAMPTZ DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS show_in_leaderboard BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS previous_rank INTEGER,
  ADD COLUMN IF NOT EXISTS challenges_completed INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS challenges_success_rate DECIMAL(5,2) DEFAULT 0.00;

-- Add indexes for leaderboard performance
CREATE INDEX IF NOT EXISTS idx_profiles_xp_points ON public.profiles(xp_points DESC, show_in_leaderboard);
CREATE INDEX IF NOT EXISTS idx_profiles_xp_earned_week ON public.profiles(xp_earned_week DESC, show_in_leaderboard);
CREATE INDEX IF NOT EXISTS idx_profiles_xp_earned_month ON public.profiles(xp_earned_month DESC, show_in_leaderboard);
CREATE INDEX IF NOT EXISTS idx_profiles_streak_count ON public.profiles(streak_count DESC, show_in_leaderboard);
CREATE INDEX IF NOT EXISTS idx_profiles_challenges_completed ON public.profiles(challenges_completed DESC, show_in_leaderboard);

-- Create leaderboard entry materialized view for all-time rankings
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_all_time AS
SELECT
  p.user_id,
  p.display_name,
  p.avatar_url,
  p.xp_points,
  p.level,
  p.streak_count,
  p.challenges_completed,
  p.show_in_leaderboard,
  ROW_NUMBER() OVER (ORDER BY p.xp_points DESC) as rank,
  LAG(p.xp_points, 1, p.xp_points) OVER (ORDER BY p.xp_points DESC) as prev_xp
FROM public.profiles p
WHERE p.show_in_leaderboard = true
  AND p.xp_points > 0;

-- Create unique index on leaderboard
CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_all_time_user_id ON public.leaderboard_all_time(user_id);

-- Create view for weekly leaderboard
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_weekly AS
SELECT
  p.user_id,
  p.display_name,
  p.avatar_url,
  p.xp_earned_week,
  p.level,
  p.streak_count,
  p.week_start_date,
  p.show_in_leaderboard,
  ROW_NUMBER() OVER (ORDER BY p.xp_earned_week DESC) as rank
FROM public.profiles p
WHERE p.show_in_leaderboard = true
  AND p.xp_earned_week > 0
  AND p.week_start_date >= date_trunc('week', NOW());

-- Create unique index on weekly leaderboard
CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_weekly_user_id ON public.leaderboard_weekly(user_id);

-- Create view for monthly leaderboard
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_monthly AS
SELECT
  p.user_id,
  p.display_name,
  p.avatar_url,
  p.xp_earned_month,
  p.level,
  p.streak_count,
  p.month_start_date,
  p.show_in_leaderboard,
  ROW_NUMBER() OVER (ORDER BY p.xp_earned_month DESC) as rank
FROM public.profiles p
WHERE p.show_in_leaderboard = true
  AND p.xp_earned_month > 0
  AND p.month_start_date >= date_trunc('month', NOW());

-- Create unique index on monthly leaderboard
CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_monthly_user_id ON public.leaderboard_monthly(user_id);

-- Create view for streak leaderboard
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_streaks AS
SELECT
  p.user_id,
  p.display_name,
  p.avatar_url,
  p.streak_count,
  p.xp_points,
  p.level,
  p.show_in_leaderboard,
  ROW_NUMBER() OVER (ORDER BY p.streak_count DESC) as rank
FROM public.profiles p
WHERE p.show_in_leaderboard = true
  AND p.streak_count > 0;

-- Create unique index on streak leaderboard
CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_streaks_user_id ON public.leaderboard_streaks(user_id);

-- Create view for challenge champions
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_challenges AS
SELECT
  p.user_id,
  p.display_name,
  p.avatar_url,
  p.challenges_completed,
  p.challenges_success_rate,
  p.xp_points,
  p.level,
  p.show_in_leaderboard,
  ROW_NUMBER() OVER (
    ORDER BY p.challenges_completed DESC, p.challenges_success_rate DESC
  ) as rank
FROM public.profiles p
WHERE p.show_in_leaderboard = true
  AND p.challenges_completed > 0;

-- Create unique index on challenges leaderboard
CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_challenges_user_id ON public.leaderboard_challenges(user_id);

-- Create view for per-subject leaderboards (Physics, Chemistry, Biology, Astronomy)
CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_physics AS
SELECT
  utp.user_id,
  p.display_name,
  p.avatar_url,
  p.level,
  p.xp_points,
  COALESCE(SUM(utp.correct_answers), 0) as correct_answers,
  COALESCE(SUM(utp.questions_answered), 0) as questions_answered,
  ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(utp.correct_answers), 0) DESC) as rank
FROM public.user_topic_progress utp
JOIN public.profiles p ON p.user_id = utp.user_id
JOIN public.learning_topics lt ON lt.id = utp.topic_id
WHERE p.show_in_leaderboard = true
  AND lt.category = 'Physics'
  AND utp.questions_answered > 0
GROUP BY utp.user_id, p.display_name, p.avatar_url, p.level, p.xp_points;

CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_physics_user_id ON public.leaderboard_physics(user_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_chemistry AS
SELECT
  utp.user_id,
  p.display_name,
  p.avatar_url,
  p.level,
  p.xp_points,
  COALESCE(SUM(utp.correct_answers), 0) as correct_answers,
  COALESCE(SUM(utp.questions_answered), 0) as questions_answered,
  ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(utp.correct_answers), 0) DESC) as rank
FROM public.user_topic_progress utp
JOIN public.profiles p ON p.user_id = utp.user_id
JOIN public.learning_topics lt ON lt.id = utp.topic_id
WHERE p.show_in_leaderboard = true
  AND lt.category = 'Chemistry'
  AND utp.questions_answered > 0
GROUP BY utp.user_id, p.display_name, p.avatar_url, p.level, p.xp_points;

CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_chemistry_user_id ON public.leaderboard_chemistry(user_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_biology AS
SELECT
  utp.user_id,
  p.display_name,
  p.avatar_url,
  p.level,
  p.xp_points,
  COALESCE(SUM(utp.correct_answers), 0) as correct_answers,
  COALESCE(SUM(utp.questions_answered), 0) as questions_answered,
  ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(utp.correct_answers), 0) DESC) as rank
FROM public.user_topic_progress utp
JOIN public.profiles p ON p.user_id = utp.user_id
JOIN public.learning_topics lt ON lt.id = utp.topic_id
WHERE p.show_in_leaderboard = true
  AND lt.category = 'Biology'
  AND utp.questions_answered > 0
GROUP BY utp.user_id, p.display_name, p.avatar_url, p.level, p.xp_points;

CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_biology_user_id ON public.leaderboard_biology(user_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS public.leaderboard_astronomy AS
SELECT
  utp.user_id,
  p.display_name,
  p.avatar_url,
  p.level,
  p.xp_points,
  COALESCE(SUM(utp.correct_answers), 0) as correct_answers,
  COALESCE(SUM(utp.questions_answered), 0) as questions_answered,
  ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(utp.correct_answers), 0) DESC) as rank
FROM public.user_topic_progress utp
JOIN public.profiles p ON p.user_id = utp.user_id
JOIN public.learning_topics lt ON lt.id = utp.topic_id
WHERE p.show_in_leaderboard = true
  AND lt.category = 'Astronomy'
  AND utp.questions_answered > 0
GROUP BY utp.user_id, p.display_name, p.avatar_url, p.level, p.xp_points;

CREATE UNIQUE INDEX IF NOT EXISTS idx_leaderboard_astronomy_user_id ON public.leaderboard_astronomy(user_id);

-- Create function to refresh all leaderboard materialized views
CREATE OR REPLACE FUNCTION public.refresh_leaderboards()
RETURNS void AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_all_time;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_weekly;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_monthly;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_streaks;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_challenges;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_physics;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_chemistry;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_biology;
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.leaderboard_astronomy;
END;
$$ LANGUAGE plpgsql;

-- Create function to reset weekly XP (call via cron job or edge function weekly)
CREATE OR REPLACE FUNCTION public.reset_weekly_xp()
RETURNS void AS $$
BEGIN
  UPDATE public.profiles
  SET xp_earned_week = 0,
      week_start_date = NOW(),
      previous_rank = (
        SELECT rank FROM public.leaderboard_weekly
        WHERE user_id = profiles.user_id
      )
  WHERE week_start_date < date_trunc('week', NOW());
END;
$$ LANGUAGE plpgsql;

-- Create function to reset monthly XP (call via cron job or edge function monthly)
CREATE OR REPLACE FUNCTION public.reset_monthly_xp()
RETURNS void AS $$
BEGIN
  UPDATE public.profiles
  SET xp_earned_month = 0,
      month_start_date = NOW()
  WHERE month_start_date < date_trunc('month', NOW());
END;
$$ LANGUAGE plpgsql;

-- Create helper function to get user rank in any leaderboard
CREATE OR REPLACE FUNCTION public.get_user_rank(p_user_id UUID, p_leaderboard TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_rank INTEGER;
BEGIN
  IF p_leaderboard = 'all_time' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_all_time WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'weekly' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_weekly WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'monthly' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_monthly WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'streaks' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_streaks WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'challenges' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_challenges WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'physics' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_physics WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'chemistry' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_chemistry WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'biology' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_biology WHERE user_id = p_user_id;
  ELSIF p_leaderboard = 'astronomy' THEN
    SELECT rank INTO v_rank FROM public.leaderboard_astronomy WHERE user_id = p_user_id;
  ELSE
    v_rank := NULL;
  END IF;

  RETURN v_rank;
END;
$$ LANGUAGE plpgsql;

-- Grant execute permissions on functions
GRANT EXECUTE ON FUNCTION public.refresh_leaderboards() TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_user_rank(UUID, TEXT) TO authenticated;

-- Grant select on materialized views
GRANT SELECT ON public.leaderboard_all_time TO authenticated;
GRANT SELECT ON public.leaderboard_weekly TO authenticated;
GRANT SELECT ON public.leaderboard_monthly TO authenticated;
GRANT SELECT ON public.leaderboard_streaks TO authenticated;
GRANT SELECT ON public.leaderboard_challenges TO authenticated;
GRANT SELECT ON public.leaderboard_physics TO authenticated;
GRANT SELECT ON public.leaderboard_chemistry TO authenticated;
GRANT SELECT ON public.leaderboard_biology TO authenticated;
GRANT SELECT ON public.leaderboard_astronomy TO authenticated;
