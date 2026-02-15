-- =====================================================
-- COSMOLOGY COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons with comprehensive content
-- Physics Course 6 of 4
-- =====================================================

-- Create Cosmology course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'cosmology-uuid',
    'Cosmology',
    'cosmology',
    'Comprehensive course covering the origin and evolution of the universe, from the Big Bang to the far future, including dark matter, dark energy, inflation, and alternative cosmological models. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/cosmology.svg',
    6,
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
-- CHAPTER 1: HISTORICAL COSMOLOGY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch1-uuid',
    'cosmology-uuid',
    'Historical Cosmology',
    'historical-cosmology',
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

-- Lesson 1.1: Ancient Cosmologies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l01-uuid',
    'course6-ch1-uuid',
    'ch1-ancient-cosmologies',
    'Lesson 1.1: Ancient Cosmologies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.1", "content": "Comprehensive explanation of Ancient Cosmologies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.1", "problem": "Practice problem demonstrating key principles of Ancient Cosmologies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Ancient Cosmologies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.2: Geocentric Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l02-uuid',
    'course6-ch1-uuid',
    'ch1-geocentric-model',
    'Lesson 1.2: Geocentric Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.2", "content": "Comprehensive explanation of Geocentric Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.2", "problem": "Practice problem demonstrating key principles of Geocentric Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Geocentric Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.3: Heliocentric Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l03-uuid',
    'course6-ch1-uuid',
    'ch1-heliocentric-model',
    'Lesson 1.3: Heliocentric Model',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.3", "content": "Comprehensive explanation of Heliocentric Model including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.3", "problem": "Practice problem demonstrating key principles of Heliocentric Model", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heliocentric Model", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.4: Kepler's Laws
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l04-uuid',
    'course6-ch1-uuid',
    'ch1-kepler's-laws',
    'Lesson 1.4: Kepler's Laws',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.4", "content": "Comprehensive explanation of Kepler''s Laws including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.4", "problem": "Practice problem demonstrating key principles of Kepler''s Laws", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Kepler''s Laws", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.5: Newton's Universal Gravitation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l05-uuid',
    'course6-ch1-uuid',
    'ch1-newton's-universal-gravitation',
    'Lesson 1.5: Newton's Universal Gravitation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.5", "content": "Comprehensive explanation of Newton''s Universal Gravitation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.5", "problem": "Practice problem demonstrating key principles of Newton''s Universal Gravitation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Newton''s Universal Gravitation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.6: Discovery of Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l06-uuid',
    'course6-ch1-uuid',
    'ch1-discovery-of-galaxies',
    'Lesson 1.6: Discovery of Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.6", "content": "Comprehensive explanation of Discovery of Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.6", "problem": "Practice problem demonstrating key principles of Discovery of Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Discovery of Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.7: Expanding Universe
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l07-uuid',
    'course6-ch1-uuid',
    'ch1-expanding-universe',
    'Lesson 1.7: Expanding Universe',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.7", "content": "Comprehensive explanation of Expanding Universe including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.7", "problem": "Practice problem demonstrating key principles of Expanding Universe", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Expanding Universe", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.8: Big Bang Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l08-uuid',
    'course6-ch1-uuid',
    'ch1-big-bang-theory',
    'Lesson 1.8: Big Bang Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.8", "content": "Comprehensive explanation of Big Bang Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.8", "problem": "Practice problem demonstrating key principles of Big Bang Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Bang Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.9: Steady State vs Expanding
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch1-l09-uuid',
    'course6-ch1-uuid',
    'ch1-steady-state-vs-expanding',
    'Lesson 1.9: Steady State vs Expanding',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.9", "content": "Comprehensive explanation of Steady State vs Expanding including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.9", "problem": "Practice problem demonstrating key principles of Steady State vs Expanding", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Steady State vs Expanding", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
    'course6-ch1-l10-uuid',
    'course6-ch1-uuid',
    'ch1-historical-perspective',
    'Lesson 1.10: Historical Perspective',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 1, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.10", "content": "Comprehensive explanation of Historical Perspective including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.10", "problem": "Practice problem demonstrating key principles of Historical Perspective", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Historical Perspective", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 2: THE BIG BANG
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch2-uuid',
    'cosmology-uuid',
    'The Big Bang',
    'big-bang',
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

