-- Planetary Science Course (Complete)
-- Intermediate level course covering planetary geology, atmospheres, and formation

INSERT INTO courses (id, title, slug, description, level, category, display_order, created_at)
VALUES (
  uuid_generate_v4(),
  'Planetary Science',
  'planetary-science',
  'Explore the formation, geology, and atmospheres of planets in our solar system and beyond. Learn about planetary surfaces, interiors, magnetic fields, and the processes that shape worlds.',
  'intermediate',
  'science',
  10,
  NOW()
)
RETURNING id;

-- Get the course ID for chapter references
DO $$
DECLARE
  planetary_course_id UUID;
BEGIN
  SELECT id INTO planetary_course_id FROM courses WHERE slug = 'planetary-science';

  -- Chapter 1: Introduction to Planetary Science
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    planetary_course_id,
    'Introduction to Planetary Science',
    'introduction-to-planetary-science',
    'Learn what planetary science is, its history, tools used, how our solar system formed, and how we compare planets.',
    1,
    NOW()
  );

  -- Chapter 2: Planetary Surfaces and Interiors
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    planetary_course_id,
    'Planetary Surfaces and Interiors',
    'planetary-surfaces-and-interiors',
    'Explore the processes that shape planetary surfaces and what lies beneath - cratering, volcanism, tectonics, interiors, and magnetic fields.',
    2,
    NOW()
  );

  -- Chapter 3: Planetary Atmospheres
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    planetary_course_id,
    'Planetary Atmospheres',
    'planetary-atmospheres',
    'Discover the composition, structure, and dynamics of planetary atmospheres, heat transfer, weather, and how atmospheres evolve over time.',
    3,
    NOW()
  );

  -- Chapter 4: Terrestrial Planets
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    planetary_course_id,
    'Terrestrial Planets',
    'terrestrial-planets',
    'Study the rocky planets of our solar system: Mercury, Venus, Earth, the Moon, and Mars - their geology, atmospheres, and unique features.',
    4,
    NOW()
  );

  -- Chapter 5: Gas Giants, Ice Giants, and Moons
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    planetary_course_id,
    'Gas Giants, Ice Giants, and Moons',
    'gas-giants-ice-giants-and-moons',
    'Explore Jupiter and Saturn (gas giants), Uranus and Neptune (ice giants), and the fascinating moons of these outer planets.',
    5,
    NOW()
  );

-- Get chapter IDs for lesson inserts
DO $$
DECLARE
  ch1_id UUID;
  ch2_id UUID;
  ch3_id UUID;
  ch4_id UUID;
  ch5_id UUID;
BEGIN
  SELECT id INTO ch1_id FROM chapters WHERE course_id = planetary_course_id AND slug = 'introduction-to-planetary-science';
  SELECT id INTO ch2_id FROM chapters WHERE course_id = planetary_course_id AND slug = 'planetary-surfaces-and-interiors';
  SELECT id INTO ch3_id FROM chapters WHERE course_id = planetary_course_id AND slug = 'planetary-atmospheres';
  SELECT id INTO ch4_id FROM chapters WHERE course_id = planetary_course_id AND slug = 'terrestrial-planets';
  SELECT id INTO ch5_id FROM chapters WHERE course_id = planetary_course_id AND slug = 'gas-giants-ice-giants-and-moons';

  -- CHAPTER 1: Introduction to Planetary Science (5 lessons)

  -- Lesson 1.1: What is Planetary Science?
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    ch1_id,
    'What is Planetary Science?',
    'what-is-planetary-science',
    'Introduction to planetary science as a multidisciplinary field studying planets, moons, and planetary systems.',
    '# What is Planetary Science?

## Introduction to Planetary Science

**Planetary science** (or planetology) is the scientific study of planets and their planetary systems, including moons, ring systems, asteroids, comets, and dwarf planets. It is an interdisciplinary field that combines:

- **Geology** - study of planetary surfaces and interiors
- **Atmospheric science** - study of planetary atmospheres and climate
- **Physics** - orbital mechanics, gravity, magnetic fields
- **Chemistry** - composition of planets and chemical processes
- **Biology** - potential for life beyond Earth (astrobiology)

## Why Study Planetary Science?

### Understanding Earth
By studying other planets, we learn more about our own planet. Earth is one piece of a larger puzzle, and comparing it to other worlds reveals what makes it unique and what processes are universal.

### Origins of the Solar System
Planetary science helps us understand how our solar system formed 4.6 billion years ago and how it has evolved over time.

### Search for Life
Understanding other planets helps us identify conditions suitable for life and guides the search for extraterrestrial intelligence.

### Resource Exploration
Knowledge of other planets may someday help us access resources beyond Earth for future space exploration and potential colonization.

## Major Areas of Study

| Area | Focus | Examples |
|------|-------|----------|
| **Planetary geology** | Surface features, rock types, volcanic activity | Mars volcanoes, lunar craters |
| **Atmospheric science** | Gas composition, weather patterns, climate | Jupiter''s storms, Venus greenhouse |
| **Planetary interiors** | Core structure, mantle convection, magnetic fields | Earth''s magnetic field |
| **Cosmochemistry** | Chemical composition of planets and meteorites | Moon rocks, Mars soil analysis |
| **Exoplanets** | Planets around other stars | Kepler discoveries, habitable zones |

## How Planetary Scientists Work

### Remote Sensing
Most planetary science is done remotely using:
- **Telescopes** - ground-based and space-based observations
- **Spacecraft** - orbiters, flybys, landers, and rovers
- **Spectroscopy** - analyzing light to determine composition

### Sample Analysis
When possible, scientists study actual samples:
- **Meteorites** - space rocks that fall to Earth
- **Moon samples** - returned by Apollo missions
- **Comet dust** - collected by spacecraft like Stardust

