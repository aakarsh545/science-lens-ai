-- Comprehensive Chemistry and Biology Courses
-- Full curriculum from beginner to advanced with structured chapters

-- ============================================
-- COMPREHENSIVE CHEMISTRY - Complete Curriculum
-- ============================================

-- Level 1: Everyone Knows This (order_index 10-19)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-everyday', 'Chemistry in Your Daily Life',
'# Chemistry is All Around You!

You experience chemistry every single day, often without realizing it.

## Morning Chemistry
- **Brushing teeth**: Fluoride compounds strengthen tooth enamel
- **Breakfast**: Toast browns (Maillard reaction), eggs cook (protein denaturation)
- **Soap**: Surfactants that break down grease and oils

## Cooking is Chemistry!
Every cooking technique is a chemical reaction:
- **Baking**: Chemical leavening (baking soda + acid)
- **Frying**: Maillard reaction creates flavors
- **Fermentation**: Yeast converts sugars to alcohol and CO₂

## Cleaners and Chemistry
- **Detergents**: Break down surface tension
- **Bleach**: Oxidizing agent that breaks down colored compounds
- **Vinegar**: Acid that dissolves mineral deposits

## Your Body is a Chemical Factory
- Digestion breaks down food into nutrients
- Blood carries oxygen via hemoglobin
- DNA stores genetic information
- Nerves transmit electrical signals

Chemistry isn''t just in labs - it''s the science of everything you touch, eat, and use!',
10, 10,
'{
  "questions": [
    {
      "question": "What happens when you bake bread?",
      "options": ["Nothing changes", "Yeast converts sugars to gas, making bread rise", "The bread disappears", "Magic happens"],
      "correct": 1,
      "explanation": "Yeast ferments sugars, producing carbon dioxide gas that gets trapped in the dough, causing it to rise."
    },
    {
      "question": "Why does vinegar clean mineral deposits?",
      "options": ["It''s a base", "It''s an acid that dissolves minerals", "It''s radioactive", "It''s a soap"],
      "correct": 1,
      "explanation": "Vinegar contains acetic acid, which reacts with and dissolves alkaline mineral deposits like limescale."
    }
  ]
}'::jsonb, 'Chapter 1: Chemistry in Your World'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-matter-states', 'States of Matter',
'# Solid, Liquid, Gas: The Three States

## What Determines State?
The arrangement and motion of particles determine the state of matter:
- **Temperature**: Higher temperature = more particle motion
- **Pressure**: Higher pressure = particles forced closer together

## Solids
- Fixed shape and volume
- Particles vibrate in fixed positions
- Strong forces between particles
- Examples: Ice, rock, metal

## Liquids
- Fixed volume, takes shape of container
- Particles slide past each other
- Moderate forces between particles
- Examples: Water, oil, blood

## Gases
- No fixed shape or volume
- Particles move freely at high speeds
- Weak forces between particles
- Examples: Air, steam, helium

## Changes of State
**Melting**: Solid → Liquid (add energy)
**Freezing**: Liquid → Solid (remove energy)
**Evaporation**: Liquid → Gas (add energy)
**Condensation**: Gas → Liquid (remove energy)
**Sublimation**: Solid → Gas (dry ice!)

## Plasma: The Fourth State
At extremely high temperatures, electrons are stripped from atoms:
- Makes up 99% of visible universe
- Found in stars, lightning, auroras
- Conducts electricity

## Why This Matters
Understanding states of matter helps us:
- Choose materials for construction
- Design heating and cooling systems
- Predict weather patterns
- Create new materials',
11, 10,
'{
  "questions": [
    {
      "question": "What happens to particle motion as temperature increases?",
      "options": ["Particles slow down", "Particles move faster", "Particles stop moving", "Particles get larger"],
      "correct": 1,
      "explanation": "Higher temperature means more energy, causing particles to move faster."
    },
    {
      "question": "What is sublimation?",
      "options": ["Gas to liquid", "Liquid to solid", "Solid directly to gas", "Liquid to gas"],
      "correct": 2,
      "explanation": "Sublimation is when a solid turns directly into a gas without becoming liquid first, like dry ice."
    }
  ]
}'::jsonb, 'Chapter 1: Chemistry in Your World'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

-- Level 2: Basic Understanding (order_index 20-29)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-atoms-elements', 'Atoms and Elements',
'# The Building Blocks of Matter

## What is an Atom?
The smallest unit of ordinary matter:
- **Protons**: Positive charge, in nucleus
- **Neutrons**: No charge, in nucleus
- **Electrons**: Negative charge, orbit nucleus

## Elements
Pure substances made of only one type of atom:
- Each element has unique atomic number (number of protons)
- Represented by chemical symbols (H, O, C, Na)
- Organized in the Periodic Table

## Key Elements to Know
- **H (Hydrogen)**: Most abundant element in universe
- **He (Helium)**: Second most abundant, inert gas
- **C (Carbon)**: Basis of organic chemistry
- **N (Nitrogen)**: 78% of Earth''s atmosphere
- **O (Oxygen)**: Essential for respiration
- **Na (Sodium)**: Table salt component
- **Cl (Chlorine)**: Table salt component
- **Fe (Iron)**: Blood hemoglobin, steel

## Atomic Structure
- **Nucleus**: Contains protons and neutrons
- **Electron shells**: Orbit the nucleus in specific energy levels
- **Most of an atom is empty space!**

## Isotopes
Same element, different number of neutrons:
- Carbon-12 (6 protons, 6 neutrons) - most common
- Carbon-14 (6 protons, 8 neutrons) - radioactive, used in dating

## Why This Matters
Understanding atoms explains:
- Why elements behave differently
- How compounds form
- Radioactivity and nuclear power',
20, 15,
'{
  "questions": [
    {
      "question": "What determines which element an atom is?",
      "options": ["Number of electrons", "Number of protons", "Number of neutrons", "Size of the atom"],
      "correct": 1,
      "explanation": "The number of protons (atomic number) uniquely identifies an element."
    },
    {
      "question": "Where are protons and neutrons located in an atom?",
      "options": ["In electron shells", "In the nucleus", "Outside the atom", "Between atoms"],
      "correct": 1,
      "explanation": "Protons and neutrons are packed together in the dense nucleus at the center of the atom."
    }
  ]
}'::jsonb, 'Chapter 2: Atomic Structure'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-bonding', 'Chemical Bonding',
'# How Atoms Stick Together

## Why Atoms Bond?
Atoms are most stable with full outer electron shells:
- Most atoms need 8 electrons in outer shell (octet rule)
- They gain, lose, or share electrons to achieve this

## Types of Bonds

### Ionic Bonds
- Electrons transferred from one atom to another
- Creates positive and negative ions
- Ions attract each other
- Examples: Salt (NaCl), Magnesium oxide (MgO)

### Covalent Bonds
- Electrons shared between atoms
- Most common type of bond
- Examples: Water (H₂O), Methane (CH₄), Oxygen (O₂)

### Metallic Bonds
- Electrons delocalized (free to move)
- Metals conduct electricity and heat
- Malleable and ductile
- Examples: Copper, iron, gold

## Molecules vs Compounds
- **Molecule**: Two or more atoms bonded together
- **Compound**: Different elements chemically combined

## Predicting Bond Type
- Metal + Nonmetal → Ionic
- Nonmetal + Nonmetal → Covalent

## Bond Strength
- **Triple bonds**: Strongest (N≡N)
- **Double bonds**: Strong (C=O)
- **Single bonds**: Weakest (C-C)

