-- Add quizzes to all lessons

-- Basic Physics: Introduction to Basic Physics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does physics primarily study?",
      "options": ["Living organisms", "Matter and its motion through space and time", "Chemical reactions", "Historical events"],
      "correct": 1,
      "explanation": "Physics is the natural science that studies matter, its motion and behavior through space and time."
    },
    {
      "question": "Which of the following is NOT a key concept in basic physics?",
      "options": ["Motion and Forces", "Energy and Work", "Photosynthesis", "Newton''s Laws"],
      "correct": 2,
      "explanation": "Photosynthesis is a biological process, not a physics concept. The key physics concepts include motion, forces, energy, and Newton''s Laws."
    }
  ]
}'::jsonb WHERE slug = 'intro';

-- Basic Physics: Basics - Units and Measurement
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is the SI unit of length?",
      "options": ["Foot", "Meter", "Mile", "Yard"],
      "correct": 1,
      "explanation": "The meter (m) is the SI (International System) unit of length."
    },
    {
      "question": "Why are standardized units important in physics?",
      "options": ["They make calculations harder", "They allow scientists worldwide to communicate measurements consistently", "They are only used in America", "They are optional"],
      "correct": 1,
      "explanation": "Standardized units ensure that scientists around the world can share and compare measurements accurately."
    }
  ]
}'::jsonb WHERE slug = 'basics-units';

-- Basic Physics: Motion - Position and Velocity
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is velocity?",
      "options": ["The total distance traveled", "Speed with direction", "The time taken to travel", "Mass times acceleration"],
      "correct": 1,
      "explanation": "Velocity is speed with a direction - it tells us both how fast something is moving and in which direction."
    },
    {
      "question": "If a car travels 100 km in 2 hours, what is its average speed?",
      "options": ["200 km/h", "50 km/h", "100 km/h", "25 km/h"],
      "correct": 1,
      "explanation": "Average speed = distance / time = 100 km / 2 hours = 50 km/h"
    }
  ]
}'::jsonb WHERE slug = 'motion-basics';

-- Basic Physics: Motion - Acceleration
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is acceleration?",
      "options": ["Constant speed", "The rate of change of velocity", "Distance traveled", "Force applied"],
      "correct": 1,
      "explanation": "Acceleration is the rate at which velocity changes over time."
    },
    {
      "question": "A car speeds up from 0 to 60 km/h in 10 seconds. What is happening?",
      "options": ["The car is decelerating", "The car has zero acceleration", "The car is accelerating", "The car is at rest"],
      "correct": 2,
      "explanation": "Since the velocity is increasing, the car is accelerating (positive acceleration)."
    }
  ]
}'::jsonb WHERE slug = 'motion-acceleration';

-- Basic Physics: Forces - Introduction to Forces
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a force?",
      "options": ["A type of energy", "A push or pull on an object", "The speed of an object", "The mass of an object"],
      "correct": 1,
      "explanation": "A force is a push or pull that can change an object''s motion, shape, or direction."
    },
    {
      "question": "Which of the following is an example of a contact force?",
      "options": ["Gravity", "Magnetism", "Friction", "Electric force at a distance"],
      "correct": 2,
      "explanation": "Friction is a contact force because it requires objects to be touching. Gravity, magnetism, and electric forces can act at a distance."
    }
  ]
}'::jsonb WHERE slug = 'forces-intro';

-- Basic Physics: Forces - Newton's Laws of Motion
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does Newton''s First Law state?",
      "options": ["F = ma", "Every action has an equal and opposite reaction", "An object at rest stays at rest unless acted upon by a force", "Energy cannot be created or destroyed"],
      "correct": 2,
      "explanation": "Newton''s First Law (Law of Inertia) states that an object at rest stays at rest, and an object in motion stays in motion, unless acted upon by an external force."
    },
    {
      "question": "According to Newton''s Second Law, if you double the force on an object, what happens to its acceleration?",
      "options": ["It stays the same", "It doubles", "It halves", "It quadruples"],
      "correct": 1,
      "explanation": "F = ma, so if mass stays constant and force doubles, acceleration must also double."
    }
  ]
}'::jsonb WHERE slug = 'forces-newtons-laws';

