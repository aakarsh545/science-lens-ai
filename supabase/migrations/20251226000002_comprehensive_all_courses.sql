-- Add comprehensive lessons to ALL courses
-- Each course will have a full curriculum with chapters

-- ============================================
-- GENETICS - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'genetics-intro-full', 'Introduction to Genetics',
'# The Science of Heredity

## What is Genetics?
Genetics is the study of genes, genetic variation, and heredity in organisms. It explains how traits are passed from parents to offspring.

## Why Genetics Matters
- Explains family resemblances
- Understanding inherited diseases
- Crop and livestock improvement
- Forensic science and DNA testing
- Evolution and biodiversity

## A Brief History
- **1865**: Gregor Mendel discovers inheritance patterns
- **1953**: Watson and Crick discover DNA structure
- **1990**: Human Genome Project begins
- **2003**: Human genome sequencing completed
- **2020s**: CRISPR gene editing revolution

## Genes and DNA
- **DNA**: Molecule that carries genetic information
- **Genes**: Segments of DNA that code for traits
- **Chromosomes**: DNA packaged into structures
  - Humans: 46 chromosomes (23 pairs)
  - Each parent contributes 23 chromosomes

## Modern Applications
- Genetic testing for disease risk
- Gene therapy treatments
- Genetically modified organisms (GMOs)
- Personalized medicine',
10, 10,
'{
  "questions": [
    {
      "question": "How many chromosomes do humans typically have?",
      "options": ["23", "46 (23 pairs)", "92", "100"],
      "correct": 1,
      "explanation": "Humans have 46 chromosomes total, arranged in 23 pairs - one set from each parent."
    },
    {
      "question": "What is a gene?",
      "options": ["A chromosome", "A segment of DNA that codes for a trait", "A cell", "A protein"],
      "correct": 1,
      "explanation": "A gene is a specific segment of DNA that contains the instructions for a particular trait or function."
    }
  ]
}'::jsonb, 'Chapter 1: Foundations of Genetics'
FROM courses c WHERE c.slug = 'genetics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'genetics-modes', 'Modes of Inheritance',
'# How Traits Are Passed Down

## Mendelian Inheritance

### Autosomal Dominant
- Only one copy of gene needed
- Affected parent has 50% chance of passing trait
- Examples: Huntington disease, Marfan syndrome
- Appears in every generation

### Autosomal Recessive
- Two copies needed for trait to appear
- Parents are typically carriers (unaffected)
- 25% chance if both parents are carriers
- Examples: Cystic fibrosis, sickle cell anemia
- Can skip generations

### X-Linked Recessive
- Gene on X chromosome
- Males more frequently affected (XY)
- Females can be carriers
- Examples: Color blindness, hemophilia

### X-Linked Dominant
- Gene on X chromosome
- Affected males pass to all daughters
- Examples: Fragile X syndrome

## Non-Mendelian Inheritance

### Incomplete Dominance
- Heterozygote shows intermediate trait
- Example: Red + White = Pink flowers

### Codominance
- Both alleles expressed
- Example: Blood type AB

### Polygenic Inheritance
- Multiple genes affect one trait
- Examples: Height, skin color, eye color
- Results in continuous variation

### Mitochondrial Inheritance
- Inherited only from mother
- Affects both males and females
- Example: Some forms of deafness

## Pedigree Analysis
Family trees that show inheritance patterns:
- Circles = females, Squares = males
- Filled symbols = affected individuals
- Horizontal lines = mating
- Vertical lines = offspring',
20, 15,
'{
  "questions": [
    {
      "question": "What is the probability that two carriers of an autosomal recessive disorder will have an affected child?",
      "options": ["0%", "25%", "50%", "100%"],
      "correct": 1,
      "explanation": "Two carriers (Aa × Aa) have a 25% chance of having an affected child (aa), 50% chance of carrier, and 25% chance of unaffected non-carrier."
    },
    {
      "question": "Why are males more affected by X-linked recessive disorders?",
      "options": ["They have two X chromosomes", "They have only one X chromosome", "They have stronger genes", "They have more mutations"],
      "correct": 1,
      "explanation": "Males have only one X chromosome (XY), so a single recessive allele on that X will be expressed. Females have two X chromosomes, so a recessive allele can be masked."
    }
  ]
}'::jsonb, 'Chapter 2: Patterns of Inheritance'
FROM courses c WHERE c.slug = 'genetics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'genetics-dna-structure', 'DNA Structure and Replication',
'# The Molecule of Heredity

## DNA Structure

### Double Helix
- Discovered by Watson and Crick (1953)
- Two strands wound around each other
- Antiparallel: run in opposite directions

### Nucleotides
Building blocks of DNA:
- **Phosphate group**
- **Sugar (deoxyribose)**
- **Nitrogen base**: A, T, C, or G

### Base Pairing
- **A**denine pairs with **T**hymine (2 hydrogen bonds)
- **G**uanine pairs with **C**ytosine (3 hydrogen bonds)
- Complementary strands

### Sugar-Phosphate Backbone
- Sides of the DNA ladder
- Provides structural support
- Bases form the "rungs"

## DNA Replication

### Semi-Conservative
1. DNA unwinds (helicase)
2. Each strand serves as template
3. DNA polymerase adds complementary bases
4. Two identical DNA molecules produced
5. Each has one old strand, one new strand

