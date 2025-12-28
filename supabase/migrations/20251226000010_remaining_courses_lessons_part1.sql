-- Comprehensive lessons for all remaining courses to reach 20 lessons per course
-- This ensures every course has comprehensive content

-- ============================================
-- THERMODYNAMICS - Add 19 more lessons (total: 20)
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-temp-intro', 'What is Temperature?',
'# Understanding Temperature

## What is Temperature?
Temperature is a measure of how hot or cold something is:
- Related to the average kinetic energy of particles
- Higher temperature = particles moving faster
- Measured with thermometers

## Temperature Scales
- **Celsius**: Water freezes at 0°C, boils at 100°C
- **Fahrenheit**: Water freezes at 32°F, boils at 212°F
- **Kelvin**: Absolute scale, 0 K = absolute zero
- **Absolute Zero**: -273.15°C (-459.67°F) - coldest possible temperature

## Thermal Equilibrium
When objects at different temperatures touch:
- Heat flows from hot to cold
- Eventually both reach same temperature
- No more net heat transfer

## Thermal Expansion
Most substances expand when heated:
- Solids: Expand slightly
- Liquids: Expand more than solids
- Gases: Expand most of all
- Exceptions: Water contracts when freezing (0-4°C)

## Why Temperature Matters
- Determines state of matter (solid, liquid, gas)
- Affects chemical reaction rates
- Critical for life processes
- Basis of heat engines',
20, 15,
'{
  "questions": [
    {"question": "What happens to particle motion as temperature increases?", "options": ["Particles slow down", "Particles move faster", "Motion stays the same", "Particles stop"], "correct": 1, "explanation": "Higher temperature means particles have more kinetic energy and move faster."},
    {"question": "What is absolute zero on the Celsius scale?", "options": ["0°C", "-100°C", "-273.15°C", "-373°C"], "correct": 2, "explanation": "Absolute zero is -273.15°C, the coldest theoretically possible temperature where all molecular motion stops."}
  ]
}'::jsonb, 'Chapter 1: Temperature and Heat'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-heat-transfer', 'Heat Transfer Methods',
'# How Heat Moves

## Conduction
Heat transfer through direct contact:
- Heat moves from hot to cold
- Requires physical contact
- Best in solids
- Example: Metal spoon getting hot in soup

## Convection
Heat transfer through fluid movement:
- Fluid (liquid/gas) heats up, expands, rises
- Cooler fluid sinks to replace it
- Creates convection currents
- Examples: Boiling water, weather patterns, wind

## Radiation
Heat transfer through electromagnetic waves:
- Requires no medium
- Can travel through vacuum
- Example: Heat from the Sun
- Infrared radiation

## Insulation
Reducing heat transfer:
- Conduction insulators: Materials that don''t conduct well (wood, plastic)
- Convection insulators: Trapped air (fiberglass, styrofoam)
- Radiation reflectors: Shiny surfaces (foil blankets)

## Applications
- **Homes**: Insulation in walls and attics
- **Cooking**: Pots conduct heat, ovens use convection
- **Clothing**: Insulates body from cold
- **Thermos**: Minimizes all three heat transfers',
21, 15,
'{
  "questions": [
    {"question": "Which heat transfer method requires no medium?", "options": ["Conduction", "Convection", "Radiation", "Insulation"], "correct": 2, "explanation": "Radiation transfers heat through electromagnetic waves and can travel through a vacuum, like heat from the Sun reaching Earth."},
    {"question": "Why does foam insulation work?", "options": ["It conducts heat well", "It traps air to reduce convection", "It absorbs heat", "It generates heat"], "correct": 1, "explanation": "Foam insulation works because trapped air pockets minimize convection, and the solid material reduces conduction."}
  ]
}'::jsonb, 'Chapter 1: Temperature and Heat'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-thermal-expansion', 'Thermal Expansion',
'# Expansion and Contraction

## Linear Expansion
Objects expand in all directions when heated:
ΔL = α × L₀ × ΔT
- α: Coefficient of linear expansion
- L₀: Original length
- ΔT: Temperature change

## Volume Expansion
For liquids and gases:
ΔV = β × V₀ × ΔT
- β: Coefficient of volume expansion
- V₀: Original volume

## Real-World Examples

### Expansion Joints
Bridges have expansion joints because:
- Steel expands ~1 cm per 12 m per 100°C
- Without joints, bridge would buckle
- Accounts for temperature extremes

### Bimetallic Strips
Two metals bonded together:
- Different expansion coefficients
- Causes bending when heated
- Used in thermostats

### Railroad Tracks
Must have gaps between rails:
- Steel expands significantly in heat
- Without gaps, tracks would buckle
- "Click-clack" sound from gaps passing

## Water''s Anomaly
Water contracts when cooled 4°C → 0°C:
- Becomes less dense
- Ice floats on water
- Fish survive under ice in winter

## Applications
- Thermometers (mercury/alcohol expansion)
- Thermostats (bimetallic strips)
- Engine cooling (expansion tank)
- Building design (expansion joints)',
22, 15,
'{
  "questions": [
    {"question": "Why do bridges have expansion joints?", "options": ["To make them lighter", "To allow for thermal expansion and contraction", "To reduce cost", "For drainage"], "correct": 1, "explanation": "Expansion joints allow bridges to expand and contract with temperature changes without buckling or damaging the structure."},
    {"question": "What happens to water as it freezes from 4°C to 0°C?", "options": ["It contracts normally", "It expands and becomes less dense", "It stays the same density", "It becomes denser"], "correct": 1, "explanation": "Water expands and becomes less dense as it freezes, which is why ice floats on water."}
  ]
}'::jsonb, 'Chapter 1: Temperature and Heat'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-heat-capacity', 'Heat Capacity',
'# Heat Capacity: Thermal Inertia

## What is Heat Capacity?
Amount of heat needed to change temperature:
Q = c × m × ΔT
- Q: Heat energy
- c: Specific heat capacity
- m: Mass
- ΔT: Temperature change

## Specific Heat Capacity
Heat needed to raise 1 gram by 1°C:
- Water: 4.184 J/g°C (very high!)
- Aluminum: 0.897 J/g°C
- Iron: 0.449 J/g°C
- Gold: 0.129 J/g°C

Water is excellent at storing heat!

## Calorimetry
Measuring heat transfer:
- Mix hot and cold water
- Measure final temperature
- Calculate heat capacity
- Basis of nutrition science (Calories)

## Thermal Inertia
High heat capacity = resists temperature change:
- Water moderates coastal climate
- Oceans absorb solar energy
- Large bodies of water stabilize temperature

## Applications

### Cooking
- Water heats slowly, stays hot
- Oil heats faster, cools faster
- Different for different cooking methods

### Climate
- Coastal areas: Moderate temperature swings
- Inland areas: Extreme temperature swings
- Water moderates climate

### Engineering
- Engine coolant (water)
- Heat sinks (materials with high capacity)
- Thermal storage systems',
23, 15,
'{
  "questions": [
    {"question": "Which substance has the highest specific heat capacity?", "options": ["Gold", "Iron", "Water", "Aluminum"], "correct": 2, "explanation": "Water has one of the highest specific heat capacities at 4.184 J/g°C, meaning it takes a lot of energy to change its temperature."},
    {"question": "Why do coastal areas have milder climates than inland areas?", "options": ["Coastal areas are closer to the ocean", "Water''s high heat capacity moderates temperature changes", "Inland areas are hotter", "Ocean currents are cold"], "correct": 1, "explanation": "Water''s high heat capacity means oceans absorb and release heat slowly, moderating temperature changes in coastal areas."}
  ]
}'::jsonb, 'Chapter 1: Temperature and Heat'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-first-law', 'First Law: Conservation of Energy',
'# Energy Cannot Be Created or Destroyed

## The First Law of Thermodynamics
ΔU = Q - W
- ΔU: Change in internal energy
- Q: Heat added to system
- W: Work done BY system

## Internal Energy (U)
Total energy of a system:
- Kinetic energy of particles
- Potential energy between particles
- Depends on temperature, phase, amount