-- Basic Physics: Energy - Work and Power
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "In physics, when is work done on an object?",
      "options": ["When you think about moving it", "When a force moves the object in the direction of the force", "When the object is at rest", "Only when lifting objects"],
      "correct": 1,
      "explanation": "Work is done when a force causes an object to move in the direction of the force. Work = Force × Distance."
    },
    {
      "question": "What is power?",
      "options": ["The total work done", "The rate at which work is done", "Force times mass", "Energy stored in an object"],
      "correct": 1,
      "explanation": "Power is the rate at which work is done, measured in watts. Power = Work / Time."
    }
  ]
}'::jsonb WHERE slug = 'energy-work';

-- Basic Physics: Energy - Kinetic and Potential Energy
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What type of energy does a moving car have?",
      "options": ["Potential energy", "Kinetic energy", "Chemical energy", "Nuclear energy"],
      "correct": 1,
      "explanation": "Kinetic energy is the energy of motion. Any moving object has kinetic energy."
    },
    {
      "question": "A ball held at the top of a hill has what type of energy?",
      "options": ["Kinetic energy", "Gravitational potential energy", "Thermal energy", "Sound energy"],
      "correct": 1,
      "explanation": "The ball has gravitational potential energy due to its height. When released, this converts to kinetic energy."
    }
  ]
}'::jsonb WHERE slug = 'energy-kinetic-potential';

-- Chemistry Basics: Introduction
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is chemistry the study of?",
      "options": ["Living organisms", "Matter and its properties, composition, and transformations", "The motion of planets", "Historical events"],
      "correct": 1,
      "explanation": "Chemistry is the science that studies matter, its properties, composition, structure, and the changes it undergoes."
    },
    {
      "question": "What is the smallest unit of an element that retains its properties?",
      "options": ["Molecule", "Atom", "Cell", "Compound"],
      "correct": 1,
      "explanation": "An atom is the smallest unit of an element that retains the chemical properties of that element."
    }
  ]
}'::jsonb WHERE slug = 'chem-intro';

-- Chemistry Basics: Atomic Structure
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What particles are found in the nucleus of an atom?",
      "options": ["Electrons only", "Protons and neutrons", "Neutrons and electrons", "Protons only"],
      "correct": 1,
      "explanation": "The nucleus contains protons (positive charge) and neutrons (no charge). Electrons orbit around the nucleus."
    },
    {
      "question": "What determines the atomic number of an element?",
      "options": ["Number of neutrons", "Number of electrons", "Number of protons", "Total mass"],
      "correct": 2,
      "explanation": "The atomic number equals the number of protons in the nucleus, which defines the element."
    }
  ]
}'::jsonb WHERE slug = 'atomic-structure';

-- Chemistry Basics: Chemical Bonds
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What type of bond involves the sharing of electrons?",
      "options": ["Ionic bond", "Covalent bond", "Metallic bond", "Hydrogen bond"],
      "correct": 1,
      "explanation": "Covalent bonds form when atoms share electrons. Ionic bonds involve the transfer of electrons."
    },
    {
      "question": "Table salt (NaCl) is formed by what type of bond?",
      "options": ["Covalent bond", "Ionic bond", "Metallic bond", "Van der Waals forces"],
      "correct": 1,
      "explanation": "Sodium chloride (NaCl) is formed by an ionic bond, where sodium transfers an electron to chlorine."
    }
  ]
}'::jsonb WHERE slug = 'chemical-bonds';

-- Chemistry Basics: States of Matter
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "In which state of matter do particles have the most energy?",
      "options": ["Solid", "Liquid", "Gas", "All have equal energy"],
      "correct": 2,
      "explanation": "Gas particles have the most kinetic energy and move freely, while solid particles vibrate in fixed positions."
    },
    {
      "question": "What is the process called when a solid turns directly into a gas?",
      "options": ["Evaporation", "Condensation", "Sublimation", "Melting"],
      "correct": 2,
      "explanation": "Sublimation is the process where a solid changes directly to a gas without becoming a liquid first (e.g., dry ice)."
    }
  ]
}'::jsonb WHERE slug = 'states-matter';

