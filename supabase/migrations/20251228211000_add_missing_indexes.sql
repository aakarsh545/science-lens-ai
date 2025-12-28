-- Add Missing Performance Indexes
-- This migration adds any missing indexes that weren't created in the optimization migration

-- Lessons table indexes
CREATE INDEX IF NOT EXISTS idx_lessons_slug ON public.lessons(slug);
CREATE INDEX IF NOT EXISTS idx_lessons_course_id ON public.lessons(course_id);

-- Courses table indexes
CREATE INDEX IF NOT EXISTS idx_courses_slug ON public.courses(slug);
CREATE INDEX IF NOT EXISTS idx_courses_category ON public.courses(category);

-- User progress indexes
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON public.user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson_id ON public.user_progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_status ON public.user_progress(status);

-- User topic progress indexes
CREATE INDEX IF NOT EXISTS idx_user_topic_progress_user_id ON public.user_topic_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_topic_progress_topic_id ON public.user_topic_progress(topic_id);

-- Profiles table indexes
CREATE INDEX IF NOT EXISTS idx_profiles_display_name ON public.profiles(display_name);
CREATE INDEX IF NOT EXISTS idx_profiles_level ON public.profiles(level);
CREATE INDEX IF NOT EXISTS idx_profiles_user_id ON public.profiles(user_id);

-- Challenge sessions indexes
CREATE INDEX IF NOT EXISTS idx_challenge_sessions_completed_at ON public.challenge_sessions(completed_at);

-- Learning topics indexes
CREATE INDEX IF NOT EXISTS idx_learning_topics_category ON public.learning_topics(category);
CREATE INDEX IF NOT EXISTS idx_learning_topics_difficulty_level ON public.learning_topics(difficulty_level);

-- Challenges indexes
CREATE INDEX IF NOT EXISTS idx_challenges_related_lesson ON public.challenges(related_lesson);