## Why This Matters
Bonding explains:
- Why materials have different properties
- How drugs interact with body
- Why some substances conduct electricity',
21, 15,
'{
  "questions": [
    {
      "question": "What type of bond forms when electrons are transferred?",
      "options": ["Covalent", "Metallic", "Ionic", "Hydrogen"],
      "correct": 2,
      "explanation": "Ionic bonds form when electrons are transferred from one atom to another, creating ions that attract each other."
    },
    {
      "question": "What type of bond typically forms between two nonmetals?",
      "options": ["Ionic", "Covalent", "Metallic", "Nuclear"],
      "correct": 1,
      "explanation": "Nonmetals typically form covalent bonds by sharing electrons."
    }
  ]
}'::jsonb, 'Chapter 2: Atomic Structure'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-reactions', 'Chemical Reactions',
'# When Substances Change

## What is a Chemical Reaction?
Process where substances (reactants) transform into new substances (products):
- Bonds break and reform
- Atoms rearrange
- New properties emerge

## Signs of a Reaction
- Color change
- Gas produced (bubbles)
- Temperature change
- Precipitate forms (solid from liquids)
- Odor change
- Light emitted

## Types of Reactions

### Synthesis (Combination)
A + B → AB
- Example: 2H₂ + O₂ → 2H₂O

### Decomposition
AB → A + B
- Example: 2H₂O → 2H₂ + O₂ (electrolysis)

### Single Replacement
A + BC → AC + B
- Example: Zn + 2HCl → ZnCl₂ + H₂

### Double Replacement
AB + CD → AD + CB
- Example: AgNO₃ + NaCl → AgCl + NaNO₃

### Combustion
Fuel + O₂ → CO₂ + H₂O
- Example: CH₄ + 2O₂ → CO₂ + 2H₂O

## Balancing Equations
Law of Conservation of Mass:
- Atoms cannot be created or destroyed
- Same number of each atom on both sides

Example:
Unbalanced: H₂ + O₂ → H₂O
Balanced: 2H₂ + O₂ → 2H₂O

## Energy in Reactions
- **Exothermic**: Releases energy (gets hot)
- **Endothermic**: Absorbs energy (gets cold)

## Why This Matters
Chemical reactions power:
- Digestion and metabolism
- Combustion engines
- Battery operation
- Industrial processes',
22, 15,
'{
  "questions": [
    {
      "question": "What does it mean if a reaction is exothermic?",
      "options": ["Absorbs energy", "Releases energy", "Has no energy change", "Is nuclear"],
      "correct": 1,
      "explanation": "Exothermic reactions release energy, usually as heat."
    },
    {
      "question": "Why must chemical equations be balanced?",
      "options": ["To look better", "Because atoms cannot be created or destroyed", "To make gases", "For color changes"],
      "correct": 1,
      "explanation": "The Law of Conservation of Mass states that atoms cannot be created or destroyed in chemical reactions, so equations must balance."
    }
  ]
}'::jsonb, 'Chapter 3: Chemical Reactions'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-solutions', 'Solutions and Mixtures',
'# When Things Mix

## What is a Solution?
A homogeneous mixture of two or more substances:
- **Solute**: Substance being dissolved
- **Solvent**: Substance doing the dissolving
- Example: Salt water (salt = solute, water = solvent)

## Types of Mixtures

### Solutions
- Homogeneous (uniform throughout)
- Particles are molecule-sized
- Don''t settle on standing
- Cannot filter out solute
- Examples: Salt water, air, alloys

### Colloids
- Particles 1-1000 nm
- May appear cloudy
- Don''t settle on standing
- Example: Milk, fog, gelatin

### Suspensions
- Larger particles
- Settle on standing
- Can be filtered
- Example: Muddy water, blood

## Solubility
Maximum amount of solute that can dissolve:
- Depends on temperature
- Depends on pressure (for gases)
- "Like dissolves like" (polar dissolves polar)

## Concentration
Amount of solute in solution:
- **Molarity (M)**: Moles of solute per liter of solution
- **Percent composition**: Mass percentage

## Separation Techniques
- **Distillation**: Boiling point differences
- **Filtration**: Separate solids from liquids
- **Chromatography**: Separate based on affinity
- **Extraction**: Solvent preferences

## Why This Matters
Solutions are everywhere:
- Ocean water
- Atmospheric gases
- Biological fluids
- Medications and IV fluids',
23, 15,
'{
  "questions": [
    {
      "question": "What is the difference between a solution and a suspension?",
      "options": ["Suspensions are homogeneous, solutions are not", "Suspensions settle over time, solutions don''t", "Solutions have larger particles", "There is no difference"],
      "correct": 1,
      "explanation": "Suspensions contain larger particles that will settle over time, while solutions remain uniformly mixed."
    },
    {
      "question": "In a salt water solution, which is the solute?",
      "options": ["Water", "Salt", "Both", "Neither"],
      "correct": 1,
      "explanation": "The solute is the substance being dissolved (salt), while water is the solvent doing the dissolving."
    }
  ]
}'::jsonb, 'Chapter 3: Chemical Reactions'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

-- Level 3: Intermediate Concepts (order_index 30-39)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-periodic-table', 'The Periodic Table',
'# The Map of Elements

## Organization
Elements arranged by:
- **Atomic number** (left to right, top to bottom)
- **Similar properties** (vertical columns called groups)
- **Filling electron shells** (rows called periods)

## Major Regions

### Metals (left side)
- Shiny, conductive, malleable
- Lose electrons to form positive ions
- Examples: Na, Mg, Fe, Cu, Au

### Nonmetals (right side)
- Various properties, poor conductors
- Gain or share electrons
- Examples: C, N, O, Cl

### Metalloids (staircase line)
- Properties of both metals and nonmetals
- Semiconductors
- Examples: Si, Ge, As

## Important Groups
- **Group 1 (Alkali Metals)**: Very reactive, 1 valence electron
- **Group 2 (Alkaline Earth)**: Reactive, 2 valence electrons
- **Group 17 (Halogens)**: Very reactive nonmetals, 7 valence electrons
- **Group 18 (Noble Gases)**: Inert, full outer shells

## Periodic Trends
- **Atomic radius**: Decreases left→right, increases top→bottom
- **Electronegativity**: Increases left→right, decreases top→bottom
- **Ionization energy**: Increases left→right, decreases top→bottom

## Why This Matters
The periodic table predicts:
- Reactivity patterns
- Bonding behavior
- Physical properties
- Which reactions will occur',
30, 20,
'{
  "questions": [
    {
      "question": "Why are elements in the same group similar?",
      "options": ["They have the same mass", "They have the same number of valence electrons", "They were discovered at the same time", "They are the same color"],
      "correct": 1,
      "explanation": "Elements in the same group have similar chemical properties because they have the same number of valence electrons."
    },
    {
      "question": "What trend does electronegativity follow across a period?",
      "options": ["Decreases", "Increases", "Stays the same", "Random"],
      "correct": 1,
      "explanation": "Electronegativity increases from left to right across a period as atoms hold electrons more tightly."
    }
  ]
}'::jsonb, 'Chapter 4: The Periodic Table'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-organic-intro', 'Introduction to Organic Chemistry',
'# The Chemistry of Carbon

## Why Carbon?
Carbon is special because it can:
- Form 4 covalent bonds
- Bond to itself endlessly
- Form chains, rings, and complex structures
- Create millions of different compounds

## Hydrocarbons
Compounds containing only carbon and hydrogen:

### Alkanes (single bonds)
- Formula: CₙH₂ₙ₊₂
- Saturated with hydrogen
- Examples: Methane (CH₄), Propane (C₃H₈)
- Uses: Fuels, plastics

### Alkenes (double bonds)
- Formula: CₙH₂ₙ
- Unsaturated
- Examples: Ethene (C₂H₄)

### Alkynes (triple bonds)
- Formula: CₙH₂ₙ₋₂
- Very unsaturated
- Examples: Ethyne (acetylene)

## Functional Groups
Groups of atoms that give molecules specific properties:

