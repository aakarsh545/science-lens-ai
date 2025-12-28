-- Fix function permissions for authenticated users
-- Grant execute on refresh_daily_credits to authenticated users
GRANT EXECUTE ON FUNCTION public.refresh_daily_credits(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION public.auto_refresh_daily_credits() TO authenticated;
