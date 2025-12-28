-- Ensure authenticated users have access to user_stats table
-- Grant necessary permissions for the credit system

-- Grant SELECT on user_stats to authenticated users
GRANT SELECT ON TABLE public.user_stats TO authenticated;

-- Grant USAGE on the user_stats sequence (if any)
-- GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO authenticated;

-- Ensure the function has SECURITY DEFINER and can bypass RLS
CREATE OR REPLACE FUNCTION public.refresh_daily_credits(p_user_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public, auth
AS $$
BEGIN
  -- Check if user already received today's credits
  UPDATE public.user_stats
  SET
    credits = CASE
      WHEN last_daily_credit_refresh < CURRENT_DATE THEN LEAST(credits + 10, 100)
      ELSE credits
    END,
    last_daily_credit_refresh = CURRENT_DATE
  WHERE user_id = p_user_id
    AND (last_daily_credit_refresh IS NULL OR last_daily_credit_refresh < CURRENT_DATE);

  -- Monthly refresh: If last monthly refresh was from a different month, reset to 100
  UPDATE public.user_stats
  SET
    credits = 100,
    last_monthly_credit_refresh = CURRENT_DATE
  WHERE user_id = p_user_id
    AND (
      last_monthly_credit_refresh IS NULL
      OR DATE_TRUNC('month', last_monthly_credit_refresh) < DATE_TRUNC('month', CURRENT_DATE)
    );
END;
$$;

-- Re-grant execute permission
GRANT EXECUTE ON FUNCTION public.refresh_daily_credits(uuid) TO authenticated;