### Laboratory Experiments
Scientists simulate planetary conditions in labs to understand processes like:
- Impact cratering
- Volcanic activity under different gravity
- High-pressure experiments simulating planetary interiors

## The Solar System in Numbers

| Feature | Value |
|---------|-------|----------|
| Age of solar system | ~4.6 billion years |
| Number of planets | 8 (not counting Pluto) |
| Number of dwarf planets | 5+ (Ceres, Pluto, Eris, Haumea, Makemake) |
| Number of known moons | 200+ |
| Largest planet | Jupiter (11× Earth''s diameter) |

## Key Terms

- **Planet**: A celestial body orbiting a star, massive enough to be rounded by gravity, and has cleared its orbit
- **Dwarf planet**: Round object orbiting the Sun that hasn''t cleared its orbital neighborhood
- **Moon**: Natural satellite orbiting a planet or dwarf planet
- **Asteroid**: Rocky object smaller than a planet, mainly in the asteroid belt
- **Comet**: Icy body that develops a tail when approaching the Sun

## Historical Development

Planetary science emerged from:
1. **Astronomy** - ancient observations of planetary motions
2. **Geology** - understanding Earth''s structure
3. **Space Age** (1957+) - spacecraft opened new worlds for direct study

The field has grown dramatically since the first lunar missions in the 1960s and continues to evolve with each new discovery.

## Real-World Example: Mars Exploration

The study of Mars illustrates planetary science in action:
- **Geologists** study rover images of rock layers
- **Atmospheric scientists** analyze weather data
- **Geochemists** study soil composition
- **Astrobiologists** search for signs of past life

All these specialists work together to understand Mars as a complete planetary system.',
    '[
      {
        "question": "What is planetary science?",
        "options": [
          "The study of stars and galaxies",
          "The scientific study of planets and their systems",
          "The study of how planets form and evolve",
          "The search for life on other worlds"
        ],
        "correctAnswer": 1,
        "explanation": "Planetary science (or planetology) is the interdisciplinary scientific study of planets, moons, and other planetary systems. It combines geology, atmospheric science, physics, chemistry, and biology to understand worlds beyond Earth."
      },
      {
        "question": "Why do scientists study other planets?",
        "options": [
          "To find aliens",
          "To prepare for human colonization",
          "To understand Earth better",
          "To search for resources"
        ],
        "correctAnswer": 2,
        "explanation": "Scientists study other planets to (1) understand Earth better through comparison (Earth is one data point in a larger planetary sample), and (2) learn about universal processes that shape all worlds, not just what''s unique to Earth."
      },
      {
        "question": "What is the definition of a planet?",
        "options": [
          "A celestial body that orbits a star",
          "A massive spherical object in space",
          "A natural satellite of another planet",
          "A rocky object with an atmosphere"
        ],
        "correctAnswer": 0,
        "explanation": "According to the International Astronomical Union (IAU), a planet is a celestial body that orbits a star, is massive enough to be rounded by its own gravity, and has cleared its orbital neighborhood of other objects."
      }
    ]',
    1,
    NOW()
  );

  -- Lesson 1.2: History of Planetary Exploration
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    ch1_id,
    'History of Planetary Exploration',
    'history-of-planetary-exploration',
    'Key milestones in the exploration of our solar system from early telescopes to modern spacecraft.',
    '# History of Planetary Exploration

## The Age of Discovery

### Pre-Space Age Observations

Before spacecraft, astronomers studied planets using only telescopes:

- **Galileo Galilei (1610)** - Discovered Jupiter''s four largest moons, observed Saturn''s rings (though didn''t recognize them as rings)
- **Christiaan Huygens (1655)** - Discovered Titan, Saturn''s largest moon
- **Giovanni Cassini (1675)** - Discovered gap in Saturn''s rings (Cassini Division)
- **William Herschel (1781)** - Discovered Uranus
- **John Couch Adams & Urbain Le Verrier (1846)** - Predicted Neptune''s position mathematically, leading to its discovery

These observations revealed that planets were worlds, not just points of light.

## The Space Age Begins

### First Milestones

| Year | Achievement | Significance |
|------|-------------|--------------|
| 1957 | Sputnik 1 (USSR) | First artificial satellite |
| 1959 | Luna 2 (USSR) | First spacecraft to reach Moon (impactor) |
| 1961 | Vostok 1 (USSR) | First human in space (Yuri Gagarin) |
| 1962 | Mariner 2 (USA) | First successful planetary flyby (Venus) |
| 1969 | Apollo 11 (USA) | First humans on Moon |

The space race between the USA and USSR drove rapid advances in space exploration technology.

## The Race to the Planets

### Venus: First Planetary Encounters

- **Venera 1 (1961)** - First flyby attempt (failed)
- **Mariner 2 (1962)** - First successful flyby, confirmed Venus''s hot surface
- **Venera 7 (1970)** - First soft landing on another planet
- **Magellan (1990)** - Radar mapping of Venus''s surface

### Mars: The Most Explored Planet

Mars has been visited by more missions than any other planet:

| Decade | Key Achievements |
|--------|------------------|
| 1960s-70s | Mariner flybys and orbiters, Viking landers (first search for life) |
| 1990s | Mars Global Surveyor, Mars Pathfinder, Sojourner rover |
| 2000s | Spirit and Opportunity rovers (90-day missions), Mars Odyssey |
| 2010s | Mars Reconnaissance Orbiter, Phoenix lander, Curiosity rover |
| 2020s | Perseverance rover, InSight lander, China''s Zhurong rover |

**Key discoveries**: Ancient water evidence, seasonal changes, methane detection

### Outer Planets: Grand Tours

