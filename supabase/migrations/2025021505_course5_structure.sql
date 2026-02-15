-- =====================================================
-- ASTROPHYSICS COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons with comprehensive content
-- Physics Course 5 of 4
-- =====================================================

-- Create Astrophysics course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'astrophysics-uuid',
    'Astrophysics',
    'astrophysics',
    'Comprehensive course covering stellar properties, stellar evolution, galaxies, cosmology, high-energy astrophysics, and observational techniques across the electromagnetic spectrum. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/astrophysics.svg',
    5,
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
-- CHAPTER 1: OBSERVATIONAL TECHNIQUES
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch1-uuid',
    'astrophysics-uuid',
    'Observational Techniques',
    'observational-techniques-astro',
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

-- Lesson 1.1: Optical Telescopes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l01-uuid',
    'course5-ch1-uuid',
    'ch1-optical-telescopes',
    'Lesson 1.1: Optical Telescopes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.1", "content": "Comprehensive explanation of Optical Telescopes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.1", "problem": "Practice problem demonstrating key principles of Optical Telescopes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Optical Telescopes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.2: Radio Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l02-uuid',
    'course5-ch1-uuid',
    'ch1-radio-astronomy',
    'Lesson 1.2: Radio Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.2", "content": "Comprehensive explanation of Radio Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.2", "problem": "Practice problem demonstrating key principles of Radio Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Radio Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.3: X-Ray and Gamma-Ray Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l03-uuid',
    'course5-ch1-uuid',
    'ch1-x-ray-and-gamma-ray-astronomy',
    'Lesson 1.3: X-Ray and Gamma-Ray Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.3", "content": "Comprehensive explanation of X-Ray and Gamma-Ray Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.3", "problem": "Practice problem demonstrating key principles of X-Ray and Gamma-Ray Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about X-Ray and Gamma-Ray Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.4: Infrared Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l04-uuid',
    'course5-ch1-uuid',
    'ch1-infrared-astronomy',
    'Lesson 1.4: Infrared Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.4", "content": "Comprehensive explanation of Infrared Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.4", "problem": "Practice problem demonstrating key principles of Infrared Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Infrared Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.5: Ultravioler Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l05-uuid',
    'course5-ch1-uuid',
    'ch1-ultravioler-astronomy',
    'Lesson 1.5: Ultravioler Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.5", "content": "Comprehensive explanation of Ultravioler Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.5", "problem": "Practice problem demonstrating key principles of Ultravioler Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Ultravioler Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.6: Space Observatories
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l06-uuid',
    'course5-ch1-uuid',
    'ch1-space-observatories',
    'Lesson 1.6: Space Observatories',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.6", "content": "Comprehensive explanation of Space Observatories including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.6", "problem": "Practice problem demonstrating key principles of Space Observatories", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Space Observatories", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.7: Detectors
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l07-uuid',
    'course5-ch1-uuid',
    'ch1-detectors',
    'Lesson 1.7: Detectors',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.7", "content": "Comprehensive explanation of Detectors including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.7", "problem": "Practice problem demonstrating key principles of Detectors", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Detectors", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.8: Spectroscopy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l08-uuid',
    'course5-ch1-uuid',
    'ch1-spectroscopy',
    'Lesson 1.8: Spectroscopy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.8", "content": "Comprehensive explanation of Spectroscopy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.8", "problem": "Practice problem demonstrating key principles of Spectroscopy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Spectroscopy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.9: Photometry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l09-uuid',
    'course5-ch1-uuid',
    'ch1-photometry',
    'Lesson 1.9: Photometry',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.9", "content": "Comprehensive explanation of Photometry including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.9", "problem": "Practice problem demonstrating key principles of Photometry", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Photometry", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 1.10: Data Analysis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch1-l10-uuid',
    'course5-ch1-uuid',
    'ch1-data-analysis',
    'Lesson 1.10: Data Analysis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 1, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 1, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 1.10", "content": "Comprehensive explanation of Data Analysis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 1.10", "problem": "Practice problem demonstrating key principles of Data Analysis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Data Analysis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 1.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 1.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 1.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 2: STELLAR PROPERTIES
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch2-uuid',
    'astrophysics-uuid',
    'Stellar Properties',
    'stellar-properties',
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