- **Alcohols (-OH)**: Ethanol, methanol
- **Aldehydes (-CHO)**: Formaldehyde
- **Ketones (C=O)**: Acetone
- **Carboxylic acids (-COOH)**: Acetic acid (vinegar)
- **Amines (-NH₂)**: Amino acids, neurotransmitters
- **Esters (-COO-)**: Fruits, flavors

## Isomers
Same formula, different arrangement:
- **Structural**: Different bonding pattern
- **Geometric**: Same bonds, different spatial arrangement
- **Optical**: Mirror images

## Why This Matters
Organic chemistry is the chemistry of:
- Life (proteins, DNA, carbohydrates)
- Fuels and energy
- Plastics and synthetic materials
- Drugs and medicines
- Food and flavors',
31, 20,
'{
  "questions": [
    {
      "question": "Why can carbon form so many different compounds?",
      "options": ["It''s magnetic", "It can form 4 bonds and bond to itself", "It''s radioactive", "It has special electrons"],
      "correct": 1,
      "explanation": "Carbon can form 4 covalent bonds and bond to itself in chains, rings, and complex structures, enabling millions of compounds."
    },
    {
      "question": "What functional group is found in vinegar?",
      "options": ["Alcohol", "Carboxylic acid", "Amine", "Ketone"],
      "correct": 1,
      "explanation": "Vinegar contains acetic acid, which has the carboxylic acid functional group (-COOH)."
    }
  ]
}'::jsonb, 'Chapter 5: Organic Chemistry'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-biochemistry', 'Biochemistry Basics',
 '# Chemistry of Life

## Carbohydrates
Energy molecules and structural materials:
- **Monosaccharides**: Glucose, fructose (simple sugars)
- **Disaccharides**: Sucrose, lactose (two sugars)
- **Polysaccharides**: Starch, cellulose, glycogen (complex)

Formula: (CH₂O)ₙ

## Proteins
Built from amino acids:
- 20 different amino acids
- Amino acid structure: Amino group (-NH₂) + Carboxyl group (-COOH) + R group
- Peptide bonds link amino acids
- Four structure levels:
  1. Primary (sequence)
  2. Secondary (folding patterns)
  3. Tertiary (3D shape)
  4. Quaternary (multiple protein chains)

Functions:
- Enzymes (catalysts)
- Transport (hemoglobin)
- Structure (collagen)
- Defense (antibodies)

## Lipids
Hydrophobic molecules (insoluble in water):
- **Fats**: Long-term energy storage
- **Oils**: Liquid at room temperature
- **Phospholipids**: Cell membranes
- **Steroids**: Hormones (testosterone, estrogen)
- **Waxes**: Protection

## Nucleic Acids
Information storage and transfer:
- **DNA**: Double helix, genetic code
- **RNA**: Single strand, protein synthesis

Nucleotides: Sugar + Phosphate + Nitrogen base

## ATP
Energy currency of the cell:
- Adenosine triphosphate
- Releases energy when phosphate bonds break
- Powers all cellular processes

## Why This Matters
Biochemistry explains:
- How your body processes food
- Genetic inheritance
- Disease mechanisms
- Drug action',
32, 20,
'{
  "questions": [
    {
      "question": "What is the primary function of carbohydrates?",
      "options": ["Genetic storage", "Energy and structure", "Catalysis", "Transport"],
      "correct": 1,
      "explanation": "Carbohydrates primarily serve as energy sources (glucose) and structural materials (cellulose)."
    },
    {
      "question": "What bond links amino acids together in proteins?",
      "options": ["Hydrogen bond", "Peptide bond", "Ionic bond", "Covalent bond"],
      "correct": 1,
      "explanation": "Amino acids are linked by peptide bonds, formed between the amino group of one and the carboxyl group of another."
    }
  ]
}'::jsonb, 'Chapter 5: Organic Chemistry'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

-- Level 4: Advanced Concepts (order_index 40-49)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-equilibrium', 'Chemical Equilibrium',
'# Dynamic Balance

## What is Equilibrium?
In a reversible reaction, equilibrium is reached when:
- Forward and reverse rates are equal
- Concentrations remain constant (not zero!)
- System appears static but is actually dynamic

A + B ⇌ C + D

## Equilibrium Constant (K)
Ratio of products to reactants at equilibrium:

K = [C]ᶜ[D]ᵈ / [A]ᵃ[B]ᵇ

- K > 1: Products favored
- K < 1: Reactants favored
- K = 1: Equal amounts

## Le Chatelier''s Principle
If a system at equilibrium is disturbed, it shifts to counteract the change:

### Concentration changes
- Add reactant → Shift toward products
- Remove product → Shift toward products

### Pressure changes
- Increase pressure → Shift toward fewer gas molecules

### Temperature changes
- Exothermic reaction + heat → Add heat shifts toward reactants
- Endothermic + heat → Add heat shifts toward products

## Real-World Applications
- **Haber process**: Ammonia synthesis (N₂ + 3H₂ ⇌ 2NH₃)
- **Oxygen binding**: Hemoglobin + O₂ ⇌ Oxyhemoglobin
- **Carbonated drinks**: CO₂(g) ⇌ CO₂(aq)

## Why This Matters
Equilibrium controls:
- Industrial chemical production
- Drug-receptor binding
- Blood oxygen transport
- Buffer systems in body',
40, 25,
'{
  "questions": [
    {
      "question": "At equilibrium, are the concentrations of reactants and products zero?",
      "options": ["Yes, they are all consumed", "No, they remain constant but not zero", "Only products are zero", "Only reactants are zero"],
      "correct": 1,
      "explanation": "At equilibrium, concentrations remain constant but are not necessarily zero - forward and reverse reactions continue at equal rates."
    },
    {
      "question": "What does Le Chatelier''s Principle state?",
      "options": ["Reactions always go to completion", "Systems at equilibrium shift to counteract disturbances", "All reactions are reversible", "Temperature doesn''t affect equilibrium"],
      "correct": 1,
      "explanation": "Le Chatelier''s Principle states that if a system at equilibrium is disturbed, it shifts to counteract the change and re-establish equilibrium."
    }
  ]
}'::jsonb, 'Chapter 6: Chemical Equilibrium'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-acids-bases-advanced', 'Advanced Acid-Base Chemistry',
'# Beyond pH

## Brønsted-Lowry Definition
- **Acid**: Proton (H⁺) donor
- **Base**: Proton (H⁺) acceptor

More general than Arrhenius definition!

## Conjugate Acid-Base Pairs
When an acid donates H⁺, it becomes its conjugate base:
- HCl + H₂O → H₃O⁺ + Cl⁻
- HCl is acid, Cl⁻ is conjugate base
- H₂O is base, H₃O⁺ is conjugate acid

## Strong vs Weak Acids/Bases

### Strong Acids (completely dissociate)
- HCl, HBr, HI
- HNO₃, H₂SO₄, HClO₄

### Weak Acids (partially dissociate)
- CH₃COOH (acetic acid)
- H₂CO₃ (carbonic acid)

### Strong Bases
- NaOH, KOH
- Ca(OH)₂

### Weak Bases
- NH₃ (ammonia)
- Organic amines

## Buffer Solutions
Resist pH changes when small amounts of acid/base added:
- Weak acid + its conjugate base
- Example: CH₃COOH / CH₃COO⁻ (acetic acid/acetate)
- Blood: H₂CO₃ / HCO₃⁻ (carbonic acid/bicarbonate)

Henderson-Hasselbalch Equation:
pH = pKa + log([A⁻]/[HA])

## Acid-Base Titrations
Determining concentration of unknown acid/base:
- **Indicator**: Changes color at specific pH
- **Equivalence point**: Stoichiometrically equal amounts
- **pH curve**: Shows pH change during titration

