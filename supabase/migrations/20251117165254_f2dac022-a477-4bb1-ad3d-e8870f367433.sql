-- Add admin role check and credit management enhancements
-- Update profiles table to ensure all gamification fields are present
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS last_credit_purchase timestamp with time zone,
ADD COLUMN IF NOT EXISTS total_credits_purchased integer DEFAULT 0,
ADD COLUMN IF NOT EXISTS learning_progress jsonb DEFAULT '{}';

-- Create admin management table for credit adjustments
CREATE TABLE IF NOT EXISTS public.admin_credit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  admin_user_id uuid NOT NULL,
  target_user_id uuid NOT NULL,
  credits_adjusted integer NOT NULL,
  reason text,
  created_at timestamp with time zone DEFAULT now()
);

ALTER TABLE public.admin_credit_logs ENABLE ROW LEVEL SECURITY;

-- Only admins can insert credit logs
CREATE POLICY "Only admins can log credit adjustments"
ON public.admin_credit_logs
FOR INSERT
TO authenticated
WITH CHECK (has_role(auth.uid(), 'admin'::app_role));

-- Only admins can view credit logs
CREATE POLICY "Only admins can view credit logs"
ON public.admin_credit_logs
FOR SELECT
TO authenticated
USING (has_role(auth.uid(), 'admin'::app_role));

-- Create function to deduct credits safely
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
  -- Get current credits
  SELECT credits INTO current_credits
  FROM public.profiles
  WHERE user_id = p_user_id;
  
  -- Check if user has enough credits
  IF current_credits IS NULL OR current_credits < p_amount THEN
    RETURN false;
  END IF;
  
  -- Deduct credits
  UPDATE public.profiles
  SET credits = credits - p_amount
  WHERE user_id = p_user_id;
  
  RETURN true;
END;
$$;

-- Create function to add credits (for admin or purchases)
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
  -- Add credits
  UPDATE public.profiles
  SET credits = credits + p_amount,
      total_credits_purchased = CASE 
        WHEN p_admin_id IS NULL THEN total_credits_purchased + p_amount
        ELSE total_credits_purchased
      END,
      last_credit_purchase = CASE
        WHEN p_admin_id IS NULL THEN now()
        ELSE last_credit_purchase
      END
  WHERE user_id = p_user_id;
  
  -- Log if admin action
  IF p_admin_id IS NOT NULL THEN
    INSERT INTO public.admin_credit_logs (admin_user_id, target_user_id, credits_adjusted, reason)
    VALUES (p_admin_id, p_user_id, p_amount, p_reason);
  END IF;
END;
$$;

-- Update existing profiles to have default credits if NULL
UPDATE public.profiles 
SET credits = 10 
WHERE credits IS NULL OR credits = 0;