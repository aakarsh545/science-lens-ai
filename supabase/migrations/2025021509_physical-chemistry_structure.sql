-- =====================================================
-- PHYSICAL CHEMISTRY COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons
-- =====================================================

-- Create Physical Chemistry course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'physical-chemistry-uuid',
    'Physical Chemistry',
    'physical-chemistry',
    'Comprehensive course covering quantum chemistry, spectroscopy, thermodynamics, kinetics, and dynamics. Ten chapters, 100 lessons.',
    '/icons/physical-chemistry.svg',
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 1: Quantum Chemistry Basics
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-uuid',
    'physical-chemistry-uuid',
    'Quantum Chemistry Basics',
    'quantum-basics',
    'Complete chapter with all 10 lessons.',
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.1: Wave Functions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l01-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-wave-functions',
    'Lesson 1.1: Wave Functions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.2: Schrödinger Equation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l02-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-schrödinger-equation',
    'Lesson 1.2: Schrödinger Equation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.3: Particle in Box
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l03-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-particle-in-box',
    'Lesson 1.3: Particle in Box',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.4: Harmonic Oscillator
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l04-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-harmonic-oscillator',
    'Lesson 1.4: Harmonic Oscillator',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.5: Hydrogen Atom
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l05-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-hydrogen-atom',
    'Lesson 1.5: Hydrogen Atom',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.6: Many-Electron Systems
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l06-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-many-electron-systems',
    'Lesson 1.6: Many-Electron Systems',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.7: Approximation Methods
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l07-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-approximation-methods',
    'Lesson 1.7: Approximation Methods',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.8: Computational Chemistry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l08-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-computational-chemistry',
    'Lesson 1.8: Computational Chemistry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.9: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l09-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-applications',
    'Lesson 1.9: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.10: Review
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'physical-chemistry-ch1-l10-uuid',
    'physical-chemistry-ch1-uuid',
    'ch1-review',
    'Lesson 1.10: Review',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- =====================================================
-- END OF PHYSICAL CHEMISTRY STRUCTURE
-- =====================================================