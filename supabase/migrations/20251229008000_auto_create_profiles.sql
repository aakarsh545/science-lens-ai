-- Auto-create profile when user signs up
-- This ensures every auth.user has a corresponding profiles row

-- First, create profiles for existing users who don't have one
INSERT INTO public.profiles (user_id, display_name, avatar_url, coins, is_premium, level)
SELECT
  id,
  COALESCE(raw_user_meta_data->>'full_name', raw_user_meta_data->>'name', 'User'),
  raw_user_meta_data->>'avatar_url',
  100, -- Starting coins
  false, -- Not premium by default
  1 -- Starting level
FROM auth.users
WHERE NOT EXISTS (
  SELECT 1 FROM public.profiles WHERE public.profiles.user_id = auth.users.id
);

-- Function to handle new user creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (user_id, display_name, avatar_url, coins, is_premium, level)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', 'User'),
    NEW.raw_user_meta_data->>'avatar_url',
    100, -- Starting coins
    false, -- Not premium by default
    1 -- Starting level
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Create trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();
