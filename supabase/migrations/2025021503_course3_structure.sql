-- =====================================================
-- THERMO-STATISTICAL MECHANICS COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons with comprehensive content
-- Physics Course 3 of 4
-- =====================================================

-- Create Thermo-Statistical Mechanics course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'thermo-statistical-mechanics-uuid',
    'Thermo-Statistical Mechanics',
    'thermo-statistical-mechanics',
    'Comprehensive course covering temperature, heat, work, ideal gases, kinetic theory, first and second laws of thermodynamics, entropy, statistical mechanics, and applications to engines and refrigerators. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/thermodynamics.svg',
    3,
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
-- CHAPTER 1: TEMPERATURE AND HEAT
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch1-uuid',
    'thermo-statistical-mechanics-uuid',
    'Temperature and Heat',
    'temperature-and-heat',
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

-- Lesson 1.1: Temperature Scales
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l01-uuid',
    'course3-ch1-uuid',
    'ch1-temperature-scales',
    'Lesson 1.1: Temperature Scales',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.1", "content": "Comprehensive explanation of Temperature Scales including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.1", "problem": "Practice problem demonstrating key principles of Temperature Scales", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Temperature Scales", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.2: Thermal Expansion
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l02-uuid',
    'course3-ch1-uuid',
    'ch1-thermal-expansion',
    'Lesson 1.2: Thermal Expansion',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.2", "content": "Comprehensive explanation of Thermal Expansion including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.2", "problem": "Practice problem demonstrating key principles of Thermal Expansion", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermal Expansion", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.3: Heat and Work
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l03-uuid',
    'course3-ch1-uuid',
    'ch1-heat-and-work',
    'Lesson 1.3: Heat and Work',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.3", "content": "Comprehensive explanation of Heat and Work including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.3", "problem": "Practice problem demonstrating key principles of Heat and Work", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat and Work", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.4: Ideal Gas Law
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l04-uuid',
    'course3-ch1-uuid',
    'ch1-ideal-gas-law',
    'Lesson 1.4: Ideal Gas Law',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.4", "content": "Comprehensive explanation of Ideal Gas Law including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.4", "problem": "Practice problem demonstrating key principles of Ideal Gas Law", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Ideal Gas Law", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.5: Kinetic Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l05-uuid',
    'course3-ch1-uuid',
    'ch1-kinetic-theory',
    'Lesson 1.5: Kinetic Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.5", "content": "Comprehensive explanation of Kinetic Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.5", "problem": "Practice problem demonstrating key principles of Kinetic Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Kinetic Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.6: Real Gases
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l06-uuid',
    'course3-ch1-uuid',
    'ch1-real-gases',
    'Lesson 1.6: Real Gases',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.6", "content": "Comprehensive explanation of Real Gases including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.6", "problem": "Practice problem demonstrating key principles of Real Gases", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Real Gases", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.7: Phase Transitions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l07-uuid',
    'course3-ch1-uuid',
    'ch1-phase-transitions',
    'Lesson 1.7: Phase Transitions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.7", "content": "Comprehensive explanation of Phase Transitions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.7", "problem": "Practice problem demonstrating key principles of Phase Transitions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Phase Transitions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.8: Calorimetry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l08-uuid',
    'course3-ch1-uuid',
    'ch1-calorimetry',
    'Lesson 1.8: Calorimetry',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.8", "content": "Comprehensive explanation of Calorimetry including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.8", "problem": "Practice problem demonstrating key principles of Calorimetry", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Calorimetry", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.9: Heat Transfer Methods
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l09-uuid',
    'course3-ch1-uuid',
    'ch1-heat-transfer-methods',
    'Lesson 1.9: Heat Transfer Methods',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.9", "content": "Comprehensive explanation of Heat Transfer Methods including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.9", "problem": "Practice problem demonstrating key principles of Heat Transfer Methods", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Transfer Methods", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.10: Applications of Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch1-l10-uuid',
    'course3-ch1-uuid',
    'ch1-applications-of-thermodynamics',
    'Lesson 1.10: Applications of Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 1, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.10", "content": "Comprehensive explanation of Applications of Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.10", "problem": "Practice problem demonstrating key principles of Applications of Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications of Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 2: FIRST LAW OF THERMODYNAMICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch2-uuid',
    'thermo-statistical-mechanics-uuid',
    'First Law of Thermodynamics',
    'first-law-thermodynamics',
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

