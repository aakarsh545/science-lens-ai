-- Update Credits System: 10 Daily + 100 Monthly
-- This migration updates the credits system to give users 10 credits daily and 100 credits monthly
-- Credits are deducted when completing lessons

-- Add monthly credit tracking column
ALTER TABLE public.user_stats
  ADD COLUMN IF NOT EXISTS last_monthly_credit_refresh DATE DEFAULT CURRENT_DATE;

-- Update refresh_daily_credits function to give 10 credits instead of 5
CREATE OR REPLACE FUNCTION public.refresh_daily_credits(p_user_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
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

-- Update auto_refresh trigger
CREATE OR REPLACE FUNCTION public.auto_refresh_daily_credits()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Daily refresh: If last refresh was before today, add up to 10 credits (max 100)
  IF NEW.last_daily_credit_refresh IS NULL OR NEW.last_daily_credit_refresh < CURRENT_DATE THEN
    NEW.credits := LEAST(NEW.credits + 10, 100);
    NEW.last_daily_credit_refresh := CURRENT_DATE;
  END IF;

  -- Monthly refresh: If last monthly refresh was from a different month, reset to 100
  IF NEW.last_monthly_credit_refresh IS NULL OR DATE_TRUNC('month', NEW.last_monthly_credit_refresh) < DATE_TRUNC('month', CURRENT_DATE) THEN
    NEW.credits := 100;
    NEW.last_monthly_credit_refresh := CURRENT_DATE;
  END IF;

  RETURN NEW;
END;
$$;

-- Add comment to document the new system
COMMENT ON COLUMN public.user_stats.credits IS 'Source of truth for user credits. 10 daily + 100 monthly refresh. Max 100 credits.';
COMMENT ON COLUMN public.user_stats.last_daily_credit_refresh IS 'Tracks last daily credit refresh. Adds 10 credits when < CURRENT_DATE.';
COMMENT ON COLUMN public.user_stats.last_monthly_credit_refresh IS 'Tracks last monthly credit refresh. Resets to 100 credits when month changes.';
