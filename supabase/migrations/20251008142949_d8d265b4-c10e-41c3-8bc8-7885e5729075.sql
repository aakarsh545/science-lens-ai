-- Add credits column to profiles for gamification
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS credits integer DEFAULT 0;

-- Add index on conversations for faster queries
CREATE INDEX IF NOT EXISTS idx_conversations_user_updated ON public.conversations(user_id, updated_at DESC);

-- Enable realtime for conversations table
ALTER PUBLICATION supabase_realtime ADD TABLE public.conversations;