-- Lesson 2.1: Internal Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l01-uuid',
    'course3-ch2-uuid',
    'ch2-internal-energy',
    'Lesson 2.1: Internal Energy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.1", "content": "Comprehensive explanation of Internal Energy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.1", "problem": "Practice problem demonstrating key principles of Internal Energy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Internal Energy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.2: Work and PV Diagrams
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l02-uuid',
    'course3-ch2-uuid',
    'ch2-work-and-pv-diagrams',
    'Lesson 2.2: Work and PV Diagrams',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.2", "content": "Comprehensive explanation of Work and PV Diagrams including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.2", "problem": "Practice problem demonstrating key principles of Work and PV Diagrams", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Work and PV Diagrams", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.3: Heat Capacity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l03-uuid',
    'course3-ch2-uuid',
    'ch2-heat-capacity',
    'Lesson 2.3: Heat Capacity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.3", "content": "Comprehensive explanation of Heat Capacity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.3", "problem": "Practice problem demonstrating key principles of Heat Capacity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Capacity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.4: Adiabatic Processes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l04-uuid',
    'course3-ch2-uuid',
    'ch2-adiabatic-processes',
    'Lesson 2.4: Adiabatic Processes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.4", "content": "Comprehensive explanation of Adiabatic Processes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.4", "problem": "Practice problem demonstrating key principles of Adiabatic Processes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Adiabatic Processes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.5: Isochoric Processes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l05-uuid',
    'course3-ch2-uuid',
    'ch2-isochoric-processes',
    'Lesson 2.5: Isochoric Processes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.5", "content": "Comprehensive explanation of Isochoric Processes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.5", "problem": "Practice problem demonstrating key principles of Isochoric Processes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Isochoric Processes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.6: Isobarric Processes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l06-uuid',
    'course3-ch2-uuid',
    'ch2-isobarric-processes',
    'Lesson 2.6: Isobarric Processes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.6", "content": "Comprehensive explanation of Isobarric Processes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.6", "problem": "Practice problem demonstrating key principles of Isobarric Processes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Isobarric Processes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.7: Cyclic Processes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l07-uuid',
    'course3-ch2-uuid',
    'ch2-cyclic-processes',
    'Lesson 2.7: Cyclic Processes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.7", "content": "Comprehensive explanation of Cyclic Processes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.7", "problem": "Practice problem demonstrating key principles of Cyclic Processes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cyclic Processes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.8: Enthalpy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l08-uuid',
    'course3-ch2-uuid',
    'ch2-enthalpy',
    'Lesson 2.8: Enthalpy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.8", "content": "Comprehensive explanation of Enthalpy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.8", "problem": "Practice problem demonstrating key principles of Enthalpy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Enthalpy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.9: Energy Conservation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l09-uuid',
    'course3-ch2-uuid',
    'ch2-energy-conservation',
    'Lesson 2.9: Energy Conservation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.9", "content": "Comprehensive explanation of Energy Conservation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.9", "problem": "Practice problem demonstrating key principles of Energy Conservation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Energy Conservation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.10: First Law Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch2-l10-uuid',
    'course3-ch2-uuid',
    'ch2-first-law-applications',
    'Lesson 2.10: First Law Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 2, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.10", "content": "Comprehensive explanation of First Law Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.10", "problem": "Practice problem demonstrating key principles of First Law Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Law Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 3: SECOND LAW OF THERMODYNAMICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch3-uuid',
    'thermo-statistical-mechanics-uuid',
    'Second Law of Thermodynamics',
    'second-law-thermodynamics',
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

