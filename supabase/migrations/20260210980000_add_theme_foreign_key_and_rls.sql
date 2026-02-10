-- Fix theme loading by cleaning up data and adding foreign key constraints
-- This fixes the 400 Bad Request error when loading equipped themes

-- Step 1: Clear invalid equipped_theme values
DO $$
DECLARE
  invalid_count INTEGER;
BEGIN
  DELETE FROM public.profiles
  WHERE equipped_theme IS NOT NULL
    AND equipped_theme NOT IN (SELECT id FROM public.shop_items WHERE type = 'theme');

  GET DIAGNOSTICS invalid_count = ROW_COUNT;
  RAISE NOTICE 'Cleared % invalid equipped_theme values', invalid_count;
END $$;

-- Step 2: Drop existing foreign key constraints if they exist
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'profiles_equipped_theme_fkey'
  ) THEN
    ALTER TABLE public.profiles DROP CONSTRAINT profiles_equipped_theme_fkey;
    RAISE NOTICE 'Dropped existing profiles_equipped_theme_fkey';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'profiles_equipped_avatar_fkey'
  ) THEN
    ALTER TABLE public.profiles DROP CONSTRAINT profiles_equipped_avatar_fkey;
    RAISE NOTICE 'Dropped existing profiles_equipped_avatar_fkey';
  END IF;
END $$;

-- Step 3: Add foreign key constraint for equipped_theme
ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_equipped_theme_fkey
  FOREIGN KEY (equipped_theme)
  REFERENCES public.shop_items(id)
  ON DELETE SET NULL;

-- Step 4: Add foreign key for equipped_avatar
ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_equipped_avatar_fkey
  FOREIGN KEY (equipped_avatar)
  REFERENCES public.shop_items(id)
  ON DELETE SET NULL;

-- Step 5: RLS policies for shop_items
DROP POLICY IF EXISTS "Allow authenticated to read shop_items" ON public.shop_items;

CREATE POLICY "Allow authenticated to read shop_items"
ON public.shop_items
FOR SELECT
TO authenticated
USING (true);

-- Step 6: Ensure RLS is enabled
ALTER TABLE public.shop_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Add helpful comments
COMMENT ON CONSTRAINT profiles_equipped_theme_fkey ON public.profiles IS 'Links equipped theme to shop_items. SET NULL on delete for safety.';
COMMENT ON CONSTRAINT profiles_equipped_avatar_fkey ON public.profiles IS 'Links equipped avatar to shop_items. SET NULL on delete for safety.';
