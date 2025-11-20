-- Add last_daily_credit_refresh column to user_stats
ALTER TABLE public.user_stats 
ADD COLUMN IF NOT EXISTS last_daily_credit_refresh date DEFAULT CURRENT_DATE;

-- Function to refresh daily credits
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
      WHEN last_daily_credit_refresh < CURRENT_DATE THEN credits + 5
      ELSE credits
    END,
    last_daily_credit_refresh = CURRENT_DATE
  WHERE user_id = p_user_id
    AND (last_daily_credit_refresh IS NULL OR last_daily_credit_refresh < CURRENT_DATE);
END;
$$;

-- Trigger to auto-refresh credits on user login (called when user_stats is read)
CREATE OR REPLACE FUNCTION public.auto_refresh_daily_credits()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- If last refresh was before today, add 5 credits
  IF NEW.last_daily_credit_refresh IS NULL OR NEW.last_daily_credit_refresh < CURRENT_DATE THEN
    NEW.credits := NEW.credits + 5;
    NEW.last_daily_credit_refresh := CURRENT_DATE;
  END IF;
  RETURN NEW;
END;
$$;

-- Create trigger on user_stats SELECT (this won't work for SELECT, so we'll use UPDATE instead)
-- We'll call the refresh function from the frontend when loading stats

-- Comment: The daily credit refresh will be called from the frontend when loading user stats