-- Ensure all users have coins in their profile
-- This migration updates any profiles that have NULL or 0 coins to have starting coins

-- Update profiles that have NULL coins to 100 starting coins
UPDATE public.profiles
SET coins = 100
WHERE coins IS NULL OR coins = 0;

-- Ensure the coins column has a default value
ALTER TABLE public.profiles
ALTER COLUMN coins SET DEFAULT 100;

-- Add a check to ensure coins is never NULL
ALTER TABLE public.profiles
ALTER COLUMN coins SET NOT NULL;