### Replication Fork
- Y-shaped region where DNA is being copied
- Leading strand: Continuous synthesis
- Lagging strand: Fragmented synthesis (Okazaki fragments)

### Accuracy and Proofreading
- DNA polymerase has proofreading ability
- Error rate: ~1 in 10^7 nucleotides
- Mismatch repair fixes additional errors

## Chromatin Structure
- DNA wrapped around histone proteins
- Nucleosomes: DNA + histones
- Further coiling creates chromosomes
- Allows long DNA to fit in nucleus',
30, 20,
'{
  "questions": [
    {
      "question": "What does semi-conservative replication mean?",
      "options": ["DNA doesn''t replicate", "Each new DNA has one old strand and one new strand", "DNA is half copied", "Only some DNA is replicated"],
      "correct": 1,
      "explanation": "Semi-conservative replication means each new DNA molecule contains one original strand and one newly synthesized strand."
    },
    {
      "question": "Why is A paired with T and G paired with C?",
      "options": ["Random chance", "Complementary shapes and hydrogen bonding", "They are same size", "DNA polymerase decides"],
      "correct": 1,
      "explanation": "A and T, and G and C have complementary shapes that allow them to form specific numbers of hydrogen bonds (2 for A-T, 3 for G-C)."
    }
  ]
}'::jsonb, 'Chapter 3: Molecular Genetics'
FROM courses c WHERE c.slug = 'genetics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'genetics-mutations', 'Mutations and Change',
'# When DNA Changes

## What Are Mutations?
Changes in DNA sequence:
- Can be harmful, beneficial, or neutral
- Ultimate source of genetic variation
- Most are repaired by cell mechanisms

## Types of Mutations

### Point Mutations
Change in single nucleotide:
- **Silent**: No amino acid change
- **Missense**: One amino acid changed
- **Nonsense**: Creates stop codon

### Insertions/Deletions (Indels)
- Adding or removing nucleotides
- Can cause frameshift
- Changes all downstream amino acids

### Chromosomal Mutations
- **Duplication**: Section copied
- **Deletion**: Section lost
- **Inversion**: Section flipped
- **Translocation**: Section moved to another chromosome

### Copy Number Variations (CNVs)
- Large sections duplicated or deleted
- Contribute to genetic diversity
- Some associated with diseases

## Mutation Causes

### Spontaneous
- DNA replication errors
- Spontaneous chemical changes
- Natural radiation (cosmic rays, radon)

### Induced
- Chemical mutagens (cigarette smoke, asbestos)
- Radiation (X-rays, UV light)
- Biological agents (some viruses)

## DNA Repair
Cells have multiple repair mechanisms:
- **Mismatch repair**: Fixes replication errors
- **Excision repair**: Removes damaged sections
- **Double-strand break repair**: Rejoins broken DNA
- Defects in repair → increased cancer risk

## Mutations and Evolution
- Most mutations are neutral or harmful
- Beneficial mutations rare but important
- Provide raw material for natural selection
- Accumulate over millions of years',
40, 25,
'{
  "questions": [
    {
      "question": "What is a frameshift mutation?",
      "options": ["Change in one nucleotide", "Insertion or deletion that shifts reading frame", "Chromosome duplication", "Silent mutation"],
      "correct": 1,
      "explanation": "Frameshift mutations occur when nucleotides are inserted or deleted, shifting the reading frame and changing all downstream amino acids."
    },
    {
      "question": "Why are most mutations neutral or harmful?",
      "options": ["Mutations are rare", "Most changes disrupt protein function", "Cells prevent mutations", "DNA is perfect"],
      "correct": 1,
      "explanation": "Most random changes to a working system (like a protein) will disrupt its function rather than improve it."
    }
  ]
}'::jsonb, 'Chapter 4: Genetic Variation'
FROM courses c WHERE c.slug = 'genetics'
ON CONFLICT DO NOTHING;

-- ============================================
-- ECOLOGY - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'ecology-intro-full', 'Introduction to Ecology',
'# The Study of Organisms and Their Environment

## What is Ecology?
Study of interactions between:
- Organisms and their environment
- Different organisms
- Organisms and each other

## Levels of Organization
1. **Organism**: Individual living thing
2. **Population**: Same species, same area
3. **Community**: Different species, same area
4. **Ecosystem**: Living + non-living components
5. **Biome**: Large region with similar climate
6. **Biosphere**: All life on Earth

## Why Ecology Matters
- Understanding environmental problems
- Conservation of species
- Managing natural resources
- Predicting climate change impacts
- Sustainable development

## The Scope of Ecology
- **Behavioral ecology**: How organisms behave
- **Population ecology**: Population dynamics
- **Community ecology**: Species interactions
- **Ecosystem ecology**: Energy and nutrient flow
- **Landscape ecology**: Spatial patterns
- **Global ecology**: Biosphere processes

## Modern Ecological Challenges
- Climate change
- Habitat loss
- Invasive species
- Pollution
- Overexploitation
- Human population growth',
10, 10,
'{
  "questions": [
    {
      "question": "What is the difference between a population and a community?",
      "options": ["They are the same", "Population is one species, community is multiple species", "Community is one species, population is multiple species", "Population includes non-living things"],
      "correct": 1,
      "explanation": "A population consists of individuals of the same species in an area, while a community includes all different species in an area."
    },
    {
      "question": "What level of organization includes both living and non-living components?",
      "options": ["Population", "Community", "Ecosystem", "Organism"],
      "correct": 2,
      "explanation": "An ecosystem includes all living organisms (biotic) plus non-living (abiotic) components like water, soil, and climate."
    }
  ]
}'::jsonb, 'Chapter 1: Foundations of Ecology'
FROM courses c WHERE c.slug = 'ecology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'ecology-populations', 'Population Ecology',
'# Dynamics of Populations