-- Chemistry Basics: Chemical Reactions
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "In a chemical equation, what do the reactants become?",
      "options": ["More reactants", "Products", "Catalysts", "Enzymes"],
      "correct": 1,
      "explanation": "In a chemical reaction, reactants undergo changes to form products."
    },
    {
      "question": "What does a catalyst do in a chemical reaction?",
      "options": ["Stops the reaction", "Speeds up the reaction without being consumed", "Is used up in the reaction", "Changes the products formed"],
      "correct": 1,
      "explanation": "A catalyst speeds up a chemical reaction without being consumed or permanently changed."
    }
  ]
}'::jsonb WHERE slug = 'chemical-reactions';

-- Chemistry Basics: Periodic Table
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "How are elements arranged in the periodic table?",
      "options": ["Alphabetically", "By atomic number (number of protons)", "By discovery date", "Randomly"],
      "correct": 1,
      "explanation": "Elements are arranged by increasing atomic number, which equals the number of protons."
    },
    {
      "question": "Elements in the same column (group) of the periodic table share what?",
      "options": ["The same number of protons", "Similar chemical properties", "The same mass", "The same color"],
      "correct": 1,
      "explanation": "Elements in the same group have similar chemical properties because they have the same number of valence electrons."
    }
  ]
}'::jsonb WHERE slug = 'periodic-table';

-- Astronomy: Introduction
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is astronomy the study of?",
      "options": ["Weather patterns", "Celestial objects and phenomena in the universe", "Rocks and minerals", "Ancient civilizations"],
      "correct": 1,
      "explanation": "Astronomy is the scientific study of celestial objects, space, and the universe as a whole."
    },
    {
      "question": "What is our galaxy called?",
      "options": ["Andromeda", "The Milky Way", "Triangulum", "Centaurus"],
      "correct": 1,
      "explanation": "Our solar system is located in the Milky Way galaxy, a barred spiral galaxy."
    }
  ]
}'::jsonb WHERE slug = 'astro-intro';

-- Astronomy: Solar System
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "How many planets are in our solar system?",
      "options": ["7", "8", "9", "10"],
      "correct": 1,
      "explanation": "There are 8 planets: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, and Neptune. Pluto was reclassified as a dwarf planet in 2006."
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Venus", "Jupiter", "Mars", "Saturn"],
      "correct": 2,
      "explanation": "Mars is called the Red Planet due to iron oxide (rust) on its surface giving it a reddish appearance."
    }
  ]
}'::jsonb WHERE slug = 'solar-system';

-- Astronomy: Stars and Constellations
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a star primarily made of?",
      "options": ["Rock and metal", "Hydrogen and helium", "Water and ice", "Carbon and oxygen"],
      "correct": 1,
      "explanation": "Stars are massive balls of hot gas, primarily hydrogen and helium, undergoing nuclear fusion."
    },
    {
      "question": "What is a constellation?",
      "options": ["A type of planet", "A pattern of stars as seen from Earth", "A galaxy", "A comet"],
      "correct": 1,
      "explanation": "A constellation is a recognizable pattern of stars in the night sky, often named after mythological figures."
    }
  ]
}'::jsonb WHERE slug = 'stars-constellations';

-- Astronomy: Galaxies
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a galaxy?",
      "options": ["A single large star", "A system of stars, gas, dust, and dark matter bound by gravity", "A planet with rings", "A type of nebula"],
      "correct": 1,
      "explanation": "A galaxy is a massive system containing billions of stars, along with gas, dust, and dark matter, all held together by gravity."
    },
    {
      "question": "What type of galaxy is the Milky Way?",
      "options": ["Elliptical", "Irregular", "Barred spiral", "Ring"],
      "correct": 2,
      "explanation": "The Milky Way is a barred spiral galaxy, with spiral arms extending from a central bar-shaped structure."
    }
  ]
}'::jsonb WHERE slug = 'galaxies';

