-- Add 3D model configuration to lessons table
-- This stores which 3D model to display for each lesson

-- Add model_type column to store the type of 3D model
ALTER TABLE public.lessons
ADD COLUMN model_type TEXT;

-- Add model_config column to store JSON configuration for the 3D model
ALTER TABLE public.lessons
ADD COLUMN model_config JSONB DEFAULT '{}'::jsonb;

-- Add index for better querying by model_type
CREATE INDEX IF NOT EXISTS lessons_model_type_idx ON public.lessons(model_type);

-- Add comments
COMMENT ON COLUMN public.lessons.model_type IS 'Type of 3D model to display (e.g., "atom", "wave", "molecule", "planet", etc.)';
COMMENT ON COLUMN public.lessons.model_config IS 'Configuration for the 3D model (e.g., { "protons": 6, "molecule": "water" })';

-- Now populate the model_type and model_config for all existing lessons
-- Based on the comprehensive lesson-to-3D-model mapping from LessonPlayer.tsx

-- ========== BASIC PHYSICS ==========
-- Introduction
UPDATE public.lessons SET model_type = 'atom', model_config = '{"protons": 6}'::jsonb WHERE slug = 'intro';

-- Units & Measurement
UPDATE public.lessons SET model_type = 'pendulum', model_config = '{}'::jsonb WHERE slug = 'basics-units';

-- Motion
UPDATE public.lessons SET model_type = 'projectile', model_config = '{}'::jsonb WHERE slug = 'motion-basics';
UPDATE public.lessons SET model_type = 'projectile', model_config = '{}'::jsonb WHERE slug = 'motion-acceleration';

-- Forces
UPDATE public.lessons SET model_type = 'force-vectors', model_config = '{}'::jsonb WHERE slug = 'forces-intro';
UPDATE public.lessons SET model_type = 'force-vectors', model_config = '{}'::jsonb WHERE slug = 'forces-newtons-laws';

-- Energy
UPDATE public.lessons SET model_type = 'pendulum', model_config = '{}'::jsonb WHERE slug = 'energy-work';
UPDATE public.lessons SET model_type = 'pendulum', model_config = '{}'::jsonb WHERE slug = 'energy-kinetic-potential';

-- Everyday Physics (Level 1)
UPDATE public.lessons SET model_type = 'pendulum', model_config = '{}'::jsonb WHERE slug = 'everyday-physics';
UPDATE public.lessons SET model_type = 'gravity', model_config = '{}'::jsonb WHERE slug = 'why-things-fall';

-- Basic Understanding (Level 2)
UPDATE public.lessons SET model_type = 'pressure', model_config = '{}'::jsonb WHERE slug = 'pressure-basics';
UPDATE public.lessons SET model_type = 'wave', model_config = '{}'::jsonb WHERE slug = 'waves-intro';

-- Intermediate (Level 3)
UPDATE public.lessons SET model_type = 'wave', model_config = '{"frequency": 3}'::jsonb WHERE slug = 'sound-physics';
UPDATE public.lessons SET model_type = 'wave', model_config = '{"frequency": 4}'::jsonb WHERE slug = 'light-basics';
UPDATE public.lessons SET model_type = 'projectile', model_config = '{}'::jsonb WHERE slug = 'momentum-impulse';
UPDATE public.lessons SET model_type = 'planet', model_config = '{}'::jsonb WHERE slug = 'circular-motion';

-- Advanced (Level 4)
UPDATE public.lessons SET model_type = 'electric-field', model_config = '{}'::jsonb WHERE slug = 'electricity-basics';
UPDATE public.lessons SET model_type = 'electric-field', model_config = '{}'::jsonb WHERE slug = 'magnetism-basics';
UPDATE public.lessons SET model_type = 'spacetime', model_config = '{}'::jsonb WHERE slug = 'relativity-intro';
UPDATE public.lessons SET model_type = 'quantum', model_config = '{}'::jsonb WHERE slug = 'quantum-concepts';

-- Expert (Level 5)
UPDATE public.lessons SET model_type = 'thermodynamics', model_config = '{}'::jsonb WHERE slug = 'thermodynamics-advanced';
UPDATE public.lessons SET model_type = 'spacetime', model_config = '{}'::jsonb WHERE slug = 'general-relativity';
UPDATE public.lessons SET model_type = 'atom', model_config = '{"protons": 12}'::jsonb WHERE slug = 'standard-model';
UPDATE public.lessons SET model_type = 'quantum', model_config = '{}'::jsonb WHERE slug = 'quantum-field-theory';