## Population Growth

### Exponential Growth
Rapid, unchecked growth:
Nₜ = N₀ × eʳᵗ
- Occurs in ideal conditions
- Resources unlimited
- J-shaped curve
- Cannot continue indefinitely

### Logistic Growth
Realistic growth with limits:
- Resources become limiting
- Growth slows as N approaches K
- S-shaped curve
- Carrying capacity (K): Maximum sustainable population

## Factors Affecting Populations

### Density-Dependent Factors
Effects increase with population density:
- **Competition**: Resources limited
- **Predation**: Predators respond to prey density
- **Disease**: Spreads easier in crowded populations
- **Parasitism**: More hosts available

### Density-Independent Factors
Affect population regardless of density:
- **Weather**: Temperature, precipitation
- **Natural disasters**: Fires, floods, storms
- **Human activities**: Habitat destruction

## Life History Strategies

### r-Selected Species
- Many offspring
- Little parental care
- Early reproduction
- Short lifespan
- Examples: Insects, weeds, fish

### K-Selected Species
- Few offspring
- Much parental care
- Delayed reproduction
- Long lifespan
- Examples: Humans, elephants, whales

## Population Regulation
Populations regulated by:
- Resource limitation
- Predation
- Disease
- Competition
- Territoriality',
20, 15,
'{
  "questions": [
    {
      "question": "What is carrying capacity?",
      "options": ["Maximum reproduction rate", "Maximum population an environment can sustain", "Population size", "Growth rate"],
      "correct": 1,
      "explanation": "Carrying capacity (K) is the maximum population size that an environment can sustainably support given available resources."
    },
    {
      "question": "What is the main difference between r-selected and K-selected species?",
      "options": ["r-selected have fewer offspring", "K-selected have many offspring with little care", "r-selected have many offspring with little care, K-selected have few with much care", "No difference"],
      "correct": 2,
      "explanation": "r-selected species produce many offspring with little parental care (insects, fish), while K-selected species produce few offspring with extensive care (humans, elephants)."
    }
  ]
}'::jsonb, 'Chapter 2: Population Dynamics'
FROM courses c WHERE c.slug = 'ecology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'ecology-communities', 'Community Ecology',
'# Species Interactions

## Species Interactions

### Competition (-/-)
Both species harmed:
- **Resource competition**: Food, space, light
- **Competitive exclusion**: One species eliminates other
- **Niche partitioning**: Species divide resources to coexist
- **Character displacement**: Evolve differences to reduce competition

### Predation (+/-)
Predator benefits, prey harmed:
- **True predation**: Predator kills prey
- **Herbivory**: Animals eat plants
- **Parasitism**: Parasite harms host
- **Parasitoidism**: Larvae eat host alive

### Mutualism (+/+)
Both species benefit:
- **Obligate**: Required for survival
- **Facultative**: Beneficial but not required
- Examples: Mycorrhizae, pollination, clownfish/anemone

### Commensalism (+/0)
One benefits, one unaffected:
- Examples: Barnacles on whales, birds in trees
- Rare in nature - most interactions affect both

### Amensalism (-/0)
One harmed, one unaffected:
- Example: Tree shading small plants
- Allelopathy: Plants release chemicals harming others

## Trophic Structure

### Food Chains
Linear energy flow:
Producer → Primary consumer → Secondary consumer → Tertiary consumer

### Food Webs
Complex interconnected food chains
- More realistic
- Show multiple feeding relationships
- Energy flows through multiple paths

### Trophic Levels
1. Primary producers (autotrophs)
2. Primary consumers (herbivores)
3. Secondary consumers (carnivores)
4. Tertiary consumers (top carnivores)
5. Decomposers

## Ecological Niches

### Fundamental Niche
Full range of conditions species can tolerate

### Realized Niche
Actual range where species lives
- Limited by competition, predation
- Usually smaller than fundamental

### Niche Concepts
- **Generalist**: Broad niche (raccoons, cockroaches)
- **Specialist**: Narrow niche (koalas, pandas)
- **Keystone species**: Disproportionate impact on community',
30, 20,
'{
  "questions": [
    {
      "question": "What type of interaction is competition?",
      "options": ["+/+", "+/-", "-/-", "+/0"],
      "correct": 2,
      "explanation": "Competition is a -/- interaction because both species are harmed as they compete for limited resources."
    },
    {
      "question": "What is the difference between fundamental and realized niche?",
      "options": ["They are the same", "Fundamental is full potential range, realized is actual range with limitations", "Realized is larger than fundamental", "Neither exists in nature"],
      "correct": 1,
      "explanation": "Fundamental niche is the full range of conditions a species can potentially use, while realized niche is the actual range where it lives, limited by competition and other factors."
    }
  ]
}'::jsonb, 'Chapter 3: Community Interactions'
FROM courses c WHERE c.slug = 'ecology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'ecology-ecosystems', 'Ecosystem Ecology',
'# Energy and Matter Flow

## Energy Flow

### Laws of Thermodynamics
1. Energy cannot be created or destroyed
2. Energy conversions are not 100% efficient (some lost as heat)

