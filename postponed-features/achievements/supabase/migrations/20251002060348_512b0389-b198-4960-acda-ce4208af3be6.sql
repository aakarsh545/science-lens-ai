-- Create profiles table for user data
CREATE TABLE public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  streak_count INTEGER DEFAULT 0,
  total_questions INTEGER DEFAULT 0,
  level INTEGER DEFAULT 1,
  xp_points INTEGER DEFAULT 0,
  current_topic TEXT DEFAULT 'basic_physics',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create questions table
CREATE TABLE public.questions (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_text TEXT NOT NULL,
  ai_response TEXT,
  topic TEXT NOT NULL,
  difficulty_level TEXT DEFAULT 'beginner',
  is_correct BOOLEAN DEFAULT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create achievements table
CREATE TABLE public.achievements (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  achievement_type TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  earned_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, achievement_type)
);

-- Create daily_streaks table
CREATE TABLE public.daily_streaks (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  questions_answered INTEGER DEFAULT 0,
  streak_maintained BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, date)
);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_streaks ENABLE ROW LEVEL SECURITY;

-- Create policies for profiles
CREATE POLICY "Users can view their own profile" 
ON public.profiles 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile" 
ON public.profiles 
FOR UPDATE 
USING (auth.uid() = user_id);

-- Create policies for questions
CREATE POLICY "Users can view their own questions" 
ON public.questions 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own questions" 
ON public.questions 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Create policies for achievements
CREATE POLICY "Users can view their own achievements" 
ON public.achievements 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own achievements" 
ON public.achievements 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Create policies for daily_streaks
CREATE POLICY "Users can view their own streaks" 
ON public.daily_streaks 
FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own streaks" 
ON public.daily_streaks 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own streaks" 
ON public.daily_streaks 
FOR UPDATE 
USING (auth.uid() = user_id);

-- Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
NEW.updated_at = now();
RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Create trigger for automatic timestamp updates
CREATE TRIGGER update_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- Create function to update streak
CREATE OR REPLACE FUNCTION public.update_user_streak()
RETURNS TRIGGER AS $$
DECLARE
  current_streak INTEGER;
  today_questions INTEGER;
BEGIN
  -- Get today's question count
  SELECT questions_answered INTO today_questions
  FROM public.daily_streaks
  WHERE user_id = NEW.user_id AND date = CURRENT_DATE;
  
  -- If no record for today, create one
  IF today_questions IS NULL THEN
    INSERT INTO public.daily_streaks (user_id, date, questions_answered, streak_maintained)
    VALUES (NEW.user_id, CURRENT_DATE, 1, TRUE)
    ON CONFLICT (user_id, date) 
    DO UPDATE SET questions_answered = daily_streaks.questions_answered + 1;
  ELSE
    -- Update today's count
    UPDATE public.daily_streaks 
    SET questions_answered = questions_answered + 1,
        streak_maintained = TRUE
    WHERE user_id = NEW.user_id AND date = CURRENT_DATE;
  END IF;
  
  -- Update profile streak count
  SELECT COUNT(*) INTO current_streak
  FROM public.daily_streaks
  WHERE user_id = NEW.user_id 
    AND streak_maintained = TRUE
    AND date >= CURRENT_DATE - INTERVAL '30 days'
    AND date <= CURRENT_DATE;
    
  UPDATE public.profiles 
  SET streak_count = current_streak,
      total_questions = total_questions + 1,
      xp_points = xp_points + 10
  WHERE user_id = NEW.user_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Create trigger for streak updates
CREATE TRIGGER update_streak_on_question
AFTER INSERT ON public.questions
FOR EACH ROW
EXECUTE FUNCTION public.update_user_streak();