## Heat (Q)
Energy transfer due to temperature difference:
- Q > 0: Heat added
- Q < 0: Heat removed
- Not a state function (depends on path)

## Work (W)
Energy transfer by force through distance:
- W > 0: Work done BY system (expansion)
- W < 0: Work done ON system (compression)
- In gases: W = PΔV

## Applications

### Heat Engines
Convert heat to mechanical work:
- Take in heat (Q_H)
- Do work (W)
- Release waste heat (Q_C)
- Q_H = W + Q_C

### Human Body
Metabolic processes:
- Chemical energy → Heat + Work
- First law applies
- Energy balance maintained

## Energy Transformation
Energy changes form but total conserved:
- Chemical → Thermal → Mechanical
- Electrical → Thermal → Light
- Nuclear → Thermal → Electrical',
30, 20,
'{
  "questions": [
    {"question": "What does the First Law of Thermodynamics state?", "options": ["Energy can be created", "Energy cannot be created or destroyed, only transformed", "Heat always flows cold to hot", "Entropy always increases"], "correct": 1, "explanation": "The First Law states that energy cannot be created or destroyed, only converted from one form to another. Total energy is conserved."},
    {"question": "In the equation ΔU = Q - W, what does W represent?", "options": ["Internal energy", "Work done BY the system", "Heat added", "Temperature change"], "correct": 1, "explanation": "W represents work done BY the system on its surroundings. When a gas expands, it does work on the environment."}
  ]
}'::jsonb, 'Chapter 2: Laws of Thermodynamics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-second-law', 'Second Law: Entropy',
'# Disorder Always Increases

## The Second Law of Thermodynamics
Entropy of an isolated system always increases:
- S_final ≥ S_initial
- Processes have preferred direction
- Time has an "arrow"

## What is Entropy (S)?
Measure of disorder or randomness:
- More arrangements = higher entropy
- Gases > Liquids > Solids
- Hot objects > Cold objects
- S = k_B × ln(Ω)

Boltzmann: Entropy measures number of microstates

## Heat Engines and Efficiency
No heat engine can be 100% efficient:
- Some heat must be wasted
- Maximum efficiency: Carnot efficiency
- η_max = 1 - T_cold/T_hot

## Real-World Implications

### Perpetual Motion Impossible
- No machine can run forever without energy input
- Violates First or Second Law

### Heat Always Flows Hot to Cold
- Never reverse spontaneously
- Requires work to reverse (refrigerator)
- Natural direction increases total entropy

### Death of the Universe
- Maximum entropy = heat death
- No energy gradients
- No work can be extracted
- Far in the future

## Applications
- Power plants (limited efficiency)
- Refrigerators (require work)
- Heat pumps (require work)
- Understanding why things break down',
31, 20,
'{
  "questions": [
    {"question": "Why can''t heat engines be 100% efficient?", "options": ["Friction losses", "Second Law: some heat must be rejected to cold reservoir", "Imperfect materials", "Energy is lost"], "correct": 1, "explanation": "The Second Law requires some heat to be rejected to a cold reservoir. No process can convert heat entirely to work with 100% efficiency."},
    {"question": "What does entropy measure?", "options": ["Energy", "Temperature", "Disorder/randomness", "Pressure"], "correct": 2, "explanation": "Entropy measures the disorder or randomness of a system. More possible arrangements of particles means higher entropy."}
  ]
}'::jsonb, 'Chapter 2: Laws of Thermodynamics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-engines', 'Heat Engines and Efficiency',
'# Converting Heat to Work

## What is a Heat Engine?
Device that converts thermal energy to mechanical work:
- Takes in heat from hot source
- Converts some to work
- Rejects waste heat to cold sink
- Operates in cycles

## Carnot Cycle (Ideal Engine)
Most efficient possible heat engine:
1. Isothermal expansion (hot)
2. Adiabatic expansion
3. Isothermal compression (cold)
4. Adiabatic compression

Efficiency = 1 - T_cold/T_hot

## Real Heat Engines
Less efficient than Carnot:
- Internal combustion (25-35%)
- Steam turbines (30-45%)
- Diesel engines (35-45%)
- Gas turbines (30-40%)

## Improving Efficiency
- Increase temperature difference
- Reduce friction
- Optimize compression ratio
- Recover waste heat

## Applications

### Automobiles
- Gasoline engine: ~25% efficient
- 75% wasted as heat
- Electric motors: 85-95% efficient

### Power Plants
- Coal: ~33% efficient
- Natural gas: ~40-50% efficient
- Combined cycle: ~60% efficient

### Refrigerators
Heat engines running backwards:
- Uses work to move heat from cold to hot
- Coefficient of performance > 1
- Moves heat against natural direction',
32, 20,
'{
  "questions": [
    {"question": "What is the theoretical maximum efficiency of a heat engine?", "options": ["100%", "Depends on fuel", "1 - T_cold/T_hot (Carnot efficiency)", "Always 50%"], "correct": 2, "explanation": "The Carnot efficiency (1 - T_cold/T_hot) is the maximum theoretical efficiency, where temperatures are in Kelvin."},
    {"question": "Why are electric motors more efficient than gasoline engines?", "options": ["They use more energy", "No heat loss, direct electrical to mechanical conversion", "They have more fuel", "Magic"], "correct": 1, "explanation": "Electric motors directly convert electrical energy to mechanical motion without heat loss, achieving 85-95% efficiency compared to 25% for gasoline engines."}
  ]
}'::jsonb, 'Chapter 3: Heat Engines'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

-- Adding more Thermodynamics lessons (continuing to reach 20 total)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-entropy', 'Entropy and Disorder',
'# The Arrow of Time

## Microstates and Macrostates
Entropy = number of possible arrangements:
- Ordered state: Few arrangements
- Disordered state: Many arrangements
- Systems naturally evolve toward disorder

## Why Disorder Increases
Simply probability:
- More ways to be disordered than ordered
- Random changes lead to disorder
- Example: Shuffled cards rarely order themselves

## Everyday Examples
- Egg breaks → Never unbreaks spontaneously
- Perfume spreads → Never re-concentrates
- Ice melts → Water doesn''t spontaneously refreeze
- Room gets messy → Never cleans itself

## Statistical Nature
Entropy is statistical:
- Individual particles can organize
- Overall system trends toward disorder
- Local decreases possible (life!)
- Must increase entropy elsewhere

## Life and Order
Living things create order:
- Reduce local entropy
- Increase total entropy (heat, waste)
- Powered by Sun (entropy source)
- Universe''s entropy still increases

## Applications
- Information theory
- Data compression
- Time''s direction
- Why we remember past, not future',
40, 25,
'{
  "questions": [
    {"question": "Why do things tend to become disordered over time?", "options": ["Bad luck", "There are more ways to be disordered than ordered, so random changes lead to disorder", "Physics is broken", "Only applies to some things"], "correct": 1, "explanation": "There are many more possible disordered arrangements than ordered ones, so random changes naturally lead to disorder. This is statistical."},
    {"question": "How can living things create order if entropy always increases?", "options": ["Living things violate thermodynamics", "They reduce local entropy while increasing total entropy", "Photosynthesis reverses entropy", "Life is supernatural"], "correct": 1, "explanation": "Living things reduce local entropy by increasing total entropy elsewhere (through heat, waste, energy consumption). The second law is not violated."}
  ]
}'::jsonb, 'Chapter 4: Advanced Topics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

-- ============================================
-- QUANTUM MECHANICS - Add 19 more lessons
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-intro-full', 'What is Quantum Mechanics?',
'# The Physics of the Very Small

## What Makes Quantum Different?

### Scale
Quantum mechanics applies at atomic scales:
- Atoms and subatomic particles
- Typically < 100 nanometers
- Quantum effects dominate

### Key Differences from Classical
- **Probabilistic**: Can''t predict exact position/momentum
- **Quantized**: Energy comes in discrete packets
- **Wave-Particle Duality**: Matter is both
- **Uncertainty**: Some things fundamentally unknowable

