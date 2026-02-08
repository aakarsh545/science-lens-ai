-- Allow anon key to insert quizzes (for quiz generation script)
DROP POLICY IF EXISTS "Allow anon to insert course quizzes" ON course_quizzes;
CREATE POLICY "Allow anon to insert course quizzes"
ON course_quizzes FOR INSERT
TO anon
WITH CHECK (true);