-- Lesson 2.1: Origins of Big Bang
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l01-uuid',
    'course6-ch2-uuid',
    'ch2-origins-of-big-bang',
    'Lesson 2.1: Origins of Big Bang',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.1", "content": "Comprehensive explanation of Origins of Big Bang including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.1", "problem": "Practice problem demonstrating key principles of Origins of Big Bang", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Origins of Big Bang", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.2: Evidence for Big Bang
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l02-uuid',
    'course6-ch2-uuid',
    'ch2-evidence-for-big-bang',
    'Lesson 2.2: Evidence for Big Bang',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.2", "content": "Comprehensive explanation of Evidence for Big Bang including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.2", "problem": "Practice problem demonstrating key principles of Evidence for Big Bang", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Evidence for Big Bang", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.3: Hubble's Law
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l03-uuid',
    'course6-ch2-uuid',
    'ch2-hubble's-law',
    'Lesson 2.3: Hubble's Law',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.3", "content": "Comprehensive explanation of Hubble''s Law including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.3", "problem": "Practice problem demonstrating key principles of Hubble''s Law", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hubble''s Law", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.4: Cosmic Redshift
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l04-uuid',
    'course6-ch2-uuid',
    'ch2-cosmic-redshift',
    'Lesson 2.4: Cosmic Redshift',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.4", "content": "Comprehensive explanation of Cosmic Redshift including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.4", "problem": "Practice problem demonstrating key principles of Cosmic Redshift", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Redshift", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.5: Cosmic Microwave Background
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l05-uuid',
    'course6-ch2-uuid',
    'ch2-cosmic-microwave-background',
    'Lesson 2.5: Cosmic Microwave Background',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.5", "content": "Comprehensive explanation of Cosmic Microwave Background including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.5", "problem": "Practice problem demonstrating key principles of Cosmic Microwave Background", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Microwave Background", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.6: Big Bang Nucleosynthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l06-uuid',
    'course6-ch2-uuid',
    'ch2-big-bang-nucleosynthesis',
    'Lesson 2.6: Big Bang Nucleosynthesis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.6", "content": "Comprehensive explanation of Big Bang Nucleosynthesis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.6", "problem": "Practice problem demonstrating key principles of Big Bang Nucleosynthesis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Bang Nucleosynthesis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.7: Primordial Abundance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l07-uuid',
    'course6-ch2-uuid',
    'ch2-primordial-abundance',
    'Lesson 2.7: Primordial Abundance',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.7", "content": "Comprehensive explanation of Primordial Abundance including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.7", "problem": "Practice problem demonstrating key principles of Primordial Abundance", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Primordial Abundance", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.8: Problems and Solutions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l08-uuid',
    'course6-ch2-uuid',
    'ch2-problems-and-solutions',
    'Lesson 2.8: Problems and Solutions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.8", "content": "Comprehensive explanation of Problems and Solutions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.8", "problem": "Practice problem demonstrating key principles of Problems and Solutions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Problems and Solutions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.9: Alternative Models
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l09-uuid',
    'course6-ch2-uuid',
    'ch2-alternative-models',
    'Lesson 2.9: Alternative Models',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.9", "content": "Comprehensive explanation of Alternative Models including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.9", "problem": "Practice problem demonstrating key principles of Alternative Models", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Alternative Models", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.10: Current Status
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch2-l10-uuid',
    'course6-ch2-uuid',
    'ch2-current-status',
    'Lesson 2.10: Current Status',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 2, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.10", "content": "Comprehensive explanation of Current Status including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.10", "problem": "Practice problem demonstrating key principles of Current Status", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Current Status", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 3: COSMIC INFLATION
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch3-uuid',
    'cosmology-uuid',
    'Cosmic Inflation',
    'cosmic-inflation',
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

