-- Comprehensive lesson expansion with difficulty progression
-- From "everyone knows it" to "what is this" with smooth transitions

-- ============================================
-- BASIC PHYSICS - Complete Curriculum
-- ============================================

-- Level 1: Everyone Knows This (order_index 10-19)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'everyday-physics', 'Physics in Your Daily Life',
'# Physics is Everywhere!

You experience physics every single day, even if you don''t realize it.

## Morning Physics
- **Alarm clock**: Sound waves travel to your ears
- **Getting out of bed**: You push against the mattress, it pushes back (Newton''s Third Law!)
- **Walking**: Friction between your feet and floor prevents slipping
- **Breakfast**: Heat transfers from stove to pan to food

## Why Don''t We Float Away?
Gravity keeps us on Earth. It''s the same force that:
- Makes apples fall from trees
- Keeps the Moon orbiting Earth
- Makes water flow downhill

## Simple Machines Around You
- **Door handle**: A lever that multiplies your force
- **Scissors**: Two levers working together
- **Ramp/wheelchair access**: Trades distance for reduced effort
- **Screws**: Spiral ramps that hold things together

Physics isn''t just for scientists - it''s the instruction manual for how everything works!',
10, 10,
'{
  "questions": [
    {
      "question": "Why don''t we float away from Earth?",
      "options": ["Air pressure pushes us down", "Gravity pulls us toward Earth", "We are too heavy", "The ground is magnetic"],
      "correct": 1,
      "explanation": "Gravity is the force that attracts objects with mass toward each other. Earth''s gravity pulls us toward its center."
    },
    {
      "question": "When you walk, what prevents you from slipping?",
      "options": ["Gravity", "Air resistance", "Friction", "Magnetism"],
      "correct": 2,
      "explanation": "Friction between your shoes and the ground provides the grip needed for walking."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'why-things-fall', 'Why Things Fall Down',
'# The Mystery of Falling Objects

Every child asks: "Why do things fall down?" Let''s explore!

## Gravity: Earth''s Invisible Pull
- Earth has mass, and mass creates gravitational pull
- Everything with mass attracts everything else
- Earth is so massive that its pull dominates near the surface

## The Famous Question: Heavy vs Light Objects
**Common Myth**: Heavy things fall faster than light things

**Reality**: In a vacuum (no air), ALL objects fall at the same rate!
- A feather and a hammer dropped on the Moon hit the ground together
- Air resistance is what makes feathers float slowly on Earth

## Acceleration Due to Gravity
On Earth, falling objects speed up by about 10 m/s every second (actually 9.8 m/s²)
- After 1 second: 10 m/s
- After 2 seconds: 20 m/s
- After 3 seconds: 30 m/s

## Why This Matters
Understanding gravity helps us:
- Design safe buildings and bridges
- Calculate how high rockets need to go
- Predict where balls will land in sports
- Understand why planets orbit the Sun',
11, 10,
'{
  "questions": [
    {
      "question": "In a vacuum (no air), which falls faster: a bowling ball or a feather?",
      "options": ["Bowling ball falls faster", "Feather falls faster", "They fall at the same rate", "Neither falls in a vacuum"],
      "correct": 2,
      "explanation": "Without air resistance, all objects fall at the same rate regardless of their mass. This was demonstrated on the Moon!"
    },
    {
      "question": "On Earth, falling objects accelerate at approximately what rate?",
      "options": ["1 m/s²", "5 m/s²", "10 m/s² (9.8 m/s²)", "100 m/s²"],
      "correct": 2,
      "explanation": "Objects near Earth''s surface accelerate at about 9.8 m/s² due to gravity."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

-- Level 2: Basic Understanding (order_index 20-29)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'pressure-basics', 'Understanding Pressure',
'# Pressure: Force Spread Over Area

## What is Pressure?
Pressure = Force ÷ Area

The same force spread over a smaller area creates MORE pressure.

## Real-World Examples

### Why Knives Cut
- Sharp knife: Small edge area → High pressure → Cuts easily
- Dull knife: Larger edge area → Low pressure → Struggles to cut

### Snowshoes vs Regular Shoes
- Regular shoe: Your weight on small area → You sink in snow
- Snowshoe: Same weight spread over large area → You stay on top

### High Heels vs Flat Shoes
- A 60kg person in high heels can exert more pressure than an elephant!
- Heel area is tiny, so pressure (force/area) is enormous

## Atmospheric Pressure
- Air has weight and pushes on everything
- At sea level: About 101,325 Pascals (14.7 psi)
- That''s like 10 tons spread over your body!
- Why don''t we feel it? Pressure inside us pushes back equally

## Pressure in Fluids
- Deeper water = More water above = Higher pressure
- This is why your ears hurt when diving deep
- Also why deep-sea fish look strange when brought to surface',
20, 15,
'{
  "questions": [
    {
      "question": "Why does a sharp knife cut better than a dull knife using the same force?",
      "options": ["Sharp knives are heavier", "Sharp knives have smaller edge area creating higher pressure", "Sharp knives are magnetic", "Dull knives absorb force"],
      "correct": 1,
      "explanation": "Pressure = Force/Area. A sharp knife has a smaller edge area, so the same force creates higher pressure."
    },
    {
      "question": "Why do snowshoes help you walk on snow?",
      "options": ["They are lighter", "They spread your weight over a larger area reducing pressure", "They are waterproof", "They are warmer"],
      "correct": 1,
      "explanation": "Snowshoes distribute your weight over a larger area, reducing pressure on the snow so you don''t sink."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'waves-intro', 'Introduction to Waves',
'# Waves: Energy in Motion

## What is a Wave?
A wave is a disturbance that transfers energy from one place to another WITHOUT transferring matter.

Think of a stadium "wave" - the wave travels around, but people stay in their seats!

## Types of Waves

### Transverse Waves
- Disturbance is perpendicular to wave direction
- Examples: Light waves, waves on a string, water surface waves
- Like shaking a rope up and down

### Longitudinal Waves
- Disturbance is parallel to wave direction
- Examples: Sound waves, compression in a slinky
- Like pushing and pulling a slinky

## Wave Properties
- **Wavelength (λ)**: Distance between wave peaks
- **Frequency (f)**: How many waves pass per second (Hz)
- **Amplitude**: Height of the wave (relates to energy)
- **Speed**: How fast the wave travels

## The Wave Equation
Speed = Wavelength × Frequency
v = λ × f

## Waves You Experience Daily
- Sound: Longitudinal waves in air
- Light: Electromagnetic transverse waves
- Radio: Long electromagnetic waves
- WiFi: Electromagnetic waves carrying data
- Ocean waves: Energy from wind traveling through water',
21, 15,
'{
  "questions": [
    {
      "question": "What do waves transfer from one place to another?",
      "options": ["Matter", "Energy", "Atoms", "Weight"],
      "correct": 1,
      "explanation": "Waves transfer energy without transferring matter. The medium oscillates but doesn''t travel with the wave."
    },
    {
      "question": "Sound waves are what type of wave?",
      "options": ["Transverse", "Longitudinal", "Circular", "Static"],
      "correct": 1,
      "explanation": "Sound waves are longitudinal - the air particles compress and expand in the same direction the sound travels."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'sound-physics', 'The Physics of Sound',
'# Sound: Vibrations We Can Hear

## How Sound Works
1. Something vibrates (vocal cords, guitar string, speaker)
2. Vibrations push air molecules
3. Molecules push their neighbors (compression wave)
4. Wave reaches your ear
5. Eardrum vibrates
6. Brain interprets as sound

## Speed of Sound
- In air (20°C): ~343 m/s (767 mph)
- In water: ~1,480 m/s (much faster!)
- In steel: ~5,960 m/s (even faster!)

Sound travels faster in denser materials because molecules are closer.

## Properties of Sound

### Pitch (Frequency)
- High frequency = High pitch (whistle, bird chirp)
- Low frequency = Low pitch (bass drum, thunder)
- Humans hear: 20 Hz to 20,000 Hz

### Loudness (Amplitude)
- Measured in decibels (dB)
- Whisper: ~30 dB
- Normal conversation: ~60 dB
- Rock concert: ~110 dB
- Pain threshold: ~130 dB

### Timbre (Quality)
Why a violin and piano playing the same note sound different:
- Each instrument produces different harmonic patterns

## Sound Phenomena
- **Echo**: Sound bouncing off surfaces
- **Doppler Effect**: Why ambulance siren changes pitch as it passes
- **Sonic Boom**: When objects exceed sound speed',
22, 15,
'{
  "questions": [
    {
      "question": "Sound travels fastest through which medium?",
      "options": ["Air", "Water", "Steel", "Vacuum"],
      "correct": 2,
      "explanation": "Sound travels fastest through solids like steel because molecules are packed tightly together."
    },
    {
      "question": "What determines the pitch of a sound?",
      "options": ["Amplitude", "Frequency", "Speed", "Medium"],
      "correct": 1,
      "explanation": "Frequency determines pitch - higher frequency means higher pitch."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'light-basics', 'Understanding Light',
'# Light: The Fastest Thing in the Universe

## What is Light?
Light is electromagnetic radiation - it''s both a wave AND a particle (photon)!

## Speed of Light
- In vacuum: 299,792,458 m/s (about 300,000 km/s)
- Light travels from Sun to Earth in about 8 minutes
- Nothing with mass can travel this fast

## The Electromagnetic Spectrum
From longest to shortest wavelength:
1. **Radio waves**: Communication, WiFi
2. **Microwaves**: Cooking, radar
3. **Infrared**: Heat, remote controls
4. **Visible light**: What we see (red → violet)
5. **Ultraviolet**: Sunburn, black lights
6. **X-rays**: Medical imaging
7. **Gamma rays**: Most energetic, from nuclear reactions

Visible light is just a tiny slice of the spectrum!

## How We See Color
- White light contains all colors
- Objects absorb some wavelengths, reflect others
- A red apple absorbs all colors except red
- A white object reflects all colors
- A black object absorbs all colors

## Light Behaviors
- **Reflection**: Bouncing off surfaces (mirrors)
- **Refraction**: Bending when entering different medium (lenses)
- **Diffraction**: Bending around obstacles
- **Interference**: Waves combining (soap bubble colors)',
23, 15,
'{
  "questions": [
    {
      "question": "What is the speed of light in a vacuum?",
      "options": ["300 m/s", "300,000 m/s", "300,000 km/s", "300,000,000 km/s"],
      "correct": 2,
      "explanation": "Light travels at approximately 300,000 km/s (or about 300 million m/s) in a vacuum."
    },
    {
      "question": "Why does a red apple appear red?",
      "options": ["It emits red light", "It absorbs red and reflects other colors", "It reflects red and absorbs other colors", "It contains red dye"],
      "correct": 2,
      "explanation": "Objects appear colored because they reflect certain wavelengths and absorb others. A red apple reflects red light."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

-- Level 3: Intermediate Concepts (order_index 30-39)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'momentum-impulse', 'Momentum and Impulse',
'# Momentum: Mass in Motion

## What is Momentum?
Momentum (p) = Mass × Velocity
p = m × v

A moving object has momentum. The more massive and faster, the more momentum.

## Examples
- Truck at 30 mph has more momentum than car at 30 mph (more mass)
- Car at 60 mph has more momentum than same car at 30 mph (more velocity)
- A bullet has high momentum despite small mass due to high velocity

## Conservation of Momentum
In a closed system, total momentum before = total momentum after

This explains:
- Billiard balls transferring motion
- Rockets working in space (exhaust goes one way, rocket goes other)
- Why you move backward when throwing a heavy ball

## Impulse: Changing Momentum
Impulse = Force × Time = Change in Momentum
J = F × Δt = Δp

## Why Airbags Work
To stop you (same change in momentum):
- Short time → Large force → Injury
- Long time → Small force → Safer

Airbags increase the stopping time, reducing the force on your body.

## Applications
- Car crumple zones extend collision time
- Bending knees when landing
- Following through in baseball/golf
- Catching eggs without breaking them',
30, 20,
'{
  "questions": [
    {
      "question": "What happens to the force if you increase the time over which momentum changes?",
      "options": ["Force increases", "Force decreases", "Force stays the same", "Momentum increases"],
      "correct": 1,
      "explanation": "Impulse = Force × Time. For the same change in momentum, increasing time means decreasing force."
    },
    {
      "question": "Why do airbags help in car crashes?",
      "options": ["They make you lighter", "They increase the time to stop, reducing force", "They add momentum", "They make the car bounce"],
      "correct": 1,
      "explanation": "Airbags increase the stopping time, which reduces the force experienced during the crash."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'circular-motion', 'Circular Motion and Centripetal Force',
'# Going in Circles: Physics of Rotation

## Uniform Circular Motion
Moving in a circle at constant speed, but velocity is always changing!
Why? Velocity includes direction, and direction constantly changes.

## Centripetal Force
"Center-seeking" force that keeps objects moving in circles

F_c = mv²/r

Where:
- m = mass
- v = velocity
- r = radius of circle

## What Provides Centripetal Force?
- **Car turning**: Friction between tires and road
- **Satellite orbiting**: Gravity from Earth
- **Ball on string**: Tension in string
- **Roller coaster loop**: Normal force from track

## Common Misconception: "Centrifugal Force"
There''s no outward force pushing you against the car door in a turn!

What''s really happening:
- Your body wants to go straight (inertia)
- Car turns, door pushes you inward (centripetal force)
- You feel "pushed out" but you''re actually being pushed IN

## Applications
- Centrifuges separate blood components
- Washing machine spin cycle
- Artificial gravity in space stations (rotation)
- Why planets orbit rather than fall into the Sun',
31, 20,
'{
  "questions": [
    {
      "question": "What force keeps a satellite in orbit around Earth?",
      "options": ["Centrifugal force", "Magnetic force", "Gravity (centripetal)", "Air resistance"],
      "correct": 2,
      "explanation": "Gravity provides the centripetal force that curves the satellite''s path into an orbit."
    },
    {
      "question": "In uniform circular motion, what is constantly changing?",
      "options": ["Speed", "Direction (velocity)", "Mass", "Radius"],
      "correct": 1,
      "explanation": "In uniform circular motion, speed is constant but direction constantly changes, so velocity (which includes direction) changes."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'electricity-basics', 'Fundamentals of Electricity',
'# Electricity: The Flow of Charge

## Electric Charge
- Two types: Positive (+) and Negative (-)
- Like charges repel, opposite charges attract
- Electrons carry negative charge
- Protons carry positive charge

## Electric Current
Current = Flow of electric charges (usually electrons)
Measured in Amperes (A)

Like water flowing through a pipe!

## Voltage (Potential Difference)
- The "push" that moves charges
- Like water pressure in pipes
- Measured in Volts (V)
- Higher voltage = more push = more current

## Resistance
- Opposition to current flow
- Measured in Ohms (Ω)
- Thin wires = more resistance
- Some materials resist more than others

## Ohm''s Law
V = I × R

Voltage = Current × Resistance

This is THE fundamental equation of circuits!

## Circuits
- **Series**: Components in a line (same current through all)
- **Parallel**: Components side by side (voltage same across all)

## Power in Circuits
P = V × I = I²R = V²/R

Measured in Watts (W)

This is why high-power devices (heaters, motors) draw lots of current!',
32, 20,
'{
  "questions": [
    {
      "question": "According to Ohm''s Law, if you double the voltage across a resistor, what happens to the current?",
      "options": ["Halves", "Stays same", "Doubles", "Quadruples"],
      "correct": 2,
      "explanation": "V = IR. If R is constant and V doubles, I must double."
    },
    {
      "question": "What does electrical resistance measure?",
      "options": ["The push on charges", "Opposition to current flow", "The amount of charge", "The speed of electrons"],
      "correct": 1,
      "explanation": "Resistance measures how much a material opposes the flow of electric current."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'magnetism-basics', 'Magnetism and Electromagnetism',
'# Magnetism: The Invisible Force

## Magnetic Poles
- Every magnet has North and South poles
- Like poles repel, opposite poles attract
- You cannot isolate a single pole (cut a magnet → two smaller magnets)

## Magnetic Fields
- Region around a magnet where magnetic forces act
- Represented by field lines (North to South outside magnet)
- Strongest at the poles

## Earth''s Magnetic Field
- Earth acts like a giant magnet
- Geographic North is actually near Magnetic South!
- Protects us from solar wind
- Allows compass navigation

## The Connection: Electricity ↔ Magnetism
**Electric Current Creates Magnetic Field**
- Current through a wire creates circular magnetic field
- Coil of wire (solenoid) acts like a bar magnet
- Basis of electromagnets

**Changing Magnetic Field Creates Electric Current**
- Moving a magnet near a coil induces current
- Basis of generators and transformers

## Electromagnetic Induction
Faraday''s discovery: Changing magnetic flux through a loop induces voltage

This powers our modern world:
- Generators at power plants
- Transformers for power distribution
- Electric guitar pickups
- Wireless charging',
33, 20,
'{
  "questions": [
    {
      "question": "What happens when you pass electric current through a wire?",
      "options": ["The wire becomes radioactive", "A magnetic field is created around the wire", "The wire becomes invisible", "Nothing happens"],
      "correct": 1,
      "explanation": "Electric current creates a magnetic field around the wire - this is the basis of electromagnets."
    },
    {
      "question": "How do electric generators work?",
      "options": ["By using batteries", "By changing magnetic fields to induce electric current", "By chemical reactions", "By nuclear fission"],
      "correct": 1,
      "explanation": "Generators use electromagnetic induction - spinning magnets create changing magnetic fields that induce electric current in coils."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

-- Level 4: Advanced Concepts (order_index 40-49)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'relativity-intro', 'Introduction to Special Relativity',
'# Einstein''s Revolutionary Ideas

## The Problem with Classical Physics
By late 1800s, physics had a problem:
- Maxwell''s equations predicted light travels at c (constant)
- But velocity should depend on observer''s motion... shouldn''t it?

## Einstein''s Postulates (1905)
1. **Laws of physics are the same** in all inertial reference frames
2. **Speed of light (c) is constant** regardless of observer''s motion

These simple statements have mind-bending consequences!

## Time Dilation
"Moving clocks run slow"

If you travel at high speed:
- Your clock runs slower relative to stationary observers
- For you, everything seems normal
- Only noticeable at speeds approaching c

γ (gamma) = 1/√(1 - v²/c²)

t'' = γt (moving time = gamma × stationary time)

## Length Contraction
"Moving objects are shortened"

Objects moving at high speed appear contracted in direction of motion:
L'' = L/γ

## Mass-Energy Equivalence
E = mc²

- Mass and energy are interchangeable
- A small mass contains enormous energy
- Basis of nuclear power and weapons
- Explains why you can''t reach light speed (would need infinite energy)

## Real-World Evidence
- GPS satellites must account for relativity
- Particle accelerators observe time dilation
- Muons from cosmic rays reach Earth''s surface
- Mass increase in particle accelerators',
40, 25,
'{
  "questions": [
    {
      "question": "What happens to time for an observer traveling at very high speeds?",
      "options": ["Time speeds up", "Time slows down relative to stationary observers", "Time reverses", "Time stops completely"],
      "correct": 1,
      "explanation": "Time dilation: moving clocks run slower. This has been verified with precise atomic clocks on airplanes and satellites."
    },
    {
      "question": "Why can''t an object with mass travel at the speed of light?",
      "options": ["It would explode", "It would require infinite energy", "Light would slow down", "It''s just a speed limit"],
      "correct": 1,
      "explanation": "As objects approach light speed, their relativistic mass increases, requiring infinite energy to reach c."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'quantum-concepts', 'Quantum Physics: The Weird World of the Small',
'# When Physics Gets Strange

## The Quantum Revolution
Classical physics couldn''t explain:
- Blackbody radiation
- Photoelectric effect
- Atomic spectra
- Stability of atoms

## Wave-Particle Duality
Light and matter exhibit BOTH wave and particle properties!

- Light: Waves (interference) + Particles (photoelectric effect)
- Electrons: Particles + Waves (diffraction patterns)

Which property you observe depends on how you measure!

## The Uncertainty Principle
Heisenberg''s discovery: You CANNOT simultaneously know exact position AND momentum

Δx × Δp ≥ ℏ/2

This isn''t about measurement limitations - it''s fundamental to nature!

## Quantum Superposition
Before measurement, particles exist in ALL possible states simultaneously

Schrödinger''s Cat: A cat in a box with a quantum trigger is both alive AND dead until observed

## Quantum Tunneling
Particles can "tunnel" through barriers they classically couldn''t cross
- Makes nuclear fusion in stars possible
- Used in scanning tunneling microscopes
- Flash memory relies on this

## Entanglement
"Spooky action at a distance" - Einstein

Measuring one entangled particle instantly affects its partner, regardless of distance
- Not useful for faster-than-light communication
- Basis of quantum computing and cryptography',
41, 25,
'{
  "questions": [
    {
      "question": "What does wave-particle duality mean?",
      "options": ["Waves are made of particles", "Light and matter can exhibit both wave and particle properties", "Particles are faster than waves", "Waves and particles are the same thing"],
      "correct": 1,
      "explanation": "Wave-particle duality means that quantum objects like photons and electrons can behave as either waves or particles depending on how they are observed."
    },
    {
      "question": "What does the Uncertainty Principle state?",
      "options": ["We can''t measure anything accurately", "We can''t know exact position AND momentum simultaneously", "Quantum physics is uncertain", "Measurements are always wrong"],
      "correct": 1,
      "explanation": "The Uncertainty Principle states there''s a fundamental limit to how precisely we can know both position and momentum of a particle."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'thermodynamics-advanced', 'Entropy and the Arrow of Time',
'# Why Time Moves Forward

## The Laws of Thermodynamics

### Zeroth Law
If A is in thermal equilibrium with C, and B is with C, then A is with B
(Allows us to define temperature)

### First Law
Energy cannot be created or destroyed
ΔU = Q - W (Change in internal energy = Heat added - Work done)

### Second Law
Entropy of an isolated system always increases (or stays same)
Heat flows from hot to cold, never reverse spontaneously

### Third Law
As temperature approaches absolute zero, entropy approaches a constant minimum

## What is Entropy?
Entropy (S) measures disorder/randomness

More precisely: number of microscopic arrangements (microstates) corresponding to a macrostate

S = k_B × ln(W)  (Boltzmann''s equation)

## Why Entropy Increases
There are VASTLY more disordered states than ordered ones
- A broken egg has many arrangements
- An intact egg has very few
- Systems naturally evolve toward more probable states

## The Arrow of Time
Why does time seem to flow one direction?

The Second Law gives time a direction:
- We remember the past (lower entropy)
- We can''t remember the future (higher entropy)
- Entropy increase defines "forward" in time

## Heat Death of the Universe
Eventually, all energy will spread evenly
- No temperature differences
- No work can be extracted
- Maximum entropy
- Time loses meaning',
42, 25,
'{
  "questions": [
    {
      "question": "What does the Second Law of Thermodynamics state about entropy?",
      "options": ["Entropy always decreases", "Entropy stays constant", "Entropy of an isolated system tends to increase", "Entropy can be created"],
      "correct": 2,
      "explanation": "The Second Law states that the entropy (disorder) of an isolated system never decreases and typically increases over time."
    },
    {
      "question": "Why does time seem to have a direction?",
      "options": ["Because clocks only go forward", "Because of increasing entropy", "Because of gravity", "Time doesn''t have a direction"],
      "correct": 1,
      "explanation": "The arrow of time is linked to the Second Law - the universe evolves from lower to higher entropy states."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

-- Level 5: Expert Level (order_index 50-59)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'general-relativity', 'General Relativity: Gravity as Geometry',
'# Einstein''s Masterpiece

## Beyond Special Relativity
Special relativity: Physics in non-accelerating frames
General relativity: Includes acceleration and gravity

## The Equivalence Principle
Being in a gravitational field is indistinguishable from accelerating

In a closed elevator:
- Can''t tell if you''re on Earth or accelerating at g in space
- This equivalence is the foundation of General Relativity

## Spacetime Curvature
Mass tells spacetime how to curve
Curved spacetime tells mass how to move

Objects don''t "fall" due to force - they follow the straightest possible path (geodesic) through curved spacetime!

## The Einstein Field Equations
G_μν + Λg_μν = (8πG/c⁴)T_μν

Left side: Geometry of spacetime
Right side: Distribution of matter/energy
These equations are incredibly complex - most solutions require computers

## Predictions of General Relativity
1. **Gravitational time dilation**: Clocks run slower in stronger gravity
2. **Gravitational lensing**: Light bends around massive objects
3. **Black holes**: Spacetime curved so much that nothing escapes
4. **Gravitational waves**: Ripples in spacetime from accelerating masses
5. **Frame dragging**: Rotating masses drag spacetime along

## Evidence
- Mercury''s orbital precession
- Gravitational lensing observations
- LIGO detecting gravitational waves (2015)
- GPS requires both special and general relativistic corrections',
50, 30,
'{
  "questions": [
    {
      "question": "According to General Relativity, what causes gravity?",
      "options": ["A force between masses", "Curvature of spacetime caused by mass", "Electromagnetic attraction", "Dark matter"],
      "correct": 1,
      "explanation": "Einstein showed that gravity isn''t a force - it''s the curvature of spacetime caused by mass and energy."
    },
    {
      "question": "What are gravitational waves?",
      "options": ["Sound waves from space", "Light from stars", "Ripples in spacetime from accelerating masses", "Radio signals"],
      "correct": 2,
      "explanation": "Gravitational waves are ripples in the fabric of spacetime, predicted by Einstein and detected by LIGO in 2015."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'standard-model', 'The Standard Model of Particle Physics',
'# The Particle Zoo

## Fundamental Particles

### Quarks (6 types, or "flavors")
- **Up (u)**: charge +2/3
- **Down (d)**: charge -1/3
- **Charm (c), Strange (s), Top (t), Bottom (b)**

Quarks combine to form:
- Protons (uud)
- Neutrons (udd)
- Many other hadrons

### Leptons (6 types)
- **Electron (e)**: familiar negative particle
- **Muon (μ)**: heavier electron cousin
- **Tau (τ)**: even heavier
- Each has an associated neutrino (νe, νμ, ντ)

### Force Carriers (Bosons)
- **Photon (γ)**: Electromagnetic force
- **W⁺, W⁻, Z⁰**: Weak nuclear force
- **Gluons (g)**: Strong nuclear force
- **Higgs boson (H)**: Gives particles mass

## The Four Fundamental Forces
1. **Gravity**: Weakest, infinite range (not in Standard Model)
2. **Electromagnetism**: Photon exchange, infinite range
3. **Weak Force**: W/Z exchange, very short range, radioactive decay
4. **Strong Force**: Gluon exchange, holds quarks together

## Color Charge
Quarks carry "color" charge: red, green, blue
Gluons carry color-anticolor
All observable particles are "color neutral"

## The Higgs Field
Particles gain mass by interacting with the Higgs field
- Discovered at CERN in 2012
- Completed the Standard Model

## Beyond the Standard Model
Still unexplained:
- Gravity
- Dark matter
- Dark energy
- Matter-antimatter asymmetry
- Neutrino masses',
51, 30,
'{
  "questions": [
    {
      "question": "Which particle gives other particles their mass?",
      "options": ["Photon", "Electron", "Higgs boson", "Gluon"],
      "correct": 2,
      "explanation": "The Higgs boson is associated with the Higgs field, which gives particles their mass through interaction."
    },
    {
      "question": "What force carrier is responsible for the strong nuclear force?",
      "options": ["Photon", "W boson", "Gluon", "Graviton"],
      "correct": 2,
      "explanation": "Gluons carry the strong force that holds quarks together inside protons and neutrons."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'quantum-field-theory', 'Quantum Field Theory: The Framework of Modern Physics',
'# The Ultimate Framework

## From Particles to Fields
In QFT, fundamental entities are fields, not particles
Particles are excitations (quanta) of their respective fields

- Electron field → electrons
- Electromagnetic field → photons
- Higgs field → Higgs bosons

## Why Fields?
1. Explains particle creation/annihilation
2. Naturally incorporates special relativity
3. Handles identical particles correctly
4. Predicts antimatter

## Virtual Particles
In QFT, forces arise from exchange of "virtual" particles
These exist briefly, allowed by uncertainty principle

ΔE × Δt ≥ ℏ/2

## Feynman Diagrams
Visual representation of particle interactions
- Lines represent particles
- Vertices represent interactions
- Sum all possible diagrams for probability

## Renormalization
Problem: Calculations give infinite answers!
Solution: "Renormalize" - absorb infinities into redefined constants

This controversial technique works extraordinarily well

## QED: Quantum Electrodynamics
The most precise theory in science
Predicts electron magnetic moment to 12 decimal places!

## The Quantum Vacuum
The vacuum isn''t empty:
- Virtual particles constantly appear/disappear
- Casimir effect: vacuum fluctuations create measurable force
- Vacuum energy might drive cosmic expansion

## Open Questions
- Quantum gravity: Can''t quantize general relativity
- Hierarchy problem: Why is gravity so weak?
- Naturalness: Why are constants what they are?',
52, 30,
'{
  "questions": [
    {
      "question": "In Quantum Field Theory, what are particles?",
      "options": ["Fundamental points", "Excitations of quantum fields", "Waves only", "Mathematical abstractions"],
      "correct": 1,
      "explanation": "In QFT, particles are quantized excitations of underlying quantum fields that permeate all of space."
    },
    {
      "question": "What do virtual particles help explain in QFT?",
      "options": ["Why space is empty", "How forces are transmitted between particles", "Why particles have mass", "How time works"],
      "correct": 1,
      "explanation": "Virtual particles mediate forces - they''re exchanged between interacting particles to transmit forces."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'basic-physics'
ON CONFLICT DO NOTHING;


-- ============================================
-- CHEMISTRY BASICS - Additional Lessons
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'kitchen-chemistry', 'Chemistry in Your Kitchen',
'# Science on Your Counter

## Cooking is Chemistry!

### Baking Soda + Vinegar
- Sodium bicarbonate + Acetic acid
- Produces carbon dioxide gas (bubbles!)
- Same reaction makes cakes rise

### Caramelization
- Heating sugar above 170°C
- Complex chemical decomposition
- Creates hundreds of new flavor compounds

### Maillard Reaction
- Proteins + sugars + heat
- Creates brown color and complex flavors
- Why bread crusts, grilled meat, and coffee taste so good

## Acids and Bases at Home
**Acids** (sour taste, pH < 7):
- Lemon juice (citric acid)
- Vinegar (acetic acid)
- Coffee (various acids)

**Bases** (bitter taste, pH > 7):
- Baking soda
- Soap
- Bleach

## Why Onions Make You Cry
Cutting releases enzymes that create sulfur compounds
These compounds react with water in your eyes to form sulfuric acid!

## Food Preservation
- **Salt/sugar**: Draw out water, prevent bacterial growth
- **Vinegar**: Low pH kills microorganisms
- **Refrigeration**: Slows chemical reactions
- **Canning**: Sterilizes and seals',
15, 10,
'{
  "questions": [
    {
      "question": "What gas is produced when baking soda and vinegar mix?",
      "options": ["Oxygen", "Hydrogen", "Carbon dioxide", "Nitrogen"],
      "correct": 2,
      "explanation": "Baking soda (sodium bicarbonate) reacts with vinegar (acetic acid) to produce carbon dioxide gas."
    },
    {
      "question": "What chemical reaction gives grilled meat its distinctive flavor and brown color?",
      "options": ["Oxidation", "Maillard reaction", "Fermentation", "Photosynthesis"],
      "correct": 1,
      "explanation": "The Maillard reaction between proteins and sugars at high temperatures creates browning and complex flavors."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'acids-bases-ph', 'Acids, Bases, and the pH Scale',
'# The Chemistry of Sour and Bitter

## What are Acids?
- Donate hydrogen ions (H⁺) in solution
- Taste sour
- React with metals to produce hydrogen gas
- Examples: HCl, H₂SO₄, citric acid

## What are Bases?
- Accept hydrogen ions / donate hydroxide ions (OH⁻)
- Taste bitter, feel slippery
- Examples: NaOH, NH₃, baking soda

## The pH Scale
Measures hydrogen ion concentration
pH = -log[H⁺]

**Scale: 0 to 14**
- pH 0-6: Acidic (more H⁺)
- pH 7: Neutral
- pH 8-14: Basic/Alkaline (more OH⁻)

Each number is 10× different from the next!

## Common pH Values
- Battery acid: 0
- Stomach acid: 1-2
- Lemon juice: 2
- Coffee: 5
- Pure water: 7
- Blood: 7.4
- Baking soda: 8
- Ammonia: 11
- Bleach: 13

## Neutralization
Acid + Base → Salt + Water
HCl + NaOH → NaCl + H₂O

## Buffer Solutions
Resist pH changes
- Blood is buffered to stay near 7.4
- Essential for life!',
25, 15,
'{
  "questions": [
    {
      "question": "What pH value is neutral?",
      "options": ["0", "7", "14", "10"],
      "correct": 1,
      "explanation": "pH 7 is neutral, where the concentration of H⁺ and OH⁻ ions are equal."
    },
    {
      "question": "What is produced when an acid reacts with a base?",
      "options": ["More acid", "A salt and water", "A gas only", "A metal"],
      "correct": 1,
      "explanation": "Neutralization: Acid + Base → Salt + Water. For example, HCl + NaOH → NaCl + H₂O."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'electrochemistry', 'Electrochemistry: Electricity from Chemistry',
'# Where Chemistry Meets Electricity

## Redox Reactions
**Oxidation**: Loss of electrons
**Reduction**: Gain of electrons
"OIL RIG" - Oxidation Is Loss, Reduction Is Gain

These always occur together - electrons must go somewhere!

## Batteries
Convert chemical energy to electrical energy

### How they work:
1. Oxidation at anode (negative terminal)
2. Electrons flow through external circuit
3. Reduction at cathode (positive terminal)
4. Ions flow through electrolyte to complete circuit

### Types:
- **Primary**: Non-rechargeable (alkaline)
- **Secondary**: Rechargeable (lithium-ion)

## Electroplating
Using electricity to coat objects with metal
- Jewelry (gold plating)
- Corrosion protection (chrome plating)
- Electronics (copper circuit boards)

## Electrolysis
Using electricity to drive non-spontaneous reactions
- Splitting water into H₂ and O₂
- Producing aluminum from ore
- Chlorine production

## Corrosion
Unwanted electrochemistry!
- Iron + oxygen + water → rust (Fe₂O₃·nH₂O)
- Prevention: Paint, galvanizing, cathodic protection

## Fuel Cells
Like batteries but fuel is continuously supplied
- Hydrogen + Oxygen → Water + Electricity
- Clean energy technology',
35, 20,
'{
  "questions": [
    {
      "question": "In a battery, what happens at the anode?",
      "options": ["Reduction occurs", "Oxidation occurs", "Nothing happens", "Ions are stored"],
      "correct": 1,
      "explanation": "Oxidation occurs at the anode - electrons are released and flow through the external circuit."
    },
    {
      "question": "What is electrolysis?",
      "options": ["A type of battery", "Using electricity to cause chemical reactions", "Natural corrosion", "A chemical catalyst"],
      "correct": 1,
      "explanation": "Electrolysis uses electrical energy to drive non-spontaneous chemical reactions, like splitting water."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'organic-reactions', 'Organic Reaction Mechanisms',
'# How Organic Molecules React

## Types of Reactions

### Substitution
One group replaces another
- Nucleophilic substitution (SN1, SN2)
- Electrophilic substitution (aromatic)

### Addition
Groups add across a double/triple bond
- Hydrogenation: Adding H₂
- Halogenation: Adding X₂

### Elimination
Groups leave, forming double bonds
- Dehydration: Removing H₂O
- Dehydrohalogenation: Removing HX

### Oxidation-Reduction
Changing oxidation states of carbon
- Alcohol → Aldehyde → Carboxylic acid

## Nucleophiles and Electrophiles
**Nucleophile**: "Nucleus-loving" - electron-rich, attacks positive centers
**Electrophile**: "Electron-loving" - electron-poor, attracts electrons

## Reaction Mechanisms
Step-by-step electron movements

Arrow notation:
- Curved arrow: Movement of electron pair
- Fishhook arrow: Movement of single electron

## SN2 Mechanism Example
Backside attack, concerted mechanism:
1. Nucleophile approaches from behind leaving group
2. Bond forms as old bond breaks
3. Configuration inverts (like umbrella flipping)

## Catalysts in Organic Chemistry
- Acid/base catalysis
- Metal catalysis (Pd, Pt, Ni)
- Enzyme catalysis (biological)',
45, 25,
'{
  "questions": [
    {
      "question": "What does a nucleophile do in a reaction?",
      "options": ["Accepts electrons", "Donates electrons / attacks positive centers", "Releases protons", "Absorbs light"],
      "correct": 1,
      "explanation": "Nucleophiles are electron-rich species that donate electrons to or attack electron-poor (positive) centers."
    },
    {
      "question": "What type of reaction adds hydrogen across a double bond?",
      "options": ["Substitution", "Elimination", "Addition (hydrogenation)", "Oxidation"],
      "correct": 2,
      "explanation": "Hydrogenation is an addition reaction where H₂ adds across a double or triple bond."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;


-- ============================================
-- ASTRONOMY - Additional Lessons
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'night-sky', 'Reading the Night Sky',
'# Looking Up: A Beginner''s Guide

## What You Can See
- Stars (distant suns)
- Planets (wandering stars)
- The Moon
- Meteors (shooting stars)
- Satellites (man-made)
- The Milky Way band (our galaxy edge-on)

## Finding Your Way
**North Star (Polaris)**
- Find Big Dipper
- Follow the "pointer stars" from the cup
- Polaris is at the end of Little Dipper''s handle
- Stays fixed while other stars rotate around it

## Planets vs Stars
Stars twinkle (light disturbed by atmosphere)
Planets usually don''t (larger apparent size)

Planets appear along the ecliptic (sun''s path)

## The Ecliptic and Zodiac
- Sun''s apparent yearly path across the sky
- Zodiac constellations lie along this line
- Planets always found near the ecliptic

## Best Viewing Conditions
- Dark location (away from city lights)
- Clear, dry night
- Moon not too bright (new moon best)
- Let eyes adapt for 20+ minutes

## Meteor Showers
Debris from comets burning in atmosphere
- Perseids (August)
- Geminids (December)
- Leonids (November)',
12, 10,
'{
  "questions": [
    {
      "question": "Why do stars twinkle but planets usually don''t?",
      "options": ["Planets are closer", "Stars are hotter", "Planets have larger apparent size, so atmospheric disturbance averages out", "Planets reflect light differently"],
      "correct": 2,
      "explanation": "Planets appear as tiny disks, so atmospheric turbulence averages out. Stars are point sources, so each ray is affected individually."
    },
    {
      "question": "What causes meteor showers?",
      "options": ["Alien spacecraft", "Earth passing through debris left by comets", "Stars falling", "Moon dust"],
      "correct": 1,
      "explanation": "Meteor showers occur when Earth passes through debris trails left behind by comets."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'stellar-evolution', 'Life Cycle of Stars',
'# From Birth to Death: Stellar Evolution

## Star Formation
1. Giant molecular cloud collapses
2. Gravity pulls gas and dust together
3. Center heats up from compression
4. Nuclear fusion ignites - a star is born!

## Main Sequence
- Hydrogen fuses to helium in core
- Outward pressure balances gravity
- Most of star''s life spent here
- Our Sun: ~10 billion years on main sequence

## What Happens Next Depends on Mass

### Low Mass Stars (< 8 solar masses)
1. Hydrogen runs out in core
2. Core contracts, outer layers expand → Red Giant
3. Helium fusion begins (helium flash)
4. Outer layers shed → Planetary Nebula
5. Core remains → White Dwarf
6. Slowly cools over trillions of years

### High Mass Stars (> 8 solar masses)
1. Faster evolution through stages
2. Fuses heavier elements up to iron
3. Iron core cannot fuse - no energy output
4. Catastrophic core collapse
5. **SUPERNOVA** explosion
6. Leaves behind:
   - Neutron star (1.4-3 solar masses), or
   - Black hole (> 3 solar masses)

## Creating the Elements
- Stars create elements up to iron through fusion
- Heavier elements created in supernovae
- We are literally made of star stuff!',
35, 20,
'{
  "questions": [
    {
      "question": "What causes a star to become a red giant?",
      "options": ["It gets angry", "Core hydrogen is depleted, causing the outer layers to expand", "It absorbs other stars", "It moves closer to Earth"],
      "correct": 1,
      "explanation": "When core hydrogen is exhausted, fusion stops briefly, the core contracts, heats up, and the outer layers expand dramatically."
    },
    {
      "question": "What determines whether a star becomes a white dwarf, neutron star, or black hole?",
      "options": ["Age", "Color", "Mass", "Distance from Earth"],
      "correct": 2,
      "explanation": "A star''s mass determines its fate: low mass → white dwarf, high mass → neutron star or black hole after supernova."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'black-holes', 'Black Holes: When Gravity Wins',
'# The Ultimate Gravitational Monsters

## What is a Black Hole?
A region where gravity is so intense that nothing - not even light - can escape once past the event horizon.

## Formation
**Stellar black holes**: Massive star collapse (> 3 solar masses)
**Supermassive black holes**: Found at galaxy centers (millions to billions of solar masses)
**Primordial black holes**: Possibly formed in early universe (theoretical)

## Anatomy of a Black Hole

### Singularity
- Center point of infinite density
- Where all the mass is concentrated
- Laws of physics as we know them break down

### Event Horizon
- "Point of no return"
- Radius = Schwarzschild radius
- Rs = 2GM/c²
- For Sun: ~3 km (Sun would need to be compressed)

### Accretion Disk
- Matter spiraling into black hole
- Heats up due to friction - glows brightly
- Can be brighter than entire galaxy!

### Jets
- Some black holes shoot material at near light speed
- Perpendicular to accretion disk
- Can extend thousands of light years

## Time Near Black Holes
Gravitational time dilation extreme near event horizon
- Observer far away sees falling object slow, redshift, and freeze at horizon
- Falling observer experiences crossing horizon in finite time

## Hawking Radiation
Black holes aren''t completely black!
- Quantum effects cause slow emission
- Black holes eventually evaporate
- Smaller = hotter = evaporate faster',
45, 25,
'{
  "questions": [
    {
      "question": "What is the event horizon of a black hole?",
      "options": ["The center point", "The boundary beyond which nothing can escape", "The spinning disk around it", "The jets it produces"],
      "correct": 1,
      "explanation": "The event horizon is the boundary around a black hole beyond which the escape velocity exceeds the speed of light."
    },
    {
      "question": "What is Hawking radiation?",
      "options": ["X-rays from the accretion disk", "Quantum emission that causes black holes to slowly evaporate", "Radio waves from jets", "Visible light from the singularity"],
      "correct": 1,
      "explanation": "Hawking radiation is thermal radiation predicted to be emitted by black holes due to quantum effects near the event horizon."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'astronomy'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz)
SELECT c.id, 'cosmology', 'Cosmology: The Universe as a Whole',
'# The Big Picture

## The Big Bang
~13.8 billion years ago, the universe began from an extremely hot, dense state

**Evidence:**
1. Cosmic Microwave Background (CMB): Afterglow of Big Bang
2. Hubble''s Law: Galaxies moving apart
3. Abundance of light elements (H, He, Li)
4. Large-scale structure formation

## Expansion of the Universe
Space itself is expanding!
- Galaxies aren''t moving through space
- Space between galaxies is stretching
- More distant = faster apparent recession

## Dark Matter
~27% of universe
- Doesn''t emit light
- Detectable only through gravity
- Holds galaxies together
- Required for observed galaxy rotation curves

## Dark Energy
~68% of universe
- Causing accelerating expansion
- Completely mysterious
- Discovered 1998

## Ordinary Matter
Only ~5% of universe!
- Everything we can see and touch
- Stars, planets, gas, dust, us

## The Fate of the Universe

### Big Freeze (most likely)
- Expansion continues forever
- Stars burn out
- Black holes evaporate
- Heat death - maximum entropy

### Big Crunch (unlikely with dark energy)
- Expansion reverses
- Universe collapses

### Big Rip (possible)
- Dark energy increases
- Tears apart galaxies, stars, atoms

## Open Questions
- What is dark matter?
- What is dark energy?
- What caused the Big Bang?
- Are there other universes?',
55, 30,
'{
  "questions": [
    {
      "question": "What is the Cosmic Microwave Background (CMB)?",
      "options": ["Light from distant stars", "Radiation from the early universe, the afterglow of the Big Bang", "Signals from aliens", "Heat from black holes"],
      "correct": 1,
      "explanation": "The CMB is thermal radiation left over from about 380,000 years after the Big Bang, when the universe became transparent to light."
    },
    {
      "question": "What makes up most of the universe?",
      "options": ["Stars and planets", "Gas and dust", "Dark matter and dark energy", "Black holes"],
      "correct": 2,
      "explanation": "Dark energy (~68%) and dark matter (~27%) make up ~95% of the universe. Ordinary matter is only ~5%."
    }
  ]
}'::jsonb
FROM courses c WHERE c.slug = 'astronomy'
ON CONFLICT DO NOTHING;
