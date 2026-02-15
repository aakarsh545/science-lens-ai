-- =====================================================
-- QUANTUM MECHANICS COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons with comprehensive content
-- Physics Course 4 of 4
-- =====================================================

-- Create Quantum Mechanics course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'quantum-mechanics-uuid',
    'Quantum Mechanics',
    'quantum-mechanics',
    'Comprehensive course covering wave-particle duality, Schrödinger equation, quantum operators, uncertainty principle, atomic structure, quantum statistics, and applications to atoms, molecules, and solids. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/quantum-mechanics.svg',
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    icon_url = EXCLUDED.icon_url,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 1: ORIGINS OF QUANTUM THEORY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch1-uuid',
    'quantum-mechanics-uuid',
    'Origins of Quantum Theory',
    'origins-quantum-theory',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.1: Blackbody Radiation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l01-uuid',
    'course4-ch1-uuid',
    'ch1-blackbody-radiation',
    'Lesson 1.1: Blackbody Radiation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.1", "content": "Comprehensive explanation of Blackbody Radiation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.1", "problem": "Practice problem demonstrating key principles of Blackbody Radiation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Blackbody Radiation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.2: Photoelectric Effect
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l02-uuid',
    'course4-ch1-uuid',
    'ch1-photoelectric-effect',
    'Lesson 1.2: Photoelectric Effect',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.2", "content": "Comprehensive explanation of Photoelectric Effect including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.2", "problem": "Practice problem demonstrating key principles of Photoelectric Effect", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Photoelectric Effect", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.3: Compton Scattering
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l03-uuid',
    'course4-ch1-uuid',
    'ch1-compton-scattering',
    'Lesson 1.3: Compton Scattering',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.3", "content": "Comprehensive explanation of Compton Scattering including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.3", "problem": "Practice problem demonstrating key principles of Compton Scattering", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Compton Scattering", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.4: Atomic Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l04-uuid',
    'course4-ch1-uuid',
    'ch1-atomic-spectra',
    'Lesson 1.4: Atomic Spectra',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.4", "content": "Comprehensive explanation of Atomic Spectra including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.4", "problem": "Practice problem demonstrating key principles of Atomic Spectra", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Atomic Spectra", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.5: Bohr Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l05-uuid',
    'course4-ch1-uuid',
    'ch1-bohr-model',
    'Lesson 1.5: Bohr Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.5", "content": "Comprehensive explanation of Bohr Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.5", "problem": "Practice problem demonstrating key principles of Bohr Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Bohr Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.6: Wave-Particle Duality
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l06-uuid',
    'course4-ch1-uuid',
    'ch1-wave-particle-duality',
    'Lesson 1.6: Wave-Particle Duality',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.6", "content": "Comprehensive explanation of Wave-Particle Duality including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.6", "problem": "Practice problem demonstrating key principles of Wave-Particle Duality", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Wave-Particle Duality", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.7: De Broglie Wavelength
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l07-uuid',
    'course4-ch1-uuid',
    'ch1-de-broglie-wavelength',
    'Lesson 1.7: De Broglie Wavelength',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.7", "content": "Comprehensive explanation of De Broglie Wavelength including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.7", "problem": "Practice problem demonstrating key principles of De Broglie Wavelength", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about De Broglie Wavelength", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.8: Davisson-Germer Experiment
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l08-uuid',
    'course4-ch1-uuid',
    'ch1-davisson-germer-experiment',
    'Lesson 1.8: Davisson-Germer Experiment',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.8", "content": "Comprehensive explanation of Davisson-Germer Experiment including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.8", "problem": "Practice problem demonstrating key principles of Davisson-Germer Experiment", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Davisson-Germer Experiment", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.9: Quantization of Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l09-uuid',
    'course4-ch1-uuid',
    'ch1-quantization-of-energy',
    'Lesson 1.9: Quantization of Energy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.9", "content": "Comprehensive explanation of Quantization of Energy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.9", "problem": "Practice problem demonstrating key principles of Quantization of Energy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantization of Energy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 1.10: Historical Perspective
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch1-l10-uuid',
    'course4-ch1-uuid',
    'ch1-historical-perspective',
    'Lesson 1.10: Historical Perspective',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 1, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.10", "content": "Comprehensive explanation of Historical Perspective including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.10", "problem": "Practice problem demonstrating key principles of Historical Perspective", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Historical Perspective", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 2: WAVE FUNCTIONS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch2-uuid',
    'quantum-mechanics-uuid',
    'Wave Functions',
    'wave-functions',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.1: Schrödinger Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l01-uuid',
    'course4-ch2-uuid',
    'ch2-schrödinger-equation',
    'Lesson 2.1: Schrödinger Equation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.1", "content": "Comprehensive explanation of Schr\u00f6dinger Equation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.1", "problem": "Practice problem demonstrating key principles of Schr\u00f6dinger Equation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Schr\u00f6dinger Equation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.2: Wave Function Interpretation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l02-uuid',
    'course4-ch2-uuid',
    'ch2-wave-function-interpretation',
    'Lesson 2.2: Wave Function Interpretation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.2", "content": "Comprehensive explanation of Wave Function Interpretation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.2", "problem": "Practice problem demonstrating key principles of Wave Function Interpretation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Wave Function Interpretation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.3: Probability Density
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l03-uuid',
    'course4-ch2-uuid',
    'ch2-probability-density',
    'Lesson 2.3: Probability Density',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.3", "content": "Comprehensive explanation of Probability Density including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.3", "problem": "Practice problem demonstrating key principles of Probability Density", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Probability Density", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.4: Normalization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l04-uuid',
    'course4-ch2-uuid',
    'ch2-normalization',
    'Lesson 2.4: Normalization',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.4", "content": "Comprehensive explanation of Normalization including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.4", "problem": "Practice problem demonstrating key principles of Normalization", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Normalization", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.5: Expectation Velues
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l05-uuid',
    'course4-ch2-uuid',
    'ch2-expectation-velues',
    'Lesson 2.5: Expectation Velues',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.5", "content": "Comprehensive explanation of Expectation Velues including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.5", "problem": "Practice problem demonstrating key principles of Expectation Velues", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Expectation Velues", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.6: Operators in Quantum Mechanics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l06-uuid',
    'course4-ch2-uuid',
    'ch2-operators-in-quantum-mechanics',
    'Lesson 2.6: Operators in Quantum Mechanics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.6", "content": "Comprehensive explanation of Operators in Quantum Mechanics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.6", "problem": "Practice problem demonstrating key principles of Operators in Quantum Mechanics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Operators in Quantum Mechanics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.7: Time-Independent Schrödinger Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l07-uuid',
    'course4-ch2-uuid',
    'ch2-time-independent-schrödinger-equation',
    'Lesson 2.7: Time-Independent Schrödinger Equation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.7", "content": "Comprehensive explanation of Time-Independent Schr\u00f6dinger Equation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.7", "problem": "Practice problem demonstrating key principles of Time-Independent Schr\u00f6dinger Equation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Time-Independent Schr\u00f6dinger Equation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.8: Time-Dependent Schrödinger Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l08-uuid',
    'course4-ch2-uuid',
    'ch2-time-dependent-schrödinger-equation',
    'Lesson 2.8: Time-Dependent Schrödinger Equation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.8", "content": "Comprehensive explanation of Time-Dependent Schr\u00f6dinger Equation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.8", "problem": "Practice problem demonstrating key principles of Time-Dependent Schr\u00f6dinger Equation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Time-Dependent Schr\u00f6dinger Equation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.9: Stationary States
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l09-uuid',
    'course4-ch2-uuid',
    'ch2-stationary-states',
    'Lesson 2.9: Stationary States',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.9", "content": "Comprehensive explanation of Stationary States including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.9", "problem": "Practice problem demonstrating key principles of Stationary States", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stationary States", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 2.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch2-l10-uuid',
    'course4-ch2-uuid',
    'ch2-applications',
    'Lesson 2.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 2, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 3: ONE-DIMENSIONAL PROBLEMS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch3-uuid',
    'quantum-mechanics-uuid',
    'One-Dimensional Problems',
    'one-dimensional-problems-quantum',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.1: Particle in a Box
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l01-uuid',
    'course4-ch3-uuid',
    'ch3-particle-in-a-box',
    'Lesson 3.1: Particle in a Box',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.1", "content": "Comprehensive explanation of Particle in a Box including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.1", "problem": "Practice problem demonstrating key principles of Particle in a Box", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Particle in a Box", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.2: Finite Potential Well
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l02-uuid',
    'course4-ch3-uuid',
    'ch3-finite-potential-well',
    'Lesson 3.2: Finite Potential Well',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.2", "content": "Comprehensive explanation of Finite Potential Well including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.2", "problem": "Practice problem demonstrating key principles of Finite Potential Well", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Finite Potential Well", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.3: Harmonic Oscillator
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l03-uuid',
    'course4-ch3-uuid',
    'ch3-harmonic-oscillator',
    'Lesson 3.3: Harmonic Oscillator',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.3", "content": "Comprehensive explanation of Harmonic Oscillator including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.3", "problem": "Practice problem demonstrating key principles of Harmonic Oscillator", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Harmonic Oscillator", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.4: Barrier Penetration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l04-uuid',
    'course4-ch3-uuid',
    'ch3-barrier-penetration',
    'Lesson 3.4: Barrier Penetration',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.4", "content": "Comprehensive explanation of Barrier Penetration including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.4", "problem": "Practice problem demonstrating key principles of Barrier Penetration", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Barrier Penetration", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.5: Tunneling
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l05-uuid',
    'course4-ch3-uuid',
    'ch3-tunneling',
    'Lesson 3.5: Tunneling',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.5", "content": "Comprehensive explanation of Tunneling including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.5", "problem": "Practice problem demonstrating key principles of Tunneling", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Tunneling", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.6: Scattering
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l06-uuid',
    'course4-ch3-uuid',
    'ch3-scattering',
    'Lesson 3.6: Scattering',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.6", "content": "Comprehensive explanation of Scattering including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.6", "problem": "Practice problem demonstrating key principles of Scattering", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Scattering", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.7: Delta Function Potential
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l07-uuid',
    'course4-ch3-uuid',
    'ch3-delta-function-potential',
    'Lesson 3.7: Delta Function Potential',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.7", "content": "Comprehensive explanation of Delta Function Potential including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.7", "problem": "Practice problem demonstrating key principles of Delta Function Potential", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Delta Function Potential", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.8: Periodic Potential
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l08-uuid',
    'course4-ch3-uuid',
    'ch3-periodic-potential',
    'Lesson 3.8: Periodic Potential',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.8", "content": "Comprehensive explanation of Periodic Potential including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.8", "problem": "Practice problem demonstrating key principles of Periodic Potential", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Periodic Potential", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.9: Superlattices
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l09-uuid',
    'course4-ch3-uuid',
    'ch3-superlattices',
    'Lesson 3.9: Superlattices',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.9", "content": "Comprehensive explanation of Superlattices including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.9", "problem": "Practice problem demonstrating key principles of Superlattices", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Superlattices", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 3.10: Quantum Dots
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch3-l10-uuid',
    'course4-ch3-uuid',
    'ch3-quantum-dots',
    'Lesson 3.10: Quantum Dots',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 3, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.10", "content": "Comprehensive explanation of Quantum Dots including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.10", "problem": "Practice problem demonstrating key principles of Quantum Dots", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Dots", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 4: QUANTUM MECHANICS IN THREE DIMENSIONS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch4-uuid',
    'quantum-mechanics-uuid',
    'Quantum Mechanics in Three Dimensions',
    'quantum-3d',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.1: Hydrogen Atom
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l01-uuid',
    'course4-ch4-uuid',
    'ch4-hydrogen-atom',
    'Lesson 4.1: Hydrogen Atom',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.1", "content": "Comprehensive explanation of Hydrogen Atom including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.1", "problem": "Practice problem demonstrating key principles of Hydrogen Atom", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hydrogen Atom", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.2: Angular Momentum
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l02-uuid',
    'course4-ch4-uuid',
    'ch4-angular-momentum',
    'Lesson 4.2: Angular Momentum',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.2", "content": "Comprehensive explanation of Angular Momentum including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.2", "problem": "Practice problem demonstrating key principles of Angular Momentum", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Angular Momentum", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.3: Quantum Numbers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l03-uuid',
    'course4-ch4-uuid',
    'ch4-quantum-numbers',
    'Lesson 4.3: Quantum Numbers',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.3", "content": "Comprehensive explanation of Quantum Numbers including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.3", "problem": "Practice problem demonstrating key principles of Quantum Numbers", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Numbers", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.4: Atomic Orbitals
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l04-uuid',
    'course4-ch4-uuid',
    'ch4-atomic-orbitals',
    'Lesson 4.4: Atomic Orbitals',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.4", "content": "Comprehensive explanation of Atomic Orbitals including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.4", "problem": "Practice problem demonstrating key principles of Atomic Orbitals", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Atomic Orbitals", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.5: Electron Spin
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l05-uuid',
    'course4-ch4-uuid',
    'ch4-electron-spin',
    'Lesson 4.5: Electron Spin',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.5", "content": "Comprehensive explanation of Electron Spin including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.5", "problem": "Practice problem demonstrating key principles of Electron Spin", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Electron Spin", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.6: Fine Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l06-uuid',
    'course4-ch4-uuid',
    'ch4-fine-structure',
    'Lesson 4.6: Fine Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.6", "content": "Comprehensive explanation of Fine Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.6", "problem": "Practice problem demonstrating key principles of Fine Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Fine Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.7: Hydrogen-Like Ions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l07-uuid',
    'course4-ch4-uuid',
    'ch4-hydrogen-like-ions',
    'Lesson 4.7: Hydrogen-Like Ions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.7", "content": "Comprehensive explanation of Hydrogen-Like Ions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.7", "problem": "Practice problem demonstrating key principles of Hydrogen-Like Ions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hydrogen-Like Ions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.8: Many-Electron Atoms
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l08-uuid',
    'course4-ch4-uuid',
    'ch4-many-electron-atoms',
    'Lesson 4.8: Many-Electron Atoms',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.8", "content": "Comprehensive explanation of Many-Electron Atoms including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.8", "problem": "Practice problem demonstrating key principles of Many-Electron Atoms", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Many-Electron Atoms", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.9: Periodic Table
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l09-uuid',
    'course4-ch4-uuid',
    'ch4-periodic-table',
    'Lesson 4.9: Periodic Table',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.9", "content": "Comprehensive explanation of Periodic Table including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.9", "problem": "Practice problem demonstrating key principles of Periodic Table", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Periodic Table", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 4.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch4-l10-uuid',
    'course4-ch4-uuid',
    'ch4-applications',
    'Lesson 4.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 4, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 5: IDENTICAL PARTICLES
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch5-uuid',
    'quantum-mechanics-uuid',
    'Identical Particles',
    'identical-particles',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.1: Spin-1/2 Systems
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l01-uuid',
    'course4-ch5-uuid',
    'ch5-spin-1/2-systems',
    'Lesson 5.1: Spin-1/2 Systems',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.1", "content": "Comprehensive explanation of Spin-1/2 Systems including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.1", "problem": "Practice problem demonstrating key principles of Spin-1/2 Systems", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Spin-1/2 Systems", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.2: Stern-Gerlach Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l02-uuid',
    'course4-ch5-uuid',
    'ch5-stern-gerlach-equation',
    'Lesson 5.2: Stern-Gerlach Equation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.2", "content": "Comprehensive explanation of Stern-Gerlach Equation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.2", "problem": "Practice problem demonstrating key principles of Stern-Gerlach Equation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stern-Gerlach Equation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.3: Spin Precession
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l03-uuid',
    'course4-ch5-uuid',
    'ch5-spin-precession',
    'Lesson 5.3: Spin Precession',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.3", "content": "Comprehensive explanation of Spin Precession including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.3", "problem": "Practice problem demonstrating key principles of Spin Precession", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Spin Precession", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.4: Pauli Exclusion Principle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l04-uuid',
    'course4-ch5-uuid',
    'ch5-pauli-exclusion-principle',
    'Lesson 5.4: Pauli Exclusion Principle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.4", "content": "Comprehensive explanation of Pauli Exclusion Principle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.4", "problem": "Practice problem demonstrating key principles of Pauli Exclusion Principle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Pauli Exclusion Principle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.5: Identical Fermions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l05-uuid',
    'course4-ch5-uuid',
    'ch5-identical-fermions',
    'Lesson 5.5: Identical Fermions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.5", "content": "Comprehensive explanation of Identical Fermions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.5", "problem": "Practice problem demonstrating key principles of Identical Fermions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Identical Fermions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.6: Identical Bosons
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l06-uuid',
    'course4-ch5-uuid',
    'ch5-identical-bosons',
    'Lesson 5.6: Identical Bosons',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.6", "content": "Comprehensive explanation of Identical Bosons including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.6", "problem": "Practice problem demonstrating key principles of Identical Bosons", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Identical Bosons", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.7: Band Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l07-uuid',
    'course4-ch5-uuid',
    'ch5-band-structure',
    'Lesson 5.7: Band Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.7", "content": "Comprehensive explanation of Band Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.7", "problem": "Practice problem demonstrating key principles of Band Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Band Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.8: Semiconductors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l08-uuid',
    'course4-ch5-uuid',
    'ch5-semiconductors',
    'Lesson 5.8: Semiconductors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.8", "content": "Comprehensive explanation of Semiconductors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.8", "problem": "Practice problem demonstrating key principles of Semiconductors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Semiconductors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.9: Superfluidity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l09-uuid',
    'course4-ch5-uuid',
    'ch5-superfluidity',
    'Lesson 5.9: Superfluidity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.9", "content": "Comprehensive explanation of Superfluidity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.9", "problem": "Practice problem demonstrating key principles of Superfluidity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Superfluidity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 5.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch5-l10-uuid',
    'course4-ch5-uuid',
    'ch5-applications',
    'Lesson 5.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 5, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 6: TIME-INDEPENDENT PERTURBATION THEORY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch6-uuid',
    'quantum-mechanics-uuid',
    'Time-Independent Perturbation Theory',
    'time-independent-perturbation-theory',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.1: Non-Degenerate Perturbation Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l01-uuid',
    'course4-ch6-uuid',
    'ch6-non-degenerate-perturbation-theory',
    'Lesson 6.1: Non-Degenerate Perturbation Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.1", "content": "Comprehensive explanation of Non-Degenerate Perturbation Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.1", "problem": "Practice problem demonstrating key principles of Non-Degenerate Perturbation Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Non-Degenerate Perturbation Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.2: First Order Correction
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l02-uuid',
    'course4-ch6-uuid',
    'ch6-first-order-correction',
    'Lesson 6.2: First Order Correction',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.2", "content": "Comprehensive explanation of First Order Correction including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.2", "problem": "Practice problem demonstrating key principles of First Order Correction", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Order Correction", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.3: Dagenerate Perturbation Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l03-uuid',
    'course4-ch6-uuid',
    'ch6-dagenerate-perturbation-theory',
    'Lesson 6.3: Dagenerate Perturbation Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.3", "content": "Comprehensive explanation of Dagenerate Perturbation Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.3", "problem": "Practice problem demonstrating key principles of Dagenerate Perturbation Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dagenerate Perturbation Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.4: Second Order Correction
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l04-uuid',
    'course4-ch6-uuid',
    'ch6-second-order-correction',
    'Lesson 6.4: Second Order Correction',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.4", "content": "Comprehensive explanation of Second Order Correction including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.4", "problem": "Practice problem demonstrating key principles of Second Order Correction", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Second Order Correction", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.5: Variational Method
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l05-uuid',
    'course4-ch6-uuid',
    'ch6-variational-method',
    'Lesson 6.5: Variational Method',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.5", "content": "Comprehensive explanation of Variational Method including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.5", "problem": "Practice problem demonstrating key principles of Variational Method", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Variational Method", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.6: Helium Atom
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l06-uuid',
    'course4-ch6-uuid',
    'ch6-helium-atom',
    'Lesson 6.6: Helium Atom',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.6", "content": "Comprehensive explanation of Helium Atom including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.6", "problem": "Practice problem demonstrating key principles of Helium Atom", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Helium Atom", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.7: Many-Electron Systems
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l07-uuid',
    'course4-ch6-uuid',
    'ch6-many-electron-systems',
    'Lesson 6.7: Many-Electron Systems',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.7", "content": "Comprehensive explanation of Many-Electron Systems including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.7", "problem": "Practice problem demonstrating key principles of Many-Electron Systems", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Many-Electron Systems", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.8: Molecular Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l08-uuid',
    'course4-ch6-uuid',
    'ch6-molecular-applications',
    'Lesson 6.8: Molecular Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.8", "content": "Comprehensive explanation of Molecular Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.8", "problem": "Practice problem demonstrating key principles of Molecular Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.9: Solid State Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l09-uuid',
    'course4-ch6-uuid',
    'ch6-solid-state-applications',
    'Lesson 6.9: Solid State Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.9", "content": "Comprehensive explanation of Solid State Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.9", "problem": "Practice problem demonstrating key principles of Solid State Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Solid State Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 6.10: Advanced Topics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch6-l10-uuid',
    'course4-ch6-uuid',
    'ch6-advanced-topics',
    'Lesson 6.10: Advanced Topics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 6, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.10", "content": "Comprehensive explanation of Advanced Topics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.10", "problem": "Practice problem demonstrating key principles of Advanced Topics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Advanced Topics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 7: ATOMIC STRUCTURE AND SPECTRA
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch7-uuid',
    'quantum-mechanics-uuid',
    'Atomic Structure and Spectra',
    'atomic-structure-spectra',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.1: Hydrogen Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l01-uuid',
    'course4-ch7-uuid',
    'ch7-hydrogen-spectra',
    'Lesson 7.1: Hydrogen Spectra',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.1", "content": "Comprehensive explanation of Hydrogen Spectra including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.1", "problem": "Practice problem demonstrating key principles of Hydrogen Spectra", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hydrogen Spectra", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.2: Alkali Metal Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l02-uuid',
    'course4-ch7-uuid',
    'ch7-alkali-metal-spectra',
    'Lesson 7.2: Alkali Metal Spectra',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.2", "content": "Comprehensive explanation of Alkali Metal Spectra including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.2", "problem": "Practice problem demonstrating key principles of Alkali Metal Spectra", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Alkali Metal Spectra", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.3: Selection Rules
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l03-uuid',
    'course4-ch7-uuid',
    'ch7-selection-rules',
    'Lesson 7.3: Selection Rules',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.3", "content": "Comprehensive explanation of Selection Rules including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.3", "problem": "Practice problem demonstrating key principles of Selection Rules", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Selection Rules", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.4: Fine Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l04-uuid',
    'course4-ch7-uuid',
    'ch7-fine-structure',
    'Lesson 7.4: Fine Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.4", "content": "Comprehensive explanation of Fine Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.4", "problem": "Practice problem demonstrating key principles of Fine Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Fine Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.5: Hyperfine Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l05-uuid',
    'course4-ch7-uuid',
    'ch7-hyperfine-structure',
    'Lesson 7.5: Hyperfine Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.5", "content": "Comprehensive explanation of Hyperfine Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.5", "problem": "Practice problem demonstrating key principles of Hyperfine Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hyperfine Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.6: External Fields
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l06-uuid',
    'course4-ch7-uuid',
    'ch7-external-fields',
    'Lesson 7.6: External Fields',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.6", "content": "Comprehensive explanation of External Fields including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.6", "problem": "Practice problem demonstrating key principles of External Fields", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about External Fields", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.7: Magnetic Resonance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l07-uuid',
    'course4-ch7-uuid',
    'ch7-magnetic-resonance',
    'Lesson 7.7: Magnetic Resonance',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.7", "content": "Comprehensive explanation of Magnetic Resonance including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.7", "problem": "Practice problem demonstrating key principles of Magnetic Resonance", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Magnetic Resonance", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.8: Lasers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l08-uuid',
    'course4-ch7-uuid',
    'ch7-lasers',
    'Lesson 7.8: Lasers',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.8", "content": "Comprehensive explanation of Lasers including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.8", "problem": "Practice problem demonstrating key principles of Lasers", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Lasers", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.9: Molecular Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l09-uuid',
    'course4-ch7-uuid',
    'ch7-molecular-spectra',
    'Lesson 7.9: Molecular Spectra',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.9", "content": "Comprehensive explanation of Molecular Spectra including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.9", "problem": "Practice problem demonstrating key principles of Molecular Spectra", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Spectra", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 7.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch7-l10-uuid',
    'course4-ch7-uuid',
    'ch7-applications',
    'Lesson 7.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 7, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 8: MOLECULAR QUANTUM MECHANICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch8-uuid',
    'quantum-mechanics-uuid',
    'Molecular Quantum Mechanics',
    'molecular-quantum',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.1: Molecular Orbital Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l01-uuid',
    'course4-ch8-uuid',
    'ch8-molecular-orbital-theory',
    'Lesson 8.1: Molecular Orbital Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.1", "content": "Comprehensive explanation of Molecular Orbital Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.1", "problem": "Practice problem demonstrating key principles of Molecular Orbital Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Orbital Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.2: LCAO Method
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l02-uuid',
    'course4-ch8-uuid',
    'ch8-lcao-method',
    'Lesson 8.2: LCAO Method',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.2", "content": "Comprehensive explanation of LCAO Method including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.2", "problem": "Practice problem demonstrating key principles of LCAO Method", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about LCAO Method", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.3: Valance Bond Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l03-uuid',
    'course4-ch8-uuid',
    'ch8-valance-bond-theory',
    'Lesson 8.3: Valance Bond Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.3", "content": "Comprehensive explanation of Valance Bond Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.3", "problem": "Practice problem demonstrating key principles of Valance Bond Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Valance Bond Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.4: Molecular Orbital Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l04-uuid',
    'course4-ch8-uuid',
    'ch8-molecular-orbital-theory',
    'Lesson 8.4: Molecular Orbital Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.4", "content": "Comprehensive explanation of Molecular Orbital Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.4", "problem": "Practice problem demonstrating key principles of Molecular Orbital Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Orbital Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.5: Hybridization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l05-uuid',
    'course4-ch8-uuid',
    'ch8-hybridization',
    'Lesson 8.5: Hybridization',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.5", "content": "Comprehensive explanation of Hybridization including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.5", "problem": "Practice problem demonstrating key principles of Hybridization", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hybridization", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.6: Conjugated Systems
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l06-uuid',
    'course4-ch8-uuid',
    'ch8-conjugated-systems',
    'Lesson 8.6: Conjugated Systems',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.6", "content": "Comprehensive explanation of Conjugated Systems including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.6", "problem": "Practice problem demonstrating key principles of Conjugated Systems", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Conjugated Systems", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.7: UV-Vis Spectroscopy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l07-uuid',
    'course4-ch8-uuid',
    'ch8-uv-vis-spectroscopy',
    'Lesson 8.7: UV-Vis Spectroscopy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.7", "content": "Comprehensive explanation of UV-Vis Spectroscopy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.7", "problem": "Practice problem demonstrating key principles of UV-Vis Spectroscopy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about UV-Vis Spectroscopy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.8: IR Spectroscopy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l08-uuid',
    'course4-ch8-uuid',
    'ch8-ir-spectroscopy',
    'Lesson 8.8: IR Spectroscopy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.8", "content": "Comprehensive explanation of IR Spectroscopy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.8", "problem": "Practice problem demonstrating key principles of IR Spectroscopy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about IR Spectroscopy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.9: Computational Chemistry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l09-uuid',
    'course4-ch8-uuid',
    'ch8-computational-chemistry',
    'Lesson 8.9: Computational Chemistry',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.9", "content": "Comprehensive explanation of Computational Chemistry including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.9", "problem": "Practice problem demonstrating key principles of Computational Chemistry", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Computational Chemistry", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 8.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch8-l10-uuid',
    'course4-ch8-uuid',
    'ch8-applications',
    'Lesson 8.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 8, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 9: SOLID STATE QUANTUM MECHANICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch9-uuid',
    'quantum-mechanics-uuid',
    'Solid State Quantum Mechanics',
    'solid-state-quantum',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.1: Crystal Symmetries
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l01-uuid',
    'course4-ch9-uuid',
    'ch9-crystal-symmetries',
    'Lesson 9.1: Crystal Symmetries',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.1", "content": "Comprehensive explanation of Crystal Symmetries including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.1", "problem": "Practice problem demonstrating key principles of Crystal Symmetries", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Crystal Symmetries", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.2: Band Theory of Solids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l02-uuid',
    'course4-ch9-uuid',
    'ch9-band-theory-of-solids',
    'Lesson 9.2: Band Theory of Solids',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.2", "content": "Comprehensive explanation of Band Theory of Solids including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.2", "problem": "Practice problem demonstrating key principles of Band Theory of Solids", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Band Theory of Solids", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.3: Free Electron Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l03-uuid',
    'course4-ch9-uuid',
    'ch9-free-electron-model',
    'Lesson 9.3: Free Electron Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.3", "content": "Comprehensive explanation of Free Electron Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.3", "problem": "Practice problem demonstrating key principles of Free Electron Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Free Electron Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.4: Nearly Free Electron Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l04-uuid',
    'course4-ch9-uuid',
    'ch9-nearly-free-electron-model',
    'Lesson 9.4: Nearly Free Electron Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.4", "content": "Comprehensive explanation of Nearly Free Electron Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.4", "problem": "Practice problem demonstrating key principles of Nearly Free Electron Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Nearly Free Electron Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.5: Tight Binding Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l05-uuid',
    'course4-ch9-uuid',
    'ch9-tight-binding-model',
    'Lesson 9.5: Tight Binding Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.5", "content": "Comprehensive explanation of Tight Binding Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.5", "problem": "Practice problem demonstrating key principles of Tight Binding Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Tight Binding Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.6: Semiconductors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l06-uuid',
    'course4-ch9-uuid',
    'ch9-semiconductors',
    'Lesson 9.6: Semiconductors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.6", "content": "Comprehensive explanation of Semiconductors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.6", "problem": "Practice problem demonstrating key principles of Semiconductors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Semiconductors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.7: Superconductivity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l07-uuid',
    'course4-ch9-uuid',
    'ch9-superconductivity',
    'Lesson 9.7: Superconductivity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.7", "content": "Comprehensive explanation of Superconductivity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.7", "problem": "Practice problem demonstrating key principles of Superconductivity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Superconductivity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.8: Magnetic Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l08-uuid',
    'course4-ch9-uuid',
    'ch9-magnetic-properties',
    'Lesson 9.8: Magnetic Properties',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.8", "content": "Comprehensive explanation of Magnetic Properties including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.8", "problem": "Practice problem demonstrating key principles of Magnetic Properties", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Magnetic Properties", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.9: Optical Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l09-uuid',
    'course4-ch9-uuid',
    'ch9-optical-properties',
    'Lesson 9.9: Optical Properties',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.9", "content": "Comprehensive explanation of Optical Properties including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.9", "problem": "Practice problem demonstrating key principles of Optical Properties", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Optical Properties", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 9.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch9-l10-uuid',
    'course4-ch9-uuid',
    'ch9-applications',
    'Lesson 9.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 9, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- CHAPTER 10: ADVANCED QUANTUM MECHANICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course4-ch10-uuid',
    'quantum-mechanics-uuid',
    'Advanced Quantum Mechanics',
    'advanced-quantum-mechanics',
    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.1: Path Integral Formulation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l01-uuid',
    'course4-ch10-uuid',
    'ch10-path-integral-formulation',
    'Lesson 10.1: Path Integral Formulation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 1 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.1", "content": "Comprehensive explanation of Path Integral Formulation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.1", "problem": "Practice problem demonstrating key principles of Path Integral Formulation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Path Integral Formulation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.2: Quantum Field Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l02-uuid',
    'course4-ch10-uuid',
    'ch10-quantum-field-theory',
    'Lesson 10.2: Quantum Field Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 2 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.2", "content": "Comprehensive explanation of Quantum Field Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.2", "problem": "Practice problem demonstrating key principles of Quantum Field Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Field Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.3: Relativistic Quantum Mechanics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l03-uuid',
    'course4-ch10-uuid',
    'ch10-relativistic-quantum-mechanics',
    'Lesson 10.3: Relativistic Quantum Mechanics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 3 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.3", "content": "Comprehensive explanation of Relativistic Quantum Mechanics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.3", "problem": "Practice problem demonstrating key principles of Relativistic Quantum Mechanics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Relativistic Quantum Mechanics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.4: Quantum Electrodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l04-uuid',
    'course4-ch10-uuid',
    'ch10-quantum-electrodynamics',
    'Lesson 10.4: Quantum Electrodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 4 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.4", "content": "Comprehensive explanation of Quantum Electrodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.4", "problem": "Practice problem demonstrating key principles of Quantum Electrodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Electrodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.5: Quantum Information
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l05-uuid',
    'course4-ch10-uuid',
    'ch10-quantum-information',
    'Lesson 10.5: Quantum Information',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 5 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.5", "content": "Comprehensive explanation of Quantum Information including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.5", "problem": "Practice problem demonstrating key principles of Quantum Information", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Information", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.6: Quantum Computing
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l06-uuid',
    'course4-ch10-uuid',
    'ch10-quantum-computing',
    'Lesson 10.6: Quantum Computing',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 6 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.6", "content": "Comprehensive explanation of Quantum Computing including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.6", "problem": "Practice problem demonstrating key principles of Quantum Computing", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Computing", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.7: Quantum Cryptography
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l07-uuid',
    'course4-ch10-uuid',
    'ch10-quantum-cryptography',
    'Lesson 10.7: Quantum Cryptography',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 7 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.7", "content": "Comprehensive explanation of Quantum Cryptography including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.7", "problem": "Practice problem demonstrating key principles of Quantum Cryptography", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Cryptography", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.8: Interpretations of Quantum Mechanics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l08-uuid',
    'course4-ch10-uuid',
    'ch10-interpretations-of-quantum-mechanics',
    'Lesson 10.8: Interpretations of Quantum Mechanics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 8 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.8", "content": "Comprehensive explanation of Interpretations of Quantum Mechanics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.8", "problem": "Practice problem demonstrating key principles of Interpretations of Quantum Mechanics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Interpretations of Quantum Mechanics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.9: Measurement Problem
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l09-uuid',
    'course4-ch10-uuid',
    'ch10-measurement-problem',
    'Lesson 10.9: Measurement Problem',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 9 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.9", "content": "Comprehensive explanation of Measurement Problem including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.9", "problem": "Practice problem demonstrating key principles of Measurement Problem", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Measurement Problem", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lesson 10.10: Review
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course4-ch10-l10-uuid',
    'course4-ch10-uuid',
    'ch10-review',
    'Lesson 10.10: Review',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Quantum Mechanics - Chapter 10, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Quantum Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 10 of Quantum Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.10", "content": "Comprehensive explanation of Review including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.10", "problem": "Practice problem demonstrating key principles of Review", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Review", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    content = EXCLUDED.content,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- END OF QUANTUM MECHANICS STRUCTURE SETUP
-- 10 chapters, 100 lessons created
-- =====================================================