- **Pioneer 10 & 11 (1972-73)** - First spacecraft to cross asteroid belt, first Jupiter flyby
- **Voyager 1 & 2 (1977)** - Grand Tour of outer planets, still transmitting data |
- **Galileo (1989)** - First Jupiter orbiter, dropped probe into Jupiter''s atmosphere
- **Cassini-Huygens (1997)** - Saturn orbiter + Titan lander, 13-year mission |

### Recent and Ongoing Missions

### Mars (2020s)

- **Perseverance Rover (2011)** - Analyzed Martian soil, found subsurface water ice
- **Curiosity (2012)** - Car-sized rover investigating Gale Crater, still operating
- **InSight (2018)** - Studying internal structure through seismology
- **Zhurong (2013)** - China''s first Mars lander and rover

### Outer Planets

- **Juno** (Jupiter, ongoing) - Studying Jupiter''s interior and magnetic field
- **New Horizons (2015)** - First Pluto flyby, revealed diverse geology
- **JUICE** (Jupiter, ongoing) - Ice moons explorer

### Future of Exploration

| Mission | Target | Goal | Timeline |
|---------|--------|------|----------|
| Europa Clipper | Jupiter''s moon Europa (2024) | Search for conditions suitable for life |
| Mars Sample Return | Mars (2028+) | Return samples collected by Perseverance |
| Dragonfly | Saturn''s moon Titan (2028) | Drone mission to explore surface |
| Artemis | Moon (2025+) | Return humans to Moon, establish presence |

## Impact of Planetary Exploration

### Scientific Discoveries

Space exploration has revolutionized our understanding:
- Volcanic activity on Io (Jupiter''s moon)
- Subsurface oceans on Europa and Enceladus
- Evidence of ancient water on Mars
- Extreme diversity of planetary surfaces and atmospheres

### Technology Spinoffs

Space technology has led to:
- Improved medical imaging devices
- Better weather forecasting
- Advanced materials and manufacturing
- GPS and communication satellites
- Water purification systems

## Challenges in Planetary Exploration

### Technical Challenges

- **Distance** - Limited communication delays, years to reach outer planets
- **Harsh conditions** - Extreme temperatures, radiation, vacuum
- **Power** - Limited solar energy beyond Mars, need nuclear power
- **Landing** - Extremely difficult, many failures

### Human Challenges

- **Cost** - Billions of dollars per major mission
- **Time** - Missions take decades from concept to data
- **Risk** - High failure rate, expensive setbacks
- **Planning** - Need long-term commitment from governments

## Key Takeaways

1. Planetary exploration began with telescopic observations but accelerated with spacecraft
2. Each decade since 1960s has brought new discoveries and capabilities
3. Different mission types (flyby, orbiter, lander) serve different scientific goals
4. The most explored planets are Venus, Mars, Jupiter, and Saturn
5. Future exploration focuses on ocean moons, sample return, and potentially human missions',
    '[
      {
        "question": "What was the first successful planetary flyby mission?",
        "options": [
          "Mariner 2 to Venus",
          "Pioneer 10 to Jupiter",
          "Voyager 1 to Jupiter",
          "Mariner 10 to Mercury"
        ],
        "correctAnswer": 0,
        "explanation": "Mariner 2 performed the first successful planetary flyby in 1962, flying past Venus and confirming that Venus has a hot surface."
      },
      {
        "question": "Which planet has been explored by the most missions?",
        "options": [
          "Jupiter",
          "Venus",
          "Mars",
          "Saturn"
        ],
        "correctAnswer": 2,
        "explanation": "Mars has been visited by more missions than any other planet, including flybys, orbiters, landers, and rovers from multiple countries over decades of exploration."
      },
      {
        "question": "What is the main advantage of an orbiter mission compared to a flyby?",
        "options": [
          "Shorter travel time",
          "Can visit multiple targets",
          "Lower cost",
          "More detailed mapping"
        ],
        "correctAnswer": 3,
        "explanation": "Orbiters provide extended observation periods and detailed mapping compared to flybys, which have brief encounters and limited data. However, they are more complex and expensive."
      }
    ]',
    2,
    NOW()
  );

  -- Lesson 1.3: Tools of Planetary Science
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    ch1_id,
    'Tools of Planetary Science',
    'tools-of-planetary-science',
    'Explore the instruments and techniques used to study planets - telescopes, spacecraft, spectroscopy, and laboratory analysis.',
    '# Tools of Planetary Science

## Introduction

Planetary scientists use a variety of tools to study planets and moons. Since we can''t visit most worlds directly, we rely on **remote sensing** and **laboratory analysis** to unlock their secrets.

## Telescopes: Windows to the Solar System

### Ground-Based Telescopes

Large telescopes on Earth observe planets and moons:

| Telescope | Location | Specialty |
|-----------|----------|-----------|
| Keck Observatory | Hawaii | Infrared spectroscopy of planets |
| Very Large Telescope (VLT) | Chile | High-resolution imaging |
| Arecibo (now decommissioned) | Puerto Rico | Radar mapping of planets, moons |

**Advantages**:
- Large apertures possible (10m+ mirrors)
- Upgradable with new instruments
- Relatively low operating costs

**Limitations**:
- Atmospheric distortion (weather, air turbulence)
- Absorption of certain wavelengths by atmosphere
- Can only observe when object is visible and above horizon

### Space-Based Telescopes

Telescopes in orbit avoid atmospheric problems:

| Telescope | Launch | Specialty |
|-----------|--------|-----------|
| Hubble Space Telescope | 1990 | Visible/UV imaging, still active |
| Spitzer Space Telescope | 2003 | Infrared observations (retired 2020) |
| James Webb Space Telescope | 2021 | Infrared, exoplanet atmospheres |

**Advantages**:
- No atmospheric distortion
- Access to all wavelengths (UV, infrared, X-ray)
- Can observe 24/7

**Limitations**:
- Extremely expensive
- Limited aperture size (must fit in rocket)
- Cannot be serviced easily (except Hubble)

