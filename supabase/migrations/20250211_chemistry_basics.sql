-- =====================================================
-- CHEMISTRY BASICS COURSE
-- Topics: Matter, Atoms, Periodic Table, Bonding, Reactions, Stoichiometry
-- Difficulty: Beginner
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Chemistry Basics
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Chemistry Basics',
  'chemistry-basics',
  'Learn the foundations of chemistry: atoms, molecules, periodic table, chemical bonding, reactions, stoichiometry, and states of matter. Perfect for beginners starting their chemistry journey.',
  'chemistry',
  'beginner',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: MATTER AND ATOMIC STRUCTURE
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'chemistry-basics' LIMIT 1),
  'Matter and Atomic Structure',
  'matter-atomic-structure',
  'Understand the nature of matter, atomic theory, and subatomic particles.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'matter-atomic-structure' LIMIT 1),
  'Classifications of Matter',
  'classifications-matter',
  1,
  '# Classifications of Matter

## What Is Matter?

**Matter** is anything that has mass and occupies space (volume).

## States of Matter

### Solid

**Properties**:
- **Definite shape and volume**
- **Particles tightly packed** (vibrate in place)
- **Strong intermolecular forces**
- **Incompressible**

**Examples**: Ice, rock, metal, diamond

### Liquid

**Properties**:
- **Indefinite shape** (takes container shape)
- **Definite volume** (fixed amount of space)
- **Particles flow past each other**
- **Weak intermolecular forces** (can slide)
- **Slightly compressible**

**Examples**: Water, oil, blood, lava

### Gas

**Properties**:
- **No definite shape or volume** (expands to fill container)
- **Particles far apart** (move freely at high speeds)
- **Negligible intermolecular forces**
- **Highly compressible**
- **Fill container uniformly**

**Examples**: Air, helium, steam, oxygen

## Plasma

The **fourth state of matter** (most common in universe!)

**Properties**:
- **Ionized gas** (electrons stripped from atoms)
- **Conducts electricity**
- **Responds to magnetic fields**
- **Emits light** (neon signs, auroras, stars)

**Examples**:
- Lightning (electrical plasma)
- Sun (thermal plasma)
- Neon signs (glowing plasma)
- Aurora borealis (solar plasma interacting with Earth''s magnetic field)

## Phase Changes

**Melting**: Solid → Liquid (heat absorbed, breaks intermolecular bonds)

**Freezing**: Liquid → Solid (heat released, bonds form)

**Vaporization**: Liquid → Gas (heat absorbed, particles escape)

**Condensation**: Gas → Liquid (heat released, particles come together)

**Sublimation**: Solid → Gas (skips liquid phase)

**Deposition**: Gas → Solid (skips liquid phase)

**Melting point**: Temperature at which solid ↔ liquid (pressure dependent)

**Boiling point**: Temperature at which liquid ↔ gas throughout bulk (pressure dependent)

## Pure Substances vs. Mixtures

**Pure substance**: Single type of particle/compound (e.g., distilled water)

**Mixture**: Two or more substances physically combined (not chemically bonded)
- **Heterogeneous**: Can see different parts (e.g., salad, granite)
- **Homogeneous**: Uniform appearance (e.g., salt dissolved in water)

## Elements and Compounds

**Element**: Pure substance consisting of only one type of atom
- Cannot be broken down by chemical means
- Represented by chemical symbol (e.g., Fe, O, Au)

**Compound**: Substance formed when two or more elements chemically combine
- Has definite composition (same ratio of elements)
- Can be broken down by chemical means
- Represented by chemical formula (e.g., H₂O, NaCl, CO₂)

### Chemical Formulas

**Water**: H₂O (2 hydrogen atoms + 1 oxygen atom)

**Table salt (sodium chloride)**: NaCl (1 sodium atom + 1 chlorine atom)

**Carbon dioxide**: CO₂ (1 carbon atom + 2 oxygen atoms)

**Glucose (sugar)**: C₆H₁₂O₆ (6 carbon + 12 hydrogen + 6 oxygen atoms)

## Physical vs. Chemical Changes

**Physical change**: Alters form/appearance, NOT composition
- Melting ice
- Crushing paper
- Dissolving sugar in water (still sugar!)
- Boiling water (still water!)

**Chemical change**: Transforms substance into new substance(s)
- Burning wood
- Rusting iron
- Baking cake (new substances form)
- Digesting food

## Separation Techniques

### Filtration

Separate solid from liquid by passing through filter paper.

**Example**: Separating sand from water

### Distillation

Separate liquids based on different boiling points:

```
       Heat
        ↓
    ┌──────────┐
    │  Mixture  │
    │ (e.g.,     │
    │  alcohol+  │
    │  water)      │
    └─────┬──────┘
          │
       Condenser
          │
    ┌────┴────┐
    │            │
    └────────────┘
      ↓
  Collection flask
```

**Example**: Purifying ethanol from water

### Chromatography

Separate components based on different affinities for stationary phase:

```
      Paper   Mobile phase
       │         (liquid)
       ↓         ↓
    ┌────┐    ┌────┐
    │    ╱     ║    ╲
    │ Spot  ║  ╲  ╱
    │ placed  ║  ╲ ╱
    │ on     ║  ╲ ╱
    └────────┘  ║  ╲ ╱
                └──────┘
                  Solvent front
                    (different Rf values)
```

**Uses**: Food coloring analysis, drug purity testing

## Key Concepts Summary

| Concept | Description | Example |
|----------|-------------|---------|
| Element | Single type of atom | Gold (Au), Oxygen (O) |
| Compound | Chemically combined elements | Water (H₂O), Salt (NaCl) |
| Mixture | Physically combined substances | Salt water, Air |
| Physical change | No new substances formed | Ice melting |
| Chemical change | New substances form | Burning, Rusting |
| Homogeneous | Uniform composition | Air, Salt water |
| Heterogeneous | Visible different parts | Oil + vinegar |
| Plasma | Ionized gas (4th state) | Lightning, Neon signs |

