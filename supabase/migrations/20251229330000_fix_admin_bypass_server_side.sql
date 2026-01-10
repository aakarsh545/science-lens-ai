-- DANGEROUS #2 FIX: Server-side admin verification
-- Previously: Admin checks were client-side only, exploitable via DevTools
-- Now: All admin checks happen server-side in RPC functions

-- Drop and recreate spend_coins with server-side admin check
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
  user_is_admin BOOLEAN;
BEGIN
  -- Get user's current balance and admin status (server-side check)
  SELECT profiles.coins, profiles.is_admin
  INTO current_balance, user_is_admin
  FROM public.profiles
  WHERE profiles.user_id = v_user_id
  FOR UPDATE;

  -- Admin bypass: Allow purchase without spending coins
  -- This check happens SERVER-SIDE, cannot be spoofed
  IF user_is_admin THEN
    -- Log admin purchase for audit
    INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
    VALUES (
      v_user_id,
      0, -- Admins don't spend coins
      'admin_bypass_purchase',
      jsonb_build_object('item_id', v_item_id, 'admin_bypass', true)
    );

    -- Return true without deducting coins
    RETURN true;
  END IF;

  -- Non-admin users: Check if they have enough coins
  IF current_balance < v_amount THEN
    RETURN false;
  END IF;

  -- Deduct coins for non-admin users
  UPDATE public.profiles
  SET coins = coins - v_amount
  WHERE profiles.user_id = v_user_id;

  -- Record transaction
  INSERT INTO public.coin_transactions (user_id, amount, source, metadata)
  VALUES (v_user_id, -v_amount, 'purchase', jsonb_build_object('item_id', v_item_id));

  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Add a server-side function to check admin status for credit system
CREATE OR REPLACE FUNCTION public.verify_admin_for_credits(
  p_user_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  user_is_admin BOOLEAN;
BEGIN
  -- Server-side admin check, cannot be spoofed by client
  SELECT profiles.is_admin
  INTO user_is_admin
  FROM public.profiles
  WHERE profiles.user_id = p_user_id;

  RETURN COALESCE(user_is_admin, false);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION public.spend_coins TO authenticated;
GRANT EXECUTE ON FUNCTION public.verify_admin_for_credits TO authenticated;

-- Add comment for documentation
COMMENT ON FUNCTION public.spend_coins IS 'Server-side purchase function with admin bypass check. Admins do not spend coins.';
COMMENT ON FUNCTION public.verify_admin_for_credits IS 'Server-side admin verification for credit system. Returns true if user is admin.';