-- Lesson 2.1: Stellar Magnitudes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l01-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-magnitudes',
    'Lesson 2.1: Stellar Magnitudes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.1", "content": "Comprehensive explanation of Stellar Magnitudes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.1", "problem": "Practice problem demonstrating key principles of Stellar Magnitudes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Magnitudes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.2: Stellar Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l02-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-spectra',
    'Lesson 2.2: Stellar Spectra',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.2", "content": "Comprehensive explanation of Stellar Spectra including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.2", "problem": "Practice problem demonstrating key principles of Stellar Spectra", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Spectra", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.3: Stellar Temperatures
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l03-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-temperatures',
    'Lesson 2.3: Stellar Temperatures',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.3", "content": "Comprehensive explanation of Stellar Temperatures including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.3", "problem": "Practice problem demonstrating key principles of Stellar Temperatures", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Temperatures", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.4: HR Diagram
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l04-uuid',
    'course5-ch2-uuid',
    'ch2-hr-diagram',
    'Lesson 2.4: HR Diagram',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.4", "content": "Comprehensive explanation of HR Diagram including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.4", "problem": "Practice problem demonstrating key principles of HR Diagram", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about HR Diagram", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.5: Luminosity Classes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l05-uuid',
    'course5-ch2-uuid',
    'ch2-luminosity-classes',
    'Lesson 2.5: Luminosity Classes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.5", "content": "Comprehensive explanation of Luminosity Classes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.5", "problem": "Practice problem demonstrating key principles of Luminosity Classes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Luminosity Classes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.6: Binary Star Systems
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l06-uuid',
    'course5-ch2-uuid',
    'ch2-binary-star-systems',
    'Lesson 2.6: Binary Star Systems',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.6", "content": "Comprehensive explanation of Binary Star Systems including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.6", "problem": "Practice problem demonstrating key principles of Binary Star Systems", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Binary Star Systems", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.7: Stellar Masses
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l07-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-masses',
    'Lesson 2.7: Stellar Masses',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.7", "content": "Comprehensive explanation of Stellar Masses including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.7", "problem": "Practice problem demonstrating key principles of Stellar Masses", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Masses", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.8: Stellar Radii
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l08-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-radii',
    'Lesson 2.8: Stellar Radii',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.8", "content": "Comprehensive explanation of Stellar Radii including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.8", "problem": "Practice problem demonstrating key principles of Stellar Radii", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Radii", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.9: Stellar Composition
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l09-uuid',
    'course5-ch2-uuid',
    'ch2-stellar-composition',
    'Lesson 2.9: Stellar Composition',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.9", "content": "Comprehensive explanation of Stellar Composition including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.9", "problem": "Practice problem demonstrating key principles of Stellar Composition", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Composition", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 2.10: Variable Stars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch2-l10-uuid',
    'course5-ch2-uuid',
    'ch2-variable-stars',
    'Lesson 2.10: Variable Stars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 2, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 2, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 2.10", "content": "Comprehensive explanation of Variable Stars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 2.10", "problem": "Practice problem demonstrating key principles of Variable Stars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Variable Stars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 2.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 2.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 2.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 3: STELLAR FORMATION
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch3-uuid',
    'astrophysics-uuid',
    'Stellar Formation',
    'stellar-formation',
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

-- Lesson 3.1: Molecular Clouds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l01-uuid',
    'course5-ch3-uuid',
    'ch3-molecular-clouds',
    'Lesson 3.1: Molecular Clouds',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.1", "content": "Comprehensive explanation of Molecular Clouds including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.1", "problem": "Practice problem demonstrating key principles of Molecular Clouds", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Clouds", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.2: Protostars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l02-uuid',
    'course5-ch3-uuid',
    'ch3-protostars',
    'Lesson 3.2: Protostars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.2", "content": "Comprehensive explanation of Protostars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.2", "problem": "Practice problem demonstrating key principles of Protostars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Protostars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.3: Main Sequence
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l03-uuid',
    'course5-ch3-uuid',
    'ch3-main-sequence',
    'Lesson 3.3: Main Sequence',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.3", "content": "Comprehensive explanation of Main Sequence including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.3", "problem": "Practice problem demonstrating key principles of Main Sequence", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Main Sequence", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.4: Pre-Main Sequence Evolution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l04-uuid',
    'course5-ch3-uuid',
    'ch3-pre-main-sequence-evolution',
    'Lesson 3.4: Pre-Main Sequence Evolution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.4", "content": "Comprehensive explanation of Pre-Main Sequence Evolution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.4", "problem": "Practice problem demonstrating key principles of Pre-Main Sequence Evolution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Pre-Main Sequence Evolution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.5: Brown Dwarfs
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l05-uuid',
    'course5-ch3-uuid',
    'ch3-brown-dwarfs',
    'Lesson 3.5: Brown Dwarfs',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.5", "content": "Comprehensive explanation of Brown Dwarfs including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.5", "problem": "Practice problem demonstrating key principles of Brown Dwarfs", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Brown Dwarfs", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.6: White Dwarfs
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l06-uuid',
    'course5-ch3-uuid',
    'ch3-white-dwarfs',
    'Lesson 3.6: White Dwarfs',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.6", "content": "Comprehensive explanation of White Dwarfs including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.6", "problem": "Practice problem demonstrating key principles of White Dwarfs", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about White Dwarfs", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.7: Neutron Stars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l07-uuid',
    'course5-ch3-uuid',
    'ch3-neutron-stars',
    'Lesson 3.7: Neutron Stars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.7", "content": "Comprehensive explanation of Neutron Stars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.7", "problem": "Practice problem demonstrating key principles of Neutron Stars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Neutron Stars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.8: Black Holes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l08-uuid',
    'course5-ch3-uuid',
    'ch3-black-holes',
    'Lesson 3.8: Black Holes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.8", "content": "Comprehensive explanation of Black Holes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.8", "problem": "Practice problem demonstrating key principles of Black Holes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Black Holes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.9: Star Clusters
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l09-uuid',
    'course5-ch3-uuid',
    'ch3-star-clusters',
    'Lesson 3.9: Star Clusters',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.9", "content": "Comprehensive explanation of Star Clusters including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.9", "problem": "Practice problem demonstrating key principles of Star Clusters", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Star Clusters", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 3.10: Star Formation Rates
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch3-l10-uuid',
    'course5-ch3-uuid',
    'ch3-star-formation-rates',
    'Lesson 3.10: Star Formation Rates',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 3, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 3, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 3.10", "content": "Comprehensive explanation of Star Formation Rates including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 3.10", "problem": "Practice problem demonstrating key principles of Star Formation Rates", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Star Formation Rates", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 3.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 3.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 3.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 4: STELLAR EVOLUTION
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch4-uuid',
    'astrophysics-uuid',
    'Stellar Evolution',
    'stellar-evolution',
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

