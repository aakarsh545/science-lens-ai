-- Add unique username field
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS username TEXT;

-- Create unique index on username
CREATE UNIQUE INDEX IF NOT EXISTS idx_profiles_username ON public.profiles(username);

-- Add comment
COMMENT ON COLUMN public.profiles.username IS 'Unique username for user identification and display';
