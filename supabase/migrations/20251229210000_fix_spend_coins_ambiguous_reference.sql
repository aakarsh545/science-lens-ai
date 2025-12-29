-- Fix ambiguous column reference in spend_coins function
-- The error occurs because both the function parameter and table column are named 'user_id'
-- Solution: Drop and recreate with renamed parameters

DROP FUNCTION IF EXISTS public.spend_coins(UUID, INTEGER, UUID);

CREATE FUNCTION public.spend_coins(
  p_user_id UUID,
  p_amount INTEGER,
  p_item_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  current_balance INTEGER;
BEGIN
  -- Get current balance and lock row
  SELECT coins INTO current_balance
  FROM public.profiles
  WHERE profiles.user_id = p_user_id
  FOR UPDATE;

  -- Check if user has enough coins
  IF current_balance < p_amount THEN
    RETURN false;
  END IF;

  -- Deduct coins
  UPDATE public.profiles
  SET coins = coins - p_amount
  WHERE profiles.user_id = p_user_id;

  -- Record transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (p_user_id, -p_amount, 'purchase', jsonb_build_object('item_id', p_item_id));

  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Also fix award_coins function to use consistent naming
DROP FUNCTION IF EXISTS public.award_coins(UUID, INTEGER, TEXT, JSONB);

CREATE FUNCTION public.award_coins(
  p_user_id UUID,
  p_amount INTEGER,
  p_source TEXT,
  p_metadata JSONB DEFAULT '{}'::jsonb
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
  WHERE profiles.user_id = p_user_id;

  -- Insert coin transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (p_user_id, p_amount * premium_multiplier, p_source, p_metadata)
  RETURNING id INTO transaction_id;

  -- Update user's coin balance
  UPDATE public.profiles
  SET coins = coins + (p_amount * premium_multiplier)
  WHERE profiles.user_id = p_user_id;

  RETURN transaction_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Re-grant execute permissions after dropping and recreating
-- Note: Parameter names in GRANT don't matter, only types matter
GRANT EXECUTE ON FUNCTION public.spend_coins TO authenticated;
GRANT EXECUTE ON FUNCTION public.award_coins TO authenticated;
