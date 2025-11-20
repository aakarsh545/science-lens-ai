-- Create trigger function to protect fields from client updates
CREATE OR REPLACE FUNCTION public.protect_profile_fields()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Only allow updates to credits and streak_count from clients
  -- All other fields (xp_points, level, total_questions) can only be updated by backend
  IF (OLD.xp_points IS DISTINCT FROM NEW.xp_points AND 
      current_setting('request.jwt.claims', true)::json->>'role' != 'service_role') THEN
    NEW.xp_points := OLD.xp_points;
  END IF;
  
  IF (OLD.level IS DISTINCT FROM NEW.level AND 
      current_setting('request.jwt.claims', true)::json->>'role' != 'service_role') THEN
    NEW.level := OLD.level;
  END IF;
  
  IF (OLD.total_questions IS DISTINCT FROM NEW.total_questions AND 
      current_setting('request.jwt.claims', true)::json->>'role' != 'service_role') THEN
    NEW.total_questions := OLD.total_questions;
  END IF;

  RETURN NEW;
END;
$$;

-- Create trigger for profiles table
DROP TRIGGER IF EXISTS protect_profile_fields_trigger ON public.profiles;
CREATE TRIGGER protect_profile_fields_trigger
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.protect_profile_fields();

-- Create trigger function to protect user_stats fields
CREATE OR REPLACE FUNCTION public.protect_user_stats_fields()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  -- Only allow updates to credits and streak from clients
  -- questions_asked and xp_total can only be updated by backend
  IF (OLD.questions_asked IS DISTINCT FROM NEW.questions_asked AND 
      current_setting('request.jwt.claims', true)::json->>'role' != 'service_role') THEN
    NEW.questions_asked := OLD.questions_asked;
  END IF;
  
  IF (OLD.xp_total IS DISTINCT FROM NEW.xp_total AND 
      current_setting('request.jwt.claims', true)::json->>'role' != 'service_role') THEN
    NEW.xp_total := OLD.xp_total;
  END IF;

  RETURN NEW;
END;
$$;

-- Create trigger for user_stats table
DROP TRIGGER IF EXISTS protect_user_stats_fields_trigger ON public.user_stats;
CREATE TRIGGER protect_user_stats_fields_trigger
  BEFORE UPDATE ON public.user_stats
  FOR EACH ROW
  EXECUTE FUNCTION public.protect_user_stats_fields();

-- Remove update permission on user_progress (only backend can modify)
DROP POLICY IF EXISTS "user_progress_update" ON public.user_progress;