## Remote Sensing Techniques

### Visible Light Imaging

Standard cameras capture images in visible wavelengths (400-700 nm).

**Applications**:
- Mapping surface features
- Studying cloud patterns
- Monitoring changes over time

**Examples**: Navigation cameras on rovers, ISS Earth photography

### Infrared Imaging

Infrared radiation (700 nm to 1 mm) reveals:

- **Surface temperature** - warmer areas appear brighter
- **Mineral composition** - different minerals reflect infrared differently
- **Atmospheric structure** - heat patterns and circulation

**Example**: Thermal emission spectrometer on Mars Global Surveyor discovered evidence of past water on Mars by identifying minerals formed in water.

### Ultraviolet Observations

Ultraviolet light (10-400 nm) studies:

- **Atmospheric composition** - especially gases like ozone
- **Aurora** - charged particles interacting with magnetic fields
- **Young, hot stars** - emit strongly in UV

**Example**: Hubble''s UV images show Jupiter''s aurora at both poles.

### Radar Mapping

Radar (radio waves) can:

- **Map surfaces through clouds** (Venus)
- **Measure surface roughness** (ice vs rock)
- **Determine topography** (elevation)

**Example**: Magellan''s radar mapped 98% of Venus''s surface, revealing volcanoes and impact craters through the thick clouds.

### Spectroscopy: The Most Powerful Tool

**Spectroscopy** analyzes light by splitting it into a spectrum to identify:

- **Chemical composition** - each element/compound has unique spectral "fingerprint"
- **Temperature** - shape of spectrum reveals temperature
- **Pressure** - pressure broadens spectral lines
- **Motion** - Doppler shift reveals movement toward or away from us

**Types of Spectroscopy**:

| Type | Information |
|------|-------------|----------|
| **Reflection spectroscopy** | Surface composition (minerals, ice) |
| **Emission spectroscopy** | Atmospheric gases, temperatures |
| **Absorption spectroscopy** | Atmospheric composition |

**Real-world example**: Spectroscopy of Mars revealed presence of:
- Water ice in polar caps
- Carbon dioxide in atmosphere
- Clay minerals formed in water (evidence of past liquid water)

## Spacecraft Instruments

### Camera Systems

- **Navigation cameras** - low resolution, for spacecraft positioning
- **Science cameras** - high resolution, multiple filters
- **Panoramic cameras** - wide-angle views (Mars rovers)
- **Microscopic imagers** - close-up views of rocks (Mars rovers)

### Spectrometers

- **Mass spectrometers** - identify atmospheric gases (Curiosity''s SAM)
- **Gamma-ray spectrometers** - map elemental composition from orbit (Lunar Prospector)
- **Thermal emission spectrometers** - mineral identification (Mars Global Surveyor)

### Radar Instruments

- **Radar altimeters** - measure elevation (Mars Global Surveyor)
- **Subsurface radar** - penetrate ground to find ice/liquid (SHARAD on MRO)
- **Synthetic aperture radar** - high-resolution surface imaging (Magellan at Venus)

### Atmospheric Instruments

- **Barometers** - measure atmospheric pressure
- **Thermometers** - measure temperature
- **Humidity sensors** - measure water vapor
- **Wind sensors** - measure wind speed and direction
- **Dust detectors** - measure dust concentration

### Surface Analysis Tools

- **Alpha Particle X-ray Spectrometer (APXS)** - determines rock composition (Mars rovers)
- **X-ray Diffraction (XRD)** - identifies mineral structure (Curiosity''s CheMin)
- **Drill** - collects samples from below surface (Curiosity, Perseverance)
- **Microscope** - examines rock textures at microscopic scale

## Sample Analysis

### Meteorites

Rocks from space that land on Earth provide direct samples:

| Meteorite Type | Origin | What They Tell Us |
|---------------|--------|------------------|
| **Achondrites** | Rocky meteorites from asteroids, Mars, or the Moon | Age of solar system (4.6 billion years), composition of early solar system |
| **Chondrites** | Primitive, unchanged since solar system formation | Oldest materials in solar system, building blocks of planets |
| **Iron meteorites** | From metallic asteroid cores | Core formation processes in asteroids |

**What they tell us**:
- Age of solar system (4.6 billion years)
- Composition of early solar system
- Evidence of past water on some asteroids
- Some come from Mars or the Moon (identified by gas trapped inside)

### Returned Samples

Only a few missions have returned samples:

| Mission | Samples | Year |
|---------|---------|------|
| Apollo (11, 12, 14-17) | 382 kg of Moon rocks | 1969-1972 |
| Luna (USSR) | 326 g of Moon soil | 1970-1976 |
| Hayabusa (Japan) | 1,500 grains from asteroid Itokawa | 2010 |
| Hayabusa2 (Japan) | 5.4 g from asteroid Ryugu | 2020 |
| OSIRIS-REx (USA) | 250 g from asteroid Bennu | 2023 |

### Laboratory Analysis Techniques

- **Electron microscopes** - examine mineral structure at tiny scales
- **Mass spectrometry** - precisely determine elemental and isotopic composition
- **Radiometric dating** - determine age of rocks
- **Gas extraction** - analyze trapped gases to identify source (e.g., Mars vs Earth)

## Modeling and Simulation

### Computer Models

Scientists use computers to simulate:

- **Planetary interiors** - convection, magnetic field generation
- **Atmospheric circulation** - weather patterns, climate change
- **Impact events** - crater formation, consequences
- **Tectonic processes** - how crust deforms over time

### Laboratory Experiments

Scientists recreate planetary conditions:

- **Impact experiments** - fire projectiles at high velocity to study cratering
- **Volcanic simulations** - study lava flow under different gravity
- **High-pressure experiments** - simulate conditions in planetary interiors
- **Space environment chambers** - test spacecraft durability