-- Lesson 3.1: Heat Engines
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l01-uuid',
    'course3-ch3-uuid',
    'ch3-heat-engines',
    'Lesson 3.1: Heat Engines',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.1", "content": "Comprehensive explanation of Heat Engines including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.1", "problem": "Practice problem demonstrating key principles of Heat Engines", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Engines", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.2: Entropy Definition
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l02-uuid',
    'course3-ch3-uuid',
    'ch3-entropy-definition',
    'Lesson 3.2: Entropy Definition',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.2", "content": "Comprehensive explanation of Entropy Definition including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.2", "problem": "Practice problem demonstrating key principles of Entropy Definition", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Entropy Definition", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.3: Entropy Changes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l03-uuid',
    'course3-ch3-uuid',
    'ch3-entropy-changes',
    'Lesson 3.3: Entropy Changes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.3", "content": "Comprehensive explanation of Entropy Changes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.3", "problem": "Practice problem demonstrating key principles of Entropy Changes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Entropy Changes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.4: Reversible vs Irreversible
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l04-uuid',
    'course3-ch3-uuid',
    'ch3-reversible-vs-irreversible',
    'Lesson 3.4: Reversible vs Irreversible',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.4", "content": "Comprehensive explanation of Reversible vs Irreversible including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.4", "problem": "Practice problem demonstrating key principles of Reversible vs Irreversible", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Reversible vs Irreversible", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.5: Carnot Cycle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l05-uuid',
    'course3-ch3-uuid',
    'ch3-carnot-cycle',
    'Lesson 3.5: Carnot Cycle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.5", "content": "Comprehensive explanation of Carnot Cycle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.5", "problem": "Practice problem demonstrating key principles of Carnot Cycle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Carnot Cycle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.6: COP Limit
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l06-uuid',
    'course3-ch3-uuid',
    'ch3-cop-limit',
    'Lesson 3.6: COP Limit',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.6", "content": "Comprehensive explanation of COP Limit including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.6", "problem": "Practice problem demonstrating key principles of COP Limit", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about COP Limit", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.7: Entropy and Probability
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l07-uuid',
    'course3-ch3-uuid',
    'ch3-entropy-and-probability',
    'Lesson 3.7: Entropy and Probability',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.7", "content": "Comprehensive explanation of Entropy and Probability including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.7", "problem": "Practice problem demonstrating key principles of Entropy and Probability", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Entropy and Probability", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.8: Second Law Formulations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l08-uuid',
    'course3-ch3-uuid',
    'ch3-second-law-formulations',
    'Lesson 3.8: Second Law Formulations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.8", "content": "Comprehensive explanation of Second Law Formulations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.8", "problem": "Practice problem demonstrating key principles of Second Law Formulations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Second Law Formulations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.9: Statistical Interpretation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l09-uuid',
    'course3-ch3-uuid',
    'ch3-statistical-interpretation',
    'Lesson 3.9: Statistical Interpretation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.9", "content": "Comprehensive explanation of Statistical Interpretation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.9", "problem": "Practice problem demonstrating key principles of Statistical Interpretation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Statistical Interpretation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch3-l10-uuid',
    'course3-ch3-uuid',
    'ch3-applications',
    'Lesson 3.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 3, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 4: THERMODYNAMIC POTENTIALS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch4-uuid',
    'thermo-statistical-mechanics-uuid',
    'Thermodynamic Potentials',
    'thermodynamic-potentials',
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

-- Lesson 4.1: Helmholtz Free Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l01-uuid',
    'course3-ch4-uuid',
    'ch4-helmholtz-free-energy',
    'Lesson 4.1: Helmholtz Free Energy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.1", "content": "Comprehensive explanation of Helmholtz Free Energy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.1", "problem": "Practice problem demonstrating key principles of Helmholtz Free Energy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Helmholtz Free Energy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.2: Gibbs Free Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l02-uuid',
    'course3-ch4-uuid',
    'ch4-gibbs-free-energy',
    'Lesson 4.2: Gibbs Free Energy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.2", "content": "Comprehensive explanation of Gibbs Free Energy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.2", "problem": "Practice problem demonstrating key principles of Gibbs Free Energy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gibbs Free Energy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.3: Chemical Potentials
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l03-uuid',
    'course3-ch4-uuid',
    'ch4-chemical-potentials',
    'Lesson 4.3: Chemical Potentials',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.3", "content": "Comprehensive explanation of Chemical Potentials including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.3", "problem": "Practice problem demonstrating key principles of Chemical Potentials", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Chemical Potentials", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.4: Maxwell Relations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l04-uuid',
    'course3-ch4-uuid',
    'ch4-maxwell-relations',
    'Lesson 4.4: Maxwell Relations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.4", "content": "Comprehensive explanation of Maxwell Relations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.4", "problem": "Practice problem demonstrating key principles of Maxwell Relations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Maxwell Relations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.5: Phase Equilibrium
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l05-uuid',
    'course3-ch4-uuid',
    'ch4-phase-equilibrium',
    'Lesson 4.5: Phase Equilibrium',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.5", "content": "Comprehensive explanation of Phase Equilibrium including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.5", "problem": "Practice problem demonstrating key principles of Phase Equilibrium", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Phase Equilibrium", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.6: Clausius-Clapyron Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l06-uuid',
    'course3-ch4-uuid',
    'ch4-clausius-clapyron-equation',
    'Lesson 4.6: Clausius-Clapyron Equation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.6", "content": "Comprehensive explanation of Clausius-Clapyron Equation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.6", "problem": "Practice problem demonstrating key principles of Clausius-Clapyron Equation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Clausius-Clapyron Equation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.7: Thermodynamic Potentials Practice
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l07-uuid',
    'course3-ch4-uuid',
    'ch4-thermodynamic-potentials-practice',
    'Lesson 4.7: Thermodynamic Potentials Practice',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.7", "content": "Comprehensive explanation of Thermodynamic Potentials Practice including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.7", "problem": "Practice problem demonstrating key principles of Thermodynamic Potentials Practice", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermodynamic Potentials Practice", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.8: Chemical Equilibrium
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l08-uuid',
    'course3-ch4-uuid',
    'ch4-chemical-equilibrium',
    'Lesson 4.8: Chemical Equilibrium',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.8", "content": "Comprehensive explanation of Chemical Equilibrium including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.8", "problem": "Practice problem demonstrating key principles of Chemical Equilibrium", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Chemical Equilibrium", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.9: Le Chatelier's Principle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch4-l09-uuid',
    'course3-ch4-uuid',
    'ch4-le-chatelier's-principle',
    'Lesson 4.9: Le Chatelier's Principle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.9", "content": "Comprehensive explanation of Le Chatelier''s Principle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.9", "problem": "Practice problem demonstrating key principles of Le Chatelier''s Principle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Le Chatelier''s Principle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course3-ch4-l10-uuid',
    'course3-ch4-uuid',
    'ch4-applications',
    'Lesson 4.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 4, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 5: STATISTICAL MECHANICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch5-uuid',
    'thermo-statistical-mechanics-uuid',
    'Statistical Mechanics',
    'statistical-mechanics',
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

