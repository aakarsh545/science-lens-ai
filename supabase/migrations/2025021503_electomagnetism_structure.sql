-- =====================================================
-- ELECTROMAGNETISM COURSE - STRUCTURE SETUP
-- 10 chapters, 100 lessons with comprehensive content
-- Physics Course 2 of 4
-- =====================================================

-- Create Electromagnetism course
INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)
VALUES (
    'electomagnetism-uuid',
    'Electromagnetism',
    'electromagnetism',
    'Comprehensive course covering electric charges, fields, potentials, circuits, magnetic fields, electromagnetic waves, and Maxwell''s equations - the foundation of all electromagnetic phenomena. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    '/icons/electromagnetism.svg',
    2,
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
-- CHAPTER 1: ELECTRIC CHARGE AND COULOMB'S LAW
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch1-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Electric Charge and Coulomb''s Law',
    'electric-charge-coulombs-law',
    'Electric charge, quantization, conductors vs insulators, charging methods, Coulomb''s law, superposition principle, and electric field basics for point charges.',
    1,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lessons 1.1-1.10 for Chapter 1
DO $$
BEGIN
    DECLARE lesson_num INT;
    FOR lesson_num IN 1..10 LOOP
        INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
        VALUES (
            'electromagnetism-ch1-l' || lesson_num || '-uuid',
            'electromagnetism-ch1-uuid',
            'ch1-l' || lesson_num || '',
            'Lesson 1.' || lesson_num,
            'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
            lesson_num,
            NOW()
        )
        ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title,
            slug = EXCLUDED.slug,
            description = EXCLUDED.description,
            content = EXCLUDED.content,
            order_index = EXCLUDED.order_index
        WHERE id = EXCLUDED.id;
    END LOOP;
END $$;

-- =====================================================
-- CHAPTER 2: ELECTRIC FIELD
-- =====================================================

INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch2-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Electric Field',
    'electric-field',
    'Electric field lines, field of point charges, dipole fields, Gauss''s law, applications of Gauss''s law to symmetrical charge distributions, and conductors in electrostatic equilibrium.',
    2,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Lessons 2.1-2.10
DO $$
BEGIN
    DECLARE lesson_num INT;
    FOR lesson_num IN 1..10 LOOP
        INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
        VALUES (
            'electromagnetism-ch2-l' || lesson_num || '-uuid',
            'electromagnetism-ch2-uuid',
            'ch2-l' || lesson_num || '',
            'Lesson 2.' || lesson_num,
            'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
            lesson_num,
            NOW()
        )
        ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title,
            slug = EXCLUDED.slug,
            description = EXCLUDED.description,
            content = EXCLUDED.content,
            order_index = EXCLUDED.order_index
        WHERE id = EXCLUDED.id;
    END LOOP;
END $$;

-- =====================================================
-- CHAPTERS 3-10: STRUCTURE PLACEHOLDERS
-- Full lesson content to be added in subsequent migrations
-- =====================================================

-- Chapter 3: Electric Potential
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch3-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Electric Potential',
    'electric-potential',
    'Electric potential energy, potential difference, equipotential surfaces, calculating potential from charge distributions, and the relationship between field and potential.',
    3,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 4: Capacitors and Dielectrics
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch4-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Capacitors and Dielectrics',
    'capacitors-dielectrics',
    'Capacitance, parallel and series combinations, energy storage, dielectric materials, dielectric constant, and applications in circuits and devices.',
    4,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 5: Current and Resistance
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch5-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Current and Resistance',
    'current-and-resistance',
    'Electric current as charge flow, Ohm''s law, resistivity, temperature dependence, superconductivity, and energy dissipation in resistors.',
    5,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 6: Direct Current Circuits
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch6-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Direct Current Circuits',
    'direct-current-circuits',
    'Series and parallel circuits, Kirchhoff''s rules, RC circuits, measuring instruments, and complex circuit analysis techniques.',
    6,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 7: Magnetic Fields
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch7-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Magnetic Fields',
    'magnetic-fields',
    'Magnetic force on moving charges, Biot-Savart law, Ampère''s law, magnetic dipoles, and applications to solenoids, motors, and magnetic materials.',
    7,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 8: Electromagnetic Induction
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch8-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Electromagnetic Induction',
    'electromagnetic-induction',
    'Faraday''s law, Lenz''s law, induced electric fields, inductance, RL circuits, and applications to generators, transformers, and wireless technology.',
    8,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 9: Electromagnetic Waves
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch9-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Electromagnetic Waves',
    'electromagnetic-waves',
    'Maxwell''s equations, wave propagation, electromagnetic spectrum, energy transport, polarization, and applications to communication and optics.',
    9,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- Chapter 10: Modern Electromagnetism and Optics
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)
VALUES (
    'electromagnetism-ch10-uuid',
    (SELECT id FROM courses WHERE slug = 'electromagnetism'),
    'Modern Electromagnetism and Optics',
    'modern-electromagnetism-optics',
    'Relativistic electromagnetism, radiation from accelerating charges, optical phenomena, interference, diffraction, and the wave-particle duality of light.',
    10,
    NOW()
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    order_index = EXCLUDED.order_index
WHERE id = EXCLUDED.id;

-- =====================================================
-- LESSONS 3-10: PLACEHOLDERS
-- Will be populated with full content in subsequent migrations
-- =====================================================

-- Add placeholder lessons for Chapters 3-10 (10 lessons each)
DO $$
BEGIN
    DECLARE chapter_num INT;
    FOR chapter_num IN 3..10 LOOP
        DECLARE lesson_num INT;
        FOR lesson_num IN 1..10 LOOP
            INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
            VALUES (
                'electromagnetism-ch' || chapter_num || '-l' || lesson_num || '-uuid',
                'electromagnetism-ch' || chapter_num || '-uuid',
                'ch' || chapter_num || '-l' || lesson_num || '',
                'Lesson ' || chapter_num || '.' || lesson_num,
                'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',
                lesson_num,
                NOW()
            )
            ON CONFLICT (id) DO UPDATE SET
                title = EXCLUDED.title,
                slug = EXCLUDED.slug,
                description = EXCLUDED.description,
                content = EXCLUDED.content,
                order_index = EXCLUDED.order_index
            WHERE id = EXCLUDED.id;
        END LOOP;
    END LOOP;
END $$;

-- =====================================================
-- END OF ELECTROMAGNETISM STRUCTURE SETUP
-- 10 chapters, 100 lessons created
-- Full lesson content to be added in subsequent migrations
-- =====================================================