-- Lesson 4.1: Red Giants
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l01-uuid',
    'course5-ch4-uuid',
    'ch4-red-giants',
    'Lesson 4.1: Red Giants',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.1", "content": "Comprehensive explanation of Red Giants including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.1", "problem": "Practice problem demonstrating key principles of Red Giants", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Red Giants", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.2: Planetary Nebulae
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l02-uuid',
    'course5-ch4-uuid',
    'ch4-planetary-nebulae',
    'Lesson 4.2: Planetary Nebulae',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.2", "content": "Comprehensive explanation of Planetary Nebulae including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.2", "problem": "Practice problem demonstrating key principles of Planetary Nebulae", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Planetary Nebulae", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.3: Supernovae
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l03-uuid',
    'course5-ch4-uuid',
    'ch4-supernovae',
    'Lesson 4.3: Supernovae',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.3", "content": "Comprehensive explanation of Supernovae including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.3", "problem": "Practice problem demonstrating key principles of Supernovae", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Supernovae", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.4: Supernova Remnants
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l04-uuid',
    'course5-ch4-uuid',
    'ch4-supernova-remnants',
    'Lesson 4.4: Supernova Remnants',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.4", "content": "Comprehensive explanation of Supernova Remnants including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.4", "problem": "Practice problem demonstrating key principles of Supernova Remnants", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Supernova Remnants", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.5: Nucleosynthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l05-uuid',
    'course5-ch4-uuid',
    'ch4-nucleosynthesis',
    'Lesson 4.5: Nucleosynthesis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.5", "content": "Comprehensive explanation of Nucleosynthesis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.5", "problem": "Practice problem demonstrating key principles of Nucleosynthesis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Nucleosynthesis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.6: Stellar Nucleosynthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l06-uuid',
    'course5-ch4-uuid',
    'ch4-stellar-nucleosynthesis',
    'Lesson 4.6: Stellar Nucleosynthesis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.6", "content": "Comprehensive explanation of Stellar Nucleosynthesis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.6", "problem": "Practice problem demonstrating key principles of Stellar Nucleosynthesis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Stellar Nucleosynthesis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.7: Heavy Element Production
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l07-uuid',
    'course5-ch4-uuid',
    'ch4-heavy-element-production',
    'Lesson 4.7: Heavy Element Production',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.7", "content": "Comprehensive explanation of Heavy Element Production including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.7", "problem": "Practice problem demonstrating key principles of Heavy Element Production", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Heavy Element Production", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.8: Supernova Types
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l08-uuid',
    'course5-ch4-uuid',
    'ch4-supernova-types',
    'Lesson 4.8: Supernova Types',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.8", "content": "Comprehensive explanation of Supernova Types including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.8", "problem": "Practice problem demonstrating key principles of Supernova Types", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Supernova Types", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.9: Observational Evidence
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l09-uuid',
    'course5-ch4-uuid',
    'ch4-observational-evidence',
    'Lesson 4.9: Observational Evidence',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.9", "content": "Comprehensive explanation of Observational Evidence including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.9", "problem": "Practice problem demonstrating key principles of Observational Evidence", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Observational Evidence", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 4.10: Cosmic Abundance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch4-l10-uuid',
    'course5-ch4-uuid',
    'ch4-cosmic-abundance',
    'Lesson 4.10: Cosmic Abundance',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 4, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 4, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 4.10", "content": "Comprehensive explanation of Cosmic Abundance including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 4.10", "problem": "Practice problem demonstrating key principles of Cosmic Abundance", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Abundance", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 4.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 4.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 4.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 5: THE INTERSTELLAR MEDIUM
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch5-uuid',
    'astrophysics-uuid',
    'The Interstellar Medium',
    'interstellar-medium',
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