## Why This Matters
Acid-base chemistry is crucial for:
- Blood pH regulation (7.35-7.45)
- Digestion (stomach acid pH ~2)
- Drug absorption and effectiveness
- Industrial processes',
41, 25,
'{
  "questions": [
    {
      "question": "According to Brønsted-Lowry theory, what is an acid?",
      "options": ["OH⁻ donor", "H⁺ donor", "Electron donor", "Oxygen donor"],
      "correct": 1,
      "explanation": "Brønsted-Lowry defines an acid as a proton (H⁺) donor."
    },
    {
      "question": "Why are buffer solutions important?",
      "options": ["They change color", "They resist pH changes", "They make things taste better", "They generate electricity"],
      "correct": 1,
      "explanation": "Buffers resist changes in pH when small amounts of acid or base are added, which is vital for maintaining blood pH."
    }
  ]
}'::jsonb, 'Chapter 6: Chemical Equilibrium'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

-- Level 5: Expert Level (order_index 50-59)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-thermodynamics', 'Chemical Thermodynamics',
'# Energy and Entropy in Chemistry

## The First Law
Energy is conserved:
ΔU = q + w
- ΔU: Change in internal energy
- q: Heat added to system
- w: Work done on system

## Enthalpy (H)
Heat content at constant pressure:
ΔH = H(products) - H(reactants)

- ΔH < 0: Exothermic (releases heat)
- ΔH > 0: Endothermic (absorbs heat)

## Hess''s Law
Total enthalpy change is independent of pathway:
- Can add reactions to get overall ΔH
- Use known ΔH values to find unknown

## Entropy (S)
Measure of disorder:
- More disorder = higher entropy
- Gases > Liquids > Solids
- Increases with temperature

## Gibbs Free Energy (G)
Predicts reaction spontaneity:
ΔG = ΔH - TΔS

- ΔG < 0: Spontaneous
- ΔG = 0: At equilibrium
- ΔG > 0: Non-spontaneous

## Temperature and Spontaneity
Four scenarios:
1. ΔH < 0, ΔS > 0: Spontaneous at all T
2. ΔH > 0, ΔS < 0: Non-spontaneous at all T
3. ΔH < 0, ΔS < 0: Spontaneous at low T
4. ΔH > 0, ΔS > 0: Spontaneous at high T

## Why This Matters
Thermodynamics explains:
- Why some reactions occur and others don''t
- How to optimize industrial processes
- Energy efficiency and sustainability
- The ultimate fate of the universe',
50, 30,
'{
  "questions": [
    {
      "question": "What does a negative ΔG indicate?",
      "options": ["Reaction is non-spontaneous", "Reaction is spontaneous", "Reaction is at equilibrium", "Reaction is impossible"],
      "correct": 1,
      "explanation": "A negative Gibbs free energy (ΔG < 0) indicates a spontaneous reaction."
    },
    {
      "question": "What happens to entropy when a solid dissolves in water?",
      "options": ["Decreases", "Increases", "Stays the same", "Becomes negative"],
      "correct": 1,
      "explanation": "When a solid dissolves, particles become more dispersed and free to move, increasing entropy."
    }
  ]
}'::jsonb, 'Chapter 7: Chemical Thermodynamics'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'chem-kinetics', 'Chemical Kinetics',
'# The Speed of Reactions

## Reaction Rate
Change in concentration per unit time:
Rate = -Δ[A]/Δt = Δ[B]/Δt

## Factors Affecting Rate

### Concentration
Higher concentration → More collisions → Faster rate

### Temperature
Higher T → Faster molecules → More collisions → More successful collisions

Rule: Rate doubles for every 10°C increase

### Surface Area
More surface area → More collision sites → Faster rate

### Catalysts
Lower activation energy without being consumed:
- Enzymes in body
- Catalytic converters in cars
- Industrial processes

## Rate Laws
Express how rate depends on concentration:
Rate = k[A]ˣ[B]ʸ

- k: Rate constant (temperature dependent)
- x, y: Reaction orders (from experiment)

## Collision Theory
Reactions occur when:
1. Molecules collide
2. With proper orientation
3. With sufficient energy (activation energy)

## Activation Energy (Eₐ)
Minimum energy needed for reaction:
- Lower Eₐ → Faster reaction
- Catalysts lower Eₐ

## Reaction Mechanisms
Step-by-step pathway:
- Elementary steps: Molecular-level events
- Rate-determining step: Slowest step controls overall rate

## Why This Matters
Kinetics explains:
- How long reactions take
- Food preservation (refrigeration)
- Engine efficiency
- Drug action time',
51, 30,
'{
  "questions": [
    {
      "question": "What effect does a catalyst have on a reaction?",
      "options": ["Increases activation energy", "Lowers activation energy without being consumed", "Changes the products", "Increases the temperature"],
      "correct": 1,
      "explanation": "Catalysts lower the activation energy needed for a reaction without being consumed in the process."
    },
    {
      "question": "Why does higher temperature increase reaction rate?",
      "options": ["It increases concentration", "Molecules move faster and collide with more energy", "It creates more molecules", "It changes the products"],
      "correct": 1,
      "explanation": "Higher temperature means molecules move faster and have more energy, leading to more frequent and energetic collisions."
    }
  ]
}'::jsonb, 'Chapter 8: Chemical Kinetics'
FROM courses c WHERE c.slug = 'chemistry-basics'
ON CONFLICT DO NOTHING;


-- ============================================
-- COMPREHENSIVE BIOLOGY - Complete Curriculum
-- ============================================

-- Level 1: Everyone Knows This (order_index 10-19)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-life-basics', 'What is Life?',
'# The Characteristics of Living Things

## What Makes Something Alive?

All living things share these characteristics:

### 1. Organization
- Made of one or more cells
- Complex, ordered structure
- Examples: Bacteria (one cell), humans (trillions of cells)

### 2. Metabolism
- Use energy for processes
- Transform energy from one form to another
- Examples: Photosynthesis, digestion

### 3. Homeostasis
- Maintain internal balance
- Regulate temperature, pH, water
- Examples: Sweating, shivering

### 4. Growth and Development
- Increase in size or complexity
- Follow genetic program
- Examples: Seeds growing, embryos developing

### 5. Response to Stimuli
- React to environment
- Detect and respond to changes
- Examples: Plants toward light, reflexes

### 6. Reproduction
- Produce offspring
- Pass on genetic information
- Examples: Seeds, eggs, cell division

### 7. Evolution
- Change over time
- Adapt to environment
- Populations evolve, individuals don''t

## Viruses: Alive or Not?
Viruses blur the line:
- Have genetic material
- Can evolve
- BUT need host cells to reproduce
- Most scientists say: NOT alive

## Why This Matters
Understanding life helps us:
- Distinguish living from non-living
- Understand health and disease
- Search for life on other planets',
10, 10,
'{
  "questions": [
    {
      "question": "Which is NOT a characteristic of life?",
      "options": ["Reproduction", "Response to stimuli", "Being made of concrete", "Metabolism"],
      "correct": 2,
      "explanation": "Living things must reproduce, respond to stimuli, and have metabolism. Being made of concrete is not a characteristic of life."
    },
    {
      "question": "Why are viruses considered not alive by many scientists?",
      "options": ["They don''t have DNA", "They cannot reproduce on their own", "They are too small", "They don''t evolve"],
      "correct": 1,
      "explanation": "Viruses need host cells to reproduce, which is why many scientists don''t consider them truly alive."
    }
  ]
}'::jsonb, 'Chapter 1: Foundations of Life'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-cells-intro', 'The Cell: Life''s Building Block',
'# The Basic Unit of Life

## Cell Theory
All living things are made of cells:
1. All organisms consist of one or more cells
2. Cell is the basic unit of life
3. All cells come from pre-existing cells

## Two Types of Cells

