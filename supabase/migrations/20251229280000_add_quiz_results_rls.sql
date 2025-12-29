-- Enable Row Level Security on quiz_results table
ALTER TABLE public.quiz_results ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (for clean migration)
DROP POLICY IF EXISTS "Users can view their own quiz results" ON public.quiz_results;
DROP POLICY IF EXISTS "Users can insert their own quiz results" ON public.quiz_results;
DROP POLICY IF EXISTS "Users can update their own quiz results" ON public.quiz_results;
DROP POLICY IF EXISTS "Users can delete their own quiz results" ON public.quiz_results;
DROP POLICY IF EXISTS "Service role can bypass RLS" ON public.quiz_results;

-- Policy: Users can view their own quiz results
CREATE POLICY "Users can view their own quiz results"
ON public.quiz_results
FOR SELECT
USING (auth.uid() = user_id);

-- Policy: Users can insert their own quiz results
CREATE POLICY "Users can insert their own quiz results"
ON public.quiz_results
FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can update their own quiz results
CREATE POLICY "Users can update their own quiz results"
ON public.quiz_results
FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can delete their own quiz results
CREATE POLICY "Users can delete their own quiz results"
ON public.quiz_results
FOR DELETE
USING (auth.uid() = user_id);

-- Policy: Service role can bypass RLS for system operations
CREATE POLICY "Service role can bypass RLS"
ON public.quiz_results
FOR ALL
TO service_role
USING (true)
WITH CHECK (true);

-- Add comment for documentation
COMMENT ON TABLE public.quiz_results IS 'Stores detailed results from quiz attempts - RLS enabled';
