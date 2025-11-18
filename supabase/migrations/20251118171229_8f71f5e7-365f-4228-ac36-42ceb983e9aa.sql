-- Create courses table
CREATE TABLE public.courses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  description text,
  category text,
  created_at timestamptz DEFAULT now()
);

-- Create lessons table
CREATE TABLE public.lessons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id uuid REFERENCES public.courses(id) ON DELETE CASCADE,
  slug text NOT NULL,
  title text NOT NULL,
  content text,
  animations jsonb DEFAULT '[]'::jsonb,
  examples jsonb DEFAULT '[]'::jsonb,
  quiz jsonb DEFAULT '{}'::jsonb,
  order_index integer DEFAULT 0,
  xp_reward integer DEFAULT 10,
  created_at timestamptz DEFAULT now(),
  UNIQUE(course_id, slug)
);

-- Create challenges table
CREATE TABLE public.challenges (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text,
  related_lesson uuid REFERENCES public.lessons(id),
  difficulty text,
  xp_reward integer DEFAULT 0,
  payload jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

-- Create progress status enum
CREATE TYPE public.progress_status AS ENUM ('not_started','in_progress','completed');

-- Create user_progress table
CREATE TABLE public.user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id uuid NOT NULL REFERENCES public.lessons(id) ON DELETE CASCADE,
  status public.progress_status DEFAULT 'not_started',
  score integer DEFAULT 0,
  xp_earned integer DEFAULT 0,
  last_practiced timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, lesson_id)
);

-- Create user_stats table
CREATE TABLE public.user_stats (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  credits integer DEFAULT 5,
  questions_asked integer DEFAULT 0,
  streak integer DEFAULT 0,
  xp_total integer DEFAULT 0,
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on all tables
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_stats ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Public read for courses and lessons
CREATE POLICY "public_select_courses" ON public.courses 
  FOR SELECT USING (true);

CREATE POLICY "public_select_lessons" ON public.lessons 
  FOR SELECT USING (true);

CREATE POLICY "public_select_challenges" ON public.challenges 
  FOR SELECT USING (true);

-- RLS Policies: User-only access for progress and stats
CREATE POLICY "user_progress_select" ON public.user_progress
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "user_progress_insert" ON public.user_progress
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_progress_update" ON public.user_progress
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "user_stats_select" ON public.user_stats
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "user_stats_insert" ON public.user_stats
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_stats_update" ON public.user_stats
  FOR UPDATE USING (auth.uid() = user_id);

-- Create trigger to auto-create user_stats on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user_stats()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.user_stats (user_id)
  VALUES (NEW.id)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created_stats
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user_stats();