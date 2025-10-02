-- Create learning topics table
CREATE TABLE public.learning_topics (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  description TEXT,
  difficulty_level TEXT DEFAULT 'beginner',
  icon TEXT,
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create user topic progress table
CREATE TABLE public.user_topic_progress (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  topic_id UUID NOT NULL REFERENCES public.learning_topics(id) ON DELETE CASCADE,
  questions_answered INTEGER DEFAULT 0,
  correct_answers INTEGER DEFAULT 0,
  completion_percentage INTEGER DEFAULT 0,
  last_practiced_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, topic_id)
);

-- Create bookmarks table
CREATE TABLE public.bookmarks (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, question_id)
);

-- Create study sessions table
CREATE TABLE public.study_sessions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  topic_id UUID REFERENCES public.learning_topics(id) ON DELETE SET NULL,
  duration_minutes INTEGER DEFAULT 0,
  questions_answered INTEGER DEFAULT 0,
  xp_earned INTEGER DEFAULT 0,
  started_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  ended_at TIMESTAMP WITH TIME ZONE
);

-- Enable RLS
ALTER TABLE public.learning_topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_topic_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_sessions ENABLE ROW LEVEL SECURITY;

-- Policies for learning_topics (public read)
CREATE POLICY "Anyone can view learning topics"
ON public.learning_topics
FOR SELECT
USING (true);

-- Policies for user_topic_progress
CREATE POLICY "Users can view their own progress"
ON public.user_topic_progress
FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own progress"
ON public.user_topic_progress
FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own progress"
ON public.user_topic_progress
FOR UPDATE
USING (auth.uid() = user_id);

-- Policies for bookmarks
CREATE POLICY "Users can view their own bookmarks"
ON public.bookmarks
FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own bookmarks"
ON public.bookmarks
FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own bookmarks"
ON public.bookmarks
FOR DELETE
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookmarks"
ON public.bookmarks
FOR UPDATE
USING (auth.uid() = user_id);

-- Policies for study_sessions
CREATE POLICY "Users can view their own sessions"
ON public.study_sessions
FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own sessions"
ON public.study_sessions
FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own sessions"
ON public.study_sessions
FOR UPDATE
USING (auth.uid() = user_id);

-- Trigger for user_topic_progress updates
CREATE TRIGGER update_user_topic_progress_updated_at
BEFORE UPDATE ON public.user_topic_progress
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Insert default learning topics
INSERT INTO public.learning_topics (name, category, description, difficulty_level, icon, order_index) VALUES
('Basic Physics', 'physics', 'Fundamental concepts of motion, forces, and energy', 'beginner', '⚛️', 1),
('Quantum Mechanics', 'physics', 'Explore the quantum world and particle behavior', 'advanced', '🔬', 2),
('Chemistry Basics', 'chemistry', 'Elements, compounds, and chemical reactions', 'beginner', '🧪', 3),
('Organic Chemistry', 'chemistry', 'Carbon-based molecules and their reactions', 'intermediate', '⚗️', 4),
('Cell Biology', 'biology', 'Structure and function of living cells', 'beginner', '🦠', 5),
('Genetics', 'biology', 'DNA, genes, and heredity', 'intermediate', '🧬', 6),
('Astronomy', 'physics', 'Stars, planets, and the universe', 'beginner', '🌌', 7),
('Thermodynamics', 'physics', 'Heat, energy, and entropy', 'intermediate', '🌡️', 8),
('Ecology', 'biology', 'Ecosystems and environmental interactions', 'beginner', '🌿', 9),
('Biochemistry', 'chemistry', 'Chemical processes in living organisms', 'advanced', '🔬', 10);