-- Astronomy: Space Exploration
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "Who was the first human to walk on the Moon?",
      "options": ["Yuri Gagarin", "Buzz Aldrin", "Neil Armstrong", "John Glenn"],
      "correct": 2,
      "explanation": "Neil Armstrong became the first human to walk on the Moon on July 20, 1969, during the Apollo 11 mission."
    },
    {
      "question": "What is the name of NASA''s most famous space telescope launched in 1990?",
      "options": ["James Webb", "Hubble", "Kepler", "Spitzer"],
      "correct": 1,
      "explanation": "The Hubble Space Telescope, launched in 1990, has provided stunning images and valuable data about the universe."
    }
  ]
}'::jsonb WHERE slug = 'space-exploration';

-- Astronomy: The Moon
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What causes the phases of the Moon?",
      "options": ["Earth''s shadow on the Moon", "The Moon''s changing distance from Earth", "The changing angle of sunlight as the Moon orbits Earth", "Clouds blocking the Moon"],
      "correct": 2,
      "explanation": "Moon phases are caused by the changing angles of sunlight hitting the Moon as it orbits Earth, not by Earth''s shadow."
    },
    {
      "question": "How long does it take for the Moon to complete one orbit around Earth?",
      "options": ["24 hours", "7 days", "About 27-29 days", "365 days"],
      "correct": 2,
      "explanation": "The Moon takes about 27.3 days (sidereal month) to orbit Earth, or about 29.5 days from new moon to new moon (synodic month)."
    }
  ]
}'::jsonb WHERE slug = 'the-moon';

-- Add quizzes to intro lessons for other courses

-- Quantum Mechanics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a quantum?",
      "options": ["A very large object", "The smallest discrete unit of any physical property", "A type of star", "A chemical element"],
      "correct": 1,
      "explanation": "A quantum is the minimum amount of any physical entity involved in an interaction - the smallest discrete unit."
    },
    {
      "question": "The famous thought experiment involving a cat that is both alive and dead is called?",
      "options": ["Newton''s Cat", "Einstein''s Cat", "Schrodinger''s Cat", "Bohr''s Cat"],
      "correct": 2,
      "explanation": "Schrodinger''s Cat is a thought experiment illustrating quantum superposition, where a cat in a box is theoretically both alive and dead until observed."
    }
  ]
}'::jsonb WHERE slug = 'quantum-intro';

-- Thermodynamics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does thermodynamics study?",
      "options": ["Light and optics", "Heat, energy, and their transformations", "Electricity and magnetism", "Nuclear reactions"],
      "correct": 1,
      "explanation": "Thermodynamics is the study of heat, energy, work, and how they interrelate and transform."
    },
    {
      "question": "What does the First Law of Thermodynamics state?",
      "options": ["Energy always increases", "Energy cannot be created or destroyed, only transformed", "Heat always flows from cold to hot", "Entropy always decreases"],
      "correct": 1,
      "explanation": "The First Law states that energy is conserved - it cannot be created or destroyed, only converted from one form to another."
    }
  ]
}'::jsonb WHERE slug = 'thermo-intro';

-- Organic Chemistry
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What element is the basis of organic chemistry?",
      "options": ["Oxygen", "Nitrogen", "Carbon", "Hydrogen"],
      "correct": 2,
      "explanation": "Carbon is the foundation of organic chemistry. Its ability to form four bonds allows it to create diverse molecular structures."
    },
    {
      "question": "Why can carbon form so many different compounds?",
      "options": ["It is very heavy", "It can form up to four covalent bonds with other atoms", "It is radioactive", "It only bonds with itself"],
      "correct": 1,
      "explanation": "Carbon can form four covalent bonds and bond with many elements including itself, creating chains, rings, and complex structures."
    }
  ]
}'::jsonb WHERE slug = 'organic-intro';

