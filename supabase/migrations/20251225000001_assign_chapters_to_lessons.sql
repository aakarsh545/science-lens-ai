-- Assign chapters to existing lessons based on order_index
-- Chapter system: Introduction → Basics → You Might Know This → Going Deeper → Advanced Concepts → Expert Level

-- Update lessons based on order_index ranges
-- Level 1: Introduction (order_index 1-19)
UPDATE public.lessons
SET chapter = 'Introduction'
WHERE order_index >= 1 AND order_index <= 19
  AND chapter IS NULL;

-- Level 2: Basics (order_index 20-29)
UPDATE public.lessons
SET chapter = 'Basics'
WHERE order_index >= 20 AND order_index <= 29
  AND chapter IS NULL;

-- Level 3: You Might Know This (order_index 30-39)
UPDATE public.lessons
SET chapter = 'You Might Know This'
WHERE order_index >= 30 AND order_index <= 39
  AND chapter IS NULL;

-- Level 4: Going Deeper (order_index 40-49)
UPDATE public.lessons
SET chapter = 'Going Deeper'
WHERE order_index >= 40 AND order_index <= 49
  AND chapter IS NULL;

-- Level 5: Advanced Concepts (order_index 50-59)
UPDATE public.lessons
SET chapter = 'Advanced Concepts'
WHERE order_index >= 50 AND order_index <= 59
  AND chapter IS NULL;

-- Level 6: Expert Level (order_index 60+)
UPDATE public.lessons
SET chapter = 'Expert Level'
WHERE order_index >= 60
  AND chapter IS NULL;

-- For any lessons without chapter or order_index, assign to 'Introduction'
UPDATE public.lessons
SET chapter = 'Introduction'
WHERE chapter IS NULL;