### Energy Flow Through Ecosystems
Sun → Producers → Consumers → Decomposers

### Productivity
- **GPP**: Gross Primary Production (total energy captured)
- **NPP**: Net Primary Production (GPP - respiration)
- NPP available to consumers

### Ecological Pyramids
- **Energy pyramid**: 90% energy lost each level
- **Biomass pyramid**: Decreases at higher levels
- **Numbers pyramid**: Fewer organisms at higher levels
- Explains why food chains are limited to ~4-5 levels

### Ecological Efficiency
- Only ~10% energy transferred between trophic levels
- Rest lost as heat, waste, movement
- Limits number of trophic levels
- Explains why few top predators

## Biogeochemical Cycles

### Water Cycle
- Evaporation from surface
- Transpiration from plants
- Condensation → Precipitation
- Runoff → Groundwater → Oceans

### Carbon Cycle
- Producers: Remove CO₂ (photosynthesis)
- Consumers: Release CO₂ (respiration)
- Decomposers: Break down organic matter
- Fossil fuels: Stored carbon
- Human impact: Burning fuels increases atmospheric CO₂

### Nitrogen Cycle
- **Nitrogen fixation**: Bacteria convert N₂ to usable forms
- **Nitrification**: NH₄⁺ → NO₂⁻ → NO₃⁻
- **Assimilation**: Plants take up nitrogen
- **Ammonification**: Decomposers convert to NH₄⁺
- **Denitrification**: NO₃⁻ → N₂ (returns to atmosphere)

### Phosphorus Cycle
- No atmospheric component
- Weathering of rocks releases phosphate
- Taken up by plants
- Returned by decomposers
- Often limits plant growth

## Ecosystem Services
Benefits humans derive from ecosystems:
- **Provisioning**: Food, water, wood
- **Regulating**: Climate, floods, disease
- **Cultural**: Recreation, spiritual
- **Supporting**: Nutrient cycling, soil formation',
40, 25,
'{
  "questions": [
    {
      "question": "Why are food chains limited to 4-5 trophic levels?",
      "options": ["Not enough species", "Energy is lost at each level, so little remains for top levels", "Top predators are too big", "Climate change"],
      "correct": 1,
      "explanation": "Only about 10% of energy is transferred between trophic levels. After 4-5 transfers, there''s not enough energy left to support another level."
    },
    {
      "question": "What is the main difference between the carbon and phosphorus cycles?",
      "options": ["They are the same", "Carbon has atmospheric component, phosphorus does not", "Phosphorus has atmospheric component", "Neither cycle is important"],
      "correct": 1,
      "explanation": "The carbon cycle includes atmospheric CO₂, while phosphorus cycles only through rocks, soil, water, and organisms - there''s no gaseous phosphorus phase."
    }
  ]
}'::jsonb, 'Chapter 4: Ecosystem Dynamics'
FROM courses c WHERE c.slug = 'ecology'
ON CONFLICT DO NOTHING;

-- ============================================
-- ORGANIC CHEMISTRY - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'organic-intro-full', 'Introduction to Organic Chemistry',
'# The Chemistry of Carbon

## Why Carbon?
- Can form 4 covalent bonds
- Can bond to itself (chains, rings)
- Forms stable bonds with many elements
- Creates complex, diverse molecules
- Basis of all known life

## Hydrocarbons
Compounds containing only carbon and hydrogen:

### Alkanes
- Single bonds only
- Formula: CₙH₂ₙ₊₂
- Saturated with hydrogen
- Examples: Methane (CH₄), Ethane (C₂H₆), Propane (C₃H₈)
- Uses: Fuels, heating, cooking

### Alkenes
- At least one double bond
- Formula: CₙH₂ₙ
- Unsaturated
- Examples: Ethene (C₂H₄), Propene (C₃H₆)
- Uses: Plastics, polymers

### Alkynes
- At least one triple bond
- Formula: CₙH₂ₙ₋₂
- Very unsaturated
- Examples: Ethyne (acetylene)
- Uses: Welding torches

### Aromatic Hydrocarbons
- Benzene ring structure
- Special stability
- Examples: Benzene, Toluene
- Uses: Dyes, drugs, explosives

## Isomerism
Same formula, different arrangement:
- **Structural**: Different bonding patterns
- **Geometric**: Cis-trans (double bonds)
- **Optical**: Mirror images (chiral centers)

## Naming Organic Compounds
IUPAC system:
1. Identify longest carbon chain
2. Name substituents
3. Number carbons
4. Assemble name',
10, 10,
'{
  "questions": [
    {
      "question": "Why can carbon form so many different compounds?",
      "options": ["It''s magnetic", "It can form 4 bonds and bond to itself", "It''s radioactive", "It has special electrons"],
      "correct": 1,
      "explanation": "Carbon can form 4 covalent bonds and bond to itself in chains and rings of various lengths, enabling millions of different compounds."
    },
    {
      "question": "What is the difference between alkanes and alkenes?",
      "options": ["Alkanes have double bonds, alkenes don''t", "Alkenes have at least one double bond, alkanes have only single bonds", "No difference", "Alkenes have more hydrogen"],
      "correct": 1,
      "explanation": "Alkanes contain only single C-C bonds (saturated), while alkenes contain at least one C=C double bond (unsaturated)."
    }
  ]
}'::jsonb, 'Chapter 1: Organic Fundamentals'
FROM courses c WHERE c.slug = 'organic-chemistry'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'organic-functional-groups', 'Functional Groups',
'# The Reactive Parts of Molecules

