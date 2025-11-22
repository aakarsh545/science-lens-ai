-- Seed 18 Science Courses with Introduction Lessons

-- Insert Courses
INSERT INTO public.courses (slug, title, description, category) VALUES
('basic-physics', 'Basic Physics', 'Fundamental concepts of motion, forces, and energy in our physical world', 'Physics'),
('quantum-mechanics', 'Quantum Mechanics', 'Explore the fascinating world of quantum physics and subatomic particles', 'Physics'),
('astronomy', 'Astronomy', 'Study celestial objects, space, and the universe as a whole', 'Astronomy'),
('thermodynamics', 'Thermodynamics', 'Understanding heat, energy transfer, and the laws governing them', 'Physics'),
('chemistry-basics', 'Chemistry Basics', 'Introduction to matter, chemical reactions, and the periodic table', 'Chemistry'),
('organic-chemistry', 'Organic Chemistry', 'Study of carbon-based compounds and their reactions', 'Chemistry'),
('biochemistry', 'Biochemistry', 'Chemical processes within living organisms', 'Chemistry'),
('cell-biology', 'Cell Biology', 'Understanding the structure and function of cells', 'Biology'),
('genetics', 'Genetics', 'Study of heredity and variation in living organisms', 'Biology'),
('ecology', 'Ecology', 'Interactions between organisms and their environment', 'Biology'),
('robotics', 'Robotics', 'Design, construction, and operation of robots', 'Technology'),
('general-science', 'General Science', 'Broad overview of scientific principles and methods', 'General'),
('origins-how-we-were-created', 'Origins: How We Were Created', 'Scientific perspectives on the origin of life and humanity', 'General'),
('materials-science', 'Materials Science', 'Study of the properties and applications of materials', 'Technology'),
('environmental-science', 'Environmental Science', 'Understanding environmental systems and sustainability', 'Earth Science'),
('neurobiology', 'Neurobiology', 'Study of the nervous system and brain function', 'Biology'),
('astrophysics', 'Astrophysics', 'Physics of celestial bodies and cosmic phenomena', 'Astronomy'),
('planetary-science', 'Planetary Science', 'Study of planets, moons, and planetary systems', 'Astronomy')
ON CONFLICT (slug) DO NOTHING;

-- Insert sample lessons (first 3 courses as examples)
INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Basic Physics',
'# Welcome to Basic Physics

Physics is the natural science that studies matter, its motion and behavior through space and time.

## Key Concepts
- Motion and Forces
- Energy and Work
- Newton''s Laws

Understanding these fundamentals helps explain everything from sports to space exploration!',
10, 0
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Quantum Mechanics',
'# Welcome to Quantum Mechanics

Quantum mechanics describes matter and energy at the atomic scale.

## Key Principles
- Wave-Particle Duality
- Uncertainty Principle
- Superposition

These strange quantum behaviors power modern technology!',
10, 0
FROM public.courses WHERE slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;