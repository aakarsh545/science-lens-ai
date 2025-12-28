-- Update chapter information for the newly added comprehensive lessons

-- Genetics - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Foundations of Genetics'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Foundations of Genetics'
  WHEN slug LIKE '%modes%' OR slug LIKE '%mendel%' THEN 'Chapter 2: Patterns of Inheritance'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Patterns of Inheritance'
  WHEN slug LIKE '%dna%' OR slug LIKE '%replication%' OR slug LIKE '%structure%' THEN 'Chapter 3: Molecular Genetics'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Molecular Genetics'
  WHEN slug LIKE '%mutation%' OR slug LIKE '%change%' THEN 'Chapter 4: Genetic Variation'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Genetic Variation'
  ELSE 'Chapter 1: Foundations of Genetics'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'genetics');

-- Ecology - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Foundations of Ecology'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Foundations of Ecology'
  WHEN slug LIKE '%population%' THEN 'Chapter 2: Population Dynamics'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Population Dynamics'
  WHEN slug LIKE '%community%' OR slug LIKE '%interaction%' THEN 'Chapter 3: Community Interactions'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Community Interactions'
  WHEN slug LIKE '%ecosystem%' OR slug LIKE '%energy%' THEN 'Chapter 4: Ecosystem Dynamics'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Ecosystem Dynamics'
  ELSE 'Chapter 1: Foundations of Ecology'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'ecology');

-- Organic Chemistry - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Organic Fundamentals'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Organic Fundamentals'
  WHEN slug LIKE '%functional%' OR slug LIKE '%group%' THEN 'Chapter 2: Functional Groups'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Functional Groups'
  WHEN slug LIKE '%reaction%' OR slug LIKE '%mechanism%' THEN 'Chapter 3: Organic Reactions'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Organic Reactions'
  ELSE 'Chapter 1: Organic Fundamentals'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'organic-chemistry');

-- Neurobiology - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Nervous System Overview'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Nervous System Overview'
  WHEN slug LIKE '%neuron%' OR slug LIKE '%structure%' OR slug LIKE '%signal%' THEN 'Chapter 2: Neuron Structure'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Neuron Structure'
  WHEN slug LIKE '%brain%' OR slug LIKE '%synapse%' THEN 'Chapter 3: Neural Circuits'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Neural Circuits'
  ELSE 'Chapter 1: Nervous System Overview'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'neurobiology');

-- Robotics - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Robotics Fundamentals'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Robotics Fundamentals'
  WHEN slug LIKE '%sensor%' OR slug LIKE '%perception%' OR slug LIKE '%sensing%' THEN 'Chapter 2: Robot Sensing'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Robot Sensing'
  WHEN slug LIKE '%actuator%' OR slug LIKE '%motor%' OR slug LIKE '%movement%' THEN 'Chapter 3: Actuation and Movement'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Actuation and Movement'
  WHEN slug LIKE '%control%' OR slug LIKE '%programming%' OR slug LIKE '%ai%' THEN 'Chapter 4: Control and AI'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Control and AI'
  ELSE 'Chapter 1: Robotics Fundamentals'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'robotics');

-- Environmental Science - organize into chapters
UPDATE public.lessons
SET chapter = CASE
  WHEN slug LIKE '%intro%' THEN 'Chapter 1: Earth Systems'
  WHEN order_index BETWEEN 10 AND 19 THEN 'Chapter 1: Earth Systems'
  WHEN slug LIKE '%biodiversity%' OR slug LIKE '%conservation%' THEN 'Chapter 2: Biodiversity'
  WHEN order_index BETWEEN 20 AND 29 THEN 'Chapter 2: Biodiversity'
  WHEN slug LIKE '%climate%' OR slug LIKE '%pollution%' THEN 'Chapter 3: Environmental Issues'
  WHEN order_index BETWEEN 30 AND 39 THEN 'Chapter 3: Environmental Issues'
  WHEN slug LIKE '%sustainability%' OR slug LIKE '%solution%' THEN 'Chapter 4: Solutions'
  WHEN order_index BETWEEN 40 AND 49 THEN 'Chapter 4: Solutions'
  ELSE 'Chapter 1: Earth Systems'
END
WHERE course_id = (SELECT id FROM courses WHERE slug = 'environmental-science');
