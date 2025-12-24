-- Set difficulty levels for all courses

-- First, add the difficulty column if it doesn't exist
ALTER TABLE public.courses ADD COLUMN IF NOT EXISTS difficulty text;

-- Beginner courses
UPDATE public.courses SET difficulty = 'beginner' WHERE slug IN (
  'basic-physics',
  'chemistry-basics',
  'general-science',
  'astronomy',
  'cell-biology',
  'ecology'
);

-- Intermediate courses
UPDATE public.courses SET difficulty = 'intermediate' WHERE slug IN (
  'thermodynamics',
  'genetics',
  'environmental-science',
  'robotics',
  'materials-science',
  'planetary-science',
  'origins-how-we-were-created'
);

-- Advanced courses
UPDATE public.courses SET difficulty = 'advanced' WHERE slug IN (
  'quantum-mechanics',
  'organic-chemistry',
  'biochemistry',
  'neurobiology',
  'astrophysics'
);