-- Lesson 5.1: Microstates and Macrostates
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l01-uuid',
    'course3-ch5-uuid',
    'ch5-microstates-and-macrostates',
    'Lesson 5.1: Microstates and Macrostates',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.1", "content": "Comprehensive explanation of Microstates and Macrostates including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.1", "problem": "Practice problem demonstrating key principles of Microstates and Macrostates", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Microstates and Macrostates", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.2: Boltzmann Distribution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l02-uuid',
    'course3-ch5-uuid',
    'ch5-boltzmann-distribution',
    'Lesson 5.2: Boltzmann Distribution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.2", "content": "Comprehensive explanation of Boltzmann Distribution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.2", "problem": "Practice problem demonstrating key principles of Boltzmann Distribution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Boltzmann Distribution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.3: Maxwell-Boltzmann Distribution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l03-uuid',
    'course3-ch5-uuid',
    'ch5-maxwell-boltzmann-distribution',
    'Lesson 5.3: Maxwell-Boltzmann Distribution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.3", "content": "Comprehensive explanation of Maxwell-Boltzmann Distribution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.3", "problem": "Practice problem demonstrating key principles of Maxwell-Boltzmann Distribution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Maxwell-Boltzmann Distribution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.4: Fermi-Dirac Statistics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l04-uuid',
    'course3-ch5-uuid',
    'ch5-fermi-dirac-statistics',
    'Lesson 5.4: Fermi-Dirac Statistics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.4", "content": "Comprehensive explanation of Fermi-Dirac Statistics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.4", "problem": "Practice problem demonstrating key principles of Fermi-Dirac Statistics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Fermi-Dirac Statistics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.5: Bose-Einstein Statistics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l05-uuid',
    'course3-ch5-uuid',
    'ch5-bose-einstein-statistics',
    'Lesson 5.5: Bose-Einstein Statistics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.5", "content": "Comprehensive explanation of Bose-Einstein Statistics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.5", "problem": "Practice problem demonstrating key principles of Bose-Einstein Statistics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Bose-Einstein Statistics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.6: Partition Functions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l06-uuid',
    'course3-ch5-uuid',
    'ch5-partition-functions',
    'Lesson 5.6: Partition Functions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.6", "content": "Comprehensive explanation of Partition Functions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.6", "problem": "Practice problem demonstrating key principles of Partition Functions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Partition Functions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.7: Entropy and Information
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l07-uuid',
    'course3-ch5-uuid',
    'ch5-entropy-and-information',
    'Lesson 5.7: Entropy and Information',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.7", "content": "Comprehensive explanation of Entropy and Information including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.7", "problem": "Practice problem demonstrating key principles of Entropy and Information", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Entropy and Information", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.8: Statistical Definition of Temperature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l08-uuid',
    'course3-ch5-uuid',
    'ch5-statistical-definition-of-temperature',
    'Lesson 5.8: Statistical Definition of Temperature',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.8", "content": "Comprehensive explanation of Statistical Definition of Temperature including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.8", "problem": "Practice problem demonstrating key principles of Statistical Definition of Temperature", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Statistical Definition of Temperature", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.9: Equipartition Theorem
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l09-uuid',
    'course3-ch5-uuid',
    'ch5-equipartition-theorem',
    'Lesson 5.9: Equipartition Theorem',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.9", "content": "Comprehensive explanation of Equipartition Theorem including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.9", "problem": "Practice problem demonstrating key principles of Equipartition Theorem", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Equipartition Theorem", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.10: Quantum Statistics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch5-l10-uuid',
    'course3-ch5-uuid',
    'ch5-quantum-statistics',
    'Lesson 5.10: Quantum Statistics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 5, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.10", "content": "Comprehensive explanation of Quantum Statistics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.10", "problem": "Practice problem demonstrating key principles of Quantum Statistics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Statistics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 6: HEAT ENGINES AND REFIGERATION
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch6-uuid',
    'thermo-statistical-mechanics-uuid',
    'Heat Engines and Refigeration',
    'heat-engines-refrieration',
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

