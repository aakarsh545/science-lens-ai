-- Create Shop System Tables
-- This migration creates the virtual shop for themes and avatars

-- Create shop items table
CREATE TABLE IF NOT EXISTS public.shop_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('theme', 'avatar')),
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  price INTEGER NOT NULL DEFAULT 0,
  is_premium_exclusive BOOLEAN DEFAULT false,
  icon_emoji TEXT,
  metadata JSONB DEFAULT '{}'::jsonb, -- theme colors, avatar config
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create user inventory table
CREATE TABLE IF NOT EXISTS public.user_inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  item_id UUID REFERENCES public.shop_items(id) ON DELETE CASCADE NOT NULL,
  purchased_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, item_id)
);

-- Add indexes for shop
CREATE INDEX IF NOT EXISTS idx_shop_items_type ON public.shop_items(type);
CREATE INDEX IF NOT EXISTS idx_shop_items_price ON public.shop_items(price);
CREATE INDEX IF NOT EXISTS idx_user_inventory_user ON public.user_inventory(user_id);
CREATE INDEX IF NOT EXISTS idx_user_inventory_item ON public.user_inventory(item_id);

-- Add comments
COMMENT ON TABLE public.shop_items IS 'Virtual shop items (themes and avatars)';
COMMENT ON TABLE public.user_inventory IS 'User purchased items from shop';
COMMENT ON COLUMN public.shop_items.type IS 'Item type: theme or avatar';
COMMENT ON COLUMN public.shop_items.price IS 'Cost in coins';
COMMENT ON COLUMN public.shop_items.is_premium_exclusive IS 'Only available to premium users';
