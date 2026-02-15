-- =====================================================
-- GENERAL CHEMISTRY COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons
-- =====================================================

-- Create General Chemistry course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'general-chemistry-uuid',
    'General Chemistry',
    'general-chemistry',
    'Comprehensive course covering atomic structure, chemical bonding, stoichiometry, states of matter, solutions, thermodynamics, equilibrium, and electrochemistry. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/chemistry.svg',
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 1: Atomic Structure
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch1-uuid',
    'general-chemistry-uuid',
    'Atomic Structure',
    'atomic-structure',
    'Complete chapter with all 10 lessons.',
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.1: Atomic Models
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l01-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-atomic-models',
    'Lesson 1.1: Atomic Models',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.2: Quantum Numbers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l02-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-quantum-numbers',
    'Lesson 1.2: Quantum Numbers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.3: Electron Configuration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l03-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-electron-configuration',
    'Lesson 1.3: Electron Configuration',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.4: Periodic Trends
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l04-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-periodic-trends',
    'Lesson 1.4: Periodic Trends',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.5: Ionic Bonding Basics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l05-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-ionic-bonding-basics',
    'Lesson 1.5: Ionic Bonding Basics',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.6: Covalent Bonding Basics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l06-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-covalent-bonding-basics',
    'Lesson 1.6: Covalent Bonding Basics',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.7: Bond Polarity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l07-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-bond-polarity',
    'Lesson 1.7: Bond Polarity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.8: Lewis Structures
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l08-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-lewis-structures',
    'Lesson 1.8: Lewis Structures',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.9: Formal Charge
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l09-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-formal-charge',
    'Lesson 1.9: Formal Charge',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.10: VSEPR Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch1-l10-uuid',
    'general-chemistry-ch1-uuid',
    'ch1-vsepr-theory',
    'Lesson 1.10: VSEPR Theory',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 2: Periodic Properties
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch2-uuid',
    'general-chemistry-uuid',
    'Periodic Properties',
    'periodic-properties',
    'Complete chapter with all 10 lessons.',
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.1: Atomic Radii
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l01-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-atomic-radii',
    'Lesson 2.1: Atomic Radii',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.2: Ionization Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l02-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-ionization-energy',
    'Lesson 2.2: Ionization Energy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.3: Electron Affinity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l03-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-electron-affinity',
    'Lesson 2.3: Electron Affinity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.4: Electronegativity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l04-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-electronegativity',
    'Lesson 2.4: Electronegativity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.5: Metallic Character
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l05-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-metallic-character',
    'Lesson 2.5: Metallic Character',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.6: Group Trends
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l06-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-group-trends',
    'Lesson 2.6: Group Trends',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.7: Periodic Trends
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l07-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-periodic-trends',
    'Lesson 2.7: Periodic Trends',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.8: Transition Metals
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l08-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-transition-metals',
    'Lesson 2.8: Transition Metals',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.9: Inner Transition Metals
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l09-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-inner-transition-metals',
    'Lesson 2.9: Inner Transition Metals',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch2-l10-uuid',
    'general-chemistry-ch2-uuid',
    'ch2-applications',
    'Lesson 2.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 3: Chemical Bonding I
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch3-uuid',
    'general-chemistry-uuid',
    'Chemical Bonding I',
    'chemical-bonding-1',
    'Complete chapter with all 10 lessons.',
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.1: Ionic Bonding
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l01-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-ionic-bonding',
    'Lesson 3.1: Ionic Bonding',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.2: Lattice Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l02-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-lattice-energy',
    'Lesson 3.2: Lattice Energy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.3: Covalent Bonding
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l03-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-covalent-bonding',
    'Lesson 3.3: Covalent Bonding',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.4: Bond Energy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l04-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-bond-energy',
    'Lesson 3.4: Bond Energy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.5: Bond Length
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l05-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-bond-length',
    'Lesson 3.5: Bond Length',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.6: Electronegativity in Bonding
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l06-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-electronegativity-in-bonding',
    'Lesson 3.6: Electronegativity in Bonding',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.7: Polarity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l07-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-polarity',
    'Lesson 3.7: Polarity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.8: Dipole Moments
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l08-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-dipole-moments',
    'Lesson 3.8: Dipole Moments',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.9: VSEPR Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l09-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-vsepr-theory',
    'Lesson 3.9: VSEPR Theory',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.10: Hybridization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch3-l10-uuid',
    'general-chemistry-ch3-uuid',
    'ch3-hybridization',
    'Lesson 3.10: Hybridization',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 4: Chemical Bonding II
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch4-uuid',
    'general-chemistry-uuid',
    'Chemical Bonding II',
    'chemical-bonding-2',
    'Complete chapter with all 10 lessons.',
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.1: Lewis Structures
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l01-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-lewis-structures',
    'Lesson 4.1: Lewis Structures',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.2: Resonance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l02-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-resonance',
    'Lesson 4.2: Resonance',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.3: Formal Charge
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l03-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-formal-charge',
    'Lesson 4.3: Formal Charge',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.4: Exceptions to Octet Rule
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l04-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-exceptions-to-octet-rule',
    'Lesson 4.4: Exceptions to Octet Rule',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.5: Bond Order
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l05-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-bond-order',
    'Lesson 4.5: Bond Order',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.6: Molecular Orbital Theory Basics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l06-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-molecular-orbital-theory-basics',
    'Lesson 4.6: Molecular Orbital Theory Basics',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.7: Sigma and Pi Bonds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l07-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-sigma-and-pi-bonds',
    'Lesson 4.7: Sigma and Pi Bonds',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.8: Conjugation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l08-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-conjugation',
    'Lesson 4.8: Conjugation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.9: Aromaticity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l09-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-aromaticity',
    'Lesson 4.9: Aromaticity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.10: Metallurgy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch4-l10-uuid',
    'general-chemistry-ch4-uuid',
    'ch4-metallurgy',
    'Lesson 4.10: Metallurgy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 5: States of Matter
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch5-uuid',
    'general-chemistry-uuid',
    'States of Matter',
    'states-of-matter',
    'Complete chapter with all 10 lessons.',
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.1: Solids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l01-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-solids',
    'Lesson 5.1: Solids',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.2: Liquids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l02-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-liquids',
    'Lesson 5.2: Liquids',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.3: Gases
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l03-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-gases',
    'Lesson 5.3: Gases',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.4: Phase Changes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l04-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-phase-changes',
    'Lesson 5.4: Phase Changes',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.5: Phase Diagrams
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l05-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-phase-diagrams',
    'Lesson 5.5: Phase Diagrams',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.6: Intermolecular Forces
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l06-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-intermolecular-forces',
    'Lesson 5.6: Intermolecular Forces',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.7: Crystall Solids I
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l07-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-crystall-solids-i',
    'Lesson 5.7: Crystall Solids I',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.8: Crystall Solids II
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l08-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-crystall-solids-ii',
    'Lesson 5.8: Crystall Solids II',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.9: Amorphous Solids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l09-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-amorphous-solids',
    'Lesson 5.9: Amorphous Solids',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.10: Liquid Crystals
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch5-l10-uuid',
    'general-chemistry-ch5-uuid',
    'ch5-liquid-crystals',
    'Lesson 5.10: Liquid Crystals',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 6: Stoichiometry
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch6-uuid',
    'general-chemistry-uuid',
    'Stoichiometry',
    'stoichiometry',
    'Complete chapter with all 10 lessons.',
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.1: Mole Concept
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l01-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-mole-concept',
    'Lesson 6.1: Mole Concept',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.2: Molar Mass
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l02-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-molar-mass',
    'Lesson 6.2: Molar Mass',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.3: Compositional Formulas
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l03-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-compositional-formulas',
    'Lesson 6.3: Compositional Formulas',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.4: Chemical Equations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l04-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-chemical-equations',
    'Lesson 6.4: Chemical Equations',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.5: Limiting Reactants
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l05-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-limiting-reactants',
    'Lesson 6.5: Limiting Reactants',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.6: Theoretical Yield
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l06-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-theoretical-yield',
    'Lesson 6.6: Theoretical Yield',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.7: Percent Yield
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l07-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-percent-yield',
    'Lesson 6.7: Percent Yield',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.8: Empirical Formulas
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l08-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-empirical-formulas',
    'Lesson 6.8: Empirical Formulas',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.9: Combustion Analysis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l09-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-combustion-analysis',
    'Lesson 6.9: Combustion Analysis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.10: Complex Stoichiometry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch6-l10-uuid',
    'general-chemistry-ch6-uuid',
    'ch6-complex-stoichiometry',
    'Lesson 6.10: Complex Stoichiometry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 7: Reactions in Solution
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch7-uuid',
    'general-chemistry-uuid',
    'Reactions in Solution',
    'reactions-solution',
    'Complete chapter with all 10 lessons.',
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.1: Solute and Solvent
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l01-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-solute-and-solvent',
    'Lesson 7.1: Solute and Solvent',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.2: Concentration Units
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l02-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-concentration-units',
    'Lesson 7.2: Concentration Units',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.3: Dissolution Process
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l03-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-dissolution-process',
    'Lesson 7.3: Dissolution Process',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.4: Solyubility Principles
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l04-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-solyubility-principles',
    'Lesson 7.4: Solyubility Principles',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.5: Colligative Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l05-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-colligative-properties',
    'Lesson 7.5: Colligative Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.6: Osmotic Pressure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l06-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-osmotic-pressure',
    'Lesson 7.6: Osmotic Pressure',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.7: Dilution Calculations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l07-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-dilution-calculations',
    'Lesson 7.7: Dilution Calculations',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.8: Titration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l08-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-titration',
    'Lesson 7.8: Titration',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.9: Acid-Base Titrations
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l09-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-acid-base-titrations',
    'Lesson 7.9: Acid-Base Titrations',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch7-l10-uuid',
    'general-chemistry-ch7-uuid',
    'ch7-applications',
    'Lesson 7.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 8: Gases
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch8-uuid',
    'general-chemistry-uuid',
    'Gases',
    'gases-chemistry',
    'Complete chapter with all 10 lessons.',
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.1: Gas Laws
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l01-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-gas-laws',
    'Lesson 8.1: Gas Laws',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.2: Ideal Gas Law
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l02-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-ideal-gas-law',
    'Lesson 8.2: Ideal Gas Law',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.3: Real Gas Behavior
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l03-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-real-gas-behavior',
    'Lesson 8.3: Real Gas Behavior',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.4: Kinetic Molecular Theory
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l04-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-kinetic-molecular-theory',
    'Lesson 8.4: Kinetic Molecular Theory',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.5: Effusion and Diffusion
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l05-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-effusion-and-diffusion',
    'Lesson 8.5: Effusion and Diffusion',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.6: Gas Stoichiometry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l06-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-gas-stoichiometry',
    'Lesson 8.6: Gas Stoichiometry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.7: Partial Pressure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l07-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-partial-pressure',
    'Lesson 8.7: Partial Pressure',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.8: Gas Phase Equilibria
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l08-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-gas-phase-equilibria',
    'Lesson 8.8: Gas Phase Equilibria',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.9: Non-Ideal Gases
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l09-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-non-ideal-gases',
    'Lesson 8.9: Non-Ideal Gases',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch8-l10-uuid',
    'general-chemistry-ch8-uuid',
    'ch8-applications',
    'Lesson 8.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 9: Thermochemistry
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch9-uuid',
    'general-chemistry-uuid',
    'Thermochemistry',
    'thermochemistry',
    'Complete chapter with all 10 lessons.',
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.1: Enthalpy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l01-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-enthalpy',
    'Lesson 9.1: Enthalpy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.2: Calorimetry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l02-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-calorimetry',
    'Lesson 9.2: Calorimetry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.3: Hess's Law
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l03-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-hess's-law',
    'Lesson 9.3: Hess's Law',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.4: Enthalpy of Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l04-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-enthalpy-of-formation',
    'Lesson 9.4: Enthalpy of Formation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.5: Bond Enthalpy
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l05-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-bond-enthalpy',
    'Lesson 9.5: Bond Enthalpy',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.6: Heat of Reaction
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l06-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-heat-of-reaction',
    'Lesson 9.6: Heat of Reaction',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.7: Exothermic vs Endothermic
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l07-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-exothermic-vs-endothermic',
    'Lesson 9.7: Exothermic vs Endothermic',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.8: Spontaneity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l08-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-spontaneity',
    'Lesson 9.8: Spontaneity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.9: Born-Haber Cycle
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l09-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-born-haber-cycle',
    'Lesson 9.9: Born-Haber Cycle',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch9-l10-uuid',
    'general-chemistry-ch9-uuid',
    'ch9-applications',
    'Lesson 9.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 10: Atomic Theory Introduction
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'general-chemistry-ch10-uuid',
    'general-chemistry-uuid',
    'Atomic Theory Introduction',
    'atomic-theory-intro',
    'Complete chapter with all 10 lessons.',
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.1: Historical Development
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l01-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-historical-development',
    'Lesson 10.1: Historical Development',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.2: Quantum Theory Origins
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l02-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-quantum-theory-origins',
    'Lesson 10.2: Quantum Theory Origins',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.3: Wave-Particle Duality
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l03-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-wave-particle-duality',
    'Lesson 10.3: Wave-Particle Duality',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.4: Photoelectric Effect
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l04-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-photoelectric-effect',
    'Lesson 10.4: Photoelectric Effect',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.5: Atomic Spectra
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l05-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-atomic-spectra',
    'Lesson 10.5: Atomic Spectra',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.6: Bohr Model
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l06-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-bohr-model',
    'Lesson 10.6: Bohr Model',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.7: Quantum Mechanics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l07-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-quantum-mechanics',
    'Lesson 10.7: Quantum Mechanics',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.8: Electron Configuration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l08-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-electron-configuration',
    'Lesson 10.8: Electron Configuration',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.9: Periodic Trends
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l09-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-periodic-trends',
    'Lesson 10.9: Periodic Trends',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.10: Review
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'general-chemistry-ch10-l10-uuid',
    'general-chemistry-ch10-uuid',
    'ch10-review',
    'Lesson 10.10: Review',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- =====================================================
-- END OF GENERAL CHEMISTRY STRUCTURE
-- =====================================================