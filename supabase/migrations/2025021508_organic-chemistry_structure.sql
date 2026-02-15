-- =====================================================
-- ORGANIC CHEMISTRY COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons
-- =====================================================

-- Create Organic Chemistry course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'organic-chemistry-uuid',
    'Organic Chemistry',
    'organic-chemistry',
    'Comprehensive course covering organic structure, bonding, alkanes, alkyl halides, alcohols, ethers, carbonyl compounds, carboxylic acids, and derivatives. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/organic-chemistry.svg',
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 1: Organic Structure
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-uuid',
    'organic-chemistry-uuid',
    'Organic Structure',
    'organic-structure',
    'Complete chapter with all 10 lessons.',
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.1: Structural Formulas
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l01-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-structural-formulas',
    'Lesson 1.1: Structural Formulas',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.2: Functional Groups
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l02-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-functional-groups',
    'Lesson 1.2: Functional Groups',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.3: Hybridization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l03-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-hybridization',
    'Lesson 1.3: Hybridization',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.4: Atomic Orbials Review
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l04-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-atomic-orbials-review',
    'Lesson 1.4: Atomic Orbials Review',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.5: Sigma Bonds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l05-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-sigma-bonds',
    'Lesson 1.5: Sigma Bonds',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.6: Pi Bonds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l06-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-pi-bonds',
    'Lesson 1.6: Pi Bonds',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.7: Electronegativity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l07-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-electronegativity',
    'Lesson 1.7: Electronegativity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.8: Inductive Effects
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l08-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-inductive-effects',
    'Lesson 1.8: Inductive Effects',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.9: Resonance
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l09-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-resonance',
    'Lesson 1.9: Resonance',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 1.10: Conjugation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch1-l10-uuid',
    'organic-chemistry-ch1-uuid',
    'ch1-conjugation',
    'Lesson 1.10: Conjugation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 2: Alkanes
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-uuid',
    'organic-chemistry-uuid',
    'Alkanes',
    'alkanes',
    'Complete chapter with all 10 lessons.',
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.1: Naming Alkanes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l01-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-naming-alkanes',
    'Lesson 2.1: Naming Alkanes',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.2: Constitutional Isomers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l02-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-constitutional-isomers',
    'Lesson 2.2: Constitutional Isomers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.3: Cycloalkanes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l03-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-cycloalkanes',
    'Lesson 2.3: Cycloalkanes',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.4: Conformational Analysis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l04-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-conformational-analysis',
    'Lesson 2.4: Conformational Analysis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.5: Physical Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l05-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-physical-properties',
    'Lesson 2.5: Physical Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.6: Chemical Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l06-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-chemical-properties',
    'Lesson 2.6: Chemical Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.7: Combustion
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l07-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-combustion',
    'Lesson 2.7: Combustion',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.8: Halogenation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l08-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-halogenation',
    'Lesson 2.8: Halogenation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.9: Cracking
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l09-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-cracking',
    'Lesson 2.9: Cracking',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 2.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch2-l10-uuid',
    'organic-chemistry-ch2-uuid',
    'ch2-applications',
    'Lesson 2.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 3: Alkenes
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-uuid',
    'organic-chemistry-uuid',
    'Alkenes',
    'alkenes',
    'Complete chapter with all 10 lessons.',
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.1: Naming Alkenes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l01-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-naming-alkenes',
    'Lesson 3.1: Naming Alkenes',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.2: Geometric Isomers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l02-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-geometric-isomers',
    'Lesson 3.2: Geometric Isomers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.3: Cis-Trans Nomenclature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l03-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-cis-trans-nomenclature',
    'Lesson 3.3: Cis-Trans Nomenclature',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.4: Preation Strategies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l04-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-preation-strategies',
    'Lesson 3.4: Preation Strategies',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.5: Polymerization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l05-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-polymerization',
    'Lesson 3.5: Polymerization',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.6: Chemical Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l06-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-chemical-properties',
    'Lesson 3.6: Chemical Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.7: Stability
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l07-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-stability',
    'Lesson 3.7: Stability',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.8: Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l08-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-reactions',
    'Lesson 3.8: Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.9: Polymer Chemistry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l09-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-polymer-chemistry',
    'Lesson 3.9: Polymer Chemistry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 3.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch3-l10-uuid',
    'organic-chemistry-ch3-uuid',
    'ch3-applications',
    'Lesson 3.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 4: Alkynes
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-uuid',
    'organic-chemistry-uuid',
    'Alkynes',
    'alkynes',
    'Complete chapter with all 10 lessons.',
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.1: Naming Alkynes
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l01-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-naming-alkynes',
    'Lesson 4.1: Naming Alkynes',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.2: Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l02-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-structure',
    'Lesson 4.2: Structure',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.3: Acidity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l03-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-acidity',
    'Lesson 4.3: Acidity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.4: Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l04-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-reactions',
    'Lesson 4.4: Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.5: Hydrogenation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l05-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-hydrogenation',
    'Lesson 4.5: Hydrogenation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.6: Halogenation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l06-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-halogenation',
    'Lesson 4.6: Halogenation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.7: Hydration
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l07-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-hydration',
    'Lesson 4.7: Hydration',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.8: Oxidation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l08-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-oxidation',
    'Lesson 4.8: Oxidation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.9: Polymerization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l09-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-polymerization',
    'Lesson 4.9: Polymerization',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 4.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch4-l10-uuid',
    'organic-chemistry-ch4-uuid',
    'ch4-applications',
    'Lesson 4.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 5: Alkyl Halides
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-uuid',
    'organic-chemistry-uuid',
    'Alkyl Halides',
    'alkyl-halides',
    'Complete chapter with all 10 lessons.',
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.1: Nomenclature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l01-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-nomenclature',
    'Lesson 5.1: Nomenclature',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.2: Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l02-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-structure',
    'Lesson 5.2: Structure',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.3: Physical Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l03-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-physical-properties',
    'Lesson 5.3: Physical Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.4: Nucleophilic Substitution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l04-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-nucleophilic-substitution',
    'Lesson 5.4: Nucleophilic Substitution',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.5: Elimination Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l05-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-elimination-reactions',
    'Lesson 5.5: Elimination Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.6: Competing Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l06-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-competing-reactions',
    'Lesson 5.6: Competing Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.7: Rearrangements
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l07-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-rearrangements',
    'Lesson 5.7: Rearrangements',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.8: Synthesis Strategies
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l08-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-synthesis-strategies',
    'Lesson 5.8: Synthesis Strategies',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.9: Environmental Impact
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l09-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-environmental-impact',
    'Lesson 5.9: Environmental Impact',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 5.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch5-l10-uuid',
    'organic-chemistry-ch5-uuid',
    'ch5-applications',
    'Lesson 5.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 6: Alcohols and Ethers
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-uuid',
    'organic-chemistry-uuid',
    'Alcohols and Ethers',
    'alcohols-ethers',
    'Complete chapter with all 10 lessons.',
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.1: Alcohol Nomenclature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l01-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-alcohol-nomenclature',
    'Lesson 6.1: Alcohol Nomenclature',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.2: Alcohol Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l02-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-alcohol-properties',
    'Lesson 6.2: Alcohol Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.3: Alcohol Synthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l03-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-alcohol-synthesis',
    'Lesson 6.3: Alcohol Synthesis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.4: Alcohol Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l04-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-alcohol-reactions',
    'Lesson 6.4: Alcohol Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.5: Ether Nomenclature
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l05-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-ether-nomenclature',
    'Lesson 6.5: Ether Nomenclature',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.6: Ether Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l06-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-ether-properties',
    'Lesson 6.6: Ether Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.7: Ether Synthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l07-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-ether-synthesis',
    'Lesson 6.7: Ether Synthesis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.8: Ether Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l08-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-ether-reactions',
    'Lesson 6.8: Ether Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.9: Protecting Groups
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l09-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-protecting-groups',
    'Lesson 6.9: Protecting Groups',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 6.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch6-l10-uuid',
    'organic-chemistry-ch6-uuid',
    'ch6-applications',
    'Lesson 6.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 7: Benzene and Aromatics
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-uuid',
    'organic-chemistry-uuid',
    'Benzene and Aromatics',
    'benzene-aromatics',
    'Complete chapter with all 10 lessons.',
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.1: Benzene Structure
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l01-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-benzene-structure',
    'Lesson 7.1: Benzene Structure',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.2: Aromaticity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l02-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-aromaticity',
    'Lesson 7.2: Aromaticity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.3: Electrophilic Substitution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l03-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-electrophilic-substitution',
    'Lesson 7.3: Electrophilic Substitution',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.4: Substitution Mechanisms
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l04-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-substitution-mechanisms',
    'Lesson 7.4: Substitution Mechanisms',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.5: Directing Effects
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l05-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-directing-effects',
    'Lesson 7.5: Directing Effects',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.6: Polycyclic Aromatics
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l06-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-polycyclic-aromatics',
    'Lesson 7.6: Polycyclic Aromatics',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.7: Heterocyclic Compounds
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l07-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-heterocyclic-compounds',
    'Lesson 7.7: Heterocyclic Compounds',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.8: Aromatic Stability
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l08-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-aromatic-stability',
    'Lesson 7.8: Aromatic Stability',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.9: Reactions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l09-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-reactions',
    'Lesson 7.9: Reactions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 7.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch7-l10-uuid',
    'organic-chemistry-ch7-uuid',
    'ch7-applications',
    'Lesson 7.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 8: Carbonyl Compounds
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-uuid',
    'organic-chemistry-uuid',
    'Carbonyl Compounds',
    'carbonyl-compounds',
    'Complete chapter with all 10 lessons.',
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.1: Aldehydes and Ketones
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l01-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-aldehydes-and-ketones',
    'Lesson 8.1: Aldehydes and Ketones',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.2: Naming Carbonyls
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l02-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-naming-carbonyls',
    'Lesson 8.2: Naming Carbonyls',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.3: Oxidation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l03-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-oxidation',
    'Lesson 8.3: Oxidation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.4: Redution
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l04-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-redution',
    'Lesson 8.4: Redution',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.5: Nucleophilic Addition
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l05-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-nucleophilic-addition',
    'Lesson 8.5: Nucleophilic Addition',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.6: Enamine Formation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l06-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-enamine-formation',
    'Lesson 8.6: Enamine Formation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.7: Aldol Condensation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l07-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-aldol-condensation',
    'Lesson 8.7: Aldol Condensation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.8: Claisen Condensation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l08-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-claisen-condensation',
    'Lesson 8.8: Claisen Condensation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.9: Synthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l09-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-synthesis',
    'Lesson 8.9: Synthesis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 8.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch8-l10-uuid',
    'organic-chemistry-ch8-uuid',
    'ch8-applications',
    'Lesson 8.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 9: Carboxylic Acids
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-uuid',
    'organic-chemistry-uuid',
    'Carboxylic Acids',
    'carboxylic-acids',
    'Complete chapter with all 10 lessons.',
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.1: Structure and Properties
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l01-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-structure-and-properties',
    'Lesson 9.1: Structure and Properties',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.2: Acid-Base Chemistry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l02-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-acid-base-chemistry',
    'Lesson 9.2: Acid-Base Chemistry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.3: Tautomerism
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l03-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-tautomerism',
    'Lesson 9.3: Tautomerism',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.4: Derivatization
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l04-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-derivatization',
    'Lesson 9.4: Derivatization',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.5: Decarboxylation
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l05-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-decarboxylation',
    'Lesson 9.5: Decarboxylation',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.6: Amino Acids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l06-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-amino-acids',
    'Lesson 9.6: Amino Acids',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.7: Proteins
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l07-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-proteins',
    'Lesson 9.7: Proteins',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.8: Nucleic Acids
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l08-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-nucleic-acids',
    'Lesson 9.8: Nucleic Acids',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.9: Fats
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l09-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-fats',
    'Lesson 9.9: Fats',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 9.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch9-l10-uuid',
    'organic-chemistry-ch9-uuid',
    'ch9-applications',
    'Lesson 9.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Chapter 10: Spectroscopy
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-uuid',
    'organic-chemistry-uuid',
    'Spectroscopy',
    'organic-spectroscopy',
    'Complete chapter with all 10 lessons.',
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.1: Chirality Centers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l01-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-chirality-centers',
    'Lesson 10.1: Chirality Centers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.2: Enantiomers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l02-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-enantiomers',
    'Lesson 10.2: Enantiomers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.3: Diastereomers
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l03-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-diastereomers',
    'Lesson 10.3: Diastereomers',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.4: Racemic Mixtures
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l04-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-racemic-mixtures',
    'Lesson 10.4: Racemic Mixtures',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.5: Optical Purity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l05-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-optical-purity',
    'Lesson 10.5: Optical Purity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.6: Resolutions
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l06-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-resolutions',
    'Lesson 10.6: Resolutions',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.7: Stereochemistry
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l07-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-stereochemistry',
    'Lesson 10.7: Stereochemistry',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.8: Asymmetric Synthesis
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l08-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-asymmetric-synthesis',
    'Lesson 10.8: Asymmetric Synthesis',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.9: Spectroselectivity
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l09-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-spectroselectivity',
    'Lesson 10.9: Spectroselectivity',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- Lesson 10.10: Applications
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
    'organic-chemistry-ch10-l10-uuid',
    'organic-chemistry-ch10-uuid',
    'ch10-applications',
    'Lesson 10.10: Applications',
    'Complete lesson with learning objectives, explanations, examples, practice problems.',
    '{"learningObjectives": ["Understand core concepts", "Apply principles to problems", "Connect to applications"]}'::jsonb,
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title WHERE id = EXCLUDED.id;

-- =====================================================
-- END OF ORGANIC CHEMISTRY STRUCTURE
-- =====================================================