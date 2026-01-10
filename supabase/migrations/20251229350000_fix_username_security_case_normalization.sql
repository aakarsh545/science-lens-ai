-- SECURITY FIX: Prevent username impersonation attacks
-- Add explicit auth.uid() == p_user_id check to prevent users from updating others' usernames

CREATE OR REPLACE FUNCTION public.update_username(
  p_user_id UUID,
  p_new_username TEXT
)
RETURNS JSON AS $$
DECLARE
  current_username TEXT;
  is_taken BOOLEAN;
  error_msg JSON;
  normalized_username TEXT;
BEGIN
  -- SECURITY CRITICAL: Verify the authenticated user is updating THEIR OWN username
  -- Without this check, any authenticated user could update ANY user's username
  IF auth.uid() IS NULL THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Not authenticated'
    );
    RETURN error_msg;
  END IF;

  IF auth.uid() != p_user_id THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Unauthorized: You can only update your own username'
    );
    RETURN error_msg;
  END IF;

  -- DATA MODEL FIX: Normalize username to lowercase for consistency
  -- This ensures "User123" and "user123" are treated as the same username
  normalized_username := LOWER(TRIM(p_new_username));

  -- Validation 1: Username cannot be empty
  IF normalized_username IS NULL OR normalized_username = '' THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Username cannot be empty'
    );
    RETURN error_msg;
  END IF;

  -- Validation 2: Length limits (3-20 characters)
  IF LENGTH(normalized_username) < 3 OR LENGTH(normalized_username) > 20 THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Username must be between 3 and 20 characters'
    );
    RETURN error_msg;
  END IF;

  -- Validation 3: Allowed characters (letters, numbers, underscores, hyphens only)
  IF normalized_username ~ '[^a-z0-9_-]' THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Username can only contain letters, numbers, underscores, and hyphens'
    );
    RETURN error_msg;
  END IF;

  -- Validation 4: Must start with a letter
  IF normalized_username ~ '^[0-9_-]' THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'Username must start with a letter'
    );
    RETURN error_msg;
  END IF;

  -- Validation 5: Check if username is already taken by another user
  -- Use normalized username for case-insensitive comparison
  SELECT EXISTS(
    SELECT 1 FROM public.profiles
    WHERE LOWER(username) = normalized_username
    AND user_id != p_user_id
  ) INTO is_taken;

  IF is_taken THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'This username is already taken'
    );
    RETURN error_msg;
  END IF;

  -- Validation 6: Reserved usernames (admin, root, system, etc.)
  IF normalized_username IN ('admin', 'root', 'system', 'api', 'www', 'mail', 'ftp', 'support', 'sales', 'marketing', 'info', 'billing', 'security', 'moderator', 'owner') THEN
    error_msg := jsonb_build_object(
      'success', false,
      'error', 'This username is reserved'
    );
    RETURN error_msg;
  END IF;

  -- All validations passed - update username with normalized value
  UPDATE public.profiles
  SET username = normalized_username,
      updated_at = NOW()
  WHERE user_id = p_user_id;

  -- Return success with normalized username
  RETURN jsonb_build_object(
    'success', true,
    'username', normalized_username
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute to authenticated users
GRANT EXECUTE ON FUNCTION public.update_username TO authenticated;

-- Add comment for documentation
COMMENT ON FUNCTION public.update_username IS 'SECURE username update with auth.uid() verification and case normalization. Enforces: ownership check, uniqueness (case-insensitive, 3-20 chars), allowed characters (a-z, 0-9, _, -), must start with letter, and reserves system names. CRITICAL: Prevents impersonation attacks.';