### Prokaryotic Cells (before nucleus)
- Simple, small (1-5 μm)
- No nucleus or membrane-bound organelles
- DNA free in cytoplasm
- Examples: Bacteria, archaea

### Eukaryotic Cells (true nucleus)
- Complex, larger (10-100 μm)
- Have nucleus and organelles
- DNA in nucleus
- Examples: Plants, animals, fungi, protists

## Cell Parts (Organelles)

### Nucleus
- Control center
- Contains DNA
- Surrounded by nuclear membrane

### Mitochondria
- Powerhouse of the cell
- Produce ATP (energy)
- Have their own DNA

### Ribosomes
- Make proteins
- Free or attached to ER

### Endoplasmic Reticulum (ER)
- **Rough ER**: Has ribosomes, makes proteins
- **Smooth ER**: No ribosomes, makes lipids

### Golgi Apparatus
- Packages and ships proteins
- Like a post office

### Lysosomes
- Digest waste and old organelles
- Recycling center

### Cell Membrane
- Controls what enters/exits
- Selectively permeable
- Phospholipid bilayer

## Plant vs Animal Cells
Plants have extra structures:
- **Cell wall**: Rigid support
- **Chloroplasts**: Photosynthesis
- **Large vacuole**: Storage and support

## Why This Matters
Understanding cells explains:
- How organisms function
- Disease processes
- How drugs work
- The unity of all life',
11, 10,
'{
  "questions": [
    {
      "question": "What is the main difference between prokaryotic and eukaryotic cells?",
      "options": ["Prokaryotes are larger", "Eukaryotes have a nucleus", "Prokaryotes have mitochondria", "Eukaryotes are always single-celled"],
      "correct": 1,
      "explanation": "Eukaryotic cells have a nucleus that contains their DNA, while prokaryotic cells lack a nucleus and have free-floating DNA."
    },
    {
      "question": "What is the function of mitochondria?",
      "options": ["Making proteins", "Producing energy (ATP)", "Storing DNA", "Digesting waste"],
      "correct": 1,
      "explanation": "Mitochondria are the powerhouses of the cell, producing ATP through cellular respiration."
    }
  ]
}'::jsonb, 'Chapter 1: Foundations of Life'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

-- Level 2: Basic Understanding (order_index 20-29)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-cell-membrane', 'The Cell Membrane',
'# The Gatekeeper of the Cell

## Structure
Fluid mosaic model:
- **Phospholipid bilayer**: Two layers of lipids
  - Hydrophilic heads (water-loving) face outward
  - Hydrophobic tails (water-fearing) face inward
- **Proteins**: Embedded for various functions
- **Cholesterol**: Stabilizes membrane

## Membrane Proteins

### Integral Proteins
- Extend through membrane
- Channels and pumps
- Receptors

### Peripheral Proteins
- Attached to surface
- Enzymes
- Structural support

## Transport Across Membrane

### Passive Transport (no energy required)
**Simple Diffusion**: Small molecules pass through
- Oxygen, carbon dioxide
- Move from high to low concentration

**Facilitated Diffusion**: Larger molecules use protein channels
- Glucose, amino acids
- Still high to low concentration

**Osmosis**: Water diffusion across membrane
- Water moves from low solute to high solute
- Crucial for cell survival

### Active Transport (requires energy - ATP)
- Move against concentration gradient
- Protein pumps use energy
- Examples: Sodium-potassium pump, proton pump

## Bulk Transport
**Endocytosis**: Cell takes in large materials
- Phagocytosis: "Cell eating"
- Pinocytosis: "Cell drinking"

**Exocytosis**: Cell releases large materials
- Secretion of hormones
- Removal of waste

## Why This Matters
The membrane controls:
- Nutrient uptake
- Waste removal
- Cell communication
- Drug effectiveness',
20, 15,
'{
  "questions": [
    {
      "question": "What is osmosis?",
      "options": ["Active transport of proteins", "Diffusion of water across a membrane", "Energy-dependent transport", "Bulk transport of materials"],
      "correct": 1,
      "explanation": "Osmosis is the passive diffusion of water across a semi-permeable membrane from an area of low solute concentration to high solute concentration."
    },
    {
      "question": "What is the difference between passive and active transport?",
      "options": ["Passive requires energy, active doesn''t", "Active requires energy, passive doesn''t", "Both require energy", "Neither requires energy"],
      "correct": 1,
      "explanation": "Active transport requires energy (ATP) to move substances against their concentration gradient, while passive transport does not require energy."
    }
  ]
}'::jsonb, 'Chapter 2: Cell Structure and Function'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-energy', 'Energy in Cells',
'# Powering Life''s Processes

## Cellular Respiration
Converting food into usable energy (ATP):

C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O + ATP

### Glycolysis (in cytoplasm)
- Glucose breaks into pyruvate
- Produces 2 ATP
- Anaerobic (no oxygen needed)

### Krebs Cycle (in mitochondria)
- Pyruvate broken down completely
- Produces 2 ATP
- Releases CO₂

### Electron Transport Chain (in mitochondria)
- Requires oxygen
- Produces 32-34 ATP
- Creates water

Total: ~36-38 ATP per glucose

## Fermentation (without oxygen)
When oxygen is unavailable:
- **Lactic acid fermentation**: Muscle fatigue, yogurt
- **Alcoholic fermentation**: Bread rising, alcohol production

## Photosynthesis (plants)
Converting light into chemical energy:

6CO₂ + 6H₂O + light → C₆H₁₂O₆ + 6O₂

### Light-Dependent Reactions
- Capture light energy
- Produce ATP and NADPH
- Release oxygen

### Light-Independent Reactions (Calvin Cycle)
- Use ATP and NADPH
- Make glucose from CO₂
- No direct light needed

## ATP: Energy Currency
Adenosine Triphosphate:
- Stores energy in phosphate bonds
- Powers all cellular work
- Constantly recycled

## Why This Matters
Energy flow explains:
- Why we need to breathe and eat
- How plants make food
- Muscle fatigue during exercise
- The basis of all food chains',
21, 15,
'{
  "questions": [
    {
      "question": "What is the net ATP production from one glucose molecule in cellular respiration?",
      "options": ["2 ATP", "12 ATP", "36-38 ATP", "100 ATP"],
      "correct": 2,
      "explanation": "Cellular respiration produces approximately 36-38 ATP molecules per glucose molecule through glycolysis, the Krebs cycle, and electron transport chain."
    },
    {
      "question": "Why is oxygen necessary for cellular respiration?",
      "options": ["To make glucose", "As final electron acceptor in electron transport chain", "To produce water", "To create ATP directly"],
      "correct": 1,
      "explanation": "Oxygen serves as the final electron acceptor in the electron transport chain, allowing the production of large amounts of ATP."
    }
  ]
}'::jsonb, 'Chapter 2: Cell Structure and Function'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-dna', 'DNA: The Genetic Material',
'# The Blueprint of Life

## DNA Structure
Double helix discovered by Watson and Crick (1953):

### Components
- **Nucleotides**: Building blocks
  - Phosphate group
  - Sugar (deoxyribose)
  - Nitrogen base (A, T, C, or G)

### Base Pairs
- **A**denine pairs with **T**hymine
- **G**uanine pairs with **C**ytosine
- Two hydrogen bonds between A-T
- Three hydrogen bonds between G-C

### Double Helix
- Two strands wound together
- Antiparallel (run opposite directions)
- Sugar-phosphate backbone on outside
- Bases on inside

## DNA Replication
Copying DNA before cell division:
1. Enzyme (helicase) unwinds DNA
2. Each strand serves as template
3. DNA polymerase adds matching bases
4. Two identical copies produced

Semi-conservative: Each new DNA has one old strand, one new strand

## Genes and Chromosomes
- **Gene**: Segment of DNA that codes for a protein
- **Chromosome**: Coiled DNA + proteins
  - Humans: 46 chromosomes (23 pairs)
  - Dogs: 78 chromosomes
  - Fruit flies: 8 chromosomes