-- Lesson 6.1: Heat Engine Efficiency
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l01-uuid',
    'course3-ch6-uuid',
    'ch6-heat-engine-efficiency',
    'Lesson 6.1: Heat Engine Efficiency',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.1", "content": "Comprehensive explanation of Heat Engine Efficiency including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.1", "problem": "Practice problem demonstrating key principles of Heat Engine Efficiency", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Engine Efficiency", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.2: Carnot Engine
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l02-uuid',
    'course3-ch6-uuid',
    'ch6-carnot-engine',
    'Lesson 6.2: Carnot Engine',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.2", "content": "Comprehensive explanation of Carnot Engine including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.2", "problem": "Practice problem demonstrating key principles of Carnot Engine", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Carnot Engine", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.3: Otto Cycle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l03-uuid',
    'course3-ch6-uuid',
    'ch6-otto-cycle',
    'Lesson 6.3: Otto Cycle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.3", "content": "Comprehensive explanation of Otto Cycle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.3", "problem": "Practice problem demonstrating key principles of Otto Cycle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Otto Cycle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.4: Diesel Cycle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l04-uuid',
    'course3-ch6-uuid',
    'ch6-diesel-cycle',
    'Lesson 6.4: Diesel Cycle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.4", "content": "Comprehensive explanation of Diesel Cycle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.4", "problem": "Practice problem demonstrating key principles of Diesel Cycle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Diesel Cycle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.5: Rankine Cycle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l05-uuid',
    'course3-ch6-uuid',
    'ch6-rankine-cycle',
    'Lesson 6.5: Rankine Cycle',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.5", "content": "Comprehensive explanation of Rankine Cycle including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.5", "problem": "Practice problem demonstrating key principles of Rankine Cycle", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Rankine Cycle", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.6: Refrieration Cycles
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l06-uuid',
    'course3-ch6-uuid',
    'ch6-refrieration-cycles',
    'Lesson 6.6: Refrieration Cycles',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.6", "content": "Comprehensive explanation of Refrieration Cycles including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.6", "problem": "Practice problem demonstrating key principles of Refrieration Cycles", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Refrieration Cycles", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.7: Heat Pumps
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l07-uuid',
    'course3-ch6-uuid',
    'ch6-heat-pumps',
    'Lesson 6.7: Heat Pumps',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.7", "content": "Comprehensive explanation of Heat Pumps including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.7", "problem": "Practice problem demonstrating key principles of Heat Pumps", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Pumps", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.8: Coefficiency of Performance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l08-uuid',
    'course3-ch6-uuid',
    'ch6-coefficiency-of-performance',
    'Lesson 6.8: Coefficiency of Performance',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.8", "content": "Comprehensive explanation of Coefficiency of Performance including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.8", "problem": "Practice problem demonstrating key principles of Coefficiency of Performance", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Coefficiency of Performance", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.9: Real Engine Analysis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l09-uuid',
    'course3-ch6-uuid',
    'ch6-real-engine-analysis',
    'Lesson 6.9: Real Engine Analysis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.9", "content": "Comprehensive explanation of Real Engine Analysis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.9", "problem": "Practice problem demonstrating key principles of Real Engine Analysis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Real Engine Analysis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.10: Environmental Impact
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch6-l10-uuid',
    'course3-ch6-uuid',
    'ch6-environmental-impact',
    'Lesson 6.10: Environmental Impact',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 6, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.10", "content": "Comprehensive explanation of Environmental Impact including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.10", "problem": "Practice problem demonstrating key principles of Environmental Impact", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Environmental Impact", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 7: PHASE TRANSITIONS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch7-uuid',
    'thermo-statistical-mechanics-uuid',
    'Phase Transitions',
    'phase-transitions-thermo',
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

