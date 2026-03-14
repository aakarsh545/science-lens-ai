-- Allow reading profiles (needed for username availability checks during onboarding).
-- NOTE: Postgres RLS policies are row-level, not column-level. This makes the entire profiles row selectable.
-- If you want to expose only usernames, consider a dedicated view/table + policy instead.

-- Replace the existing "own profile only" SELECT policy with a broader read policy.
DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
DROP POLICY IF EXISTS "usernames are publicly readable" ON public.profiles;

CREATE POLICY "Profiles are viewable by everyone"
ON public.profiles
FOR SELECT
TO authenticated
USING (true);

-- IMPORTANT: Do NOT use auth.uid() = id for UPDATE policies.
-- auth.uid() matches profiles.user_id (FK to auth.users.id), not profiles.id (random UUID PK).