-- ========== CHEMISTRY ==========
-- Chemistry Introduction
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "water"}'::jsonb WHERE slug = 'basics-matter';
UPDATE public.lessons SET model_type = 'atom', model_config = '{"protons": 8}'::jsonb WHERE slug = 'basics-atoms';

-- Reactions
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "co2"}'::jsonb WHERE slug = 'reactions-intro';
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "methane"}'::jsonb WHERE slug = 'reactions-balancing';

-- Advanced Chemistry
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "nacl"}'::jsonb WHERE slug = 'advanced-bonding';

-- Comprehensive Chemistry
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "water"}'::jsonb WHERE slug = 'kitchen-chemistry';
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "water"}'::jsonb WHERE slug = 'acids-bases-ph';
UPDATE public.lessons SET model_type = 'electric-field', model_config = '{}'::jsonb WHERE slug = 'electrochemistry';
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "methane"}'::jsonb WHERE slug = 'organic-reactions';

-- ========== ASTRONOMY ==========
-- Basic Astronomy
UPDATE public.lessons SET model_type = 'planet', model_config = '{"planet": "earth"}'::jsonb WHERE slug = 'planets-inner';
UPDATE public.lessons SET model_type = 'planet', model_config = '{"planet": "saturn"}'::jsonb WHERE slug = 'planets-outer';
UPDATE public.lessons SET model_type = 'star', model_config = '{}'::jsonb WHERE slug = 'stars-lifecycle';
UPDATE public.lessons SET model_type = 'galaxy', model_config = '{}'::jsonb WHERE slug = 'galaxies-types';
UPDATE public.lessons SET model_type = 'galaxy', model_config = '{}'::jsonb WHERE slug = 'cosmology-big-bang';

-- Comprehensive Astronomy
UPDATE public.lessons SET model_type = 'planet', model_config = '{"planet": "saturn"}'::jsonb WHERE slug = 'night-sky';
UPDATE public.lessons SET model_type = 'star', model_config = '{}'::jsonb WHERE slug = 'stellar-evolution';
UPDATE public.lessons SET model_type = 'black-hole', model_config = '{}'::jsonb WHERE slug = 'black-holes';
UPDATE public.lessons SET model_type = 'galaxy', model_config = '{}'::jsonb WHERE slug = 'cosmology';

-- ========== BIOLOGY ==========
-- Cell Biology
UPDATE public.lessons SET model_type = 'cell', model_config = '{}'::jsonb WHERE slug = 'cell-intro';

-- Genetics
UPDATE public.lessons SET model_type = 'dna', model_config = '{}'::jsonb WHERE slug = 'genetics-intro';

-- Ecology
UPDATE public.lessons SET model_type = 'ecosystem', model_config = '{}'::jsonb WHERE slug = 'ecology-intro';

-- ========== OTHER SCIENCES ==========
-- Thermodynamics
UPDATE public.lessons SET model_type = 'thermodynamics', model_config = '{}'::jsonb WHERE slug = 'thermo-intro';

-- Organic Chemistry
UPDATE public.lessons SET model_type = 'molecule', model_config = '{"molecule": "methane"}'::jsonb WHERE slug = 'organic-intro';

-- Biochemistry
UPDATE public.lessons SET model_type = 'dna', model_config = '{}'::jsonb WHERE slug = 'biochem-intro';

-- Neurobiology
UPDATE public.lessons SET model_type = 'cell', model_config = '{}'::jsonb WHERE slug = 'neuro-intro';

-- Robotics
UPDATE public.lessons SET model_type = 'robot', model_config = '{}'::jsonb WHERE slug = 'robotics-intro';

-- Environmental Science
UPDATE public.lessons SET model_type = 'ecosystem', model_config = '{}'::jsonb WHERE slug = 'environment-intro';

-- Materials Science
UPDATE public.lessons SET model_type = 'atom', model_config = '{"protons": 14}'::jsonb WHERE slug = 'materials-intro';

-- Astrophysics
UPDATE public.lessons SET model_type = 'star', model_config = '{}'::jsonb WHERE slug = 'astrophysics-intro';

-- Planetary Science
UPDATE public.lessons SET model_type = 'planet', model_config = '{"planet": "mars"}'::jsonb WHERE slug = 'planetary-intro';

-- Quantum Mechanics
UPDATE public.lessons SET model_type = 'quantum', model_config = '{}'::jsonb WHERE slug = 'quantum-intro';

-- General Science
UPDATE public.lessons SET model_type = 'atom', model_config = '{"protons": 6}'::jsonb WHERE slug = 'general-intro';

-- Origins
UPDATE public.lessons SET model_type = 'galaxy', model_config = '{}'::jsonb WHERE slug = 'origins-intro';