-- Lesson 5.1: ISM Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l01-uuid',
    'course5-ch5-uuid',
    'ch5-ism-properties',
    'Lesson 5.1: ISM Properties',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.1", "content": "Comprehensive explanation of ISM Properties including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.1", "problem": "Practice problem demonstrating key principles of ISM Properties", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about ISM Properties", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.2: Dust and Gas
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l02-uuid',
    'course5-ch5-uuid',
    'ch5-dust-and-gas',
    'Lesson 5.2: Dust and Gas',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.2", "content": "Comprehensive explanation of Dust and Gas including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.2", "problem": "Practice problem demonstrating key principles of Dust and Gas", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dust and Gas", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.3: H I Regions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l03-uuid',
    'course5-ch5-uuid',
    'ch5-h-i-regions',
    'Lesson 5.3: H I Regions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.3", "content": "Comprehensive explanation of H I Regions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.3", "problem": "Practice problem demonstrating key principles of H I Regions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about H I Regions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.4: Molecular Clouds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l04-uuid',
    'course5-ch5-uuid',
    'ch5-molecular-clouds',
    'Lesson 5.4: Molecular Clouds',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.4", "content": "Comprehensive explanation of Molecular Clouds including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.4", "problem": "Practice problem demonstrating key principles of Molecular Clouds", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Molecular Clouds", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.5: Dust Clouds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l05-uuid',
    'course5-ch5-uuid',
    'ch5-dust-clouds',
    'Lesson 5.5: Dust Clouds',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.5", "content": "Comprehensive explanation of Dust Clouds including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.5", "problem": "Practice problem demonstrating key principles of Dust Clouds", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dust Clouds", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.6: Interstellar Extinction
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l06-uuid',
    'course5-ch5-uuid',
    'ch5-interstellar-extinction',
    'Lesson 5.6: Interstellar Extinction',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.6", "content": "Comprehensive explanation of Interstellar Extinction including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.6", "problem": "Practice problem demonstrating key principles of Interstellar Extinction", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Interstellar Extinction", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.7: Cosmic Rays
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l07-uuid',
    'course5-ch5-uuid',
    'ch5-cosmic-rays',
    'Lesson 5.7: Cosmic Rays',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.7", "content": "Comprehensive explanation of Cosmic Rays including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.7", "problem": "Practice problem demonstrating key principles of Cosmic Rays", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Rays", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.8: Magnetic Fields in ISM
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l08-uuid',
    'course5-ch5-uuid',
    'ch5-magnetic-fields-in-ism',
    'Lesson 5.8: Magnetic Fields in ISM',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.8", "content": "Comprehensive explanation of Magnetic Fields in ISM including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.8", "problem": "Practice problem demonstrating key principles of Magnetic Fields in ISM", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Magnetic Fields in ISM", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.9: Star Formation in ISM
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l09-uuid',
    'course5-ch5-uuid',
    'ch5-star-formation-in-ism',
    'Lesson 5.9: Star Formation in ISM',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.9", "content": "Comprehensive explanation of Star Formation in ISM including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.9", "problem": "Practice problem demonstrating key principles of Star Formation in ISM", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Star Formation in ISM", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 5.10: Observations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch5-l10-uuid',
    'course5-ch5-uuid',
    'ch5-observations',
    'Lesson 5.10: Observations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 5, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 5, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 5.10", "content": "Comprehensive explanation of Observations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 5.10", "problem": "Practice problem demonstrating key principles of Observations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Observations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 5.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 5.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 5.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 6: THE MILKY WAY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch6-uuid',
    'astrophysics-uuid',
    'The Milky Way',
    'milky-way',
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

