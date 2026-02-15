-- =====================================================
-- CLASSICAL MECHANICS COURSE - STRUCTURE SETUP
-- 10 chapters, all 100 lessons with placeholder structure
-- Full content will be added in subsequent migrations
-- =====================================================

-- Update course metadata
UPDATE courses
SET
    title = 'Classical Mechanics',
    slug = 'classical-mechanics',
    description = 'Comprehensive course covering all fundamental principles of classical mechanics: kinematics, Newton''s laws, energy and momentum, rotational dynamics, gravitation, oscillations, Lagrangian mechanics, relativity, and modern applications. Ten chapters, 100 lessons with complete worked examples and practice problems.',
    icon_url = '/icons/classical-mechanics.svg',
    order_index = 1
WHERE id = 'classical-mechanics-uuid';

-- =====================================================
-- CHAPTER 1: INTRODUCTION TO MECHANICS
-- =====================================================

-- Update Chapter 1 with complete metadata
UPDATE chapters
SET
    title = 'Introduction to Mechanics',
    slug = 'introduction-to-mechanics',
    description = 'Kinematics in one and two dimensions, Newton''s three laws, fundamental forces, free-body diagrams, momentum and impulse, work and energy, conservation of energy. The foundations for all of mechanics.',
    order_index = 1
WHERE id = 'classical-mechanics-ch1-uuid';

-- Lessons 1.4-1.10 already exist - update their metadata
UPDATE lessons SET
    title = 'Newton''s First Law - Inertia and Reference Frames',
    slug = 'newtons-first-law',
    description = 'Inertia, inertial vs non-inertial frames, equilibrium, Aristotle''s error, and the true nature of friction.'
WHERE id = 'classical-mechanics-ch1-l4-uuid';

UPDATE lessons SET
    title = 'Newton''s Second Law - Force and Acceleration',
    slug = 'newtons-second-law',
    description = 'F = ma, weight, normal force, connected objects, inclined planes, and problem-solving strategies.'
WHERE id = 'classical-mechanics-ch1-l5-uuid';

UPDATE lessons SET
    title = 'Newton''s Third Law - Action and Reaction',
    slug = 'newtons-third-law',
    description = 'Action-reaction pairs, how walking and rockets work, analyzing interacting objects, and the Third Law in equilibrium.'
WHERE id = 'classical-mechanics-ch1-l6-uuid';

UPDATE lessons SET
    title = 'Free-Body Diagrams',
    slug = 'free-body-diagrams',
    description = 'Systematic approach to drawing FBDs, identifying all forces, choosing coordinate systems, and avoiding common errors.'
WHERE id = 'classical-mechanics-ch1-l7-uuid';

UPDATE lessons SET
    title = 'Motion with Variable Force',
    slug = 'variable-force-motion',
    description = 'Impulse, momentum, impulse-momentum theorem, force-time graphs, springs, air resistance, and terminal velocity.'
WHERE id = 'classical-mechanics-ch1-l8-uuid';

UPDATE lessons SET
    title = 'Work and Energy (Introduction)',
    slug = 'work-and-energy',
    description = 'Work as F·d, work by variable forces, kinetic energy, work-energy theorem, and power.'
WHERE id = 'classical-mechanics-ch1-l9-uuid';

UPDATE lessons SET
    title = 'Conservation of Energy (Introduction)',
    slug = 'conservation-of-energy',
    description = 'Potential energy, conservative forces, mechanical energy conservation, energy diagrams, and when energy is NOT conserved.'
WHERE id = 'classical-mechanics-ch1-l10-uuid';

-- =====================================================
-- CHAPTER 2: DYNAMICS OF PARTICLES
-- =====================================================

UPDATE chapters
SET
    title = 'Dynamics of Particles',
    slug = 'dynamics-of-particles',
    description = 'Friction (static and kinetic), pulleys and Atwood''s machine, uniform circular motion, centripetal force, applications of Newton''s laws to complex systems.',
    order_index = 2
WHERE id = 'classical-mechanics-ch2-uuid';

-- Lessons 2.1-2.3 exist - update metadata
UPDATE lessons SET
    title = 'Friction Forces - Static and Kinetic',
    slug = 'friction-forces',
    description = 'Static friction ≤ μₛN, kinetic friction = μₖN, microscopic origin, why friction doesn''t depend on area, friction on inclines, and friction enabling motion (walking, driving).'
WHERE id = 'classical-mechanics-ch2-l1-uuid';

UPDATE lessons SET
    title = 'Pulleys and Atwood''s Machine',
    slug = 'pulleys-and-atwoods-machine',
    description = 'Ideal pulleys, constraint relationships, basic and modified Atwood configurations, multiple pulleys, and mechanical advantage.'
