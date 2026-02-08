-- Add rarity and thumbnail_url columns to shop_items
-- This enables premium theme shop with rarity tiers

-- Add rarity column
ALTER TABLE public.shop_items
ADD COLUMN IF NOT EXISTS rarity TEXT DEFAULT 'common'
CHECK (rarity IN ('common', 'rare', 'epic', 'legendary', 'mythical'));

-- Add thumbnail_url column
ALTER TABLE public.shop_items
ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;

-- Add index for rarity sorting
CREATE INDEX IF NOT EXISTS idx_shop_items_rarity ON public.shop_items(rarity);

-- Comment on columns
COMMENT ON COLUMN public.shop_items.rarity IS 'Theme rarity: common, rare, epic, legendary, mythical';
COMMENT ON COLUMN public.shop_items.thumbnail_url IS 'URL to theme preview/thumbnail image';