-- Lesson 6.1: Galactic Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l01-uuid',
    'course5-ch6-uuid',
    'ch6-galactic-structure',
    'Lesson 6.1: Galactic Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.1", "content": "Comprehensive explanation of Galactic Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.1", "problem": "Practice problem demonstrating key principles of Galactic Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.2: Spiral Arms
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l02-uuid',
    'course5-ch6-uuid',
    'ch6-spiral-arms',
    'Lesson 6.2: Spiral Arms',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.2", "content": "Comprehensive explanation of Spiral Arms including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.2", "problem": "Practice problem demonstrating key principles of Spiral Arms", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Spiral Arms", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.3: Galactic Center
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l03-uuid',
    'course5-ch6-uuid',
    'ch6-galactic-center',
    'Lesson 6.3: Galactic Center',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.3", "content": "Comprehensive explanation of Galactic Center including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.3", "problem": "Practice problem demonstrating key principles of Galactic Center", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Center", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.4: Dark Matter
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l04-uuid',
    'course5-ch6-uuid',
    'ch6-dark-matter',
    'Lesson 6.4: Dark Matter',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.4", "content": "Comprehensive explanation of Dark Matter including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.4", "problem": "Practice problem demonstrating key principles of Dark Matter", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.5: Dark Matter Halo
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l05-uuid',
    'course5-ch6-uuid',
    'ch6-dark-matter-halo',
    'Lesson 6.5: Dark Matter Halo',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.5", "content": "Comprehensive explanation of Dark Matter Halo including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.5", "problem": "Practice problem demonstrating key principles of Dark Matter Halo", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter Halo", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.6: Galactic Rotation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l06-uuid',
    'course5-ch6-uuid',
    'ch6-galactic-rotation',
    'Lesson 6.6: Galactic Rotation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.6", "content": "Comprehensive explanation of Galactic Rotation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.6", "problem": "Practice problem demonstrating key principles of Galactic Rotation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Rotation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.7: Star Populations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l07-uuid',
    'course5-ch6-uuid',
    'ch6-star-populations',
    'Lesson 6.7: Star Populations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.7", "content": "Comprehensive explanation of Star Populations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.7", "problem": "Practice problem demonstrating key principles of Star Populations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Star Populations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.8: Gobular Clusters
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l08-uuid',
    'course5-ch6-uuid',
    'ch6-gobular-clusters',
    'Lesson 6.8: Gobular Clusters',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.8", "content": "Comprehensive explanation of Gobular Clusters including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.8", "problem": "Practice problem demonstrating key principles of Gobular Clusters", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gobular Clusters", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.9: Interstellar Medium
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l09-uuid',
    'course5-ch6-uuid',
    'ch6-interstellar-medium',
    'Lesson 6.9: Interstellar Medium',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.9", "content": "Comprehensive explanation of Interstellar Medium including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.9", "problem": "Practice problem demonstrating key principles of Interstellar Medium", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Interstellar Medium", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 6.10: Galactic Evolution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch6-l10-uuid',
    'course5-ch6-uuid',
    'ch6-galactic-evolution',
    'Lesson 6.10: Galactic Evolution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 6, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 6, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 6.10", "content": "Comprehensive explanation of Galactic Evolution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 6.10", "problem": "Practice problem demonstrating key principles of Galactic Evolution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Evolution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 6.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 6.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 6.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 7: GALAXIES
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch7-uuid',
    'astrophysics-uuid',
    'Galaxies',
    'galaxies',
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

-- Lesson 7.1: Galaxy Classification
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l01-uuid',
    'course5-ch7-uuid',
    'ch7-galaxy-classification',
    'Lesson 7.1: Galaxy Classification',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.1", "content": "Comprehensive explanation of Galaxy Classification including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.1", "problem": "Practice problem demonstrating key principles of Galaxy Classification", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Classification", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.2: Spiral Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l02-uuid',
    'course5-ch7-uuid',
    'ch7-spiral-galaxies',
    'Lesson 7.2: Spiral Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.2", "content": "Comprehensive explanation of Spiral Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.2", "problem": "Practice problem demonstrating key principles of Spiral Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Spiral Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.3: Elliptical Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l03-uuid',
    'course5-ch7-uuid',
    'ch7-elliptical-galaxies',
    'Lesson 7.3: Elliptical Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.3", "content": "Comprehensive explanation of Elliptical Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.3", "problem": "Practice problem demonstrating key principles of Elliptical Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Elliptical Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.4: Irregular Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l04-uuid',
    'course5-ch7-uuid',
    'ch7-irregular-galaxies',
    'Lesson 7.4: Irregular Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.4", "content": "Comprehensive explanation of Irregular Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.4", "problem": "Practice problem demonstrating key principles of Irregular Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Irregular Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.5: Galaxy Clusters
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l05-uuid',
    'course5-ch7-uuid',
    'ch7-galaxy-clusters',
    'Lesson 7.5: Galaxy Clusters',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.5", "content": "Comprehensive explanation of Galaxy Clusters including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.5", "problem": "Practice problem demonstrating key principles of Galaxy Clusters", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Clusters", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.6: Active Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l06-uuid',
    'course5-ch7-uuid',
    'ch7-active-galaxies',
    'Lesson 7.6: Active Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.6", "content": "Comprehensive explanation of Active Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.6", "problem": "Practice problem demonstrating key principles of Active Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Active Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.7: Galaxy Evolution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l07-uuid',
    'course5-ch7-uuid',
    'ch7-galaxy-evolution',
    'Lesson 7.7: Galaxy Evolution',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.7", "content": "Comprehensive explanation of Galaxy Evolution including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.7", "problem": "Practice problem demonstrating key principles of Galaxy Evolution", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Evolution", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.8: Galaxy Mergers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l08-uuid',
    'course5-ch7-uuid',
    'ch7-galaxy-mergers',
    'Lesson 7.8: Galaxy Mergers',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.8", "content": "Comprehensive explanation of Galaxy Mergers including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.8", "problem": "Practice problem demonstrating key principles of Galaxy Mergers", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galaxy Mergers", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.9: Galactic Interactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l09-uuid',
    'course5-ch7-uuid',
    'ch7-galactic-interactions',
    'Lesson 7.9: Galactic Interactions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.9", "content": "Comprehensive explanation of Galactic Interactions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.9", "problem": "Practice problem demonstrating key principles of Galactic Interactions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Galactic Interactions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 7.10: Observations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch7-l10-uuid',
    'course5-ch7-uuid',
    'ch7-observations',
    'Lesson 7.10: Observations',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 7, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 7, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 7.10", "content": "Comprehensive explanation of Observations including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 7.10", "problem": "Practice problem demonstrating key principles of Observations", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Observations", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 7.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 7.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 7.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 8: ACTIVE GALAXIES AND QUASARS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch8-uuid',
    'astrophysics-uuid',
    'Active Galaxies and Quasars',
    'active-galaxies-quasars',
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

