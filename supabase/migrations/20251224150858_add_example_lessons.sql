-- Add example lessons to demonstrate tree structure
-- Tree structure requires 6+ lessons per course

-- First, add more lessons to Basic Physics to show tree grouping
INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'basics-units', 'Basics: Units and Measurement',
'# Units and Measurement

Understanding physical quantities requires proper units.

## SI Units
- Length: meter (m)
- Mass: kilogram (kg)
- Time: second (s)
- Temperature: kelvin (K)

Always include units in your calculations!',
10, 1
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'motion-basics', 'Motion: Position and Velocity',
'# Position and Velocity

Motion is the change in position over time.

## Key Concepts
- **Position**: Where an object is located
- **Displacement**: Change in position
- **Velocity**: Rate of change of position
- **Speed**: Magnitude of velocity

The velocity formula: v = Δx / Δt',
15, 2
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'motion-acceleration', 'Motion: Acceleration',
'# Acceleration

Acceleration is the rate of change of velocity.

## Formula
a = Δv / Δt

## Types of Acceleration
- Positive (speeding up)
- Negative (slowing down)
- Centripetal (changing direction)

Objects in free fall accelerate at g = 9.8 m/s²',
15, 3
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'forces-intro', 'Forces: Introduction to Forces',
'# What are Forces?

A force is a push or pull on an object.

## Types of Forces
- **Contact Forces**: friction, normal, tension, applied
- **Non-contact Forces**: gravity, electromagnetic, nuclear

Forces are measured in Newtons (N).

Force is a vector - it has both magnitude and direction!',
15, 4
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'forces-newtons-laws', 'Forces: Newton''s Laws of Motion',
'# Newton''s Three Laws

## First Law (Inertia)
An object at rest stays at rest; an object in motion stays in motion, unless acted upon by a force.

## Second Law
F = ma (Force equals mass times acceleration)

## Third Law
For every action, there is an equal and opposite reaction.

These laws explain how objects move!',
20, 5
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'energy-work', 'Energy: Work and Power',
'# Work and Power

## Work
Work is done when a force moves an object.
W = F × d × cos(θ)

Work is measured in Joules (J).

## Power
Power is the rate of doing work.
P = W / t

Power is measured in Watts (W).

1 horsepower ≈ 746 Watts',
15, 6
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'energy-kinetic-potential', 'Energy: Kinetic and Potential Energy',
'# Types of Energy

## Kinetic Energy
Energy of motion: KE = ½mv²

## Potential Energy
Stored energy due to position: PE = mgh

## Conservation of Energy
Energy cannot be created or destroyed, only transformed.

Total mechanical energy: E = KE + PE',
20, 7
FROM public.courses WHERE slug = 'basic-physics'
ON CONFLICT DO NOTHING;

-- Add lessons to Chemistry Basics
INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Chemistry',
'# Welcome to Chemistry

Chemistry is the study of matter and its transformations.

## What You''ll Learn
- The periodic table
- Atoms and molecules
- Chemical reactions
- States of matter

Chemistry is everywhere - from cooking to medicine to materials!',
10, 0
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'basics-matter', 'Basics: What is Matter?',
'# Matter

Matter is anything that has mass and takes up space.

## States of Matter
- **Solid**: Fixed shape and volume
- **Liquid**: Fixed volume, takes shape of container
- **Gas**: Fills entire container
- **Plasma**: Ionized gas (stars!)

Matter can change states with temperature changes.',
10, 1
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'basics-atoms', 'Basics: Atoms and Elements',
'# Atoms and Elements

## The Atom
- **Protons**: Positive charge, in nucleus
- **Neutrons**: No charge, in nucleus
- **Electrons**: Negative charge, orbit nucleus

## Elements
An element is a pure substance made of one type of atom.
There are 118 known elements!

The atomic number = number of protons',
15, 2
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'reactions-intro', 'Reactions: Chemical Reactions',
'# Chemical Reactions

A chemical reaction transforms substances into new substances.

## Signs of a Reaction
- Color change
- Gas production (bubbles)
- Temperature change
- Precipitate forms

Reactants → Products