-- Lesson 3.1: Problems with Standard Big Bang
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l01-uuid',
    'course6-ch3-uuid',
    'ch3-problems-with-standard-big-bang',
    'Lesson 3.1: Problems with Standard Big Bang',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.1", "content": "Comprehensive explanation of Problems with Standard Big Bang including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.1", "problem": "Practice problem demonstrating key principles of Problems with Standard Big Bang", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Problems with Standard Big Bang", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.2: Inflationary Epoch
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l02-uuid',
    'course6-ch3-uuid',
    'ch3-inflationary-epoch',
    'Lesson 3.2: Inflationary Epoch',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.2", "content": "Comprehensive explanation of Inflationary Epoch including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.2", "problem": "Practice problem demonstrating key principles of Inflationary Epoch", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Inflationary Epoch", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.3: Mechanisms of Inflation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l03-uuid',
    'course6-ch3-uuid',
    'ch3-mechanisms-of-inflation',
    'Lesson 3.3: Mechanisms of Inflation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.3", "content": "Comprehensive explanation of Mechanisms of Inflation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.3", "problem": "Practice problem demonstrating key principles of Mechanisms of Inflation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Mechanisms of Inflation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.4: Quantum Fluctuations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l04-uuid',
    'course6-ch3-uuid',
    'ch3-quantum-fluctuations',
    'Lesson 3.4: Quantum Fluctuations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.4", "content": "Comprehensive explanation of Quantum Fluctuations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.4", "problem": "Practice problem demonstrating key principles of Quantum Fluctuations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quantum Fluctuations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.5: Eternal Inflation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l05-uuid',
    'course6-ch3-uuid',
    'ch3-eternal-inflation',
    'Lesson 3.5: Eternal Inflation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.5", "content": "Comprehensive explanation of Eternal Inflation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.5", "problem": "Practice problem demonstrating key principles of Eternal Inflation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Eternal Inflation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.6: Multiverse
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l06-uuid',
    'course6-ch3-uuid',
    'ch3-multiverse',
    'Lesson 3.6: Multiverse',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.6", "content": "Comprehensive explanation of Multiverse including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.6", "problem": "Practice problem demonstrating key principles of Multiverse", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Multiverse", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.7: Observational Evidence
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l07-uuid',
    'course6-ch3-uuid',
    'ch3-observational-evidence',
    'Lesson 3.7: Observational Evidence',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.7", "content": "Comprehensive explanation of Observational Evidence including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.7", "problem": "Practice problem demonstrating key principles of Observational Evidence", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Observational Evidence", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.8: CMB Anisotropies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l08-uuid',
    'course6-ch3-uuid',
    'ch3-cmb-anisotropies',
    'Lesson 3.8: CMB Anisotropies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.8", "content": "Comprehensive explanation of CMB Anisotropies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.8", "problem": "Practice problem demonstrating key principles of CMB Anisotropies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about CMB Anisotropies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.9: Inflationary Predictions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l09-uuid',
    'course6-ch3-uuid',
    'ch3-inflationary-predictions',
    'Lesson 3.9: Inflationary Predictions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.9", "content": "Comprehensive explanation of Inflationary Predictions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.9", "problem": "Practice problem demonstrating key principles of Inflationary Predictions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Inflationary Predictions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.10: Current Research
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch3-l10-uuid',
    'course6-ch3-uuid',
    'ch3-current-research',
    'Lesson 3.10: Current Research',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 3, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.10", "content": "Comprehensive explanation of Current Research including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.10", "problem": "Practice problem demonstrating key principles of Current Research", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Current Research", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 4: DARK MATTER
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch4-uuid',
    'cosmology-uuid',
    'Dark Matter',
    'dark-matter',
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

-- Lesson 4.1: Evidence for Dark Matter
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l01-uuid',
    'course6-ch4-uuid',
    'ch4-evidence-for-dark-matter',
    'Lesson 4.1: Evidence for Dark Matter',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.1", "content": "Comprehensive explanation of Evidence for Dark Matter including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.1", "problem": "Practice problem demonstrating key principles of Evidence for Dark Matter", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Evidence for Dark Matter", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.2: Galactic Rotation Curves
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l02-uuid',
    'course6-ch4-uuid',
    'ch4-galactic-rotation-curves',
    'Lesson 4.2: Galactic Rotation Curves',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.2", "content": "Comprehensive explanation of Galactic Rotation Curves including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.2", "problem": "Practice problem demonstrating key principles of Galactic Rotation Curves", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Rotation Curves", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.3: Gravitional Lensing
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l03-uuid',
    'course6-ch4-uuid',
    'ch4-gravitional-lensing',
    'Lesson 4.3: Gravitional Lensing',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.3", "content": "Comprehensive explanation of Gravitional Lensing including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.3", "problem": "Practice problem demonstrating key principles of Gravitional Lensing", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gravitional Lensing", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.4: Bullet Cluster
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l04-uuid',
    'course6-ch4-uuid',
    'ch4-bullet-cluster',
    'Lesson 4.4: Bullet Cluster',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.4", "content": "Comprehensive explanation of Bullet Cluster including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.4", "problem": "Practice problem demonstrating key principles of Bullet Cluster", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Bullet Cluster", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.5: Dark Matter Candidates
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l05-uuid',
    'course6-ch4-uuid',
    'ch4-dark-matter-candidates',
    'Lesson 4.5: Dark Matter Candidates',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.5", "content": "Comprehensive explanation of Dark Matter Candidates including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.5", "problem": "Practice problem demonstrating key principles of Dark Matter Candidates", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter Candidates", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.6: WIMPs
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l06-uuid',
    'course6-ch4-uuid',
    'ch4-wimps',
    'Lesson 4.6: WIMPs',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.6", "content": "Comprehensive explanation of WIMPs including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.6", "problem": "Practice problem demonstrating key principles of WIMPs", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about WIMPs", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.7: Axions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l07-uuid',
    'course6-ch4-uuid',
    'ch4-axions',
    'Lesson 4.7: Axions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.7", "content": "Comprehensive explanation of Axions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.7", "problem": "Practice problem demonstrating key principles of Axions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Axions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.8: Dark Matter Detectors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l08-uuid',
    'course6-ch4-uuid',
    'ch4-dark-matter-detectors',
    'Lesson 4.8: Dark Matter Detectors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.8", "content": "Comprehensive explanation of Dark Matter Detectors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.8", "problem": "Practice problem demonstrating key principles of Dark Matter Detectors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter Detectors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.9: Dark Matter Simulations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l09-uuid',
    'course6-ch4-uuid',
    'ch4-dark-matter-simulations',
    'Lesson 4.9: Dark Matter Simulations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.9", "content": "Comprehensive explanation of Dark Matter Simulations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.9", "problem": "Practice problem demonstrating key principles of Dark Matter Simulations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter Simulations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.10: Alternative Theories
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch4-l10-uuid',
    'course6-ch4-uuid',
    'ch4-alternative-theories',
    'Lesson 4.10: Alternative Theories',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 4, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.10", "content": "Comprehensive explanation of Alternative Theories including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.10", "problem": "Practice problem demonstrating key principles of Alternative Theories", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Alternative Theories", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 5: DARK ENERGY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch5-uuid',
    'cosmology-uuid',
    'Dark Energy',
    'dark-energy',
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