## Historical Development
- **1900**: Planck''s quantum hypothesis (blackbody radiation)
- **1905**: Einstein''s photoelectric effect
- **1913**: Bohr''s atomic model
- **1920s**: Schrödinger equation, Heisenberg uncertainty
- **1930s**: Quantum mechanics formalized

## Why Quantum Matters
Explains:
- Atomic structure
- Chemical bonding
- Semiconductors (computers!)
- Lasers
- Nuclear energy
- MRI machines
- Electron microscopy

## Quantum in Technology
- Transistors (all electronics)
- Lasers (CD, DVD, fiber optics)
- LEDs (energy-efficient lighting)
- Solar cells
- MRI scans
- Atomic clocks (GPS)',
20, 15,
'{
  "questions": [
    {"question": "What makes quantum mechanics different from classical physics?", "options": ["Quantum applies to large objects", "Energy is continuous in quantum", "Everything is probabilistic and quantized at small scales", "Quantum is simpler"], "correct": 2, "explanation": "In quantum mechanics, energy comes in discrete packets (quantized) and properties are probabilistic rather than deterministic at atomic scales."},
    {"question": "What modern technology relies on quantum mechanics?", "options": ["Only nuclear power plants", "Almost all electronics (computers, phones, lasers)", "Just scientific research", "Nothing uses quantum mechanics"], "correct": 1, "explanation": "Transistors, lasers, LEDs, solar cells, and countless other technologies rely entirely on quantum mechanical principles."}
  ]
}'::jsonb, 'Chapter 1: Introduction to Quantum'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-wave-particle', 'Wave-Particle Duality',
'# The Double Nature of Matter

## Light as Wave
Classical evidence:
- Interference patterns
- Diffraction
- Reflection, refraction
- Colors from prisms

## Light as Particle
- Photoelectric effect (Einstein 1905)
- Light delivers energy in packets (photons)
- Each photon has energy E = hf
- Explains why UV ejects electrons but visible light doesn''t

## Matter as Wave
- de Broglie (1924): λ = h/p
- All matter has wave properties
- Wavelength inversely related to momentum
- Massive objects: tiny wavelength (not noticeable)
- Electrons: measurable wavelength

## Electron Diffraction
Double-slit experiment with electrons:
- Electrons create interference pattern
- Individual electrons build up pattern
- Each electron goes through BOTH slits
- Collapses to point when detected

## What Does It Mean?
- Everything has both wave and particle properties
- Which you see depends on how you measure
- Not "either/or" but "both/and"
- Complementarity: Both are needed for full picture

## Applications
- Electron microscopes
- X-ray crystallography
- Neutron diffraction
- Quantum computing basics',
21, 15,
'{
  "questions": [
    {"question": "What did the photoelectric effect demonstrate?", "options": ["Light is only a wave", "Light delivers energy in discrete packets (photons)", "Light is only a particle", "Electrons are waves"], "correct": 1, "explanation": "The photoelectric effect showed that light delivers energy in discrete packets called photons, supporting the particle nature of light."},
    {"question": "What is de Broglie wavelength?", "options": ["Wavelength of light", "Wavelength associated with any particle: λ = h/p", "Length of a guitar string", "Speed of light divided by frequency"], "correct": 1, "explanation": "de Broglie proposed that all matter has wave-like properties, with wavelength λ = h/p where h is Planck''s constant and p is momentum."}
  ]
}'::jsonb, 'Chapter 1: Introduction to Quantum'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-uncertainty', 'The Uncertainty Principle',
'# Fundamental Limits of Knowledge

## Heisenberg Uncertainty Principle
Some pairs of properties cannot both be known precisely:
Δx × Δp ≥ ℏ/2

- Δx: Uncertainty in position
- Δp: Uncertainty in momentum
- ℏ: Reduced Planck constant

## What It Means
NOT about measurement limitations:
- Fundamental property of nature
- Particles don''t have definite position AND momentum
- More precisely you know one, less precisely you know the other
- Not a technical limitation

## Everyday Analogy
Photographing a baseball:
- Fast shutter: Position clear, motion (momentum) unclear
- Slow shutter: Motion clear, position blurry
- Trade-off between sharpness and motion capture

## Quantum Implications
- Electrons in atoms: "clouds" not orbits
- Zero-point energy: Particles always have some motion
- Virtual particles: Can briefly "borrow" energy (ΔE × Δt ≥ ℏ/2)
- Tunneling: Can pass through barriers

## Applications
- Electron microscopes (limited resolution)
- Flash memory (tunneling)
- Quantum computing (qubits)
- Nuclear fusion (tunneling through Coulomb barrier)',
22, 15,
'{
  "questions": [
    {"question": "What does the uncertainty principle state?", "options": ["Measurement errors are unavoidable", "Position and momentum cannot both be known precisely", "Particles move randomly", "Electrons are clouds"], "correct": 1, "explanation": "The uncertainty principle states that there is a fundamental limit to how precisely we can know both position and momentum simultaneously. It''s not about measurement errors but a fundamental property of nature."},
    {"question": "Why don''t we notice quantum uncertainty in everyday life?", "options": ["Uncertainty principle is wrong", "ℏ is so small for massive objects that uncertainty is negligible", "Everyday objects don''t have momentum", "Classical physics prevents it"], "correct": 1, "explanation": "Planck''s constant (ℏ) is so small that for everyday massive objects, the uncertainty is immeasurably tiny. Quantum effects become significant only at atomic scales."}
  ]
}'::jsonb, 'Chapter 2: Quantum Fundamentals'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-schrodinger', 'The Schrödinger Equation',
'# The Master Equation of Quantum Mechanics

## The Wave Function (Ψ)
Contains all information about a quantum system:
- Ψ²(x) = probability of finding particle at x
- Complex-valued function
- Evolves according to Schrödinger equation
- |Ψ|² is always real and positive

## Time-Dependent Schrödinger Equation
iℏ ∂Ψ/∂t = ĤΨ

Describes how quantum states evolve over time:
- i: Imaginary unit
- ℏ: Reduced Planck constant
- Ĥ: Hamiltonian (energy operator)
- Ψ: Wave function

## Stationary States
Time-independent solutions:
- Energy is well-defined
- Probability distributions don''t change
- Electron orbitals in atoms
- Ψ(x,t) = ψ(x)e^(-iEt/ℏ)

## Solving the Equation
1. Set up potential energy function V(x)
2. Write Schrödinger equation for that V
3. Find allowed energy levels (eigenvalues)
4. Find corresponding wave functions (eigenfunctions)

## Famous Solutions
- Particle in a box: Quantized energy levels
- Harmonic oscillator: Equally spaced levels
- Hydrogen atom: Complex orbital structure

## Applications
- Atomic structure
- Molecular orbitals
- Quantum dots
- Energy bands in solids',
23, 20,
'{
  "questions": [
    {"question": "What does the wave function Ψ represent?", "options": ["A physical wave like water waves", "Probability amplitude: |Ψ|² gives probability of finding particle", "A trajectory", "The particle itself"], "correct": 1, "explanation": "The wave function Ψ is a probability amplitude. The square of its magnitude |Ψ|² gives the probability density of finding the particle at a particular location."},
    {"question": "What are stationary states in quantum mechanics?", "options": ["States that don''t move", "States with well-defined energy where probability distributions don''t change", "States at absolute zero", "Impossible states"], "correct": 1, "explanation": "Stationary states are solutions with definite energy where the probability distribution doesn''t change over time, even though the wave function has a time-dependent phase factor."}
  ]
}'::jsonb, 'Chapter 2: Quantum Fundamentals'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-superposition', 'Quantum Superposition',
'# Being in Multiple States at Once

## What is Superposition?
A quantum system exists in multiple states simultaneously:
- Only when measured does it "choose" one state
- Measurement collapses the superposition
- Between measurements: superposition evolves

## Schrödinger''s Cat (Famous Thought Experiment)
Cat in box with:
- Random quantum event (50% chance of poison release)
- Before observation: Cat is both alive AND dead
- After observation: Cat is either alive or dead
- Demonstrates absurdity of quantum at macroscopic scales