Mass is conserved in chemical reactions!',
15, 3
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'reactions-balancing', 'Reactions: Balancing Equations',
'# Balancing Chemical Equations

Atoms must be equal on both sides of the equation.

## Example
Unbalanced: H₂ + O₂ → H₂O
Balanced: 2H₂ + O₂ → 2H₂O

## Steps
1. Count atoms on each side
2. Add coefficients to balance
3. Check your work

Never change subscripts - only coefficients!',
20, 4
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'advanced-bonding', 'Advanced: Chemical Bonding',
'# Chemical Bonding

Atoms bond to achieve stable electron configurations.

## Types of Bonds
- **Ionic**: Transfer of electrons (NaCl)
- **Covalent**: Sharing of electrons (H₂O)
- **Metallic**: Sea of electrons (metals)

Bond strength affects properties like melting point!',
20, 5
FROM public.courses WHERE slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

-- Add lessons to Astronomy
INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Astronomy',
'# Welcome to Astronomy

Astronomy is the study of celestial objects and the universe.

## What You''ll Explore
- Our Solar System
- Stars and their life cycles
- Galaxies and deep space
- The history of the universe

Look up at the night sky - you''re seeing light that traveled billions of years!',
10, 0
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'planets-inner', 'Planets: The Inner Planets',
'# Inner Planets

The terrestrial planets closest to the Sun.

## Mercury
- Smallest planet
- Extreme temperatures
- No atmosphere

## Venus
- Hottest planet (runaway greenhouse)
- Thick toxic atmosphere

## Earth
- The only known planet with life
- Perfect distance from Sun

## Mars
- The Red Planet
- Evidence of ancient water',
15, 1
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'planets-outer', 'Planets: The Outer Planets',
'# Outer Planets

The gas and ice giants beyond the asteroid belt.

## Jupiter
- Largest planet
- Great Red Spot storm
- 79+ moons

## Saturn
- Famous ring system
- Lower density than water

## Uranus
- Tilted on its side
- Ice giant

## Neptune
- Strongest winds
- Farthest major planet',
15, 2
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'stars-lifecycle', 'Stars: Life Cycle of Stars',
'# Stellar Evolution

Stars are born, live, and die.

## Stages
1. **Nebula**: Cloud of gas and dust
2. **Protostar**: Gravity collapses cloud
3. **Main Sequence**: Stable hydrogen fusion
4. **Red Giant**: Hydrogen depleted
5. **End Stage**: Depends on mass

Our Sun is a main sequence star about 4.6 billion years old.',
20, 3
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'galaxies-types', 'Galaxies: Types of Galaxies',
'# Galaxies

Galaxies are massive collections of stars, dust, and dark matter.

## Types
- **Spiral**: Like our Milky Way, arms of stars
- **Elliptical**: Smooth, oval shaped
- **Irregular**: No defined shape

The observable universe contains ~2 trillion galaxies!

Our nearest major galaxy is Andromeda, 2.5 million light-years away.',
20, 4
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'cosmology-big-bang', 'Cosmology: The Big Bang',
'# The Big Bang

The universe began ~13.8 billion years ago.

## Evidence
- Cosmic Microwave Background radiation
- Redshift of distant galaxies
- Abundance of light elements

## Timeline
- 0: Big Bang singularity
- 380,000 years: First light
- 400 million years: First stars
- 13.8 billion years: Today

The universe is still expanding!',
25, 5
FROM public.courses WHERE slug = 'astronomy'
ON CONFLICT DO NOTHING;

-- Add intro lessons to remaining courses
INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Thermodynamics',
'# Welcome to Thermodynamics

Thermodynamics studies heat, energy, and their transformations.

## Key Concepts
- Heat and temperature
- Energy transfer
- Laws of thermodynamics
- Entropy

From engines to refrigerators, thermodynamics powers our world!',
10, 0
FROM public.courses WHERE slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Organic Chemistry',
'# Welcome to Organic Chemistry

Organic chemistry studies carbon-based compounds.

## Why Carbon?
- Forms 4 stable bonds
- Creates long chains and rings
- Bonds with many elements

