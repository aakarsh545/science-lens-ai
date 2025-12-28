-- Populate 3-tier challenges for each learning topic
-- This creates beginner, intermediate, and advanced challenges for each topic

-- First, let's update existing challenges to have proper tier data
UPDATE public.challenges
SET
  question_count = 15,
  xp_reward = 100,
  max_hearts = 3,
  estimated_time_minutes = 10
WHERE challenge_level = 'beginner';

UPDATE public.challenges
SET
  question_count = 30,
  xp_reward = 200,
  max_hearts = 3,
  estimated_time_minutes = 20
WHERE challenge_level = 'intermediate';

UPDATE public.challenges
SET
  question_count = 45,
  xp_reward = 500,
  max_hearts = 3,
  estimated_time_minutes = 30
WHERE challenge_level = 'advanced';

-- Now create 3-tier challenges for each learning topic
-- We'll create challenges based on existing learning_topics

-- Physics Challenges
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Physics Fundamentals - Beginner' as title,
  'Test your basic physics knowledge with 15 fundamental questions.' as description,
  'beginner' as challenge_level,
  0 as level_requirement,
  'easy' as difficulty,
  15 as question_count,
  100 as xp_reward,
  3 as max_hearts,
  10 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%physics%' OR LOWER(category) LIKE '%physics%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Physics Mastery - Intermediate' as title,
  'Challenge yourself with 30 intermediate physics questions.' as description,
  'intermediate' as challenge_level,
  10 as level_requirement,
  'medium' as difficulty,
  30 as question_count,
  200 as xp_reward,
  3 as max_hearts,
  20 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%physics%' OR LOWER(category) LIKE '%physics%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Physics Genius - Advanced' as title,
  'Master physics with 45 advanced questions covering complex topics.' as description,
  'advanced' as challenge_level,
  20 as level_requirement,
  'hard' as difficulty,
  45 as question_count,
  500 as xp_reward,
  3 as max_hearts,
  30 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%physics%' OR LOWER(category) LIKE '%physics%'
ON CONFLICT DO NOTHING;

-- Chemistry Challenges
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Chemistry Basics - Beginner' as title,
  'Learn the fundamentals of chemistry with 15 basic questions.' as description,
  'beginner' as challenge_level,
  0 as level_requirement,
  'easy' as difficulty,
  15 as question_count,
  100 as xp_reward,
  3 as max_hearts,
  10 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%chemistry%' OR LOWER(category) LIKE '%chemistry%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Chemistry Concepts - Intermediate' as title,
  'Test your chemistry knowledge with 30 intermediate questions.' as description,
  'intermediate' as challenge_level,
  10 as level_requirement,
  'medium' as difficulty,
  30 as question_count,
  200 as xp_reward,
  3 as max_hearts,
  20 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%chemistry%' OR LOWER(category) LIKE '%chemistry%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Chemistry Expert - Advanced' as title,
  'Challenge yourself with 45 advanced chemistry questions.' as description,
  'advanced' as challenge_level,
  20 as level_requirement,
  'hard' as difficulty,
  45 as question_count,
  500 as xp_reward,
  3 as max_hearts,
  30 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%chemistry%' OR LOWER(category) LIKE '%chemistry%'
ON CONFLICT DO NOTHING;

-- Biology Challenges
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Biology Essentials - Beginner' as title,
  'Explore the basics of biology with 15 fundamental questions.' as description,
  'beginner' as challenge_level,
  0 as level_requirement,
  'easy' as difficulty,
  15 as question_count,
  100 as xp_reward,
  3 as max_hearts,
  10 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%biology%' OR LOWER(category) LIKE '%biology%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Biology Deep Dive - Intermediate' as title,
  'Dive deeper into biology with 30 intermediate questions.' as description,
  'intermediate' as challenge_level,
  10 as level_requirement,
  'medium' as difficulty,
  30 as question_count,
  200 as xp_reward,
  3 as max_hearts,
  20 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%biology%' OR LOWER(category) LIKE '%biology%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  'Biology Master - Advanced' as title,
  'Master biology with 45 advanced questions.' as description,
  'advanced' as challenge_level,
  20 as level_requirement,
  'hard' as difficulty,
  45 as question_count,
  500 as xp_reward,
  3 as max_hearts,
  30 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) LIKE '%biology%' OR LOWER(category) LIKE '%biology%'
ON CONFLICT DO NOTHING;

-- Create generic challenges for any other topics not covered above
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  name || ' - Beginner' as title,
  'Test your knowledge of ' || name || ' with 15 basic questions.' as description,
  'beginner' as challenge_level,
  0 as level_requirement,
  'easy' as difficulty,
  15 as question_count,
  100 as xp_reward,
  3 as max_hearts,
  10 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) NOT LIKE '%physics%'
  AND LOWER(name) NOT LIKE '%chemistry%'
  AND LOWER(name) NOT LIKE '%biology%'
  AND LOWER(category) NOT LIKE '%physics%'
  AND LOWER(category) NOT LIKE '%chemistry%'
  AND LOWER(category) NOT LIKE '%biology%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  name || ' - Intermediate' as title,
  'Challenge your ' || name || ' knowledge with 30 intermediate questions.' as description,
  'intermediate' as challenge_level,
  10 as level_requirement,
  'medium' as difficulty,
  30 as question_count,
  200 as xp_reward,
  3 as max_hearts,
  20 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) NOT LIKE '%physics%'
  AND LOWER(name) NOT LIKE '%chemistry%'
  AND LOWER(name) NOT LIKE '%biology%'
  AND LOWER(category) NOT LIKE '%physics%'
  AND LOWER(category) NOT LIKE '%chemistry%'
  AND LOWER(category) NOT LIKE '%biology%'
ON CONFLICT DO NOTHING;

INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, question_count, xp_reward, max_hearts, estimated_time_minutes, topic_id)
SELECT
  name || ' - Advanced' as title,
  'Master ' || name || ' with 45 advanced questions.' as description,
  'advanced' as challenge_level,
  20 as level_requirement,
  'hard' as difficulty,
  45 as question_count,
  500 as xp_reward,
  3 as max_hearts,
  30 as estimated_time_minutes,
  id as topic_id
FROM public.learning_topics
WHERE LOWER(name) NOT LIKE '%physics%'
  AND LOWER(name) NOT LIKE '%chemistry%'
  AND LOWER(name) NOT LIKE '%biology%'
  AND LOWER(category) NOT LIKE '%physics%'
  AND LOWER(category) NOT LIKE '%chemistry%'
  AND LOWER(category) NOT LIKE '%biology%'
ON CONFLICT DO NOTHING;