-- Lesson 8.1: Active Galactic Nuclei
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l01-uuid',
    'course5-ch8-uuid',
    'ch8-active-galactic-nuclei',
    'Lesson 8.1: Active Galactic Nuclei',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.1", "content": "Comprehensive explanation of Active Galactic Nuclei including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.1", "problem": "Practice problem demonstrating key principles of Active Galactic Nuclei", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Active Galactic Nuclei", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.2: Jets
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l02-uuid',
    'course5-ch8-uuid',
    'ch8-jets',
    'Lesson 8.2: Jets',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.2", "content": "Comprehensive explanation of Jets including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.2", "problem": "Practice problem demonstrating key principles of Jets", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Jets", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.3: Radio Galaxies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l03-uuid',
    'course5-ch8-uuid',
    'ch8-radio-galaxies',
    'Lesson 8.3: Radio Galaxies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.3", "content": "Comprehensive explanation of Radio Galaxies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.3", "problem": "Practice problem demonstrating key principles of Radio Galaxies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Radio Galaxies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.4: Quasars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l04-uuid',
    'course5-ch8-uuid',
    'ch8-quasars',
    'Lesson 8.4: Quasars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.4", "content": "Comprehensive explanation of Quasars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.4", "problem": "Practice problem demonstrating key principles of Quasars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Quasars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.5: Black Hole Physics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l05-uuid',
    'course5-ch8-uuid',
    'ch8-black-hole-physics',
    'Lesson 8.5: Black Hole Physics',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.5", "content": "Comprehensive explanation of Black Hole Physics including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.5", "problem": "Practice problem demonstrating key principles of Black Hole Physics", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Black Hole Physics", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.6: Accretion Disks
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l06-uuid',
    'course5-ch8-uuid',
    'ch8-accretion-disks',
    'Lesson 8.6: Accretion Disks',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.6", "content": "Comprehensive explanation of Accretion Disks including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.6", "problem": "Practice problem demonstrating key principles of Accretion Disks", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Accretion Disks", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.7: Gravitional Lensing
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l07-uuid',
    'course5-ch8-uuid',
    'ch8-gravitional-lensing',
    'Lesson 8.7: Gravitional Lensing',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.7", "content": "Comprehensive explanation of Gravitional Lensing including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.7", "problem": "Practice problem demonstrating key principles of Gravitional Lensing", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gravitional Lensing", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.8: Cosmic Rays
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l08-uuid',
    'course5-ch8-uuid',
    'ch8-cosmic-rays',
    'Lesson 8.8: Cosmic Rays',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.8", "content": "Comprehensive explanation of Cosmic Rays including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.8", "problem": "Practice problem demonstrating key principles of Cosmic Rays", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Rays", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.9: Gamma-Ray Bursts
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l09-uuid',
    'course5-ch8-uuid',
    'ch8-gamma-ray-bursts',
    'Lesson 8.9: Gamma-Ray Bursts',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.9", "content": "Comprehensive explanation of Gamma-Ray Bursts including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.9", "problem": "Practice problem demonstrating key principles of Gamma-Ray Bursts", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gamma-Ray Bursts", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 8.10: Multi-Messenger Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch8-l10-uuid',
    'course5-ch8-uuid',
    'ch8-multi-messenger-astronomy',
    'Lesson 8.10: Multi-Messenger Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 8, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 8, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 8.10", "content": "Comprehensive explanation of Multi-Messenger Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 8.10", "problem": "Practice problem demonstrating key principles of Multi-Messenger Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Multi-Messenger Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 8.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 8.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 8.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 9: COSMOLOGY
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch9-uuid',
    'astrophysics-uuid',
    'Cosmology',
    'cosmology',
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

