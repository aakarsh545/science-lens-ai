-- Allow anon key to read quizzes (for frontend)
DROP POLICY IF EXISTS "Allow authenticated users to read course quizzes" ON course_quizzes;
CREATE POLICY "Allow authenticated users to read course quizzes"
ON course_quizzes FOR SELECT
TO authenticated
USING (true);

-- Also allow anon for testing
DROP POLICY IF EXISTS "Allow anon to read course quizzes" ON course_quizzes;
CREATE POLICY "Allow anon to read course quizzes"
ON course_quizzes FOR SELECT
TO anon
USING (true);
