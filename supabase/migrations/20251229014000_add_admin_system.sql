-- Admin System Migration
-- Adds admin privileges that bypass all restrictions

-- Add is_admin flag to user_stats
ALTER TABLE public.user_stats
  ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS admin_purchased_at TIMESTAMPTZ;

-- Create index for admin queries
CREATE INDEX IF NOT EXISTS idx_user_stats_is_admin ON public.user_stats(is_admin);

-- Add RLS policy for admin updates
CREATE POLICY "users_can_update_own_admin_status" ON public.user_stats
  FOR UPDATE USING (auth.uid() = user_id);

-- Create function to check if user is admin
CREATE OR REPLACE FUNCTION public.is_user_admin(p_user_id uuid)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.user_stats
    WHERE user_id = p_user_id AND is_admin = true
  );
END;
$$;

-- Grant execute on admin function
GRANT EXECUTE ON FUNCTION public.is_user_admin(uuid) TO authenticated;

-- Comment to document admin system
COMMENT ON COLUMN public.user_stats.is_admin IS 'Admin status: bypasses all restrictions (premium, level, coins, xp)';
COMMENT ON COLUMN public.user_stats.admin_purchased_at IS 'Timestamp when admin access was purchased';

-- Update shop_items table to allow admin_pass type
ALTER TABLE public.shop_items
  DROP CONSTRAINT IF EXISTS shop_items_type_check;

-- Insert Admin Pass shop item ($10,000)
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(
  gen_random_uuid(),
  'admin_pass',
  'Admin Pass',
  'Ultimate power: Access to ALL features, infinite coins, max level (1000), and complete bypass of all restrictions. Premium, level requirements, and coin costs are ignored.',
  10000,
  false,
  1,
  'godly',
  '👑',
  '{
    "type": "admin_pass",
    "benefits": ["infinite_coins", "max_level", "bypass_premium", "bypass_level", "bypass_coins"],
    "coins": "infinite",
    "level": 1000,
    "special_features": ["admin_panel", "god_mode"]
  }'::jsonb
)
ON CONFLICT DO NOTHING;