## What are Functional Groups?
Specific groups of atoms that determine chemical properties:
- Site of chemical reactions
- Determine physical properties
- Used to classify organic compounds

## Hydrocarbons (as refresher)
- Alkyl: -CH₃, -C₂H₅
- Alkenyl: C=C
- Alkynyl: C≡C
- Phenyl: Benzene ring

## Oxygen-Containing Groups

### Hydroxyl (-OH)
- Alcohols and phenols
- Hydrogen bonding
- Polar, soluble in water
- Examples: Methanol, ethanol, cholesterol

### Carbonyl (C=O)
- **Aldehyde (-CHO)**: At end of chain
- **Ketone (C=O)**: In middle of chain
- Polar but no H-bonding (as hydrogen donor)

### Carboxyl (-COOH)
- Carboxylic acids
- Can donate H⁺ (acidic)
- Examples: Acetic acid (vinegar)
- Amino acids have carboxyl groups

### Ester (-COO-)
- Sweet smells
- Fruits, flowers
- Fats and oils
- Examples: Acetone, vanilla

### Ether (-O-)
- Oxygen between two carbons
- Relatively unreactive
- Examples: Diethyl ether (anesthetic)

## Nitrogen-Containing Groups

### Amino (-NH₂)
- Amines
- Basic (accept H⁺)
- Amino acids have amino groups
- Examples: Amino acids, alkaloids

### Amide (-CONH₂)
- Peptide bonds in proteins
- Very stable
- Examples: Proteins, nylon

## Other Important Groups

### Phosphate (-PO₄³⁻)
- Nucleic acids (DNA, RNA)
- ATP (energy currency)
- Cell membranes

### Sulfhydryl (-SH)
- Thiols
- Disulfide bonds in proteins
- Example: Cysteine (amino acid)

## Identifying Functional Groups
- Look for characteristic atoms
- Memorize structures
- Practice with many examples
- Understand properties of each group',
20, 15,
'{
  "questions": [
    {
      "question": "What functional group is found in all amino acids?",
      "options": ["Hydroxyl", "Carboxyl (-COOH) and amino (-NH₂)", "Carbonyl", "Phosphate"],
      "correct": 1,
      "explanation": "All amino acids contain both an amino group (-NH₂) and a carboxyl group (-COOH)."
    },
    {
      "question": "What type of compound has a hydroxyl group (-OH)?",
      "options": ["Alkenes", "Alcohols", "Esters", "Amines"],
      "correct": 1,
      "explanation": "Compounds containing a hydroxyl group (-OH) bonded to carbon are called alcohols."
    }
  ]
}'::jsonb, 'Chapter 2: Functional Groups'
FROM courses c WHERE c.slug = 'organic-chemistry'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'organic-reactions', 'Organic Reactions',
'# How Organic Molecules Change

## Reaction Mechanisms
Step-by-step pathways showing electron movement:

### Curved Arrow Notation
- Shows movement of electron pairs
- Arrow starts at electrons, ends at destination
- Essential tool for understanding reactions

## Types of Organic Reactions

### Addition Reactions
Add atoms across double/triple bonds:
- **Hydrogenation**: Add H₂ (alkenes → alkanes)
- **Halogenation**: Add X₂ (alkenes → dihaloalkanes)
- **Hydration**: Add H₂O (alkenes → alcohols)

### Elimination Reactions
Remove atoms to form double bonds:
- **Dehydration**: Remove H₂O (alcohols → alkenes)
- **Dehydrohalogenation**: Remove HX (alkyl halides → alkenes)

### Substitution Reactions
One atom replaces another:
- **Radical substitution**: Alkanes + halogens (UV light)
- **Nucleophilic substitution**: Nu⁻ replaces leaving group
  - SN1: Two-step, carbocation intermediate
  - SN2: One-step, backside attack

### Oxidation-Reduction
- **Oxidation**: Gain O, lose H
- **Reduction**: Lose O, gain H
- Examples: Alcohol → Aldehyde → Carboxylic acid

## Polymerization
Building large molecules from small ones:
- **Addition polymerization**: Alkenes
- **Condensation polymerization**: Monomers + loss of H₂O
- Examples: Polyethylene, nylon, proteins

## Reaction Conditions
- **Catalysts**: Lower activation energy
- **Temperature**: Affects rate
- **Solvent**: Medium for reaction
- **pH**: Affects acid/base reactions

## Why This Matters
Organic reactions explain:
- Drug synthesis
- Polymer production
- Metabolism in body
- Industrial processes',
30, 20,
'{
  "questions": [
    {
      "question": "What is the difference between SN1 and SN2 reactions?",
      "options": ["SN1 has one step, SN2 has two", "SN1 has two steps with carbocation intermediate, SN2 has one step with backside attack", "They are the same", "SN1 is faster"],
      "correct": 1,
      "explanation": "SN1 is a two-step process with a carbocation intermediate, while SN2 is a one-step process with backside attack by the nucleophile."
    },
    {
      "question": "What type of reaction converts an alkene to an alkane?",
      "options": ["Elimination", "Substitution", "Addition (hydrogenation)", "Oxidation"],
      "correct": 2,
      "explanation": "Hydrogenation adds hydrogen across the double bond of an alkene, converting it to an alkane."
    }
  ]
}'::jsonb, 'Chapter 3: Organic Reactions'
FROM courses c WHERE c.slug = 'organic-chemistry'
ON CONFLICT DO NOTHING;