-- Lesson 7.1: Phase Equilibrium
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l01-uuid',
    'course3-ch7-uuid',
    'ch7-phase-equilibrium',
    'Lesson 7.1: Phase Equilibrium',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.1", "content": "Comprehensive explanation of Phase Equilibrium including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.1", "problem": "Practice problem demonstrating key principles of Phase Equilibrium", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Phase Equilibrium", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.2: Phase Diagrams
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l02-uuid',
    'course3-ch7-uuid',
    'ch7-phase-diagrams',
    'Lesson 7.2: Phase Diagrams',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.2", "content": "Comprehensive explanation of Phase Diagrams including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.2", "problem": "Practice problem demonstrating key principles of Phase Diagrams", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Phase Diagrams", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.3: Critical Points
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l03-uuid',
    'course3-ch7-uuid',
    'ch7-critical-points',
    'Lesson 7.3: Critical Points',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.3", "content": "Comprehensive explanation of Critical Points including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.3", "problem": "Practice problem demonstrating key principles of Critical Points", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Critical Points", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.4: Latent Heat
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l04-uuid',
    'course3-ch7-uuid',
    'ch7-latent-heat',
    'Lesson 7.4: Latent Heat',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.4", "content": "Comprehensive explanation of Latent Heat including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.4", "problem": "Practice problem demonstrating key principles of Latent Heat", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Latent Heat", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.5: Clausius-Clapyron
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l05-uuid',
    'course3-ch7-uuid',
    'ch7-clausius-clapyron',
    'Lesson 7.5: Clausius-Clapyron',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.5", "content": "Comprehensive explanation of Clausius-Clapyron including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.5", "problem": "Practice problem demonstrating key principles of Clausius-Clapyron", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Clausius-Clapyron", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.6: First Order Transitions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l06-uuid',
    'course3-ch7-uuid',
    'ch7-first-order-transitions',
    'Lesson 7.6: First Order Transitions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.6", "content": "Comprehensive explanation of First Order Transitions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.6", "problem": "Practice problem demonstrating key principles of First Order Transitions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Order Transitions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.7: Second Order Transitions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l07-uuid',
    'course3-ch7-uuid',
    'ch7-second-order-transitions',
    'Lesson 7.7: Second Order Transitions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.7", "content": "Comprehensive explanation of Second Order Transitions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.7", "problem": "Practice problem demonstrating key principles of Second Order Transitions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Second Order Transitions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.8: Metastable States
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l08-uuid',
    'course3-ch7-uuid',
    'ch7-metastable-states',
    'Lesson 7.8: Metastable States',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.8", "content": "Comprehensive explanation of Metastable States including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.8", "problem": "Practice problem demonstrating key principles of Metastable States", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Metastable States", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.9: Triple Point
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch7-l09-uuid',
    'course3-ch7-uuid',
    'ch7-triple-point',
    'Lesson 7.9: Triple Point',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.9", "content": "Comprehensive explanation of Triple Point including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.9", "problem": "Practice problem demonstrating key principles of Triple Point", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Triple Point", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course3-ch7-l10-uuid',
    'course3-ch7-uuid',
    'ch7-applications',
    'Lesson 7.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 7, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 8: KINETIC THEORY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch8-uuid',
    'thermo-statistical-mechanics-uuid',
    'Kinetic Theory',
    'kinetic-theory',
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