## Real-World Superposition
- Electron spin: Up AND down until measured
- Photon polarization: Horizontal AND vertical
- Atomic orbitals: Electron cloud = superposition of positions
- Qubits: Can be |0⟩ AND |1⟩ simultaneously

## Quantum Computing
Uses superposition for parallel processing:
- Qubit can be 0 and 1 simultaneously
- n qubits = 2ⁿ states at once
- Quantum algorithms: Solve certain problems faster
- Shor''s algorithm: Factor large numbers
- Grover''s algorithm: Search unsorted databases

## Collapse of the Wave Function
Measurement problem:
- Why does measurement cause collapse?
- What counts as measurement?
- Many interpretations (Copenhagen, Many-Worlds, etc.)
- Still debated today!

## Applications
- Quantum computing
- Quantum cryptography
- Nuclear magnetic resonance (NMR)
- Atomic clocks',
24, 20,
'{
  "questions": [
    {"question": "What is quantum superposition?", "options": ["Particles moving faster than light", "A quantum system existing in multiple states simultaneously until measured", "Particles splitting in two", "Wave functions overlapping"], "correct": 1, "explanation": "Quantum superposition means a quantum system can exist in multiple states at the same time. Only when measured does it \"collapse\" to one definite state."},
    {"question": "How does superposition enable quantum computing?", "options": ["Quantum computers are faster electronics", "Qubits can be 0 and 1 simultaneously, allowing parallel computation on 2ⁿ states", "Quantum computers use parallel processors", "Superposition makes qubits smaller"], "correct": 1, "explanation": "Superposition allows n qubits to represent 2ⁿ states simultaneously, enabling quantum computers to process many possibilities in parallel for certain types of problems."}
  ]
}'::jsonb, 'Chapter 3: Quantum Phenomena'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-entanglement', 'Quantum Entanglement',
'# "Spooky Action at a Distance"

## What is Entanglement?
Two or more particles connected in mysterious ways:
- Measuring one instantly affects the other
- Connection exists regardless of distance
- "Spooky action at a distance" - Einstein
- Violates classical intuitions

## EPR Paradox (1935)
Einstein-Podolsky-Rosen paper argued:
- QM must be incomplete (hidden variables)
- "Spooky action" impossible
- Bell''s Theorem (1964) proved QM is correct!

## Bell''s Theorem
Experimental test of local realism:
- Local hidden variable theories predict certain limits
- Quantum mechanics violates those limits
- Experiments confirm quantum predictions
- Nature is inherently non-local!

## Applications

### Quantum Teleportation
- Transfer quantum states between locations
- Requires entanglement + classical communication
- Demonstrated over kilometers
- Basis for quantum internet

### Quantum Cryptography
- Detect eavesdropping (breaks entanglement)
- Unbreakable encryption
- Commercial systems available
- Bank transfers, secure communications

### Quantum Computing
- Entangled qubits for processing
- Error correction protocols
- Quantum networks

## Faster Than Light?
No: Entanglement doesn''t transmit information:
- Can''t use for communication
- Still need classical channel
- No violation of relativity',
25, 20,
'{
  "questions": [
    {"question": "What is quantum entanglement?", "options": ["Two particles connected across any distance", "Measuring one instantly affects the other", "Einstein called it \"spooky action at a distance\"", "All of the above"], "correct": 3, "explanation": "Quantum entanglement is a phenomenon where two or more particles become connected such that measuring one instantly affects the other, regardless of distance. Einstein called it \"spooky action at a distance\"."},
    {"question": "Does entanglement allow faster-than-light communication?", "options": ["Yes, instant communication", "No, classical channel still needed for information transfer", "Sometimes, depends on distance", "Entanglement is just theoretical"], "correct": 1, "explanation": "No, entanglement cannot be used for faster-than-light communication. While the correlation is instant, usable information still requires a classical communication channel, which is limited by light speed."}
  ]
}'::jsonb, 'Chapter 3: Quantum Phenomena'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

-- More Thermodynamics lessons
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-phase-changes', 'Phase Changes and Latent Heat',
'# Matter Changes State

## What are Phase Changes?
Transitions between solid, liquid, gas:
- Melting: Solid → Liquid
- Freezing: Liquid → Solid
- Vaporization: Liquid → Gas
- Condensation: Gas → Liquid
- Sublimation: Solid → Gas
- Deposition: Gas → Solid

## Latent Heat
Energy absorbed/released during phase change:
- Temperature stays constant during phase change
- Energy breaks/form bonds, not increase motion
- Q = m × L (L = latent heat)

### Latent Heat of Fusion
Solid ↔ Liquid:
- Water: 334 J/g (melting/freezing)
- Energy needed to break solid structure

### Latent Heat of Vaporization
Liquid ↔ Gas:
- Water: 2260 J/g (vaporizing/condensing)
- Much higher than fusion (more bonds to break)

## Heating Curve
Plot temperature vs. heat added:
1. Solid warms (specific heat)
2. Melts (latent heat, T constant)
3. Liquid warms (specific heat)
4. Boils (latent heat, T constant)
5. Gas warms (specific heat)

## Applications
- **Cooling by evaporation**: Sweat, refrigerators
- **Steam burns**: More dangerous than boiling water (latent heat)
- **Pressure cooking**: Higher boiling point
- **Climate**: Water vapor moderates temperature',
33, 15,
'{
  "questions": [
    {"question": "Why does temperature stay constant during melting?", "options": ["Energy is being destroyed", "Energy goes into breaking bonds, not increasing motion", "Thermometer breaks", "Latent heat is zero"], "correct": 1, "explanation": "During phase change, energy is used to break or form molecular bonds rather than increase molecular motion, so temperature remains constant."},
    {"question": "Why is a steam burn worse than a burn from boiling water?", "options": ["Steam is hotter", "Steam releases latent heat when it condenses on skin", "Water burns more", "Steam has pressure"], "correct": 1, "explanation": "Steam releases the latent heat of vaporization when it condenses on your skin, delivering much more energy than boiling water at the same temperature."}
  ]
}'::jsonb, 'Chapter 1: Temperature and Heat'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-thermodynamics-processes', 'Thermodynamic Processes',
'# How Systems Change

## Types of Processes

### Isobaric (Constant Pressure)
- Pressure stays same
- Volume can change
- Heat can be added/removed
- Work = PΔV

### Isochoric (Constant Volume)
- Volume stays same
- Pressure can change
- No work done (W = 0)
- All heat changes internal energy

### Isothermal (Constant Temperature)
- Temperature stays same
- Internal energy unchanged
- Heat added = Work done

### Adiabatic (No Heat Transfer)
- Q = 0 (no heat exchange)
- Temperature can change
- Work done by internal energy

## Ideal Gas Law
PV = nRT
- P: Pressure
- V: Volume
- n: Moles of gas
- R: Gas constant
- T: Temperature

## Work in Gas Processes
W = ∫ P dV
- Expansion: W > 0 (gas does work)
- Compression: W < 0 (work done on gas)

## Applications
- **Engines**: Adiabatic compression, isobaric expansion
- **Refrigerators**: Adiabatic expansion cools gas
- **Atmospheric processes**: Air rises, expands, cools
- **Breathing**: Diaphragm changes lung volume',
34, 20,
'{
  "questions": [
    {"question": "In which process is no work done?", "options": ["Isobaric", "Isochoric (constant volume)", "Isothermal", "Adiabatic"], "correct": 1, "explanation": "In an isochoric process, volume is constant (ΔV = 0), so work W = PΔV = 0. All heat added changes internal energy."},
    {"question": "What happens during adiabatic compression?", "options": ["Temperature stays constant", "Heat is added", "Temperature increases (work becomes internal energy)", "Pressure stays constant"], "correct": 2, "explanation": "During adiabatic compression, no heat is exchanged (Q = 0), so work done on the gas increases its internal energy and temperature."}
  ]
}'::jsonb, 'Chapter 2: Laws of Thermodynamics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-third-law', 'Third Law: Absolute Zero',
'# The Limit of Cold

## Third Law of Thermodynamics
As temperature approaches absolute zero:
- Entropy approaches constant minimum
- Perfect crystal: S → 0 as T → 0K
- Cannot reach absolute zero in finite steps

