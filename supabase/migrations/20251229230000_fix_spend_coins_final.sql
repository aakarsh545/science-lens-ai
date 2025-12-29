-- Fix spend_coins function by avoiding ambiguous column references
-- Use local variables to store parameter values and avoid name conflicts

DROP FUNCTION IF EXISTS public.spend_coins(UUID, INTEGER, UUID);

CREATE FUNCTION public.spend_coins(
  user_id UUID,
  amount INTEGER,
  item_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  v_user_id UUID := user_id;
  v_amount INTEGER := amount;
  v_item_id UUID := item_id;
  current_balance INTEGER;
BEGIN
  -- Get current balance and lock row
  SELECT profiles.coins INTO current_balance
  FROM public.profiles
  WHERE profiles.user_id = v_user_id
  FOR UPDATE;

  -- Check if user has enough coins
  IF current_balance < v_amount THEN
    RETURN false;
  END IF;

  -- Deduct coins
  UPDATE public.profiles
  SET coins = coins - v_amount
  WHERE profiles.user_id = v_user_id;

  -- Record transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (v_user_id, -v_amount, 'purchase', jsonb_build_object('item_id', v_item_id));

  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Also fix award_coins function with the same approach
DROP FUNCTION IF EXISTS public.award_coins(UUID, INTEGER, TEXT, JSONB);

CREATE FUNCTION public.award_coins(
  user_id UUID,
  amount INTEGER,
  source TEXT,
  metadata JSONB DEFAULT '{}'::jsonb
)
RETURNS UUID AS $$
DECLARE
  v_user_id UUID := user_id;
  v_amount INTEGER := amount;
  v_source TEXT := source;
  v_metadata JSONB := metadata;
  transaction_id UUID;
  premium_multiplier INTEGER;
BEGIN
  -- Get premium multiplier (1x for free, 2x for premium)
  SELECT CASE WHEN profiles.is_premium THEN 2 ELSE 1 END
  INTO premium_multiplier
  FROM public.profiles
  WHERE profiles.user_id = v_user_id;

  -- Insert coin transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (v_user_id, v_amount * premium_multiplier, v_source, v_metadata)
  RETURNING id INTO transaction_id;

  -- Update user's coin balance
  UPDATE public.profiles
  SET coins = coins + (v_amount * premium_multiplier)
  WHERE profiles.user_id = v_user_id;

  RETURN transaction_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Re-grant execute permissions
GRANT EXECUTE ON FUNCTION public.spend_coins TO authenticated;
GRANT EXECUTE ON FUNCTION public.award_coins TO authenticated;
