-- Remove all restrictions from coin packs and XP boosts
-- Makes them accessible to all users regardless of level or premium status

-- Update all coin packs: remove premium requirement and level requirement
UPDATE public.shop_items
SET
  is_premium_exclusive = false,
  level_required = 1
WHERE type = 'coin_pack';

-- Update all XP boosts: remove premium requirement and level requirement
UPDATE public.shop_items
SET
  is_premium_exclusive = false,
  level_required = 1
WHERE type = 'xp_boost';

-- Add comment to clarify
COMMENT ON TABLE public.shop_items IS 'Shop items including themes, avatars, coin packages (no restrictions), and XP boosts (no restrictions). Type can be: theme, avatar, coin_pack, xp_boost';
