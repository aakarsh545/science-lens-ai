-- Add sample challenges with different difficulty levels

-- Clear existing challenges (optional, remove if you want to keep existing ones)
-- TRUNCATE public.challenges CASCADE;

-- Beginner Challenges (No level requirement)
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, xp_reward, payload)
VALUES
  (
    'What is Photosynthesis?',
    'Test your understanding of how plants convert light into energy.',
    'beginner',
    0,
    'easy',
    20,
    '{"question": "What is the primary product of photosynthesis?", "options": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"], "correctAnswer": "Oxygen"}'::jsonb
  ),
  (
    'States of Matter',
    'Identify the three main states of matter.',
    'beginner',
    0,
    'easy',
    20,
    '{"question": "Which of the following is NOT a state of matter?", "options": ["Solid", "Liquid", "Gas", "Energy"], "correctAnswer": "Energy"}'::jsonb
  ),
  (
    'The Solar System',
    'How well do you know our cosmic neighborhood?',
    'beginner',
    0,
    'easy',
    25,
    '{"question": "Which planet is known as the Red Planet?", "options": ["Venus", "Mars", "Jupiter", "Saturn"], "correctAnswer": "Mars"}'::jsonb
  ),
  (
    'Basic Chemistry',
    'Test your knowledge of chemical elements.',
    'beginner',
    0,
    'easy',
    20,
    '{"question": "What is the chemical symbol for water?", "options": ["H2O", "CO2", "O2", "NaCl"], "correctAnswer": "H2O"}'::jsonb
  );

-- Intermediate Challenges (Require Level 10+)
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, xp_reward, payload)
VALUES
  (
    'Cell Division',
    'Challenge your understanding of mitosis and meiosis.',
    'intermediate',
    10,
    'medium',
    50,
    '{"question": "What is the main difference between mitosis and meiosis?", "options": ["Mitosis produces 2 cells, meiosis produces 4", "Mitosis is for reproduction, meiosis is for growth", "Mitosis occurs in plants only", "There is no difference"], "correctAnswer": "Mitosis produces 2 cells, meiosis produces 4"}'::jsonb
  ),
  (
    'Newton''s Laws',
    'Apply Newton''s laws of motion to solve problems.',
    'intermediate',
    10,
    'medium',
    50,
    '{"question": "Which of Newton''s laws explains why you feel pushed back when a car accelerates?", "options": ["First Law (Inertia)", "Second Law (F=ma)", "Third Law (Action-Reaction)", "Law of Gravity"], "correctAnswer": "First Law (Inertia)"}'::jsonb
  ),
  (
    'Chemical Bonding',
    'Test your knowledge of ionic and covalent bonds.',
    'intermediate',
    10,
    'medium',
    50,
    '{"question": "What type of bond involves the sharing of electrons?", "options": ["Ionic bond", "Covalent bond", "Metallic bond", "Hydrogen bond"], "correctAnswer": "Covalent bond"}'::jsonb
  ),
  (
    'Genetics Basics',
    'Challenge yourself with Mendelian genetics.',
    'intermediate',
    10,
    'medium',
    50,
    '{"question": "In Mendel''s pea plants, which trait was dominant?", "options": ["Short stem", "Tall stem", "Yellow seeds (over green)", "Both B and C"], "correctAnswer": "Both B and C"}'::jsonb
  );

-- Advanced Challenges (Require Level 20+)
INSERT INTO public.challenges (title, description, challenge_level, level_requirement, difficulty, xp_reward, payload)
VALUES
  (
    'Quantum Mechanics',
    'Dive into the weird world of quantum physics.',
    'advanced',
    20,
    'hard',
    100,
    '{"question": "What is the principle that states you cannot simultaneously know the exact position and momentum of a particle?", "options": ["Schrödinger''s Equation", "Heisenberg Uncertainty Principle", "Pauli Exclusion Principle", "Wave-Particle Duality"], "correctAnswer": "Heisenberg Uncertainty Principle"}'::jsonb
  ),
  (
    'Organic Chemistry Reactions',
    'Test your knowledge of complex organic reactions.',
    'advanced',
    20,
    'hard',
    100,
    '{"question": "What type of reaction converts an alkene to an alkane?", "options": ["Oxidation", "Reduction (Hydrogenation)", "Substitution", "Elimination"], "correctAnswer": "Reduction (Hydrogenation)"}'::jsonb
  ),
  (
    'Biochemical Pathways',
    'Challenge your understanding of metabolic pathways.',
    'advanced',
    20,
    'hard',
    100,
    '{"question": "What is the net ATP production from one glucose molecule in cellular respiration?", "options": ["2 ATP", "30-32 ATP", "36-38 ATP", "4 ATP"], "correctAnswer": "30-32 ATP"}'::jsonb
  ),
  (
    'Astrophysics',
    'Explore the physics of stars and galaxies.',
    'advanced',
    20,
    'hard',
    100,
    '{"question": "What process powers the Sun?", "options": ["Chemical combustion", "Nuclear fission", "Nuclear fusion", "Gravitational collapse"], "correctAnswer": "Nuclear fusion"}'::jsonb
  );