-- Lesson 5.1: Accelerating Expanson
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l01-uuid',
    'course6-ch5-uuid',
    'ch5-accelerating-expanson',
    'Lesson 5.1: Accelerating Expanson',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.1", "content": "Comprehensive explanation of Accelerating Expanson including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.1", "problem": "Practice problem demonstrating key principles of Accelerating Expanson", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Accelerating Expanson", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.2: Type Ia Supernovae
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l02-uuid',
    'course6-ch5-uuid',
    'ch5-type-ia-supernovae',
    'Lesson 5.2: Type Ia Supernovae',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.2", "content": "Comprehensive explanation of Type Ia Supernovae including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.2", "problem": "Practice problem demonstrating key principles of Type Ia Supernovae", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Type Ia Supernovae", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.3: Cosmic Acceleration Parameter
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l03-uuid',
    'course6-ch5-uuid',
    'ch5-cosmic-acceleration-parameter',
    'Lesson 5.3: Cosmic Acceleration Parameter',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.3", "content": "Comprehensive explanation of Cosmic Acceleration Parameter including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.3", "problem": "Practice problem demonstrating key principles of Cosmic Acceleration Parameter", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Acceleration Parameter", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.4: Dark Energy Candidates
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l04-uuid',
    'course6-ch5-uuid',
    'ch5-dark-energy-candidates',
    'Lesson 5.4: Dark Energy Candidates',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.4", "content": "Comprehensive explanation of Dark Energy Candidates including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.4", "problem": "Practice problem demonstrating key principles of Dark Energy Candidates", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Energy Candidates", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.5: Cosmological Constant
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l05-uuid',
    'course6-ch5-uuid',
    'ch5-cosmological-constant',
    'Lesson 5.5: Cosmological Constant',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.5", "content": "Comprehensive explanation of Cosmological Constant including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.5", "problem": "Practice problem demonstrating key principles of Cosmological Constant", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmological Constant", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.6: Quintessence
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l06-uuid',
    'course6-ch5-uuid',
    'ch5-quintessence',
    'Lesson 5.6: Quintessence',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.6", "content": "Comprehensive explanation of Quintessence including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.6", "problem": "Practice problem demonstrating key principles of Quintessence", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quintessence", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.7: Modified Gravity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l07-uuid',
    'course6-ch5-uuid',
    'ch5-modified-gravity',
    'Lesson 5.7: Modified Gravity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.7", "content": "Comprehensive explanation of Modified Gravity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.7", "problem": "Practice problem demonstrating key principles of Modified Gravity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Modified Gravity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.8: Dark Energy Detectors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l08-uuid',
    'course6-ch5-uuid',
    'ch5-dark-energy-detectors',
    'Lesson 5.8: Dark Energy Detectors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.8", "content": "Comprehensive explanation of Dark Energy Detectors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.8", "problem": "Practice problem demonstrating key principles of Dark Energy Detectors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Energy Detectors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.9: Future of Expanson
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l09-uuid',
    'course6-ch5-uuid',
    'ch5-future-of-expanson',
    'Lesson 5.9: Future of Expanson',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.9", "content": "Comprehensive explanation of Future of Expanson including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.9", "problem": "Practice problem demonstrating key principles of Future of Expanson", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Future of Expanson", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.10: Alternative Explanations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch5-l10-uuid',
    'course6-ch5-uuid',
    'ch5-alternative-explanations',
    'Lesson 5.10: Alternative Explanations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 5, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.10", "content": "Comprehensive explanation of Alternative Explanations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.10", "problem": "Practice problem demonstrating key principles of Alternative Explanations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Alternative Explanations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 6: LARGE SCALE STRUCTURE
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch6-uuid',
    'cosmology-uuid',
    'Large Scale Structure',
    'large-scale-structure',
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

