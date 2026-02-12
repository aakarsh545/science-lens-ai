-- =====================================================
-- ECOLOGY COURSE
-- Topics: Ecosystems, Populations, Biodiversity, Conservation
-- Difficulty: Intermediate
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Ecology
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Ecology',
  'ecology',
  'Study interactions between organisms and their environment: ecosystems, populations, biodiversity, energy flow, biogeochemical cycles, and conservation biology.',
  'biology',
  'intermediate',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: INTRODUCTION TO ECOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'ecology' LIMIT 1),
  'Introduction to Ecology',
  'introduction-ecology',
  'Understand ecology fundamentals: levels of organization, ecosystems dynamics, energy flow, and biogeochemical cycles.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-ecology' LIMIT 1),
  'What Is Ecology?',
  'what-is-ecology',
  1,
  '# What Is Ecology?

## Definition of Ecology

**Ecology**: Scientific study of interactions between organisms and their environment.

**Greek roots**:
- **Oikos** (house) + **logos** (study of)
- Study of organisms in their homes

## Scope of Ecology

### Levels of Organization

**Organism**: Individual living thing
**Population**: Group of same species in same area
**Community**: Multiple populations in same area
**Ecosystem**: Living (biotic) and non-living (abiotic) components interacting
**Biosphere**: All ecosystems on Earth
**Biome**: Large geographic region with similar climate and ecosystems

## Ecology vs Environmental Science

| Aspect | Ecology | Environmental Science |
|----------|----------|-------------------|
| Focus | Interactions in natural systems | Human impacts and solutions |
| Approach | Observational, experimental | Applied, technological |
| Goal | Understanding natural processes | Solving environmental problems |

## Historical Development

**Ernst Haeckel** (1866): Coined term "ecology"
**Eugene Odum** (1915): Developed plant succession concepts
**Modern ecology**: Integrated study of ecosystems, populations, and energy flow