-- ============================================
-- NEUROBIOLOGY - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'neuro-intro-full', 'Introduction to Neurobiology',
'# The Science of the Nervous System

## What is Neurobiology?
Study of the nervous system:
- Structure and function of neurons
- Neural circuits and signaling
- Brain development and plasticity
- Neural basis of behavior and cognition

## Why Neurobiology Matters
- Understanding brain disorders
- Developing treatments
- Artificial intelligence inspiration
- Understanding consciousness
- Improving learning and memory

## The Nervous System Overview

### Central Nervous System (CNS)
- **Brain**: Processing center
  - Cerebrum: Thinking, memory, reasoning
  - Cerebellum: Coordination, balance
  - Brainstem: Vital functions
- **Spinal cord**: Communication pathway

### Peripheral Nervous System (PNS)
- **Sensory neurons**: Carry information TO CNS
- **Motor neurons**: Carry information FROM CNS
- **Autonomic**: Involuntary functions
- **Somatic**: Voluntary movements

## Neurons vs Glia

### Neurons
- Send electrical signals
- ~100 billion in human brain
- Specialized for communication

### Glial Cells
- Support neurons
- More numerous than neurons
- Types: Astrocytes, oligodendrocytes, microglia
- Essential for neural function

## Historical Highlights
- **Ancient Egypt**: Recognized brain as organ
- **1600s**: Beginning of modern neuroscience
- **1890s**: Neuron doctrine established
- **1952**: Hodgkin-Huxley model of action potential
- **1990s**: Decade of the Brain
- **2020s**: Brain mapping, connectomics',
10, 10,
'{
  "questions": [
    {
      "question": "What is the main difference between the CNS and PNS?",
      "options": ["They are the same", "CNS is brain and spinal cord, PNS includes all other nerves", "PNS is brain, CNS is nerves", "No difference"],
      "correct": 1,
      "explanation": "The Central Nervous System (CNS) consists of the brain and spinal cord, while the Peripheral Nervous System (PNS) includes all the nerves outside the CNS."
    },
    {
      "question": "What is the primary function of glial cells?",
      "options": ["Sending electrical signals", "Supporting and nourishing neurons", "Storing memories", "Processing information"],
      "correct": 1,
      "explanation": "Glial cells provide support, nutrition, and protection for neurons, though they don''t send electrical signals themselves."
    }
  ]
}'::jsonb, 'Chapter 1: Nervous System Overview'
FROM courses c WHERE c.slug = 'neurobiology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'neuron-structure', 'Neuron Structure and Function',
'# The Building Blocks of the Nervous System

## Neuron Structure

### Cell Body (Soma)
- Contains nucleus
- Protein synthesis
- Metabolic center
- Receives signals from dendrites

### Dendrites
- Branched extensions
- Receive signals from other neurons
- Increase surface area for connections
- Multiple dendrites per neuron

### Axon
- Long projection carrying signals AWAY
- Can be very long (up to 1 meter)
- Covered in myelin sheath
- Ends at axon terminals

### Myelin Sheath
- Insulating layer around axon
- Made by Schwann cells (PNS) or oligodendrocytes (CNS)
- Speeds up signal transmission
- Nodes of Ranvier: Gaps in myelin

### Axon Terminals
- Release neurotransmitters
- Connect to next neuron
- Synaptic vesicles store chemicals
- Synapse: Connection point

## Types of Neurons

### Sensory Neurons
- Detect stimuli
- Send information TO CNS
- Examples: Vision, hearing, touch

### Motor Neurons
- Carry signals FROM CNS
- Control muscles and glands
- Enable movement

### Interneurons
- Connect other neurons
- Found in CNS
- Process information
- Most numerous type

## Neural Signaling

### Resting Potential
- Neuron at rest: -70 mV
- More negative inside than outside
- Maintained by ion pumps

### Action Potential
- Rapid depolarization
- All-or-nothing response
- Travels down axon
- ~100 m/s in myelinated neurons

## Synaptic Transmission
1. Action potential arrives
2. Calcium channels open
3. Neurotransmitters released
4. Bind to receptors on next neuron
5. Signal continues or stops',
20, 15,
'{
  "questions": [
    {
      "question": "What is the function of myelin sheath?",
      "options": ["Receive signals", "Insulate axon and speed up signal transmission", "Store neurotransmitters", "Make proteins"],
      "correct": 1,
      "explanation": "The myelin sheath insulates the axon and allows action potentials to travel faster via saltatory conduction."
    },
    {
      "question": "What is the resting potential of a typical neuron?",
      "options": ["0 mV", "+70 mV", "-70 mV", "-100 mV"],
      "correct": 2,
      "explanation": "The resting potential of a neuron is approximately -70 mV, meaning the inside is more negative than the outside."
    }
  ]
}'::jsonb, 'Chapter 2: Neuron Structure'
FROM courses c WHERE c.slug = 'neurobiology'
ON CONFLICT DO NOTHING;

-- ============================================
-- ROBOTICS - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'robotics-intro-full', 'Introduction to Robotics',
'# The Field of Robotics

## What is a Robot?
A machine capable of carrying out complex actions automatically:
- Programmable
- Can sense environment
- Can make decisions
- Can manipulate objects