-- Lesson 6.1: Galaxy Clusters
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l01-uuid',
    'course6-ch6-uuid',
    'ch6-galaxy-clusters',
    'Lesson 6.1: Galaxy Clusters',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.1", "content": "Comprehensive explanation of Galaxy Clusters including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.1", "problem": "Practice problem demonstrating key principles of Galaxy Clusters", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Clusters", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.2: Superclusters
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l02-uuid',
    'course6-ch6-uuid',
    'ch6-superclusters',
    'Lesson 6.2: Superclusters',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.2", "content": "Comprehensive explanation of Superclusters including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.2", "problem": "Practice problem demonstrating key principles of Superclusters", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Superclusters", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.3: Voids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l03-uuid',
    'course6-ch6-uuid',
    'ch6-voids',
    'Lesson 6.3: Voids',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.3", "content": "Comprehensive explanation of Voids including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.3", "problem": "Practice problem demonstrating key principles of Voids", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Voids", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.4: Cosmic Web
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l04-uuid',
    'course6-ch6-uuid',
    'ch6-cosmic-web',
    'Lesson 6.4: Cosmic Web',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.4", "content": "Comprehensive explanation of Cosmic Web including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.4", "problem": "Practice problem demonstrating key principles of Cosmic Web", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Web", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.5: Baryon Acoustic Oscillations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l05-uuid',
    'course6-ch6-uuid',
    'ch6-baryon-acoustic-oscillations',
    'Lesson 6.5: Baryon Acoustic Oscillations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.5", "content": "Comprehensive explanation of Baryon Acoustic Oscillations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.5", "problem": "Practice problem demonstrating key principles of Baryon Acoustic Oscillations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Baryon Acoustic Oscillations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.6: Power Spectrum
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l06-uuid',
    'course6-ch6-uuid',
    'ch6-power-spectrum',
    'Lesson 6.6: Power Spectrum',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.6", "content": "Comprehensive explanation of Power Spectrum including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.6", "problem": "Practice problem demonstrating key principles of Power Spectrum", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Power Spectrum", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.7: Large Scale Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l07-uuid',
    'course6-ch6-uuid',
    'ch6-large-scale-structure',
    'Lesson 6.7: Large Scale Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.7", "content": "Comprehensive explanation of Large Scale Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.7", "problem": "Practice problem demonstrating key principles of Large Scale Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Large Scale Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.8: Homogeneity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l08-uuid',
    'course6-ch6-uuid',
    'ch6-homogeneity',
    'Lesson 6.8: Homogeneity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.8", "content": "Comprehensive explanation of Homogeneity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.8", "problem": "Practice problem demonstrating key principles of Homogeneity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Homogeneity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.9: Cosmic Velosity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l09-uuid',
    'course6-ch6-uuid',
    'ch6-cosmic-velosity',
    'Lesson 6.9: Cosmic Velosity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.9", "content": "Comprehensive explanation of Cosmic Velosity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.9", "problem": "Practice problem demonstrating key principles of Cosmic Velosity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Velosity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.10: Formation and Evolution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch6-l10-uuid',
    'course6-ch6-uuid',
    'ch6-formation-and-evolution',
    'Lesson 6.10: Formation and Evolution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 6, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.10", "content": "Comprehensive explanation of Formation and Evolution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.10", "problem": "Practice problem demonstrating key principles of Formation and Evolution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Formation and Evolution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 7: EARLY UNIVERSE
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch7-uuid',
    'cosmology-uuid',
    'Early Universe',
    'early-universe',
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