## Sources
- OpenStax Chemistry 2e (2015). "Atoms, Molecules, and Ions"
- Zumdahl, S., Zumdahl, S. (2017). "Chemistry: The Central Science, 10th ed."
- Khan Academy: "States of Matter"
- LibreTexts: "Chemistry"
',

  '[
    {
      "question": "What is the key difference between physical and chemical changes?",
      "options": ["Physical changes involve heat, chemical changes don''t", "Physical changes alter form/appearance but NOT composition; chemical changes form new substances", "Physical changes are reversible, chemical changes are not", "Physical changes involve solids, chemical changes involve gases"],
      "correctAnswer": 1,
      "explanation": "Physical changes alter form or appearance without creating new substances (ice melting, paper crushing). Chemical changes transform matter into NEW substances with different properties (burning, rusting, baking). The key difference is whether NEW substances form!"
    },
    {
      "question": "Which state of matter is characterized by particles that vibrate in place but are tightly packed?",
      "options": ["Gas", "Liquid", "Solid", "Plasma"],
      "correctAnswer": 2,
      "explanation": "Solids have particles that vibrate in fixed positions (tightly packed by strong intermolecular forces). They have definite shape and volume, and are incompressible. Examples: ice, rock, metals. This distinguishes them from liquids (flow) and gases (far apart)."
    },
    {
      "question": "What is the fourth state of matter, most common in the universe?",
      "options": ["Solid", "Liquid", "Plasma", "Bose-Einstein condensate"],
      "correctAnswer": 2,
      "explanation": "Plasma is the fourth state of matter—an ionized gas where electrons are stripped from atoms. It conducts electricity, responds to magnetic fields, and emits light. Stars (including our Sun) are plasma! Lightning and auroras are also plasma. It''s the most common state in the universe by mass."
    },
    {
      "question": "Is salt dissolved in water a mixture or a compound?",
      "options": ["Mixture—can be separated", "Compound—cannot be separated by physical means", "Neither—it''s a solution", "Pure substance"],
      "correctAnswer": 1,
      "explanation": "Salt dissolved in water is a HOMOGENEOUS MIXTURE (uniform appearance). Salt and water retain their chemical identities and can be separated by physical means like evaporation. A compound (NaCl) would require a CHEMICAL change to separate into sodium and chlorine. Mixtures involve physical combination, not chemical bonding!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'matter-atomic-structure' LIMIT 1),
  'Atoms and the Periodic Table',
  'atoms-periodic-table',
  2,
  '# Atoms and the Periodic Table

## Atomic Theory

**Atoms** are the smallest unit of ordinary matter that retains the properties of an element.

### Subatomic Particles

**Protons** ($p^+$):
- Positive charge (+1 elementary charge)
- Mass ≈ 1.0073 u (atomic mass units)
- Found in nucleus
- Determine atomic number

**Neutrons** ($n$):
- No charge (neutral)
- Mass ≈ 1.0087 u
- Found in nucleus
- Different isotopes have different neutron counts

**Electrons** ($e^-$):
- Negative charge (-1 elementary charge)
- Mass ≈ 0.00055 u (1/1836 of proton)
- Found in electron cloud/orbitals
- Equal to protons in neutral atom

### Atomic Number and Mass Number

**Atomic number (Z)**: Number of protons in nucleus
- Determines the element
- Also equals electrons in neutral atom

**Mass number (A)**: Protons + neutrons in nucleus
- Determines the isotope

**Notation**: $^A_Z$X

- $A$ = mass number (protons + neutrons)
- $Z$ = atomic number (protons)
- $X$ = element symbol

**Examples**:
- Carbon-12: $^{12}_6$C (6 protons, 6 neutrons)
- Carbon-14: $^{14}_6$C (6 protons, 8 neutrons) - radioactive
- Uranium-238: $^{238}_{92}$U (92 protons, 146 neutrons)

## The Periodic Table

**Organization**: Elements arranged by atomic number (increasing left-to-right, top-to-bottom)

### Periods (Rows)

Each period represents a **principal energy level** (electron shell):

| Period | Elements | Electrons in outer shell | Valence electrons |
|---------|----------|------------------------|-----------------|
| 1 | H, He | 1 (except He) | 1 |
| 2 | Li to Ne | 2 | 2 |
| 3 | Na to Ar | 3 | 3 |
| 4 | K to Kr | 4 | 4 |
| 5 | Rb to Xe | 5 | 5 |
| 6 | Cs to Rn | 6 | 6 |
| 7 | Fr, Ra (not complete) | 7 | 7 |

### Groups (Columns)

Elements in same group have similar **chemical properties**:

| Group | Name | Similar Properties | Example |
|-------|------|------------------|---------|
| 1 | Alkali metals | Highly reactive, soft, low density | Li, Na, K |
| 2 | Alkaline earth | Reactive, form basic oxides | Mg, Ca, Ba |
| 17 | Halogens | Most reactive nonmetals | F, Cl, Br, I |

### Key Regions

**Metals** (left side, separated by stair-step line):
- Shiny, conductive, malleable, ductile

**Nonmetals** (right side):
- Dull, poor conductors, brittle

**Metalloids** (stair-step diagonal):
- Properties of both metals and nonmetals

**Noble gases** (Group 18):
- Very unreactive (full valence shell)
- He, Ne, Ar, Kr, Xe, Rn

## Important Trends

### Atomic Radius

**Definition**: Half the distance between nuclei of two adjacent atoms

**Trend**: **Increases down a group** (more electron shells) and **decreases across a period** (same shell, more protons = stronger pull)

**Example**: Na (186 pm) > Mg (160 pm) > K (227 pm)

**Exceptions**: Ga > Al (due to d-block contraction)

### Ionization Energy

**Definition**: Energy required to remove valence electron from gaseous atom

**First ionization energy**: $X(g) \rightarrow X^+(g) + e^-$

**Trend**: **Increases up a group** (harder to remove electron from smaller atom) and **decreases down a group**

**Exception**: Be > B (full s-subshell stability)

### Electronegativity

**Definition**: Measure of atom''s ability to attract electrons in a chemical bond

**Scale** (Pauling scale):
- F (most electronegative): 4.0 (e.g., F, O)
- Cl (moderate): 3.0 (e.g., Cl, N)
- Metals (low): 0.7-1.3 (e.g., Na, Mg)

**Trends**:
- Increases across period (left to right)
- Decreases down group (top to bottom)

**Use**: Predict bond type (ionic vs. covalent)

### Electron Affinity

**Definition**: Energy change when adding electron to neutral atom

**Trend**: Generally **opposite of ionization energy** (more energy released = more negative)

### Metallic Character

**Metals** (left):
- Lose electrons easily (low ionization energy)
- Form cations (positive ions)
- Conductive, malleable

**Nonmetals** (right):
- Gain electrons (high electron affinity)
- Form anions (negative ions)
- Brittle, poor conductors

## Isotopes

Atoms of same element with **different numbers of neutrons**:

**Notation**: Element name - mass number (e.g., Carbon-14, Uranium-235)

**Carbon isotopes**:
- $^{12}$C: 98.89% abundant, stable
- $^{13}$C: 1.07% abundant, stable, used in radiocarbon dating
- $^{14}$C: Radioactive (half-life 5,730 years), tracer

**Uses of isotopes**:
- **Radiometric dating**: $^{14}$C decay (half-life 5,730 years)
- **Nuclear medicine**: $^{99m}$Tc for SPECT scans
- **Nuclear power**: $^{235}$U for reactors

## Important Elements

| Element | Symbol | Atomic # | Use |
|----------|----------|---------|-----|
| Hydrogen | H | 1 | Rocket fuel, ammonia production, |
|          |          |          | chemicals |
| Carbon | C | 6 | Basis of organic chemistry, |
|          |          |          | diamonds, graphite |
| Nitrogen | N | 7 | 78% of atmosphere, |
|          |          |          | fertilizers, proteins |
| Oxygen | O | 8 | 21% of atmosphere, |
|          |          |          | respiration, combustion |
| Iron | Fe | 26 | Steel production, |
|          |          |          | hemoglobin (blood) |
| Gold | Au | 79 | Jewelry, electronics, |
|          |          |          | currency (inert) |

## Diatomic Elements

**H₂** (hydrogen gas): Two hydrogen atoms bonded together

**O₂** (oxygen gas): Two oxygen atoms bonded together

**N₂** (nitrogen gas): Two nitrogen atoms bonded together

**Cl₂** (chlorine gas): Two chlorine atoms bonded together

Many gases exist as **diatomic molecules** at standard conditions!

## Key Equations

| Concept | Formula/Relation |
|----------|-----------------|
| Atomic number | Z = number of protons |
| Mass number | A = protons + neutrons |
| Isotope notation | $^A_Z$X |
| Notation | $^A_Z$X (A = mass number, Z = atomic number, X = symbol) |

## Sources
- Mendeleev, D. (1869). "On the Relation of the Properties to the Atomic Weights of the Elements"
- OpenStax Chemistry 2e (2015). "Atoms, Molecules, and Ions"
- Zumdahl, S., Zumdahl, S. (2017). "Chemistry: The Central Science, 10th ed."
- Royal Society of Chemistry: "Periodic Table"
',

  '[
    {
      "question": "What determines the chemical identity of an element?",
      "options": ["Number of neutrons", "Number of protons (atomic number Z)", "Number of electron shells", "Mass number A"],
      "correctAnswer": 1,
      "explanation": "The atomic number (Z) determines an element''s chemical identity—the number of protons in the nucleus. Different numbers of neutrons create isotopes (same element, different mass), but the element is defined by Z. Carbon always has 6 protons, whether it''s C-12 or C-14!"
    },
    {
      "question": "What is the trend for atomic radius moving down a group on the periodic table?",
      "options": ["Atomic radius decreases down a group", "Atomic radius increases down a group (more electron shells)", "Atomic radius stays the same down a group", "No clear trend"],
      "correctAnswer": 1,
      "explanation": "Moving down a group, you ADD electron shells. For example, lithium (2 shells) has smaller radius than sodium (3 shells), which has smaller radius than potassium (4 shells). More shells → larger atom, even though increased nuclear charge pulls inward. Radius INCREASES down groups (with some exceptions like Ga > Al)."
    },
    {
      "question": "What is electronegativity and which element is most electronegative?",
      "options": ["Measure of an atom''s attraction to protons; metals are most electronegative", "Measure of an atom''s ability to attract electrons; fluorine is most electronegative", "Measure of ionization energy; helium is most electronegative", "Measure of an atom''s repulsion of electrons"],
      "correctAnswer": 1,
      "explanation": "Electronegativity measures an atom''s ability to attract electrons in a chemical bond. Fluorine (F, EN = 4.0) is most electronegative element, followed by oxygen (3.5). Electronegativity increases across a period (left to right) and decreases up a group. High EN means stronger pull on bonding electrons!"
    },
    {
      "question": "Is carbon-14 (¹⁴C) stable or radioactive?",
      "options": ["Stable and makes up 98.9% of all carbon", "Radioactive with half-life of 5,730 years; used in radiocarbon dating", "Stable and makes up 50% of all carbon", "Radioactive with half-life of 100 years"],
      "correctAnswer": 1,
      "explanation": "Carbon-14 is RADIOACTIVE with a half-life of 5,730 years. It''s produced in the atmosphere by cosmic rays and makes up only ~1% of carbon. This property makes it useful for radiocarbon dating of formerly living organisms. In contrast, Carbon-12 (98.9% abundance) and Carbon-13 (1.07%) are stable."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'matter-atomic-structure' LIMIT 1),
  'Chemical Bonding',
  'chemical-bonding',
  3,
  '# Chemical Bonding

## What Is Chemical Bonding?

**Chemical bond**: Force that holds atoms together in molecules/compounds.

Bond formation is **exothermic** (releases energy) because bonded state is more stable than separated atoms.

## Why Do Atoms Bond?

**Octet rule**: Atoms bond to achieve **stable electron configuration** (like noble gases).

### Valence Electrons

Electrons in outermost shell determine bonding behavior:

| Group | Valence e⁻ | Bonds needed | Example |
|-------|------------|-------------|---------|
| 1 (H, He, Li, Na...) | 1 | Lose 1 | Na → Na⁺ |
| 16 (O, S...) | 6 | Gain 2 | O → O²⁻ |
| 17 (Cl...) | 7 | Gain 1 | Cl → Cl⁻ |

**Noble gases** (Group 18): Full valence shell = **unreactive**!

## Types of Chemical Bonds

### Ionic Bonding

**Transfer of electrons** from metal to nonmetal.

```
   Metal loses e⁻      Nonmetal gains e⁻
         ↓                   ↓
    Na   →    Na⁺  +   Cl  →   Cl⁻
   (11 e⁻)              (17 e⁻)
         │                   │
    ╔═══╦═══╗           ╔═══╤═══╗
    ║ Na⁺  ║           ║ Cl⁻  ║
    ║      ║           ║      ║
    ╚════╤═══╝           ╚════╩═══╝
         ↓                  ↓
      Opposites attract    Form NaCl
         (ionic crystal)
```

**Properties**:
- **Metal loses electrons** (low ionization energy)
- **Nonmetal gains electrons** (high electron affinity)
- **Forms cations (+) and anions (-)**
- **High melting/boiling points** (strong electrostatic attraction)
- **Conducts electricity when molten/dissolved** (mobile ions)
- **Brittle**

**Examples**: NaCl, MgO, CaF₂, KBr

### Covalent Bonding

**Sharing of electrons** between nonmetals (or between same element).

**Single covalent bond**: Two atoms share one electron pair

```
    H   +   H   →   H-H (H₂)
    •    •       •
  (1 e⁻) (1 e⁻)
         │   :    (shared pair)
```

**Double covalent bond**: Two atoms share two electron pairs

```
    O   +   O   →   O=O (O₂)
    ••   •       ••
  (6 e⁻) (6 e⁻)
         │  ::  :  (two shared pairs)
```

**Triple covalent bond**: Three electron pairs shared

```
    N   +   N   →   N≡N (N₂)
    •••  •••
  (5 e⁻) (5 e⁻)
         │ ::: : (three shared pairs)
```

**Properties**:
- **Sharing electrons** (not transfer)
- **Directional** (unequal sharing creates polar bonds)
- **Lower melting points** than ionic (weaker bonds)
- **Poor conductors** (no charged particles)
- **Can be gases, liquids, or solids** at room temperature

**Examples**: H₂O, CO₂, CH₄, O₂, N₂

### Polar vs. Nonpolar Covalent Bonds

**Polar bond**: Unequal electron sharing creates **dipole** (δ+ and δ-):

```
            δ⁺              δ⁻
         H   ────   O
           (shared
           pair)
```

Water is **polar** → dissolves many substances ("universal solvent")

**Nonpolar bond**: Equal sharing, no dipole

**Examples**: O₂, N₂, CH₄, CCl₄ (symmetrical molecules)

### Coordinate Covalent Bond

Both atoms contribute electrons to shared pair (both provide one electron):

```
    N   +   N   →   :N≡N:  ← donated
          •       •      (from N)
         (3 e⁻) (5 e⁻)   (lone pair from N)
         │       :
```

Examples: CO, O₂, N₂O

## Predicting Bond Type

**Electronegativity difference** (ΔEN) determines bond type:

| ΔEN | Bond Type | Electron Sharing | Example |
|------|----------|------------------|---------|
| 0.0 - 0.4 | Nonpolar covalent | Equal sharing | H₂, O₂ |
| 0.5 - 1.7 | Polar covalent | Unequal sharing | H₂O, NH₃ |
| > 1.7 | Ionic | Electron transfer | NaCl, MgO |
| < 0.4 (same element) | Nonpolar/metallic | Metallic bonding | Fe, Cu |

**Special case**: ΔEN = 1.7 - 2.0 = **Polar covalent with ionic character**

## Lewis Dot Structures

**Representation** of valence electrons as dots:

**Rules**:
1. Count valence electrons
2. Draw dots around symbol
3. **Octet rule**: Atoms bond to have 8 e⁻ (except H which wants 2)
4. Single bond = 2 shared electrons (1 pair)

### Examples

**Water (H₂O)**:
```
    H   O   H
    •   ••  •   •
        │   :
        ···
    (8 dots total)
```

**Carbon dioxide (CO₂)**:
```
         O   C   O
    ••  •   ••
        │   :
        ···
    (16 e⁻ total)
```

**Ammonia (NH₃)**:
```
    N   H   H
    ••  •   •   •   •
        │   :
        ····
    (8 e⁻ total)
```

## Bond Energy and Length

**Bond energy**: Energy required to break bond (higher = stronger bond)

**Bond length**: Distance between nuclei (shorter = generally stronger)

| Bond Type | Bond Energy (kJ/mol) | Bond Length (pm) |
|----------|------------------------|-----------------|
| C-C (single) | 347 | 154 |
| C=C (double) | 614 | 134 |
| C≡C (triple) | 839 | 120 |
| C-F (single) | 485 | 135 |
| O-H (single) | 467 | 96 |
| O=O (double) | 498 | 120 |

Multiple bonds = stronger overall (C≡O in CO₂)

## Resonance

**Delocalized electrons** spread across multiple atoms.

**Benzene** (C₆H₆):
```
    Alternating single/double bonds
    (two equivalent structures)
         ◊ ═ ◊ ◊
        ║   ║
        ║   ║
         ◊ ═ ◊ ◊
```

Actual structure is **hybrid** of both resonance forms!

## VSEPR Theory

**Valence Shell Electron Pair Repulsion** predicts molecular geometry:

**Electron pairs** (lone pairs + bonding pairs) repel each other to maximize separation

**Geometries**:
- **2 regions**: Linear (180°)
- **3 regions**: Trigonal planar (120°) or trigonal pyramidal (107°)
- **4 regions**: Tetrahedral (109.5°)

**Water (H₂O)**: Bent shape (2 lone pairs + 2 bonding pairs)

## Key Concepts Summary

| Bond Type | Electron Behavior | Example | Properties |
|----------|------------------|---------|-------------|
| Ionic | Transfer (metal → nonmetal) | NaCl, MgO | High melting points, conductive when molten |
| Polar covalent | Unequal sharing | H₂O, NH₃ | Dipole, dissolves in water |
| Nonpolar covalent | Equal sharing | CO₂, O₂ | No dipole, gas at STP |
| Metallic | Electron sea | Fe, Cu | Conductive, malleable |
| Coordinate | One atom donates both e⁻ | CO, N₂O | Multiple representations possible |

## Sources
- OpenStax Chemistry 2e (2015). "Chemical Bonding and Molecular Geometry"
- Zumdahl, S., Zumdahl, S. (2017). "Chemistry: The Central Science, 10th ed."
- Khan Academy: "Chemical Bonds"
- Brown, W., et al. (2018). "Chemistry: The Central Science, 14th ed."
',

  '[
    {
      "question": "What determines whether a bond will be ionic or covalent?",
      "options": ["Atomic number difference", "Electronegativity difference (ΔEN) between atoms", "Number of valence electrons", "Mass number ratio"],
      "correctAnswer": 1,
      "explanation": "Electronegativity difference (ΔEN) predicts bond type. ΔEN < 0.4 = nonpolar covalent (equal sharing), 0.5-1.7 = polar covalent (unequal sharing), > 1.7 = ionic (electron transfer). For example, Na-Cl has ΔEN ≈ 2.1 (ionic), but H-Cl has ΔEN ≈ 0.9 (polar covalent)!"
    },
    {
      "question": "How many bonds does oxygen typically form to achieve an octet?",
      "options": ["1 bond (gains 1 e⁻)", "2 bonds (gains 2 e⁻)", "3 bonds (gains 3 e⁻)", "4 bonds (gains 4 e⁻)"],
      "correctAnswer": 1,
      "explanation": "Oxygen has 6 valence electrons and needs 2 more to complete octet (8 e⁻). It forms 2 SINGLE bonds, gaining 2 electrons total (1 from each bond). Examples: H₂O (O shares with 2 H), CO₂ (O double-bonded to 2 C). Oxygen''s typical valence is -2 (forms 2 bonds)."
    },
    {
      "question": "Which molecule has a triple bond?",
      "options": ["Oxygen (O₂)", "Nitrogen (N₂)", "Carbon dioxide (CO₂)", "Water (H₂O)"],
      "correctAnswer": 1,
      "explanation": "Nitrogen (N₂) has a TRIPLE bond (N≡N). Nitrogen has 5 valence electrons and needs 3 more to complete octet (8 e⁻). It shares 3 electron pairs with another nitrogen, creating a triple bond. Triple bonds are very strong (bond energy ~945 kJ/mol)."
    },
    {
      "question": "What is VSEPR theory used to predict?",
      "options": ["Bond energies in molecules", "Molecular geometry based on electron pair repulsion", "How many bonds form", "Which elements are metals"],
      "correctAnswer": 1,
      "explanation": "VSEPR (Valence Shell Electron Pair Repulsion) theory predicts molecular geometry by considering that electron pairs (both bonding and lone pairs) repel each other to maximize separation. For example, water (H₂O) has 2 bonding pairs + 2 lone pairs = 4 regions → bent shape (104.5°), not linear!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'matter-atomic-structure' LIMIT 1),
  'Chemical Reactions and Equations',
  'chemical-reactions-equations',
  4,
  '# Chemical Reactions and Equations

## What Is a Chemical Reaction?

**Chemical reaction**: Process where substances (reactants) transform into new substances (products).

**Evidence of chemical reaction**:
- Color change
- Temperature change
- Gas production (bubbles)
- Precipitate forms
- Odor change

## Chemical Equations

**Reactants → Products**

**Example**: Hydrogen + oxygen → water

$$2\text{H}_2 + \text{O}_2 \rightarrow 2\text{H}_2\text{O}$$

### Balancing Equations

**Law of Conservation of Mass**: Mass is neither created nor destroyed in chemical reactions.

**Balanced equation**: Same number of each type of atom on both sides

**Unbalanced**: $\text{H}_2 + \text{O}_2 \rightarrow \text{H}_2\text{O}$

**Balanced**: $2\text{H}_2 + \text{O}_2 \rightarrow 2\text{H}_2\text{O}$

Check:
- Left: 4 H, 2 O
- Right: 4 H, 2 O ✓

## Types of Reactions

### Synthesis Reaction

Two or more substances combine to form a more complex product.

$$A + B \rightarrow AB$$

**Example**: Sodium + chlorine → sodium chloride

$$2\text{Na} + \text{Cl}_2 \rightarrow 2\text{NaCl}$$

**Visual**:
```
    Na   +   Cl₂   →   NaCl  (table salt)
    │                 │
  (solid)          (gas)    (solid crystals)
```

### Decomposition Reaction

One compound breaks down into simpler substances.

$$AB \rightarrow A + B$$

**Example**: Water decomposition via electrolysis:

$$2\text{H}_2\text{O} \rightarrow 2\text{H}_2 + \text{O}_2$$

Requires electrical energy input!

### Single Replacement Reaction

One element replaces another in a compound.

$$AB + C \rightarrow AC + B$$

**Example**: Zinc + hydrochloric acid:

$$\text{Zn} + 2\text{HCl} \rightarrow \text{ZnCl}_2 + \text{H}_2$$

**Activity series**: More reactive metals replace less reactive ones from compounds!

### Double Replacement Reaction

Two compounds exchange partners.

$$AB + CD \rightarrow AD + CB$$

**Example**: Silver nitrate + sodium chloride:

$$\text{AgNO}_3 + \text{NaCl} \rightarrow \text{AgCl} + \text{NaNO}_3$$

**Evidence of reaction**: Silver chloride precipitates (white solid)

### Combustion Reaction

Rapid reaction with oxygen, releasing energy as heat and light.

**Hydrocarbon combustion**:

$$\text{C}_x\text{H}_y + \text{O}_2 \rightarrow x\text{CO}_2 + \frac{y}{2}\text{H}_2\text{O}$$

**Methane combustion**:

$$\text{CH}_4 + 2\text{O}_2 \rightarrow \text{CO}_2 + 2\text{H}_2\text{O}$$

**Complete combustion**: Enough oxygen (blue flame)
**Incomplete combustion**: Limited oxygen (yellow flame, produces soot)

## Energy in Reactions

### Exothermic Reactions

**Energy released**: Products have LESS potential energy than reactants.

**Example**: Combustion (releases heat)

```
Reactants (high PE)     Products (low PE)
    [H₂ + O₂]      →   [CO₂ + H₂O] + ENERGY
         ↓                ↓
       (bonds break)    (bonds form)
              + energy released
```

**Temperature increases**: Feels hot!

### Endothermic Reactions

**Energy absorbed**: Products have MORE potential energy than reactants.

**Example**: Photosynthesis (absorbs light energy)

$$6\text{CO}_2 + 6\text{H}_2\text{O} \rightarrow \text{C}_6\text{H}_{12}\text{O}_6 + \text{energy}$$

**Energy input**: Required from sunlight

## Reaction Rates

### Collision Theory

Reactions occur when particles **collide with sufficient energy** (activation energy).

**Factors affecting rate**:
1. **Temperature**: Higher temperature → faster (more particles with sufficient energy)
2. **Concentration**: More particles → more collisions → faster
3. **Surface area**: More exposure → more collisions → faster
4. **Catalyst**: Lowers activation energy → faster (not consumed)

### Activation Energy

Minimum energy needed to start reaction:

```
Energy
   ↑
 Ea        →  Reactants
 (activation     (with enough
  barrier)       energy to overcome Ea)
         ↓
    Products (lower energy)
```

**Catalyst**: Provides alternative pathway with lower activation energy!

## Equilibrium

**Reversible reactions** reach dynamic equilibrium when forward and reverse rates are equal.

$$A + B \rightleftharpoons C + D$$

### Le Chatelier''s Principle

If stress is applied to system at equilibrium, system shifts to counteract the stress:

| Stress | System Response |
|-------|-----------------|
| Increase concentration of reactant | Shift toward products (consumes added reactant) |
| Increase concentration of product | Shift toward reactants (consumes added product) |
| Increase pressure (gases) | Shift toward fewer gas molecules |
| Add heat (endothermic) | Shift in endothermic direction (absorbs added heat) |
| Remove heat (exothermic) | Shift in exothermic direction (releases added heat) |

## Oxidation-Reduction Reactions

**Oxidation**: Loss of electrons (increase in oxidation number)

**Reduction**: Gain of electrons (decrease in oxidation number)

**Oxidation-reduction** (redox): Both occur simultaneously!

**Example**: Combustion of magnesium:

$$2\text{Mg} + \text{O}_2 \rightarrow 2\text{MgO}$$

**Half-reactions**:
- Oxidation: $\text{Mg} \rightarrow \text{Mg}^{2+} + 2e^-$ (Mg loses 2 electrons)
- Reduction: $\text{O}_2 + 4e^- \rightarrow 2\text{O}^{2-}$ (O gains 2 electrons)

**Oxidizing agent**: Causes oxidation (is reduced itself)
**Reducing agent**: Causes reduction (is oxidized itself)

## Key Equations Summary

| Reaction Type | General Equation | Example |
|----------|-----------------|---------|
| Synthesis | A + B → AB | 2Na + Cl₂ → 2NaCl |
| Decomposition | AB → A + B | 2H₂O → 2H₂ + O₂ |
| Combustion | CₓHᵧ + (x+¼)O₂ → xCO₂ + (½y)H₂O | CH₄ + 2O₂ → CO₂ + 2H₂O |
| Single replacement | AB + C → AC + B | Zn + 2HCl → ZnCl₂ + H₂ |

## Sources
- OpenStax Chemistry 2e (2015). "Stoichiometry, The Mole Concept, and Molar Mass"
- Zumdahl, S., Zumdahl, S. (2017). "Chemistry: The Central Science, 10th ed."
- Khan Academy: "Chemical Reactions and Stoichiometry"
- Brown, W., LeMay, H. (2017). "Chemistry: The Central Science, 14th ed."
',

  '[
    {
      "question": "What does a balanced chemical equation satisfy?",
      "options": ["Equal masses on both sides", "Equal number of each type of atom on both sides", "Equal energies on both sides", "Equal charges on both sides"],
      "correctAnswer": 1,
      "explanation": "A balanced chemical equation has the SAME NUMBER of each type of atom on both sides (law of conservation of mass). For example, 2H₂ + O₂ → 2H₂O is balanced: left has 4H + 2O, right has 4H + 2O. Mass is neither created nor destroyed in chemical reactions!"
    },
    {
      "question": "Which type of reaction absorbs energy from surroundings (feels cold)?",
      "options": ["Exothermic reaction", "Endothermic reaction", "Synthesis reaction", "Combustion reaction"],
      "correctAnswer": 1,
      "explanation": "Endothermic reactions ABSORB energy from surroundings, making the container feel cold. Examples include photosynthesis (requires light energy), baking soda (heat input), and most dissolving reactions (like ammonium nitrate in water). The products have MORE potential energy than reactants."
    },
    {
      "question": "What is the role of a catalyst in a chemical reaction?",
      "options": ["Increases the energy of the products", "Lowers the activation energy, providing an alternative reaction pathway", "Increases the concentration of reactants", "Makes the reaction more exothermic"],
      "correctAnswer": 1,
      "explanation": "A catalyst LOWERS the activation energy (Ea) needed to start a reaction by providing an alternative pathway with lower energy barrier. Catalysts are NOT consumed (regenerated at the end). For example, enzymes in your body catalyze digestion; catalytic converters in cars reduce harmful emissions."
    },
    {
      "question": "In the reaction 2Mg + O₂ → 2MgO, which species is oxidized and which is reduced?",
      "options": ["Mg is reduced (gains e⁻), O₂ is reduced (gains e⁻)", "Mg is oxidized (loses e⁻), O₂ is oxidized (loses e⁻)", "Both are oxidized"],
      "correctAnswer": 2,
      "explanation": "Magnesium is OXIDIZED (loses 2 electrons to oxygen). Oxygen is REDUCED (gains 2 electrons from magnesium). Oxidation = loss of electrons (increase in oxidation number). Reduction = gain of electrons (decrease in oxidation number). Electrons are transferred from Mg to O!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'matter-atomic-structure' LIMIT 1),
  'Stoichiometry and the Mole',
  'stoichiometry-mole',
  5,
  '# Stoichiometry and the Mole Concept

## What Is the Mole?

**Mole (mol)**: SI unit for amount of substance

One mole contains **exactly Avogadro''s number** of particles:

$$N_A = 6.022 \times 10^{23} \text{ particles/mol}$$

## Why the Mole?

**Problem**: Atoms are too small to count individually!

**Solution**: Use a standard number of particles (like a dozen, but bigger).

**Examples**:
- 1 mole of carbon-12 atoms = exactly 12 grams
- 1 mole of water molecules = 18 grams (molar mass)

## Molar Mass

**Molar mass (M)**: Mass of ONE mole of substance (grams/mol)

| Substance | Formula | Molar Mass (g/mol) |
|----------|----------|-------------------|
| Water | H₂O | 18.015 |
| Carbon dioxide | CO₂ | 44.01 |
| Sodium chloride | NaCl | 58.44 |
| Glucose | C₆H₁₂O₆ | 180.16 |

**Calculating molar mass**:
$$M = \sum (\text{atomic masses} \times \text{number of atoms})$$

**Example**: Glucose (C₆H₁₂O₆)
$$M = 6(12.01) + 12(1.008) + 6(16.00) = 180.16 \text{ g/mol}$$

## Mole Calculations

### Moles to Mass

$$n = \frac{m}{M}$$

Where:
- $n$ = number of moles
- $m$ = mass (grams)
- $M$ = molar mass (g/mol)

**Example**: 36 g of water

$$n = \frac{36 \text{ g}}{18.015 \text{ g/mol}} = 2.0 \text{ mol}$$

### Mass to Moles

$$m = n \times M$$

**Example**: 0.5 mol of NaCl

$$m = 0.5 \text{ mol} \times 58.44 \text{ g/mol} = 29.22 \text{ g}$$

### Molar Volume of Gas

At STP (Standard Temperature and Pressure: 0°C, 1 atm):
$$V_m = 22.4 \text{ L/mol}$$

**Example**: 2 mol of oxygen gas at STP

$$V = 2 \text{ mol} \times 22.4 \text{ L/mol} = 44.8 \text{ L}$$

## Percent Composition

**Mass percent** of each element in a compound:

$$\% = \frac{\text{mass of element}}{\text{total mass}} \times 100\%$$

**Example**: Water (H₂O)

| Element | Mass (g/mol) | Total in Formula | % by Mass |
|----------|---------------|-----------------|---------|
| H | 1.008 × 2 = 2.016 | 2.016/18.015 | 11.2% |
| O | 16.00 × 1 = 16.00 | 16.00/18.015 | 88.8% |

## Empirical and Molecular Formulas

### Empirical Formula

**Simplest whole-number ratio** of atoms in compound.

**Determine from**:
- **Percent composition**
- **Mass data** from combustion analysis

**Example**: Glucose (C₆H₁₂O₆)

**Steps**:
1. Convert % to grams (assume 100 g)
2. Convert grams to moles
3. Calculate mole ratio
4. Reduce to simplest integers

### Molecular Formula

**Actual number** of atoms of each type in one molecule/unit.

**Example**: Benzene
- Empirical: CH
- Molecular: C₆H₆ (6 × empirical)

## Limiting Reactant

**Reactant that runs out first** and determines amount of product formed!

### Example**: Hot dogs in buns

```
Hot dog: 1 bun + 1 sausage
Hot dog bun: 2 bun
Sausage: 1 sausage

With 2 hot dogs + 1 bun:
- 2 hot dogs = 2 buns + 2 sausages ✓
- 1 extra bun remains unused
```

**SAUSAGE is limiting reactant!**

### Calculating Limiting Reactant

**Problem**: 10 H₂ + 7 O₂ → ?

**Step 1**: Calculate moles of each reactant

Assume STP (22.4 L/mol):
- $n(\text{H}_2) = \frac{10}{22.4} = 0.446 \text{ mol}$
- $n(\text{O}_2) = \frac{7}{22.4} = 0.313 \text{ mol}$

**Step 2**: Calculate required O₂ for available H₂

From balanced equation: $2\text{H}_2 + \text{O}_2 \rightarrow 2\text{H}_2\text{O}$

$$n(\text{O}_2) \text{ needed} = \frac{n(\text{H}_2)}{2} = \frac{0.446}{2} = 0.223 \text{ mol}$$

**Step 3**: Identify limiting reactant

Available O₂ (0.313 mol) > Needed O₂ (0.223 mol)

**Hydrogen is LIMITING!**

## Solution Stoichiometry

**Molarity (M)**: Moles of solute per liter of solution

$$M = \frac{n}{V}$$

Where:
- $n$ = moles of solute
- $V$ = volume of solution (L)

**Units**: mol/L (commonly written as M, e.g., 0.1 M)

### Dilution

$$M_1 V_1 = M_2 V_2$$

When diluting, moles of solute stay constant!

**Example**: Dilute 100 mL of 1.0 M NaCl to 0.1 M

$$1.0 \times 0.100 = 0.1 \times 0.200$$

$$V_2 = \frac{0.10}{0.1} = 1.0 \text{ L}$$

Add 900 mL water to reach 1.0 L total volume!

## Gravimetric Analysis

**Measuring mass** to determine concentration (more accurate than volume).

**Example**: Precipitate silver chloride:

$$\text{Ag}^+ + \text{Cl}^- \rightarrow \text{AgCl}(s)$$

**Steps**:
1. Measure mass of reactants
2. Mix solutions
3. Filter, wash, dry precipitate
4. Measure mass of product
5. Calculate % yield

### Percent Yield

$$\%\text{ yield} = \frac{\text{actual mass}}{\text{theoretical mass}} \times 100\%$$

## Key Formulas

| Formula | Quantity | Units |
|----------|----------|--------|
| $n = m/M$ | Moles from mass | mol |
| $m = n \times M$ | Mass from moles | g |
| $V_m = 22.4$ L/mol | Molar volume (STP) | L/mol |
| $M = n/V$ | Molarity | mol/L |
| $\% = \text{mass part}/\text{total mass} \times 100$ | Percent composition | % |

## Sources
- OpenStax Chemistry 2e (2015). "Stoichiometry, The Mole Concept, and Molar Mass"
- Zumdahl, S., Zumdahl, S. (2017). "Chemistry: The Central Science, 10th ed."
- Khan Academy: "Stoichiometry"
- Brown, W., LeMay, H. (2017). "Chemistry: The Central Science, 14th ed."
',

  '[
    {
      "question": "What is Avogadro''s number and why is it important?",
      "options": ["The number of molecules in 1 gram of water", "6.022×10²³ particles/mol (the mole)", "The number of atoms in 12 grams of carbon-12", "The number of electrons in an atom"],
      "correctAnswer": 1,
      "explanation": "Avogadro''s number (Nₐ = 6.022×10²³) is the number of particles in ONE mole. It connects atomic scale to macroscopic measurements. 1 mole of any substance contains exactly Nₐ particles. This allows us to count particles by weighing: 1 mole of carbon-12 atoms = exactly 12 grams!"
    },
    {
      "question": "What is the molar mass of water (H₂O)?",
      "options": ["10.01 g/mol", "18.015 g/mol", "22.4 L/mol", "16.00 g/mol"],
      "correctAnswer": 1,
      "explanation": "Molar mass of H₂O = 2(1.008) + 16.00 = 18.015 g/mol. This means 1 mole (6.022×10²³ molecules) of water has a mass of 18.015 grams. Molar mass is essential for converting between mass (grams) and amount (moles) in stoichiometry calculations!"
    },
    {
      "question": "If 2 H₂ + 1 O₂ react, which is the limiting reactant?",
      "options": ["O₂ because there''s more oxygen mass", "H₂ because there are more hydrogen atoms", "O₂ because only 1 mole O₂ is available but reaction needs 0.5 moles", "H₂ because it runs out first as the equation is 2:1 ratio"],
      "correctAnswer": 3,
      "explanation": "The balanced equation is 2H₂ + O₂ → 2H₂O (mole ratio 2:1). With 2 moles H₂ and 1 mole O₂ available, we need 0.5 moles O₂ to react with 1 mole H₂. We have 1 mole O₂ available (excess). After consuming 1 mole H₂, 0.5 moles O₂ remain unused. HYDROGEN is limiting!"
    },
    {
      "question": "What is the difference between empirical and molecular formulas?",
      "options": ["Empirical is always simpler than molecular", "Empirical shows simplest whole-number ratio; molecular shows actual atoms in one molecule", "Molecular is for ionic compounds, empirical for covalent", "There is no difference—they are always the same"],
      "correctAnswer": 1,
      "explanation": "Empirical formula = simplest whole-number ratio (CH for benzene C₆H₆). Molecular formula = actual atoms per molecule (C₆H₆ for benzene). Molecular formula is ALWAYS a multiple of empirical formula: (empirical)ₙ where n = 1, 2, 3... Benzene: molecular = 6 × empirical CH!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: CHEMICAL BONDING AND STRUCTURE
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'chemistry-basics' LIMIT 1),
  'Chemical Bonding and Structure',
  'chemical-bonding-structure',
  'Learn about ionic, covalent, and metallic bonding, molecular shapes, and intermolecular forces.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2 (continuing with more chapters...)
