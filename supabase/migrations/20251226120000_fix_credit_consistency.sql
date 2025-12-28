-- Fix credit data inconsistency bug
-- This migration ensures user_stats.credits is the single source of truth
-- and updates the deduct_credits function to use the correct table

-- Step 1: Sync any credits from profiles to user_stats (take the max to preserve data)
UPDATE public.user_stats
SET credits = GREATEST(
  user_stats.credits,
  COALESCE((SELECT credits FROM public.profiles WHERE profiles.user_id = user_stats.user_id), 0)
);

-- Step 2: Update the deduct_credits function to use user_stats instead of profiles
CREATE OR REPLACE FUNCTION public.deduct_credits(
  p_user_id uuid,
  p_amount integer
)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  current_credits integer;
BEGIN
  -- Get current credits from user_stats (the source of truth)
  SELECT credits INTO current_credits
  FROM public.user_stats
  WHERE user_id = p_user_id;

  -- Check if user has enough credits
  IF current_credits IS NULL OR current_credits < p_amount THEN
    RETURN false;
  END IF;

  -- Deduct credits from user_stats
  UPDATE public.user_stats
  SET credits = credits - p_amount
  WHERE user_id = p_user_id;

  RETURN true;
END;
$$;

-- Step 3: Update the add_credits function to use user_stats
CREATE OR REPLACE FUNCTION public.add_credits(
  p_user_id uuid,
  p_amount integer,
  p_admin_id uuid DEFAULT NULL,
  p_reason text DEFAULT NULL
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Add credits to user_stats (the source of truth)
  UPDATE public.user_stats
  SET credits = credits + p_amount
  WHERE user_id = p_user_id;

  -- If this is a purchase, update profiles tracking
  IF p_admin_id IS NULL THEN
    UPDATE public.profiles
    SET
      total_credits_purchased = total_credits_purchased + p_amount,
      last_credit_purchase = now()
    WHERE user_id = p_user_id;
  END IF;

  -- Log if admin action
  IF p_admin_id IS NOT NULL THEN
    INSERT INTO public.admin_credit_logs (admin_user_id, target_user_id, credits_adjusted, reason)
    VALUES (p_admin_id, p_user_id, p_amount, p_reason);
  END IF;
END;
$$;

-- Step 4: Add a trigger to keep profiles.credits in sync (for backwards compatibility)
-- This ensures any legacy code still reading from profiles sees the correct value
CREATE OR REPLACE FUNCTION public.sync_credits_to_profile()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- When user_stats.credits changes, sync to profiles.credits
  UPDATE public.profiles
  SET credits = NEW.credits
  WHERE user_id = NEW.user_id;

  RETURN NEW;
END;
$$;

-- Create trigger to sync credits
DROP TRIGGER IF EXISTS sync_credits_trigger ON public.user_stats;
CREATE TRIGGER sync_credits_trigger
  AFTER UPDATE OF credits ON public.user_stats
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_credits_to_profile();

-- Step 5: Add comment to document the source of truth
COMMENT ON COLUMN public.user_stats.credits IS 'Source of truth for user credits. All credit operations should use this column.';
COMMENT ON COLUMN public.profiles.credits IS 'Legacy field kept for backwards compatibility. Auto-synced from user_stats.credits via trigger.';