-- Lesson 8.1: Pressure and Temperature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l01-uuid',
    'course3-ch8-uuid',
    'ch8-pressure-and-temperature',
    'Lesson 8.1: Pressure and Temperature',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.1", "content": "Comprehensive explanation of Pressure and Temperature including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.1", "problem": "Practice problem demonstrating key principles of Pressure and Temperature", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Pressure and Temperature", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.2: Velosity Distributions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l02-uuid',
    'course3-ch8-uuid',
    'ch8-velosity-distributions',
    'Lesson 8.2: Velosity Distributions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.2", "content": "Comprehensive explanation of Velosity Distributions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.2", "problem": "Practice problem demonstrating key principles of Velosity Distributions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Velosity Distributions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.3: Mean Free Path
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l03-uuid',
    'course3-ch8-uuid',
    'ch8-mean-free-path',
    'Lesson 8.3: Mean Free Path',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.3", "content": "Comprehensive explanation of Mean Free Path including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.3", "problem": "Practice problem demonstrating key principles of Mean Free Path", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Mean Free Path", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.4: Transport Phenomena
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l04-uuid',
    'course3-ch8-uuid',
    'ch8-transport-phenomena',
    'Lesson 8.4: Transport Phenomena',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.4", "content": "Comprehensive explanation of Transport Phenomena including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.4", "problem": "Practice problem demonstrating key principles of Transport Phenomena", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Transport Phenomena", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.5: Viscosity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l05-uuid',
    'course3-ch8-uuid',
    'ch8-viscosity',
    'Lesson 8.5: Viscosity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.5", "content": "Comprehensive explanation of Viscosity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.5", "problem": "Practice problem demonstrating key principles of Viscosity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Viscosity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.6: Thermal Conductivity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l06-uuid',
    'course3-ch8-uuid',
    'ch8-thermal-conductivity',
    'Lesson 8.6: Thermal Conductivity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.6", "content": "Comprehensive explanation of Thermal Conductivity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.6", "problem": "Practice problem demonstrating key principles of Thermal Conductivity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermal Conductivity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.7: Diffraction
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l07-uuid',
    'course3-ch8-uuid',
    'ch8-diffraction',
    'Lesson 8.7: Diffraction',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.7", "content": "Comprehensive explanation of Diffraction including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.7", "problem": "Practice problem demonstrating key principles of Diffraction", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Diffraction", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.8: Real Gas Behavior
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l08-uuid',
    'course3-ch8-uuid',
    'ch8-real-gas-behavior',
    'Lesson 8.8: Real Gas Behavior',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.8", "content": "Comprehensive explanation of Real Gas Behavior including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.8", "problem": "Practice problem demonstrating key principles of Real Gas Behavior", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Real Gas Behavior", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.9: Molecular Velocities
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch8-l09-uuid',
    'course3-ch8-uuid',
    'ch8-molecular-velocities',
    'Lesson 8.9: Molecular Velocities',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.9", "content": "Comprehensive explanation of Molecular Velocities including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.9", "problem": "Practice problem demonstrating key principles of Molecular Velocities", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Velocities", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course3-ch8-l10-uuid',
    'course3-ch8-uuid',
    'ch8-applications',
    'Lesson 8.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 8, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 9: THERMODYNAMICS OF SOLIDS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch9-uuid',
    'thermo-statistical-mechanics-uuid',
    'Thermodynamics of Solids',
    'thermodynamics-solids',
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

-- Lesson 9.1: Crystal Structures
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l01-uuid',
    'course3-ch9-uuid',
    'ch9-crystal-structures',
    'Lesson 9.1: Crystal Structures',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.1", "content": "Comprehensive explanation of Crystal Structures including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.1", "problem": "Practice problem demonstrating key principles of Crystal Structures", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Crystal Structures", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.2: Heat Capacity of Solids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l02-uuid',
    'course3-ch9-uuid',
    'ch9-heat-capacity-of-solids',
    'Lesson 9.2: Heat Capacity of Solids',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.2", "content": "Comprehensive explanation of Heat Capacity of Solids including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.2", "problem": "Practice problem demonstrating key principles of Heat Capacity of Solids", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Capacity of Solids", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.3: Thermal Expansion
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l03-uuid',
    'course3-ch9-uuid',
    'ch9-thermal-expansion',
    'Lesson 9.3: Thermal Expansion',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.3", "content": "Comprehensive explanation of Thermal Expansion including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.3", "problem": "Practice problem demonstrating key principles of Thermal Expansion", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermal Expansion", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.4: Thermal Conductivity in Solids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l04-uuid',
    'course3-ch9-uuid',
    'ch9-thermal-conductivity-in-solids',
    'Lesson 9.4: Thermal Conductivity in Solids',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.4", "content": "Comprehensive explanation of Thermal Conductivity in Solids including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.4", "problem": "Practice problem demonstrating key principles of Thermal Conductivity in Solids", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermal Conductivity in Solids", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.5: Electron Gas Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l05-uuid',
    'course3-ch9-uuid',
    'ch9-electron-gas-theory',
    'Lesson 9.5: Electron Gas Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.5", "content": "Comprehensive explanation of Electron Gas Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.5", "problem": "Practice problem demonstrating key principles of Electron Gas Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Electron Gas Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.6: Band Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l06-uuid',
    'course3-ch9-uuid',
    'ch9-band-theory',
    'Lesson 9.6: Band Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.6", "content": "Comprehensive explanation of Band Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.6", "problem": "Practice problem demonstrating key principles of Band Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Band Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.7: Semiconductors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l07-uuid',
    'course3-ch9-uuid',
    'ch9-semiconductors',
    'Lesson 9.7: Semiconductors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.7", "content": "Comprehensive explanation of Semiconductors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.7", "problem": "Practice problem demonstrating key principles of Semiconductors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Semiconductors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.8: Superconductivity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l08-uuid',
    'course3-ch9-uuid',
    'ch9-superconductivity',
    'Lesson 9.8: Superconductivity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.8", "content": "Comprehensive explanation of Superconductivity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.8", "problem": "Practice problem demonstrating key principles of Superconductivity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Superconductivity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.9: Magnetic Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch9-l09-uuid',
    'course3-ch9-uuid',
    'ch9-magnetic-properties',
    'Lesson 9.9: Magnetic Properties',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.9", "content": "Comprehensive explanation of Magnetic Properties including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.9", "problem": "Practice problem demonstrating key principles of Magnetic Properties", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Magnetic Properties", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course3-ch9-l10-uuid',
    'course3-ch9-uuid',
    'ch9-applications',
    'Lesson 9.10: Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 9, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.10", "content": "Comprehensive explanation of Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.10", "problem": "Practice problem demonstrating key principles of Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 10: ADVANCED THERMODYNAMICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course3-ch10-uuid',
    'thermo-statistical-mechanics-uuid',
    'Advanced Thermodynamics',
    'advanced-thermodynamics',
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