## Data Analysis and Interpretation

### Planetary Data System (PDS)

All NASA mission data is archived in the Planetary Data System:
- Freely available to all scientists
- Standardized formats
- Includes raw data, calibrated data, and documentation

### Geographic Information Systems (GIS)

GIS software allows scientists to:
- Map surface features
- Analyze spatial relationships
- Overlay different data types (elevation, composition, imagery)

## Key Takeaways

1. Telescopes (ground and space-based) provide remote observations of planets
2. Spectroscopy is the most powerful tool for determining composition
3. Spacecraft carry specialized instruments to study planets up close
4. Direct samples (meteorites, returned samples) provide the most detailed information
5. Laboratory experiments and computer models help interpret observations and understand processes',
    '[
      {
        "question": "What is spectroscopy used for in planetary science?",
        "options": [
          "Taking photographs of planets",
          "Measuring distance to planets",
          "Analyzing light to determine chemical composition",
          "Detecting magnetic fields on other worlds"
        ],
        "correctAnswer": 2,
        "explanation": "Spectroscopy analyzes light by splitting it into a spectrum to identify chemical composition, temperature, pressure, and motion. Each element and compound has a unique spectral signature, allowing scientists to determine what planets are made of without visiting them."
      },
      {
        "question": "What can radar observations do that visible-light telescopes cannot?",
        "options": [
          "Measure surface temperature",
          "Map surfaces through clouds",
          "Determine topography (elevation)"
        ],
        "correctAnswer": 1,
        "explanation": "Radar uses radio waves that can penetrate clouds (like Venus''s thick atmosphere) and measure elevation by bouncing signals off the surface. This allows mapping of surface features and topography that cannot be seen with visible light."
      },
      {
        "question": "Why are meteorites important?",
        "options": [
          "They contain valuable minerals",
          "They tell us about the age of the solar system",
          "They show what the early solar system was made of",
          "Some come from Mars or the Moon"
        ],
        "correctAnswer": 1,
        "explanation": "Meteorites are space rocks that land on Earth, providing direct samples for study. They reveal the age of the solar system (4.6 billion years), the composition of the early solar system, and some come from Mars or the Moon (identified by trapped gases matching Apollo samples)."
      }
    ]',
    3,
    NOW()
  );

  -- Lesson 1.4: Formation of the Solar System
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    ch1_id,
    'Formation of the Solar System',
    'formation-of-the-solar-system',
    'Learn how our solar system formed from a collapsing cloud of gas and dust 4.6 billion years ago.',
    '# Formation of the Solar System

## Introduction

Our solar system formed approximately **4.6 billion years ago** from a giant cloud of gas and dust. Understanding this origin story helps explain why planets have their current characteristics and why they''re arranged the way they are.

## The Solar Nebula Theory

The widely accepted theory for solar system formation is the **solar nebula hypothesis**:

1. A large cloud of gas and dust (nebula) began to collapse
2. As it collapsed, it flattened into a rotating disk
3. The Sun formed at the center, and planets formed in the disk

## Step-by-Step Formation

### Stage 1: Collapse of the Solar Nebula

**Trigger**: A nearby supernova shock wave may have triggered collapse

**The Solar Nebula**:
- Composed of 98% hydrogen and helium (from Big Bang)
- 2% heavier elements (from previous generations of stars)
- Diameter: ~100 AU (about twice Pluto''s current orbit)
- Mass: ~2-3 times mass of our Sun

**Conservation Laws in Action**:

| Property | What Happened | Result |
|----------|---------------|--------|
| **Angular momentum** | As cloud shrank, rotation speed increased | Disk formation |
| **Energy** | Gravitational potential energy converted to heat | Center heated up |
| **Momentum** | Particles collided and merged | Growth of larger bodies |

**Temperature Distribution**:
- Center: hottest (several thousand K)
- Edges: coldest (~100 K or -173°C)

This temperature gradient would determine what kind of planets could form where.

### Stage 2: Condensation of Solids

As the nebula cooled, different materials condensed (turned from gas to solid) at different distances from the proto-Sun:

| Distance | Materials | Temperature |
|----------|-----------|-------------|
| **Inner (0-4 AU)** | Metals, silicates | ~1500 K (hot) |
| **Outer (4-30 AU)** | Silicates, water ice, other volatiles | ~100-200 K (cold) |

**The Frost Line** (also called snow line):
- Boundary beyond which water ice could condense (~4 AU - near Jupiter''s current orbit)
- Inside this line: too hot for water ice
- Outside this line: water ice (and other volatiles) abundant

This boundary is crucial for explaining the difference between rocky inner planets and icy outer planets.

### Stage 3: Planetesimal Formation

**Planetesimals** - small solid bodies (1-10 km) that formed from dust grains sticking together.

**Growth Process**:

1. **Electrostatic sticking** - tiny dust grains stuck together
2. **Collisional growth** - larger objects collided and merged
3. **Gravitational attraction** - once large enough (~1 km), gravity helped attract more material
4. **Runaway growth** - Larger objects grew faster (more gravity) and swept up nearby material

**Time to form**: ~100,000 years

This stage produced millions of planetesimals throughout the disk.

### Stage 4: Protoplanets Form

**Protoplanets** - Moon to Mars-sized bodies formed by planetesimals merging.

**Runaway Growth**:
- Larger planetesimals grew faster (more gravity)
- Swept up nearby material
- Often had similar orbits and collided

**Evidence**: Asteroids and comets are leftover planetesimals that never merged into planets.

### Stage 5: Formation of the Sun

At the center of the disk:

1. **Protostar phase** - contraction continued, temperature rose
2. **Fusion ignition** - when core reached ~15 million K, hydrogen fusion began
3. **T Tauri phase** - young Sun was very active, with strong solar wind
4. **Main sequence** - stable hydrogen burning that continues today

