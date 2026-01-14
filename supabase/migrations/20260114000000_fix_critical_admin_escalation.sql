-- CRITICAL SECURITY FIX: Admin Self-Grant Vulnerability
-- Date: 2026-01-14
-- Severity: CRITICAL
--
-- VULNERABILITY: Users could grant themselves admin privileges by updating their own is_admin field
--
-- BEFORE (INSECURE):
-- CREATE POLICY "users_can_update_own_admin_status" ON public.user_stats
--   FOR UPDATE USING (auth.uid() = user_id);
--
-- CREATE POLICY "Users can update their own profile" ON public.profiles
--   FOR UPDATE USING (auth.uid() = user_id);
--
-- ATTACK VECTORS:
-- 1. await supabase.from('user_stats').update({ is_admin: true }).eq('user_id', myId);
-- 2. await supabase.from('profiles').update({ is_admin: true }).eq('user_id', myId);
--
-- FIX: Create secure policies that prevent users from modifying their own admin status
-- Admin status can only be modified by:
-- 1. Service role (via Supabase Dashboard or server-side code)
-- 2. Edge functions using service role key

-- ============================================================================
-- STEP 1: Drop dangerous policy from user_stats table
-- ============================================================================

DROP POLICY IF EXISTS "users_can_update_own_admin_status" ON public.user_stats;

-- ============================================================================
-- STEP 2: Create secure admin-only policies
-- ============================================================================

-- Policy for user_stats: Block normal users from modifying is_admin
CREATE POLICY "block_users_from_modifying_admin_status_in_user_stats"
ON public.user_stats
FOR UPDATE
WITH CHECK (
  -- Allow update if NOT changing is_admin
  (COALESCE(OLD.is_admin, false) = COALESCE(NEW.is_admin, false)) OR
  -- OR if user is service role (bypasses RLS)
  -- Note: Service role key bypasses RLS entirely, so this check is for authenticated users
  false
);

-- Alternative approach: Use a trigger to prevent admin self-grant
CREATE OR REPLACE FUNCTION public.prevent_admin_self_grant()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if is_admin is being changed from false/null to true
  IF (OLD.is_admin IS NULL OR OLD.is_admin = false) AND NEW.is_admin = true THEN
    -- Check if the user is trying to modify their own admin status
    IF auth.uid() = NEW.user_id THEN
      RAISE EXCEPTION 'Users cannot grant themselves admin privileges';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger on user_stats
DROP TRIGGER IF EXISTS prevent_admin_self_grant_trigger ON public.user_stats;
CREATE TRIGGER prevent_admin_self_grant_trigger
  BEFORE UPDATE ON public.user_stats
  FOR EACH ROW
  EXECUTE FUNCTION public.prevent_admin_self_grant();

-- ============================================================================
-- STEP 3: Fix profiles table - prevent users from modifying their own is_admin
-- ============================================================================

-- Drop and recreate the profiles UPDATE policy with admin protection
DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;

-- Create new policy that prevents admin self-grant
CREATE POLICY "Users can update their own profile (except admin status)"
ON public.profiles
FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (
  -- Allow update if NOT changing is_admin
  (COALESCE(OLD.is_admin, false) = COALESCE(NEW.is_admin, false)) OR
  -- Deny if trying to change is_admin (prevents self-grant)
  (OLD.is_admin = NEW.is_admin)
);

-- Add trigger for profiles table as well
CREATE OR REPLACE FUNCTION public.prevent_admin_self_grant_profiles()
RETURNS TRIGGER AS $$
BEGIN
  -- Check if is_admin is being changed from false/null to true
  IF (OLD.is_admin IS NULL OR OLD.is_admin = false) AND NEW.is_admin = true THEN
    -- Check if the user is trying to modify their own admin status
    IF auth.uid() = NEW.user_id THEN
      RAISE EXCEPTION 'Users cannot grant themselves admin privileges in profiles table';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger on profiles
DROP TRIGGER IF EXISTS prevent_admin_self_grant_trigger_profiles ON public.profiles;
CREATE TRIGGER prevent_admin_self_grant_trigger_profiles
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.prevent_admin_self_grant_profiles();

-- ============================================================================
-- STEP 4: Document the fix
-- ============================================================================

COMMENT ON FUNCTION public.prevent_admin_self_grant() IS 'Security trigger: Prevents users from granting themselves admin privileges in user_stats table';
COMMENT ON FUNCTION public.prevent_admin_self_grant_profiles() IS 'Security trigger: Prevents users from granting themselves admin privileges in profiles table';
COMMENT ON POLICY "block_users_from_modifying_admin_status_in_user_stats" ON public.user_stats IS 'Security policy: Prevents users from modifying their own admin status';
COMMENT ON POLICY "Users can update their own profile (except admin status)" ON public.profiles IS 'Security policy: Users can update their profile but cannot grant themselves admin privileges';

-- ============================================================================
-- VERIFICATION QUERY
-- ============================================================================
-- After running this migration, verify it works by testing:
--
-- Test 1: Try to update own admin status (should FAIL)
-- UPDATE public.user_stats SET is_admin = true WHERE user_id = 'your-user-id';
-- Expected: ERROR: Users cannot grant themselves admin privileges
--
-- Test 2: Update non-admin fields (should SUCCEED)
-- UPDATE public.profiles SET display_name = 'Test' WHERE user_id = 'your-user-id';
-- Expected: SUCCESS
--
-- Test 3: Service role can still modify admin (should SUCCEED)
-- Run in Supabase Dashboard with service role privileges:
-- UPDATE public.profiles SET is_admin = true WHERE user_id = 'target-user-id';
-- Expected: SUCCESS