From plastics to medicines to DNA - organic chemistry is everywhere!',
10, 0
FROM public.courses WHERE slug = 'organic-chemistry'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Biochemistry',
'# Welcome to Biochemistry

Biochemistry explores the chemistry of living things.

## Key Topics
- Proteins and enzymes
- DNA and RNA
- Metabolism
- Cell signaling

Understanding biochemistry helps us develop medicines and treatments!',
10, 0
FROM public.courses WHERE slug = 'biochemistry'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Cell Biology',
'# Welcome to Cell Biology

Cells are the basic units of life.

## Cell Types
- **Prokaryotic**: No nucleus (bacteria)
- **Eukaryotic**: Has nucleus (plants, animals, fungi)

Every living thing is made of cells - from single-celled bacteria to trillion-celled humans!',
10, 0
FROM public.courses WHERE slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Genetics',
'# Welcome to Genetics

Genetics is the study of heredity and variation.

## Key Concepts
- DNA structure
- Genes and chromosomes
- Inheritance patterns
- Genetic mutations

Your DNA contains about 3 billion base pairs and ~20,000 genes!',
10, 0
FROM public.courses WHERE slug = 'genetics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Ecology',
'# Welcome to Ecology

Ecology studies interactions between organisms and their environment.

## Key Concepts
- Ecosystems
- Food webs
- Population dynamics
- Biodiversity

Everything is connected - changes in one species affect the entire ecosystem!',
10, 0
FROM public.courses WHERE slug = 'ecology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Robotics',
'# Welcome to Robotics

Robotics combines engineering, computer science, and AI.

## Robot Components
- Sensors (input)
- Processors (decision making)
- Actuators (output/movement)

From factory arms to Mars rovers, robots are transforming our world!',
10, 0
FROM public.courses WHERE slug = 'robotics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to General Science',
'# Welcome to General Science

Science is the systematic study of the natural world.

## The Scientific Method
1. Observe and question
2. Form a hypothesis
3. Test with experiments
4. Analyze results
5. Draw conclusions

Science helps us understand everything around us!',
10, 0
FROM public.courses WHERE slug = 'general-science'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Origins',
'# Origins: How We Came to Be

This course explores scientific perspectives on origins.

## Topics Covered
- Formation of the universe
- Formation of Earth
- Origin of life
- Human evolution

A journey through 13.8 billion years of cosmic history!',
10, 0
FROM public.courses WHERE slug = 'origins-how-we-were-created'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Materials Science',
'# Welcome to Materials Science

Materials science studies properties and applications of materials.

## Material Categories
- Metals
- Ceramics
- Polymers
- Composites

From smartphones to spacecraft, materials science enables innovation!',
10, 0
FROM public.courses WHERE slug = 'materials-science'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Environmental Science',
'# Welcome to Environmental Science

Environmental science studies Earth''s systems and human impacts.

## Key Topics
- Climate systems
- Ecosystems
- Pollution
- Sustainability

Understanding our environment is crucial for a sustainable future!',
10, 0
FROM public.courses WHERE slug = 'environmental-science'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Neurobiology',
'# Welcome to Neurobiology

Neurobiology studies the nervous system and brain.

## Key Areas
- Neurons and synapses
- Brain regions
- Sensory processing
- Memory and learning

Your brain contains ~86 billion neurons making trillions of connections!',
10, 0
FROM public.courses WHERE slug = 'neurobiology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Astrophysics',
'# Welcome to Astrophysics

Astrophysics applies physics to understand celestial phenomena.

## Topics
- Stellar physics
- Black holes
- Dark matter
- Gravitational waves

Astrophysics reveals the most extreme physics in the universe!',
10, 0
FROM public.courses WHERE slug = 'astrophysics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, xp_reward, order_index)
SELECT id, 'intro', 'Introduction to Planetary Science',
'# Welcome to Planetary Science

Planetary science studies planets, moons, and planetary systems.

## What We Study
- Planet formation
- Planetary atmospheres
- Geology of other worlds
- Potential for life

We''ve discovered over 5,000 exoplanets beyond our solar system!',
10, 0
FROM public.courses WHERE slug = 'planetary-science'
ON CONFLICT DO NOTHING;
