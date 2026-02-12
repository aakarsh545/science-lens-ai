-- =====================================================
-- ASTRONOMY COURSE
-- Topics: Solar System, Stars, Galaxies, Cosmology
-- Difficulty: Beginner
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Astronomy
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Astronomy',
  'astronomy',
  'Study the universe beyond Earth: our solar system, stars and galaxies, stellar evolution, and cosmology. Learn how astronomers observe and understand the cosmos.',
  'science',
  'beginner',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: EARTH'S PLACE IN THE UNIVERSE
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'Earth's Place in the Universe',
  'earth-place-universe',
  'Understand Earth\"s position in the solar system, its motions, and how we observe and map our cosmic neighborhood.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-place-universe' LIMIT 1),
  'Introduction to Astronomy',
  'introduction-astronomy',
  1,
  '# Introduction to Astronomy

## What Is Astronomy?

**Astronomy**: Scientific study of the universe beyond Earth\"s atmosphere.

**Tools**:
- Telescopes (observe light from space)
- Spectrometers (analyze light to determine composition)
- Space probes (explore solar system)
- Satellites (observe Earth, communications)
- Mathematics and physics

## Branches of Astronomy

**Observational astronomy**: Gathering data about celestial objects

**Theoretical astronomy**: Using physics to explain observations

**Astrophysics**: Physics of the universe (black holes, Big Bang)

**Cosmology**: Origin and evolution of the universe

## Why Study Astronomy?

**Understanding our place** in the universe
- Search for life elsewhere
- Learn Earth\"s history and future
- Appreciate cosmic perspective

## Scale of the Universe

**Observable universe**: ~93 billion light-years across

**Contents**:
- ~5% ordinary matter
- ~27% dark matter
- ~68% dark energy

## Historical Development

| Era | Key Developments |
|------|-------------------|
| Ancient (3000 BCE-1600 CE) | Geocentric model, celestial observations |
| Renaissance (1543-1687) | Heliocentric model, telescope invention |
| Modern (1687-present) | Gravity, relativity, Big Bang, space telescopes |

## Sources
- CK-12 Earth Science: "Astronomy"
- Khan Academy: "Introduction to Astronomy"
- OpenStax Astronomy: "The Solar System"
- NASA: "Earth Observatory"
',

  '[
    {
      "question": "What is the main difference between observational and theoretical astronomy?",
      "options": ["Observational uses telescopes to gather data, theoretical uses mathematical models", "Observational is about looking at the sky, theoretical is about explaining what we see", "Observational can be done by anyone, theoretical requires advanced mathematics"],
      "correctAnswer": 1,
      "explanation": "OBSERVATIONAL ASTRONOMY involves gathering data about celestial objects using telescopes and other instruments - just LOOKING and recording. THEORETICAL ASTRONOMY uses physics and mathematics to EXPLAIN observations and make predictions about how the universe works. Anyone can observe; theoretical requires understanding of complex math and physics to develop models!"
    },
    {
      "question": "What is the estimated composition of the universe?",
      "options": ["75% dark energy, 27% ordinary matter, 5% dark matter"], ["68% dark energy, 5% ordinary matter, 27% dark matter"],
      "correctAnswer": 1,
      "explanation": "Current estimates suggest the universe is approximately: 5% ordinary matter (stars, gas, dust), 27% DARK MATTER (unknown substance), 68% DARK ENERGY (even more mysterious than dark matter), and 5% normal matter (neutrinos and antineutrinos). This means 95% of the universe is composed of substances we don\"t fully understand. Dark matter and dark energy together make up ~73% of the universe!"
    },
    {
      "question": "What was the geocentric model proposed in ancient times?",
      "options": ["Earth-centered model with all celestial bodies orbiting Earth", "Sun-centered model with planets orbiting the Sun", "Both Earth and Sun orbiting around a center point in space"],
      "correctAnswer": 0,
      "explanation": "The GEOCENTRIC MODEL dominated ancient Greek astronomy - Earth was believed to be the unmoving center of the universe with all celestial bodies (Sun, Moon, planets, stars) orbiting around IT. This model explained planetary motions (retrograde motion) but couldn\"t explain Mercury\"s strange orbit. Later, COPERNICUS and HELIOCENTRIC models placed the Sun at the center, which better matched observations!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-place-universe' LIMIT 1),
  'Earth's Motions and Rotation',
  'earth-motions-rotation',
  'Explore how Earth moves through space and rotates on its axis, creating day and night, seasons, and years.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-motions-rotation' LIMIT 1),
  'Earth's Rotation',
  'earth-rotation',
  2,
  '# Earth's Rotation

## What Causes Earth's Rotation?

**Gravitation**: Pulls material toward Earth's center.

**Conservation of angular momentum**: L = constant

$$L = I \omega$$

## Rotation Speed

**At equator**: 1,670 km/hr (1,670 km/surface speed)
**Speed at poles**: Much lower (due to smaller circumference)

## Evidence of Rotation

### Foucault Pendulum

**1851 Foucault**: Massive swinging pendulum demonstrated Earth's rotation.

$$T = 2\pi\sqrt{\frac{L}{g}}$$

**Challenges**: Maintaining 27 kg mass over 100m wire

### Coriolis Effect

**Apparent deflection**: Moving objects appear curved.

$$F = 2mv\Omega \sin(\phi)$$

**Direction**: Rightward in Northern Hemisphere, leftward in Southern.

### Day and Night

**Solar day**: ~12 hours long (varies by season).

**Sidereal day**: 23 hours 56 minutes (time to rotate 360°).

## Latitude and Rotation

**Equatorial bulge**: Earth's diameter is ~43 km wider at equator.

**Oblate spheroid**: Earth is not a perfect sphere.

## Leap Seconds

**Atomic clocks**: Need adjustment over time.

## Sources
- CK-12 Earth Science: "Earth's Place in the Universe"
- Khan Academy: "Rotation of the Earth"
- NASA: "Earth Observatory"
',

  '[
    {
      "question": "What evidence proves Earth rotates from west to east?",
      "options": ["Rising and setting constellations appear to move west", "Foucault pendulum demonstrates eastward rotation", "The sun appears to rise in the east and set in the west"],
      "correctAnswer": 1,
      "explanation": "The FOUCAULT PENDULUM (1851) provided first clear evidence of eastward rotation - the heavy pendulum appeared to swing eastward with the motion of Earth. This was a major triumph for physics and confirmed Earth\"s rotation direction. Now we use atomic clocks, GPS satellites, and very long-baseline interferometry to measure rotation precisely!"
    },
    {
      "question": "Why is a solar day not exactly 24 hours?",
      "options": ["Earth rotates at different speeds at different latitudes", "Earth's orbit is elliptical, not perfectly circular", "Earth's axis is tilted changing rotation speed throughout the year"],
      "correctAnswer": 2,
      "explanation": "Several factors combine to make solar day length vary throughout the year: 1) Earth\"s axis is TILTED 23.5° from orbital plane, creating different rotation speeds, 2) Earth\"s ORBIT is elliptical (not a perfect circle), so orbital speed varies (Kepler\"s laws), 3) This tilt creates seasonal changes in daylight length. Combined effects can make solar days range from about 10 hours in winter to 14 hours in summer!"
    },
    {
      "question": "What is the Coriolis effect?",
      "options": ["The deflection of moving objects due to Earth's rotation", "The apparent force on moving objects caused by latitude and rotation", "The way Earth's spheroid shape affects moving objects"],
      "correctAnswer": 1,
      "explanation": "The CORIOLIS EFFECT is an apparent deflection of moving objects caused by Earth\"s rotation beneath them. In the Northern Hemisphere, deflection is to the RIGHT (following the direction of rotation). In the Southern Hemisphere, deflection is to the LEFT. This effect is strongest at the equator and nonexistent at the poles. It explains why projectiles don\"t always travel perfectly straight!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-motions-rotation' LIMIT 1),
  'Earth's Orbit and Moon',
  'earth-orbit-moon',
  'Study the Moon, its phases, eclipses, and how Earth and Moon dance together in space.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-orbit-moon' LIMIT 1),
  'The Moon',
  'moon',
  1,
  '# The Moon

## Physical Characteristics