**Solar Wind** - The young Sun''s intense wind:
- Blew away remaining gas and dust
- Limited planet formation to first ~10 million years
- Explains why gas giants stopped growing

## Evidence Supporting the Nebular Theory

### 1. All Planets Orbit in Same Direction

All planets orbit the Sun counterclockwise (as viewed from north), in nearly the same plane.

### 2. All Planets Rotate in Same Direction

Most planets rotate in the same direction they orbit (exceptions: Venus, Uranus).

### 3. Composition Pattern

| Planet Type | Location | Composition |
|-------------|----------|-------------|
| **Terrestrial** | Inner solar system | Rock and metal |
| **Gas giants** | Outer solar system | Hydrogen and helium |
| **Ice giants** | Far outer solar system | Water, ammonia, methane ices |

This matches condensation temperatures from the nebula.

### 4. Meteorite Ages

All meteorites (except a few from Mars/Moon) date to 4.6 billion years - same age as solar system.

### 5. Observations of Other Systems

We''ve observed young stars surrounded by protoplanetary disks (e.g., HL Tau, TW Hydrae).

## The Early Solar System: Violent Times

For the first ~700 million years, planetesimal impacts were frequent:

- **Giant impacts** - Mercury hit hard (stripped mantle), Earth-Moon formed from impact
- **Late Heavy Bombardment** (~3.9 billion years ago) - spike in impacts, may have delivered water to Earth
- **Cratering record** - visible on Moon, Mercury, Mars

### Moon Formation

**Giant Impact Hypothesis**:

1. **Theia impact** - Mars-sized body struck early Earth
2. **Debris ejected** - formed ring around Earth
3. **Debris coalesced** - formed Moon within ~1 month
4. **Moon originally closer** - only ~20,000 km away (vs 384,000 km today)

**Evidence**:
- Moon composition similar to Earth''s mantle
- Moon lacks iron core
- Identical oxygen isotopes in Earth and Moon rocks
- Angular momentum conserved (Earth''s day lengthened from 5 to 24 hours)

## Why Are There Only 8 Planets?

### Clearing the Orbit

For a body to be a planet, it must clear its orbital neighborhood. This means:

- Planet''s gravity dominates its orbital zone
- No other similar-sized bodies share its orbit
- Either ejected or absorbed other objects

**Failed Planets**:
- **Ceres** (asteroid belt) - Jupiter''s gravity prevented it from clearing its orbit
- **Pluto** (Kuiper Belt) - many similar objects in Kuiper Belt
- **Eris** (scattered disk) - similar to Pluto

### The Asteroid Belt

Why no planet between Mars and Jupiter?

- **Jupiter''s gravity** - stirred up material, preventing accretion
- **Orbital resonances** - Jupiter''s gravity ejects objects in certain orbits
- **Total mass** - only ~4% of Moon''s mass

### The Kuiper Belt

Beyond Neptune, thousands of icy objects:
- Pluto, Eris, Haumea, Makemake (dwarf planets)
- Source region of short-period comets

## Timeline

| Time | Event |
|------|-------|
| 4.6 billion years ago | Solar nebula collapse begins |
| 4.59 billion years ago | Sun begins hydrogen fusion (main sequence) |
| 4.55 billion years ago | Terrestrial planets mostly formed |
| 4.5 billion years ago | Giant impact creates Moon |
| 4.5-3.9 billion years ago | Late Heavy Bombardment |
| 3.8 billion years ago | Life appears on Earth |
| Today | 8 planets, 5+ dwarf planets, continuous evolution |

## Comparative Planetology

Understanding solar system formation allows us to:

- **Predict properties** of planets based on location
- **Compare planets** to understand processes (e.g., why Venus is hot, Mars is cold)
- **Search for exoplanets** and predict their characteristics
- **Understand Earth''s uniqueness** and potential for life elsewhere

## Key Takeaways

1. Solar system formed from a collapsing gas/dust cloud 4.6 billion years ago
2. Temperature gradient determined composition: rocky planets inside, gas/ice giants outside
3. Planetesimals grew into protoplanets through collisions; asteroids/comets are leftovers
4. Young Sun''s solar wind cleared remaining gas, limiting planet formation
5. Giant impacts shaped early solar system (Moon formation, Late Heavy Bombardment)
6. Asteroid belt and Kuiper Belt are leftover building blocks; Jupiter''s gravity prevented planet formation there',
    '[
      {
        "question": "What is the frost line in the solar system?",
        "options": [
          "The boundary where liquid water exists on planets",
          "The division between the inner and outer planets",
          "The distance at which the Sun''s temperature is cold enough for water to freeze",
          "The orbit where comets are found"
        ],
        "correctAnswer": 1,
        "explanation": "The frost line (or snow line) at ~4 AU marks the boundary beyond which water ice could condense. Inside this line (closer to Sun), it was too hot for water ice to exist. Outside this line (farther from Sun), water ice (and other volatiles) could condense abundantly. This explains why inner planets are rocky and outer planets contain abundant ices."
      },
      {
        "question": "What were planetesimals?",
        "options": [
          "Early stars that formed in the early universe",
          "Small solid bodies that became planets",
          "Building blocks of planets that never fully formed",
          "The moons that formed the planets"
        ],
        "correctAnswer": 2,
        "explanation": "Planetesimals were small solid bodies (1-10 km) that formed from dust grains sticking together through electrostatic forces and collisions. They grew through gravitational attraction and mergers to become the building blocks of planets. Asteroids and comets are leftover planetesimals that never merged into planets."
      },
      {
        "question": "What is the giant impact hypothesis for Moon formation?",
        "options": [
          "Moon captured from elsewhere",
          "Moon split from early Earth",
          "Moon formed from same debris as Earth",
          "A Mars-sized body collided with early Earth"
        ],
        "correctAnswer": 3,
        "explanation": "The giant impact hypothesis proposes that a Mars-sized body struck early Earth, ejecting debris that formed a ring. This debris coalesced to form the Moon within about 1 month. The Moon and Earth share similar composition, supporting this theory."
      }
    ]',
    4,
    NOW()
  );

  -- Lesson 1.5: Comparative Planetology
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    uuid_generate_v4(),
    ch1_id,
    'Comparative Planetology',
    'comparative-planetology',
    'Learn how comparing planets helps us understand the processes that shape all worlds.',
    '# Comparative Planetology

