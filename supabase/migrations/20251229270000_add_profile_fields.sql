-- Add full_name and bio fields to profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS full_name TEXT,
  ADD COLUMN IF NOT EXISTS bio TEXT;

-- Add comments
COMMENT ON COLUMN public.profiles.full_name IS 'User full name for display';
COMMENT ON COLUMN public.profiles.bio IS 'User bio/description (max 150 chars)';
