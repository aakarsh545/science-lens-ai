-- Simple Admin System
-- Just toggle is_admin to true in Supabase to grant admin powers

-- Add is_admin column to profiles table (for easy access)
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT false;

-- Create function to grant admin privileges
CREATE OR REPLACE FUNCTION public.grant_admin_privileges(p_user_id uuid)
RETURNS void AS $$
BEGIN
  -- Set max level
  UPDATE public.profiles
  SET level = 1000,
      xp_points = 100000,
      coins = 999999999,
      is_premium = true
  WHERE user_id = p_user_id;

  -- Add all shop items to inventory (themes, avatars, etc)
  INSERT INTO public.user_inventory (user_id, item_id)
  SELECT p_user_id, id
  FROM public.shop_items
  ON CONFLICT (user_id, item_id) DO NOTHING;

  -- Set admin flag in user_stats too
  UPDATE public.user_stats
  SET is_admin = true
  WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger: when is_admin is set to true, auto-grant all privileges
CREATE OR REPLACE FUNCTION public.handle_admin_toggle()
RETURNS trigger AS $$
BEGIN
  IF NEW.is_admin = true AND (OLD.is_admin IS NULL OR OLD.is_admin = false) THEN
    -- Admin status granted: give all privileges
    PERFORM public.grant_admin_privileges(NEW.user_id);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop trigger if exists
DROP TRIGGER IF EXISTS on_admin_toggle ON public.profiles;

-- Create trigger
CREATE TRIGGER on_admin_toggle
  AFTER UPDATE OF is_admin ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_admin_toggle();

-- Create index for admin queries
CREATE INDEX IF NOT EXISTS idx_profiles_is_admin ON public.profiles(is_admin);

-- Grant execute on functions
GRANT EXECUTE ON FUNCTION public.grant_admin_privileges(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.handle_admin_toggle() TO authenticated;

-- Add helpful comment
COMMENT ON COLUMN public.profiles.is_admin IS 'Admin flag: Set to TRUE in Supabase to grant level 1000, infinite coins, all themes/avatars. No code changes needed.';

-- Instructions for use
/*
HOW TO MAKE ANY USER AN ADMIN:

1. Go to Supabase Dashboard → Table Editor
2. Open the "profiles" table
3. Find the user you want to make admin
4. Set the "is_admin" column to TRUE (checkbox)
5. Save

That's it! The user will immediately have:
- Level 1000
- 999,999,999 coins
- All themes and avatars
- Premium status
- All restrictions bypassed

To remove admin: Set is_admin back to FALSE
*/