**Diameter**: 3,474 km (about 27% of Earth's)

**Mass**: $$7.35 \times 10^{22}$$ kg (1.2% of Earth)

**Gravity**: 1/6 of Earth's (0.165 g or 1.62 m/s²)

**Density**: 3.34 g/cm³ (similar to Mars)

**Atmosphere**: Exosphere (negligible gas), essentially no atmosphere

## Formation Theories

**Giant Impact Hypothesis**: Mars-sized body struck early Earth, debris formed Moon.

**Capture Theory**: Earth's gravity captured passing asteroid.

**Synchrotronis**: Moon formed in Earth orbit (same time as Earth).

## Lunar Surface Features

**Maria**: Dark basaltic plains (Moon's face).

**Highlands**: Lighter-colored, heavily cratered terrain.

**Craters**: Tycho, Copernicus, Kepler, etc.

## Phases of the Moon

$$\text{New Moon} \rightarrow \text{Waxing Crescent} \rightarrow \text{First Quarter} \rightarrow \text{Full Moon} \rightarrow \text{Last Quarter} \rightarrow \text{Waning Crescent}$$

**New Moon**: Not visible (in Sun's glare)
**Waxing Crescent**: Increasingly illuminated
**Full Moon**: Fully illuminated face
**Last Quarter**: Decreasing illumination

## Orbit

**Distance**: 384,400 km from Earth (average)

**Period**: 27.3 days (sidereal month)

**Synchronous rotation**: Same face always toward Earth

## Sources
- CK-12 Earth Science: "Earth's Place in the Universe"
- Khan Academy: "The Moon"
- NASA: "Lunar Reconnaissance Orbiter"
',

  '[
    {
      "question": "What is the most widely accepted theory for the Moon's origin?",
      "options": ["The Moon was captured by Earth's gravity", "A Mars-sized body impacted Earth ejecting debris that formed the Moon", "The Moon formed from Earth's debris after a giant impact", "The Moon and Earth formed at the same time from the solar nebula"],
      "correctAnswer": 2,
      "explanation": "The CAPTURE THEORY suggests a Mars-sized asteroid struck early Earth with such force that DEBRIS EJECTED into space. This debris COALESCED under Earth\"s gravity to form the Moon in orbit. This theory explains why Moon rocks are similar to Earth rocks (same oxygen isotopes) and why the Moon has no iron core (it formed from Earth\"s outer crust)!"
    },
    {
      "question": "What is synchronous rotation?",
      "options": ["The Moon rotating at different speeds than Earth", "The Moon showing the same face to Earth always", "The Moon taking exactly 27.3 days to complete one rotation"],
      "correctAnswer": 1,
      "explanation": "SYNCHRONOUS ROTATION means the Moon takes the SAME AMOUNT OF TIME (27.3 days) to complete one rotation on its axis. This happens because the Moon\"s ROTATION PERIOD matches its ORBITAL PERIOD. The Moon always shows the SAME FACE to Earth because it rotates at the same rate it orbits. This is why we always see the same side of the Moon!"
    },
    {
      "question": "What causes a total solar eclipse?",
      "options": ["When Moon is directly between Earth and Sun", "When Moon passes into Earth's shadow", "When Moon is too far from Earth to fully block the Sun", "When Moon is at apogee (farthest from Earth)"],
      "correctAnswer": 2,
      "explanation": "A TOTAL SOLAR ECLIPSE occurs when the Moon passes DIRECTLY BETWEEN Earth and the Sun (blocking sunlight), casting its shadow on Earth. The Moon's UMBRA appears completely dark during totality. PARTIAL ECLIPSES occur when the Moon only partially covers the Sun or enters Earth's penumbra (partial shadow) without blocking sunlight completely!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'earth-orbit-moon' LIMIT 1),
  'The Solar System',
  'solar-system',
  'Study our Sun and its family of planets: inner rocky planets, gas giants, ice giants, dwarf planets, and objects in the Kuiper belt and beyond.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'solar-system' LIMIT 1),
  'The Sun',
  'sun',
  1,
  '# The Sun

## Our Nearest Star

**Type**: G-type main-sequence star (yellow dwarf).

**Distance**: 149.6 million km (8.3 light-minutes)

**Size**: 1.4 million km diameter (109 times Earth)

**Energy source**: Nuclear fusion (hydrogen → helium).

## Structure of the Sun

### Core

**Temperature**: 15 million °C at core (27 million °C at surface).

**Radiative zone**: Energy transport through radiation.

### Photosphere

**Visible surface**: Granular texture (pattern of bright cells).

**Chromosphere**: Colorful shell (turbulent plasma).

### Corona

**Outer atmosphere**: Extremely hot (1-3 million °C).

**Solar wind**: Stream of charged particles.

## Solar Activity

### Nuclear Fusion

$$4\text{H} \rightarrow \text{He}}^{4+}$$

**Energy release**: E = mc²

**Mass conversion**: 4 million tons of hydrogen → 1 unit of energy.

### Sunspots and Solar Cycle

**Sunspots**: Dark, cooler regions (magnetic activity).

**11-year cycle**: Sunspot maxima and minima.

**Maunder Minimum**: Period of low solar activity (1645-1715).

## Magnetic Fields

**Dynamo effect**: Moving electric charges create magnetic fields.

**Solar flares**: Eruptions of plasma and radiation.

**Solar prominences**: Loops of gas extending into space.

## Sources
- CK-12 Earth Science: "The Solar System"
- Khan Academy: "The Sun"
- NASA: "Solar Dynamics Observatory"
',

  '[
    {
      "question": "What is the source of the Sun's energy?",
      "options": ["Nuclear fusion of uranium into iron", "Nuclear fusion of hydrogen into helium", "Gravitational collapse of a massive gas cloud", "Burning of fossil fuels and wood"],
      "correctAnswer": 1,
      "explanation": "The Sun's energy source is NUCLEAR FUSION in its core, where hydrogen nuclei combine to form HELIUM. This process releases enormous energy according to E = mc². In main-sequence stars like our Sun, hydrogen fuses to form helium (the second most abundant element). This differs from earlier stars that burned through gravitational contraction of hydrogen fuel!"
    },
    {
      "question": "What are sunspots?",
      "options": ["Giant explosions on the Sun", "Cooler, darker regions on the photosphere", "Magnetic storms that affect Earth's magnetic field", "Areas of intense magnetic activity"],
      "correctAnswer": 1,
      "explanation": "SUNSPOTS are temporary dark, COOLER regions on the Sun\"s surface caused by INTENSE MAGNETIC ACTIVITY. They appear dark because they\"re cooler (3,000-4,500°F vs surrounding 5,800°F photosphere). Magnetic fields inhibit convective heat transport, allowing plasma to cool and darken. These are associated with SOLAR FLARES and can affect Earth\"s magnetic field and communications!"
    },
    {
      "question": "What is the solar cycle?",
      "options": ["The daily rotation of the Sun", "The 11-year sunspot cycle", "The orbit of Earth around the Sun", "The period between solar maximums"],
      "correctAnswer": 1,
      "explanation": "The SOLAR CYCLE lasts approximately 11 YEARS, marked by increasing and decreasing numbers of SUNSPOTS. The cycle begins with SOLAR MINIMUM (few sunspots) and builds to SOLAR MAXIMUM (hundreds of sunspots). Then sunspots decrease and the cycle ends. This roughly 11-year period affects space weather and can impact Earth\"s climate when sustained!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'solar-system' LIMIT 1),
  'The Inner Planets',
  'inner-planets',
  'Learn about the terrestrial planets closest to the Sun: Mercury, Venus, Earth, and Mars - their formation, atmospheres, surfaces, and unique features.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'inner-planets' LIMIT 1),
  'Mercury',
  'mercury',
  1,
  '# Mercury

## Physical Characteristics

**Distance from Sun**: 0.39 AU (58 million km)

**Orbital period**: 88 days (fastest planet)

**Diameter**: 4,879 km (0.38 × Earth)

**Day length**: 176 Earth days (rotation period 59 days)

**Gravity**: 0.38 g (3.7 m/s²)

**Temperature**: -180°C to 430°C (-290°F to 806°F)

**Moons**: None

## Surface Features

**Craters**: Caloris Basin (huge impact crater)

**Surface**: Ancient, heavily cratered

**Atmosphere**: Exosphere only (negligible gas, sodium, potassium, oxygen)

## Why So Extreme?

**Formation**: Closest to Sun, only remaining rocky planet.

**Loss of atmosphere**: Solar wind stripped away lightweight gases (hydrogen, helium).

**Tidal locking**: Same face always points toward Sun (1:1 resonance).

**Compressed core**: Large iron core, still partially molten.

## Sources
- CK-12 Earth Science: "Mercury"
- Khan Academy: "The Solar System"
- NASA: "Solar System Exploration"
',

  '[
    {
      "question": "Why does Mercury have such extreme temperature variations?",
      "options": ["No atmosphere to retain heat", "Slow rotation gives one side extended periods of extreme heat and cold", "Thin atmosphere allows heat to escape into space at night", "Large iron core has cooled and solidified"],
      "correctAnswer": 1,
      "explanation": "Mercury's temperature extremes result from: 1) LACK OF SUBSTANTIAL ATMOSPHERE - virtually no gases to trap heat or distribute temperature, 2) VERY SLOW ROTATION (59 days) creating long days/night cycles with extreme heating and cooling, 3) THIN ATMOSPHERE allows heat to escape into space during nights. These combine to create 800°F temperature swings from sunlit to shaded sides!"
    },
    {
      "question": "What is the Caloris Basin?",
      "options": ["A region of smooth plains on Mercury", "The largest volcanic crater on Mercury", "A basin of ancient lava flows", "The most heavily cratered region on Mercury"],
      "correctAnswer": 0,
      "explanation": "The CALORIS BASIN is a large, smooth plain on Mercury - about 1,500 km across. It was formed by a MASSIVE IMPACT around 3.9 billion years ago that created one of Mercury\"s largest craters (about 1,550 km diameter). This basin is named for Johann Gottlob Kaloris and appears as bright, relatively smooth terrain surrounding the Caloris Mountains!"
    },
    {
      "question": "What is Mercury's 1:1 spin-orbit resonance?",
      "options": ["Its rotation and orbit are synchronized", "Mercury rotates exactly 3 times for every 2 orbits around the Sun", "The same hemisphere always faces the Sun due to tidal locking"],
      "correctAnswer": 1,
      "explanation": "Mercury is TIDALLY LOCKED - its rotation period (59 days) is exactly 2/3 of its orbital period (88 days). This means the SAME HEMISPHERE always faces the Sun! Mercury rotates three times during each of its years, and every time it returns to the same position relative to Earth-Sun line. This unique resonance occurs because Mercury\"s orbit is quite eccentric (elliptical)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'inner-planets' LIMIT 1),
  'Venus',
  'venus',
  2,
  '# Venus

## Physical Characteristics

**Distance from Sun**: 0.72 AU (108 million km)

**Orbital period**: 225 days

**Diameter**: 12,104 km (0.95 × Earth)

**Day length**: 117 Earth days (retrograde rotation)

**Gravity**: 0.90 g (8.87 m/s²)

**Temperature**: 462°C average (cloud tops 480°C)

**Atmosphere**: Very dense, 92 times Earth's air pressure

## Greenhouse Effect

**Runaway greenhouse effect**: Surface temperature of 470°C makes Venus hottest planet.

**Atmospheric pressure**: Crushingly dense CO₂ atmosphere (95 bar).

**Why so hot?**
1. Closest to Sun (0.72 AU)
2. Thick CO₂ atmosphere traps heat
3. Slow rotation (117 days) - heat distributes evenly

## Surface Features

**Volcanoes**: Extensive volcanic plains (70% of surface).

**Coronae**: Young (no plate tectonics).

**Craters**: Not visible (hidden by clouds).

## Retrograde Rotation

**Clockwise**: Spins opposite to other planets (Sun rises in west).

**Longest day**: 243 Earth days (slowest rotation).

## Sources
- CK-12 Earth Science: "Venus"
- Khan Academy: "The Solar System"
- NASA: "Magellan (Venus)"
',

  '[
    {
      "question": "Why is Venus the hottest planet?",
      "options": ["Because it rotates fastest", "Thick CO₂ atmosphere traps heat effectively", "It has the most active volcanoes in the solar system", "It's closest to the Sun and receives most solar radiation"],
      "correctAnswer": 1,
      "explanation": "Venus is the HOTTEST planet due to RUNAWAY GREENHOUSE EFFECT created by its thick CO₂ atmosphere (92 times Earth\"s pressure) combined with proximity to Sun. The dense clouds trap heat so effectively it cannot escape. Venus is 0.72 AU from the Sun and receives about 2× more solar radiation than Earth. This creates surface temperatures of 470°C (880°F) - hot enough to melt lead!"
    },
    {
      "question": "What makes Venus rotate backwards compared to other planets?",
      "options": ["Its thick atmosphere creates more drag on one side", "A massive impact in its early history changed its rotation", "It has no moon to slow down its rotation through tidal effects"],
      "correctAnswer": 2,
      "explanation": "Most theories suggest a MASSIVE IMPACT early in Venus\"s history changed its rotation direction. Unlike other planets, Venus has NO MOON to create tidal drag that would slow its rotation. This mysterious event, combined with Venus\"s thick atmosphere (which could create drag), reversed its rotation to RETROGRADE (clockwise when viewed from above). The impact was so great it overwrote Venus\"s early rotation direction!"
    },
    {
      "question": "What is unique about Venus's surface compared to other planets?",
      "options": ["Its surface is completely hidden beneath thick clouds", "It has the most recent surface features due to active volcanism", "Its surface age is uniform and very young compared to other planets"],
      "correctAnswer": 0,
      "explanation": "Venus\"s surface is COMPLETELY HIDDEN from view by a thick layer of sulfuric acid clouds (12-25 km thick). We cannot see the surface directly from space - only radar mapping through clouds reveals the topography. The surface is also very YOUNG and ACTIVE due to EXTENSIVE VOLCANISM that constantly resurfaces the planet. Erosion rates on Venus are similar across the entire surface, making it appear uniformly young geologically!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'inner-planets' LIMIT 1),
  'Earth',
  'earth',
  3,
  '# Earth

## Physical Characteristics

**Type**: Terrestrial planet

**Distance from Sun**: 1.00 AU (definition)

**Orbital period**: 365.256 days (1 sidereal year)

**Diameter**: 12,742 km (3.67 × Moon)

**Gravity**: 9.8 m/s² (1 g)

**Atmosphere**: 78% nitrogen, 21% oxygen, 0.93% argon

**Moons**: 1 (Luna)

**Magnetic field**: Protects from solar wind

## Structure

### Layers

**Crust**: 5-50 km thick (continental ~35 km, oceanic ~5-10 km)

**Mantle**: 2,900 km thick (mostly solid silicate rocks)

**Outer core**: Liquid (iron-nickel alloy)
- **Inner core**: Solid iron-sulfur

**Density**: 5.51 g/cm³

## Plate Tectonics

**Lithosphere**: Crust + uppermost mantle (rigid).

**Asthenosphere**: Viscous, convection currents.

### Continental vs Oceanic Crust

**Continental**: Thicker, older (3-4 billion years)

**Oceanic**: Thinner, younger (200 million years)

## Sources
- CK-12 Earth Science: "Earth"
- Khan Academy: "Plate Tectonics"
- NASA: "Earth Observatory"
',

  '[
    {
      "question": "What is Earth's magnetic field generated by?",
      "options": ["Solar wind", "The liquid iron outer core moving", "Electric currents in the mantle", "Rotation of the solid inner core"],
      "correctAnswer": 1,
      "explanation": "The GEODYNAMO EFFECT creates Earth\"s magnetic field: MOVEMENT OF MOLTEN IRON and NICKEL ALLOY in the outer core generates electric currents. Meanwhile, convection in the mantle (circulating hot rock) and the rotation of the SOLID INNER CORE both contribute to magnetic field generation. This DYNAMO effect maintains our atmosphere against harmful solar radiation!"
    },
    {
      "question": "What is the theory of continental drift?",
      "options": ["Continents move slowly due to thick crust", "The mantle has convection currents that drag the continents", "Earth is expanding as magma rises at mid-ocean ridges"],
      "correctAnswer": 0,
      "explanation": "The THEORY OF CONTINENTAL DRIFT (proposed by Alfred Wegener in 1912) suggests that CONTINENTS move slowly because they\"re attached to THICKER, less dense continental crust (~35-50 km thick) compared to thinner oceanic crust (~5-10 km). Convection currents in the viscous mantle may drag the continents. New crust forms at mid-ocean ridges, not expanding Earth\"s surface. This theory explains fossil distributions and matching coastlines!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'inner-planets' LIMIT 1),
  'Mars',
  'mars',
  4,
  '# Mars

## Physical Characteristics

**Distance from Sun**: 1.52 AU (228 million km)

**Orbital period**: 687 Earth days (1.88 Earth years)

**Diameter**: 6,779 km (0.53 × Earth)

**Day length**: 24 hours 37 minutes (rotation period)

**Gravity**: 3.72 m/s² (0.38 g)

**Temperature**: -63°C average (varies -140°F to 68°F at equator)

**Atmosphere**: Thin, mostly CO₂ (95.3% pressure)

**Moons**: 2 (Phobos and Deimos)

## Red Planet

**Iron oxide** gives rust color.

**Dust storms**: Can cover entire planet.

**Volcanoes**: Olympus Mons (21.9 km high) - largest volcano in solar system.

## Water on Mars?

### Past Evidence

**Polar ice caps**: Frozen water at poles.

**River valleys**: Ancient water flow features.

**Possible lakes**: Ancient shorelines.

### Current Mars

**Thin atmosphere**: 0.006 bar (vs Earth's 1 bar).

**Liquid water**: Underground reservoirs?

**Perchlorates**: Soil chemicals toxic to life.

## Colonization Prospects

**Similar day length**: 24h 37m (close to Earth)

**Gravity**: 38% of Earth (easier landing).

**Resources**: Iron, CO₂ for fuel, water ice.

## Sources
- CK-12 Earth Science: "Mars"
- Khan Academy: "The Solar System"
- NASA: "Mars Exploration Program"
',

  '[
    {
      "question": "Why is Mars red?",
      "options": ["Because it has high iron oxide content", "Due to dust storms with iron particles", "Because of ancient water rusting on surface", "Because its thin atmosphere scatters blue light"],
      "correctAnswer": 0,
      "explanation": "Mars appears RED because of iron oxide (rust)遍布 its surface. Dust storms also carry fine iron particles that settle and oxidize rocks. The combination of REDDISH soil (iron oxides) and blue-scattering thin atmosphere creates the salmon-colored appearance. Future astronauts visiting Mars would see a rusty landscape!"
    },
    {
      "question": "What is Olympus Mons?",
      "options": ["The highest mountain on Mars", "A large ancient volcanic crater", "The largest volcano in the solar system by volume", "A shield volcano protecting nearby areas"],
      "correctAnswer": 2,
      "explanation": "OLYMPUS MONS is the largest volcano in the solar system by VOLUME - about 3× the height of Mount Everest! It is a SHIELD VOLCANO that towers 21.9 km (72,000 feet) above Mars\" surface. Despite being on Mars for billions of years, it shows evidence of relatively recent activity (last erupted ~25 million years ago). Unlike explosive Earth volcanoes, Olympus Mons has gently sloping flanks due to lower Mars gravity!"
    },
    {
      "question": "What evidence suggests Mars once had liquid water?",
      "options": ["Ancient river deltas and lake shorelines", "Polar ice caps", "Rover discoveries of hydrated minerals", "The presence of minerals that only form in water"],
      "correctAnswer": 3,
      "explanation": "Multiple lines of evidence suggest Mars once had LIQUID WATER: 1) ANCIENT RIVER VALLEYS visible from orbit (dried river channels), 2) POLAR ICE CAPS at north and south poles (frozen water reservoir), 3) ROVERS have discovered MINERALS like gypsum and clays that only form in the presence of water, 4) SEDIMENTARY LAYERS suggest ancient lake beds. Mars appears to have had a water-rich past before losing most of its atmosphere to space weathering!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'inner-planets' LIMIT 1),
  'The Gas Giants and Ice Giants',
  'gas-giants-ice-giants',
  'Explore Jupiter, Saturn, Uranus, Neptune and their moon systems, plus the distant Kuiper belt objects and the dwarf planets.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'gas-giants-ice-giants' LIMIT 1),
  'Jupiter',
  'jupiter',
  1,
  '# Jupiter

## Physical Characteristics

**Distance from Sun**: 5.20 AU (778 million km)

**Orbital period**: 11.86 Earth years

**Diameter**: 139,820 km (11.2 × Earth)

**Day length**: 9.9 hours (fastest rotating planet).

**Gravity**: 24.8 m/s² (2.54 g)

**Atmosphere**: Hydrogen, helium, methane, ammonia.

**Magnetic field**: Strongest (20 × Earth's).

**Temperature**: Cloud tops: -145°C (110 K at 1 bar).

**Moons**: 95 known moons (4 large Galilean: Io, Europa, Ganymede, Callisto).

## The Great Red Spot

**Giant storm**: Larger than Earth (1.3 × Earth diameter).

**Anticyclone**: High-pressure storm system.

**Duration**: Has raged for over 300 years (may be permanent).

## Internal Structure

**Differentiation**: Core, mantle, molecular hydrogen layer.

**Metallic hydrogen**: Deep interior may have metal hydrogen (creates magnetic field).

## Sources
- CK-12 Earth Science: "Jupiter"
- Khan Academy: "The Solar System"
- NASA: "Juno Mission"
',

  '[
    {
      "question": "What is the Great Red Spot?",
      "options": ["A permanent storm in Jupiter's atmosphere", "A giant hurricane that has lasted for hundreds of years", "A volcanic hot spot on Jupiter's surface", "An opening in Jupiter's cloud cover allowing heat to escape"],
      "correctAnswer": 0,
      "explanation": "The GREAT RED SPOT is a GIANT ANTICYCLONIC STORM - a persistent high-pressure system in Jupiter\"s atmosphere. It is an OVAL-shaped storm larger than Earth (1.3× our planet\"s diameter) that has raged for OVER 300 YEARS and may be PERMANENT. Unlike hurricanes (which feed off warm oceans), the Great Red Spot is powered by Jupiter\"s internal heat and is confined to a specific latitude region. It\"s anticyclonic features give it incredible longevity!"
    },
    {
      "question": "Why does Jupiter have a strong magnetic field?",
      "options": ["Because it has a solid iron core", "Because of its rapid rotation period creating a dynamo effect", "Due to metallic hydrogen in its interior", "Because it has electrically charged metallic hydrogen oceans in its atmosphere"],
      "correctAnswer": 3,
      "explanation": "Jupiter\"s magnetic field is STRONGEST in the solar system (20× Earth\"s). This is likely due to: 1) Metallic HYDROGEN DYNAMO in Jupiter\"s interior from high pressure creating electric currents, or 2) DEEP INTERIOR may contain METALLIC HYDROGEN (conducting fluid). Additionally, Jupiter\"s FAST ROTATION (9h 55m) coupled with convection in conducting metallic hydrogen could generate a self-sustaining dynamo effect far stronger than Earth\"s field!"
    },
    {
      "question": "What is Jupiter's moon Io known for?",
      "options": ["Being the most volcanically active body in the solar system", "Having the youngest surface in the solar system", "Being covered in sulfur ice and having extreme tidal heating"],
      "correctAnswer": 0,
      "explanation": "IO is the most VOLCANICALLY ACTIVE body in the solar system with over 400 active volcanoes! Tidal heating from Jupiter\"s immense gravity creates internal friction, melting sulfur and rock below the surface. This drives SILICA LAVAS that create spectacular volcanic eruptions with plumes 300 km high. Jupiter\"s tidal forces flex Io\"s crust, creating heat and generating the LAVA-LIKE surface features we observe!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: THE OUTER PLANETS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'The Outer Planets',
  'outer-planets',
  'Learn about Pluto, Eris, Haumea, Makemake, and the Kuiper belt - icy remnants from the solar system's formation far beyond Neptune.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'outer-planets' LIMIT 1),
  'Saturn',
  'saturn',
  1,
  '# Saturn

## Physical Characteristics

**Distance from Sun**: 9.58 AU (1.43 billion km)

**Orbital period**: 29.46 Earth years

**Diameter**: 116,460 km (9.45 × Earth)

**Day length**: 10.7 hours (fastest rotation).

**Gravity**: 10.4 m/s² (1.07 g)

**Atmosphere**: Hydrogen, helium.

**Magnetic field**: 5% of Earth's.

**Temperature**: Cloud tops: -139°C (134 K).

**Moons**: 146 known moons (Titan largest).

## The Rings

**Magnificent system**: Mostly ice and rock particles.

**Structure**: Multiple rings (A-G, B, C, D, E, F, G).

**Gap divisions**: Cassini Division - numerous gaps.

**Formation theories**: Debris ring (shattered moon), shepherd moons.

## The Moon Titan

**Diameter**: 5,150 km (larger than Mercury).

**Atmosphere**: Thick nitrogen (1.5 bar).

**Surface**: Liquid methane-ethane lakes.

**Features**: Ice rocks, dunes, organic molecules.

## Sources
- CK-12 Earth Science: "Saturn"
- Khan Academy: "The Solar System"
- NASA: "Cassini Solstice Mission"
',

  '[
    {
      "question": "What are Saturn's rings primarily made of?",
      "options": ["Solid nitrogen ice", "Rock and dust particles", "Frozen water and ammonia", "Gaseous hydrogen and helium"],
      "correctAnswer": 0,
      "explanation": "Saturn\"s rings are PRIMARILY composed of WATER ICE, rock particles, and dust - with perhaps some embedded ammonia. While the rings appear solid from afar, they\"re actually delicate structures only tens of meters thick. The bright reflected surfaces are ice particles. The rings are Saturn\"s most iconic feature and teach us about solar system formation!"
    },
    {
      "question": "What is special about Saturn's moon Titan?",
      "options": ["It is the only moon with a thick atmosphere", "It has liquid methane lakes on its surface", "It is the largest moon in the solar system", "It may have conditions suitable for life"],
      "correctAnswer": 1,
      "explanation": "TITAN is the ONLY moon with a SUBSTANTIAL ATMOSPHERE (thick nitrogen 1.5 bar - 50% denser than Earth\"s). Its surface features LIQUID METHANE-ETHANE lakes and rivers, the only such bodies of liquid found on any moon other than Earth. With its thick atmosphere and organic molecules, Titan is considered one of the most promising locations for possible extraterrestrial life in our solar system!"
    },
    {
      "question": "What created the gaps in Saturn's rings?",
      "options": ["Moon collisions breaking up ring particles", "Shepherd moons gravitationally confining ring material", "Meteoroid impacts shattering ring debris", "Orbital resonances clearing gaps"],
      "correctAnswer": 2,
      "explanation": "MOON MASSES that once orbited within the ring region (or were captured) gravitationally interacted with ring particles. SHEPHERD MOONS (small moonlets embedded within or near rings) help clear debris through their weak gravity. Other MOONS\" gravitational influence creates orbital resonances that can clear gaps and confine ring structures into sharper arcs. The Cassini mission revealed many of these dynamics in beautiful detail!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'outer-planets' LIMIT 1),
  'Uranus',
  'uranus',
  2,
  '# Uranus

## Physical Characteristics

**Distance from Sun**: 19.22 AU (2.87 billion km)

**Orbital period**: 84 Earth years.

**Diameter**: 50,724 km (4.0 × Earth).

**Day length**: 17.2 hours (retrograde rotation).

**Gravity**: 8.69 m/s² (0.89 g).

**Atmosphere**: Hydrogen, helium, methane.

**Temperature**: -224°C (cloud tops).

**Magnetic field**: 4% of Earth's.

**Axial tilt**: 97.77° (rolls on side).

## Unique Features

**Tilted**: Extreme seasons.

**Retrograde rotation**: Rotates opposite to most planets.

**Magnetic field**: Tilted 59° from rotation axis (unique).

**Coldest**: Coldest planetary atmosphere (59 K).

## Rings

**Faint ring system**: Dark, narrow.

**Discovery**: 1781 (telescope).

**Shepherd moons**: Cordelia and Ophelia.

## Sources
- CK-12 Earth Science: "Uranus"
- Khan Academy: "The Solar System"
- NASA: "Voyager 2"
',

  '[
    {
      "question": "What is Uranus's axial tilt?",
      "options": ["23°", "97.77°", "42°", "82°"],
      "correctAnswer": 0,
      "explanation": "Uranus has an EXTREME AXIAL TILT of 97.77° - it essentially rolls on its side in its orbit. This extreme tilt creates SEVERE SEASONS: each pole gets 42 years of continuous sunlight followed by 42 years of darkness. Uranus also has RETROGRADE ROTATION (opposite to most planets). These unique conditions make Uranus the STRANGEST planet in the solar system!"
    },
    {
      "question": "What is unique about Uranus's temperature?",
      "options": ["It is the coldest planetary atmosphere in the solar system", "It has the coldest recorded temperature on Earth", "Its extreme axial tilt causes extreme seasons"],
      "correctAnswer": 1,
      "explanation": "Uranus has the COLDEST ATMOSPHERE of any planet in the solar system at 59 K (-224°F or -371°C). This is COLDER than even Neptune\"s moon Triton! The extreme axial tilt (98°) causes one pole to face the Sun for 42 years while the other is in darkness, then the situation reverses. This creates the most extreme seasonal variations in the solar system!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'outer-planets' LIMIT 1),
  'Neptune',
  'neptune',
  3,
  '# Neptune

## Physical Characteristics

**Distance from Sun**: 30.07 AU (4.5 billion km)

**Orbital period**: 164.8 Earth years.

**Diameter**: 49,244 km (3.88 × Earth).

**Day length**: 16.1 hours (rotation period).

**Gravity**: 11.2 m/s² (1.14 g).

**Atmosphere**: Hydrogen, helium, methane.

**Temperature**: -201°C (cloud tops).

**Moons**: 14 known moons (Triton largest).

## Features

**Great Dark Spot**: Dark storm (similar to Jupiter's).

**Winds**: Fastest in solar system (2,000 km/h).

**Internal heat**: More energy radiated than received (mystery).

## The Moon Triton

**Diameter**: 2,707 km (larger than Mercury).

**Atmosphere**: Thin nitrogen with geysers.

**Surface**: Water ice, rock mix.

**Cryogeysers**: Nitrogen geysirs (erupting plumes).

## Sources
- CK-12 Earth Science: "Neptune"
- Khan Academy: "The Solar System"
- NASA: "Voyager 2"
',

  '[
    {
      "question": "What is the Great Dark Spot on Neptune?",
      "options": ["A large anticyclone similar to Jupiter's Great Red Spot", "A permanent storm in Neptune's atmosphere", "An opening in Neptune's clouds allowing heat to escape", "A high-pressure system with supersonic winds"],
      "correctAnswer": 1,
      "explanation": "Neptune\"s GREAT DARK SPOT is a large, high-pressure anticyclonic storm system in the planet\"s atmosphere. Like Jupiter\"s spot, it appears as a DARK OVAL in the clouds. Neptune has the FASTEST WINDS in the solar system (2,000 km/h, or 1.2 miles per second) powered by supersonic jets. The spot has raged for decades and may have Voyager 2-observed cloud clearings, suggesting long-term persistence!"
    },
    {
      "question": "What is unique about Triton's geysers?",
      "options": ["They are nitrogen geysers that erupt liquid nitrogen instead of water vapor", "They are the tallest eruptions in the solar system", "They are driven by Neptune's internal heat rather than sunlight", "They create visible dark plumes on Triton's surface that can be seen from space"],
      "correctAnswer": 2,
      "explanation": "Triton\"s geysers are NITROGEN GEYSERS that shoot liquid NITROGEN 8 km into space (instead of water vapor). These plumes rise 8 km above Triton\"s surface before falling back, creating dark deposits. They\"re powered by Neptune\"s INTERNAL HEAT (tidal heating from gravitational pull) rather than solar heating. These are the TALLEST ERUPTIONS in the solar system, easily visible from Earth with telescopes!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'outer-planets' LIMIT 1),
  'Dwarf Planets',
  'dwarf-planets',
  'Explore the smallest worlds in our solar system: Pluto, Eris, Haumea, Makemake, Ceres, Vesta, Pallas, Hygiea, and others in the Kuiper belt and scattered disc-shaped objects.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'dwarf-planets' LIMIT 1),
  'Pluto',
  'pluto',
  1,
  '# Pluto

## Discovery and Reclassification

**Discovered**: 1930 (Clyde Tombaugh)

**Reclassified 2006**: Dwarf planet (IAU definition).

**Why not a planet?**:
- Failed to clear orbit (Neptune neighborhood)
- Too small to clear neighborhood

## Physical Characteristics

**Distance from Sun**: 39.5 AU (5.9 billion km) - average for Kuiper belt.

**Orbital period**: 248 Earth years.

**Diameter**: 2,377 km (0.18 × Earth).

**Day length**: 153.3 hours (6.4 Earth days).

**Gravity**: 0.62 m/s² (0.06 g).

**Atmosphere**: Thin nitrogen, methane, carbon monoxide.

## Moons

**Charon**: Discovered 1978.

**Styx**: Discovered 2012.

**Kerberos**: Discovered 2011.

**Nix**: Discovered 2011.

**Hydra**: Discovered 2005.

## The Heart Region (Tomba Regio)

**Ice plain**: Sputtered plain of nitrogen ice.

**Mountains**: Ice mountains (2-3 km high).

**Craters**: Many impact basins.

## Surface Features

**Thin atmosphere**: Layers of haze, smog.

**Nitrogen ice**: Predominant surface (water ice below).

**Tholin** (dark equatorial region): Dark organic deposits.

## New Horizons Flyby

**Encountered**: July 14, 2015 (14.5 billion km away).

**Discoveries**:
- Icebergs (water ice)
- Water ice mountains
- Tectonic plate (1 km wide)

## Sources
- CK-12 Earth Science: "Pluto"
- Khan Academy: "The Solar System"
- NASA: "New Horizons"
',

  '[
    {
      "question": "Why is Pluto considered a dwarf planet?",
      "options": ["Because it is too small to be a major planet", "Because it has not cleared its orbital neighborhood", "Because it is made of ice and rock like other dwarf planets", "Because it shares its orbit with Kuiper belt objects"],
      "correctAnswer": 2,
      "explanation": "Pluto is considered a DWARF PLANET because it has not CLEARED its ORBITAL NEIGHBORHOOD of massive planets. It resides in the Kuiper belt - a region of icy debris beyond Neptune, sharing its orbit with other small bodies. Pluto is made of ice and rock (like other dwarf planets) but is too small to gravitationally dominate its orbit. Its reclassification reflects our improved understanding of the solar system!"
    },
    {
      "question": "What is the Tomba Regio?",
      "options": ["A vast plain of ice on Pluto's surface", "A mountain range comparable to the Rockies on Earth", "A region with many tall peaks reaching 2-3 km high", "The heart-shaped region of Pluto visible in New Horizons images"],
      "correctAnswer": 2,
      "explanation": "The TOMBA REGIO is the large, \"heart-shaped\" region of impact basins directly opposite Charon\"s bright lobe. This region has many isolated PEAKS (mountains) reaching 2-3 km high - comparable to Colorado Rockies on Earth. It appears relatively smooth compared to the mountains of Charon. New Horizons revealed this intriguing landscape that may have formed from ancient cryovolcanic or impact processes!"
    },
    {
      "question": "What did New Horizons discover in the Kuiper belt?",
      "options": ["Evidence of ancient subsurface ocean", "Thousands of new small icy bodies", "A binary dwarf planet system with Haumea and Makemake", "Frozen nitrogen and methane ice mountains"],
      "correctAnswer": 2,
      "explanation": "New Horizons discovered THOUSANDS of small icy bodies in the Kuiper belt, evidence of an ANCIENT SUBSURFACE OCEAN that may have existed on Pluto. It also found numerous BINARY DWARF PLANETS (two-body systems) including Haumea and Makemake orbiting each other. It observed FROZEN METHANE and NITROGEN ICE features, and saw mountains of water ice on these distant worlds. These discoveries revealed the Kuiper belt is even more complex than previously thought!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 3: STARS AND GALAXIES
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'Stars and Galaxies',
  'stars-galaxies',
  'Explore the life cycles of stars: their birth in nebulae, main sequence evolution, and their eventual fate as white dwarfs, neutron stars, or supernovae. Learn about galaxies: spiral, elliptical, and irregular, and how they cluster into the cosmic web.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 3
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'stars-galaxies' LIMIT 1),
  'The Life Cycle of Stars',
  'life-cycle-stars',
  1,
  '# The Life Cycle of Stars

## Star Birth

**Nebulae**: Giant clouds of gas and dust.

**Protostars**: Dense regions within nebulae.

**Trigger**: Shock waves (supernova remnants, nearby stars).

**Collapse**: Gravity overcomes gas pressure, forming first stars.

$$\text{Nebula} \rightarrow \text{Protostars} \rightarrow \text{Cluster}$$

## Main Sequence

**Massive stars** (O, B types):
- Burn hydrogen rapidly
- Become red giants/supergiants
- Explode as supernovae
- End as white dwarfs

**Intermediate mass stars** (A types):
- More stable, longer lifespan
- Yellow color (Sun, Capella)
- Become planetary nebulae

**Low mass stars** (K, M types):
- Consume fuel slowly
- Very long lifespan (trillions of years)
- Red dwarfs (cooler)
- End as white dwarfs

## The H-R Diagram

$$L = \text{Luminosity}$$

**Temperature**:
- **Blue stars**: >30,000 K (hot)
- **White stars**: 6,000-30,000 K
- **Red dwarfs**: <3,000 K

**Size and brightness**: Blue giants largest.

## Stellar Evolution

**Changes over time**:
- Main sequence: O → B → A → K → M
- Metal enrichment increases

$$X_{Fe} \rightarrow X_{Fe}$$

## Sources
- CK-12 Earth Science: "Stars"
- Khan Academy: "Life and Death of Stars"
- OpenStax Astronomy: "Stars"
',

  '[
    {
      "question": "What is the Hertzsprung-Russell diagram showing stellar evolution?",
      "options": ["A plot of star luminosity versus temperature", "A diagram showing how star types are arranged on a graph", "A chart predicting star life spans based on mass", "A graph of star color distribution in the galaxy"],
      "correctAnswer": 0,
      "explanation": "The HERTZSPRUNG-RUSSELL diagram plots STELLAR LUMINOSITY (Y-axis) versus SURFACE TEMPERATURE (X-axis). It shows how stars are arranged: massive blue O stars (top left), intermediate A/F stars (middle), red M stars (lower right), and white dwarfs (bottom). The diagram reveals that STAR BRIGHTNESS INCREASES with TEMPERATURE and that MASSIVE stars burn out faster (shorter lives) while low-mass stars burn slowly (longer lives)!"
    },
    {
      "question": "What creates white dwarfs?",
      "options": ["Low-mass stars that have exhausted their nuclear fuel", "Stars that were once red giants but shed their outer layers", "Stars that have cooled and contracted over billions of years", "The leftover cores of stars after fusion stops"],
      "correctAnswer": 2,
      "explanation": "WHITE DWARFS are the exposed cores of low-to-intermediate mass stars (0.5-8 solar masses) that have exhausted their nuclear fuel. After fusion stops, the star sheds its OUTER LAYERS, revealing the hot core. Without this envelope, the star cannot fuse heavier elements and slowly cools over billions of years into a compact Earth-sized object. White dwarfs will slowly fade to black dwarfs!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'stars-galaxies' LIMIT 1),
  'The Milky Way Galaxy',
  'milky-way-galaxy',
  2,
  '# The Milky Way Galaxy

## Our Galactic Home

**Shape**: Barred spiral galaxy.

**Size**: 100,000-200,000 light-years across.

**Composition**: 100-400 billion stars.

**Location**: Orion Arm of Local Group.

**Sun's position**: About 26,000 light-years from Galactic Center.

## Galactic Structure

### Components

1. **Nuclear bulge**:
   - Galactic Center
   - Dense star cluster
   - Supermassive black hole (4 million solar masses)

2. **Galactic disk**:
   - Stars, gas, dust
   - Spiral arms
   - Most of galaxy's mass

3. **Halo**:
   - Spherical distribution of stars
   - Extends ~100,000 light-years
   - Contains ~150 globular clusters

4. **Dark matter halo**:
   - Majority of galaxy's mass
   - Spherical distribution
   - Extends ~200,000 light-years
   - Unknown composition

## Spiral Arms

**Perseus Arm**:
- Contains Messier 31
- Length: 50,000 light-years
- Star-forming regions

**Norma Arm**:
- Contains many young stars
- Length: 30,000 light-years
- Center of galaxy

**Scutum-Centaurus Arm**:
- Outer arm
- Contains older stars
- Fewer star-forming regions

**Other named arms**:
- Sagittarius
- Carina
- Various outer fragments

## Black Hole at Center

**Sagittarius A***:
- 4 million solar masses
- Stars orbit at incredible speeds

**Evidence**:
- Stars orbiting at thousands of km/s
- X-rays from accretion disk
- Gravity affects nearby stars

## Sources
- CK-12 Earth Science: "Galaxies"
- Khan Academy: "The Milky Way"
- NASA: "Galaxy Evolution Explorer"
',

  '[
    {
      "question": "What is the shape of the Milky Way?",
      "options": ["Elliptical galaxy", "Spiral galaxy", "Irregular galaxy", "Barred spiral galaxy", "Disk with central bulge"],
      "correctAnswer": 0,
      "explanation": "The MILKY WAY is a BARRED SPIRAL GALAXY with a central band of stars across the galactic plane. From above, it appears as a rotating disk with two major spiral arms (Perseus and Scutum-Centaurus) extending outward. The central region (bulge) contains about 10% of galaxy\"s stars and is roughly 27,000 light-years across. Our Solar System is located in one of the spiral arms, about 26,000 light-years from the center!"
    },
    {
      "question": "What is dark matter?",
      "options": ["Matter that cannot be seen but has gravitational effects", "The mysterious substance making up 73% of the universe", "Particles that do not interact with light but have mass", "Unknown form of matter that does not emit radiation"],
      "correctAnswer": 1,
      "explanation": "DARK MATTER is an UNKNOWN SUBSTANCE that does not interact with light but has GRAVITATIONAL EFFECTS (we can\"t see it but we know it\"s there from its gravity). It makes up about 27% of the universe\"s mass-energy density - more than five times the combined amount of ordinary matter, stars, and gas. Dark energy is even more mysterious at 27%. Most of it is in halos around galaxies, forming a DARK MATTER HALO. Its nature remains one of cosmology\"s biggest mysteries!"
    },
    {
      "question": "What creates supermassive black holes?",
      "options": ["Death of massive stars", "Galaxy mergers", "Direct collapse of gas clouds", "Accretion of mass over billions of years"],
      "correctAnswer": 2,
      "explanation": "SUPERMASSIVE BLACK HOLES (millions to billions of solar masses) form when GALAXIES MERGER - two large galaxies collide and their central black holes combine. This can also happen through GRADUAL GROWTH as a galaxy\"s central black hole swallows stars and gas. Matter falling toward the event horizon can never escape, creating an infinitely dense object from which even light cannot escape!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: THE BIG BANG AND COSMOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'The Big Bang and Cosmology',
  'big-bang-cosmology',
  'Study the origin and evolution of our universe: the Big Bang theory, cosmic microwave background, formation of the first atoms, nucleosynthesis, and how the universe has evolved from a hot dense beginning to its current structured state.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'big-bang-cosmology' LIMIT 1),
  'The Big Bang Theory',
  'big-bang-theory',
  1,
  '# The Big Bang Theory

## What Is the Big Bang?

**Definition**: The universe began as an infinitely hot, dense point ~13.8 billion years ago.

## Key Evidence

### Expanding Universe

**Hubble's Law** (1929):
$$v = H_0 d$$

**Galaxies receding**: More distant = faster recession.

**Cosmic Microwave Background**:
- Discovered 1965
- 3K radiation everywhere
- Confirms Big Bang predictions.

### Primordial Nucleosynthesis

**First three minutes**:
$$n \rightarrow p + e^- + n$$

- Formed hydrogen (75%) and helium (25%)
- Deuterium and lithium (trace)

### Cosmic Timeline

**Planck Era** (recombination):
- 13.8 billion years ago
- CMB cooled to 2.7 K

**Matter Era** (radiation):
- Matter dominated
- 380,000 years
- Stars and galaxies formed

### Evidence Supporting Big Bang

**Redshift**:
- Galaxies moving away = universe expanding
- Light stretched (redshifted)

**Nucleosynthesis**:
- Primordial helium/hydrogen ratios (75/25)
- Matches stellar observations

## Alternative Theories

### Steady State Universe**:
- No beginning or end
- Infinite in size
- No expansion

**Problems**: Violates observations.

### Sources
- CK-12 Earth Science: "The Big Bang"
- Khan Academy: "Big Bang"
- NASA: "WMAP (Wilkinson Microwave Anisotropy Probe)"
',

  '[
    {
      "question": "What is the cosmic microwave background?",
      "options": ["Radiation left over from the Big Bang", "The first light from stars that can now be seen", "3K uniform thermal radiation that fills the universe", "The background radiation detected by radio telescopes in 1965"],
      "correctAnswer": 2,
      "explanation": "The COSMIC MICROWAVE BACKGROUND is faint glow of thermal radiation (3K) that permeates the universe, discovered in 1965. It\"s the OLDEST LIGHT we can see - the first light from stars that has traveled across 13.8 billion years. This background is nearly UNIFORM in all directions and represents the cooled remnant of the Big Bang. It\"s one of the strongest confirmations that our universe began in a hot, dense state!"
    },
    {
      "question": "What is redshift?",
      "options": ["The stretching of light waves due to universe expansion", "The shift of starlight toward longer wavelengths (redder color)", "The cooling of the universe over time", "The Doppler effect from relative motion"],
      "correctAnswer": 1,
      "explanation": "REDSHIFT occurs when light waves are STRETCHED to longer wavelengths (appear redder) as space expands during the light\"s journey. As the universe expands, the wavelength stretches, shifting starlight toward the RED end of the spectrum. This cosmological REDSHIFT provides evidence for an expanding universe and supports the Big Bang theory of cosmic origin!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: THE SOLAR SYSTEM BEYOND NEPTUNE
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'Exoplanets and Kuiper Belt',
  'exoplanets-kuiper-belt',
  'Explore worlds orbiting other stars: the diverse array of planets discovered beyond our solar system, the icy debris at the solar system's fringe, and the search for Earth-like planets around nearby stars.',
  6,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'exoplanets-kuiper-belt' LIMIT 1),
  'Methods of Detecting Exoplanets',
  'exoplanet-detection-methods',
  1,
  '# Methods of Detecting Exoplanets

## Transit Photometry

**Principle**: Planet passes in front of star, dimming its light.

$$\text{Flux} = \left(\frac{\Delta F}{F}\right)^2$$

**Depth**:
$$ \text{Depth} = \left(\frac{R_\opl^2}{R_\star^2}\right)^{2.78}$$

**Size**: Earth-sized = 1% drop in starlight.

**Limitations**:
- Minimum detectable size ~2-5 × Earth
- Favors large planets

## Direct Imaging

**Blocking starlight**:
- Reduces glare
- Creates sharp shadow

**Examples**:
- **64-planets**: Imaging from space (telescopes)

- **VLTs**: Ground-based telescopes

**Success**: First image of an exoplanet atmosphere.

## Radial Velocity Method

**Doppler shift**: $$\frac{\Delta \lambda}{\lambda_0}$$

**Wobble**: Center of mass motion.

**Mass**:
$$M_p \sin i = \frac{V_{\text{star}} c}{1}$$

**Minimum mass**: Neptunian desert planets: ~10 Earth masses.

## Transit Timing

**Orbital period**: Must observe multiple transits.

**Duration**:
- Long-period planets: Weeks to months
- Short-period planets: Hours to days

## Sources
- CK-12 Earth Science: "Exoplanets"
- Khan Academy: "Exoplanets"
- NASA: "Exoplanet Exploration"
',

  '[
    {
      "question": "What is the transit method used to detect most exoplanets?",
      "options": ["Direct imaging from space telescopes", "Measuring the tiny dimming of starlight as a planet passes in front", "Detecting the gravitational wobble of the host star caused by orbiting planet", "Looking for periodic variations in star brightness caused by orbiting planet"],
      "correctAnswer": 1,
      "explanation": "The TRANSIT METHOD (measuring star brightness variations as planet passes in front) has discovered thousands of exoplanets. This requires PRECISE, BRIGHT STARS for calibration. TRANSIT PHOTOMETRY and RADIAL VELOCITY (Doppler wobble) methods can also determine mass. Most successful ground-based transit surveys use both methods in combination. The transit must be REPEATABLE to confirm planetary properties!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'exoplanets-kuiper-belt' LIMIT 1),
  'Types of Exoplanets',
  'exoplanet-types',
  2,
  '# Types of Exoplanets

## Classification

### By Size

**Gas giants**:
- Jupiter, Saturn, Uranus, Neptune
- Thick atmosphere
- Many moons
- May have solid cores

**Ice giants**:
- Uranus, Neptune
- Thick atmosphere
- Fewer moons
- Icy interiors

**Super-Earths**:
- Larger than Earth
- Thick atmosphere
- No solid surface

**Terrestrial planets**:
- Mercury, Venus, Earth, Mars
- Rocky surfaces
- Thin atmospheres
- Few moons

**Mini-Neptunes**:
- Pluto, Eris, Haumea, Makemake
- Icy/rocky bodies
- Irregular shapes

**Dwarf planets**:
- Asteroid-sized (Ceres, Vesta, Pallas)
- Rocky, icy
- No atmospheres

## Detection Methods

### Radial Velocity

**Star wobble**:
- Planets pull star

**Direct imaging**:
- Light from planet blocks star

**Transit timing**:
- Brightness measurements

## Habitability Zones

**Hot Zone**:
- Too hot for liquid water
- Where deserts would be too hot

**Habitable Zone**:
- Not too hot, not too cold
- Where liquid water could exist

## Sources
- CK-12 Earth Science: "Exoplanets"
- Khan Academy: "Exoplanets"
- NASA: "Exoplanet Exploration"
',

  '[
    {
      "question": "What is a hot Jupiter?",
      "options": ["An exoplanet with extremely high temperature", "A gas giant planet hotter than it should be", "A planet with magma surface and active volcanism"],
      "correctAnswer": 2,
      "explanation": "A HOT JUPITER is an exoplanet with EXTREMELY HIGH TEMPERATURES (day side 1,100°C or 1,300°F) and NIGHT SIDE temperatures of -700°C or -1,000°F due to LOCKED TIDAL HEATING from eternal star-facing. It\"s so close to its star that one year lasts only 10 Earth hours. Recent surveys show hot Jupiters may have MOLTEN SURFACES or extremely high winds, not lava lakes. This extreme heat is maintained by internal heat from formation, not starlight!"
    },
    {
      "question": "What is the habitable zone around an Earth-like planet?",
      "options": ["The distance from star where liquid water can exist", "The range of distances where temperatures allow liquid water", "The atmospheric pressure that permits water to exist as liquid", "The region of the planet not too hot or too cold"],
      "correctAnswer": 0,
      "explanation": "The HABITABLE ZONE around a star is the GOLDILOCKS region where liquid water could exist on the surface. This zone exists where stellar flux allows for temperatures between 0°C and 100°C (273K to 373K), creating conditions for liquid water. Too close to star (hot zone) water boils away, too far (cold zone) water freezes. Too far means solar heating is insufficient for liquid water. This narrow band determines whether a planet could host Earth-like life!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 6: THE LIFE CYCLE OF STARS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'astronomy' LIMIT 1),
  'The Life Cycle of Stars',
  'life-cycle-stars',
  'Explore how stars are born, live, and die: their formation in stellar nurseries, their time on the main sequence, and their ultimate fate as supernovae, neutron stars, white dwarfs, or black holes.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 6
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'life-cycle-stars' LIMIT 1),
  'Star Formation',
  'star-formation',
  1,
  '# Star Formation

## Stellar Nurseries

**Molecular clouds**:
- Gas and dust (99% H₂, 1% He, traces of heavier elements).

**Protostars**:
- Dense regions within clouds.

**Trigger**:
- Shock waves from supernovae
- Galaxy collisions
- Radiation from nearby hot stars

**Gravitational collapse**:
$$F_g = \frac{GMm_1m_2}{r}$$

**First stars**:
- Begin hydrogen fusion
- Mass: 150-300 solar masses
- Clear nebula

## Main Sequence

**T Tauri stars** (3-60 M☉):
- Protium (H), Helium, Carbon, Nitrogen, Oxygen
- Consume hydrogen rapidly
- Become red giants
- Nuclear shells of heavy elements
- End as supernovae or planetary nebulae

## Post-Main Sequence

**Red giants**:
- Helium, Carbon, Oxygen
- Shell burning and planetary nebulae
- End as white dwarfs

**Planetary nebulae**:
- Material ejected from dying star
- Form next generation of stars

## Low Mass Stars

**Characteristics**:
- Mass: <8 solar masses
- Convection in core
- Stable energy supply (trillions of years)

**Spectrum**: M-type (red dwarfs)

## Brown Dwarfs

**Sub-solar mass**:
- Mass: 8% of Sun or less
- Core: Radiative zone
- Convection throughout
- Failed nuclear burning

## White Dwarfs

**Final stage**:
- No nuclear fusion
- Core composed of electron-degenerate matter
- Very hot when young, gradually cooling

**Size**:
- Similar to Earth
- High density

## Sources
- CK-12 Earth Science: "Stars"
- Khan Academy: "Life and Death of Stars"
- OpenStax Astronomy: "Stars"
',

  '[
    {
      "question": "What creates planetary nebulae?",
      "options": ["The death of a massive star in a supernova explosion", "The collision of two stars merging together", "The outer layers of a dying red giant star being ejected into space", "Large radiation pressure blowing off outer atmospheric layers"],
      "correctAnswer": 0,
      "explanation": "PLANETARY NEBULAE form when a star (usually a RED GIANT) approaches the end of its life. The star\"s outer layers are gently ejected over hours to days, creating expanding shells of gas and dust. This material mixes with interstellar medium, potentially forming the next generation of stars. The beautiful structures we see (like the Helix Nebula) are the ashes of stellar death!"
    },
    {
      "question": "What is the Chandrasekhar limit?",
      "options": ["The maximum mass a star can have and still be stable", "The peak luminosity of a star's main sequence lifetime", "The boundary between low and high mass on the main sequence", "The temperature at which a star spends its time on the main sequence"],
      "correctAnswer": 2,
      "explanation": "The CHANDRASEKHAR LIMIT (named after Indian astronomer Subrahmanyan Chandrasekhar) is ~8 SOLAR MASSES. Above this limit, stars cannot balance gravity with radiation pressure and become UNSTABLE. They expand to RED GIANTS or SUPERGIANTS, exhausting core hydrogen quickly (millions of years). These massive stars burn fuel at incredible rates but have SHORT LIFETIMES (millions of years) because gravity can\"t crush their immense mass into a stable configuration!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'life-cycle-stars' LIMIT 1),
  'Supernovae',
  'supernovae',
  2,
  '# Supernovae

## What Is a Supernova?

**Supernova**: Cataclysmic explosion of a massive star.

$$E \sim 10^{44}$$ joules (more energy than Sun's lifetime output)

## Types

**Type Ia (Core-collapse):
- Complete destruction
- Remnant: Neutron star or black hole
- No neutron star left

**Type Ib (Type II):
- Core collapse with neutron star or black hole
- Remnant: Neutron star or black hole

**Type Ic (Thermonuclear):
- Thermonuclear runaway
- Complete destruction
- Remnant: Neutron star or black hole

## The Explosion

**Shockwave**:
- Expels stellar atmosphere
- Creates heavy elements (iron, silicon, etc.)

**Light curve**:
- Brightness increases rapidly, then fades over months.

**Nebula**:
- Expanding shell of gas and dust.
- Can remain visible for thousands of years (Crab Nebula).

## Elements Produced

**Nucleosynthesis**: Creates elements heavier than iron.

**Radioactive isotopes**:
- $$^{56}\text{Co}$$
- $$^{22}\text{Na}$$
- $$^{44}\text{Ti}$$ (with daughter products)

## Supernova Remnants

**Neutron star**:
- Pulsar (rapidly spinning neutron star)
- X-ray source

**Black hole**:
- If mass >3 solar masses (M_safe)
- Gravitational waves

## Sources
- CK-12 Earth Science: "Stars"
- Khan Academy: "Supernovae"
- OpenStax Astronomy: "Stars"
',

  '[
    {
      "question": "What is the difference between Type Ia and Type II supernovae?",
      "options": ["Type Ia completely destroys the star leaving no remnant", "Type II leaves behind a compact remnant like a neutron star or black hole", "Type II creates heavy elements but has a less complete explosion", "Type Ia occurs in old, low-mass stars while Type II happens in younger, more massive stars"],
      "correctAnswer": 2,
      "explanation": "TYPE IA supernovae represent COMPLETE CORE COLLAPSE where the entire star is destroyed, leaving no remnant. TYPE II supernovae leave behind a COMPACT OBJECT - either a NEUTRON STAR or a BLACK HOLE. Type II SUPERNOVAE create heavy elements and disperse the star, but have less complete disruption. Type II occurs in younger, more massive stars, while Type Ia events occur in older, low-mass stars with shorter lifetimes!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'life-cycle-stars' LIMIT 1),
  'Neutron Stars and Black Holes',
  'neutron-stars-black-holes',
  'Explore the corpses of massive stars: neutron stars and the most extreme objects in the universe - black holes. Learn about stellar remnants, pulsars, magnetars, and the relativistic jets that power some of the most energetic phenomena in the cosmos.',
  3,
  '# Neutron Stars and Black Holes

## Neutron Stars

**Characteristics**:
- Mass: 1.4-2.0 solar masses
- Luminosity: 0.0001-0.01 × Sun
- Lifetime: millions of years
- Surface temperature: 50,000 K

**Examples**: Sirius B, Procyon, 61 Cygni.

## Pulsars

**Rapid rotation**:
- Periodic brightness changes (milliseconds to seconds).
- X-rays and radio emission.

**Formation**:
- Core collapse of massive star
- Neutron star remains

## Black Holes

**Event horizon**:
- Point of no return.

**Singularity**:
- Infinite density.

**Size**:
- Stellar mass: 3-20 billion solar masses (large)
- Event horizon: 6-10 million km (Earth diameter).

**Evidence**:
- Stars orbiting at high speeds
- X-ray binaries
- Gravitational waves from mergers

## Sources
- CK-12 Earth Science: "Stars"
- Khan Academy: "Neutron Stars and Black Holes"
- OpenStax Astronomy: "Stars"
',

  '[
    {
      "question": "What is the event horizon?",
      "options": ["The point where light cannot escape from a black hole", "The boundary between normal space and the black hole's extreme gravity", "The surface of a black hole where time stops according to external observer", "The radius at which escape velocity equals the speed of light"],
      "correctAnswer": 0,
      "explanation": "The EVENT HORIZON is the boundary beyond which NOTHING CAN ESCAPE - not even light. It's located at the SCHWARZSCHILD RADIUS where the escape velocity equals the speed of light (c = 300,000 km/s). At this boundary, GRAVITY becomes so intense that space and time are infinitely distorted from an external observer\"s perspective. Once crossed, all paths lead toward the singularity where physics breaks down. This is the one-way door to no return!"
    },
    {
      "question": "What creates relativistic jets?",
      "options": ["Accretion disks around black holes", "Magnetic field lines being twisted into jets", "Frame-dragging effects in black hole ergosphere", "Extreme gravitational forces"],
      "correctAnswer": 2,
      "explanation": "RELATIVISTIC JETS are powered by EXTREME GRAVITY and magnetic fields near rapidly spinning black holes. Matter falling toward the black hole forms an ACCRETION DISK that feeds the jets. FRAME-DRAGGING from the ergosphere (rotating magnetic fields) collimates particles into high-energy beams along the rotation axes. These jets can extend THOUSANDS of light-years, making black holes some of the most energetic and LUMINOUS objects in the universe!"
    }
  ]',
  NOW()
);