## RNA: DNA''s Cousin
Differences from DNA:
- Single-stranded
- Ribose sugar (not deoxyribose)
- Uracil instead of Thymine
- Can act as enzyme (ribozymes)

## Why This Matters
DNA explains:
- How traits are inherited
- Genetic diseases
- Why offspring resemble parents
- Evolution and diversity',
22, 15,
'{
  "questions": [
    {
      "question": "Which nitrogen bases pair together in DNA?",
      "options": ["A-G and C-T", "A-T and G-C", "A-C and G-T", "A-A and T-T"],
      "correct": 1,
      "explanation": "Adenine (A) pairs with Thymine (T), and Guanine (G) pairs with Cytosine (C)."
    },
    {
      "question": "What is a gene?",
      "options": ["A chromosome", "A segment of DNA that codes for a protein", "A cell", "An enzyme"],
      "correct": 1,
      "explanation": "A gene is a specific segment of DNA that contains the instructions to make a particular protein or RNA molecule."
    }
  ]
}'::jsonb, 'Chapter 3: Genetics and DNA'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-protein-synthesis', 'From DNA to Protein',
'# How Cells Make Proteins

## Central Dogma
DNA → RNA → Protein

## Transcription: DNA → mRNA
In the nucleus:
1. DNA unwinds
2. RNA polymerase builds mRNA using DNA template
3. mRNA carries genetic code to cytoplasm

## The Genetic Code
Codons: 3-base sequences that specify amino acids:
- 64 possible codons
- 61 code for amino acids
- 3 are stop signals
- Redundant: multiple codons can code for same amino acid

Example: AUG codes for methionine (start codon)

## Translation: mRNA → Protein
At the ribosome:
1. mRNA codons read
2. tRNA brings matching amino acids
3. Amino acids link together
4. Protein chain grows

### tRNA: Transfer RNA
- Anticodon matches mRNA codon
- Carries specific amino acid
- Brings ingredients to ribosome

### Ribosome
- Small subunit: Reads mRNA
- Large subunit: Links amino acids
- Moves along mRNA like a machine

## Protein Folding
- Primary structure: Amino acid sequence
- Secondary: Alpha helices, beta sheets
- Tertiary: 3D shape
- Quaternary: Multiple protein chains

## Why This Matters
Protein synthesis explains:
- How genetic information becomes physical traits
- How mutations cause disease
- How antibiotics work (block bacterial protein synthesis)
- The basis of genetic engineering',
23, 15,
'{
  "questions": [
    {
      "question": "What is a codon?",
      "options": ["A type of protein", "A three-base sequence that codes for an amino acid", "A type of cell", "A segment of DNA"],
      "correct": 1,
      "explanation": "A codon is a sequence of three nucleotides that specifies a particular amino acid or stop signal during protein synthesis."
    },
    {
      "question": "What is the role of tRNA in protein synthesis?",
      "options": ["Stores genetic information", "Carries amino acids to the ribosome", "Makes copies of DNA", "Provides energy"],
      "correct": 1,
      "explanation": "tRNA molecules carry specific amino acids to the ribosome, matching their anticodons to mRNA codons to build proteins."
    }
  ]
}'::jsonb, 'Chapter 3: Genetics and DNA'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

-- Level 3: Intermediate Concepts (order_index 30-39)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-cell-division', 'Cell Division',
 '# How Cells Reproduce

## The Cell Cycle
Series of events from one division to the next:

### Interphase (90% of cell cycle)
- **G1**: Growth, normal functions
- **S**: DNA replication
- **G2**: Prepare for division

### Mitosis (nuclear division)
- **Prophase**: Chromosomes condense, nuclear envelope breaks
- **Metaphase**: Chromosomes line up in center
- **Anaphase**: Chromosomes separate to opposite ends
- **Telophase**: Two nuclei form

### Cytokinesis (cytoplasm divides)
- Animal cells: Pinches in half
- Plant cells: Cell plate forms

## Result of Mitosis
- Two identical daughter cells
- Same number of chromosomes as parent
- Asexual reproduction
- Growth and tissue repair

## Meiosis: Making Sex Cells
Two divisions producing four unique cells:

### Meiosis I
- Homologous chromosomes separate
- Two cells formed

### Meiosis II
- Sister chromatids separate
- Four cells total

## Key Differences
| Feature | Mitosis | Meiosis |
|---------|---------|---------|
| Purpose | Growth/repair | Reproduction |
| Divisions | 1 | 2 |
| Daughter cells | 2 | 4 |
| Chromosome number | Same (2n) | Half (n) |
| Genetic variation | None | High |

## Why This Matters
Cell division explains:
- How organisms grow
- Cancer (uncontrolled division)
- Sexual reproduction
- Genetic variation',
30, 20,
'{
  "questions": [
    {
      "question": "What is the main difference between mitosis and meiosis?",
      "options": ["Mitosis makes sex cells, meiosis makes body cells", "Mitosis produces identical cells, meiosis produces unique cells with half chromosomes", "Meiosis happens in plants only", "There is no difference"],
      "correct": 1,
      "explanation": "Mitosis produces two identical daughter cells for growth and repair, while meiosis produces four unique sex cells with half the chromosomes for reproduction."
    },
    {
      "question": "During which phase of the cell cycle does DNA replication occur?",
      "options": ["G1 phase", "S phase", "G2 phase", "Mitosis"],
      "correct": 1,
      "explanation": "DNA replication occurs during the S (synthesis) phase of interphase, ensuring each daughter cell gets a complete copy of the genome."
    }
  ]
}'::jsonb, 'Chapter 4: Cell Division'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-mendel', 'Mendelian Genetics',
'# Patterns of Inheritance

## Gregor Mendel
Father of genetics, studied pea plants (1860s):
- Why do traits appear and disappear?
- Why do offspring resemble parents?
- How are traits inherited?

## Key Concepts

### Alleles
Different versions of a gene:
- Gene: Flower color
- Alleles: Purple or white

### Dominant and Recessive
- **Dominant**: Masks recessive (appears even if one copy)
- **Recessive**: Hidden unless two copies

Symbols: Capital = dominant, lowercase = recessive
- Purple (P) dominant over white (p)

### Homozygous vs Heterozygous
- **Homozygous**: Two same alleles (PP or pp)
- **Heterozygous**: Two different alleles (Pp)

## Mendel''s Laws

### Law of Segregation
- Two alleles for a gene separate
- Each gamete gets one allele
- Random which one

### Law of Independent Assortment
- Genes for different traits assort independently
- Exception: Genes on same chromosome (linked)

## Punnett Squares
Predict offspring probabilities:

| | P | p |
|---|---|---|
| **P** | PP | Pp |
| **p** | Pp | pp |

Cross: Pp × Pp
Results: 1 PP: 2 Pp: 1 pp (3 purple: 1 white)

## Test Cross
Determine unknown genotype:
- Cross with homozygous recessive
- Observe offspring ratios

## Why This Matters
Mendelian genetics explains:
- How traits are inherited
- Probability of genetic conditions
- Why children resemble (and differ from) parents
- Selective breeding in agriculture',
31, 20,
'{
  "questions": [
    {
      "question": "What is the difference between homozygous and heterozygous?",
      "options": ["Homozygous has two different alleles, heterozygous has two same alleles", "Homozygous has two same alleles, heterozygous has two different alleles", "They are the same thing", "Homozygous is dominant"],
      "correct": 1,
      "explanation": "Homozygous means having two identical alleles for a gene (PP or pp), while heterozygous means having two different alleles (Pp)."
    },
    {
      "question": "In a cross between two heterozygous individuals (Pp × Pp), what is the expected ratio?",
      "options": ["All dominant", "3 dominant : 1 recessive", "1:1", "2:2"],
      "correct": 1,
      "explanation": "A Pp × Pp cross produces approximately 3 dominant phenotype (PP, Pp, Pp) to 1 recessive phenotype (pp)."
    }
  ]
}'::jsonb, 'Chapter 5: Genetics and Heredity'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'bio-molecular-genetics', 'Molecular Genetics',
'# DNA at the Molecular Level