-- Biochemistry
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does biochemistry study?",
      "options": ["Only plants", "Chemical processes within living organisms", "Rocks and minerals", "Weather patterns"],
      "correct": 1,
      "explanation": "Biochemistry studies the chemical processes and substances that occur within living organisms."
    },
    {
      "question": "Which molecule carries genetic information in cells?",
      "options": ["Proteins", "Carbohydrates", "DNA", "Lipids"],
      "correct": 2,
      "explanation": "DNA (deoxyribonucleic acid) carries the genetic instructions for the development and functioning of living organisms."
    }
  ]
}'::jsonb WHERE slug = 'biochem-intro';

-- Cell Biology
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is considered the basic unit of life?",
      "options": ["Atom", "Molecule", "Cell", "Organ"],
      "correct": 2,
      "explanation": "The cell is the basic structural and functional unit of all living organisms."
    },
    {
      "question": "Which organelle is known as the powerhouse of the cell?",
      "options": ["Nucleus", "Ribosome", "Mitochondria", "Golgi apparatus"],
      "correct": 2,
      "explanation": "Mitochondria are called the powerhouse of the cell because they produce ATP, the cell''s main energy currency."
    }
  ]
}'::jsonb WHERE slug = 'cell-intro';

-- Genetics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a gene?",
      "options": ["A type of cell", "A unit of heredity that codes for a specific trait", "A type of protein", "A chromosome"],
      "correct": 1,
      "explanation": "A gene is a segment of DNA that contains instructions for building specific proteins and determines inherited traits."
    },
    {
      "question": "Who is considered the father of genetics?",
      "options": ["Charles Darwin", "Gregor Mendel", "James Watson", "Louis Pasteur"],
      "correct": 1,
      "explanation": "Gregor Mendel, through his experiments with pea plants in the 1860s, established the fundamental laws of heredity."
    }
  ]
}'::jsonb WHERE slug = 'genetics-intro';

-- Ecology
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does ecology study?",
      "options": ["Only animals", "Interactions between organisms and their environment", "Only plants", "Only weather"],
      "correct": 1,
      "explanation": "Ecology is the study of how organisms interact with each other and their physical environment."
    },
    {
      "question": "What is an ecosystem?",
      "options": ["A single organism", "A community of living organisms interacting with their non-living environment", "Only the plants in an area", "A type of cell"],
      "correct": 1,
      "explanation": "An ecosystem includes all living organisms in an area and their interactions with non-living components like water, soil, and climate."
    }
  ]
}'::jsonb WHERE slug = 'ecology-intro';

-- Neurobiology
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is the basic functional unit of the nervous system?",
      "options": ["Brain", "Neuron", "Spine", "Muscle"],
      "correct": 1,
      "explanation": "Neurons are specialized cells that transmit electrical and chemical signals throughout the nervous system."
    },
    {
      "question": "What is the gap between two neurons called?",
      "options": ["Axon", "Dendrite", "Synapse", "Myelin"],
      "correct": 2,
      "explanation": "A synapse is the junction between two neurons where signals are transmitted via neurotransmitters."
    }
  ]
}'::jsonb WHERE slug = 'neuro-intro';

-- Planetary Science
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does planetary science study?",
      "options": ["Only Earth", "Planets, moons, and planetary systems", "Only stars", "Only galaxies"],
      "correct": 1,
      "explanation": "Planetary science studies planets, moons, asteroids, comets, and other objects in planetary systems."
    },
    {
      "question": "Which planet has the most moons in our solar system?",
      "options": ["Earth", "Mars", "Jupiter", "Saturn"],
      "correct": 3,
      "explanation": "Saturn has the most confirmed moons (over 140), slightly more than Jupiter."
    }
  ]
}'::jsonb WHERE slug = 'planetary-intro';

