-- Seed all science courses for quiz generation

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
('neurobiology', 'Neurobiology', 'Study of the nervous system and brain function', 'Biology'),
('materials-science', 'Materials Science', 'Study of the properties and applications of materials', 'Technology'),
('environmental-science', 'Environmental Science', 'Understanding environmental systems and sustainability', 'Earth Science'),
('astrophysics', 'Astrophysics', 'Physics of celestial bodies and cosmic phenomena', 'Astronomy'),
('planetary-science', 'Planetary Science', 'Study of planets, moons, and planetary systems', 'Astronomy')
ON CONFLICT (slug) DO NOTHING;