## Absolute Zero
-273.15°C = 0 Kelvin = -459.67°F
- Lowest possible temperature
- All molecular motion stops (theoretically)
- Cannot be reached, only approached

## Why Can''t We Reach Absolute Zero?
- Cooling requires heat transfer to colder reservoir
- At absolute zero, no colder reservoir exists
- Infinite steps required
- Uncertainty principle: Some motion always exists

## Approach to Absolute Zero
Methods to get very close:
- Laser cooling: Microkelvins achieved
- Magnetic cooling: Nanokelvins
- Dilution refrigeration: Millikelvins
- Bose-Einstein condensates created

## Applications
- **Superconductivity**: Zero resistance at very low T
- **Superfluidity**: Liquid helium flows without friction
- **Quantum computing**: Qubits operate at mK temperatures
- **Precision measurements**: Atomic clocks need cold atoms

## Implications
- Perfect order = zero entropy (theoretical)
- Heat death of universe: Maximum entropy
- Shows asymmetry: Can reach hot, not absolute zero',
35, 20,
'{
  "questions": [
    {"question": "Why can''t absolute zero be reached?", "options": ["Equipment isn''t good enough", "Would require infinite steps (no colder reservoir exists)", "It doesn''t exist", "Scientists haven''t tried hard enough"], "correct": 1, "explanation": "Absolute zero cannot be reached because it would require an infinite number of cooling steps. You need a colder reservoir to transfer heat to, but at absolute zero no colder reservoir exists."},
    {"question": "What happens to entropy as temperature approaches absolute zero?", "options": ["It increases", "It approaches a minimum constant value", "It stays the same", "It becomes infinite"], "correct": 1, "explanation": "The Third Law states that entropy approaches a minimum constant value as temperature approaches absolute zero. For a perfect crystal, this minimum is zero."}
  ]
}'::jsonb, 'Chapter 2: Laws of Thermodynamics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-free-energy', 'Free Energy and Spontaneity',
'# Why Things Happen Naturally

## Gibbs Free Energy (G)
Predicts if process occurs spontaneously:
G = H - TS
- G: Gibbs free energy
- H: Enthalpy (total heat content)
- T: Temperature (Kelvin)
- S: Entropy

## Spontaneity Conditions
- ΔG < 0: Spontaneous (happens naturally)
- ΔG > 0: Non-spontaneous (requires energy input)
- ΔG = 0: Equilibrium (no net change)

## Enthalpy vs. Entropy
Four combinations:
1. Exothermic (-ΔH) + Increasing entropy (+ΔS): Always spontaneous
2. Endothermic (+ΔH) + Decreasing entropy (-ΔS): Never spontaneous
3. Exothermic (-ΔH) + Decreasing entropy (-ΔS): Spontaneous at low T
4. Endothermic (+ΔH) + Increasing entropy (+ΔS): Spontaneous at high T

## Temperature Dependence
ΔG = ΔH - TΔS
At different temperatures:
- Low T: Enthalpy dominates (exothermic favored)
- High T: Entropy dominates (disorder favored)

## Applications

### Chemical Reactions
- Combustion: Spontaneous (exothermic, gas increases)
- Ice melting: Spontaneous above 0°C (entropy increase > endothermic cost)
- Photosynthesis: Non-spontaneous (requires energy input)

### Phase Changes
- Ice → Water: Spontaneous above 0°C
- Water → Steam: Spontaneous above 100°C
- Entropy increase drives these

### Biological Systems
- ATP hydrolysis: Spontaneous (powers life)
- Protein folding: Spontaneous (entropy-driven)
- Metabolism: Coupled spontaneous and non-spontaneous reactions',
36, 20,
'{
  "questions": [
    {"question": "What does a negative ΔG indicate?", "options": ["Reaction is impossible", "Reaction is spontaneous", "Reaction is at equilibrium", "Reaction requires energy"], "correct": 1, "explanation": "Negative ΔG means the process is spontaneous and will occur naturally without continuous energy input."},
    {"question": "Why does ice spontaneously melt above 0°C?", "options": ["It absorbs enough heat", "Entropy increase outweighs endothermic cost at high T", "Pressure forces it", "Enthalpy decreases"], "correct": 1, "explanation": "Above 0°C, the entropy increase from melting (solid to liquid) outweighs the enthalpy cost (absorbing heat), making ΔG negative and melting spontaneous."}
  ]
}'::jsonb, 'Chapter 4: Advanced Topics'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'thermo-refrigeration', 'Refrigeration and Heat Pumps',
'# Moving Heat Against Nature

## Refrigerators
Move heat from cold to hot (requires work):
Q_cold + W = Q_hot
- Q_cold: Heat removed from cold space
- W: Work input (compressor)
- Q_hot: Heat rejected to warm space

## How Refrigerators Work
1. **Compression**: Work done, gas heats up
2. **Condensation**: Heat released to room
3. **Expansion**: Gas cools (adiabatic expansion)
4. **Evaporation**: Absorbs heat from inside

## Coefficient of Performance (COP)
Efficiency measure:
COP = Q_cold / W
- Can be > 1 (unlike efficiency)
- Typical: 2-6 (moves 2-6× work as heat)
- Higher is better

## Heat Pumps
Refrigerator running in reverse:
- Heats homes in winter
- Cools homes in summer (reverse valve)
- Very efficient: COP 3-4
- Moves heat rather than creating it

## Applications
- **Home refrigerators**: Keep food cold
- **Air conditioning**: Cool buildings
- **Heat pumps**: Efficient heating/cooling
- **Cryogenics**: Liquefy gases
- **Science cooling**: Superconducting magnets

## Efficiency Limits
Maximum COP (Carnot refrigerator):
COP_max = T_cold / (T_hot - T_cold)
- Shows temperature difference matters
- Small ΔT = high COP
- Large ΔT = low COP',
41, 25,
'{
  "questions": [
    {"question": "What is the coefficient of performance (COP) for a refrigerator?", "options": ["Work done divided by heat moved", "Heat removed from cold divided by work input", "Always equal to 1", "Cannot exceed 1"], "correct": 1, "explanation": "COP = Q_cold / W, the heat removed from the cold space divided by work input. Unlike efficiency, COP can be greater than 1."},
    {"question": "Why can heat pumps be more efficient than electric heaters?", "options": ["Heat pumps create heat", "Heat pumps move heat rather than create it, so COP > 1", "Electric heaters are inefficient", "Heat pumps use less electricity"], "correct": 1, "explanation": "Heat pumps move heat from outside to inside rather than creating it, so they can move 3-4 units of heat for every 1 unit of electricity (COP 3-4). Electric heaters can only convert 1 unit of electricity to 1 unit of heat."}
  ]
}'::jsonb, 'Chapter 3: Heat Engines'
FROM courses c WHERE c.slug = 'thermodynamics'
ON CONFLICT DO NOTHING;

-- More Quantum Mechanics lessons
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-tunneling', 'Quantum Tunneling',
'# Passing Through Barriers

## What is Tunneling?
Particles can pass through energy barriers:
- Classically impossible
- Quantum mechanically possible
- Probability depends on barrier properties
- More likely for thin, low barriers

## How Tunneling Works
Wave function doesn''t go to zero in barrier:
- Decays exponentially inside barrier
- Non-zero amplitude on other side
- If barrier is thin enough: significant probability
- Particle "tunnels" through

## Tunneling Probability
Depends on:
- Particle mass (lighter = higher probability)
- Barrier width (thinner = higher probability)
- Barrier height (lower = higher probability)
- Particle energy (higher = higher probability)

## Applications

### Nuclear Fusion
- Sun shines because of tunneling
- Protons tunnel through Coulomb barrier
- Otherwise, fusion would be impossible at solar temperatures

### Flash Memory
- Electrons tunnel through insulator
- Store charge = bit (0 or 1)
- USB drives, SSDs use this

### Scanning Tunneling Microscope (STM)
- Tunneling current measures surface
- Atomic resolution
- Can move individual atoms

### Quantum Computing
- Qubits can tunnel between states
- Enables quantum algorithms
- Quantum annealing