-- Astrophysics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is astrophysics?",
      "options": ["The study of Earth", "The application of physics to understand astronomical objects", "The study of chemistry", "Weather prediction"],
      "correct": 1,
      "explanation": "Astrophysics applies the principles of physics to understand how celestial objects and the universe work."
    },
    {
      "question": "What is a black hole?",
      "options": ["An empty region of space", "A region where gravity is so strong that nothing can escape, not even light", "A type of star", "A dark planet"],
      "correct": 1,
      "explanation": "A black hole is a region of spacetime where gravity is so intense that nothing, including light, can escape once past the event horizon."
    }
  ]
}'::jsonb WHERE slug = 'astrophysics-intro';

-- Robotics
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is a robot?",
      "options": ["Only a human-shaped machine", "A machine capable of carrying out complex actions automatically", "Only factory machines", "Only toys"],
      "correct": 1,
      "explanation": "A robot is a programmable machine capable of carrying out complex actions automatically, often with sensors and actuators."
    },
    {
      "question": "What are the three main components of a basic robot?",
      "options": ["Wheels, arms, legs", "Sensors, controllers, actuators", "Screen, keyboard, mouse", "Battery, motor, light"],
      "correct": 1,
      "explanation": "Basic robots have sensors (to perceive), controllers (to process/decide), and actuators (to act on the environment)."
    }
  ]
}'::jsonb WHERE slug = 'robotics-intro';

-- Materials Science
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does materials science study?",
      "options": ["Only metals", "The properties and applications of materials", "Only plastics", "Only natural materials"],
      "correct": 1,
      "explanation": "Materials science studies the properties, structure, and applications of all types of materials including metals, ceramics, polymers, and composites."
    },
    {
      "question": "What are the four main categories of materials?",
      "options": ["Solid, liquid, gas, plasma", "Metals, ceramics, polymers, composites", "Natural, synthetic, organic, inorganic", "Hard, soft, flexible, rigid"],
      "correct": 1,
      "explanation": "The four main categories are metals, ceramics, polymers (plastics), and composites (combinations of materials)."
    }
  ]
}'::jsonb WHERE slug = 'materials-intro';

-- Environmental Science
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What does environmental science study?",
      "options": ["Only pollution", "The interactions between physical, chemical, and biological components of the environment", "Only animals", "Only climate"],
      "correct": 1,
      "explanation": "Environmental science is an interdisciplinary field studying how natural and human systems interact with the environment."
    },
    {
      "question": "What is the greenhouse effect?",
      "options": ["Growing plants in greenhouses", "The trapping of heat in Earth''s atmosphere by certain gases", "A type of pollution", "Ozone depletion"],
      "correct": 1,
      "explanation": "The greenhouse effect is the process where certain atmospheric gases trap heat from the sun, warming Earth''s surface."
    }
  ]
}'::jsonb WHERE slug = 'environmental-intro';

-- General Science
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "What is the scientific method?",
      "options": ["A type of experiment", "A systematic approach to investigating phenomena through observation and experimentation", "A mathematical formula", "A scientific law"],
      "correct": 1,
      "explanation": "The scientific method is a systematic process of observation, hypothesis formation, experimentation, and conclusion."
    },
    {
      "question": "What is a hypothesis?",
      "options": ["A proven fact", "A testable prediction or explanation", "A scientific law", "An opinion"],
      "correct": 1,
      "explanation": "A hypothesis is a proposed explanation that can be tested through experiments and observations."
    }
  ]
}'::jsonb WHERE slug = 'general-intro';

-- Origins: How We Were Created
UPDATE public.lessons SET quiz = '{
  "questions": [
    {
      "question": "According to the Big Bang theory, the universe began approximately how long ago?",
      "options": ["1 million years ago", "4.5 billion years ago", "13.8 billion years ago", "100 billion years ago"],
      "correct": 2,
      "explanation": "The Big Bang theory suggests the universe began approximately 13.8 billion years ago from an extremely hot, dense state."
    },
    {
      "question": "How old is Earth approximately?",
      "options": ["1 million years", "4.5 billion years", "13.8 billion years", "100 million years"],
      "correct": 1,
      "explanation": "Earth formed approximately 4.5 billion years ago from the solar nebula, the cloud of gas and dust that formed our solar system."
    }
  ]
}'::jsonb WHERE slug = 'origins-intro';
