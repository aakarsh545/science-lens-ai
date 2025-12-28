-- Add Coins and Premium System to User Profiles
-- This migration adds the foundation for the premium economy

-- Add coins and premium columns to profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS coins INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS is_premium BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS equipped_theme UUID,
  ADD COLUMN IF NOT EXISTS equipped_avatar UUID;

-- Create coin transactions table
CREATE TABLE IF NOT EXISTS public.coin_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  amount INTEGER NOT NULL,
  source TEXT NOT NULL, -- 'lesson', 'challenge', 'achievement', 'daily_streak', 'quiz_perfect'
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add indexes for coin transactions
CREATE INDEX IF NOT EXISTS idx_coin_transactions_user
  ON public.coin_transactions(user_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_coin_transactions_source
  ON public.coin_transactions(source);

-- Add comment for documentation
COMMENT ON TABLE public.coin_transactions IS 'Tracks all coin earning and spending transactions';
COMMENT ON COLUMN public.coin_transactions.amount IS 'Positive for earning, negative for spending';
COMMENT ON COLUMN public.coin_transactions.source IS 'Type of transaction: lesson, challenge, achievement, daily_streak, quiz_perfect, purchase';
