-- Fix RLS policies for course_quizzes to allow inserts
DROP POLICY IF EXISTS "Allow service role to manage course quizzes" ON course_quizzes;
CREATE POLICY "Allow service role to manage course quizzes"
ON course_quizzes FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

-- Also allow authenticated users to insert (for testing)
DROP POLICY IF EXISTS "Allow authenticated to insert course quizzes" ON course_quizzes;
CREATE POLICY "Allow authenticated to insert course quizzes"
ON course_quizzes FOR INSERT
TO authenticated
WITH CHECK (true);