### Alpha Decay
- Alpha particles tunnel out of nucleus
- Explains radioactive decay rates
- Half-life comes from tunneling probability',
26, 20,
'{
  "questions": [
    {"question": "What is quantum tunneling?", "options": ["Particles breaking through barriers with force", "Particles passing through energy barriers that would be impossible in classical physics", "Particles going around barriers", "Particles destroying barriers"], "correct": 1, "explanation": "Quantum tunneling is the phenomenon where particles can pass through energy barriers that would be impossible to cross according to classical physics. This happens because the wave function doesn''t go to zero inside the barrier."},
    {"question": "Why is nuclear fusion possible in the Sun?", "options": ["Temperature is high enough to overcome repulsion", "Protons tunnel through the Coulomb barrier", "Gravity forces protons together", "Fusion doesn''t require overcoming repulsion"], "correct": 1, "explanation": "The temperature in the Sun isn''t high enough for protons to classically overcome their electrical repulsion. Instead, quantum tunneling allows protons to tunnel through the Coulomb barrier and fuse."}
  ]
}'::jsonb, 'Chapter 3: Quantum Phenomena'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-atomic-structure', 'Quantum Atomic Structure',
'# Electron Orbitals and Shells

## Bohr Model (1913)
Electrons in discrete orbits:
- Fixed energy levels
- n = 1, 2, 3, ... (principal quantum number)
- Electrons don''t radiate in orbits
- Explains hydrogen spectrum

## Quantum Mechanical Model
Electron clouds, not orbits:
- Orbitals: Probability distributions
- s, p, d, f orbitals (different shapes)
- Pauli exclusion: Max 2 electrons per orbital
- Hund''s rule: Electrons fill singly first

## Quantum Numbers
Describe electron state:
- **n**: Principal (shell, energy)
- **l**: Azimuthal (subshell, shape: s=0, p=1, d=2, f=3)
- **m**: Magnetic (orientation)
- **s**: Spin (+½ or -½)

## Electron Configuration
How electrons fill orbitals:
1s² 2s² 2p⁶ 3s² 3p⁶ 4s² 3d¹⁰ ...
- Fill lowest energy first
- Each orbital holds max 2 electrons
- Orbitals in subshell fill singly first

## Periodic Table Structure
- Rows: Principal quantum number (n)
- Columns: Valence electron configuration
- Groups: Similar chemical properties
- Blocks: s, p, d, f orbitals filling