WHERE id = 'classical-mechanics-ch2-l2-uuid';

UPDATE lessons SET
    title = 'Uniform Circular Motion',
    slug = 'uniform-circular-motion',
    description = 'Centripetal acceleration a = v²/r, centripetal force, flat vs banked curves, vertical circles, period and frequency, and common misconceptions about centrifugal force.'
WHERE id = 'classical-mechanics-ch2-l3-uuid';

-- =====================================================
-- CHAPTERS 3-10: PLACEHOLDER STRUCTURE
-- Full content to be added in subsequent migrations
-- =====================================================

-- Chapter 3: Work, Energy, and Power
UPDATE chapters
SET
    title = 'Work, Energy, and Power',
    slug = 'work-energy-power',
    description = 'Work by variable forces, conservative vs non-conservative forces, energy diagrams and equilibrium, power, and energy loss in collisions.',
    order_index = 3
WHERE id = 'classical-mechanics-ch3-uuid';

-- Chapter 4: Systems of Particles and Momentum
UPDATE chapters
SET
    title = 'Systems of Particles and Momentum',
    slug = 'systems-of-particles',
    description = 'Center of mass, momentum conservation in 2D, elastic and inelastic collisions, coefficient of restitution, impulse, rocket propulsion, and angular momentum.',
    order_index = 4
WHERE id = 'classical-mechanics-ch4-uuid';

-- Chapter 5: Rotational Dynamics
UPDATE chapters
SET
    title = 'Rotational Dynamics',
    slug = 'rotational-dynamics',
    description = 'Angular kinematics, torque, moment of inertia, Newton''s Second Law for rotation, rotational KE, parallel axis theorem, angular momentum, and rolling motion.',
    order_index = 5
WHERE id = 'classical-mechanics-ch5-uuid';

-- Chapter 6: Gravitation and Orbital Mechanics
UPDATE chapters
SET
    title = 'Gravitation and Orbital Mechanics',
    slug = 'gravitation-orbital-mechanics',
    description = 'Newton''s law of universal gravitation, gravitational potential energy, Kepler''s laws, orbital energy and velocity, escape velocity, geosynchronous orbits, and multi-body systems.',
    order_index = 6
WHERE id = 'classical-mechanics-ch6-uuid';

-- Chapter 7: Oscillations and Waves
UPDATE chapters
SET
    title = 'Oscillations and Waves',
    slug = 'oscillations-and-waves',
    description = 'Simple harmonic motion, energy in SHM, the pendulum, damped oscillations, forced oscillations and resonance, wave motion, sound waves, superposition, and normal modes.',
    order_index = 7
WHERE id = 'classical-mechanics-ch7-uuid';

-- Chapter 8: Lagrangian and Analytical Mechancs
UPDATE chapters
SET
    title = 'Lagrangian and Analytical Mechanics',
    slug = 'lagrangian-analytical-mechanics',
    description = 'Generalized coordinates, Lagrangian, Hamiltonian mechanics, conservation laws from symmetries, small oscillations, central force motion, and canonical transformations.',
    order_index = 8
WHERE id = 'classical-mechanics-ch8-uuid';

-- Chapter 9: Non-Inertial Frames and Relativity
UPDATE chapters
SET
    title = 'Non-Inertial Frames and Relativity',
    slug = 'non-inertial-frames-relativity',
    description = 'Accelerating and rotating reference frames, fictitious forces, special relativity postulates, time dilation, length contraction, relativistic energy and momentum, Lorentz transformations, and spacetime diagrams.',
    order_index = 9
WHERE id = 'classical-mechanics-ch9-uuid';

-- Chapter 10: Applications and Advanced Topics
UPDATE chapters
SET
    title = 'Applications and Advanced Topics',
    slug = 'applications-advanced-topics',
    description = 'Continuum mechanics, fluid mechanics, chaos and nonlinear dynamics, computational methods, biomechanics, engineering applications, astrophysical mechanics, connections to quantum mechanics, and modern experimental techniques.',
    order_index = 10
WHERE id = 'classical-mechanics-ch10-uuid';

-- =====================================================
-- LESSONS NEEDING FULL CONTENT
-- Will be updated in subsequent migrations by chapter
-- =====================================================

-- Remaining lessons in Chapter 2 (2.4-2.10) - placeholder
-- Will be populated with full content from reference files

-- All lessons in Chapters 3-10 - placeholder
-- Will be populated with full content from reference files

-- =====================================================
-- END OF STRUCTURE SETUP
-- =====================================================