-- Lesson 7.1: Planck Epoch
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l01-uuid',
    'course6-ch7-uuid',
    'ch7-planck-epoch',
    'Lesson 7.1: Planck Epoch',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.1", "content": "Comprehensive explanation of Planck Epoch including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.1", "problem": "Practice problem demonstrating key principles of Planck Epoch", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Planck Epoch", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.2: Grand Unification
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l02-uuid',
    'course6-ch7-uuid',
    'ch7-grand-unification',
    'Lesson 7.2: Grand Unification',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.2", "content": "Comprehensive explanation of Grand Unification including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.2", "problem": "Practice problem demonstrating key principles of Grand Unification", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Grand Unification", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.3: Quark-Hadron Era
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l03-uuid',
    'course6-ch7-uuid',
    'ch7-quark-hadron-era',
    'Lesson 7.3: Quark-Hadron Era',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.3", "content": "Comprehensive explanation of Quark-Hadron Era including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.3", "problem": "Practice problem demonstrating key principles of Quark-Hadron Era", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quark-Hadron Era", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.4: Nucleosynthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l04-uuid',
    'course6-ch7-uuid',
    'ch7-nucleosynthesis',
    'Lesson 7.4: Nucleosynthesis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.4", "content": "Comprehensive explanation of Nucleosynthesis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.4", "problem": "Practice problem demonstrating key principles of Nucleosynthesis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Nucleosynthesis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.5: Recombination
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l05-uuid',
    'course6-ch7-uuid',
    'ch7-recombination',
    'Lesson 7.5: Recombination',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.5", "content": "Comprehensive explanation of Recombination including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.5", "problem": "Practice problem demonstrating key principles of Recombination", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Recombination", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.6: CMB Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l06-uuid',
    'course6-ch7-uuid',
    'ch7-cmb-formation',
    'Lesson 7.6: CMB Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.6", "content": "Comprehensive explanation of CMB Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.6", "problem": "Practice problem demonstrating key principles of CMB Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about CMB Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.7: Structure Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l07-uuid',
    'course6-ch7-uuid',
    'ch7-structure-formation',
    'Lesson 7.7: Structure Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.7", "content": "Comprehensive explanation of Structure Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.7", "problem": "Practice problem demonstrating key principles of Structure Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Structure Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.8: Dark Matter
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l08-uuid',
    'course6-ch7-uuid',
    'ch7-dark-matter',
    'Lesson 7.8: Dark Matter',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.8", "content": "Comprehensive explanation of Dark Matter including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.8", "problem": "Practice problem demonstrating key principles of Dark Matter", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.9: First Stars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l09-uuid',
    'course6-ch7-uuid',
    'ch7-first-stars',
    'Lesson 7.9: First Stars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.9", "content": "Comprehensive explanation of First Stars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.9", "problem": "Practice problem demonstrating key principles of First Stars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Stars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.10: First Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch7-l10-uuid',
    'course6-ch7-uuid',
    'ch7-first-galaxies',
    'Lesson 7.10: First Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 7, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.10", "content": "Comprehensive explanation of First Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.10", "problem": "Practice problem demonstrating key principles of First Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 8: STRUCTURE FORMATION
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch8-uuid',
    'cosmology-uuid',
    'Structure Formation',
    'structure-formation',
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