## Beyond Simple Mendelian Genetics

### Incomplete Dominance
Heterozygote shows intermediate trait:
- Red (RR) × White (rr) = Pink (Rr)
- Neither allele completely dominant

### Codominance
Both alleles expressed:
- Blood type AB (IAIB)
- Both A and B antigens present

### Multiple Alleles
More than two alleles for a gene:
- Blood types: IA, IB, i
- Three alleles, each person has two

### Polygenic Inheritance
Multiple genes affect one trait:
- Height, skin color, eye color
- Bell curve distribution

## Sex-Linked Inheritance
Genes on sex chromosomes (X or Y):
- **X-linked recessive**: Color blindness, hemophilia
  - Males: X⁺Y = affected, X⁺X⁻ = carrier
  - Females: X⁻X⁻ = affected
- Males more likely affected (only one X)

## Genetic Disorders

### Autosomal Recessive
- Need two copies
- Parents are carriers
- Examples: Cystic fibrosis, sickle cell anemia

### Autosomal Dominant
- Need only one copy
- Affected parent passes to ~50% offspring
- Examples: Huntington''s disease, Marfan syndrome

### Chromosomal Disorders
- Wrong number of chromosomes
- Down syndrome: 3 copies of chromosome 21
- Turner syndrome: XO (only one X)

## DNA Mutations
Changes in DNA sequence:
- **Point mutation**: One base changed
- **Insertion/deletion**: Frameshift
- **Duplication**: Section repeated

Some mutations harmful, some neutral, some beneficial

## Why This Matters
Molecular genetics explains:
- Why Mendel''s laws sometimes don''t apply
- How genetic diseases occur and spread
- Complex traits like height and intelligence
- Human genetic diversity',
32, 20,
'{
  "questions": [
    {
      "question": "What is the difference between incomplete dominance and codominance?",
      "options": ["They are the same", "Incomplete dominance shows intermediate trait, codominance shows both traits", "Codominance shows intermediate, incomplete shows both", "Neither exists in nature"],
      "correct": 1,
      "explanation": "Incomplete dominance produces an intermediate phenotype (pink from red and white), while codominance shows both traits simultaneously (blood type AB showing both A and B antigens)."
    },
    {
      "question": "Why are males more likely to have X-linked recessive disorders?",
      "options": ["They have two X chromosomes", "They have only one X chromosome", "They have stronger genes", "They have more mutations"],
      "correct": 1,
      "explanation": "Males have only one X chromosome (XY), so a single recessive allele on that X will be expressed. Females have two X chromosomes, so a recessive allele can be masked by a dominant one."
    }
  ]
}'::jsonb, 'Chapter 5: Genetics and Heredity'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

-- Level 4: Advanced Concepts (order_index 40-49)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'biobio-evolution', 'Evolution: The Unifying Theory',
'# How Life Changes Over Time

## What is Evolution?
Change in genetic characteristics of populations over time:
- Individuals don''t evolve, populations do
- Driven by four mechanisms

## Darwin''s Theory of Natural Selection

### Observations
1. Populations produce more offspring than can survive
2. Individuals vary in traits
3. Some traits are heritable
4. Some variations aid survival

### Conclusion
Individuals with favorable traits:
- Survive and reproduce more
- Pass those traits to offspring
- Population changes over time

"Survival of the fittest" = reproductive success

## Evidence for Evolution

### Fossil Record
- Shows changes over time
- Transitional forms (e.g., whale evolution)
- Relative dating by position
- Absolute dating by radioactive decay

### Homology
Similar structure, different function:
- Human arm, bat wing, whale flipper
- Same bones, different arrangements
- Evidence of common ancestor

### Embryology
- Related embryos look similar early on
- Human embryos have tails, gill slits

### Molecular Evidence
- DNA and protein similarities
- More similar DNA = more closely related
- Humans share ~98% DNA with chimps

### Biogeography
- Species on islands resemble mainland species
- Convergent evolution: Similar adaptations in similar environments

## Mechanisms of Evolution

### Natural Selection
- Environment "selects" favorable traits
- Can cause rapid change

### Genetic Drift
- Random changes in allele frequencies
- Stronger in small populations
- Founder effect, bottleneck

### Gene Flow
- Movement of alleles between populations
- Migration
- Redifferences between populations

### Mutation
- Ultimate source of genetic variation
- Random, not directed

## Hardy-Weinberg Equilibrium
Population NOT evolving when:
1. No mutation
2. Random mating
3. No gene flow
4. Large population
5. No natural selection

## Why This Matters
Evolution explains:
- Diversity of life
- Adaptation to environments
- Extinction and speciation
- Distribution of species
- Human origins',
40, 25,
'{
  "questions": [
    {
      "question": "What does natural selection act on?",
      "options": ["Individuals", "Populations", "Species", "Ecosystems"],
      "correct": 0,
      "explanation": "Natural selection acts on individuals, but evolution occurs in populations as favorable traits become more common over generations."
    },
    {
      "question": "What is the ultimate source of genetic variation?",
      "options": ["Natural selection", "Mutation", "Genetic drift", "Gene flow"],
      "correct": 1,
      "explanation": "Mutations create new alleles and genetic variants, which are then acted upon by other evolutionary forces like natural selection."
    }
  ]
}'::jsonb, 'Chapter 6: Evolution'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'biobio-ecology', 'Ecology: Organisms and Environment',
'# The Study of Interactions

## Levels of Organization
Individual → Population → Community → Ecosystem → Biome → Biosphere

## Population Ecology

### Population Growth
**Exponential Growth**: J-shaped curve
Nₜ = N₀ × 2ⁿ (ideal conditions)

**Logistic Growth**: S-shaped curve
- Carrying capacity (K): Maximum population
- Limited by resources
- Realistic model

### Factors Affecting Population
- **Density-dependent**: Competition, disease, predation
- **Density-independent**: Weather, natural disasters

## Community Ecology

### Species Interactions
**Competition**: Both harmed (-,-)
**Predation**: One benefits, one harmed (+,-)
**Mutualism**: Both benefit (+,+)
- Mycorrhizae and plants
**Commensalism**: One benefits, one unaffected (+,0)

### Ecological Niches
- **Fundamental niche**: Where species could live
- **Realized niche**: Where species actually lives
- Competitive exclusion: Two species can''t occupy same niche

## Ecosystem Ecology

### Energy Flow
Sun → Producers → Consumers → Decomposers

**Trophic Levels**:
1. Primary producers (plants)
2. Primary consumers (herbivores)
3. Secondary consumers (carnivores)
4. Tertiary consumers (top carnivores)

Only ~10% energy transferred between levels
- Explains why few top predators
- Limits food chain length

### Biogeochemical Cycles

**Carbon Cycle**:
- Photosynthesis removes CO₂
- Respiration adds CO₂
- Fossil fuels, oceans, atmosphere

**Nitrogen Cycle**:
- Nitrogen fixation: Bacteria convert N₂ to usable forms
- Nitrification, ammonification, denitrification
- Essential for proteins, DNA

**Water Cycle**:
- Evaporation, condensation, precipitation
- Transpiration from plants
- Groundwater, surface water

## Biomes
Major terrestrial ecosystems:
- **Tropical rainforest**: High diversity, year-round warmth
- **Savanna**: Grassland with scattered trees
- **Desert**: Low precipitation, extreme temperatures
- **Temperate forest**: Four seasons, deciduous trees
- **Taiga**: Coniferous forest, cold winters
- **Tundra**: Permafrost, short growing season