## What is Robotics?
Interdisciplinary field combining:
- **Mechanical engineering**: Design and construction
- **Electrical engineering**: Circuits and sensors
- **Computer science**: Programming and AI
- **Control systems**: Movement and feedback

## Types of Robots

### Industrial Robots
- Manufacturing and assembly
- Welding, painting, material handling
- Precision and repeatability
- Work in dangerous environments

### Service Robots
- Perform useful tasks for humans
- Examples: Roomba, delivery robots, surgical robots
- Growing rapidly

### Mobile Robots
- Can move around environment
- Wheels, legs, tracks, propellers
- Autonomous vehicles

### Humanoid Robots
- Resemble human form
- Interact with human environments
- Examples: ASIMO, Sophia, Atlas

### Agricultural Robots
- Farming automation
- Harvesting, planting, monitoring
- Drones for crop monitoring

## Robot Components

### Sensors (Input)
- Vision: Cameras, lidar
- Touch: Force sensors
- Position: Encoders, gyroscopes
- Distance: Ultrasonic, infrared
- Sound: Microphones

### Actuators (Output)
- Electric motors
- Hydraulic systems
- Pneumatic systems
- Shape memory alloys
- Artificial muscles

### Controller (Brain)
- Microcontrollers
- Computers
- Control algorithms
- AI and machine learning

## Why Robotics Matters
- Automation increases efficiency
- Dangerous work made safe
- Precision surgery
- Space exploration
- Assisting elderly and disabled
- Scientific research',
10, 10,
'{
  "questions": [
    {
      "question": "Which engineering fields are combined in robotics?",
      "options": ["Only mechanical engineering", "Mechanical, electrical, and computer engineering", "Only computer science", "Only electrical engineering"],
      "correct": 1,
      "explanation": "Robotics is interdisciplinary, combining mechanical engineering (design), electrical engineering (circuits), and computer science (programming)."
    },
    {
      "question": "What is the main purpose of sensors in robots?",
      "options": ["To move the robot", "To provide information about the environment (input)", "To power the robot", "To make decisions"],
      "correct": 1,
      "explanation": "Sensors gather information about the robot''s environment, providing input for the robot''s control system to process."
    }
  ]
}'::jsonb, 'Chapter 1: Robotics Fundamentals'
FROM courses c WHERE c.slug = 'robotics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'robotics-sensing', 'Sensors and Perception',
'# How Robots Sense the World

## Vision Systems

### Cameras
- 2D images for recognition
- Stereo vision for depth
- RGB-D cameras (color + depth)
- High resolution but processing intensive

### Lidar (Light Detection and Ranging)
- Laser scanning
- Creates 3D point clouds
- Used in autonomous vehicles
- Accurate distance measurements
- Expensive but powerful

### Ultrasonic Sensors
- Sound wave reflection
- Distance measurement
- Cheap and reliable
- Used in parking sensors
- Limited range and resolution

### Infrared Sensors
- Heat detection
- Night vision
- Obstacle detection
- Line following robots

## Position and Orientation

### Encoders
- Measure wheel rotation
- Calculate distance traveled
- High precision
- Can accumulate errors

### Gyroscopes
- Measure rotation rate
- Detect orientation changes
- MEMS gyroscopes in smartphones
- Can drift over time

### Accelerometers
- Measure acceleration
- Detect movement
- Used for gesture control
- Gravity detection

### IMU (Inertial Measurement Unit)
- Combines accelerometer + gyroscope
- Tracks position and orientation
- Essential for drones and robots
- Sensor fusion for accuracy

## Touch and Force

### Force Sensors
- Measure contact force
- Essential for manipulation
- Prevent damage
- Enable safe human interaction

### Tactile Sensors
- Simulate human touch
- Pressure arrays
- Texture recognition
- Slip detection

## Environmental Sensors

### Temperature
- Thermal cameras
- Operating in extreme conditions

### Humidity
- Weather monitoring
- Indoor environment

### Gas and Chemical
- Air quality
- Leak detection
- Hazardous environments

## Sensor Fusion
Combining multiple sensors:
- Overcomes individual limitations
- Increases accuracy
- Provides redundancy
- Kalman filters for optimal estimation',
20, 15,
'{
  "questions": [
    {
      "question": "What is lidar used for in robotics?",
      "options": ["To detect sound", "To create 3D maps and measure distances using laser scanning", "To measure temperature", "To detect gases"],
      "correct": 1,
      "explanation": "Lidar uses laser scanning to create detailed 3D point cloud maps and accurately measure distances, commonly used in autonomous vehicles."
    },
    {
      "question": "Why is sensor fusion important?",
      "options": ["Sensors are expensive", "Combining sensors improves accuracy and reliability", "Robots only need one sensor", "Sensors don''t work alone"],
      "correct": 1,
      "explanation": "Sensor fusion combines data from multiple sensors to overcome individual limitations, improve accuracy, and provide redundant measurements."
    }
  ]
}'::jsonb, 'Chapter 2: Robot Sensing'
FROM courses c WHERE c.slug = 'robotics'
ON CONFLICT DO NOTHING;

-- ============================================
-- ENVIRONMENTAL SCIENCE - Complete Curriculum
-- ============================================

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'environment-intro-full', 'Introduction to Environmental Science',
'# Science of the Environment

## What is Environmental Science?
Interdisciplinary study of:
- Natural systems and processes
- Human impact on environment
- Solutions to environmental problems
- Sustainability and conservation

