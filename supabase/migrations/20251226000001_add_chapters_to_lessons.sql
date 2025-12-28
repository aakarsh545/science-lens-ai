-- Add chapters to existing lessons to organize them better
-- This updates existing lessons with proper chapter information

-- Chemistry Basics - organize existing lessons into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN order_index = 0 THEN 'Chapter 1: Introduction'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Chemistry in Your World'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Atomic Structure'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Chemical Reactions'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: The Periodic Table'
  WHEN order_index BETWEEN 50 AND 59 THEN 'Chapter 5: Advanced Topics'
  ELSE chapter
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'chemistry-basics');

-- Cell Biology - organize existing lessons into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN order_index = 0 THEN 'Chapter 1: Introduction'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Foundations of Life'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Cell Structure and Function'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Genetics and DNA'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Cell Division'
  WHEN order_index BETWEEN 50 AND 59 THEN 'Chapter 5: Advanced Topics'
  ELSE chapter
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'cell-biology');

-- Basic Physics - organize existing lessons into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN order_index = 0 THEN 'Chapter 1: Introduction'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Everyone Knows This'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Basic Understanding'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Intermediate Concepts'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Advanced Concepts'
  WHEN order_index BETWEEN 50 AND 59 THEN 'Chapter 5: Expert Level'
  ELSE chapter
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'basic-physics');

-- Astronomy - organize existing lessons into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN order_index = 0 THEN 'Chapter 1: Introduction'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Getting Started'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: The Solar System'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Stars and Galaxies'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Deep Space'
  WHEN order_index BETWEEN 50 AND 59 THEN 'Chapter 5: The Universe'
  ELSE chapter
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'astronomy');