## Conservation Biology

### Biodiversity
- Genetic diversity
- Species diversity
- Ecosystem diversity

### Threats
- Habitat destruction
- Climate change
- Invasive species
- Overexploitation
- Pollution

### Conservation Strategies
- Protected areas
- Captive breeding
- Habitat restoration
- Sustainable use

## Why This Matters
Ecology explains:
- How nature works
- Environmental problems
- How to conserve species
- Our impact on Earth',
41, 25,
'{
  "questions": [
    {
      "question": "Why are food chains limited in length?",
      "options": ["Animals get too big", "Energy is lost at each level, so little remains for top predators", "Not enough species", "Climate change"],
      "correct": 1,
      "explanation": "Only about 10% of energy is transferred between trophic levels, so there''s not enough energy to support many levels or many top predators."
    },
    {
      "question": "What is carrying capacity?",
      "options": ["Maximum reproductive rate", "Maximum population an environment can sustain", "Number of species in ecosystem", "Food chain length"],
      "correct": 1,
      "explanation": "Carrying capacity (K) is the maximum population size that an environment can sustainably support given available resources."
    }
  ]
}'::jsonb, 'Chapter 7: Ecology'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

-- Level 5: Expert Level (order_index 50-59)
INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'biobio-gene-regulation', 'Gene Regulation',
'# Controlling Gene Expression

## Why Regulate Genes?
All cells have same DNA, but:
- Heart cells different from liver cells
- Genes turned on/off at right times
- Respond to environment
- Conserve energy

## Prokaryotic Gene Regulation

### Operon Model
Cluster of genes controlled together:

**Lac Operon** (E. coli digesting lactose):
- Lactose present → Gene on
- Lactose absent → Gene off

**Trp Operon** (making tryptophan):
- Tryptophan low → Gene on
- Tryptophan high → Gene off

## Eukaryotic Gene Regulation

### Transcriptional Control
**Promoters**: Where RNA polymerase binds
**Enhancers**: Distant regulatory sequences
**Transcription factors**: Proteins that help regulate

### Epigenetics
Heritable changes without DNA sequence change:

**DNA Methylation**:
- Methyl groups added to DNA
- Usually turns genes off

**Histone Modification**:
- Histones: Proteins DNA wraps around
- Acetylation: Usually turns genes on
- Methylation: Usually turns genes off

### Post-Transcriptional Control
**Alternative splicing**: One gene → multiple proteins
**miRNA**: Small RNAs that block translation

### Translational Control
Regulating protein synthesis:
- Blocking ribosome binding
- Regulating mRNA stability

### Post-Translational Control
After protein made:
- Protein modification
- Protein degradation
- Tagged with ubiquitin for destruction

## Cellular Differentiation
Stem cells → specialized cells:
- Totipotent: Can become anything (early embryo)
- Pluripotent: Can become many cells (embryonic stem cells)
- Multipotent: Limited potential (adult stem cells)
- Unipotent: Single cell type

## Cancer: Gene Regulation Gone Wrong
Oncogenes: Accelerate growth (gas pedal stuck)
Tumor suppressors: Slow growth (brakes failed)

Mutations in regulatory genes → uncontrolled division

## Why This Matters
Gene regulation explains:
- How cells become specialized
- Development from embryo to adult
- Cancer and other diseases
- Cloning and stem cells',
50, 30,
'{
  "questions": [
    {
      "question": "What is epigenetics?",
      "options": ["Study of genes", "Heritable changes without DNA sequence changes", "Study of proteins", "Study of mutations"],
      "correct": 1,
      "explanation": "Epigenetics involves heritable changes in gene expression that don''t involve changes to the underlying DNA sequence, such as DNA methylation and histone modification."
    },
    {
      "question": "How does the lac operon work in E. coli?",
      "options": ["Always on", "Turned on when lactose is present", "Turned on when glucose is present", "Never turns on"],
      "correct": 1,
      "explanation": "The lac operon is turned on when lactose is present, allowing E. coli to produce enzymes needed to digest lactose."
    }
  ]
}'::jsonb, 'Chapter 8: Advanced Genetics'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;

INSERT INTO public.lessons (course_id, slug, title, content, order_index, xp_reward, quiz, chapter)
SELECT c.id, 'biobio-biotech', 'Biotechnology and Genetic Engineering',
'# Manipulating DNA

## Recombinant DNA Technology
Combining DNA from different sources:

### Restriction Enzymes
- Cut DNA at specific sequences
- Molecular scissors
- Example: EcoRI cuts at GAATTC

### DNA Ligase
- Joins DNA fragments
- Molecular glue

### Plasmids
- Circular DNA in bacteria
- Used as vectors
- Carry foreign DNA into host

## Making Recombinant DNA
1. Cut plasmid and human DNA with same enzyme
2. Mix with DNA ligase
3. Insert plasmid into bacteria
4. Bacteria replicate with foreign gene
5. Bacteria produce gene product

## Applications

### Medicine
- **Insulin**: Bacteria produce human insulin
- **Growth hormone**: Treat growth disorders
- **Vaccines**: Safer, more effective
- **Monoclonal antibodies**: Cancer treatment

### Agriculture
- **Bt corn**: Makes own insecticide
- **Roundup Ready**: Resistant to herbicide
- **Golden Rice**: Contains vitamin A
- **Frost-resistant plants**

### Industry
- Enzymes for detergents
- Oil-eating bacteria (spills)
- Biofuels

## PCR (Polymerase Chain Reaction)
Amplify DNA:
1. Heat to separate strands
2. Cool to add primers
3. DNA polymerase copies DNA
4. Repeat 30+ times
5. Millions of copies in hours

Uses:
- Crime scene DNA
- Disease diagnosis
- Ancient DNA
- Paternity testing

## Gel Electrophoresis
Separate DNA by size:
- Smaller fragments move faster
- Creates DNA fingerprint
- Used for identification

## DNA Sequencing
Determining exact DNA sequence:
- Sanger method (older, reliable)
- Next-generation sequencing (fast, cheap)
- Human Genome Project: $3 billion, 13 years
- Today: ~$1000, few hours

## CRISPR-Cas9
Gene editing:
- Guide RNA finds target DNA
- Cas9 enzyme cuts DNA
- Cell repairs (with or without changes)
- Can add, remove, or change genes

Potential:
- Cure genetic diseases
- Create designer babies?
- Eliminate mosquitoes?
- Ethical concerns!

## Stem Cell Research
Types:
- **Embryonic**: Most potential, ethical issues
- **Adult (iPSC)**: Reprogrammed, fewer issues

Uses:
- Regenerative medicine
- Organ growth
- Disease modeling
- Drug testing

## Why This Matters
Biotechnology:
- Treats and cures diseases
- Improves agriculture
- Solves environmental problems
- Raises important ethical questions',
51, 30,
'{
  "questions": [
    {
      "question": "What is the function of restriction enzymes?",
      "options": ["Join DNA fragments", "Cut DNA at specific sequences", "Replicate DNA", "Translate DNA"],
      "correct": 1,
      "explanation": "Restriction enzymes are molecular scissors that cut DNA at specific nucleotide sequences, allowing scientists to cut and paste genes."
    },
    {
      "question": "What does PCR do?",
      "options": ["Cuts DNA", "Joins DNA", "Amplifies (copies) DNA", "Sequences DNA"],
      "correct": 2,
      "explanation": "PCR (Polymerase Chain Reaction) amplifies DNA, creating millions of copies from a tiny sample through repeated heating and cooling cycles."
    }
  ]
}'::jsonb, 'Chapter 9: Biotechnology'
FROM courses c WHERE c.slug = 'cell-biology'
ON CONFLICT DO NOTHING;