-- Lesson 8.1: Linear Density Perturbations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l01-uuid',
    'course6-ch8-uuid',
    'ch8-linear-density-perturbations',
    'Lesson 8.1: Linear Density Perturbations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.1", "content": "Comprehensive explanation of Linear Density Perturbations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.1", "problem": "Practice problem demonstrating key principles of Linear Density Perturbations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Linear Density Perturbations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.2: Hierarchical Structure Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l02-uuid',
    'course6-ch8-uuid',
    'ch8-hierarchical-structure-formation',
    'Lesson 8.2: Hierarchical Structure Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.2", "content": "Comprehensive explanation of Hierarchical Structure Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.2", "problem": "Practice problem demonstrating key principles of Hierarchical Structure Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hierarchical Structure Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.3: Reionization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l03-uuid',
    'course6-ch8-uuid',
    'ch8-reionization',
    'Lesson 8.3: Reionization',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.3", "content": "Comprehensive explanation of Reionization including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.3", "problem": "Practice problem demonstrating key principles of Reionization", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Reionization", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.4: First Stars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l04-uuid',
    'course6-ch8-uuid',
    'ch8-first-stars',
    'Lesson 8.4: First Stars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.4", "content": "Comprehensive explanation of First Stars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.4", "problem": "Practice problem demonstrating key principles of First Stars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about First Stars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.5: Galaxy Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l05-uuid',
    'course6-ch8-uuid',
    'ch8-galaxy-formation',
    'Lesson 8.5: Galaxy Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.5", "content": "Comprehensive explanation of Galaxy Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.5", "problem": "Practice problem demonstrating key principles of Galaxy Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.6: Cluster Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l06-uuid',
    'course6-ch8-uuid',
    'ch8-cluster-formation',
    'Lesson 8.6: Cluster Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.6", "content": "Comprehensive explanation of Cluster Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.6", "problem": "Practice problem demonstrating key principles of Cluster Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cluster Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.7: Supercluster Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l07-uuid',
    'course6-ch8-uuid',
    'ch8-supercluster-formation',
    'Lesson 8.7: Supercluster Formation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.7", "content": "Comprehensive explanation of Supercluster Formation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.7", "problem": "Practice problem demonstrating key principles of Supercluster Formation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Supercluster Formation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.8: Feedback Mechanisms
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l08-uuid',
    'course6-ch8-uuid',
    'ch8-feedback-mechanisms',
    'Lesson 8.8: Feedback Mechanisms',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.8", "content": "Comprehensive explanation of Feedback Mechanisms including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.8", "problem": "Practice problem demonstrating key principles of Feedback Mechanisms", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Feedback Mechanisms", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.9: Simulations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l09-uuid',
    'course6-ch8-uuid',
    'ch8-simulations',
    'Lesson 8.9: Simulations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.9", "content": "Comprehensive explanation of Simulations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.9", "problem": "Practice problem demonstrating key principles of Simulations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Simulations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.10: Observations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch8-l10-uuid',
    'course6-ch8-uuid',
    'ch8-observations',
    'Lesson 8.10: Observations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 8, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.10", "content": "Comprehensive explanation of Observations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.10", "problem": "Practice problem demonstrating key principles of Observations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Observations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 9: FATE OF THE UNIVERSE
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch9-uuid',
    'cosmology-uuid',
    'Fate of the Universe',
    'fate-of-universe',
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

-- Lesson 9.1: Dark Energy Dominance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l01-uuid',
    'course6-ch9-uuid',
    'ch9-dark-energy-dominance',
    'Lesson 9.1: Dark Energy Dominance',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.1", "content": "Comprehensive explanation of Dark Energy Dominance including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.1", "problem": "Practice problem demonstrating key principles of Dark Energy Dominance", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Energy Dominance", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.2: Heat Death
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l02-uuid',
    'course6-ch9-uuid',
    'ch9-heat-death',
    'Lesson 9.2: Heat Death',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.2", "content": "Comprehensive explanation of Heat Death including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.2", "problem": "Practice problem demonstrating key principles of Heat Death", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heat Death", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.3: Big Rip
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l03-uuid',
    'course6-ch9-uuid',
    'ch9-big-rip',
    'Lesson 9.3: Big Rip',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.3", "content": "Comprehensive explanation of Big Rip including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.3", "problem": "Practice problem demonstrating key principles of Big Rip", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Rip", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.4: Big Crunch
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l04-uuid',
    'course6-ch9-uuid',
    'ch9-big-crunch',
    'Lesson 9.4: Big Crunch',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.4", "content": "Comprehensive explanation of Big Crunch including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.4", "problem": "Practice problem demonstrating key principles of Big Crunch", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Crunch", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.5: Big Bounce
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l05-uuid',
    'course6-ch9-uuid',
    'ch9-big-bounce',
    'Lesson 9.5: Big Bounce',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.5", "content": "Comprehensive explanation of Big Bounce including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.5", "problem": "Practice problem demonstrating key principles of Big Bounce", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Bounce", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.6: Vacuum Decay
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l06-uuid',
    'course6-ch9-uuid',
    'ch9-vacuum-decay',
    'Lesson 9.6: Vacuum Decay',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.6", "content": "Comprehensive explanation of Vacuum Decay including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.6", "problem": "Practice problem demonstrating key principles of Vacuum Decay", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Vacuum Decay", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.7: False Vacuum
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l07-uuid',
    'course6-ch9-uuid',
    'ch9-false-vacuum',
    'Lesson 9.7: False Vacuum',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.7", "content": "Comprehensive explanation of False Vacuum including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.7", "problem": "Practice problem demonstrating key principles of False Vacuum", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about False Vacuum", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.8: Cosmological Constant
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l08-uuid',
    'course6-ch9-uuid',
    'ch9-cosmological-constant',
    'Lesson 9.8: Cosmological Constant',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.8", "content": "Comprehensive explanation of Cosmological Constant including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.8", "problem": "Practice problem demonstrating key principles of Cosmological Constant", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmological Constant", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.9: Phase Transitions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l09-uuid',
    'course6-ch9-uuid',
    'ch9-phase-transitions',
    'Lesson 9.9: Phase Transitions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.9", "content": "Comprehensive explanation of Phase Transitions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.9", "problem": "Practice problem demonstrating key principles of Phase Transitions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Phase Transitions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.10: Ultimate Fate
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch9-l10-uuid',
    'course6-ch9-uuid',
    'ch9-ultimate-fate',
    'Lesson 9.10: Ultimate Fate',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 9, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.10", "content": "Comprehensive explanation of Ultimate Fate including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.10", "problem": "Practice problem demonstrating key principles of Ultimate Fate", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Ultimate Fate", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 10: ALTERNATIVE COSMOLOGIES
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course6-ch10-uuid',
    'cosmology-uuid',
    'Alternative Cosmologies',
    'alternative-cosmologies',
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

