-- Fix RLS policies for courses to allow public read
DROP POLICY IF EXISTS "public_select_courses" ON public.courses;
CREATE POLICY "public_select_courses" ON public.courses
  FOR SELECT USING (true);
