-- Add original_state column to save user state before admin
ALTER TABLE public.user_stats
  ADD COLUMN IF NOT EXISTS original_state JSONB;

-- Add comment
COMMENT ON COLUMN public.user_stats.original_state IS 'Stores user state (level, coins, etc) before admin was granted, so it can be restored when admin is revoked';
