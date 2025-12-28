-- Add RLS Policies for Premium System
-- This migration secures premium features with proper access control

-- Enable RLS on new tables
ALTER TABLE public.coin_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shop_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_inventory ENABLE ROW LEVEL SECURITY;

-- Coin Transactions Policies
CREATE POLICY "Users can view their own coin transactions"
  ON public.coin_transactions FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert their own coin transactions"
  ON public.coin_transactions FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

-- Shop Items Policies (read-only for authenticated users)
CREATE POLICY "Authenticated users can view shop items"
  ON public.shop_items FOR SELECT
  TO authenticated
  USING (true);

-- User Inventory Policies
CREATE POLICY "Users can view their own inventory"
  ON public.user_inventory FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

CREATE POLICY "Users can insert to their own inventory"
  ON public.user_inventory FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can delete from their own inventory"
  ON public.user_inventory FOR DELETE
  TO authenticated
  USING (user_id = auth.uid());

-- Update profiles to allow users to set their equipped theme/avatar
-- Skip if already exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'profiles'
    AND policyname = 'Users can update their own profile'
  ) THEN
    CREATE POLICY "Users can update their own profile"
      ON public.profiles FOR UPDATE
      TO authenticated
      USING (user_id = auth.uid())
      WITH CHECK (user_id = auth.uid());
  END IF;
END $$;

-- Add premium check function
CREATE OR REPLACE FUNCTION public.can_access_lesson(lesson_id UUID, user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  lesson_is_premium BOOLEAN;
  user_is_premium BOOLEAN;
BEGIN
  -- Get lesson premium status
  SELECT is_premium INTO lesson_is_premium
  FROM public.lessons
  WHERE id = lesson_id;

  -- If lesson is not premium, allow access
  IF NOT COALESCE(lesson_is_premium, false) THEN
    RETURN true;
  END IF;

  -- Get user premium status
  SELECT is_premium INTO user_is_premium
  FROM public.profiles
  WHERE user_id = user_id;

  -- Allow access if user is premium
  RETURN COALESCE(user_is_premium, false);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add helper to award coins
CREATE OR REPLACE FUNCTION public.award_coins(
  user_id UUID,
  amount INTEGER,
  source TEXT,
  metadata JSONB DEFAULT '{}'::jsonb
)
RETURNS UUID AS $$
DECLARE
  transaction_id UUID;
  premium_multiplier INTEGER;
BEGIN
  -- Get premium multiplier (1x for free, 2x for premium)
  SELECT CASE WHEN is_premium THEN 2 ELSE 1 END
  INTO premium_multiplier
  FROM public.profiles
  WHERE user_id = award_coins.user_id;

  -- Insert coin transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (user_id, amount * premium_multiplier, source, metadata)
  RETURNING id INTO transaction_id;

  -- Update user's coin balance
  UPDATE public.profiles
  SET coins = coins + (amount * premium_multiplier)
  WHERE user_id = award_coins.user_id;

  RETURN transaction_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add helper to spend coins
CREATE OR REPLACE FUNCTION public.spend_coins(
  user_id UUID,
  amount INTEGER,
  item_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  current_balance INTEGER;
BEGIN
  -- Get current balance and lock row
  SELECT coins INTO current_balance
  FROM public.profiles
  WHERE user_id = spend_coins.user_id
  FOR UPDATE;

  -- Check if user has enough coins
  IF current_balance < amount THEN
    RETURN false;
  END IF;

  -- Deduct coins
  UPDATE public.profiles
  SET coins = coins - amount
  WHERE user_id = spend_coins.user_id;

  -- Record transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (user_id, -amount, 'purchase', jsonb_build_object('item_id', item_id));

  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION public.can_access_lesson TO authenticated;
GRANT EXECUTE ON FUNCTION public.award_coins TO authenticated;
GRANT EXECUTE ON FUNCTION public.spend_coins TO authenticated;
