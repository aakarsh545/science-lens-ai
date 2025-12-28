-- Add Monetization Items: Coin Packages & XP Boosts
-- These are special shop items for real-money value and temporary boosts

-- First, drop the type check constraint to allow new types
ALTER TABLE public.shop_items DROP CONSTRAINT IF EXISTS shop_items_type_check;

-- Recreate constraint to allow all types
ALTER TABLE public.shop_items
  ADD CONSTRAINT shop_items_type_check
    CHECK (type IN ('theme', 'avatar', 'coin_pack', 'xp_boost'));

-- Coin Packages (Special items - not themes/avatars)
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- SMALL COIN PACKAGES
('coin_pack', 'Starter Coins', '100 coins to get started', 99, false, 1, 'common', '💰',
 '{"coin_amount": 100, "usd_price": 0.99, "bonus": 0}'::jsonb),
('coin_pack', 'Basic Coins', '500 coins pack', 399, false, 1, 'uncommon', '💰',
 '{"coin_amount": 500, "usd_price": 4.99, "bonus": 0}'::jsonb),
('coin_pack', 'Standard Coins', '1200 coins pack', 799, false, 5, 'rare', '💰',
 '{"coin_amount": 1200, "usd_price": 9.99, "bonus": 200}'::jsonb),

-- MEDIUM COIN PACKAGES
('coin_pack', 'Premium Coins', '3000 coins + 500 bonus', 1599, false, 10, 'epic', '💎',
 '{"coin_amount": 3500, "usd_price": 19.99, "bonus": 500}'::jsonb),
('coin_pack', 'Elite Coins', '7500 coins + 1500 bonus', 2999, false, 20, 'legendary', '💎',
 '{"coin_amount": 9000, "usd_price": 49.99, "bonus": 1500}'::jsonb),

-- LARGE COIN PACKAGES (Premium exclusive, best value)
('coin_pack', 'Legendary Coins', '20000 coins + 5000 bonus', 4999, true, 40, 'mythical', '👑',
 '{"coin_amount": 25000, "usd_price": 99.99, "bonus": 5000, "best_value": true}'::jsonb),
('coin_pack', 'Godly Coins', '50000 coins + 15000 bonus', 9999, true, 60, 'godly', '🌟',
 '{"coin_amount": 65000, "usd_price": 199.99, "bonus": 15000, "best_value": true, "premium": true}'::jsonb),

-- XP BOOST ITEMS (Single-use temporary boosts)
-- 15 MINUTE BOOSTS
('xp_boost', '2x XP - 15 Minutes', 'Double XP for 15 minutes', 50, false, 1, 'common', '⚡',
 '{"boost_type": "2x_xp", "duration_minutes": 15, "bonus_multiplier": 2}'::jsonb),
('xp_boost', '3x XP - 15 Minutes', 'Triple XP for 15 minutes', 150, false, 10, 'rare', '⚡',
 '{"boost_type": "3x_xp", "duration_minutes": 15, "bonus_multiplier": 3}'::jsonb),

-- 30 MINUTE BOOSTS
('xp_boost', '2x XP - 30 Minutes', 'Double XP for 30 minutes', 75, false, 5, 'uncommon', '⚡',
 '{"boost_type": "2x_xp", "duration_minutes": 30, "bonus_multiplier": 2}'::jsonb),
('xp_boost', '3x XP - 30 Minutes', 'Triple XP for 30 minutes', 250, false, 20, 'epic', '⚡',
 '{"boost_type": "3x_xp", "duration_minutes": 30, "bonus_multiplier": 3}'::jsonb),
('xp_boost', '5x XP - 30 Minutes', 'Quintuple XP for 30 minutes', 500, true, 40, 'legendary', '⚡',
 '{"boost_type": "5x_xp", "duration_minutes": 30, "bonus_multiplier": 5, "premium": true}'::jsonb),

-- 50 MINUTE BOOSTS
('xp_boost', '2x XP - 50 Minutes', 'Double XP for 50 minutes', 100, false, 10, 'rare', '⚡',
 '{"boost_type": "2x_xp", "duration_minutes": 50, "bonus_multiplier": 2}'::jsonb),
('xp_boost', '3x XP - 50 Minutes', 'Triple XP for 50 minutes', 350, false, 30, 'legendary', '⚡',
 '{"boost_type": "3x_xp", "duration_minutes": 50, "bonus_multiplier": 3}'::jsonb),
('xp_boost', '5x XP - 50 Minutes', 'Quintuple XP for 50 minutes', 750, true, 60, 'godly', '⚡',
 '{"boost_type": "5x_xp", "duration_minutes": 50, "bonus_multiplier": 5, "premium": true, "best_value": true}'::jsonb),

-- SPECIAL: 1 HOUR BOOSTS
('xp_boost', '2x XP - 1 Hour', 'Double XP for 60 minutes', 150, false, 15, 'epic', '⚡',
 '{"boost_type": "2x_xp", "duration_minutes": 60, "bonus_multiplier": 2}'::jsonb),
('xp_boost', '3x XP - 1 Hour', 'Triple XP for 60 minutes', 500, false, 40, 'mythical', '⚡',
 '{"boost_type": "3x_xp", "duration_minutes": 60, "bonus_multiplier": 3}'::jsonb),
('xp_boost', '5x XP - 1 Hour', 'Quintuple XP for 60 minutes', 1000, true, 80, 'godly', '⚡',
 '{"boost_type": "5x_xp", "duration_minutes": 60, "bonus_multiplier": 5, "premium": true, "best_value": true}'::jsonb);

-- Add active boosts tracking to user_profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS active_xp_boost INTEGER DEFAULT 1,
  ADD COLUMN IF NOT EXISTS xp_boost_expires_at TIMESTAMPTZ;

-- Add index for active boosts
CREATE INDEX IF NOT EXISTS idx_profiles_xp_boost ON public.profiles(active_xp_boost, xp_boost_expires_at);

-- Create function to get current XP multiplier
CREATE OR REPLACE FUNCTION public.get_xp_multiplier(p_user_id uuid)
RETURNS NUMERIC AS $$
DECLARE
  multiplier INTEGER DEFAULT 1;
  boost_expires TIMESTAMPTZ;
BEGIN
  -- Check if user has active boost
  SELECT active_xp_boost, xp_boost_expires_at
  INTO multiplier, boost_expires
  FROM public.profiles
  WHERE user_id = p_user_id;

  -- If boost expired, reset it
  IF boost_expires IS NOT NULL AND boost_expires < NOW() THEN
    UPDATE public.profiles
    SET active_xp_boost = 1, xp_boost_expires_at = NULL
    WHERE user_id = p_user_id;
    multiplier := 1;
  END IF;

  RETURN COALESCE(multiplier, 1);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.get_xp_multiplier TO authenticated;

-- Add comment
COMMENT ON TABLE public.shop_items IS 'Shop items including themes, avatars, coin packages, and XP boosts. Type can be: theme, avatar, coin_pack, xp_boost';
COMMENT ON COLUMN public.profiles.active_xp_boost IS 'Current XP boost multiplier (1 = no boost, 2 = 2x, 3 = 3x, 5 = 5x)';
COMMENT ON COLUMN public.profiles.xp_boost_expires_at IS 'When the current XP boost expires';