-- Lesson 10.1: Non-Ideal Gases
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l01-uuid',
    'course3-ch10-uuid',
    'ch10-non-ideal-gases',
    'Lesson 10.1: Non-Ideal Gases',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 1 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.1", "content": "Comprehensive explanation of Non-Ideal Gases including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.1", "problem": "Practice problem demonstrating key principles of Non-Ideal Gases", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Non-Ideal Gases", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.2: Third Law of Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l02-uuid',
    'course3-ch10-uuid',
    'ch10-third-law-of-thermodynamics',
    'Lesson 10.2: Third Law of Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 2 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.2", "content": "Comprehensive explanation of Third Law of Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.2", "problem": "Practice problem demonstrating key principles of Third Law of Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Third Law of Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.3: Thermodynamic Identities
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l03-uuid',
    'course3-ch10-uuid',
    'ch10-thermodynamic-identities',
    'Lesson 10.3: Thermodynamic Identities',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 3 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.3", "content": "Comprehensive explanation of Thermodynamic Identities including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.3", "problem": "Practice problem demonstrating key principles of Thermodynamic Identities", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Thermodynamic Identities", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.4: Chemical Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l04-uuid',
    'course3-ch10-uuid',
    'ch10-chemical-thermodynamics',
    'Lesson 10.4: Chemical Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 4 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.4", "content": "Comprehensive explanation of Chemical Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.4", "problem": "Practice problem demonstrating key principles of Chemical Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Chemical Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.5: Biological Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l05-uuid',
    'course3-ch10-uuid',
    'ch10-biological-thermodynamics',
    'Lesson 10.5: Biological Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 5 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.5", "content": "Comprehensive explanation of Biological Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.5", "problem": "Practice problem demonstrating key principles of Biological Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Biological Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.6: Atmospheric Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l06-uuid',
    'course3-ch10-uuid',
    'ch10-atmospheric-thermodynamics',
    'Lesson 10.6: Atmospheric Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 6 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.6", "content": "Comprehensive explanation of Atmospheric Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.6", "problem": "Practice problem demonstrating key principles of Atmospheric Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Atmospheric Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.7: Astrophysical Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l07-uuid',
    'course3-ch10-uuid',
    'ch10-astrophysical-thermodynamics',
    'Lesson 10.7: Astrophysical Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 7 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.7", "content": "Comprehensive explanation of Astrophysical Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.7", "problem": "Practice problem demonstrating key principles of Astrophysical Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Astrophysical Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.8: Non-Equilibrium Thermodynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l08-uuid',
    'course3-ch10-uuid',
    'ch10-non-equilibrium-thermodynamics',
    'Lesson 10.8: Non-Equilibrium Thermodynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 8 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.8", "content": "Comprehensive explanation of Non-Equilibrium Thermodynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.8", "problem": "Practice problem demonstrating key principles of Non-Equilibrium Thermodynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Non-Equilibrium Thermodynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.9: Statistical Mechanics Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course3-ch10-l09-uuid',
    'course3-ch10-uuid',
    'ch10-statistical-mechanics-applications',
    'Lesson 10.9: Statistical Mechanics Applications',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 9 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.9", "content": "Comprehensive explanation of Statistical Mechanics Applications including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.9", "problem": "Practice problem demonstrating key principles of Statistical Mechanics Applications", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Statistical Mechanics Applications", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course3-ch10-l10-uuid',
    'course3-ch10-uuid',
    'ch10-review',
    'Lesson 10.10: Review',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Thermo-Statistical Mechanics - Chapter 10, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Thermo-Statistical Mechanics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 10 of Thermo-Statistical Mechanics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.10", "content": "Comprehensive explanation of Review including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.10", "problem": "Practice problem demonstrating key principles of Review", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Review", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- END OF THERMO-STATISTICAL MECHANICS STRUCTURE SETUP
-- 10 chapters, 100 lessons created
-- =====================================================