## Why It Matters
- Climate change is real and urgent
- Biodiversity loss accelerating
- Pollution affecting health
- Resource depletion
- Our future depends on it

## Earth Systems

### Atmosphere
- Layer of gases around Earth
- Weather and climate
- Protects from radiation
- Composition: 78% N₂, 21% O₂, 1% other

### Hydrosphere
- All water on Earth
- Oceans, lakes, rivers, groundwater
- Water cycle
- Essential for life

### Lithosphere
- Earth''s solid outer layer
- Rocks, soil, minerals
- Plate tectonics
- Soil formation

### Biosphere
- All living things
- Interactions with other systems
- Ecosystems
- Biodiversity

## Human Impact

### Population Growth
- Exponential growth
- ~8 billion and increasing
- Pressure on resources
- Urbanization

### Resource Use
- Fossil fuels (non-renewable)
- Minerals and metals
- Fresh water
- Forest and agriculture land

### Pollution
- Air pollution (smog, particulates)
- Water pollution (chemicals, plastics)
- Soil contamination
- Light and noise pollution

### Habitat Destruction
- Deforestation
- Urbanization
- Agriculture expansion
- Fragmentation

## Environmental Ethics
- Anthropocentrism: Human-centered
- Biocentrism: All life has value
- Ecocentrism: Ecosystems have value
- Sustainability: Meeting needs without compromising future',
10, 10,
'{
  "questions": [
    {
      "question": "What are the four main Earth systems?",
      "options": ["Land, sea, air, fire", "Atmosphere, hydrosphere, lithosphere, biosphere", "Rocks, water, air, life", "Earth, wind, water, fire"],
      "correct": 1,
      "explanation": "The four main Earth systems are atmosphere (gases), hydrosphere (water), lithosphere (rock/soil), and biosphere (living things)."
    },
    {
      "question": "What is sustainability?",
      "options": ["Using resources as fast as possible", "Meeting present needs without compromising future generations", "Not using any resources", "Only using renewable resources"],
      "correct": 1,
      "explanation": "Sustainability is meeting the needs of the present without compromising the ability of future generations to meet their own needs."
    }
  ]
}'::jsonb, 'Chapter 1: Earth Systems'
FROM courses c WHERE c.slug = 'environmental-science'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'environment-biodiversity', 'Biodiversity and Conservation',
'# The Variety of Life

## What is Biodiversity?
Variety of life at all levels:
- **Genetic diversity**: Within species
- **Species diversity**: Number and abundance of species
- **Ecosystem diversity**: Variety of habitats

## Why Biodiversity Matters

### Ecosystem Services
- **Provisioning**: Food, medicine, materials
- **Regulating**: Climate, disease, water purification
- **Cultural**: Recreation, spiritual, aesthetic
- **Supporting**: Nutrient cycling, soil formation

### Resilience
- Diverse ecosystems more stable
- Better recovery from disturbances
- Adaptation to change

### Economic Value
- Food security
- Tourism
- Pharmaceuticals
- Genetic resources for crops

## Threats to Biodiversity

### HIPPO Acronym
- **H**abitat loss: Primary threat
- **I**nvasive species: Outcompete natives
- **P**ollution: Harm to organisms
- **P**opulation growth: Resource pressure
- **O**verexploitation: Overharvesting

### Habitat Destruction
- Deforestation (~18 million acres/year)
- Urbanization
- Agriculture expansion
- Fragmentation: Isolates populations

### Invasive Species
- Non-native, harmful species
- No natural predators
- Outcompete natives
- Examples: Zebra mussels, kudzu, cane toads

### Overexploitation
- Overfishing
- Poaching
- Excessive hunting
- Unsustainable harvesting

### Climate Change
- Shifting habitats
- Coral bleaching
- Migration pattern changes
- Phenological mismatches

## Conservation Strategies

### Protected Areas
- National parks
- Marine reserves
- Wildlife refuges
- Varying levels of protection

### Sustainable Use
- Sustainable forestry
- Eco-friendly agriculture
- Responsible fishing
- Ecotourism

### Restoration
- Reforestation
- Habitat restoration
- Species reintroduction
- Ecosystem services recovery

### Captive Breeding
- Zoos and aquariums
- Breeding programs
- Reintroduction to wild
- Genetic management

## Success Stories
- Bald eagle recovery
- Bison restoration
- Whale conservation
- Giant panda recovery',
20, 15,
'{
  "questions": [
    {
      "question": "What does the HIPPO acronym stand for in conservation?",
      "options": ["A large animal", "Habitat loss, Invasive species, Pollution, Population, Overexploitation", "Happy Animals People Protect Order", "Habitats, Plants, Predators, Oceans"],
      "correct": 1,
      "explanation": "HIPPO stands for the five major threats to biodiversity: Habitat loss, Invasive species, Pollution, Population growth, and Overexploitation."
    },
    {
      "question": "Why is biodiversity important for ecosystem resilience?",
      "options": ["It isn''t important", "Diverse ecosystems are more stable and recover better from disturbances", "Only a few species matter", "Ecosystems are always stable"],
      "correct": 1,
      "explanation": "Biodiverse ecosystems have more species performing different functions, making them more stable and better able to recover from disturbances."
    }
  ]
}'::jsonb, 'Chapter 2: Biodiversity'
FROM courses c WHERE c.slug = 'environmental-science'
ON CONFLICT DO NOTHING;