## Introduction

**Comparative planetology** is the study of similarities and differences between planets to understand the processes that shape all worlds. By comparing planets, we can:

- Understand what processes are universal
- Learn why planets evolved differently despite starting with similar materials
- Predict what we might find on exoplanets
- Understand Earth''s past and future

## The Planet Classification System

### By Composition

| Planet Type | Examples | Key Characteristics |
|-------------|----------|---------------------|
| **Terrestrial** | Mercury, Venus, Earth, Mars | Rocky surfaces, thin/no atmospheres, small size |
| **Gas Giants** | Jupiter, Saturn | Mostly hydrogen/helium, no solid surface, large size |
| **Ice Giants** | Uranus, Neptune | Water/ammonia/methane ices, thick atmospheres, medium size |

### By Location

| Zone | Distance from Sun | Characteristics |
|------|------------------|-----------------|
| **Inner** | 0-2 AU | Hot, rocky planets |
| **Middle** | 2-4 AU | Asteroid belt |
| **Outer** | 4-30 AU | Gas and ice giants |
| **Extreme Outer** | >30 AU | Kuiper Belt objects |

### By Size/Mass

| Category | Mass (Earth = 1) | Radius (Earth = 1) |
|----------|---------------------|---------------|
| **Small** | <0.1 | <0.5 | Mercury, Moon, Pluto |
| **Earth-sized** | 0.1-10 | 0.5-2.0 | Venus, Earth, Mars |
| **Gas giant** | 10-500 | 3-11 | Jupiter, Saturn |
| **Brown dwarf** | 500-3000 | 11-15 | Failed stars |

## Fundamental Planetary Properties

### Density: Composition Clue

$$Density = \frac{Mass}{Volume}$$

| Planet | Density (g/cm³) | Composition Inferred |
|--------|----------------|---------------------|
| Mercury | 5.43 | Metal-rich (large iron core) |
| Venus | 5.24 | Rocky (similar to Earth) |
| Earth | 5.51 | Rock + metal core |
| Mars | 3.93 | Rocky (smaller core) |
| Jupiter | 1.33 | Gas/compressed hydrogen |

**What density tells us**:
- Density >3 g/cm³: Rocky planet
- Density <2 g/cm³: Gas/ice planet
- Density ~3 g/cm³: Mixed composition (rock + ice)

### Surface Gravity

$$g = \frac{GM}{R^2}$$

| Planet | Surface Gravity (m/s²) | % of Earth |
|--------|---------------------|-------------|
| Mercury | 3.7 | 38% |
| Venus | 8.87 | 90% |
| Earth | 9.8 | 100% |
| Mars | 3.71 | 38% |
| Jupiter | 24.79 | 254% |

**Effects of surface gravity**:
- Atmospheric retention (higher gravity = thicker atmosphere)
- Volcanic eruption style
- Impact crater shapes
- Ability to retain liquid water

### Escape Velocity

Minimum speed needed to escape a planet''s gravity:

$$v_e = \sqrt{\frac{2GM}{R}}$$

| Planet | Escape Velocity (km/s) |
|--------|----------------------|
| Mercury | 4.3 |
| Venus | 10.4 |
| Earth | 11.2 |
| Mars | 5.0 |
| Jupiter | 59.5 |

**Importance**:
- Determines what gases a planet can retain
- Controls difficulty of spacecraft launches
- Affects impact ejecta distribution

## Atmospheric Comparisons

### Why Do Atmospheric Compositions Differ?

| Planet | Main Components | Why? |
|--------|----------------|------|
| **Mercury** | Essentially none | Too small, hot, close to Sun |
| **Venus** | 96% CO₂, 3.5% N₂ | Thick CO₂ atmosphere creates runaway greenhouse |
| **Earth** | 78% N₂, 21% O₂ | Life produced O₂; liquid water absorbs CO₂ |
| **Mars** | 95% CO₂, 2.7% N₂ | Thin atmosphere due to low gravity, no magnetic field |
| **Jupiter** | 90% H₂, 10% He | Cold enough to retain hydrogen/helium |

### Atmospheric Pressure

| Planet | Surface Pressure (bars) | Relative to Earth |
|--------|----------------------|-------------------|
| Mercury | ~10⁻¹⁵ | Vacuum |
| Mars | 0.006 | 0.6% |
| Earth | 1.0 | 100% |
| Venus | 92 | 9,200% |

**Key factors controlling atmospheric thickness**:
1. **Gravity** - Higher gravity retains more gas
2. **Temperature** - Hotter molecules move faster, more likely to escape
3. **Magnetic field** - Protects atmosphere from solar wind stripping
4. **Geological activity** - Volcanoes add gases; weathering removes them

## Surface Feature Comparisons

### Impact Craters

Impact craters form on all solid surfaces, but are preserved differently:

| Body | Crater Preservation | Why? |
|------|-------------------|------|
| **Mercury** | Excellent | No atmosphere, no geological activity |
| **Moon** | Excellent | No atmosphere, no activity |
| **Venus** | Poor | Thick atmosphere burns up small objects, volcanic resurfacing |
| **Earth** | Very poor | Erosion, plate tectonics, vegetation, oceans |
| **Mars** | Good | Thin atmosphere, moderate erosion, some volcanic activity |