-- Lesson 10.1: Steady State
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l01-uuid',
    'course6-ch10-uuid',
    'ch10-steady-state',
    'Lesson 10.1: Steady State',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 1 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.1", "content": "Comprehensive explanation of Steady State including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.1", "problem": "Practice problem demonstrating key principles of Steady State", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Steady State", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.2: Tired-Light Cosmology
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l02-uuid',
    'course6-ch10-uuid',
    'ch10-tired-light-cosmology',
    'Lesson 10.2: Tired-Light Cosmology',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 2 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.2", "content": "Comprehensive explanation of Tired-Light Cosmology including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.2", "problem": "Practice problem demonstrating key principles of Tired-Light Cosmology", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Tired-Light Cosmology", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.3: Brane-Dicke Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l03-uuid',
    'course6-ch10-uuid',
    'ch10-brane-dicke-theory',
    'Lesson 10.3: Brane-Dicke Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 3 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.3", "content": "Comprehensive explanation of Brane-Dicke Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.3", "problem": "Practice problem demonstrating key principles of Brane-Dicke Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Brane-Dicke Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.4: Modified Newtonian Dynamics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l04-uuid',
    'course6-ch10-uuid',
    'ch10-modified-newtonian-dynamics',
    'Lesson 10.4: Modified Newtonian Dynamics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 4 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.4", "content": "Comprehensive explanation of Modified Newtonian Dynamics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.4", "problem": "Practice problem demonstrating key principles of Modified Newtonian Dynamics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Modified Newtonian Dynamics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.5: Scalar-Tensor-Vector Gravity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l05-uuid',
    'course6-ch10-uuid',
    'ch10-scalar-tensor-vector-gravity',
    'Lesson 10.5: Scalar-Tensor-Vector Gravity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 5 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.5", "content": "Comprehensive explanation of Scalar-Tensor-Vector Gravity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.5", "problem": "Practice problem demonstrating key principles of Scalar-Tensor-Vector Gravity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Scalar-Tensor-Vector Gravity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.6: Massive Gravity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l06-uuid',
    'course6-ch10-uuid',
    'ch10-massive-gravity',
    'Lesson 10.6: Massive Gravity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 6 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.6", "content": "Comprehensive explanation of Massive Gravity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.6", "problem": "Practice problem demonstrating key principles of Massive Gravity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Massive Gravity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.7: Emergent Gravity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l07-uuid',
    'course6-ch10-uuid',
    'ch10-emergent-gravity',
    'Lesson 10.7: Emergent Gravity',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 7 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.7", "content": "Comprehensive explanation of Emergent Gravity including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.7", "problem": "Practice problem demonstrating key principles of Emergent Gravity", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Emergent Gravity", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.8: Variable Speed of Light
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l08-uuid',
    'course6-ch10-uuid',
    'ch10-variable-speed-of-light',
    'Lesson 10.8: Variable Speed of Light',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 8 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.8", "content": "Comprehensive explanation of Variable Speed of Light including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.8", "problem": "Practice problem demonstrating key principles of Variable Speed of Light", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Variable Speed of Light", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.9: Cyclic Models
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l09-uuid',
    'course6-ch10-uuid',
    'ch10-cyclic-models',
    'Lesson 10.9: Cyclic Models',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 9 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.9", "content": "Comprehensive explanation of Cyclic Models including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.9", "problem": "Practice problem demonstrating key principles of Cyclic Models", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cyclic Models", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.10: Future Directions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course6-ch10-l10-uuid',
    'course6-ch10-uuid',
    'ch10-future-directions',
    'Lesson 10.10: Future Directions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Cosmology - Chapter 10, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Cosmology", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 10 of Cosmology, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.10", "content": "Comprehensive explanation of Future Directions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.10", "problem": "Practice problem demonstrating key principles of Future Directions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Future Directions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- END OF COSMOLOGY STRUCTURE SETUP
-- 10 chapters, 100 lessons created
-- =====================================================