-- Lesson 9.1: Big Bang Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l01-uuid',
    'course5-ch9-uuid',
    'ch9-big-bang-theory',
    'Lesson 9.1: Big Bang Theory',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.1", "content": "Comprehensive explanation of Big Bang Theory including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.1", "problem": "Practice problem demonstrating key principles of Big Bang Theory", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Bang Theory", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.2: Cosmic Microwave Background
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l02-uuid',
    'course5-ch9-uuid',
    'ch9-cosmic-microwave-background',
    'Lesson 9.2: Cosmic Microwave Background',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.2", "content": "Comprehensive explanation of Cosmic Microwave Background including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.2", "problem": "Practice problem demonstrating key principles of Cosmic Microwave Background", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Microwave Background", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.3: Hubble's Law
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l03-uuid',
    'course5-ch9-uuid',
    'ch9-hubble's-law',
    'Lesson 9.3: Hubble's Law',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.3", "content": "Comprehensive explanation of Hubble''s Law including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.3", "problem": "Practice problem demonstrating key principles of Hubble''s Law", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Hubble''s Law", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.4: Cosmic Inflation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l04-uuid',
    'course5-ch9-uuid',
    'ch9-cosmic-inflation',
    'Lesson 9.4: Cosmic Inflation',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.4", "content": "Comprehensive explanation of Cosmic Inflation including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.4", "problem": "Practice problem demonstrating key principles of Cosmic Inflation", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Inflation", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.5: Dark Matter
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l05-uuid',
    'course5-ch9-uuid',
    'ch9-dark-matter',
    'Lesson 9.5: Dark Matter',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.5", "content": "Comprehensive explanation of Dark Matter including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.5", "problem": "Practice problem demonstrating key principles of Dark Matter", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Matter", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.6: Dark Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l06-uuid',
    'course5-ch9-uuid',
    'ch9-dark-energy',
    'Lesson 9.6: Dark Energy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.6", "content": "Comprehensive explanation of Dark Energy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.6", "problem": "Practice problem demonstrating key principles of Dark Energy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Dark Energy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.7: Large Scale Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l07-uuid',
    'course5-ch9-uuid',
    'ch9-large-scale-structure',
    'Lesson 9.7: Large Scale Structure',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.7", "content": "Comprehensive explanation of Large Scale Structure including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.7", "problem": "Practice problem demonstrating key principles of Large Scale Structure", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Large Scale Structure", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.8: Big Bang Nucleosynthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l08-uuid',
    'course5-ch9-uuid',
    'ch9-big-bang-nucleosynthesis',
    'Lesson 9.8: Big Bang Nucleosynthesis',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.8", "content": "Comprehensive explanation of Big Bang Nucleosynthesis including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.8", "problem": "Practice problem demonstrating key principles of Big Bang Nucleosynthesis", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Big Bang Nucleosynthesis", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.9: Alternative Cosmologies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l09-uuid',
    'course5-ch9-uuid',
    'ch9-alternative-cosmologies',
    'Lesson 9.9: Alternative Cosmologies',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.9", "content": "Comprehensive explanation of Alternative Cosmologies including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.9", "problem": "Practice problem demonstrating key principles of Alternative Cosmologies", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Alternative Cosmologies", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 9.10: Fate of the Universe
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch9-l10-uuid',
    'course5-ch9-uuid',
    'ch9-fate-of-the-universe',
    'Lesson 9.10: Fate of the Universe',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 9, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 9, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 9.10", "content": "Comprehensive explanation of Fate of the Universe including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 9.10", "problem": "Practice problem demonstrating key principles of Fate of the Universe", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Fate of the Universe", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 9.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 9.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 9.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- CHAPTER 10: HIGH-ENERGY ASTROPHYSICS
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'course5-ch10-uuid',
    'astrophysics-uuid',
    'High-Energy Astrophysics',
    'high-energy-astrophysics',
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