## Sources
- CK-12 Biology: "Ecology"
- Khan Academy: "Intro to Ecology"
- OpenStax Ecology: "The Science of Ecology"
- LibreTexts Ecology
',

  '[
    {
      "question": "What is the main focus of ecology compared to environmental science?",
      "options": ["Solving pollution problems and climate change", "Understanding natural interactions between organisms and their environment", "Developing technologies to clean up pollution", "Studying the impact of human activities on natural systems"],
      "correctAnswer": 1,
      "explanation": "ECOLOGY focuses on understanding natural interactions between organisms and their environment - how living things relate to each other and to abiotic factors. Environmental science typically studies human impacts on natural systems and develops solutions to environmental problems. While related, ecology is more about observing natural processes, while environmental science is more about applied solutions!"
    },
    {
      "question": "Which term refers to all ecosystems on Earth?",
      "options": ["Biome", "Biosphere", "Ecosystem", "Community"],
      "correctAnswer": 1,
      "explanation": "The BIOSPHERE encompasses ALL ecosystems on Earth - the global sum of all living organisms and their environments across land, water, and atmosphere. It extends from high atmosphere to deep ocean sediments. An ECOSYSTEM is a smaller unit within the biosphere (like a forest or coral reef). A BIOME is a large region with similar climate and ecosystems (like tropical rainforest)!"
    },
    {
      "question": "Who is credited with coining the term 'ecology' in 1866?",
      "options": ["Charles Darwin", "Ernst Haeckel", "Eugene Odum", "Rachel Carson"],
      "correctAnswer": 1,
      "explanation": "ERNST HAECKEL (1834-1919) is credited with coining the term \"ecology\" from Greek: oikos (house) + logos (study of). He worked on animal morphology and behavior, establishing the scientific study of organisms\" relationships to their surroundings. The term became central to understanding how living things interact with their environment!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-ecology' LIMIT 1),
  'Levels of Ecological Organization',
  'levels-ecological-organization',
  2,
  '# Levels of Ecological Organization

## Ecological Hierarchy

### Individual Organism

**Definition**: Single living thing (one bacterium, one tree, one animal).

**Examples**: E. coli bacterium, White oak tree, Human

### Population

**Definition**: Group of organisms of SAME species living in SAME area.

**Characteristics**:
- Same species (interbreeding possible)
- Same geographic location
- Same time period

**Examples**:
- All deer in a forest
- All bacteria of one species in a pond
- Maple trees in a forest stand

### Community

**Definition**: All populations of DIFFERENT species living in SAME area.

**Characteristics**:
- Multiple species
- Interactions between populations
- Same geographic location

**Examples**:
- Forest community (trees, birds, insects, fungi, bacteria)
- Coral reef community (corals, fish, algae)
- Pond community (fish, insects, plants, microorganisms)

### Ecosystem

**Definition**: Living (biotic) and non-living (abiotic) components interacting.

**Biotic factors**: Living organisms (plants, animals, fungi, bacteria, protists)

**Abiotic factors**: Non-living components (sunlight, temperature, water, soil, atmosphere)

**Examples**:
- Forest ecosystem (trees + animals + soil + climate)
- Ocean ecosystem (fish + algae + water + sunlight)
- Desert ecosystem (cacti + reptiles + sand + heat)

## Key Ecological Concepts

### Habitat

**Habitat**: Natural environment where species lives.

**Niche**: Role and position of species in its habitat.

**Fundamental niche**: Full range of conditions and resources species can use.

**Realized niche**: Actual conditions and resources species uses (often limited by competition).

## Sources
- CK-12 Biology: "Ecology"
- Khan Academy: "Levels of Organization"
- OpenStax Ecology: "Organization in Ecology"
',

  '[
    {
      "question": "What is the main difference between a population and a community?",
      "options": ["Population has multiple species, community has one species", "Population includes all organisms in an area, community includes only interacting populations", "Population is the same species, community is different species"],
      "correctAnswer": 2,
      "explanation": "A POPULATION consists of organisms of the SAME species in the same area. A COMMUNITY includes MULTIPLE DIFFERENT species that interact in the same geographic area. For example, all white-tailed deer in a forest = one population, but that deer population PLUS all the trees, birds, insects, and other organisms = a forest community!"
    },
    {
      "question": "What is the difference between a habitat and a niche?",
      "options": ["Habitat is the role a species plays, niche is where the species lives", "Habitat is the physical location, niche is the resources a species uses", "Habitat is the temperature range, niche is the food sources"],
      "correctAnswer": 2,
      "explanation": "A HABITAT is the specific physical environment where a species lives (forest, desert, ocean). A NICHE is the role and position of a species within that habitat - what it DOES and what RESOURCES it uses. The fundamental niche is the full range of conditions a species could theoretically use, while the realized niche is what it ACTUALLY uses (often limited by competition)!"
    },
    {
      "question": "What are the biotic and abiotic components of a forest ecosystem?",
      "options": ["Biotic: Oak trees, maple trees, and birds; Abiotic: Rainfall and soil pH", "Biotic: Deer, mushrooms, and bacteria; Abiotic: Sunlight and temperature", "Biotic: All plants and animals; Abiotic: Water and minerals in soil"],
      "correctAnswer": 0,
      "explanation": "BIOTIC factors are the LIVING components: oak and maple trees (producers), deer, birds, insects, mushrooms, fungi, bacteria (consumers and decomposers). ABIOTIC factors are NON-LIVING: rainfall (water input), soil pH and nutrients, sunlight (energy source), temperature, humidity, and wind. These abiotic factors determine which species can survive in the forest!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-ecology' LIMIT 1),
  'Ecosystem Dynamics',
  'ecosystem-dynamics',
  3,
  '# Ecosystem Dynamics

## Energy Flow Through Ecosystems

### Producers

**Autotrophs**: Organisms that make their own food.

**Photoautotrophs** (Photosynthesis):
- Plants, algae, cyanobacteria

$$6\text{CO}_2 + 6\text{H}_2\text{O} \xrightarrow{\text{light}} \text{C}_6\text{H}_{12}\text{O}_6$$

**Chemosynthesis** (Chemical energy):
- Deep-sea bacteria
- Hydrothermal vents

### Consumers

**Heterotrophs**: Organisms that eat other organisms.

**Primary consumers** (Herbivores):
- Eat producers (plants)

**Secondary consumers** (Carnivores):
- Eat herbivores

**Tertiary consumers**:
- Eat secondary consumers

**Decomposers**:
- Break down dead organisms, recycling nutrients

### Food Chains

**Trophic levels**:
1. Producers (plants)
2. Primary consumers (herbivores)
3. Secondary consumers (carnivores)
4. Tertiary consumers (top predators)
5. Decomposers

**Energy pyramid**:
- Only ~10% energy transferred between trophic levels
- 90% lost as heat

## Food Webs

**Definition**: Interconnected food chains in ecosystem.

**Keystone species**: Species whose impact is disproportionate to abundance.

**Example**: Sea otters (eat urchins, controlling urchin population)

## Ecological Pyramids

### Numbers Pyramid

**Base**: Producers must outnumber consumers
$$1000 \text{ plants} \rightarrow 100 \text{ deer} \rightarrow 10 \text{wolves}$$

### Biomass Pyramid

**Decrease with trophic level**: Less biomass at higher levels
$$\text{Producers} > \text{Herbivores} > \text{Carnivores}$$

## Sources
- CK-12 Biology: "Ecology"
- Khan Academy: "Energy Flow"
- OpenStax Ecology: "Ecosystem Dynamics"
',

  '[
    {
      "question": "What is the difference between a food chain and a food web?",
      "options": ["Food chain shows linear energy flow, food web shows all feeding relationships", "Food chain has one pathway, food web has many interconnected pathways", "Food chain is simpler, food web is more complex", "Food chain includes producers, food web includes consumers only"],
      "correctAnswer": 1,
      "explanation": "A FOOD CHAIN shows a single linear pathway of energy from producer through various consumers (e.g., grass → rabbit → fox). A FOOD WEB consists of MULTIPLE INTERCONNECTED food chains showing all feeding relationships in an ecosystem. Food webs are more realistic as most organisms eat multiple species and are eaten by multiple predators!"
    },
    {
      "question": "Why is only about 10% of energy transferred between trophic levels?",
      "options": ["Producers at lower levels produce less energy than consumers", "Energy is lost as heat during metabolic processes at each level", "Consumers excrete most energy they consume as waste", "Higher trophic levels require more energy, so less is available to transfer"],
      "correctAnswer": 1,
      "explanation": "Only ~10% of energy at each trophic level is incorporated into biomass at the next level. The remaining ~90% is LOST AS HEAT during respiration, excretion, and other metabolic processes. This inefficient energy transfer explains why there are fewer organisms at higher trophic levels and why food chains are limited in length!"
    },
    {
      "question": "What is a keystone species?",
      "options": ["The most abundant species in an ecosystem", "A species that has a major impact on ecosystem structure despite low abundance", "A top predator that controls the population of prey species", "A species that creates habitat for many other species"],
      "correctAnswer": 1,
      "explanation": "A KEYSTONE SPECIES has a disproportionate impact on its ecosystem relative to its abundance. Like the keystone that holds up an arch, its removal causes dramatic changes. Examples: sea otters (eat urchins, preventing urchin overgrazing of kelp), wolves (control deer populations preventing overbrowsing that changes forest structure)!"
    },
    {
      "question": "What do ecological pyramids demonstrate about ecosystems?",
      "options": ["That there are more consumers than producers in most ecosystems", "That biomass decreases at each trophic level due to energy loss", "That higher trophic levels always have fewer organisms than lower levels", "That energy is lost at each transfer between trophic levels"],
      "correctAnswer": 1,
      "explanation": "Ecological pyramids show that both NUMBERS and BIOMASS DECREASE with each trophic level. Fewer organisms can support fewer predators. Also, only ~10% of energy is incorporated into biomass at each level; the remaining 90% is lost as heat. This explains why food chains are short and why top predators are rare!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-ecology' LIMIT 1),
  'Population Ecology',
  'population-ecology',
  4,
  '# Population Ecology

## What Is a Population?

**Population**: Group of organisms of the same species living in the same area.

## Population Growth

### Exponential Growth

**Unrestricted growth**: J-shaped curve

$$N_t = N_0 e^{rt}$$

**Characteristics**:
- Rapid initial growth
- Slows as carrying capacity approached
- Resource-limited growth

### Logistic Growth

**S-shaped curve** with carrying capacity:

$$N_t = \frac{K}{1 + \frac{K-N_0}{N_0}e^{-rt}}$$

**Carrying capacity (K)**: Maximum population size environment can support.

### Factors Affecting Growth

**Density-dependent factors**:
- Food availability
- Predation pressure
- Disease
- Competition for resources

**Density-independent factors**:
- Temperature
- Rainfall
- Natural disasters

## Population Regulation

### Limiting Factors

**Factor that limits growth**:
- Usually food or resources
- Determines carrying capacity

**Examples**:
- Leibig\"s Principle: Biotic potential
- Shelford\"s Law of Tolerance: Competition

## Human Population Growth

**Human population**: Exponential growth (doubling time ~40 years).

**Impact**:
- Resource depletion
- Pollution
- Habitat destruction

## Sources
- CK-12 Biology: "Populations"
- Khan Academy: "Population Ecology"
- OpenStax Ecology: "Population Growth"
',

  '[
    {
      "question": "What is the main difference between exponential and logistic population growth?",
      "options": ["Exponential growth continues indefinitely, logistic growth levels off at carrying capacity", "Exponential is J-shaped curve, logistic is S-shaped curve", "Logistic growth accounts for limiting factors, exponential does not"],
      "correctAnswer": 1,
      "explanation": "EXPONENTIAL GROWTH assumes unlimited resources continuing in a J-shaped curve. LOGISTIC GROWTH follows an S-shaped curve that LEVELS OFF as population approaches CARRYING CAPACITY (K) - the maximum population environment can support. Logistic growth accounts for LIMITING FACTORS like food, space, competition, making it more realistic for natural populations!"
    },
    {
      "question": "What determines the carrying capacity of a population?",
      "options": ["The amount of rainfall in the environment", "The availability of food and other limiting resources", "The number of predators that control population growth", "The balance between birth rate and death rate"],
      "correctAnswer": 1,
      "explanation": "CARRYING CAPACITY (K) is determined by LIMITING FACTORS - most commonly FOOD AVAILABILITY but also water, shelter, space, disease, predation, and competition. When birth rate equals death rate including these limiting factors, population stabilizes at K. If resources increase, K increases; if resources decrease, K decreases. This is Leibig\"s Principle!"
    },
    {
      "question": "Why has human population grown exponentially over the past few centuries?",
      "options": ["Due to elimination of diseases and predators", "Because of advances in agriculture and food production", "Because humans have no natural predators", "Because of improvements in medical technology and sanitation"],
      "correctAnswer": 1,
      "explanation": "Human population has grown EXPONENTIALLY due to: 1) AGRICULTURAL REVOLUTION increasing food production beyond subsistence levels, 2) ADVANCES IN MEDICINE and SANITATION reducing death rates, 3) TECHNOLOGY and INDUSTRIALIZATION allowing more resource extraction, 4) REDUCED PREDATION (though humans still have some predators). This exponential growth (doubling time ~40 years historically) cannot continue indefinitely due to Earth\"s finite resources!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 3: COMMUNITY ECOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'ecology' LIMIT 1),
  'Community Ecology',
  'community-ecology',
  'Study species interactions within communities: competition, predation, symbiosis, and ecological succession.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 3
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'community-ecology' LIMIT 1),
  'Species Interactions and Competition',
  'species-interactions-competition',
  1,
  '# Species Interactions and Competition

## Types of Species Interactions

### Competition

**Competition**: Individuals struggle for limited resources.

**Intraspecific competition**: Same species compete

**Interspecific competition**: Different species compete

### Predation

**Predation**: One organism eats another.

**Predator**: Hunter
**Prey**: Organism being eaten

**Predator-Prey Cycles**:
- Predator population increases → prey decreases → predator decreases
- Classic population dynamics

### Symbiosis

**Mutualism**: Both species benefit (+,+)

**Commensalism**: One benefits, one unaffected (+,0)

**Parasitism**: One benefits, one harmed (+,-)

## Competitive Exclusion Principle

**Gause\"s Principle** (1934):
- Two species with similar needs cannot coexist
- One will exclude the other

**Example**: Paramecium outcompetes P. aurelia in lab cultures

## Niche Theory

**Fundamental niche**: Full range of conditions species can use

**Realized niche**: Actual conditions used (limited by competition)

**Niche differentiation**:
- Resource partitioning
- Character displacement
- Evolutionary specialization

## Sources
- CK-12 Biology: "Community Ecology"
- Khan Academy: "Competitive Relationships"
- OpenStax Ecology: "Species Interactions"
',

  '[
    {
      "question": "What is the difference between mutualism and commensalism?",
      "options": ["Both species are harmed in mutualism", "In mutualism both species benefit, in commensalism only one benefits", "Mutualism involves nutritional sharing, commensalism involves shelter"],
      "correctAnswer": 1,
      "explanation": "In MUTUALISM, BOTH species benefit (+,+). In COMMENSALISM, one species benefits (+,0) while the other is UNAFFECTED (0). Examples: mutualism - bees and flowers (both need each other); commensalism - barnacles on whales (barnacles benefit from transportation, whales are neither helped nor harmed). The +,+ or +,0 notation indicates the effect on each species!"
    },
    {
      "question": "What is Gause\"s principle in ecology?",
      "options": ["Two predator species cannot coexist in the same habitat", "Two species with identical needs cannot coexist; one will exclude the other", "Similar species will always compete until one wins", "Environmental factors determine which species dominates in different locations"],
      "correctAnswer": 1,
      "explanation": "GAUSE\"S PRINCIPLE (1934) states that two species with IDENTICAL ecological needs (same niche requirements) cannot stably coexist - one will eventually EXCLUDE the other through competition. G.F. Gause demonstrated this with Paramecium and P. aurelia in lab cultures - the slightly faster reproducing Paramecium outcompeted and excluded P. aurelia!"
    },
    {
      "question": "What is a realized niche?",
      "options": ["The actual habitat where a species lives", "The role and position of a species within its habitat", "The full range of conditions a species could theoretically use", "The resources and conditions a species actually uses in an ecosystem"],
      "correctAnswer": 3,
      "explanation": "The FUNDAMENTAL NICHE is the complete range of environmental conditions and resources a species COULD theoretically use in the absence of competition. The REALIZED NICHE is what the species ACTUALLY uses, which is often more limited due to competition, predation, or other factors. Niche differentiation (resource partitioning, specialization) allows similar species to coexist by using different resources or strategies!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'community-ecology' LIMIT 1),
  'Predator-Prey Dynamics',
  'predator-prey-dynamics',
  2,
  '# Predator-Prey Dynamics

## Predator-Prey Relationships

### Lotka-Volterra Equations

**Predator-Prey model**: Mathematical predator-prey cycles.

**Assumptions**:
1. Prey grows exponentially without predators
2. Predators consume prey according to functional response
3. Predator population limited by prey availability

**Equations**:
$$\frac{dN}{dt} = rN(t) - aN(t)$$
$$\frac{dP}{dt} = fP(t) - aP(t)$$

**Oscillations**:
- Prey population increases
- Predator population follows with delay

## Functional Responses

**Type I functional response**:
- Population cycles
- Constant population
- Damped oscillations

**Type II functional response**:
- Predator population tracks prey
- Predator satiation threshold

**Type III functional response**:
- Lotka-Volterra cycles (predator-prey oscillations)

## Trophic Cascades

**Top-down control**:
- Predators regulate prey populations
- Example: Wolves control deer, sea otters control urchins

**Trophic cascades**:
- Indirect effects across multiple trophic levels
- Example: Killer whale declines → sea otter decline → urchin increase → kelp forest decrease

## Sources
- CK-12 Biology: "Community Ecology"
- Khan Academy: "Predator-Prey Dynamics"
- OpenStax Ecology: "Community Ecology"
',

  '[
    {
      "question": "What happens in a Type I functional response according to Lotka-Volterra equations?",
      "options": ["Predator population becomes extinct", "Prey population reaches carrying capacity and stabilizes", "Predator and prey populations oscillate out of phase", "Both populations reach equilibrium and remain constant"],
      "correctAnswer": 1,
      "explanation": "In a TYPE I FUNCTIONAL RESPONSE, prey population grows exponentially and reaches a CARRYING CAPACITY (K), then stabilizes at this equilibrium level. The predator population initially grows due to abundant food but then reaches its own equilibrium based on prey availability. Both populations reach STEADY-STATE equilibrium, not oscillating!"
    },
    {
      "question": "What is a trophic cascade?",
      "options": ["The direct transfer of energy from one trophic level to the next", "The top-down control of organisms at higher trophic levels over lower levels", "The oscillating interaction between predator and prey populations", "The indirect effects of a top predator on multiple lower trophic levels"],
      "correctAnswer": 3,
      "explanation": "A TROPHIC CASCADE occurs when a top predator has INDIRECT EFFECTS across multiple lower trophic levels. For example: killer whales eat sea otters, which eat urchins, which graze on kelp. When killer whales decline, sea otters increase (direct effect), then urchins increase (indirect effect), then kelp forests decline (indirect effect). This shows ecosystem-wide connectivity!"
    },
    {
      "question": "What is the relationship between sea otters and urchins in a trophic cascade?",
      "options": ["Sea otters are predators of urchins", "Sea otters and urchins have no direct ecological relationship", "Sea otters control urchin population through predation", "Both are affected by the same top predator (killer whales)"],
      "correctAnswer": 2,
      "explanation": "Sea otters and urchins have NO DIRECT ecological relationship - they don\"t directly interact. However, they are both affected by the SAME TOP PREDATOR (killer whales) through a TROPHIC CASCADE. When killer whales decline, sea otter populations increase (which then increases predation on urchins). This indirect connection can have ecosystem-wide effects!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'community-ecology' LIMIT 1),
  'Ecological Succession',
  'ecological-succession',
  3,
  '# Ecological Succession

## What Is Succession?

**Succession**: Gradual, directional change in species composition of a community over time.

## Primary Succession

**Pioneer species**: First species to colonize barren area.

**Characteristics**:
- Tolerant of harsh conditions
- Good dispersers
- Rapid growth
- Modify environment (create soil)

**Examples**: Lichens, mosses, grasses

### Climax Community

**Stable endpoint**: More complex, competitive community.

**Characteristics**:
- Slower-growing species
- More competition
- K-selected species (few offspring, high investment)
- Greater biodiversity

## Secondary Succession

**Further changes**: New species replace climax community after disturbance.

**Disturbances**: Fire, storms, human activity

### Facilitation

**Facilitation**: Early species modify environment making it more suitable for later species.

**Example**: Alder trees improve soil for spruce seedlings

## Models of Succession

### Facilitation Model

**Early species help later species**: Nurse plants effect

### Tolerance Model

**Later species outcompete early ones**: Competitive exclusion

## Intermediate Disturbance

**Intermediate disturbance hypothesis**:
- Moderate disturbance = maximum diversity
- Too little or too much = lower diversity
- Forest fires, windthrows can maintain diversity

## Sources
- CK-12 Biology: "Communities"
- Khan Academy: "Ecological Succession"
- OpenStax Ecology: "Community Ecology"
',

  '[
    {
      "question": "What is the main difference between primary and secondary succession?",
      "options": ["Primary succession starts after a glacier retreats, secondary starts after a fire", "Primary succession occurs on bare rock with no soil, secondary occurs where soil already exists", "Primary succession has pioneer species, secondary has late successional species"],
      "correctAnswer": 1,
      "explanation": "PRIMARY SUCCESSION occurs on BARE surfaces like rock, sand, or lava flows where NO SOIL exists. PIONEER SPECIES (lichens, mosses) must create soil first. SECONDARY SUCCESSION occurs where SOIL already exists - after disturbance like fire that leaves soil intact. Both involve gradual species replacement, but starting conditions differ!"
    },
    {
      "question": "What is facilitation in ecological succession?",
      "options": ["When early species compete with late species for resources", "When early species modify environment making it more suitable for later species", "When late species outcompete early species through superior competitive ability", "When nurse plants protect seedlings of later successional species"],
      "correctAnswer": 1,
      "explanation": "FACILITATION occurs when EARLY SUCCESSIONAL SPECIES modify environment in ways that HELP LATER SPECIES. Examples: nitrogen-fixing bacteria enrich soil, alder trees provide shade/shelter for spruce seedlings. The early species don\"t directly help later ones but create better conditions. This is distinct from competition where species directly interact!"
    },
    {
      "question": "What is the intermediate disturbance hypothesis?",
      "options": ["Disturbances always reduce biodiversity", "Moderate levels of disturbance can maintain maximum species diversity", "Species diversity is highest in late successional communities regardless of disturbance", "Fires are the only type of disturbance that creates biodiversity"],
      "correctAnswer": 1,
      "explanation": "The INTERMEDIATE DISTURBANCE HYPOTHESIS proposes that MODERATE, intermediate-interval disturbances (like fires, windthrows) maintain MAXIMUM DIVERSITY. Too little disturbance allows competitive K-selected species to dominate. Too much disturbance (clear-cutting) also reduces diversity. This explains why diverse ecosystems like some forests may need periodic disturbance!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: BIOMES AND GLOBAL ECOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'ecology' LIMIT 1),
  'Biomes and Global Ecology',
  'biomes-global-ecology',
  'Explore Earth\"s major biomes, climate patterns, biogeochemical cycles, and global environmental challenges.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'biomes-global-ecology' LIMIT 1),
  'Terrestrial Biomes',
  'terrestrial-biomes',
  1,
  '# Terrestrial Biomes

## What Is a Biome?

**Biome**: Large geographic region with similar climate and ecosystems.

## Major Terrestrial Biomes

### Tropical Rainforest

**Climate**: Hot, wet year-round (near equator)
**Rainfall**: >200 cm/year
**Temperature**: 20-30°C (constant)

**Characteristics**:
- Biodiversity: Highest of all biomes
- Canopy layers: Emergent, canopy, understory
- Nutrient cycling: Rapid (poor soils)
- Epiphytes: Plants growing on other plants

**Adaptations**:
- Buttress roots
- Drip tips
- Smooth leaf edges
- Large leaves (faster nutrient cycling)

### Savanna

**Climate**: Tropical wet-dry seasons
**Rainfall**: 50-150 cm/year
**Temperature**: 20-30°C

**Characteristics**:
- Grassland with scattered trees
- Fire-adapted ecosystem
- Grazing herbivores
- Nutrient-rich but drought-prone

### Desert

**Climate**: Extreme dry, extreme temperature variation
**Rainfall**: <25 cm/year
**Temperature**: Hot days, cold nights

**Characteristics**:
- Low precipitation
- Adaptations to water scarcity
- Nocturnal animals, crepuscular animals
- Succulent plants (water storage)
- Reptiles, amphibians

### Temperate Deciduous Forest

**Climate**: Four distinct seasons
**Rainfall**: 75-150 cm/year
**Temperature**: -30°C winter, 30°C summer

**Characteristics**:
- Deciduous trees (oak, maple, beech)
- Distinct growing season
- Rich understory, shrubs
- Seasonal animal migrations

### Temperate Rainforest

**Climate**: Mild seasonal variation
**Rainfall**: 200-400 cm/year
**Temperature**: 20-25°C

**Characteristics**:
- Evergreen broadleaf trees
- Epiphytes abundant
- Lianas, woody vines
- High biodiversity (though less than tropical)

### Taiga (Boreal Forest)

**Climate**: Long, cold winters
**Rainfall**: 40-100 cm/year
**Temperature**: -30°C winter, 20°C summer

**Characteristics**:
- Coniferous evergreen forests
- Acidic, nutrient-poor soils
- Permafrost in north
- Adapted animals (moose, wolves, lynx)

### Grassland (Temperate)

**Climate**: Moderate rainfall, seasonal drought
**Temperature**: Wide seasonal range

**Characteristics**:
- Dominated by grasses
- Few trees (often fire-maintained)
- Large grazing mammals
- Rich soils, high productivity

## Sources
- CK-12 Biology: "Biomes"
- Khan Academy: "Biomes"
- OpenStax Ecology: "The Biosphere"
- NASA: "Earth Observatory"
',

  '[
    {
      "question": "Which biome has the highest biodiversity?",
      "options": ["Desert", "Tropical rainforest", "Savanna", "Temperate deciduous forest"],
      "correctAnswer": 1,
      "explanation": "TROPICAL RAINFOREST has the HIGHEST BIODIVERSITY of all biomes due to: 1) Consistently warm, wet climate supporting year-round plant growth, 2) Complex vertical structure (canopy layers) creating numerous niches, 3) Abundant rainfall (200+ cm/year), 4) Rapid nutrient cycling despite poor soils. This combination allows more species to coexist than any other terrestrial biome on Earth!"
    },
    {
      "question": "What is the main adaptation of plants in desert biomes?",
      "options": ["Growing broad leaves to maximize photosynthesis", "Being drought-deciduous to survive dry periods", "Having deep root systems to find groundwater", "Being nocturnal to avoid extreme daytime heat"],
      "correctAnswer": 1,
      "explanation": "Desert plants adapt to EXTREME WATER SCARCITY through various strategies: 1) SUCCULENT tissues to store water, 2) DEEP ROOT systems to reach groundwater, 3) SPINY leaves to reduce water loss, 4) DORMANCY during drought, 5) Some are ANNUAL (complete life cycle in brief wet season). These adaptations allow survival in conditions where most plants would quickly die from dehydration!"
    },
    {
      "question": "Why do taiga (boreal forest) soils tend to be acidic and nutrient-poor?",
      "options": ["Cold temperatures prevent decomposition, so nutrients build up slowly", "Coniferous needles decompose slowly acidifying the soil", "Permafrost limits nutrient cycling and root growth", "Low rainfall prevents nutrient input to the soil"],
      "correctAnswer": 2,
      "explanation": "TAIGA soils are acidic and nutrient-poor because: 1) CONIFEROUS NEEDLES (high lignin) decompose very slowly, releasing organic acids slowly, 2) COLD TEMPERATURES slow decomposition and nutrient cycling, 3) Often underlain by PERMAFROST limiting deep root growth and nutrient access, 4) MODERATE LEAF-FALL and needle drop limit soil nutrient input. These conditions create challenging environment for most plant species!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'biomes-global-ecology' LIMIT 1),
  'Aquatic Biomes',
  'aquatic-biomes',
  2,
  '# Aquatic Biomes

## Freshwater Biomes

### Lakes and Ponds

**Lentic systems**: Still water (lakes, ponds).

**Thermal stratification**:
- **Epilimnion**: Warm surface layer
- **Hypolimnion**: Cold bottom layer
- **Thermocline**: Transition zone

**Turnover**: Spring and fall mixing in temperate lakes.

### Streams and Rivers

**Lotic systems**: Flowing water.

**Characteristics**:
- High oxygen
- Fresh water input
- Rapid nutrient cycling
- Current creates niches

### Wetlands

**Marshes**: Herbaceous vegetation, water-saturated soils.

**Swamps**: Forested wetlands.

**Bogs**: Acidic, sphagnum mosses.

**Functions**:
- Water filtration
- Flood control
- Wildlife habitat

### Estuaries

**Estuary**: Where river meets ocean.

**Characteristics**:
- Brackish water (mix of fresh and salt)
- High productivity
- Nursery habitat for fish
- Migratory birds stopover point

## Marine Biomes

### Coral Reefs

**Characteristics**:
- High biodiversity (\"rainforests of the sea\")
- Symbiotic relationships
- Calcium carbonate structures
- Warm, shallow waters required

**Threats**:
- Climate change (bleaching)
- Overfishing
- Pollution
- Ocean acidification

### Open Ocean

**Pelagic zone**: Open water beyond continental shelf.

**Characteristics**:
- Low productivity
- 70% of Earth\"s surface
- Deep ocean organisms

**Upwelling areas**: High nutrients, high productivity.

### Kelp Forests

**Structure**: Brown algae form underwater forests.

**Location**: Cold, nutrient-rich waters.

**Importance**:
- Habitat foundation
- Food source
- Storm buffering
- Carbon sequestration

## Sources
- CK-12 Biology: "Aquatic Biomes"
- Khan Academy: "Aquatic Biomes"
- OpenStax Ecology: "Aquatic Ecosystems"
- NASA: "Ocean Ecology"
',

  '[
    {
      "question": "What is the thermocline in a lake?",
      "options": ["The transition zone between warm surface water and cold deep water", "The boundary where light penetration stops in deep water", "The layer of water with the most consistent temperature regardless of season", "The mixing zone between different water layers in a lake"],
      "correctAnswer": 2,
      "explanation": "The THERMOCLINE is the layer with the most RAPID temperature change in a lake, not necessarily the mixing zone. In summer, surface water warms but a consistent thermocline may form at a certain depth. In winter, surface cools rapidly, and the thermocline may become more pronounced. This STRATIFICATION affects oxygen levels and nutrient cycling in lakes!"
    },
    {
      "question": "Why are coral reefs considered one of the most biodiverse ecosystems?",
      "options": ["Because they have the highest number of species of any marine ecosystem", "Because coral reefs provide habitat for 25% of all marine species", "Because warm tropical waters allow for maximum species coexistence", "Because coral organisms have evolved numerous symbiotic relationships"],
      "correctAnswer": 2,
      "explanation": "Coral reefs harbor ~25% of all MARINE SPECIES despite covering less than 1% of ocean floor. Their complex 3D structure provides NUMEROUS NICHES: branching corals, crevices, and holes. Combine WARM TROPICAL WATERS (stable temperatures, high light) with year-round productivity for MAXIMUM SPECIES RICHNESS. This combination creates unparalleled biodiversity comparable to tropical rainforests!"
    },
    {
      "question": "What is upwelling in marine ecosystems?",
      "options": ["When deep ocean currents bring nutrients to the surface", "When wind blows surface water away from coastal areas", "When seasonal changes cause deep water to rise and mix with surface water", "The movement of surface water toward coastal areas creating nutrient-rich conditions"],
      "correctAnswer": 2,
      "explanation": "UPWELLING occurs when wind pushes SURFACE WATER toward shorelines, moving AWAY from coastal areas. This causes DEEP WATER to rise (often bringing nutrients) and creates NUTRIENT-RICH conditions near coasts. These areas support high PRIMARY PRODUCTIVITY (phytoplankton blooms), forming the base of marine food webs and important fisheries!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'biomes-global-ecology' LIMIT 1),
  'The Carbon Cycle',
  'carbon-cycle',
  3,
  '# The Carbon Cycle

## What Is the Carbon Cycle?

**Carbon cycle**: Movement of carbon through the Earth\"s spheres.

## Major Carbon Reservoirs

### Atmosphere

**CO₂**: Currently ~420 ppm (and rising)

**Forms**:
- Gaseous CO₂
- Dissolved CO₂ in oceans

### Biosphere

**Terrestrial**:
- Living biomass (plants, animals)
- Dead organic matter
- Soil carbon

**Oceanic**:
- Dissolved CO₂
- Marine biomass (phytoplankton, fish)
- Seafloor sediments

### Fossil Carbon

**Fossil fuels**:
- Coal
- Oil
- Natural gas

**Carbon stored** underground for millions of years.

## Carbon Flux Processes

### Photosynthesis

**Carbon fixation**:
$$6\text{CO}_2 + 6\text{H}_2\text{O} \xrightarrow{\text{C}_6\text{H}_{12}\text{O}_6$$

**Net primary production**:
- Stores carbon in biomass
- Removes CO₂ from atmosphere

### Respiration

**Cellular respiration**:
$$\text{C}_6\text{H}_{12}\text{O}_6 + 6\text{O}_2 \rightarrow 6\text{CO}_2 + 6\text{H}_2\text{O}$$

**Returns carbon** to atmosphere:
- Releases CO₂ through respiration
- Decomposition returns carbon to atmosphere

### Decomposition

**Decomposer** organisms break down organic matter.

**Process**:
$$\text{Organic matter} \xrightarrow{\text{CO}_2 + \text{Water} + \text{Nutrients}}$$

**Rate factors**:
- Temperature (warmer = faster)
- Moisture (optimal)
- Oxygen availability

## Human Impacts

### Fossil Fuel Combustion

$$\text{C} + \text{O}_2 \rightarrow \text{CO}_2 + \text{Energy}$$

**Effects**:
- Adds CO₂ to atmosphere
- Deforestation releases stored carbon

### Land Use Change

**Deforestation**:
- Releases biomass carbon
- Reduces carbon uptake

**Afforestation**:
- Planting trees
- Increases carbon storage

## Sources
- CK-12 Biology: "Biogeochemical Cycles"
- Khan Academy: "Carbon Cycle"
- OpenStax Ecology: "The Carbon Cycle"
- NOAA: "Carbon Cycle Science"
',

  '[
    {
      "question": "What is the main process that removes carbon dioxide from the atmosphere?",
      "options": ["Photosynthesis", "Respiration and decomposition", "Oceanic uptake", "Weathering of rocks"],
      "correctAnswer": 1,
      "explanation": "PHOTOSYNTHESIS temporarily removes CO₂ from atmosphere (storing carbon in biomass). RESPIRATION and DECOMPOSITION return CO₂ to atmosphere as organisms break down organic matter for energy. These processes balance carbon uptake from atmosphere, maintaining relatively stable CO₂ levels over long time scales before human activities significantly altered the cycle!"
    },
    {
      "question": "What happens to carbon stored in fossil fuels when they are burned?",
      "options": ["It is converted into energy and released as CO₂", "It remains trapped underground as graphite", "It is converted into biomass and stored in plant tissues", "It combines with oxygen to form carbon dioxide and water"],
      "correctAnswer": 0,
      "explanation": "When FOSSIL FUELS (coal, oil, natural gas) are burned, CARBON that was stored underground for millions of years is COMBUSTED WITH OXYGEN, releasing energy as heat and returning CO₂ to the atmosphere. Some carbon becomes soot (elemental carbon) if combustion is incomplete. This process releases carbon that has been sequestered from the ancient atmosphere!"
    },
    {
      "question": "How does deforestation affect the carbon cycle?",
      "options": ["It increases atmospheric CO₂ levels", "It reduces the biosphere's ability to store carbon", "It releases carbon from soil and reduces future carbon uptake", "It has no significant effect on atmospheric CO₂ because plants regrow quickly"],
      "correctAnswer": 2,
      "explanation": "DEFORESTATION releases biomass carbon to atmosphere as trees are cut or burned, REDUCING the biosphere\"s carbon storage capacity. While regrowth can absorb some CO₂, the immediate effect is INCREASED atmospheric CO₂. Forest soils also contain carbon that is released and not replaced. Sustainable land management preserves the biosphere\"s role as a major carbon reservoir regulating atmospheric CO₂!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'biomes-global-ecology' LIMIT 1),
  'Climate and Weather',
  'climate-weather',
  4,
  '# Climate and Weather

## What Is Climate?

**Climate**: Long-term patterns of temperature, precipitation, humidity, and wind in a region.

## Climate Zones

### Tropical Zone

**Location**: Between 23.5°N and 23.5°S latitude
**Characteristics**:
- Warm year-round
- Small seasonal variation
- High precipitation

### Temperate Zones

**Location**: 23.5°N to 66.5°N latitude

**Four distinct seasons**: Spring, summer, fall, winter

### Polar Zones

**Arctic**: North of Arctic Circle (66.5°N to 90°N)
**Antarctic**: South of Arctic Circle

**Characteristics**:
- Extreme cold
- Low precipitation
- Strong seasonal daylight differences

## Atmospheric Circulation

### Solar Radiation

**Insolation**: Solar energy received at different latitudes.

**Equator**: Maximum direct solar radiation
**Poles**: Lower solar radiation (spread over larger area)

### Wind Patterns

**Trade winds**: Blow from east to west in tropics
**Westerlies**: Mid-latitude winds from west to east
**Polar easterlies**: High-latitude winds from east to west

## Weather Elements

### Temperature

**Factors affecting temperature**:
- Latitude
- Altitude
- Distance from water
- Ocean currents

### Humidity

**Relative humidity**: Percentage of moisture saturation in air

**Dew point**: Temperature at which air becomes saturated

### Precipitation

**Rain**: Liquid water drops
**Snow**: Ice crystals fall
**Sleet**: Rain freezes on ice pellets
**Hail**: Ice spheres in thunderstorms

## Sources
- CK-12 Biology: "Weather and Climate"
- Khan Academy: "Weather"
- NOAA: "Weather Education"
- NASA: "Climate Kids"
',

  '[
    {
      "question": "What is the main difference between weather and climate?",
      "options": ["Weather is short-term, climate is long-term", "Weather refers to daily conditions, climate refers to average patterns over 30+ years", "Weather is caused by atmospheric pressure, climate is caused by greenhouse gases", "Weather can be predicted accurately, climate cannot"],
      "correctAnswer": 1,
      "explanation": "WEATHER refers to short-term atmospheric conditions (temperature, rain, wind, humidity) over hours to days. CLIMATE refers to long-term PATTERNS (temperature, precipitation, seasonal cycles) averaged over 30+ YEARS. Weather is highly variable day-to-day, but climate is relatively stable and predictable over decades. Climate change is about long-term shifts in climate patterns!"
    },
    {
      "question": "Why do polar regions receive less solar radiation than the equator?",
      "options": ["The poles are always cloudy and block sunlight", "Sunlight hits the poles at a direct angle and is spread over larger surface area", "The poles are further from the sun during their winter months", "The equator is closer to the sun than the poles"],
      "correctAnswer": 1,
      "explanation": "Solar radiation is most DIRECT at the EQUATOR where sunlight strikes Earth\"s surface perpendicularly. At the POLES, sunlight strikes at an OBLIQUE ANGLE, spreading the same energy over a LARGER SURFACE AREA (the polar cap). Additionally, during their respective winter months, each pole is tilted further from the sun. This creates the coldest climates on Earth!"
    },
    {
      "question": "What is the dew point?",
      "options": ["The temperature at which relative humidity reaches 50%", "The temperature at which condensation begins in the atmosphere", "The temperature at which air becomes fully saturated with water vapor", "The temperature at which frost forms"],
      "correctAnswer": 2,
      "explanation": "The DEW POINT is the temperature at which air becomes SATURATED (100% relative humidity) and water vapor begins to condense into liquid water (dew or fog). When air temperature cools to the dew point, water vapor changes from gas to liquid. The dew point varies based on moisture content - more humid air has higher dew point temperatures!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'biomes-global-ecology' LIMIT 1),
  'Conservation Biology',
  'conservation-biology',
  5,
  '# Conservation Biology

## What Is Conservation Biology?

**Conservation biology**: Scientific study of protecting and restoring Earth\"s biodiversity and ecosystems.

## Biodiversity

### Species Diversity

**Species richness**: Number of different species in area.

**Species evenness**: Relative abundance of each species.

**Endemism**: Species found only in one geographic region.

**Biodiversity hotspots**: Regions with exceptionally high biodiversity and many endemics.

### Extinction

**Background extinction rate**: Natural rate of species loss.

**Mass extinctions**:
- Ordovician (445 MYA): 86% species lost
- Permian (299 MYA): 96% species lost
- Cretaceous (66 MYA): Dinosaurs + ammonites
- K-Pg (66 MYA): Dinosaurs + many more

**Current extinction rate**: 100-1000x background rate!

## Threats to Biodiversity

### Habitat Destruction

**Deforestation**:
- 50% of original forests gone
- Causes species loss

**Pollution**:
- Chemical contaminants
- Oil spills
- Plastic waste

**Climate change**:
- Shifting habitats faster than adaptation
- Ocean acidification
- Coral bleaching

### Invasive Species

**Characteristics**:
- Non-native species
- Rapid reproduction
- Outcompetes natives
- No natural predators

**Examples**:
- Zebra mussels in North America
- Cane toad in Australia
- Kudzu vine in Pacific islands

## Conservation Strategies

### In Situ Conservation

**Protecting species in natural habitat**:

**Protected areas**: National parks, wildlife reserves

**Examples**:
- Yellowstone National Park
- Serengeti (Tanzania)
- Galapagos Islands

### Ex Situ Conservation

**Captive breeding**:

**Zoos and botanical gardens**: Maintain genetic diversity

**Seed banks**: Store genetic material for future

**Cloning**: Last resort for endangered species

**Success stories**:
- California condor: Recovered from 27 individuals
- Gray whale: Population rebound from protection
- Giant panda: Habitat protection + breeding programs
- Bald eagle: DDT ban + habitat protection

## Sources
- CK-12 Biology: "Biodiversity"
- Khan Academy: "Biodiversity"
- OpenStax Ecology: "Conservation Biology"
- IUCN Red List: Threatened Species
',

  '[
    {
      "question": "What is the current rate of species extinction compared to background extinction rates?",
      "options": ["10-100 times lower than background rates", "100-1000 times background rates", "About 10,000 times higher than background", "Equal to background extinction rates"],
      "correctAnswer": 1,
      "explanation": "The CURRENT EXTINCTION RATE is estimated to be 100-1000 TIMES the natural BACKGROUND RATE. This HUMAN-CAUSED EXTINCTION CRISIS is far exceeding natural extinction patterns. While background extinction normally removes 1-5 species per million years, current rates are estimated at 100-1000 species per million years - primarily due to habitat destruction, climate change, pollution, and overexploitation!"
    },
    {
      "question": "What makes a species \"invasive\"?",
      "options": ["It is a non-native species that reproduces rapidly and outcompetes native species", "It is any species that is not native to an ecosystem", "It is a species that was introduced by humans and causes ecological harm", "It is a species that has no natural predators in its new environment"],
      "correctAnswer": 0,
      "explanation": "An INVASIVE SPECIES is non-native, reproduces rapidly, and OUTCOMPETES native species for resources like food, space, or light. The key factors are: 1) Introduction to new area (accidental or deliberate), 2) HIGH REPRODUCTIVE RATE, 3) ABSENCE OF NATURAL PREDATORS in new range, 4) COMPETITIVE ADVANTAGE. Examples include zebra mussels, cane toads, and kudzu vines!"
    },
    {
      "question": "What is the difference between in situ and ex situ conservation?",
      "options": ["In situ is protecting animals in their natural habitat, ex situ is breeding programs", "In situ is more effective for large animals, ex situ is more effective for plants", "In situ focuses on habitat, ex situ focuses on genetics"],
      "correctAnswer": 1,
      "explanation": "IN SITU conservation protects species IN THEIR NATURAL HABITAT through protected areas like national parks and marine reserves. EX SITU conservation involves CAPTIVE BREEDING PROGRAMS, ZOOS, SEED BANKS, and sometimes CLONING. In situ is preferred for large mobile species, while ex situ may be necessary when populations become critically small or fragmented. Both approaches are often used together!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: AQUATIC ECOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'ecology' LIMIT 1),
  'Aquatic Ecology',
  'aquatic-ecology',
  'Study freshwater and marine ecosystems: lakes, rivers, wetlands, estuaries, coral reefs, and open ocean dynamics.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'aquatic-ecology' LIMIT 1),
  'Freshwater Ecosystems',
  'freshwater-ecosystems',
  1,
  '# Freshwater Ecosystems

## Lotic Systems (Flowing Water)

### Stream Order

**Headwater**: Upper reaches of stream

**Characteristics**:
- High oxygen
- Cool temperature
- Fast flow

**Mid-reach**: Middle sections of stream

**Characteristics**:
- Warmer temperatures
- Slower flow
- More sediment accumulation

**Mouth**: Where stream enters lake or ocean.

### River Continuum Concept

**River continuum**: Gradient from headwaters to mouth.

**Changes**:
- Physical: Width, depth, speed
- Chemical: Nutrient levels, pollution
- Biological: Species composition along length

## Lentic Systems (Still Water)

### Lake Zonation

### Littoral Zone

**Area**: Near shore with rooted plants.

**Characteristics**:
- High light penetration
- Rooted vegetation (cattails, rushes)
- Fish nesting areas
- High biodiversity

### Limnetic Zone

**Area**: Open water beyond rooted plants.

**Characteristics**:
- Phytoplankton production
- Zooplankton (small animals)
- No large plants

### Profundal Zone

**Area**: Deep water below light penetration.

**Characteristics**:
- No photosynthesis (too dark)
- Decomposition dominates
- Cold, stable temperatures
- Accumulating sediments

## Lake Turnover

**Dimictic lakes**: Mix twice yearly (spring and fall).

**Warm monomictic lakes**: Mix rarely (tropical).

**Cold monomictic lakes**: Mix rarely (polar).

**Oligotrophic**: Low nutrient, high oxygen (clear).

**Eutrophic**: High nutrient, low oxygen (algae blooms).

## Wetlands

### Marshes

**Vegetation**: Herbaceous plants, grasses, sedges.

**Hydrology**: Water-saturated soils, standing water.

**Wildlife**: Waterfowl, amphibians, muskrats.

### Swamps

**Forest-ed wetlands**: Trees in standing water.

**Functions**:
- Water filtration
- Flood control
- Carbon storage

## Sources
- CK-12 Biology: "Freshwater Ecosystems"
- Khan Academy: "Freshwater Ecosystems"
- USGS: "Water Education"
',

  '[
    {
      "question": "What is the main difference between lotic and lentic systems?",
      "options": ["Lotic systems have flowing water, lentic systems have still water", "Lotic systems are colder than lentic systems", "Lotic systems have higher oxygen, lentic systems have more sediment", "Lotic systems are found in mountains, lentic systems are found in valleys"],
      "correctAnswer": 0,
      "explanation": "LOTIC systems have flowing water (streams and rivers), while LENTIC systems have still water (lakes, ponds, marshes). This affects oxygen levels, temperature, sediment transport, and biological communities. Lentic systems often develop thermal stratification, while lotic systems are more homogeneous. The terms derive from Latin: lotus (lake/washing pool) and lenticus (still)!"
    },
    {
      "question": "What is the thermocline in a lake?",
      "options": ["The warm surface layer extending to the bottom of the lake", "The cold bottom layer that does not mix with surface layers", "The boundary between warm surface waters and cold deep waters", "The layer where water temperature changes most rapidly with depth"],
      "correctAnswer": 1,
      "explanation": "In MEROMICTIC lakes that mix seasonally or DIMICTIC lakes, THERMAL STRATIFICATION occurs creating distinct layers: EPILIMNION (warm, well-oxygenated surface), METALIMNION (cold transition zone), and HYPOLIMNION (cold, oxygen-depleted bottom). The thermocline is the RAPID temperature change zone (metalimnion). This stratification affects nutrient cycling, oxygen distribution, and seasonal mixing patterns in lakes!"
    },
    {
      "question": "What determines whether a lake is oligotrophic or eutrophic?",
      "options": ["The amount of rainfall in the surrounding watershed", "The concentration of nitrogen and phosphorus in the water", "The clarity and oxygen content of the water", "The depth and volume of the lake"],
      "correctAnswer": 1,
      "explanation": "EUTROPHIC lakes have high NUTRIENT concentrations (nitrogen, phosphorus) often from agricultural runoff or wastewater. This stimulates ALGAE GROWTH (phytoplankton blooms), reducing water clarity and oxygen levels. OLIGOTROPHIC lakes have low nutrients, clear water, and high oxygen. Productivity and biodiversity follow the nutrient availability gradient in freshwater ecosystems!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'aquatic-ecology' LIMIT 1),
  'Marine Ecosystems',
  'marine-ecosystems',
  2,
  '# Marine Ecosystems

## Ocean Zones

### Pelagic Zone (Open Ocean)

**Characteristics**:
- Beyond continental shelf
- Low productivity
- Deep waters
- 70% of Earth\"s surface

**Organisms**:
- Phytoplankton (microscopic producers)
- Zooplankton (small herbivores)
- nekton (fish, squid)

### Neritic Zone (Coastal Waters)

**Characteristics**:
- Over continental shelf
- High productivity
- Upwelling areas

**Importance**:
- Major fishing grounds
- 80% of ocean fisheries

### Ocean Currents

**Gyres**:
- Circular ocean currents
- Driven by winds and Coriolis effect

**Thermohaline circulation**:
- Deep water formation
- Global heat distribution

## Marine Organisms

### Plankton

**Phytoplankton**: Microscopic algae (producers).

**Zooplankton**: Small animals (herbivores).

**Nekton**: Strong swimmers (fish, squid).

### Benthic Organisms

**Epifauna**: Live on sediment surface.

**Infauna**: Burrow in sediment.

## Coral Reef Ecosystems

### Structure

**Fringing reef**: Barrier reef (along coastline).

**Atoll**: Ring-shaped reef around submerged volcano.

### Coral Biology

**Symbiosis**: Corals + zooxanthellae (algae).

**Calcification**:
$$\text{Ca}^{2+} + \text{HCO}_3^- \rightleftharpoons \text{CaCO}_3 + \text{H}_2\text{O}$$

**Threats**:
- Bleaching (thermal stress)
- Ocean acidification (pH ↓)
- Crown-of-thorns starfish (predator)

## Upwelling and Downwelling

**Upwelling**: Wind pushes surface water away from coast, deep water rises.

**Downwelling**: Wind pushes surface water toward coast, deep water sinks.

**Ecological importance**: Upwelling brings nutrients, supporting high productivity.

## Sources
- CK-12 Biology: "Marine Ecosystems"
- Khan Academy: "Marine Biology"
- OpenStax Ecology: "Aquatic Ecology"
- NOAA: "Ocean Exploration"
',

  '[
    {
      "question": "What is the main difference between the neritic and pelagic zones?",
      "options": ["Neritic zone is deep water, pelagic zone is near shore", "Neritic zone is over continental shelf, pelagic zone is beyond continental shelf", "Neritic zone has high productivity, pelagic zone has low productivity"],
      "correctAnswer": 2,
      "explanation": "The NERITIC ZONE is the water over the CONTINENTAL SHELF (relatively shallow, typically <200m deep), known for HIGH PRODUCTIVITY due to nutrient upwelling and sunlight penetration. The PELAGIC ZONE is the open ocean BEYOND the continental shelf, characterized by DEEP WATERS and LOW PRODUCTIVITY (though it covers 70% of Earth\"s surface). Most marine fisheries occur in neritic waters!"
    },
    {
      "question": "What is coral calcification?",
      "options": ["The process by which corals build their calcium carbonate skeletons", "When corals absorb calcium ions from the water to strengthen their structure", "The breakdown of coral skeletons due to ocean acidification", "The symbiotic relationship between corals and algae that helps both organisms"],
      "correctAnswer": 0,
      "explanation": "CORAL CALCIFICATION is the process by which reef-building corals extract calcium and carbonate ions from seawater to build their hard skeletons. The chemical equation is: Ca²⁺ + 2HCO₃⁻ → CaCO₃ + H₂O + CO₂. This process creates the massive reef structures. Ocean acidification (decreased pH) makes calcification more difficult, dissolving skeletons and threatening coral reef ecosystems!"
    },
    {
      "question": "Why is upwelling ecologically important?",
      "options": ["It brings cold deep water to the surface for fishing", "It brings nutrients from the deep ocean to sunlit surface waters", "It causes surface water to move away from coastal areas creating nutrient-rich conditions", "It increases oxygen levels in surface waters through mixing with deep waters"],
      "correctAnswer": 1,
      "explanation": "UPWELLING occurs when winds push surface water AWAY from shore, causing DEEP WATER to rise and replace it. This deep water is NUTRIENT-RICH from decomposing organic matter. When it reaches the sunlit surface, it supports EXPLOSIVE PHYTOPLANKTON GROWTH. These areas become hotspots for marine productivity and fisheries, supporting entire ocean food webs!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 6: APPLIED ECOLOGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'ecology' LIMIT 1),
  'Applied Ecology',
  'applied-ecology',
  'Learn practical applications of ecology: sustainability, restoration, resource management, and human ecological footprint.',
  6,
  NOW()
);

-- LESSONS FOR CHAPTER 6
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'applied-ecology' LIMIT 1),
  'Sustainability',
  'sustainability',
  1,
  '# Sustainability

## What Is Sustainability?

**Sustainability**: Meeting present needs without compromising ability of future generations to meet their needs.

## Three Pillars of Sustainability

### Environmental Sustainability

**Protecting ecosystems**:
- Pollution control
- Habitat preservation
- Biodiversity conservation

### Economic Sustainability

**Renewable resources**:
- Solar, wind, geothermal
- Sustainable forestry
- Recycled materials

### Social Sustainability

**Human well-being**:
- Food security
- Health access
- Education equality
- Fair wages

## Ecological Footprint

**Footprint**: Amount of biologically productive land and water needed to support a person\"s lifestyle.

**Global average**: ~1.7 hectares per person (unsustainable)

**Sustainable target**: ~1.5 hectares per person

### I = P A T Equation

$$\text{I} = \text{P} \times \text{A}$$

**Impact**:
- Humanity uses 1.7 Earths (equivalent to 1.7 Earth\"s biocapacity)

## Sustainable Development

**Meeting needs, protecting environment**:
- Green building practices
- Renewable energy
- Public transportation
- Urban planning

## Sources
- United Nations SDGs
- CK-12 Biology: "Human Actions"
- Khan Academy: "Sustainability"
- EPA: "Sustainability"
',

  '[
    {
      "question": "What is the current global ecological footprint per person?",
      "options": ["~0.5 hectares per person", "~1.0 hectares per person", "~1.7 hectares per person (unsustainable)", "~2.5 hectares per person"],
      "correctAnswer": 2,
      "explanation": "The current GLOBAL ECOLOGICAL FOOTPRINT is approximately 1.7 GLOBAL HECTARES per person (gha). This means humanity uses resources equivalent to 1.7 Earth\"s biocapacity - we would need 1.7 Earths to sustainably support everyone. The sustainable target is about 1.5 gha per person within the safe operating space. At current consumption, we\"re overshooting Earth\"s carrying capacity by about 13%!"
    },
    {
      "question": "What does I = P × A represent in ecological footprint calculations?",
      "options": ["The impact of population on resources", "The balance between consumption and production", "The relationship between technology and sustainability", "The formula for calculating human environmental impact"],
      "correctAnswer": 1,
      "explanation": "The equation I = P × A represents IMPACT = POPULATION (P) times AFFLUENCE (A) - the average resources consumed per person. This calculates humanity\"s total ecological demand on Earth\"s biosphere. When I > P × A (using more resources than Earth can regenerate), we\"re in ECOLOGICAL OVERSHOOT and unsustainable. Reducing I requires lowering population or consumption (P) or improving technology (smaller A)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'applied-ecology' LIMIT 1),
  'Restoration Ecology',
  'restoration-ecology',
  2,
  '# Restoration Ecology

## Ecological Restoration

**Restoration**: Process of assisting recovery of an ecosystem that has been degraded, damaged, or destroyed.

## Restoration Approaches

### Natural Recovery

**Succession**: Allow natural regeneration.

**Example**: Forest fire allowing new growth.

**Limitations**: Slow process (decades to centuries).

### Active Restoration

**Assisted recovery**: Human intervention to accelerate recovery.

### Reforestation

**Planting trees**:
- Native species
- Mixed species
- Multiple rows

**Agroforestry**:
- Trees + crops/pasture
- Benefits: Food production, soil improvement
- Risks: Monocultures, soil degradation

### Wetland Restoration

**Rehabilitation**: Restore hydrological functions.

**Techniques**:
- Recontouring (restore natural water flow)
- Invasive species removal
- Native species replanting

### Mine Reclamation

**Soil replacement**: Cover toxic waste with layers.

**Techniques**:
- Topsoil replacement
- Contouring
- Revegetation
- Long-term monitoring

**Success stories**:
- Appalachian mine reclamation → hardwood forests
- Florida Everglades restoration → water flow recovered

## Ecosystem Services

**Provisioning services**: Benefits humans get from functioning ecosystems.

**Examples**:
- **Water purification**: Wetlands filter pollutants
- **Pollination**: Bees and other insects support agriculture
- **Carbon storage**: Forests sequester carbon
- **Flood control**: Wetlands absorb excess rainfall
- **Recreation**: Parks provide mental and physical health

## Sources
- CK-12 Biology: "Human Actions"
- Khan Academy: "Ecological Restoration"
- SER (Society for Ecological Restoration International): "Restoration Ecology"
',

  '[
    {
      "question": "What is the main difference between reforestation and afforestation?",
      "options": ["Reforestation is replanting with native species, afforestation is planting on land that never had forests", "Reforestation restores degraded land, afforestation creates new forests", "Reforestation uses mixed tree species, afforestation uses monoculture plantations"],
      "correctAnswer": 1,
      "explanation": "REFORESTATION replants degraded or cleared forest lands, often using NATIVE SPECIES mix to restore biodiversity. AFFORESTATION plants trees on land that historically was NOT forested (grasslands, shrublands). Both can increase forest cover, but reforestation aims to restore ecological function while afforestation aims to establish NEW tree cover. Reforestation typically has higher biodiversity value than afforestation monocultures!"
    },
    {
      "question": "What is ecological restoration?",
      "options": ["The process of building new ecosystems from scratch in damaged areas", "Assisting natural recovery processes while providing some guidance", "The rehabilitation of degraded ecosystems to their original state", "The active repair of damaged ecosystems using human intervention"],
      "correctAnswer": 2,
      "explanation": "ECOLOGICAL RESTORATION is the process of ASSISTING the recovery of an ecosystem that has been degraded, damaged, or destroyed. This can involve NATURAL RECOVERY (allowing succession), ACTIVE RESTORATION (human interventions like reforestation, wetland rehabilitation), or REHABILITATION (restoring to original state). The goal is to restore ecosystem STRUCTURE, FUNCTION, and COMPOSITION, not necessarily to some previous pristine condition!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'applied-ecology' LIMIT 1),
  'Human Impacts on Ecosystems',
  'human-impacts-ecosystems',
  3,
  '# Human Impacts on Ecosystems

## Pollution

### Air Pollution

**Primary pollutants**:
- Carbon monoxide (CO)
- Nitrogen oxides (NOₓ)
- Sulfur dioxide (SO₂)
- Particulates (PM₂.₅, PM₁₀)
- Volatile organic compounds (VOCs)

**Sources**:
- Vehicle emissions
- Industrial emissions
- Power plants
- Agricultural burning

**Effects**:
- Smog formation
- Acid rain
- Respiratory problems
- Climate change

### Water Pollution

**Point sources**: Sewage, industrial discharge.

**Non-point sources**: Agricultural runoff, urban runoff.

**Pollutants**:
- Nutrients (nitrogen, phosphorus) → Eutrophication
- Heavy metals (mercury, lead)
- Organic chemicals
- Oil spills
- Plastics

**Effects**:
- Algal blooms
- Fish kills
- Bioaccumulation in food chains

### Soil Pollution

**Causes**:
- Agricultural chemicals (pesticides, fertilizers)
- Industrial waste
- Mining activities
- Salinization (irrigation)

**Desertification**: Loss of fertile soil.

**Remediation**:
- Phytoremediation (plants clean soil)
- Microbial remediation (bacteria break down pollutants)

### Light Pollution

**Artificial light**: Streetlights, buildings, vehicles.

**Effects**:
- Disorients wildlife
- Alters sleep patterns
- Attracts insects to predators (increasing predation)

## Habitat Destruction

### Deforestation

**Drivers**:
- Agriculture (slash-and-burn)
- Logging (timber, pulp)
- Urban expansion
- Road building

**Impacts**:
- Biodiversity loss
- Carbon release
- Soil erosion
- Climate regulation changes

### Urbanization

**Sprawl**: Low-density urban expansion.

**Effects**:
- Habitat fragmentation
- Impervious surfaces (runoff)
- Heat islands (local warming)
- Wildlife displacement

## Invasive Species

**Pathways**:
- Pet trade release
- Ballast water (ship tanks)
- Shipping container transport
- Agricultural escape

**Economic impacts**:
- Crop damage ($ billions/year)
- Control costs
- Property damage
- Healthcare costs

## Sources
- CK-12 Biology: "Human Actions"
- Khan Academy: "Human Impacts"
- EPA: "Environmental Science"
',

  '[
    {
      "question": "What is eutrophication?",
      "options": ["The oxygen depletion of water bodies due to excessive algae growth", "The buildup of chemical nutrients in aquatic ecosystems causing biodiversity loss", "The warming of water bodies due to nutrient pollution from agricultural runoff", "The process by which nitrogen and phosphorus from fertilizers enter water systems"],
      "correctAnswer": 1,
      "explanation": "EUTROPHICATION occurs when excessive NUTRIENTS (especially nitrogen and phosphorus from fertilizers, sewage, or runoff) enter aquatic ecosystems. This causes ALGAL BLOOMS that block sunlight and deplete oxygen when they decompose, creating \"dead zones.\" The result is BIODIVERSITY LOSS as fish and other organisms die from lack of oxygen and habitat. Preventing eutrophication requires better nutrient management!"
    },
    {
      "question": "What is the primary environmental impact of urbanization/sprawl?",
      "options": ["Increased flooding risk due to more impermeable surfaces", "Habitat fragmentation isolating wildlife populations", "Heat island effect increasing local temperatures", "Loss of agricultural land at urban-rural interface"],
      "correctAnswer": 1,
      "explanation": "URBANIZATION creates IMPERVIOUS SURFACES (roads, buildings, concrete) that increase RUNOFF and FLOODING risk. The heat island effect (concrete absorbs and radiates heat) raises local temperatures. Wildlife HABITATS become FRAGMENTED by roads and development, isolating populations and preventing gene flow. These combined effects significantly alter local ecosystems and hydrology!"
    },
    {
      "question": "What is the hypoxic zone in marine ecosystems?",
      "options": ["The zone in the ocean with the highest biodiversity and productivity", "The shallow coastal waters where coral reefs grow", "The surface layer where oxygen concentration is lowest due to stratification", "The deep ocean zone where decomposers consume most of the oxygen"],
      "correctAnswer": 2,
      "explanation": "The HYPOXIC ZONE is the oxygen-minimum layer in oceans or lakes, typically below 2 mg/L. This occurs where STRATIFICATION prevents oxygen mixing to deep waters. Decomposers consume oxygen, and without replenishment from surface mixing, oxygen becomes depleted. Most marine life avoids hypoxic zones except for specially adapted organisms!"
    }
  ]',
  NOW()
);