### Volcanism

| Planet | Volcanic Activity | Status |
|--------|------------------|--------|
| **Earth** | Active (Hawaii, Iceland) | Currently active |
| **Venus** | Extensive past activity | May still be active |
| **Mars** | Past activity (Olympus Mons) | Possibly dormant |
| **Mercury** | Past activity | Extinct |

### Tectonics

| Planet | Tectonic Style | Evidence |
|--------|---------------|----------|
| **Earth** | Plate tectonics | Earthquakes, mountain building, continental drift |
| **Venus** | No plate tectonics | Stagnant lid, volcanic resurfacing |
| **Mars** | No plate tectonics | Tharsis bulge, large volcanoes |
| **Mercury** | No plate tectonics | Scarps from global contraction |

## Magnetic Field Comparisons

### Planetary Magnetic Fields

| Planet | Magnetic Field | Origin |
|--------|-------------------|--------------|
| **Earth** | Strong (1 gauss at surface) | Liquid outer core convection + rotation ✓ |
| **Mercury** | Weak (~1% of Earth) | Partially liquid core, slow rotation |
| **Venus** | None | Too slow rotation, core convection uncertain |
| **Mars** | None (crustal only) | Core solidified, no convection |
| **Jupiter** | Very strong (10× Earth at cloud tops) | Metallic hydrogen + rapid rotation ✓ |

**Requirements for a magnetic field**:
1. Electrically conducting fluid (liquid metal)
2. Convection in that fluid
3. Rotation to organize the convective motions

**Why magnetic fields matter**:
- Protect atmosphere from solar wind stripping
- Deflect charged particles (radiation protection)
- Create auroras - beautiful light shows near poles
- Trap particles - forming radiation belts

## Why Are Planets Different?

### Initial Conditions

- **Distance from Sun** determined initial temperature
- **Available materials** varied with distance (rock vs ice)
- **Size** affected ability to retain atmosphere and generate heat

### Evolutionary Paths

| Planet | Key Evolutionary Difference |
|--------|----------------------------|
| **Venus** | Runaway greenhouse → boiling oceans, thick CO₂ atmosphere |
| **Earth** | Liquid water → CO₂ absorbed → moderate greenhouse → life |
| **Mars** | Lost magnetic field → atmosphere stripped → liquid water lost |

### Feedback Loops

**Venus - Runaway Greenhouse**:
1. Slightly closer to Sun → warmer
2. Water evaporated → more H₂O vapor (greenhouse gas)
3. More warming → more evaporation (positive feedback)
4. Result: Thick CO₂ atmosphere, surface temperature 465°C

**Earth - Thermostat Effect**:
1. Volcanoes release CO₂ (warming)
2. Weathering removes CO₂ (cooling)
3. Temperature regulation through carbon cycle

**Mars - Death by Cooling**:
1. Smaller size → cooled faster
2. Magnetic field died
3. Solar wind stripped atmosphere
4. Liquid water evaporated or froze

## The Drake Equation: Looking Beyond

Comparative planetology helps estimate the number of civilizations:

$$N = R_* × f_p × n_e × f_l × f_i × f_c × L$$

Where:
- $N$ = number of communicative civilizations
- $R_*$ = star formation rate
- $f_p$ = fraction of stars with planets
- $n_e$ = average planets per star capable of supporting life
- $f_l$ = fraction where life actually develops
- $f_i$ = fraction where intelligent life evolves
- $f_c$ = fraction that develop communication technology
- $L$ = lifetime of communicative phase

By studying planets in our solar system, we can better estimate these values.

## Key Takeaways

1. Planets can be classified by composition, location, and size
2. Physical properties (density, gravity, escape velocity) reveal internal composition
3. Atmospheric composition depends on size, temperature, and magnetic field
4. Surface processes (cratering, volcanism, tectonics) vary based on planetary characteristics
5. Small differences in initial conditions can lead to dramatically different outcomes
6. Comparative planetology helps us understand exoplanets and search for life',
    '[
      {
        "question": "What does a planet''s density tell us?",
        "options": [
          "Only its mass",
          "Only its radius",
          "Both mass and radius (g = GM/R²)",
          "The planet\'s age"
        ],
        "correctAnswer": 2,
        "explanation": "Surface gravity is determined by g = GM/R², where G is the gravitational constant, M is the planet\'s mass, and R is the planet\'s radius. Both mass and radius together determine surface gravity. Density reveals internal composition: >3 g/cm³ indicates rocky planets, <2 g/cm³ indicates gas/ice planets."
      },
      {
        "question": "Why does Venus have a thick CO₂ atmosphere while Earth has a nitrogen-oxygen atmosphere?",
        "options": [
          "Venus is larger",
          "Runaway greenhouse and lack of water absorption of CO₂",
          "Venus has more volcanic activity",
          "Venus has more nitrogen"
        ],
        "correctAnswer": 1,
        "explanation": "Venus experienced runaway greenhouse where being slightly closer to Sun caused water to evaporate. This created thick CO₂ atmosphere that trapped heat. Without liquid water to absorb CO₂ through weathering, CO₂ built up in atmosphere. Earth\'s liquid water absorbs CO₂, and life later produced oxygen."
      },
      {
        "question": "What is required for a planet to generate a magnetic field?",
        "options": [
          "Solid iron core only",
          "Liquid iron core, convection, and rotation",
          "Thick atmosphere",
          "Active volcanoes"
        ],
        "correctAnswer": 1,
        "explanation": "Magnetic fields require: (1) electrically conducting fluid (like liquid iron), (2) convection in that fluid to move it, and (3) rotation to organize the convection. This explains why Earth has a strong field but Venus does not."
      }
    ]',
    5,
    NOW()
  );

END $$;