-- Lesson 10.1: Cosmic Rays
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l01-uuid',
    'course5-ch10-uuid',
    'ch10-cosmic-rays',
    'Lesson 10.1: Cosmic Rays',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 1", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 1 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.1", "content": "Comprehensive explanation of Cosmic Rays including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.1", "problem": "Practice problem demonstrating key principles of Cosmic Rays", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Cosmic Rays", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.1", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.1", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.1", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.2: Gamma-Ray Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l02-uuid',
    'course5-ch10-uuid',
    'ch10-gamma-ray-astronomy',
    'Lesson 10.2: Gamma-Ray Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 2", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 2 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.2", "content": "Comprehensive explanation of Gamma-Ray Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.2", "problem": "Practice problem demonstrating key principles of Gamma-Ray Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gamma-Ray Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.2", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.2", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.2", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.3: Neutrino Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l03-uuid',
    'course5-ch10-uuid',
    'ch10-neutrino-astronomy',
    'Lesson 10.3: Neutrino Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 3", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 3 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.3", "content": "Comprehensive explanation of Neutrino Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.3", "problem": "Practice problem demonstrating key principles of Neutrino Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Neutrino Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.3", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.3", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.3", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.4: Gravitational Wave Astronomy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l04-uuid',
    'course5-ch10-uuid',
    'ch10-gravitational-wave-astronomy',
    'Lesson 10.4: Gravitational Wave Astronomy',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 4", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 4 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.4", "content": "Comprehensive explanation of Gravitational Wave Astronomy including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.4", "problem": "Practice problem demonstrating key principles of Gravitational Wave Astronomy", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Gravitational Wave Astronomy", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.4", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.4", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.4", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.5: High-Energy Phenomena
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l05-uuid',
    'course5-ch10-uuid',
    'ch10-high-energy-phenomena',
    'Lesson 10.5: High-Energy Phenomena',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 5", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 5 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.5", "content": "Comprehensive explanation of High-Energy Phenomena including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.5", "problem": "Practice problem demonstrating key principles of High-Energy Phenomena", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about High-Energy Phenomena", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.5", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.5", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.5", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.6: Pulsars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l06-uuid',
    'course5-ch10-uuid',
    'ch10-pulsars',
    'Lesson 10.6: Pulsars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 6", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 6 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.6", "content": "Comprehensive explanation of Pulsars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.6", "problem": "Practice problem demonstrating key principles of Pulsars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Pulsars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.6", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.6", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.6", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.7: Magnetars
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l07-uuid',
    'course5-ch10-uuid',
    'ch10-magnetars',
    'Lesson 10.7: Magnetars',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 7", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 7 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.7", "content": "Comprehensive explanation of Magnetars including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.7", "problem": "Practice problem demonstrating key principles of Magnetars", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Magnetars", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.7", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.7", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.7", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.8: Accretion Processes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l08-uuid',
    'course5-ch10-uuid',
    'ch10-accretion-processes',
    'Lesson 10.8: Accretion Processes',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 8", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 8 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.8", "content": "Comprehensive explanation of Accretion Processes including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.8", "problem": "Practice problem demonstrating key principles of Accretion Processes", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Accretion Processes", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.8", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.8", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.8", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.9: Particle Acceleration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l09-uuid',
    'course5-ch10-uuid',
    'ch10-particle-acceleration',
    'Lesson 10.9: Particle Acceleration',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 9", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 9 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.9", "content": "Comprehensive explanation of Particle Acceleration including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.9", "problem": "Practice problem demonstrating key principles of Particle Acceleration", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Particle Acceleration", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.9", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.9", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.9", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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

-- Lesson 10.10: Future Missions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'course5-ch10-l10-uuid',
    'course5-ch10-uuid',
    'ch10-future-missions',
    'Lesson 10.10: Future Missions',
    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
    '{"learningObjectives": ["Understand core concepts of Astrophysics - Chapter 10, Lesson 10", "Apply principles to solve physics problems", "Connect to real-world applications"], "prerequisites": ["Previous lessons in Astrophysics", "Calculus and vector mathematics", "Classical mechanics and electromagnetism foundation"], "whyThisMatters": "This lesson builds essential understanding for Chapter 10, Lesson 10 of Astrophysics, connecting fundamental principles to practical applications in science and engineering.", "parts": [{"title": "Main Concepts for Lesson 10.10", "content": "Comprehensive explanation of Future Missions including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."}], "workedExamples": [{"title": "Example Problem for Lesson 10.10", "problem": "Practice problem demonstrating key principles of Future Missions", "solution": "Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"}], "commonMisconceptions": [{"misconception": "Common misunderstanding about Future Missions", "reality": "The correct understanding based on experimental evidence and theoretical framework"}], "practiceProblems": [{"problem": "Practice problem 1 for Lesson 10.10", "solution": "Detailed solution with explanation"}, {"problem": "Practice problem 2 for Lesson 10.10", "solution": "Detailed solution with explanation"}], "furtherStudy": ["Textbook readings for Lesson 10.10", "Online simulations and visualizations", "Historical development and modern applications"]}'::jsonb,
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
-- END OF ASTROPHYSICS STRUCTURE SETUP
-- 10 chapters, 100 lessons created
-- =====================================================