## Applications
- **Chemistry**: All chemical behavior
- **Spectroscopy**: Atomic emission/absorption
- **Lasers**: Electron transitions produce light
- **Materials**: Conductors vs. insulators',
27, 20,
'{
  "questions": [
    {"question": "What determines an element''s position in the periodic table?", "options": ["Atomic mass only", "Number of neutrons", "Electron configuration and valence electrons", "Temperature"], "correct": 2, "explanation": "An element''s position is determined by its electron configuration, particularly the valence electrons. This explains why elements in the same column have similar chemical properties."},
    {"question": "What is the maximum number of electrons in a single orbital?", "options": ["1", "2", "4", "8"], "correct": 1, "explanation": "According to the Pauli exclusion principle, each orbital can hold a maximum of 2 electrons, and they must have opposite spins (+½ and -½)."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-spin', 'Quantum Spin',
'# Intrinsic Angular Momentum

## What is Spin?
Intrinsic angular momentum of particles:
- Not actual spinning (despite name)
- Fundamental property like mass, charge
- Can be integer (0, 1, 2...) or half-integer (½, 3/2...)
- Always same magnitude for given particle type

## Fermions vs. Bosons
**Fermions** (half-integer spin):
- Electrons, protons, neutrons
- Pauli exclusion applies
- Make up matter

**Bosons** (integer spin):
- Photons, mesons
- Can occupy same state
- Mediate forces

## Pauli Exclusion Principle
No two fermions can occupy same quantum state:
- Explains electron shell structure
- Matter is stable (doesn''t collapse)
- White dwarf stars supported by exclusion
- Chemistry exists!

## Spin and Magnetic Moments
Spin creates magnetic field:
- Electron spin magnetic moment
- MRI uses nuclear spin (protons)
- Spin alignment in magnetic fields
- Up vs. down (parallel vs. antiparallel)

## Stern-Gerlach Experiment
- Silver atoms split in magnetic field
- Demonstrated spin quantization
- Only two discrete paths
- Proved spin is real

## Applications
- **MRI**: Nuclear spin imaging
- **Spintronics**: Electron spin electronics
- **Quantum computing**: Spin qubits
- **Magnetic materials**: Ferromagnetism from aligned spins',
28, 20,
'{
  "questions": [
    {"question": "What is the difference between fermions and bosons?", "options": ["Fermions have mass, bosons don''t", "Fermions have half-integer spin and obey exclusion principle, bosons have integer spin", "Bosons make up matter, fermions mediate forces", "No difference"], "correct": 1, "explanation": "Fermions have half-integer spin (½, 3/2, etc.) and obey the Pauli exclusion principle. Bosons have integer spin (0, 1, 2, etc.) and can occupy the same quantum state."},
    {"question": "What does the Pauli exclusion principle explain?", "options": ["Why particles have spin", "Why matter is stable and electrons form shells", "Why photons can overlap", "Why atoms have nuclei"], "correct": 1, "explanation": "The Pauli exclusion principle explains why electrons occupy different quantum states, forming shells around atoms. This prevents matter from collapsing and explains the structure of the periodic table."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-pauli-exclusion', 'Pauli Exclusion Principle',
'# Why Matter Doesn''t Collapse

## The Principle
No two identical fermions can occupy the same quantum state:
- Wolfgang Pauli (1925)
- Applies to particles with half-integer spin
- Most important for electrons

## Why It Matters

### Atomic Structure
- Electrons fill shells, not all in lowest orbital
- 1s² 2s² 2p⁶ 3s² ...
- Explains periodic table
- Chemistry emerges from this!

### Matter Stability
- Atoms don''t collapse into nucleus
- Electrons can''t all fall to lowest energy
- Matter has volume, doesn''t shrink to point

### White Dwarf Stars
- Gravity wants to collapse star
- Electron degeneracy pressure resists
- Pauli exclusion creates this pressure
- Stars supported by quantum mechanics

### Neutron Stars
- Even denser than white dwarfs
- Neutrons (also fermions) resist further collapse
- Maximum mass set by exclusion + GR

## Degeneracy Pressure
Not thermal pressure:
- Comes from exclusion principle
- Exists even at absolute zero
- Doesn''t depend on temperature
- Fermions can''t occupy same states

## Applications
- **Semiconductors**: Electron band structure
- **Metals**: Free electron gas
- **Chemistry**: Bonding rules
- **Astrophysics**: Stellar remnants',
29, 20,
'{
  "questions": [
    {"question": "What does the Pauli exclusion principle state?", "options": ["Particles can''t spin", "No two identical fermions can occupy the same quantum state", "Electrons repel each other", "Atoms can''t be created"], "correct": 1, "explanation": "The Pauli exclusion principle states that no two identical fermions (particles with half-integer spin) can occupy the same quantum state simultaneously."},
    {"question": "What prevents a white dwarf star from collapsing under gravity?", "options": ["Thermal pressure from heat", "Nuclear reactions", "Electron degeneracy pressure from Pauli exclusion", "Magnetic fields"], "correct": 2, "explanation": "Electron degeneracy pressure, arising from the Pauli exclusion principle, prevents white dwarf stars from collapsing. This pressure exists even at absolute zero and doesn''t depend on temperature."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-observables', 'Quantum Observables and Measurement',
'# What Happens When We Measure?

## Observables in Quantum Mechanics
Physical quantities we can measure:
- Position
- Momentum
- Energy
- Angular momentum
- Spin

Each corresponds to a mathematical operator

## Measurement Problem
Measurement changes the system:
- Wave function collapses
- Superposition becomes definite state
- Probability distribution → single outcome
- Irreversible process

## Copenhagen Interpretation
Standard view (Bohr, Heisenberg):
- Wave function is complete description
- Collapse is fundamental, unexplained
- Don''t ask what happens "before" measurement
- "Shut up and calculate" approach

## Many-Worlds Interpretation
Alternative view (Everett):
- No collapse
- All outcomes happen in different branches
- Universe splits constantly
- We experience one branch

## Other Interpretations
- **Pilot Wave**: Hidden variables (de Broglie-Bohm)
- **Objective Collapse**: Spontaneous collapse theories
- **Quantum Bayesian**: Subjective probability
- **Consistent Histories**: Framework for probabilities

## Does It Matter?
Practically: No (all predict same results)
Philosophically: Yes (nature of reality)

## Applications
- **Quantum computing**: Measurement destroys superposition
- **Cryptography**: Detection of measurement
- **Foundations**: Ongoing research',
30, 25,
'{
  "questions": [
    {"question": "What is the measurement problem in quantum mechanics?", "options": ["Measurements are inaccurate", "Measurement causes wave function collapse from superposition to definite state", "We can''t measure quantum systems", "Measurements create particles"], "correct": 1, "explanation": "The measurement problem is that measurement causes a quantum system to transition from a superposition of states to a single definite state. How and why this happens is still debated."},
    {"question": "What is the Many-Worlds interpretation of quantum mechanics?", "options": ["There are many universes with different physics", "All quantum outcomes happen in different branches of universe", "Measurements create new worlds", "Parallel universes communicate"], "correct": 1, "explanation": "The Many-Worlds interpretation suggests that all possible outcomes of quantum measurements actually occur, each in a separate, non-communicating branch of the universe. There is no collapse of the wave function."}
  ]
}'::jsonb, 'Chapter 5: Interpretations and Foundations'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-hydrogen-atom', 'The Hydrogen Atom',
'# Solved Exactly

## Schrödinger Equation for Hydrogen
One electron + one proton:
- Can solve exactly (rare!)
- Beautiful analytic solutions
- Explains hydrogen spectrum perfectly
- Basis for understanding all atoms

## Quantum Numbers for Hydrogen
Each state labeled by:
- **n**: Principal (energy level, 1, 2, 3, ...)
- **l**: Azimuthal (0 to n-1, orbital shape)
- **m**: Magnetic (-l to +l, orientation)
- **ms**: Spin (+½ or -½)

## Energy Levels
E_n = -13.6 eV / n²
- Ground state: n=1, E=-13.6 eV
- First excited: n=2, E=-3.4 eV
- Ionization: n=∞, E=0
- Explains emission/absorption spectra

## Orbitals (Wave Functions)
Shapes of electron probability:
- **s-orbitals** (l=0): Spherical
- **p-orbitals** (l=1): Dumbbell-shaped
- **d-orbitals** (l=2): Clover shapes
- **f-orbitals** (l=3): Complex shapes

## Spectral Lines
Transitions between levels:
- Lyman series: n→1 (UV)
- Balmer series: n→2 (visible)
- Paschen series: n→3 (infrared)
- ΔE = hf (photon energy)

## Why Hydrogen Is Special
- Only one electron
- Exact solutions possible
- Testing ground for QM
- Starting point for multi-electron atoms

## Applications
- **Spectroscopy**: Identifying elements
- **Lasers**: Electron transitions
- **Astrophysics**: Stellar spectra
- **Quantum chemistry**: Molecular basis',
31, 20,
'{
  "questions": [
    {"question": "What is the ground state energy of hydrogen?", "options": ["0 eV", "-13.6 eV", "13.6 eV", "-1 eV"], "correct": 1, "explanation": "The ground state energy of hydrogen is -13.6 eV. The negative sign means the electron is bound to the proton. 0 eV represents the ionization limit where electron is free."},
    {"question": "Why can we solve the hydrogen atom exactly but not other atoms?", "options": ["Hydrogen is simpler", "Hydrogen has only one electron, others have multiple electrons that interact", "Scientists are lazy", "Hydrogen follows different physics"], "correct": 1, "explanation": "Hydrogen has only one electron, so we only need to consider the electron-proton interaction. Other atoms have multiple electrons that interact with each other, making exact solutions impossible."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-identical-particles', 'Identical Particles',
'# You Can''t Tell Them Apart

## Quantum Indistinguishability
Identical particles are truly identical:
- Cannot label or track individual particles
- "This electron" vs "that electron" is meaningless
- Wave functions must be symmetric/antisymmetric
- Purely quantum effect (no classical analog)

## Bosons (Symmetric Wave Function)
Integer spin (0, 1, 2...):
- Can occupy same state
- Wave function: ψ(1,2) = +ψ(2,1)
- Examples: Photons, mesons, He-4 atoms
- Bose-Einstein condensates possible

## Fermions (Antisymmetric Wave Function)
Half-integer spin (½, 3/2...):
- Cannot occupy same state (Pauli exclusion)
- Wave function: ψ(1,2) = -ψ(2,1)
- Examples: Electrons, protons, neutrons
- Matter is made of fermions

## Statistics

### Bose-Einstein Statistics (Bosons)
- Many particles can occupy ground state
- Explains superfluidity, superconductivity
- Lasers (many photons in same state)
- BEC: All particles in one quantum state

### Fermi-Dirac Statistics (Fermions)
- One particle per quantum state
- Electrons fill shells in atoms
- White dwarf/neutron star degeneracy
- Properties of metals

## Applications
- **Superconductivity**: Electron pairs (Cooper pairs) act as bosons
- **Lasers**: Many photons in same state
- **White dwarfs**: Electron degeneracy pressure
- **Neutron stars**: Neutron degeneracy pressure',
32, 20,
'{
  "questions": [
    {"question": "What is the difference between how bosons and fermions behave?", "options": ["Bosons have mass, fermions don''t", "Bosons can occupy the same state, fermions cannot", "Fermions attract, bosons repel", "No difference"], "correct": 1, "explanation": "Bosons (integer spin) can occupy the same quantum state, allowing phenomena like lasers and Bose-Einstein condensates. Fermions (half-integer spin) cannot occupy the same state due to the antisymmetric wave function."},
    {"question": "What is a Bose-Einstein condensate?", "options": ["A chemical reaction", "A state where many bosons occupy the same quantum state", "A type of radiation", "A particle accelerator"], "correct": 1, "explanation": "A Bose-Einstein condensate is a state of matter where many bosons occupy the lowest quantum state, behaving as a single quantum entity. This occurs at very low temperatures."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-semiconductors', 'Semiconductors and Band Theory',
'# How Electronics Work

## Band Theory
Solids have energy bands:
- **Valence band**: Bound electrons
- **Conduction band**: Free electrons
- **Band gap**: Energy difference between bands

## Conductors, Insulators, Semiconductors

### Conductors (Metals)
- Valence and conduction bands overlap
- Electrons easily move
- Current flows freely

### Insulators
- Large band gap (> 5 eV)
- Electrons can''t jump to conduction band
- No current flows

### Semiconductors
- Small band gap (~1 eV)
- Some electrons can jump
- Conductivity can be controlled
- Silicon, germanium

## Doping
Adding impurities to control conductivity:
- **n-type**: Add extra electrons (phosphorus in silicon)
- **p-type**: Add electron holes (boron in silicon)
- p-n junction: Diode behavior

## p-n Junction
Boundary between n-type and p-type:
- Current flows one way only
- Basis of diodes, transistors
- Depletion region forms
- Rectifies AC to DC

## Applications

### Transistors
- Switch: On/off for digital logic
- Amplifier: Boost signals
- MOSFET: Most common type
- Billions in every computer

### Solar Cells
- Photons excite electrons across band gap
- Creates voltage, current
- Converts light to electricity
- Band gap determines efficiency

### LEDs
- Electrons fall across band gap
- Emit photons (light)
- Color depends on band gap
- Energy-efficient lighting

## Quantum Origin
- Band structure from quantum mechanics
- Pauli exclusion fills valence band
- Tunneling in tunnel diodes
- Quantum wells in modern devices',
33, 20,
'{
  "questions": [
    {"question": "What makes semiconductors useful for electronics?", "options": ["They conduct better than metals", "Their small band gap allows conductivity to be controlled via doping", "They are insulators", "They are cheap"], "correct": 1, "explanation": "Semiconductors have a small band gap (~1 eV) that allows some electrons to reach the conduction band. Their conductivity can be precisely controlled by doping, making them ideal for electronic devices."},
    {"question": "How does an LED work?", "options": ["Heats a filament", "Electrons dropping across band gap emit photons", "Chemical reaction produces light", "Filters white light"], "correct": 1, "explanation": "In an LED, electrons fall from the conduction band to the valence band, crossing the band gap. The energy difference is emitted as a photon (light), with color determined by the band gap energy."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-lasers', 'Lasers and Quantum Optics',
'# Stimulated Emission

## How Lasers Work
**L**ight **A**mplification by **S**timulated **E**mission of **R**adiation:
1. **Population inversion**: More excited than ground
2. **Stimulated emission**: Photon triggers emission
3. **Amplification**: Chain reaction of photons
4. **Coherent light**: All in phase, same direction

## Spontaneous vs. Stimulated Emission

### Spontaneous Emission
- Excited atom decays randomly
- Photon emitted in random direction
- Random phase
- Ordinary light (light bulb)

### Stimulated Emission
- Passing photon triggers emission
- New photon identical to triggering photon
- Same direction, same phase
- Laser light!

## Laser Components
- **Gain medium**: Atoms/molecules that lase
- **Energy source**: Pump (flash lamp, electric)
- **Mirrors**: Reflect light back and forth
- **Output coupler**: Partially transparent mirror

## Laser Properties
- **Monochromatic**: Single wavelength
- **Coherent**: All waves in phase
- **Collimated**: Very directional beam
- **High intensity**: Energy concentrated

## Applications
- **Communications**: Fiber optics
- **Medicine**: Surgery, eye correction
- **Industry**: Cutting, welding
- **Research**: Spectroscopy, interferometry
- **Consumer**: Barcode scanners, DVD players

## Types of Lasers
- **Gas**: HeNe, CO₂
- **Solid-state**: Ruby, Nd:YAG
- **Semiconductor**: Laser diodes
- **Liquid**: Dye lasers',
34, 20,
'{
  "questions": [
    {"question": "What is the key difference between laser light and ordinary light?", "options": ["Laser is brighter", "Laser is monochromatic, coherent, and collimated", "Laser has different colors", "Ordinary light is artificial"], "correct": 1, "explanation": "Laser light is monochromatic (single wavelength), coherent (all waves in phase), and collimated (very directional beam). Ordinary light is incoherent, multi-wavelength, and spreads in all directions."},
    {"question": "What is stimulated emission?", "options": ["Atoms get excited", "A passing photon triggers an excited atom to emit an identical photon", "Spontaneous emission", "Absorption of light"], "correct": 1, "explanation": "Stimulated emission occurs when a photon passes near an excited atom, causing it to emit a second photon with the same energy, direction, and phase as the first. This creates the coherent amplification that makes lasers work."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-mri', 'MRI and Quantum Spin',
'# Seeing Inside the Body

## What is MRI?
**M**agnetic **R**esonance **I**maging:
- Images internal body structures
- No harmful radiation
- Excellent soft tissue contrast
- Based on nuclear spin

## How MRI Works

### 1. Strong Magnetic Field
- Aligns nuclear spins (protons in water)
- Most protons align with field
- Small energy difference between alignments

### 2. Radio Frequency Pulse
- Perturbs spins away from alignment
- Photons match energy difference
- Resonant absorption

### 3. Relaxation
- Spins return to alignment
- Emit RF photons as they relax
- Signal detected by coils

### 4. Image Formation
- Spatial encoding with gradient fields
- Different tissues relax differently
- Creates contrast in image
- 3D reconstruction

## T1 and T2 Relaxation
- **T1**: Recovery of longitudinal magnetization
- **T2**: Decay of transverse magnetization
- Different tissues have different rates
- Basis of image contrast

## Applications
- **Brain imaging**: Tumors, strokes
- **Joint imaging**: Ligaments, cartilage
- **Spine imaging**: Discs, nerves
- **Cancer detection**: Staging tumors
- **Functional MRI**: Brain activity (blood flow)

## Advantages
- No ionizing radiation
- Excellent soft tissue contrast
- Can image any plane
- Safe for most patients

## Quantum Connection
- Nuclear spin (quantum property)
- Energy level splitting in magnetic field
- Resonant absorption/emission
- Pure quantum mechanics in action!',
35, 20,
'{
  "questions": [
    {"question": "What does MRI use to create images?", "options": ["X-rays", "Nuclear spin resonance of protons in water", "Sound waves", "Radioactive tracers"], "correct": 1, "explanation": "MRI uses the magnetic resonance of nuclear spins (primarily protons in water molecules) in a strong magnetic field, detected with radio frequency pulses."},
    {"question": "Why is MRI safer than X-rays?", "options": ["MRI is not actually safer", "MRI uses non-ionizing RF radiation, X-rays use ionizing radiation", "MRI uses lower power", "X-rays are fake"], "correct": 1, "explanation": "MRI uses radio frequency pulses (non-ionizing) which don''t damage DNA like X-rays (ionizing radiation). The magnetic fields are also safe at the strengths used for imaging."}
  ]
}'::jsonb, 'Chapter 4: Quantum Applications'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'quantum-philosophy', 'Quantum Philosophy and Reality',
'# What Does It All Mean?

## The Measurement Problem Revisited
What counts as "measurement"?
- Conscious observer?
- Any interaction?
- Macroscopic object?
- No consensus!

## Copenhagen Interpretation (Standard)
- Wave function is complete
- Collapse is fundamental
- Don''t ask about "reality" between measurements
- "Shut up and calculate" attitude
- Most widely taught

## Many-Worlds Interpretation
- No collapse ever occurs
- Universe splits into branches
- All outcomes happen
- Each branch experiences one outcome
- Growing in popularity

## Pilot Wave (de Broglie-Bohm)
- Particles have definite positions
- Guided by pilot wave
- Deterministic (not random)
- Non-local (instantaneous connections)
- Hidden variable theory

## Objective Collapse Theories
- Wave function spontaneously collapses
- Collapse is physical process
- GRW theory, Penrose interpretation
- Testable predictions differ from standard QM

## Quantum Bayesianism (QBism)
- Quantum states are beliefs, not reality
- Probability is subjective
- Updates beliefs based on experience
- More Bayesian than classical

## Experimental Tests
- Bell''s theorem: Excludes local hidden variables
- Delayed choice quantum eraser: Time''s role
- Quantum Zeno effect: Measurement affects evolution
- Leggett-Garg inequalities: Macrorealism tests

## Does It Matter?
Practically: Usually no
Philosophically: Everything
- Nature of reality
- Role of observer
- Determinism vs. randomness
- Free will?

## Quantum Mysticism (WARNING)
- "Quantum healing": Not real
- "Quantum consciousness": Unproven
- "Quantum manifestation": Pseudoscience
- Be skeptical of quantum claims!',
40, 25,
'{
  "questions": [
    {"question": "What is the main difference between Copenhagen and Many-Worlds interpretations?", "options": ["Many-Worlds is proven correct", "Copenhagen has collapse, Many-Worlds has branching universes without collapse", "Copenhagen involves consciousness", "No difference"], "correct": 1, "explanation": "The Copenhagen interpretation involves wave function collapse upon measurement. The Many-Worlds interpretation says collapse never happens; instead, the universe branches and all outcomes occur in different branches."},
    {"question": "What did Bell''s theorem prove?", "options": ["Quantum mechanics is wrong", "Local hidden variable theories cannot reproduce quantum predictions", "Many-Worlds is correct", "Pilot wave theory"], "correct": 1, "explanation": "Bell''s theorem showed that any local hidden variable theory would make different predictions than quantum mechanics. Experiments have confirmed quantum mechanics, ruling out local hidden variables."}
  ]
}'::jsonb, 'Chapter 5: Interpretations and Foundations'
FROM courses c WHERE c.slug = 'quantum-mechanics'
ON CONFLICT DO NOTHING;