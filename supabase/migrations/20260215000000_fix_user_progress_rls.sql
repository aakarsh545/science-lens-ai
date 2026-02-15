-- Fix RLS policies for user_progress table to allow upsert operations
-- This fixes the 403 error when saving onboarding data

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Users can view their own progress" ON user_progress;
DROP POLICY IF EXISTS "Users can insert their own progress" ON user_progress;
DROP POLICY IF EXISTS "Users can update their own progress" ON user_progress;
DROP POLICY IF EXISTS "Users can delete their own progress" ON user_progress;

-- Create comprehensive RLS policies for user_progress

-- Policy: Users can view their own progress
CREATE POLICY "Users can view their own progress"
ON user_progress
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- Policy: Users can insert their own progress (needed for onboarding)
CREATE POLICY "Users can insert their own progress"
ON user_progress
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can update their own progress
CREATE POLICY "Users can update their own progress"
ON user_progress
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can delete their own progress
CREATE POLICY "Users can delete their own progress"
ON user_progress
FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- Grant necessary permissions
GRANT SELECT ON user_progress TO authenticated;
GRANT INSERT ON user_progress TO authenticated;
GRANT UPDATE ON user_progress TO authenticated;
GRANT DELETE ON user_progress TO authenticated;
