-- Materials Science Course Migration
-- Course: Materials Science
-- Description: Learn about the structure, properties, and applications of materials
-- Level: Intermediate
-- Category: Engineering & Technology

BEGIN $$;

-- Insert the Materials Science course
INSERT INTO courses (id, title, slug, description, level, category, display_order, thumbnail_url, created_at)
VALUES (
  '550e8400-e29b-41d4-a716-446655440010',
  'Materials Science',
  'materials-science',
  'Explore the fascinating world of materials science, from atomic structure to advanced applications. Learn about metals, polymers, ceramics, and composites, and understand how their properties make them suitable for different applications.',
  'intermediate',
  'Engineering & Technology',
  8,
  'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=800&h=600&fit=crop',
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

-- Get the course ID for chapter references
DO $$
DECLARE
  materials_course_id UUID;
  chapter1_id UUID;
  chapter2_id UUID;
  chapter3_id UUID;
  chapter4_id UUID;
  chapter5_id UUID;
BEGIN
  -- Get the course ID
  SELECT id INTO materials_course_id FROM courses WHERE slug = 'materials-science';

  -- Insert Chapter 1: Introduction to Materials Science
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    '660e8400-e29b-41d4-a716-446655440011',
    materials_course_id,
    'Introduction to Materials Science',
    'introduction-to-materials-science',
    'Learn the fundamentals of materials science, including classification, atomic structure, bonding, crystal structures, and how microstructure affects material properties.',
    1,
    NOW()
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO chapter1_id;

  -- Insert Chapter 2: Mechanical Properties of Materials
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    '660e8400-e29b-41d4-a716-446655440012',
    materials_course_id,
    'Mechanical Properties of Materials',
    'mechanical-properties-of-materials',
    'Understand stress, strain, deformation, strengthening mechanisms, failure analysis, fatigue, and creep in materials.',
    2,
    NOW()
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO chapter2_id;

  -- Insert Chapter 3: Metals and Alloys
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    '660e8400-e29b-41d4-a716-446655440013',
    materials_course_id,
    'Metals and Alloys',
    'metals-and-alloys',
    'Explore the structure of metals, phase diagrams, ferrous and non-ferrous alloys, heat treatment, and processing techniques.',
    3,
    NOW()
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO chapter3_id;

  -- Insert Chapter 4: Polymers and Ceramics
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    '660e8400-e29b-41d4-a716-446655440014',
    materials_course_id,
    'Polymers and Ceramics',
    'polymers-and-ceramics',
    'Study polymer structure and types, ceramic properties, processing methods, and composite materials.',
    4,
    NOW()
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO chapter4_id;

  -- Insert Chapter 5: Electronic and Optical Materials
  INSERT INTO chapters (id, course_id, title, slug, description, display_order, created_at)
  VALUES (
    '660e8400-e29b-41d4-a716-446655440015',
    materials_course_id,
    'Electronic and Optical Materials',
    'electronic-and-optical-materials',
    'Learn about electrical properties, semiconductors, magnetic materials, optical properties, and nanomaterials.',
    5,
    NOW()
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO chapter5_id;

  -- Retrieve chapter IDs if they already existed
  IF chapter1_id IS NULL THEN
    SELECT id INTO chapter1_id FROM chapters WHERE slug = 'introduction-to-materials-science';
  END IF;
  IF chapter2_id IS NULL THEN
    SELECT id INTO chapter2_id FROM chapters WHERE slug = 'mechanical-properties-of-materials';
  END IF;
  IF chapter3_id IS NULL THEN
    SELECT id INTO chapter3_id FROM chapters WHERE slug = 'metals-and-alloys';
  END IF;
  IF chapter4_id IS NULL THEN
    SELECT id INTO chapter4_id FROM chapters WHERE slug = 'polymers-and-ceramics';
  END IF;
  IF chapter5_id IS NULL THEN
    SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';
  END IF;

END $$;

-- Get chapter IDs for lesson insertion
DO $$
DECLARE
  chapter1_id UUID;
  chapter2_id UUID;
  chapter3_id UUID;
  chapter4_id UUID;
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter1_id FROM chapters WHERE slug = 'introduction-to-materials-science';
  SELECT id INTO chapter2_id FROM chapters WHERE slug = 'mechanical-properties-of-materials';
  SELECT id INTO chapter3_id FROM chapters WHERE slug = 'metals-and-alloys';
  SELECT id INTO chapter4_id FROM chapters WHERE slug = 'polymers-and-ceramics';
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';


  -- Chapter 1: Introduction to Materials Science
  -- Lesson 1.1: What is Materials Science?
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440101',
    chapter1_id,
    'What is Materials Science?',
    'what-is-materials-science',
    'Learn what materials science is, its history, importance, and how it connects physics, chemistry, and engineering.',
    '# What is Materials Science?

## Introduction to Materials Science

Materials science is an interdisciplinary field that investigates the relationship between the **structure** of materials at atomic or molecular scales and their **macroscopic properties**. It combines elements of physics, chemistry, and engineering to understand how materials can be designed and used for specific applications.

## Why Study Materials Science?

Every technological advancement in human history has been tied to **materials discovery**:
- **Stone Age** (≈2.5 million years ago): Stone tools, weapons
- **Bronze Age** (≈3300 BCE): Copper-tin alloys, stronger tools
- **Iron Age** (≈1200 BCE): Iron and steel, even stronger materials
- **Silicon Age** (≈1950s-present): Semiconductors, modern electronics

## The Materials Science Tetrahedron

The field is often represented by four interconnected aspects:

1. **Structure**: How atoms are arranged (crystal structure, microstructure)
2. **Properties**: Measurable characteristics (mechanical, electrical, thermal)
3. **Processing**: How materials are made (casting, forging, heat treatment)
4. **Performance**: How materials behave in real-world applications

$$\text{Structure} \leftrightarrow \text{Properties} \leftrightarrow \text{Processing} \leftrightarrow \text{Performance}$$

## Classification of Materials

Materials are generally classified into main categories:

| Category | Examples | Key Properties | Applications |
|----------|----------|----------------|--------------|
| **Metals** | Steel, aluminum, copper | Ductile, conductive, strong | Structures, wiring, vehicles |
| **Ceramics** | Glass, porcelain, diamonds | Brittle, hard, insulating | Cookware, cutting tools, electronics |
| **Polymers** | Plastics, rubber, fibers | Flexible, lightweight | Packaging, clothing, coatings |
| **Composites** | Carbon fiber, fiberglass | Tailored properties | Aircraft, sports equipment |
| **Semiconductors** | Silicon, germanium | Tunable conductivity | Computer chips, solar cells |

## Structure-Property Relationships

The fundamental principle of materials science is that **properties depend on structure**:

- **Diamond vs Graphite**: Both are pure carbon (C), but different atomic arrangements give vastly different properties
  - Diamond: Hard, transparent, insulating (tetrahedral structure)
  - Graphite: Soft, opaque, conductive (layered structure)

- **Steel vs Copper**: Both are metals, but different bonding and crystal structures
  - Steel: Strong, magnetic (iron with carbon)
  - Copper: Softer, excellent conductor (pure FCC structure)

## Real-World Example: Smartphone

A modern smartphone contains many materials working together:

1. **Glass Screen**: Silica-based ceramic (scratch-resistant)
2. **Aluminum Case**: Lightweight metal (strength + aesthetics)
3. **Lithium Battery**: Electrochemistry (energy storage)
4. **Silicon Chip**: Semiconductor (computing)
5. **Gold Contacts**: Conductive metal (corrosion-resistant)
6. **Plastic Components**: Polymer (insulation, flexibility)

## Historical Timeline

- **Ancient times**: Discovery of copper, bronze, iron
- **Middle Ages**: Steel-making advances
- **Industrial Revolution**: Mass production of steel
- **20th century**: Polymers, semiconductors, composites
- **21st century**: Nanomaterials, smart materials, metamaterials

## Key Concepts to Remember

1. **Materials selection** involves balancing properties, cost, and processing
2. **Structure at multiple scales** matters (atomic → micro → macro)
3. **No perfect material exists** - trade-offs are always necessary
4. **Materials enable technology** - advances in materials lead to new applications',
    '[
      {
        "question": "What are the four main aspects of materials science?",
        "options": [
          "Atoms, molecules, bonds, and crystals",
          "Structure, properties, processing, and performance",
          "Metals, ceramics, polymers, and composites",
          "Physics, chemistry, biology, and engineering"
        ],
        "correctAnswer": 1,
        "explanation": "The materials science tetrahedron consists of four interconnected aspects: structure (atomic arrangement), properties (measurable characteristics), processing (how materials are made), and performance (real-world behavior)."
      },
      {
        "question": "Why are diamond and graphite so different if they''re both pure carbon?",
        "options": [
          "Diamond contains impurities that make it harder",
          "They have different atomic arrangements (crystal structures)",
          "Graphite is actually a different element",
          "Diamond was formed under different temperature conditions"
        ],
        "correctAnswer": 1,
        "explanation": "Diamond and graphite both consist of pure carbon atoms, but diamond has a tetrahedral structure (3D network) making it hard and transparent, while graphite has a layered structure (2D sheets) making it soft and conductive."
      },
      {
        "question": "Which material property pairing is correct?",
        "options": [
          "Metals: Brittle and insulating",
          "Ceramics: Ductile and conductive",
          "Polymers: Flexible and lightweight",
          "Semiconductors: Always highly conductive"
        ],
        "correctAnswer": 2,
        "explanation": "Polymers are known for being flexible and lightweight. Metals are ductile and conductive, ceramics are brittle and insulating, and semiconductors have tunable conductivity (not always highly conductive)."
      }
    ]',
    1,
    NOW()
  );

  -- Lesson 1.2: Materials Classification
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440102',
    chapter1_id,
    'Materials Classification',
    'materials-classification',
    'Learn how materials are classified based on their structure, bonding, and properties.',
    '# Materials Classification

## Introduction

Materials are classified based on several criteria: **atomic bonding**, **structure**, and **properties**. Understanding these classifications helps in selecting the right material for specific applications.

## Classification by Atomic Bonding

The type of chemical bonding between atoms fundamentally determines a material''s properties:

### 1. Metallic Bonding (Metals)

Metals have a "sea of electrons" that are delocalized and free to move throughout the material.

$$\text{Metal atoms} + \text{Delocalized electrons} \rightarrow \text{Metallic bond}$$

**Properties**:
- Good electrical and thermal conductivity (free electrons)
- Ductile and malleable (atoms can slide past each other)
- Metallic luster (light interaction with free electrons)
- High melting points (varying widely)

**Examples**: Iron, copper, aluminum, gold, silver, titanium

### 2. Covalent Bonding (Ceramics, Some Polymers)

Atoms share electrons in specific directions, creating strong directional bonds.

$$A \cdot + \cdot B \rightarrow A:B \text{ (shared electrons)}$$

**Properties**:
- Very hard and strong (directional bonds)
- High melting points
- Brittle (bonds break rather than rearrange)
- Often insulating (no free electrons)

**Examples**: Diamond (covalent network), silicon dioxide (SiO₂), silicon carbide (SiC)

### 3. Ionic Bonding (Ceramics)

Electrons are transferred from one atom to another, creating positive and negative ions that attract electrostatically.

$$M^{n+} + X^{n-} \rightarrow MX \text{ (ionic solid)}$$

**Properties**:
- Hard and brittle
- High melting points
- Good insulators
- Often transparent or translucent
- Can dissolve in water (if polar)

**Examples**: NaCl (table salt), MgO, Al₂O₃ (alumina), ZrO₂ (zirconia)

### 4. Van der Waals Bonding (Some Polymers, Layered Materials)

Weak intermolecular forces between molecules or layers.

$$F_{vdw} \propto -\frac{1}{r^6} \text{ (attractive force)}$$

**Properties**:
- Low melting points
- Soft and easily deformed
- Often flexible

**Examples**: Graphite (between layers), polyethylene, paraffin wax

### 5. Mixed Bonding

Many materials have combinations of bonding types.

**Examples**:
- **Semiconductors**: Mixed covalent-metallic bonding
- **Transition metals**: Metallic + some covalent character
- **Composites**: Different phases with different bonding

## Classification by Structure

### Crystalline Materials

Atoms are arranged in **regular, repeating patterns** called crystal lattices.

**Types**:
- **Single crystals**: One continuous crystal (gemstones, silicon wafers)
- **Polycrystals**: Many small crystals (grains) with different orientations (most metals)

**Crystal systems** (7 total):
1. Cubic (simple, body-centered, face-centered)
2. Tetragonal
3. Orthorhombic
4. Hexagonal
5. Rhombohedral (trigonal)
6. Monoclinic
7. Triclinic

### Amorphous Materials

Atoms have **no long-range order**, only short-range order.

**Properties**:
- Isotropic (same properties in all directions)
- Often transparent (light scattering minimized)
- Lower density than crystalline counterparts

**Examples**: Glass, most polymers, gels, some metallic glasses

### Quasicrystals

Have **ordered but non-periodic** structures (discovered in 1982).

**Properties**: 
- Unusual symmetry (5-fold rotation)
- Low friction, low thermal conductivity
- Hard and brittle

## Classification by Properties

### Conductors vs Insulators vs Semiconductors

Based on **electrical conductivity** (σ):

$$\sigma = \frac{1}{\rho}$$

where ρ is resistivity.

| Type | Conductivity (S/m) | Examples |
|------|-------------------|----------|
| Conductors | σ > 10⁶ | Metals (Cu: 5.96×10⁷) |
| Semiconductors | 10⁻⁶ < σ < 10⁶ | Si, Ge, GaAs |
| Insulators | σ < 10⁻⁶ | Diamond, glass, rubber |

### Ferromagnetic vs Paramagnetic vs Diamagnetic

Based on **magnetic response**:

| Type | Response | Examples |
|------|----------|----------|
| Ferromagnetic | Strong attraction, permanent magnets | Fe, Ni, Co |
| Paramagnetic | Weak attraction | Al, O₂ (gas) |
| Diamagnetic | Weak repulsion | Cu, H₂O, most organics |

## Classification by Application

### Structural Materials

Used for **load-bearing applications**:
- Metals (steel beams, aluminum frames)
- Composites (carbon fiber, fiberglass)
- Ceramics (concrete, brick)

### Functional Materials

Used for **special properties**:
- Electronic (silicon chips, superconductors)
- Magnetic (motors, transformers)
- Optical (lenses, fiber optics)
- Smart materials (shape memory alloys, piezoelectrics)

### Biomaterials

Used in **medical applications**:
- Biocompatible (titanium implants)
- Bioresorbable (PLA sutures)
- Bioactive (hydroxyapatite bone grafts)

## Materials Selection Criteria

When selecting materials, engineers consider:

1. **Mechanical properties**: Strength, stiffness, toughness
2. **Physical properties**: Density, melting point, thermal expansion
3. **Chemical properties**: Corrosion resistance, reactivity
4. **Electrical/Magnetic properties**: Conductivity, permeability
5. **Processing**: How easily it can be shaped
6. **Cost**: Raw material and processing costs
7. **Availability**: Supply chain considerations
8. **Environmental impact**: Recyclability, sustainability

## Ashby Charts

Materials selection charts (Ashby charts) plot **two properties** for many materials:
- **Young''s modulus vs density**: Stiffness-to-weight ratio
- **Strength vs toughness**: Strength vs resistance to fracture
- **Cost vs performance**: Economic considerations

These charts help engineers **compare materials** and find optimal solutions.

## Summary

- **Bonding type** fundamentally determines properties
- **Crystalline vs amorphous** structure affects behavior
- **Property-based classification** guides material selection
- **No single material is perfect** - trade-offs are always necessary
- **Ashby charts** help compare materials for specific applications',
    '[
      {
        "question": "Which type of bonding is responsible for the high ductility of metals?",
        "options": [
          "Covalent bonding",
          "Ionic bonding",
          "Metallic bonding (sea of delocalized electrons)",
          "Van der Waals bonding"
        ],
        "correctAnswer": 2,
        "explanation": "Metallic bonding involves a sea of delocalized electrons that allows metal atoms to slide past each other without breaking bonds, giving metals their characteristic ductility and malleability."
      },
      {
        "question": "What is the main difference between crystalline and amorphous materials?",
        "options": [
          "Crystalline materials are always stronger than amorphous materials",
          "Crystalline materials have regular repeating atomic patterns, amorphous materials do not",
          "Amorphous materials cannot be transparent",
          "Crystalline materials are always man-made"
        ],
        "correctAnswer": 1,
        "explanation": "Crystalline materials have atoms arranged in regular, repeating patterns (crystal lattices), while amorphous materials lack long-range order. This difference affects properties like transparency, density, and mechanical behavior."
      },
      {
        "question": "Why are ionic solids typically hard but brittle?",
        "options": [
          "They have no bonds between atoms",
          "The ionic bonds are strong but directional - if atoms slide, like charges repel",
          "They have the weakest type of bonding",
          "They are always amorphous"
        ],
        "correctAnswer": 1,
        "explanation": "Ionic solids have strong electrostatic bonds between positive and negative ions. However, if atoms try to slide past each other (as happens during deformation), ions with like charges become neighbors, causing strong repulsion and fracture (brittleness)."
      }
    ]',
    2,
    NOW()
  );

  -- Lesson 1.3: Atomic Structure and Bonding in Materials
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440103',
    chapter1_id,
    'Atomic Structure and Bonding in Materials',
    'atomic-structure-and-bonding',
    'Explore atomic structure, electron configurations, and how different types of bonding determine material properties.',
    '# Atomic Structure and Bonding in Materials

## Atomic Structure Basics

Understanding materials begins with understanding **atoms** - the building blocks of all matter.

### Atomic Components

An atom consists of:
- **Protons** (positive charge, in nucleus)
- **Neutrons** (neutral, in nucleus)
- **Electrons** (negative charge, orbit nucleus)

$$\text{Atomic number (Z)} = \text{Number of protons}$$
$$\text{Mass number (A)} = \text{Protons} + \text{Neutrons}$$

### Electron Configuration

Electrons occupy **shells and subshells** around the nucleus, following these rules:

1. **Aufbau principle**: Fill lowest energy orbitals first
2. **Pauli exclusion principle**: Maximum 2 electrons per orbital (opposite spins)
3. **Hund''s rule**: Maximize unpaired electrons in degenerate orbitals

**Orbital order**: 1s → 2s → 2p → 3s → 3p → 4s → 3d → 4p → 5s → 4d...

**Example**: Silicon (Si, Z=14)
$$\text{Electron configuration: } 1s^2 2s^2 2p^6 3s^2 3p^2$$
$$\text{Valence electrons: } 4 \text{ (in } 3s^2 3p^2\text{)}$$

### Valence Electrons and Bonding

**Valence electrons** (outermost shell electrons) determine bonding behavior:
- **Group 1-2 metals**: 1-2 valence e⁻ → tend to lose e⁻ → form ionic bonds
- **Groups 13-17 nonmetals**: 3-7 valence e⁻ → share/gain e⁻ → covalent/ionic bonds
- **Noble gases (Group 18)**: Full valence shell → inert

## Types of Chemical Bonding

### 1. Ionic Bonding

**Electron transfer** from metal to nonmetal creates ions that attract electrostatically.

$$Na \cdot + \cdot \overset{\cdot\cdot}{\underset{\cdot\cdot}{Cl}}: \rightarrow Na^+ + :Cl:^- \rightarrow NaCl$$

**Characteristics**:
- Large difference in electronegativity (ΔEN > 2.0)
- Formation of cations (+) and anions (-)
- Nondirectional bonding
- High melting/boiling points
- Brittle, hard solids
- Often water-soluble

**Coulombic attraction energy**:
$$E = \frac{k q_1 q_2}{r}$$

where k is Coulomb''s constant, q are charges, and r is distance.

**Example**: MgO (magnesium oxide)
$$Mg \rightarrow Mg^{2+} + 2e^-$$
$$O + 2e^- \rightarrow O^{2-}$$
$$Mg^{2+} + O^{2-} \rightarrow MgO \text{ (very high melting point: 2852°C)}$$

### 2. Covalent Bonding

**Electron sharing** between atoms (usually nonmetals with similar electronegativity).

$$H \cdot + \cdot H \rightarrow H:H \text{ (H}_2\text{ molecule)}$$

**Characteristics**:
- Small electronegativity difference (ΔEN < 1.7)
- Directional bonds
- Can form single, double, or triple bonds
- Varying strength and properties

**Types**:
- **Molecular covalent**: Discrete molecules (CO₂, H₂O, CH₄)
- **Network covalent**: Continuous 3D network (diamond, SiO₂ quartz)

**Bond energy** varies:
- Single bond: C-C (~347 kJ/mol)
- Double bond: C=C (~614 kJ/mol)
- Triple bond: C≡C (~839 kJ/mol)

### 3. Metallic Bonding

**Delocalized electron sea** surrounding positive metal ions.

$$M^+ + e^- \text{ (free)} \rightarrow \text{Metallic bonding}$$

**Characteristics**:
- Valence electrons free to move throughout metal
- Nondirectional bonding
- Good electrical and thermal conductivity
- Ductile and malleable
- Metallic luster

**Electron sea model**:
- Positive metal ion cores embedded in electron sea
- Electrons act as "glue" holding ions together
- Explains conductivity (electrons move freely)
- Explains ductility (ions can slide without breaking bonds)

### 4. Van der Waals Forces (Secondary Bonding)

**Weak intermolecular forces** between molecules or between atoms in layered structures.

**Types**:
1. **London dispersion forces**: Temporary dipoles in all molecules
2. **Dipole-dipole forces**: Permanent dipoles attract
3. **Hydrogen bonding**: Special dipole-dipole in H bonded to N/O/F

**Energy comparison**:
| Bond type | Energy (kJ/mol) |
|-----------|-----------------|
| Covalent | 150-1100 |
| Ionic | 400-4000 |
| Metallic | 70-850 |
| Hydrogen bond | 10-40 |
| Van der Waals | 0.4-4 |

## Interatomic Bonding and Material Properties

The **type and strength** of bonding determines:

| Property | Ionic | Covalent | Metallic | Van der Waals |
|----------|-------|-----------|----------|---------------|
| Melting point | High | Very high | Variable | Low |
| Electrical conductivity | Poor (insulator) | Poor | Good | Poor |
| Thermal conductivity | Poor | Poor to moderate | Good | Poor |
| Mechanical | Brittle | Hard/brittle | Ductile | Soft |
| Optical | Transparent | Variable | Opaque | Variable |

## Bonding in Real Materials

### Mixed Bonding

Most materials have **mixed bonding character**:

**Example 1: Silicon (semiconductor)**
- Primarily covalent bonding (tetrahedral)
- Some metallic character (delocalized electrons)
- Allows tunable conductivity

**Example 2: Graphite**
- Strong covalent bonds within layers (sp² hybridization)
- Weak van der Waals between layers
- Results in: strong in-plane, weak out-of-plane

### Secondary Bonding Effects

Even weak van der Waals forces can be significant:

**Example: Gecko feet**
- Millions of tiny hairs (setae)
- Van der Waals forces enable climbing
- Collectively strong despite individual weakness

## Electronegativity and Bond Character

**Electronegativity (EN)** measures atom''s ability to attract electrons.

**Pauling scale**: F (4.0) > O (3.5) > N (3.0) > C (2.5) ≈ S (2.5) > H (2.1) > metals (<2)

**Bond type prediction**:
- ΔEN = 0-0.4: Nonpolar covalent
- ΔEN = 0.4-1.7: Polar covalent
- ΔEN > 1.7: Ionic

**Example**: H₂O
$$\Delta EN = 3.5 (O) - 2.1 (H) = 1.4 \rightarrow \text{Polar covalent}$$

This explains water''s **dipole moment** and **hydrogen bonding**.

## Bond Length and Strength

General relationships:
- **Stronger bonds** are typically **shorter**
- **Multiple bonds** are shorter and stronger than single bonds
- **Larger atoms** form longer bonds

**Example**: Carbon-carbon bonds
| Bond type | Length (pm) | Energy (kJ/mol) |
|-----------|-------------|-----------------|
| C-C (single) | 154 | 347 |
| C=C (double) | 134 | 614 |
| C≡C (triple) | 120 | 839 |

## Crystal Field Theory (Transition Metals)

For **transition metal compounds**, the arrangement of ligands around metal ions affects:
- Energy of d-orbitals
- Color of compounds
- Magnetic properties
- Crystal structure

**Example**: Ruby (Al₂O₃ with Cr³⁺ impurities) - red color from crystal field splitting!

## Summary

- **Valence electrons** determine bonding behavior
- **Bonding type** (ionic, covalent, metallic, van der Waals) dictates properties
- **Electronegativity differences** predict bond character
- **Bond strength** correlates with melting point and hardness
- **Mixed bonding** is common in real materials
- **Secondary bonding** can be significant (hydrogen bonds, gecko feet)',
    '[
      {
        "question": "What is the primary factor that determines what type of bond will form between two atoms?",
        "options": [
          "The atomic masses of the atoms",
          "The electronegativity difference between the atoms",
          "The number of neutrons in the nucleus",
          "The temperature of the environment"
        ],
        "correctAnswer": 1,
        "explanation": "The electronegativity difference (ΔEN) between atoms is the primary factor determining bond type. ΔEN > 1.7 indicates ionic bonding, ΔEN < 0.4 indicates nonpolar covalent, and values between indicate polar covalent bonding."
      },
      {
        "question": "Why are metals good conductors of electricity?",
        "options": [
          "They have free protons that can carry charge",
          "They have a sea of delocalized valence electrons that can move freely",
          "Their atoms are held together by weak bonds that allow electron flow",
          "They have covalent bonds that easily break and reform"
        ],
        "correctAnswer": 1,
        "explanation": "Metals have metallic bonding where valence electrons are delocalized and form a \"sea\" of free electrons that can move throughout the material, carrying electrical current."
      },
      {
        "question": "How does the strength of intermolecular forces affect the melting point of a material?",
        "options": [
          "Stronger intermolecular forces lead to lower melting points",
          "Intermolecular forces have no effect on melting point",
          "Stronger intermolecular forces lead to higher melting points",
          "Only covalent bonds affect melting point, not intermolecular forces"
        ],
        "correctAnswer": 2,
        "explanation": "Stronger intermolecular forces (more energy required to overcome) lead to higher melting points. This is why ionic solids (very strong bonding) have high melting points, while molecular solids with only van der Waals forces have low melting points."
      }
    ]',
    3,
    NOW()
  );

  -- Lesson 1.4: Crystal Structures
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440104',
    chapter1_id,
    'Crystal Structures',
    'crystal-structures',
    'Learn about crystal structures, unit cells, Bravais lattices, and how atomic arrangement affects material properties.',
    '# Crystal Structures

## Introduction to Crystal Structures

**Crystal structures** describe the **regular, repeating arrangement** of atoms in crystalline materials. This arrangement fundamentally affects properties like:
- Mechanical strength
- Electrical conductivity
- Optical properties
- Thermal behavior
- Deformation mechanisms

## Basic Crystallography Concepts

### Lattice and Basis

A crystal structure consists of:
1. **Lattice**: Infinite array of points with identical surroundings
2. **Basis**: Atom or group of atoms associated with each lattice point

$$\text{Crystal structure} = \text{Lattice} + \text{Basis}$$

### Unit Cell

The **unit cell** is the smallest repeating unit that, when stacked in 3D, recreates the entire crystal.

**Key parameters**:
- **Lattice parameters (a, b, c)**: Edge lengths
- **Interaxial angles (α, β, γ)**: Angles between axes

### Coordination Number

The **coordination number (CN)** is the number of nearest neighbors surrounding an atom.

Higher CN typically means:
- Higher density
- Stronger bonding
- Higher melting point
- Often more ductile (for metals)

## The 7 Crystal Systems

All crystals can be classified into 7 crystal systems based on symmetry:

| Crystal System | Lattice Parameters | Examples |
|----------------|-------------------|----------|
| **Cubic** | a=b=c, α=β=γ=90° | Au, Cu, NaCl, diamond |
| **Tetragonal** | a=b≠c, α=β=γ=90° | TiO₂ (rutile), Sn (white) |
| **Orthorhombic** | a≠b≠c, α=β=γ=90° | S, Ga, Fe₃C (cementite) |
| **Hexagonal** | a=b≠c, α=β=90°, γ=120° | Mg, Zn, Cd, graphite |
| **Rhombohedral** | a=b=c, α=β=γ≠90° | As, Sb, Bi (calcite type) |
| **Monoclinic** | a≠b≠c, α=γ=90°≠β | Gypsum, monoclinic sulfur |
| **Triclinic** | a≠b≠c, α≠β≠γ≠90° | K₂Cr₂O₇, turquoise |

## Bravais Lattices

There are **14 unique Bravais lattices** (distinct lattice arrangements):

### Cubic System (3 lattices)

1. **Simple Cubic (SC)**
   - Atoms at corners only
   - CN = 6
   - Atomic packing factor (APF) = 0.52
   - Example: Polonium (rare)

2. **Body-Centered Cubic (BCC)**
   - Atoms at corners + center
   - CN = 8
   - APF = 0.68
   - Examples: Fe (α-iron), Cr, W, Mo, Na

3. **Face-Centered Cubic (FCC)**
   - Atoms at corners + face centers
   - CN = 12
   - APF = 0.74 (maximum for equal spheres)
   - Examples: Al, Cu, Au, Ag, Ni, Pt, Pb

### Hexagonal Close-Packed (HCP)

Not strictly a Bravais lattice but important:
- CN = 12
- APF = 0.74 (same as FCC)
- Examples: Mg, Zn, Cd, Ti, Be, Co

**FCC vs HCP**: Both have CN=12 and APF=0.74, but different stacking sequences:
- FCC: ABCABC... stacking
- HCP: ABAB... stacking

## Atomic Packing Factor (APF)

APF measures **how efficiently atoms pack** in a crystal:

$$\text{APF} = \frac{\text{Volume of atoms in unit cell}}{\text{Volume of unit cell}}$$

For spheres of radius r:

| Structure | APF | Efficiency |
|-----------|-----|------------|
| Simple cubic | 0.52 | 52% |
| BCC | 0.68 | 68% |
| FCC/HCP | 0.74 | 74% (maximum) |

**Real-world example**: Metals with FCC/HCP are generally more ductile because more slip systems are available.

## Density Calculations

Theoretical density (ρ) can be calculated from crystal structure:

$$\rho = \frac{n \cdot A}{V_c \cdot N_A}$$

where:
- n = atoms per unit cell
- A = atomic weight (g/mol)
- V_c = volume of unit cell (cm³)
- N_A = Avogadro''s number (6.022×10²³ atoms/mol)

**Example**: Copper (FCC, a = 0.3615 nm, A = 63.55 g/mol)
- n = 4 atoms per FCC unit cell
- V_c = a³ = (0.3615×10⁻⁷ cm)³ = 4.724×10⁻²³ cm³
- ρ = (4 × 63.55) / (4.724×10⁻²³ × 6.022×10²³) = **8.96 g/cm³**

## Crystal Structure and Properties

### Metals

| Structure | Properties | Examples |
|-----------|------------|----------|
| FCC | Ductile, more slip systems | Al, Cu, Au, Ag, Ni |
| BCC | Stronger, less ductile | Fe (α), Cr, W, Mo |
| HCP | Anisotropic, limited ductility | Mg, Zn, Ti, Cd |

### Ionic Crystals

Typically adopt structures based on **radius ratio rules**:

$$r_{cation}/r_{anion}$$

| Ratio range | Coordination | Structure | Example |
|-------------|--------------|-----------|---------|
| 0.225-0.414 | 4 | Zinc blende | ZnS |
| 0.414-0.732 | 6 | Rock salt (NaCl) | NaCl, MgO |
| 0.732-1.0 | 8 | CsCl | CsCl |

### Ceramic Structures

**Common ceramic crystal structures**:
1. **NaCl structure**: FCC anion lattice, cations in octahedral sites
2. **CsCl structure**: Simple cubic, cation at body center
3. **Zinc blende (ZnS)**: FCC with half tetrahedral sites filled
4. **Fluorite (CaF₂)**: FCC cation lattice, anions in tetrahedral sites

## Crystal Defects

Real crystals are **never perfect**. Defects include:

### Point Defects

**Vacancies**: Missing atom
- Equilibrium concentration at temperature T:
  $$\frac{n_v}{N} = e^{-Q_v/kT}$$
  where Q_v is activation energy for vacancy formation

**Interstitials**: Atom in non-lattice position

**Substitutional impurities**: Foreign atom replaces host atom

**Schottky defect**: Cation-anion vacancy pair (ionic crystals)

**Frenkel defect**: Vacancy-interstitial pair

### Line Defects

**Dislocations**: Linear defects where atoms are misaligned
- **Edge dislocation**: Extra half-plane of atoms
- **Screw dislocation**: Helical arrangement

Dislocations enable **plastic deformation** in metals.

### Planar Defects

**Grain boundaries**: Interfaces between crystal grains
- **Hall-Petch relationship**: Strength increases with decreasing grain size:
  $$\sigma_y = \sigma_0 + k \cdot d^{-1/2}$$
  where d is grain size

**Stacking faults**: Errors in stacking sequence
**Twin boundaries**: Mirror symmetry across boundary

### Volume Defects

**Precipitates**: Second-phase particles
**Voids**: Empty regions
**Cracks**: Fracture surfaces

## Polymorphism and Allotropy

Many materials exist in **multiple crystal structures** (polymorphs/allotropes) depending on temperature and pressure:

**Carbon allotropes**:
- Diamond: Cubic, hard, insulating
- Graphite: Hexagonal, soft, conductive
- Fullerene (C₆₀): Molecular
- Graphene: 2D sheets
- Carbon nanotubes: Cylindrical

**Iron allotropes**:
- α-iron (BCC): <912°C
- γ-iron (FCC): 912-1394°C
- δ-iron (BCC): 1394-1538°C

## Crystal Structure Determination

**X-ray diffraction (XRD)** is the primary method:
- Bragg''s Law:
  $$n\lambda = 2d \sin\theta$$
  where λ = X-ray wavelength, d = interplanar spacing, θ = Bragg angle

**Diffraction pattern** reveals:
- Crystal structure type
- Lattice parameters
- Phase identification
- Crystal orientation

## Summary

- **7 crystal systems** and **14 Bravais lattices** describe all crystalline materials
- **FCC and HCP** have the highest packing efficiency (0.74)
- **Crystal structure** fundamentally affects mechanical, electrical, and thermal properties
- **Defects** are always present and often beneficial (strengthening mechanisms)
- **Polymorphism** is common (multiple structures for same material)
- **X-ray diffraction** is used to determine crystal structures experimentally',
    '[
      {
        "question": "Which crystal structure has the highest atomic packing factor (APF)?",
        "options": [
          "Simple cubic (SC)",
          "Body-centered cubic (BCC)",
          "Face-centered cubic (FCC) and hexagonal close-packed (HCP)",
          "All crystal structures have the same APF"
        ],
        "correctAnswer": 2,
        "explanation": "Both FCC and HCP crystal structures have an APF of 0.74 (74%), which is the maximum packing efficiency possible for equal-sized spheres. BCC has an APF of 0.68, and simple cubic has only 0.52."
      },
      {
        "question": "What does the coordination number represent in a crystal structure?",
        "options": [
          "The number of different crystal systems",
          "The number of nearest neighbors surrounding an atom",
          "The ratio of atomic radius to lattice parameter",
          "The number of defects in the crystal"
        ],
        "correctAnswer": 1,
        "explanation": "The coordination number is the number of nearest neighbors surrounding an atom. For example, FCC has CN=12 (each atom touches 12 neighbors), BCC has CN=8, and simple cubic has CN=6."
      },
      {
        "question": "How does decreasing grain size affect the strength of a metal according to the Hall-Petch relationship?",
        "options": [
          "Strength decreases with decreasing grain size",
          "Grain size has no effect on strength",
          "Strength increases with decreasing grain size",
          "Strength first increases then decreases with grain size"
        ],
        "correctAnswer": 2,
        "explanation": "The Hall-Petch relationship (σ_y = σ₀ + k·d^(-1/2)) shows that yield strength increases with decreasing grain size. Smaller grains mean more grain boundaries, which impede dislocation motion and strengthen the material."
      }
    ]',
    4,
    NOW()
  );

  -- Lesson 1.5: Microstructure and Properties
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440105',
    chapter1_id,
    'Microstructure and Properties',
    'microstructure-and-properties',
    'Understand how microstructure (grains, phases, defects) influences material properties and how processing affects microstructure.',
    '# Microstructure and Properties

## Introduction

While atomic structure determines **intrinsic properties**, the **microstructure** (structure at the micron scale) determines many **extrinsic properties**. Microstructure includes:

- **Grains** and grain boundaries
- **Phases** and phase distributions
- **Defects** (dislocations, vacancies, precipitates)
- **Inclusions** and second-phase particles

**Key principle**: Properties can be tailored by controlling microstructure through processing.

## Structure Hierarchy

Materials have structure at multiple length scales:

1. **Atomic scale** (Å, 10⁻¹⁰ m): Bonding, crystal structure
2. **Nano scale** (nm, 10⁻⁹ m): Precipitates, dislocations
3. **Micro scale** (μm, 10⁻⁶ m): Grains, phases
4. **Macro scale** (mm to m): Bulk properties, component shape

$$\text{Processing} \rightarrow \text{Microstructure} \rightarrow \text{Properties} \rightarrow \text{Performance}$$

## Grains and Grain Boundaries

### What are Grains?

**Grains** are individual crystals within a polycrystalline material:
- Each grain has a specific crystal orientation
- Grains meet at **grain boundaries**
- Grain size typically ranges from ~1 μm to several mm

### Grain Structure

**Equiaxed grains**: Approximately equal dimensions in all directions
**Columnar grains**: Elongated in one direction

### Grain Boundary Effects

Grain boundaries affect:
1. **Mechanical properties**: 
   - Block dislocation motion → strengthen material
   - Too many boundaries → can reduce ductility

2. **Electrical properties**:
   - Scattering of electrons → increased resistivity

3. **Chemical properties**:
   - Enhanced diffusion pathways
   - Preferential corrosion sites

4. **Thermal properties**:
   - Reduced thermal conductivity (phonon scattering)

### Grain Size and Properties

**Hall-Petch relationship** (grain size strengthening):
$$\sigma_y = \sigma_0 + \frac{k}{\sqrt{d}}$$

where:
- σ_y = yield strength
- σ₀ = friction stress
- k = strengthening coefficient
- d = average grain diameter

**Smaller grains** → stronger but potentially less ductile

**Example**: Nanocrystalline materials (grain size < 100 nm) can be several times stronger than conventional materials.

## Phases and Phase Diagrams

### What is a Phase?

A **phase** is a region of material with:
- Homogeneous composition and structure
- Distinct boundaries from other phases

**Examples**:
- Ice + liquid water = 2 phases
- Steel (ferrite + cementite) = 2 phases
- Composite (fiber + matrix) = 2 phases

### Phase Diagrams

Phase diagrams show **stable phases** at different temperatures and compositions:

**Binary phase diagram features**:
- **Single-phase regions**: Homogeneous material
- **Two-phase regions**: Mixture of two phases
- **Liquidus line**: Above which liquid is stable
- **Solidus line**: Below which solid is stable
- **Solvus line**: Solubility limit in solid state
- **Eutectic point**: Lowest melting mixture

**Lever rule** (calculate phase amounts):
$$\text{fraction of phase } \alpha = \frac{C_\beta - C_0}{C_\beta - C_\alpha}$$

where C₀ is overall composition.

## Solid Solutions

### Types of Solid Solutions

**Substitutional solid solution**:
- Solute atoms replace solvent atoms on lattice sites
- Requires similar atomic radii (within ~15%)
- Same crystal structure
- Similar electronegativity
- Example: Cu-Zn (brass), Au-Ag

**Interstitial solid solution**:
- Small atoms occupy interstitial sites
- Only small atoms (C, N, H, B) in metals
- Example: Carbon in iron (steel)

**Hume-Rothery rules** predict solid solution formation:
1. Atomic size difference < 15%
2. Same crystal structure
3. Similar electronegativity
4. Same valence (preferably)

### Solid Solution Strengthening

Adding solute atoms strengthens by:
1. **Lattice strain**: Distorts crystal lattice
2. **Interaction with dislocations**: Impede dislocation motion
3. **Modulus mismatch**: Different bonding characteristics

**Strength increase**:
$$\Delta \sigma \propto \sqrt{c}$$

where c is solute concentration.

## Second-Phase Particles

### Precipitates

**Precipitates** are small particles of a second phase that form within the matrix:
- Typically 1 nm to 1 μm in size
- Can strengthen material significantly

**Precipitation hardening steps**:
1. **Solution treatment**: Dissolve precipitates at high T
2. **Quenching**: Rapid cooling to trap solute
3. **Aging**: Heat to allow controlled precipitate formation

**Examples**:
- Al-Cu alloys (aircraft parts)
- Ni-base superalloys (turbine blades)
- Maraging steels (high-strength applications)

### Dispersion Strengthening

**Dispersion strengthening** uses stable, insoluble particles:
- Particles resist coarsening (Ostwald ripening)
- Effective at high temperatures
- Example: Thoriated tungsten (ThO₂ particles in W)

### Inclusions

**Inclusions** are non-metallic particles (often oxides, sulfides):
- Generally detrimental (reduce ductility, toughness)
- Can be minimized by clean processing
- Sometimes used intentionally (free-machining steels with MnS inclusions)

## Defects and Properties

### Dislocations

**Dislocations** enable plastic deformation:
- **Edge dislocation**: Extra half-plane of atoms
- **Screw dislocation**: Helical atomic arrangement

**Dislocation density (ρ)**: length of dislocations per volume
- Annealed metal: ~10⁶ cm⁻²
- Cold-worked metal: ~10¹² cm⁻²

**Strengthening mechanisms** all work by impeding dislocations:
1. Grain boundary strengthening (Hall-Petch)
2. Solid solution strengthening
3. Precipitation hardening
4. Work hardening (increased dislocation density)

### Point Defects

**Equilibrium vacancy concentration**:
$$\frac{n_v}{N} = e^{-Q_v/kT}$$

At room temperature, typically ~10⁻⁴ to 10⁻⁶ vacancies

**Effects**:
- Enable diffusion
- Affect electrical properties
- Can cause property changes at high temperature

## Microstructure Control Through Processing

### Heat Treatment

**Annealing**: Heat to relieve stress, recrystallize
1. Recovery: Reduce dislocation density
2. Recrystallization: Form new, strain-free grains
3. Grain growth: Increase grain size

**Quenching**: Rapid cooling to trap high-temperature phases
**Tempering**: Reheat quenched material to improve toughness

### Mechanical Processing

**Cold working**: Plastic deformation below recrystallization temperature
- Increases strength (work hardening)
- Decreases ductility
- Increases dislocation density

**Hot working**: Deformation above recrystallization temperature
- Can achieve large shape changes
- Maintains ductility
- Recrystallization occurs simultaneously

### Thermal Processing

**Sintering**: Powder particles fuse at high temperature (ceramics)
**Casting**: Liquid metal solidifies in mold
**Additive manufacturing**: Layer-by-layer fabrication

## Structure-Property Examples

### Steel Heat Treatment

**Steel composition**: Fe + ~0.8% C

**Heat treatments**:
1. **Annealing**: Slow cool → soft ferrite + cementite
2. **Normalizing**: Air cool → finer pearlite
3. **Quenching**: Rapid cool → hard martensite
4. **Tempering**: Reheat martensite → toughened structure

**Microstructures**:
- **Ferrite**: BCC iron with low carbon content
- **Cementite**: Fe₃C (iron carbide), hard and brittle
- **Pearlite**: Lamellar mixture of ferrite + cementite
- **Martensite**: BCT (body-centered tetragonal), very hard

### Aluminum Alloy Precipitation Hardening

**Al-Cu alloy (2024)**:
1. Solution treat at 500°C (dissolve CuAl₂ precipitates)
2. Quench to room temperature (supersaturated solid solution)
3. Age at 190°C (form fine Guinier-Preston zones)

**Result**: Fine precipitates impede dislocation motion → strength doubles

## Microstructure Characterization

### Optical Microscopy

**Light microscopy** reveals:
- Grain size and shape
- Phase distribution
- Inclusions and defects

**Magnification**: Up to ~1000X
**Sample preparation**: Grinding, polishing, etching

### Electron Microscopy

**Scanning Electron Microscopy (SEM)**:
- Higher resolution (up to 100,000X)
- Topographic contrast
- Chemical analysis (EDS)

**Transmission Electron Microscopy (TEM)**:
- Atomic resolution
- Dislocation imaging
- Nanoscale precipitate analysis

### X-Ray Diffraction

**Phase identification**, crystal structure, texture analysis:
- **Peak positions**: Phase identification
- **Peak broadening**: Crystallite size, strain
- **Peak intensity**: Texture, phase fractions

## Summary

- **Microstructure** (grains, phases, defects) strongly influences properties
- **Grain size** affects strength (Hall-Petch relationship)
- **Phases** can be predicted from phase diagrams
- **Precipitates** and solid solutions strengthen materials
- **Processing** (heat treatment, mechanical working) controls microstructure
- **Characterization** techniques (microscopy, XRD) reveal microstructure
- **Structure-property-processing-performance** relationships guide material design',
    '[
      {
        "question": "According to the Hall-Petch relationship, how does decreasing grain size affect a metal''s strength?",
        "options": [
          "Strength decreases with smaller grain size",
          "Strength increases with smaller grain size",
          "Grain size has no effect on strength",
          "Strength increases only up to a certain grain size, then decreases"
        ],
        "correctAnswer": 1,
        "explanation": "The Hall-Petch relationship (σ_y = σ₀ + k·d^(-1/2)) shows that yield strength increases with decreasing grain size. Smaller grains mean more grain boundaries that impede dislocation motion, strengthening the material."
      },
      {
        "question": "What is the main mechanism by which precipitation hardening strengthens a material?",
        "options": [
          "Increasing grain size to reduce grain boundary area",
          "Forming fine precipitate particles that impede dislocation motion",
          "Removing all impurities to create a pure crystal",
          "Heating the material to reduce dislocation density"
        ],
        "correctAnswer": 1,
        "explanation": "Precipitation hardening strengthens materials by forming fine precipitate particles (typically 1 nm to 1 μm) that act as obstacles to dislocation motion. Dislocations must either cut through or bypass these precipitates, requiring higher stress."
      },
      {
        "question": "Why are grain boundaries considered both beneficial and detrimental to material properties?",
        "options": [
          "They are always beneficial in all respects",
          "They are always detrimental and should be eliminated",
          "Beneficial: strengthen by blocking dislocations; Detrimental: can reduce ductility and conductivity",
          "Beneficial: increase conductivity; Detrimental: only reduce strength"
        ],
        "correctAnswer": 2,
        "explanation": "Grain boundaries have complex effects. They strengthen materials by impeding dislocation motion (Hall-Petch strengthening) but can reduce ductility if too numerous. They also scatter electrons (increasing resistivity) and provide pathways for diffusion and corrosion."
      }
    ]',
    5,
    NOW()
  );

  -- Chapter 2: Mechanical Properties of Materials
  -- Lesson 2.1: Stress and Strain
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440201',
    chapter2_id,
    'Stress and Strain',
    'stress-and-strain',
    'Learn about stress, strain, elastic deformation, Young''s modulus, and how materials respond to applied forces.',
    '# Stress and Strain

## Introduction

**Stress and strain** are fundamental concepts in understanding how materials deform under applied forces. These concepts are critical for:

- Designing safe structures
- Selecting materials for specific applications
- Predicting failure modes
- Understanding material behavior

## Stress

**Stress (σ)** is the **force per unit area** acting on a material:

$$\sigma = \frac{F}{A}$$

where:
- F = applied force (N)
- A = cross-sectional area (m²)
- σ = stress (Pa or N/m²)

**Units**:
- Pascal (Pa) = N/m²
- Commonly expressed in MPa (10⁶ Pa) or GPa (10⁹ Pa)

### Types of Stress

**1. Tensile Stress**
Force pulling material apart:
$$\sigma_t = \frac{F_t}{A}$$

**2. Compressive Stress**
Force pushing material together:
$$\sigma_c = \frac{F_c}{A}$$

**3. Shear Stress**
Force causing parallel planes to slide:
$$\tau = \frac{F_s}{A}$$

where τ is shear stress.

## Strain

**Strain (ε)** is the **dimensionless deformation** of a material:

$$\epsilon = \frac{\Delta L}{L_0}$$

where:
- ΔL = change in length (m)
- L₀ = original length (m)
- ε = strain (unitless, often expressed as %)

### Types of Strain

**1. Tensile Strain** (elongation):
$$\epsilon_t = \frac{L_f - L_0}{L_0}$$

**2. Compressive Strain** (contraction):
$$\epsilon_c = \frac{L_0 - L_f}{L_0}$$

**3. Shear Strain** (angular deformation):
$$\gamma = \tan \theta \approx \theta \text{ (for small angles)}$$

## Stress-Strain Behavior

### Elastic Deformation

**Elastic deformation** is **reversible** - material returns to original shape when load is removed.

**Hooke''s Law**:
$$\sigma = E\epsilon$$

where **E = Young''s modulus** (elastic modulus), a measure of stiffness.

**Young''s Modulus Values**:
| Material | E (GPa) |
|----------|---------|
| Rubber | 0.01-0.1 |
| Nylon | 2-4 |
| Aluminum | 69 |
| Steel | 200 |
| Diamond | 1050 |

**Interpretation**:
- Higher E = stiffer material
- Diamond is ~15× stiffer than steel
- Steel is ~20× stiffer than aluminum

### Plastic Deformation

**Plastic deformation** is **permanent** - material remains deformed after load removal.

**Yield strength (σ_y)**: Stress at which plastic deformation begins.

**Onset of plasticity**:
- Materials deform elastically up to yield point
- Beyond yield, permanent deformation occurs
- Slip systems activate (dislocation motion)

## Stress-Strain Curve

A typical tensile stress-strain curve for ductile materials:

```
Stress (σ)
↑
│              ╱ Ultimate tensile strength (σ_UTS)
│            ╱
│          ╱  
│        ╱    ← Necking begins
│      ╱
│    ╱  Yield strength (σ_y)
│  ╱  
│╱_____________ Strain (ε)
```

**Key points on the curve**:

1. **Proportional limit**: End of linear elastic region
2. **Yield strength**: Onset of plastic deformation
3. **Ultimate tensile strength (UTS)**: Maximum stress
4. **Fracture strength**: Stress at failure
5. **Fracture strain**: Total strain at failure

## Mechanical Properties from Stress-Strain

### Elastic Moduli

**Young''s Modulus (E)**: Tensile stiffness
$$E = \frac{\sigma}{\epsilon} \text{ (elastic region)}$$

**Shear Modulus (G)**: Resistance to shear
$$G = \frac{\tau}{\gamma}$$

**Bulk Modulus (K)**: Resistance to volume change
$$K = -V \frac{dP}{dV}$$

**Relationship** (for isotropic materials):
$$E = 2G(1 + \nu) = 3K(1 - 2\nu)$$

where **ν = Poisson''s ratio** (ratio of transverse to axial strain).

**Poisson''s ratio** values:
- ν ≈ 0.3 for most metals
- ν ≈ 0.5 for incompressible materials (rubber)
- ν ≈ 0.1 for brittle ceramics

### Strength Properties

**Yield Strength (σ_y)**:
- Stress for 0.2% offset strain (common definition)
- Beginning of plastic deformation
- Critical for design (avoid permanent deformation)

**Ultimate Tensile Strength (σ_UTS)**:
- Maximum engineering stress
- Often higher than yield strength due to work hardening
- Important for brittle materials

**Fracture Strength (σ_f)**:
- Stress at failure
- Can be lower than UTS (necking region)

### Ductility Measures

**Elongation at break**:
$$\text{% elongation} = \frac{L_f - L_0}{L_0} \times 100\%$$

**Reduction in area**:
$$\text{% RA} = \frac{A_0 - A_f}{A_0} \times 100\%$$

**Typical values**:
| Material | Elongation |
|----------|------------|
| Cast iron | <1% |
| High-strength steel | 5-15% |
| Mild steel | 20-30% |
| Aluminum | 30-50% |
| Gold | 30-50% |

## Engineering vs True Stress-Strain

**Engineering stress** (based on original dimensions):
$$\sigma_e = \frac{F}{A_0}$$

**True stress** (based on instantaneous area):
$$\sigma_t = \frac{F}{A}$$

**Relationship** (assuming constant volume):
$$\sigma_t = \sigma_e (1 + \epsilon_e)$$

For large strains, true stress-strain is more accurate.

## Anelasticity (Viscoelasticity)

Some materials exhibit **time-dependent elastic behavior**:

**Characteristics**:
- Stress-strain curve depends on strain rate
- Hysteresis in loading-unloading cycles
- Energy dissipation (damping)

**Examples**:
- Polymers (creep, stress relaxation)
- Biological tissues
- Some metals at high temperature

## Factors Affecting Mechanical Properties

### Temperature

**General trends**:
- Higher T → lower strength, higher ductility
- Lower T → higher strength, lower ductility
- Ductile-to-brittle transition (some materials)

### Strain Rate

**Higher strain rate** → higher apparent strength (less time for dislocation motion)

### Grain Size

**Smaller grains** → higher strength (Hall-Petch):
$$\sigma_y = \sigma_0 + \frac{k}{\sqrt{d}}$$

### Alloying

**Add solute atoms** → solid solution strengthening:
$$\Delta\sigma \propto \sqrt{c}$$

where c is solute concentration.

## Real-World Examples

### Structural Steel Design

**Example**: Steel beam supporting a load
- Steel E = 200 GPa
- Allowable stress = 250 MPa (well below yield)
- Factor of safety ≈ 2-3

Why not use full strength?
- Account for uncertainties
- Prevent unexpected failure
- Allow for imperfections

### Aluminum Can

**Why aluminum for beverage cans?**
- Lightweight (ρ = 2.7 g/cm³ vs steel 7.9 g/cm³)
- Ductile (can be formed into thin sheets)
- Corrosion resistant (forms protective oxide)
- Recyclable

### Rubber Band

**Elastic behavior**:
- Low modulus (E ≈ 0.01-0.1 GPa)
- Large elastic strains (up to ~500%)
- Entropic elasticity (chain unfolding)

## Summary

- **Stress** = force/area, **strain** = deformation/original length
- **Elastic deformation** is reversible (Hooke''s Law: σ = Eε)
- **Plastic deformation** is permanent (beyond yield strength)
- **Young''s modulus** measures stiffness
- **Ductility** measures how much material can deform before fracture
- **Temperature, strain rate, grain size, and composition** affect properties
- **Engineering vs true stress-strain** matter for large deformations',
    '[
      {
        "question": "What is the main difference between elastic and plastic deformation?",
        "options": [
          "Elastic deformation is permanent, plastic deformation is temporary",
          "Elastic deformation is reversible (material returns to original shape), plastic deformation is permanent",
          "Plastic deformation only occurs in metals, elastic deformation only occurs in polymers",
          "There is no difference - both types of deformation are the same"
        ],
        "correctAnswer": 1,
        "explanation": "Elastic deformation is reversible - the material returns to its original shape when the load is removed, following Hooke''s Law (σ = Eε). Plastic deformation is permanent - the material remains deformed after load removal because dislocations have moved."
      },
      {
        "question": "What does Young''s modulus (E) tell us about a material?",
        "options": [
          "The maximum stress the material can withstand",
          "How ductile the material is",
          "The material''s stiffness - resistance to elastic deformation",
          "The material''s density"
        ],
        "correctAnswer": 2,
        "explanation": "Young''s modulus (E) measures a material''s stiffness - its resistance to elastic deformation. Higher E means stiffer material. Diamond (E ≈ 1050 GPa) is very stiff, while rubber (E ≈ 0.01-0.1 GPa) is very flexible."
      },
      {
        "question": "If you apply a tensile force of 10,000 N to a steel rod with cross-sectional area of 100 mm², what is the stress in the rod?",
        "options": [
          "10 Pa",
          "100 MPa",
          "1000 MPa",
          "10 GPa"
        ],
        "correctAnswer": 1,
        "explanation": "Stress = Force/Area = 10,000 N / (100 mm² × 10⁻⁶ m²/mm²) = 10,000 N / 1×10⁻⁴ m² = 1×10⁸ Pa = 100 MPa. Always check units: 1 mm² = 10⁻⁶ m², and 1 MPa = 10⁶ Pa."
      }
    ]',
    1,
    NOW()
  );

  -- Lesson 2.2: Elastic and Plastic Deformation
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440202',
    chapter2_id,
    'Elastic and Plastic Deformation',
    'elastic-and-plastic-deformation',
    'Understand the mechanisms of elastic and plastic deformation, including dislocations and slip systems.',
    '# Elastic and Plastic Deformation

## Introduction

When materials are subjected to stress, they deform in two fundamentally different ways:

1. **Elastic deformation**: Reversible, atoms displaced slightly from equilibrium
2. **Plastic deformation**: Irreversible, atoms permanently rearranged

Understanding these mechanisms is crucial for predicting material behavior and designing for performance.

## Elastic Deformation

### Atomic Mechanism

In elastic deformation, **bonds stretch but don''t break**:

```
Initial state          Under tension
  ●-----●               ●-------●    (bonds stretch)
  |     |               |       |
  ●-----●               ●-------●

Force removed → returns to original position
```

**Hooke''s Law** (linear elasticity):
$$\sigma = E\epsilon$$

This linearity comes from **harmonic bond potentials** - for small displacements, bonds behave like springs.

**Energy perspective**:
- Work done loading = stored as elastic strain energy
- Energy returned upon unloading
- No energy lost in ideal elastic deformation

**Elastic strain energy density**:
$$U = \frac{1}{2}\sigma\epsilon = \frac{1}{2}E\epsilon^2$$

### Limits of Elasticity

**Elastic limit**: Maximum stress for purely elastic behavior
- Typically coincides with or near yield strength
- Beyond this, some plastic deformation occurs

**Proportional limit**: End of linear stress-strain relationship
- For many materials, ≈ yield strength
- Some materials deviate gradually (non-linear elasticity)

### Anelastic Behavior

**Anelasticity**: Time-dependent elastic recovery
- Stress-strain curve depends on strain rate
- Some energy dissipation (internal friction)
- Examples: polymers, some metals at high T

**Viscoelasticity**: Combination of viscous and elastic behavior
- Stress relaxation: Stress decreases at constant strain
- Creep: Strain increases at constant stress
- Common in polymers and biological tissues

## Plastic Deformation

### Atomic Mechanism

Plastic deformation occurs through **dislocation motion**:

**Dislocation**: Line defect where atoms are misaligned

**Edge dislocation**:
```
Extra half-plane of atoms
      ↓
  ● ● ● ● ● ●
  ● ● ● ● ● ●
  ● ● ● ● ✕ ●  ← Dislocation line (⊥ to page)
  ● ● ● ● ● ●
  ● ● ● ● ● ●
```

**Screw dislocation**:
```
Helical ramp of atoms
      ↓
  ● ● ● ● ● ●
  ● ● ● ● ● ●
  ● ● ● ● ● ●
  ● ● ● ● ● ●
  ● ● ● ● ● ●
```

### Slip Systems

**Slip**: Dislocation motion on specific crystallographic planes and directions

**Slip system** = slip plane + slip direction

**Factors favoring slip**:
1. **Close-packed planes**: Highest planar density
2. **Close-packed directions**: Highest linear density

**Slip systems in common metals**:
| Structure | Slip Planes | Slip Directions | # Systems |
|-----------|-------------|----------------|-----------|
| FCC | {111} | <110> | 12 |
| BCC | {110}, {112}, {123} | <111> | 48 |
| HCP | {0001}, {10-10}, etc. | <11-20> | 3-6 (limited) |

**Why FCC metals are ductile**:
- Many slip systems (12)
- Slip can occur on multiple {111} planes
- Dislocations move easily

**Why HCP metals are less ductile**:
- Fewer slip systems (typically <5 independent systems)
- Limited deformation modes
- More brittle at room temperature

### Critical Resolved Shear Stress

**Schmid''s Law**: Slip begins when resolved shear stress reaches critical value:

$$\tau_c = \sigma \cos \phi \cos \lambda$$

where:
- τ_c = critical resolved shear stress
- σ = applied tensile stress
- φ = angle between slip plane normal and stress axis
- λ = angle between slip direction and stress axis

**Implications**:
- Maximum when ϕ = λ = 45°
- Single crystals show orientation-dependent yield strength
- Polycrystals average over many grain orientations

## Dislocation Behavior

### Dislocation Motion

**Edge dislocation movement**:
```
Before:                 After (moved right):
  ● ● ● ✕ ● ●           ● ● ● ● ✕ ●
  ● ● ● ✕ ● ●           ● ● ● ● ✕ ●
  ● ● ● ● ● ●           ● ● ● ● ● ●
  (dislocation moves by one atomic spacing)
```

**Burger''s vector (b)**: Measure of dislocation strength
- Magnitude = interatomic spacing (for perfect dislocation)
- Direction = slip direction
- Larger b → more lattice distortion → higher energy

### Peierls-Nabarro Stress

**Peierls stress**: Stress needed to move a dislocation through the crystal lattice:

$$\tau_{PN} \propto e^{-\frac{2\pi w}{b}}$$

where w is width of dislocation.

**Wider dislocations** → lower Peierls stress → easier movement
- **FCC**: Wide dislocations → low τ_PN → ductile
- **BCC**: Narrow dislocations → higher τ_PN → stronger, less ductile
- **Ceramics**: Very high τ_PN → dislocations essentially immobile → brittle

### Dislocation Interactions

Dislocations can interact in various ways:

1. **Attraction**: Opposite signed dislocations attract and annihilate
2. **Repulsion**: Same signed dislocations repel
3. **Jogs and kinks**: Steps in dislocation lines
4. **Pinning**: Obstacles impede dislocation motion

**Forest hardening**: Dislocations cut through other dislocations (forest), increasing strength.

## Plastic Deformation in Polycrystals

### Grain Constraint Effects

In polycrystals:
- Each grain has different orientation
- Grains must deform compatibly at boundaries
- Geometric constraints cause additional hardening

**Taylor hardening**: Multiple slip systems required to maintain compatibility:
$$\sigma = \sigma_0 + M \cdot \tau_c$$

where M is Taylor factor (≈3 for FCC metals).

### Work Hardening (Strain Hardening)

**Phenomenon**: Material becomes stronger as it deforms

**Mechanism**: Dislocation density increases with strain:
$$\rho \propto \epsilon^n$$

**Relationship**:
$$\sigma = \sigma_0 + k\sqrt{\rho}$$

where:
- σ = flow stress
- ρ = dislocation density
- k = constant

**Typical dislocation densities**:
- Annealed: ~10⁶ cm⁻²
- Cold worked: ~10¹² cm⁻²

**Result**: Metal can become several times stronger after cold working.

## Deformation Mechanisms by Material Type

### Metals

**Primary mechanism**: Dislocation slip on slip systems
**Secondary**: Deformation twinning (HCP metals at low T, high strain rate)
**Result**: Usually ductile with significant work hardening

### Ceramics

**Primary mechanism**: Very limited dislocation motion (high Peierls stress)
**Alternative**: Crack propagation
**Result**: Brittle fracture, little plastic deformation

**Why ceramic dislocations don''t move easily**:
- Strong directional bonding (covalent/ionic)
- Narrow dislocation cores
- High Peierls stress
- Electroneutrality constraints (ionic crystals)

### Polymers

**Primary mechanisms**:
1. **Elastic**: Uncoiling of polymer chains
2. **Plastic**: Chain sliding, orientation

**Stages of polymer deformation**:
1. **Elastic**: Bond stretching, chain bending (reversible)
2. **Yielding**: Chain sliding begins (irreversible)
3. **Orientation**: Chains align with stress direction
4. **Strain hardening**: Oriented chains resist further deformation

**Result**: Often large elastic strains (up to several hundred percent)

## Strengthening Mechanisms (Impeding Dislocations)

All strengthening mechanisms work by **impeding dislocation motion**:

### 1. Grain Boundary Strengthening

**Hall-Petch relationship**:
$$\sigma_y = \sigma_0 + \frac{k}{\sqrt{d}}$$

Grain boundaries act as barriers to dislocation motion.

### 2. Solid Solution Strengthening

Solute atoms distort the lattice:
$$\Delta\sigma \propto G \cdot \epsilon_s \cdot \sqrt{c}$$

where ε_s is lattice strain from solute, c is concentration.

### 3. Precipitation Hardening

Fine precipitates obstruct dislocations:
- **Cutting mechanism**: Dislocations cut through precipitates
- **Orowan bowing**: Dislocations loop around precipitates

**Critical particle size** (~5-50 nm) for maximum strength.

### 4. Work Hardening

Increased dislocation density:
$$\sigma = \sigma_0 + \alpha G b \sqrt{\rho}$$

### 5. Transformation Hardening

Phase transformations create volume change, dislocations:
- Example: Martensitic transformation in steel

## Real-World Examples

### Cold-Rolled Steel

**Process**: Steel rolled at room temperature (below recrystallization T)
**Result**:
- Dislocation density increases 1000×
- Strength increases 2-3×
- Ductility decreases
- Used for: High-strength sheet metal

### Car Burdening (Case Hardening)

**Process**: Carbon diffused into steel surface
**Result**:
- High carbon at surface → hard, strong
- Low carbon core → tough
- Used for: Gears, bearings, tools

### Tempered Glass

**Process**: Glass surface cooled rapidly, core slowly
**Result**:
- Surface in compression
- Core in tension
- Much stronger than annealed glass
- Used for: Car windows, shower doors, phone screens

## Summary

- **Elastic deformation** involves bond stretching (reversible)
- **Plastic deformation** involves dislocation motion (permanent)
- **Slip systems** (plane + direction) enable plastic flow
- **FCC metals** are ductile (many slip systems)
- **HCP metals and ceramics** are less ductile (fewer slip systems)
- **Work hardening** increases strength via dislocation multiplication
- **All strengthening mechanisms** impede dislocation motion
- **Grain size, solutes, precipitates, and dislocations** all contribute to strength',
    '[
      {
        "question": "What is the primary mechanism of plastic deformation in metals?",
        "options": [
          "Breaking and reforming of all atomic bonds",
          "Motion of dislocations along slip systems",
          "Uniform stretching of all atomic bonds",
          "Melting and recrystallization of the material"
        ],
        "correctAnswer": 1,
        "explanation": "Plastic deformation in metals occurs primarily through dislocation motion along slip systems (specific crystallographic planes and directions). Dislocations are line defects that can move through the crystal lattice with relatively low stress, enabling plastic flow."
      },
      {
        "question": "Why are FCC metals like aluminum and copper generally more ductile than HCP metals?",
        "options": [
          "FCC metals are always softer than HCP metals",
          "FCC metals have more slip systems (12) than HCP metals (typically 3-6)",
          "HCP metals have stronger atomic bonding",
          "FCC metals have lower melting points"
        ],
        "correctAnswer": 1,
        "explanation": "FCC metals have 12 slip systems ({111} planes with <110> directions), providing many ways for dislocations to move. HCP metals typically have only 3-6 slip systems due to their limited number of close-packed planes, making them less ductile."
      },
      {
        "question": "What is work hardening (strain hardening) and what causes it?",
        "options": [
          "Material softens as it deforms due to heating",
          "Material becomes stronger as it deforms due to increased dislocation density",
          "Material becomes harder because it cools during deformation",
          "Material hardening is caused by adding more alloying elements during deformation"
        ],
        "correctAnswer": 1,
        "explanation": "Work hardening (or strain hardening) is the increase in material strength during plastic deformation. It occurs because the dislocation density increases dramatically (from ~10⁶ to ~10¹² cm⁻²), and dislocations interact and impede each other''s motion, requiring higher stress for further deformation."
      }
    ]',
    2,
    NOW()
  );

  -- Continue with remaining lessons...

  -- Lesson 2.3: Strengthening Mechanisms
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440203',
    chapter2_id,
    'Strengthening Mechanisms',
    'strengthening-mechanisms',
    'Learn about various methods to strengthen materials, including solid solution strengthening, precipitation hardening, grain size reduction, and work hardening.',
    '# Strengthening Mechanisms

## Introduction

**Strengthening** increases a material''s resistance to deformation. All strengthening mechanisms work by **impeding dislocation motion** - making it harder for dislocations to move through the crystal lattice.

**Key principle**: Strength ∝ obstacles to dislocation motion

## Why Strengthen Materials?

**Applications requiring high strength**:
- Aircraft structures (high strength-to-weight ratio)
- Automobile components (safety, fuel efficiency)
- Cutting tools (hardness, wear resistance)
- Buildings and bridges (load-bearing capacity)
- Turbine blades (high-temperature strength)

## Types of Strengthening Mechanisms

### 1. Grain Boundary Strengthening (Hall-Petch)

**Mechanism**: Grain boundaries act as barriers to dislocation motion.

**Hall-Petch relationship**:
$$\sigma_y = \sigma_0 + \frac{k}{\sqrt{d}}$$

where:
- σ_y = yield strength
- σ₀ = friction stress (lattice resistance)
- k = strengthening coefficient
- d = average grain diameter

**Explanation**:
- Dislocations pile up at grain boundaries
- Stress concentration at pile-up
- Smaller grains → shorter pile-ups → lower stress concentration
- Requires higher applied stress to transmit slip across boundary

**Practical considerations**:
- **Grain refinement**: Cold working + recrystallization
- **Typical grain sizes**: 1-100 μm
- **Limit**: Nanocrystalline (<100 nm) can reverse trend (grain boundary sliding)

**Example**: Reducing grain size from 50 μm to 5 μm can increase yield strength by 2-3×.

### 2. Solid Solution Strengthening

**Mechanism**: Solute atoms distort the lattice, creating stress fields that interact with dislocations.

**Types**:
1. **Substitutional solid solution**: Solute replaces solvent atom
2. **Interstitial solid solution**: Solute occupies interstitial site

**Strengthening effect**:
$$\Delta\sigma \propto G \cdot \epsilon_s \cdot \sqrt{c}$$

where:
- G = shear modulus
- ε_s = lattice strain (size mismatch)
- c = solute concentration

**Key factors affecting strength increase**:
1. **Size difference**: Larger mismatch → more strengthening
2. **Modulus difference**: Different bonding characteristics
3. **Concentration**: More solute → more strengthening (√c relationship)
4. **Solute type**: Some elements more effective than others

**Hume-Rothery rules** for solid solution formation:
- Atomic size difference < 15%
- Same crystal structure
- Similar electronegativity
- Same valence

**Examples**:
- **Brass (Cu-Zn)**: Zn atoms distort Cu lattice → stronger than pure Cu
- **Sterling silver (Ag-Cu)**: Cu in Ag → harder than pure Ag
- **Steel (Fe-C)**: C in interstitial sites → much stronger than pure Fe

### 3. Precipitation Hardening (Age Hardening)

**Mechanism**: Fine precipitates obstruct dislocation motion.

**Process steps**:
1. **Solution treatment**: Heat to dissolve precipitates (single phase)
2. **Quenching**: Rapid cooling to trap solute (supersaturated solid solution)
3. **Aging**: Moderate heating to form fine, coherent precipitates

**Precipitate-dislocation interactions**:
1. **Cutting mechanism** (small, coherent precipitates):
   - Dislocations cut through precipitates
   - Requires creating new precipitate-matrix interface
   - Strengthening ∝ precipitate size

2. **Orowan bowing** (larger, incoherent precipitates):
   - Dislocations loop around precipitates
   - Critical stress: τ = Gb/L
   - L = inter-precipitate spacing
   - Strengthening ∝ 1/L

**Optimal precipitate characteristics**:
- Size: 5-50 nm
- Spacing: 10-100 nm
- Coherent with matrix
- High number density

**Examples**:
- **Al-Cu (2024 aluminum)**: θ'' precipitates → aircraft structures
- **Ni-base superalloys**: γ'' precipitates → turbine blades
- **Beryllium copper**: CuBe precipitates → springs, connectors

**Overaging**:
- Too long/high aging temperature
- Precipitates coarsen (Ostwald ripening)
- Strength decreases

### 4. Work Hardening (Strain Hardening)

**Mechanism**: Plastic deformation increases dislocation density.

**Dislocation density-strain relationship**:
$$\rho = \rho_0 + k\epsilon$$

**Flow stress relationship**:
$$\sigma = \sigma_0 + \alpha G b \sqrt{\rho}$$

where:
- α = constant (~0.5)
- G = shear modulus
- b = Burger''s vector magnitude
- ρ = dislocation density

**Explanation**:
- Dislocations multiply during deformation (Frank-Read sources)
- Higher density → more interactions → more obstacles
- Dislocations tangle, forming forests

**Processing methods**:
- **Cold rolling**: Sheet metal through rollers at room temperature
- **Cold forging**: Shaping metal at room temperature
- **Wire drawing**: Pulling wire through die
- **Shot peening**: Surface hardening with metal shot

**Limitations**:
- **Ductility decreases** with increased strength
- **Residual stresses** can cause distortion
- **Recrystallization** occurs at high temperature (resets structure)

**Example**: Cold-worked copper can have 2-3× higher strength than annealed copper.

### 5. Transformation Hardening

**Mechanism**: Phase transformation creates strain and defects.

**Martensitic transformation** (steel):
- Rapid cooling (quenching) from austenite phase
- Face-centered cubic → body-centered tetragonal
- Volume expansion creates internal stresses
- Very hard but brittle

**Tempering**:
- Reheating martensite
- Allows some stress relief
- Precipitates form (cementite)
- Balances strength and toughness

**Example**: Quenched and tempered steel used for:
- Tools and dies
- Springs
- Automotive components

### 6. Dispersion Strengthening

**Mechanism**: Stable, insoluble particles impede dislocations.

**Similar to precipitation hardening** but:
- Particles don''t dissolve (no solution treatment)
- Stable at high temperatures
- No coarsening (Ostwald ripening)

**Examples**:
- **Thoriated tungsten**: ThO₂ particles in W → welding electrodes
- **SAP (Sintered Aluminum Powder)**: Al₂O₃ particles in Al
- **Nickel-base alloys**: Oxide dispersion strengthening (ODS)

## Combined Strengthening Effects

**Additive strengthening** (multiple mechanisms):
$$\sigma_{total} = \sigma_0 + \Delta\sigma_{GB} + \Delta\sigma_{SS} + \Delta\sigma_{PPT} + \Delta\sigma_{WH}$$

**Example**: High-strength aluminum alloy (7075-T6)
- Solid solution strengthening (Zn, Mg, Cu)
- Precipitation hardening (η phase)
- Work hardening (cold work after aging)

## Strength-Ductility Trade-off

**General relationship**: Higher strength → lower ductility

**Ashby plot**: Materials tend to follow a trend line

**Exceptions** (break the trade-off):
1. **TRIP steels**: Transformation-induced plasticity
2. **TWIP steels**: Twinning-induced plasticity
3. **Nanostructured materials**: Very small grains + gradient structures

## Design Considerations

### Selecting Strengthening Mechanisms

**Grain size strengthening**:
- Pros: Increases strength AND toughness
- Cons: Limited effect at very small grain sizes
- Best for: General-purpose strengthening

**Solid solution strengthening**:
- Pros: Relatively simple processing
- Cons: Limited solubility, can affect other properties
- Best for: Moderate strength increases

**Precipitation hardening**:
- Pros: Large strength increases, can be tailored
- Cons: Complex processing, temperature sensitive
- Best for: High-performance applications

**Work hardening**:
- Pros: Simple, no alloying needed
- Cons: Reduces ductility, residual stresses
- Best for: Cold-formed products

**Transformation hardening**:
- Pros: Very high strength
- Cons: Can be brittle, requires careful control
- Best for: Cutting tools, bearings

## Real-World Examples

### Aircraft Aluminum (2024-T3)

**Composition**: Al-4.4%Cu-0.6%Mn-1.5%Mg
**Processing**:
1. Solution treat at 500°C
2. Quench to room temperature
3. Age at 190°C for 12 hours
4. Cold work 3% (T3 temper)

**Result**: σ_UTS ≈ 470 MPa (vs pure Al: ~90 MPa)

### High-Strength Low-Alloy (HSLA) Steel

**Composition**: Fe-0.15%C-1.25%Mn + V, Nb
**Processing**: Controlled rolling + precipitation
**Result**: σ_y ≈ 450 MPa (vs plain carbon steel: ~250 MPa)

### Titanium Alloy (Ti-6Al-4V)

**Strengthening mechanisms**:
1. Solid solution (Al, V in Ti)
2. Phase mixture (α + β phases)
3. Work hardening (forging)

**Result**: σ_UTS ≈ 950 MPa, excellent corrosion resistance

## Summary

- **All strengthening mechanisms** impede dislocation motion
- **Grain boundary strengthening**: σ ∝ 1/√d (Hall-Petch)
- **Solid solution strengthening**: σ ∝ √c (solute concentration)
- **Precipitation hardening**: Fine precipitates (5-50 nm) obstruct dislocations
- **Work hardening**: Increased dislocation density
- **Transformation hardening**: Phase change creates defects
- **Multiple mechanisms** can combine for greater strength
- **Strength-ductility trade-off** is common but not absolute',
    '[
      {
        "question": "What is the fundamental principle behind all strengthening mechanisms in metals?",
        "options": [
          "Increasing the melting point of the metal",
          "Adding heavier atoms to increase density",
          "Impeding dislocation motion through the crystal lattice",
          "Increasing the grain size to reduce grain boundary area"
        ],
        "correctAnswer": 2,
        "explanation": "All strengthening mechanisms in metals work by impeding dislocation motion. Whether through grain boundaries, solute atoms, precipitates, or increased dislocation density, these obstacles make it harder for dislocations to move, thereby increasing the stress required for plastic deformation."
      },
      {
        "question": "According to the Hall-Petch relationship, how does decreasing grain size affect a material''s strength?",
        "options": [
          "Strength decreases with decreasing grain size",
          "Strength increases with smaller grain size (∝ 1/√d)",
          "Grain size has no effect on strength",
          "Strength increases with grain size"
        ],
        "correctAnswer": 1,
        "explanation": "The Hall-Petch relationship (σ_y = σ₀ + k/√d) shows that yield strength increases with decreasing grain size. Smaller grains mean more grain boundaries that act as barriers to dislocation motion, requiring higher stress for slip to transmit across boundaries."
      },
      {
        "question": "Why is precipitation hardening effective at strengthening materials?",
        "options": [
          "Precipitates increase the density of the material",
          "Fine precipitate particles obstruct dislocation motion",
          "Precipitates increase the melting point",
          "Precipitates reduce the number of grain boundaries"
        ],
        "correctAnswer": 1,
        "explanation": "Precipitation hardening works by forming fine precipitate particles (typically 5-50 nm) that obstruct dislocation motion. Dislocations must either cut through or loop around these precipitates (Orowan bowing), both of which require higher stress. The optimal precipitate size and spacing create maximum strengthening."
      }
    ]',
    3,
    NOW()
  );

  -- Lesson 2.4: Failure and Fracture
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440204',
    chapter2_id,
    'Failure and Fracture',
    'failure-and-fracture',
    'Understand different types of failure, fracture mechanics, stress concentrations, and factors affecting material toughness.',
    '# Failure and Fracture

## Introduction

**Failure** occurs when a material can no longer perform its intended function. Understanding failure mechanisms is crucial for:

- Preventing catastrophic failures
- Designing safe structures
- Selecting appropriate materials
- Determining safe operating conditions

## Types of Failure

### 1. Elastic Failure

**Excessive elastic deformation**:
- Material still intact but deformed beyond tolerances
- Example: Spring stretched beyond usable range
- Design criterion: Stay below yield strength

### 2. Plastic Failure (Yielding)

**Permanent deformation**:
- Material has yielded and permanently deformed
- May still be functional but with changed geometry
- Example: Bent paper clip, dented car panel

### 3. Fracture Failure

**Complete separation** into two or more pieces:
- Catastrophic failure
- Can be ductile or brittle
- Most serious type of failure

## Ductile vs Brittle Fracture

### Ductile Fracture

**Characteristics**:
- Significant plastic deformation before fracture
- Rough, dimpled fracture surface
- Energy absorption (tough)
- Warning signs (necking, deformation)

**Stages**:
1. **Necking**: Localized deformation
2. **Void formation**: Microvoids nucleate at inclusions
3. **Void growth**: Voids grow and coalesce
4. **Fracture**: Final separation

**Microstructural appearance**:
- **Cup-and-cone** fracture surface
- **Dimples** where voids formed
- Each dimple centered on inclusion/particle

**Example**: Mild steel, aluminum, gold at room temperature

### Brittle Fracture

**Characteristics**:
- Little or no plastic deformation
- Smooth, flat fracture surface
- Little energy absorption (low toughness)
- Little or no warning (sudden failure)

**Types**:
1. **Cleavage fracture**: Along crystallographic planes
2. **Intergranular fracture**: Along grain boundaries

**Microstructural appearance**:
- Flat, shiny surfaces
- River patterns (cleavage steps)
- Faceted appearance (intergranular)

**Example**: Glass, ceramics, some metals at low temperature

## Stress Concentration

**Stress concentration factor (K_t)**:

$$K_t = \frac{\sigma_{max}}{\sigma_{nom}}$$

where:
- σ_max = maximum localized stress
- σ_nom = nominal applied stress

**Sources of stress concentration**:
- Holes, notches, corners
- Surface scratches, defects
- Cracks (worst case)
- Sharp changes in geometry

**Crack tip stress**:

$$\sigma_{yy} = \frac{K_I}{\sqrt{2\pi r}} \cos\frac{\theta}{2}\left(1 + \sin\frac{\theta}{2}\sin\frac{3\theta}{2}\right)$$

Near crack tip, σ → ∞ (theoretically)

**Design implications**:
- Avoid sharp corners (use generous fillets)
- Polish surfaces to remove scratches
- Avoid stress risers in critical areas
- Use crack arrestors where needed

## Fracture Mechanics

### Stress Intensity Factor

**Mode I (opening mode)** stress intensity factor:

$$K_I = Y\sigma\sqrt{\pi a}$$

where:
- Y = geometry factor (dimensionless)
- σ = applied stress
- a = crack length

**Fracture occurs when**: K_I ≥ K_IC

where **K_IC** = fracture toughness (material property)

### Fracture Toughness

**K_IC values** (typical):
| Material | K_IC (MPa√m) | Behavior |
|----------|--------------|----------|
| Glass | 0.7-1.0 | Very brittle |
| Ceramics | 2-5 | Brittle |
| High-strength steel | 50-150 | Tough |
| Aluminum alloys | 20-40 | Moderately tough |
| Titanium alloys | 50-100 | Tough |

**Design implications**:
- Higher K_IC → more crack tolerant
- Lower K_IC → flaw-sensitive (need near-perfect materials)
- Ceramics require flaw-free processing

### Griffith Criterion

**Critical stress for crack propagation**:

$$\sigma_c = \sqrt{\frac{2E\gamma}{\pi a}}$$

where:
- E = Young''s modulus
- γ = surface energy
- a = crack length

**Implications**:
- Larger cracks → lower fracture stress
- Higher modulus → higher stress for fracture
- Brittle materials (low γ) very crack-sensitive

## Factors Affecting Fracture Behavior

### Temperature

**Ductile-to-brittle transition temperature (DBTT)**:
- Above DBTT: ductile fracture
- Below DBTT: brittle fracture

**Materials with DBTT**:
- BCC metals (e.g., steel)
- Some HCP metals

**Temperature effect**:
$$K_{IC}(T) = K_{IC}(0) \cdot e^{-\frac{Q}{RT}}$$

**Example**: Liberty ships (WWII) - Many failed due to DBTT being above operating temperature

### Strain Rate

**Higher strain rate → more brittle behavior**:
- Less time for dislocation motion
- Higher yield stress
- Less plastic deformation

**Impact loading** → more brittle than static loading

### Grain Size

**Smaller grains**:
- Higher strength (Hall-Petch)
- Usually tougher
- Higher DBTT (more brittle at low T)

### Environment

**Stress corrosion cracking (SCC)**:
- Combined tensile stress + corrosive environment
- Cracks grow over time
- Example: Brass in ammonia

**Hydrogen embrittlement**:
- Hydrogen atoms diffuse to crack tip
- Cause brittle fracture
- Problem for high-strength steels

## Fatigue vs Creep

### Fatigue Failure

**Cyclic loading below yield strength** can still cause failure.

**S-N curve** (stress vs cycles):
$$\sigma = \sigma_f'' (N)^b$$

where:
- σ_f'' = fatigue strength coefficient
- N = number of cycles to failure
- b = fatigue exponent (~ -0.1)

**Fatigue limit** (some materials):
- Below this stress, infinite life
- Only ferrous materials (typically)

**Stages of fatigue**:
1. **Crack initiation**: At stress concentration
2. **Crack propagation**: Each cycle advances crack
3. **Final fracture**: Sudden failure when remaining area insufficient

**Prevention**:
- Reduce stress concentrations
- Use compressive residual stresses (shot peening)
- Regular inspection

### Creep Failure

**Time-dependent deformation at constant stress and high temperature**.

**Creep curve stages**:
1. **Primary creep**: Decreasing strain rate
2. **Secondary creep**: Constant (minimum) strain rate
3. **Tertiary creep**: Accelerating strain rate → failure

**Creep rate equation**:
$$\dot{\epsilon} = A\sigma^n e^{-\frac{Q}{RT}}$$

where:
- A = material constant
- n = stress exponent (3-8 for metals)
- Q = activation energy

**Applications**:
- Turbine blades (high T, high stress)
- Pressure vessels (long-term loading)

## Impact Toughness Testing

### Charpy V-Notch Test

**Procedure**:
1. Notched specimen (V-notch)
2. Struck with pendulum
3. Measure energy absorbed

**Results**:
- High energy absorption → tough material
- Low energy absorption → brittle material

**Temperature effects**:
- Test at various temperatures
- Determine DBTT

**Applications**:
- Quality control
- Material selection for low-temperature service

### Izod Test

Similar to Charpy but different specimen geometry and impact method.

## Failure Analysis

**Failure investigation**:
1. **Visual inspection**: Fracture surface appearance
2. **Microscopy**: SEM for detailed examination
3. **Mechanical testing**: Verify material properties
4. **Chemical analysis**: Check composition
5. **Stress analysis**: Determine actual stresses

**Common failure causes**:
- Design flaws (under-designed)
- Manufacturing defects (inclusions, voids)
- Material defects (impurities, wrong material)
- Environmental factors (corrosion, temperature)
- Overloading or misuse

## Real-World Examples

### Titanic (1912)

**Failure**: Brittle fracture of hull steel
**Contributing factors**:
- High sulfur/phosphorus content (brittle steel)
- Cold water temperature (-2°C)
- High impact stress from iceberg
- Rivet failure (wrought iron with slag inclusions)

**Modern lesson**: Use tougher steel for low-temperature service

### Aloha Airlines Flight 243 (1988)

**Failure**: Fatigue cracking of fuselage skin
**Causes**:
- Corrosion in lap joints
- Cyclic pressurization
- Multiple small cracks linked up

**Result**: Improved inspection protocols, crack detection

### Liberty Ships (WWII)

**Failure**: Brittle fracture of hulls
**Causes**:
- Poor weld quality
- Low ambient temperature
- DBTT above operating temperature
- Stress concentrations at hatch corners

**Result**: Development of fracture mechanics as field

## Summary

- **Ductile fracture**: Significant plastic deformation, dimpled surface
- **Brittle fracture**: Little deformation, flat surface, catastrophic
- **Stress concentrations** drastically reduce strength (K_t factor)
- **Fracture toughness (K_IC)** measures resistance to crack propagation
- **Temperature affects** ductility (DBTT in some materials)
- **Fatigue**: Cyclic loading can cause failure below yield strength
- **Creep**: Time-dependent deformation at high temperature
- **Impact testing** measures toughness (Charpy, Izod)
- **Failure analysis** identifies causes to prevent recurrence',
    '[
      {
        "question": "What is the main difference between ductile and brittle fracture?",
        "options": [
          "Ductile fracture occurs only in metals, brittle fracture only in ceramics",
          "Ductile fracture involves significant plastic deformation with a dimpled surface, brittle fracture involves little deformation with a flat surface",
          "Ductile fracture occurs at high temperatures, brittle fracture occurs at low temperatures",
          "There is no difference - both are types of fracture"
        ],
        "correctAnswer": 1,
        "explanation": "Ductile fracture is characterized by significant plastic deformation before failure and produces a rough, dimpled fracture surface (cup-and-cone). Brittle fracture involves little to no plastic deformation and produces a relatively flat, smooth fracture surface that is often catastrophic with little warning."
      },
      {
        "question": "What is the ductile-to-brittle transition temperature (DBTT)?",
        "options": [
          "The temperature at which a metal melts",
          "The temperature below which a normally ductile material becomes brittle",
          "The temperature at which fracture toughness is maximum",
          "The melting point of the second phase"
        ],
        "correctAnswer": 1,
        "explanation": "The ductile-to-brittle transition temperature (DBTT) is the temperature below which a normally ductile material (like BCC metals such as steel) exhibits brittle fracture. Above DBTT, the material behaves ductilely; below DBTT, it becomes brittle and can fracture suddenly with little deformation."
      },
      {
        "question": "Why are stress concentrations (holes, notches, cracks) particularly dangerous for structural integrity?",
        "options": [
          "They increase the weight of the structure",
          "They cause localized stress amplification that can exceed material strength even when nominal stress is low",
          "They only affect the appearance of the material",
          "They reduce the melting point of the material"
        ],
        "correctAnswer": 1,
        "explanation": "Stress concentrations amplify local stresses. The stress concentration factor (K_t) is the ratio of maximum localized stress to nominal applied stress. Sharp corners, holes, and especially cracks can cause local stresses many times higher than the nominal stress, potentially causing failure even when the average stress appears safe."
      }
    ]',
    4,
    NOW()
  );

  -- Lesson 2.5: Fatigue and Creep
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440205',
    chapter2_id,
    'Fatigue and Creep',
    'fatigue-and-creep',
    'Learn about time-dependent failure mechanisms including fatigue (cyclic loading) and creep (high-temperature deformation).',
    '# Fatigue and Creep

## Introduction

Many materials fail under conditions that wouldn''t cause immediate failure:

- **Fatigue**: Failure from cyclic (repeated) loading
- **Creep**: Progressive deformation under constant load at high temperature

Both are critical for design and reliability.

## Fatigue

### What is Fatigue?

**Fatigue**: Progressive, localized structural damage that occurs when a material is subjected to cyclic loading.

**Key characteristics**:
- Can occur below yield strength
- No visible warning (until final fracture)
- Responsible for ~80-90% of mechanical failures

**Historical examples**:
- **De Havilland Comet** (1950s): Crashed due to fatigue around square windows
- **Alexander L. K. versa Bridge** (1967): Fatigue cracks in eyebar
- **Automobile parts**: Axles, springs, connecting rods

### Fatigue Loading

**Types of cyclic loading**:

1. **Completely reversed**:
   $$\sigma_m = 0, \sigma_a = \sigma_{max}$$
   Mean stress σ_m = 0

2. **Repeated tension**:
   $$0 < \sigma_{min} < \sigma_{max}$$

3. **Fluctuating**:
   $$\sigma_{min} < 0 < \sigma_{max}$$

**Parameters**:
- Stress amplitude: $\sigma_a = \frac{\sigma_{max} - \sigma_{min}}{2}$
- Mean stress: $\sigma_m = \frac{\sigma_{max} + \sigma_{min}}{2}$
- Stress range: $\Delta\sigma = \sigma_{max} - \sigma_{min}$
- Stress ratio: $R = \frac{\sigma_{min}}{\sigma_{max}}$

### S-N Curves (Wöhler Curves)

**Stress (S) vs Number of cycles to failure (N)**:

```
log(stress)
    ↑
    │    Low-cycle fatigue
    │    ╱
    │   ╱
    │  ╱  High-cycle fatigue
    │ ╱
    │╱_____________________ log(cycles)
    ↑  ↑
   10² 10⁶-10⁹
```

**Low-cycle fatigue** (N < 10⁴ cycles):
- Higher stress (above yield)
- Significant plastic deformation each cycle

**High-cycle fatigue** (N > 10⁴ cycles):
- Lower stress (elastic)
- Little plastic deformation

**Endurance limit (fatigue limit)**:
- Stress below which infinite life possible
- Only ferrous materials (typically)
- ~0.4-0.5 × tensile strength for steel

**Basquin equation** (high-cycle fatigue):
$$\sigma_a = \sigma_f'' (N)^b$$

where:
- σ_f'' = fatigue strength coefficient
- b = fatigue exponent (~ -0.1 to -0.15)
- N = cycles to failure

### Fatigue Failure Mechanism

**Three stages**:

1. **Crack initiation**:
   - At stress concentrations
   - Surface defects, inclusions
   - Persistent slip bands (PSBs)
   - Typically 10-40% of life

2. **Crack propagation**:
   - Each cycle advances crack
   - Beach marks: Clamshell marks showing crack position
   - Striations: Individual cycle marks (SEM)
   - ~50-90% of life

3. **Final fracture**:
   - Sudden when remaining area insufficient
   - Rapid overload failure
   - <1% of life

### Factors Affecting Fatigue Life

**1. Surface finish**:
- Polished > machined > ground > as-forged
- Rough surfaces create stress concentrations

**2. Stress concentrations**:
- Notches, holes, sharp corners
- Weld defects, porosity
- K_t factor (stress concentration factor)

**3. Surface treatments**:
- **Shot peening**: Compressive surface stress → inhibits crack initiation
- **Case hardening**: Hard surface, tough core
- **Plating**: Can be detrimental (residual tensile stress)

**4. Environment**:
- **Corrosion fatigue**: Corrosive environment accelerates fatigue
- **Temperature**: Higher T → shorter life (some materials)

**5. Frequency**:
- Very low frequency: Time for environmental effects
- Very high frequency: Heating effects

### Fatigue Life Prediction

**Miner''s rule** (cumulative damage):
$$\sum \frac{n_i}{N_i} = 1$$

where:
- n_i = cycles at stress level i
- N_i = cycles to failure at stress level i

**Example**: If 50% of life used at high stress, then 50% remains at lower stress.

**Design approach**:
- Design for infinite life (below endurance limit)
- OR design for finite life with inspection

### Improving Fatigue Resistance

**Design modifications**:
- Avoid sharp corners (use fillets)
- Reduce stress concentrations
- Use generous radii

**Material selection**:
- Higher strength materials (better to a point)
- Clean steel (fewer inclusions)
- Fine grain size

**Processing**:
- Shot peening (compressive surface stress)
- Polishing surfaces
- Heat treatment
- Overloading (proof stress)

**Example**: Aircraft parts often shot peened to create compressive surface stresses that inhibit crack initiation.

## Creep

### What is Creep?

**Creep**: Time-dependent, permanent deformation under constant stress at elevated temperature.

**Key characteristics**:
- Occurs at high temperature (typically >0.4 T_melting)
- Constant stress can cause continuous strain
- Can lead to failure after extended time

**Applications**:
- Turbine blades (jet engines, power plants)
- Pressure vessels (nuclear reactors)
- Boiler tubes
- High-temperature piping

### Creep Curve

```
strain
  ↑
  │            ← Tertiary (accelerating) → failure
  │          ╱
  │        ╱  ← Secondary (steady-state)
  │      ╱
  │    ╱  ← Primary (decelerating)
  │  ╱
  │╱_________________ time
```

**Three stages**:

1. **Primary creep**:
   - Decreasing strain rate
   - Work hardening dominates
   - Relatively short time

2. **Secondary creep**:
   - Constant (minimum) strain rate
   - Balance of work hardening and recovery
   - Most of creep life
   - Design based on this stage

3. **Tertiary creep**:
   - Accelerating strain rate
   - Necking, void formation, cracking
   - Leads to failure

### Creep Mechanisms

**1. Dislocation creep**:
- Dislocation climb over obstacles
- Stress exponent n ≈ 3-8

**2. Diffusion creep**:
- Atom flow by diffusion
- **Nabarro-Herring creep**: Lattice diffusion
- **Coble creep**: Grain boundary diffusion
- Stress exponent n ≈ 1

**3. Grain boundary sliding**:
- Grains slide past each other
- Important at high T, low stress
- Cavities form at boundaries

### Creep Equation

**General creep rate equation**:
$$\dot{\epsilon} = A \sigma^n e^{-\frac{Q}{RT}}$$

where:
- $\dot{\epsilon}$ = strain rate (s⁻¹)
- A = material constant
- σ = applied stress (MPa)
- n = stress exponent (3-8 for dislocation creep)
- Q = activation energy (J/mol)
- R = gas constant (8.314 J/mol·K)
- T = absolute temperature (K)

**Implications**:
- Higher stress → much higher creep rate (σⁿ)
- Higher temperature → exponentially higher creep rate

### Larson-Miller Parameter

**Time-temperature equivalence**:

$$P = T(C + \log t)$$

where:
- P = Larson-Miller parameter (constant for given stress/strain)
- T = temperature (K or °R)
- t = time (hours)
- C ≈ 20 for many steels

**Use**: Predict long-term creep from short-term tests
- If we know life at 600°C for 1000 hours
- We can predict life at 550°C (different time at same P)

### Creep Resistance

**Factors improving creep resistance**:

1. **High melting point**:
   - Higher T_m → higher service temperature possible
   - Refractory metals (W, Mo, Ta) for very high T

2. **Solid solution strengthening**:
   - Solute atoms impede dislocation climb
   - Example: Ni-base superalloys with Co, Cr, Mo

3. **Precipitation strengthening****:
   - Precipitates stable at high T
   - Gamma prime (γ'') in Ni-base superalloys
   - Very effective!

4. **Grain size**:
   - Larger grains → less grain boundary sliding
   - **Directionally solidified** (columnar grains)
   - **Single crystal** blades (no grain boundaries!)

5. **Dispersion strengthening**:
   - Oxide dispersion strengthening (ODS)
   - Stable particles at high T

### Superalloys

**Ni-base superalloys**: Best creep resistance
- Used for turbine blades
- Can operate at ~85% of melting point
- Complex chemistry (Ni, Co, Cr, Al, Ti, Ta, etc.)
- Expensive but essential for jet engines

**Example**: IN738 (Ni-base superalloy)
- Used for turbine blades
- Creep strength: ~100 MPa at 850°C for 1000 hours
- Cost: ~$100-200/kg (vs plain steel: ~$1/kg)

## Real-World Examples

### Turbine Blades (Jet Engines)

**Conditions**:
- Temperature: 800-1100°C
- Stress: 100-300 MPa (centrifugal + thermal)
- Time: Thousands of hours

**Design**:
- Single crystal (no grain boundaries)
- Internal cooling passages
- Thermal barrier coating (Y₂O₃-stabilized ZrO₂)
- Ni-base superalloy (γ'' precipitates)

**Result**: Can operate ~20,000 hours before replacement

### Pressure Vessels (Nuclear)

**Conditions**:
- Temperature: 300-350°C
- Pressure: 15 MPa
- Time: 40+ years (design life)

**Concerns**:
- Creep deformation
- Fatigue from thermal cycling
- Radiation damage

**Approach**:
- Conservative design
- Regular inspection
- Monitor creep strain over time

### Engine Components

**Automotive pistons**:
- High temperature, cyclic loading
- Aluminum alloy (lightweight, good thermal conductivity)
- Creep not major issue (lower T than turbine)

**Automotive connecting rods**:
- High cyclic loading
- Fatigue is primary concern
- Fatigue design life: ~10⁸ cycles (100k miles at 2000 RPM)

## Summary

- **Fatigue**: Failure from cyclic loading below yield strength
- **S-N curves** relate stress amplitude to cycles to failure
- **Endurance limit**: Stress below which ferrous materials have infinite life
- **Three fatigue stages**: Initiation, propagation, final fracture
- **Fatigue factors**: Surface finish, stress concentrations, environment
- **Creep**: Time-dependent deformation at high temperature under constant load
- **Three creep stages**: Primary (decelerating), secondary (constant), tertiary (accelerating)
- **Creep rate**: $\dot{\epsilon} = A\sigma^n e^{-Q/RT}$ (strong T and σ dependence)
- **Larson-Miller parameter**: Predicts long-term creep from short-term tests
- **Creep resistance**: High T_m, solid solution, precipitation, large grains, single crystals',
    '[
      {
        "question": "Why is fatigue failure particularly dangerous compared to other types of failure?",
        "options": [
          "Fatigue only occurs at very high temperatures",
          "Fatigue occurs below the yield strength with little or no visible warning before sudden catastrophic failure",
          "Fatigue failure only affects ceramic materials",
          "Fatigue always produces visible deformation before failure"
        ],
        "correctAnswer": 1,
        "explanation": "Fatigue is particularly dangerous because it can occur at stresses well below the yield strength (often 20-50% of tensile strength) and typically provides little to no visible warning before sudden catastrophic failure. The crack grows incrementally with each loading cycle until the remaining cross-section becomes insufficient to support the load."
      },
      {
        "question": "What does the endurance limit (fatigue limit) represent on an S-N curve?",
        "options": [
          "The maximum stress a material can withstand for one cycle",
          "The stress level below which a ferrous material can theoretically endure infinite cycles without failure",
          "The stress at which creep begins",
          "The minimum number of cycles required for fatigue crack initiation"
        ],
        "correctAnswer": 1,
        "explanation": "The endurance limit (or fatigue limit) is the stress amplitude below which a material (typically ferrous metals) can theoretically endure an infinite number of loading cycles without failing. For steel, this is typically around 40-50% of the tensile strength. Non-ferrous metals (aluminum, copper) generally do not have a true endurance limit."
      },
      {
        "question": "How does temperature affect the creep rate of materials according to the creep equation?",
        "options": [
          "Higher temperatures decrease the creep rate exponentially",
          "Temperature has no effect on creep rate",
          "Higher temperatures increase the creep rate exponentially (e^-Q/RT term)",
          "Creep rate is directly proportional to temperature"
        ],
        "correctAnswer": 2,
        "explanation": "The creep rate equation ($\\dot{\\epsilon} = A\\sigma^n e^{-Q/RT}$) shows that creep rate depends exponentially on temperature through the Arrhenius term (e^(-Q/RT)). As temperature increases, the exponential term increases dramatically, leading to much higher creep rates. This is why creep becomes a significant design consideration only at elevated temperatures (typically >0.4 T_melting)."
      }
    ]',
    5,
    NOW()
  );

END $$;

-- Continue Materials Science course with remaining lessons

DO $$
DECLARE
  chapter3_id UUID;
  chapter4_id UUID;
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter3_id FROM chapters WHERE slug = 'metals-and-alloys';
  SELECT id INTO chapter4_id FROM chapters WHERE slug = 'polymers-and-ceramics';
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';

  -- Lesson 3.3: Ferrous Alloys (Steel and Cast Iron)
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440303',
    chapter3_id,
    'Ferrous Alloys (Steel and Cast Iron)',
    'ferrous-alloys-steel-and-cast-iron',
    'Explore iron-carbon alloys including steel and cast iron, their classifications, properties, and applications.',
    '# Ferrous Alloys: Steel and Cast Iron

## Introduction

**Ferrous alloys** (iron-based alloys) are the **most widely used metallic materials**, accounting for ~80% of all metal production.

**Advantages**:
- Abundant raw materials (iron ore)
- Relatively low cost
- Wide range of properties (through composition and heat treatment)
- Recyclable

**Categories**:
- **Steel**: < 2% carbon
- **Cast iron**: 2-4% carbon

## Iron-Carbon Phase Diagram Review

**Key phases**:
1. **Austenite (γ)**: FCC iron with carbon in interstitial sites
2. **Ferrite (α)**: BCC iron with limited carbon solubility
3. **Cementite (Fe₃C)**: Iron carbide (6.7% C)
4. **δ-ferrite**: BCC iron at high temperature

**Key transformations**:
- **Eutectoid** (0.76% C, 727°C): γ → α + Fe₃C (pearlite)
- **Eutectic** (4.3% C, 1147°C): L → γ + Fe₃C (ledeburite)

## Classification of Steel

### By Carbon Content

**Low carbon steel** (< 0.25% C):
- Properties: Soft, ductile, easily formed
- Applications: Car bodies, pipes, structural shapes
- Examples: AISI 1010, 1020

**Medium carbon steel** (0.25-0.60% C):
- Properties: Stronger, less ductile
- Applications: Machinery, gears, rails
- Examples: AISI 1040, 1050

**High carbon steel** (0.60-1.4% C):
- Properties: Very hard, strong, brittle
- Applications: Tools, springs, knives
- Examples: AISI 1080, 1095

### By Alloying Elements

**Plain carbon steels**: Mostly Fe + C
- Inexpensive
- Limited hardenability

**Alloy steels**: Added elements (Cr, Ni, Mo, W, V)
- Improved hardenability
- Better strength-toughness combination
- Corrosion resistance (stainless steels)

**Stainless steels**: > 11% Cr
- Forms protective Cr₂O₃ layer
- Excellent corrosion resistance
- Categories: Austenitic (304, 316), Martensitic (440C), Ferritic (430)

### By Microstructure

**Eutectoid steel** (0.76% C):
- Forms pearlite (α + Fe₃C lamellae)
- Good strength-ductility balance

**Hypoeutectoid steel** (< 0.76% C):
- Proeutectoid ferrite + pearlite
- Softer than eutectoid

**Hypereutectoid steel** (> 0.76% C):
- Proeutectoid cementite + pearlite
- Harder, more brittle

## Steel Heat Treatment

### Annealing

**Process**: Heat to austenite region, hold, cool slowly (furnace cool)

**Result**: Coarse pearlite, soft, ductile

**Applications**: 
- Relieve internal stresses
- Improve machinability
- Soften after cold working

### Normalizing

**Process**: Heat to austenite region, air cool

**Result**: Fine pearlite, stronger than annealed

**Applications**:
- Refine grain structure
- Uniform properties
- Prepare for hardening

### Quenching and Tempering

**Quenching**: Heat to austenite, rapidly cool (water/oil)
- Forms martensite (BCT structure)
- Very hard but brittle

**Tempering**: Reheat martensite to moderate temperature (200-600°C)
- Allows carbon to precipitate
- Reduces brittleness
- Balances strength and toughness

**Applications**:
- Tools, dies, springs
- Gears, shafts, bolts
- Cutting tools

## Cast Iron

### Characteristics

**High carbon content** (2-4%):
- Carbon precipitates as graphite flakes or nodules
- Excellent castability (low melting point, good fluidity)
- Good machinability
- Low cost
- Limited ductility (except ductile iron)

### Types of Cast Iron

**Gray cast iron**:
- Graphite flakes
- Good vibration damping
- Easy to machine
- Applications: Engine blocks, machine bases

**White cast iron**:
- Cementite (no graphite)
- Very hard, brittle
- Forms when cooled rapidly
- Applications: Wear surfaces, mill liners

**Ductile (nodular) cast iron**:
- Graphite nodules (spherical)
- Reasonable ductility
- Applications: Pipe, automotive components

**Malleable cast iron**:
- Heat-treated white iron
- Graphite clusters
- Applications: Hardware, fittings

## Stainless Steels

**Definition**: > 11% Cr for corrosion resistance

**Types**:

**Austenitic stainless (300 series)**:
- FCC structure (non-magnetic)
- Excellent corrosion resistance
- Good formability
- Examples: 304 (18% Cr, 8% Ni), 316 (added Mo)

**Ferritic stainless (400 series)**:
- BCC structure (magnetic)
- Moderate corrosion resistance
- Lower cost than austenitic
- Example: 430 (17% Cr)

**Martensitic stainless**:
- Heat-treatable
- High strength
- Lower corrosion resistance
- Example: 440C (high carbon, cutting tools)

## Tool Steels

**High-carbon, alloyed steels** for tools and dies

**Types**:
- **W-type**: Water-hardening, plain carbon
- **O-type**: Oil-hardening, low alloy
- **D-type**: High Cr, air hardening
- **T-type**: Tungsten, high-speed steel

**Properties required**:
- Hot hardness (resist softening at high T)
- Wear resistance
- Toughness
- Dimensional stability

## Real-World Applications

### Automobiles

**Body**: Low carbon steel (formed, spot welded)
**Chassis**: Medium carbon steel (stronger)
**Gears**: Alloy steel, case hardened
**Engine blocks**: Gray cast iron (vibration damping)
**Exhaust**: Stainless steel (corrosion resistance)

### Construction

**Beams**: Structural steel (A36, ~0.25% C)
**Rebar**: Medium carbon steel (deformed for bonding)
**Bolts**: Medium carbon steel, quenched and tempered

### Cutlery

**Knives**: High carbon stainless (440C, 1% C, 17% Cr)
- High hardness
- Good corrosion resistance
- Sharp edge retention

## Summary

- **Steel**: < 2% C, classified by carbon content and alloying
- **Low C steel**: Ductile, easily formed
- **Medium C steel**: Stronger, used for machinery
- **High C steel**: Hard, used for tools
- **Heat treatment**: Controls microstructure (pearlite, martensite)
- **Cast iron**: 2-4% C, excellent castability
- **Stainless steel**: > 11% Cr for corrosion resistance
- **Tool steel**: High C + alloying for cutting tools
- **Applications**: Everything from paper clips to skyscrapers',
    '[
      {
        "question": "What is the primary difference between steel and cast iron?",
        "options": [
          "Steel contains iron, cast iron does not",
          "Steel has less than 2% carbon, cast iron has 2-4% carbon",
          "Steel is magnetic, cast iron is not",
          "Cast iron is an alloy, steel is a pure element"
        ],
        "correctAnswer": 1,
        "explanation": "The primary distinction is carbon content. Steel contains less than 2% carbon (typically 0.02-1.4%), while cast iron contains 2-4% carbon. The higher carbon content in cast iron causes graphite to form during solidification, giving cast iron its characteristic properties (excellent castability, vibration damping, but lower ductility)."
      },
      {
        "question": "What happens during the quenching and tempering process for steel?",
        "options": [
          "Quenching slowly cools steel to form soft pearlite, tempering hardens it",
          "Quenching rapidly cools austenite to form hard martensite, tempering reheats to reduce brittleness while maintaining hardness",
          "Quenching and tempering both heat the steel to the same temperature",
          "Quenching removes carbon, tempering adds it back"
        ],
        "correctAnswer": 1,
        "explanation": "Quenching rapidly cools austenitized steel (water or oil) to form martensite, a very hard but brittle phase. Tempering then reheats the martensite to 200-600°C, allowing some carbon to precipitate as fine carbides. This reduces brittleness while maintaining most of the hardness, creating an optimal balance of strength and toughness."
      },
      {
        "question": "Why is chromium added to stainless steels?",
        "options": [
          "Chromium increases the melting point of steel",
          "Chromium forms a protective oxide layer (Cr2O3) that provides corrosion resistance",
          "Chromium makes steel magnetic",
          "Chromium decreases the density of steel"
        ],
        "correctAnswer": 1,
        "explanation": "Chromium (added in amounts > 11%) forms a thin, transparent, adherent oxide layer (Cr₂O₃) on the steel surface. This passive layer protects the underlying iron from oxidizing (rusting). If scratched, the layer reforms spontaneously in the presence of oxygen, providing continuous corrosion resistance."
      }
    ]',
    3,
    NOW()
  );

  -- Add placeholder for remaining lessons to complete course structure
  -- Lesson 3.4: Non-Ferrous Metals
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440304',
    chapter3_id,
    'Non-Ferrous Metals',
    'non-ferrous-metals',
    'Study important non-ferrous metals including aluminum, copper, titanium, and their alloys.',
    '# Non-Ferrous Metals

## Introduction

**Non-ferrous metals** contain no significant amount of iron. While less common than steel, they have specialized properties that make them essential for many applications.

**Key advantages**:
- Lower density (lighter weight)
- Better corrosion resistance
- Higher electrical and thermal conductivity
- Special properties (biocompatibility, nuclear transparency)

## Aluminum and Alloys

### Properties

**Density**: 2.7 g/cm³ (vs steel: 7.9 g/cm³) - 1/3 the weight!

**Other properties**:
- Good corrosion resistance (oxide layer)
- Excellent electrical conductivity (60% of copper)
- High reflectivity
- Non-toxic
- Easily recycled

**Limitations**:
- Low melting point (660°C)
- Lower strength than steel (unless alloyed)
- Creep at elevated temperature

### Crystal Structure

**FCC structure**:
- Very ductile
- Excellent formability
- Good fatigue resistance

### Alloy Designations

**Wrought alloys** (1xxx, 2xxx, etc.):
- **1xxx**: >99% Al (foil, electrical conductors)
- **2xxx**: Al-Cu (high strength, aircraft: 2024)
- **3xxx**: Al-Mn (moderate strength, beverage cans: 3003)
- **4xxx**: Al-Si (casting, welding filler)
- **5xxx**: Al-Mg (marine applications: 5052)
- **6xxx**: Al-Mg-Si (extrusions: 6061)
- **7xxx**: Al-Zn-Mg (highest strength, aircraft: 7075)

**Cast alloys** (3xx.x, 356, etc.):
- Good castability
- Used for engine blocks, wheels

### Heat Treatment

**Age-hardenable alloys** (2xxx, 6xxx, 7xxx):
1. Solution treat at ~500°C
2. Quench to room temperature
3. Age at 150-200°C

Result: Fine precipitates → strong

### Applications

**Transportation**:
- Aircraft (7075, 2024): High strength-to-weight
- Automobile (6xxx): Body panels, wheels
- Rail cars, boats

**Packaging**:
- Beverage cans (3003): Lightweight, recyclable
- Aluminum foil (1xxx): Flexible

**Construction**:
- Window frames (6061): Extruded shapes
- Siding, roofing

**Electrical**:
- Power lines (1xxx): Lightweight conductors
- Bus bars

## Copper and Alloys

### Properties

**Excellent electrical conductivity**: Best of all metals (except silver)
**High thermal conductivity**: Used for heat exchangers
**Good corrosion resistance**: Forms protective patina
**Antimicrobial**: Naturally kills bacteria
**Ductile**: Easily drawn into wires

### Crystal Structure

**FCC structure**:
- Very ductile
- Excellent cold workability

### Alloy Types

**Brasses** (Cu-Zn):
- **Yellow brass** (70% Cu, 30% Zn): Good corrosion resistance, decorative
- **Red brass** (85% Cu, 15% Zn): Better corrosion resistance
- Applications: Plumbing fittings, valves, musical instruments

**Bronzes** (Cu-Sn):
- Higher strength than brass
- Good corrosion resistance
- Low friction
- Applications: Bearings, bushings, marine hardware

**Beryllium copper** (Cu-2% Be):
- Very high strength (precipitation hardenable)
- Non-sparking
- Good conductivity
- Applications: Tools for explosive environments, springs

**Cupronickel** (Cu-Ni):
- Excellent corrosion resistance (seawater)
- Applications: Ship hulls, condensers, coins

### Applications

**Electrical**:
- Wiring (high conductivity)
- Motors, generators
- Transformers

**Plumbing**:
- Pipes, fittings (corrosion resistance)

**Heat exchange**:
- Radiators, air conditioners (high thermal conductivity)

## Titanium and Alloys

### Properties

**Density**: 4.5 g/cm³ (between Al and Fe)
**Strength-to-weight**: Excellent (better than steel on equal weight basis)
**Corrosion resistance**: Outstanding (oxide layer)
**Biocompatible**: Non-toxic, used in implants
**High melting point**: 1668°C

### Crystal Structure

**Allotropic**:
- **α-Ti** (HCP): Below 882°C
- **β-Ti** (BCC): Above 882°C

### Alloy Types

**α alloys** (Ti-6Al-4V ELI):
- Stabilized by Al, O, N
- Good weldability
- Creep resistance

**α-β alloys** (Ti-6Al-4V):
- Most common titanium alloy
- Balanced properties
- Applications: Aircraft, biomedical implants

**β alloys** (Ti-13V-11Cr-3Al):
- Stabilized by V, Mo, Fe
- High strength
- Forgeable

### Applications

**Aerospace**:
- Jet engine components (high T strength)
- Airframe (high strength-to-weight)
- Fasteners

**Biomedical**:
- Hip implants (biocompatible)
- Dental implants
- Pacemaker cases

**Chemical processing**:
- Heat exchangers (corrosion resistance)
- Valve bodies

## Magnesium and Alloys

### Properties

**Density**: 1.74 g/cm³ - lightest structural metal!
**Low melting point**: 650°C
**Moderate strength**
**Good damping capacity**

### Limitations

**Poor corrosion resistance** (reacts with water)
**Flammable** (especially powder or chips)
**Lower stiffness** than Al

### Applications

**Transportation** (lightweighting):
- Gearbox housings
- Wheels (racing)
- Aerospace components

**Electronics**:
- Camera bodies (lightweight)
- Laptop chassis

## Nickel and Alloys

### Properties

**High temperature strength**: Maintains strength at elevated T
**Corrosion resistance**: Excellent, especially to oxidation
**Toughness**: Good at cryogenic temperatures

### Alloy Types

**Superalloys** (Ni-base with Cr, Co, Al, Ti):
- **Creep resistance**: Turbine blades
- **Oxidation resistance**: High T applications
- **γ'' precipitates**: Strength
- Examples: IN718, IN738

**Stainless alternatives**:
- **Monel** (Ni-Cu): Chemical resistance
- **Hastelloy** (Ni-Mo): Acid resistance
- **Inconel** (Ni-Cr): Oxidation resistance

### Applications

**Jet engines**: Turbine blades (superalloys)
**Nuclear**: Reactor components (corrosion resistance)
**Chemical processing**: Heat exchangers, valves

## Refractory Metals

**Definition**: Very high melting point (> 2000°C)

**Examples**: W, Mo, Ta, Nb

**Tungsten**:
- Highest melting point: 3422°C
- Applications: Filaments, welding electrodes

**Molybdenum**:
- High temperature strength
- Applications: Heating elements, furnace parts

## Precious Metals

**Gold, silver, platinum group**:
- Excellent corrosion resistance (noble metals)
- Good electrical conductivity
- Expensive
- Applications: Jewelry, electronics, catalysis

## Comparison Table

| Metal | Density (g/cm³) | Melting Point (°C) | Key Properties | Main Applications |
|-------|------------------|-------------------|----------------|------------------|
| Al | 2.7 | 660 | Lightweight, formable | Aircraft, cans, foil |
| Cu | 8.9 | 1085 | Conductivity, ductility | Wire, pipes, motors |
| Ti | 4.5 | 1668 | Strong, light, corrosion | Aerospace, implants |
| Mg | 1.7 | 650 | Lightest structural metal | Lightweight parts |
| Ni | 8.9 | 1455 | High T strength, corrosion | Superalloys, reactors |
| W | 19.3 | 3422 | Highest T_m | Filaments, electrodes |

## Summary

- **Aluminum**: Lightweight, corrosion-resistant, excellent strength-to-weight when alloyed
- **Copper**: Best conductivity (after Ag), excellent for electrical applications
- **Titanium**: Outstanding strength-to-weight, biocompatible, expensive
- **Magnesium**: Lightest metal, limited by corrosion
- **Nickel**: High-temperature strength, corrosion resistance
- **Refractory metals**: Extremely high melting points
- **Precious metals**: Excellent corrosion resistance, high cost',
    '[
      {
        "question": "Why is aluminum extensively used in aircraft construction?",
        "options": [
          "Aluminum has the highest strength of all metals",
          "Aluminum has excellent strength-to-weight ratio (lightweight + alloyed strength) and good corrosion resistance",
          "Aluminum is the cheapest metal available",
          "Aluminum has a higher melting point than steel"
        ],
        "correctAnswer": 1,
        "explanation": "Aluminum''s density is only 2.7 g/cm³ (1/3 that of steel), and when alloyed (e.g., 7075-T6), it achieves high strengths (up to 570 MPa yield strength). This excellent strength-to-weight ratio reduces aircraft weight while maintaining structural integrity. Aluminum also has good corrosion resistance and fatigue resistance."
      },
      {
        "question": "What makes titanium ideal for biomedical implants like hip replacements?",
        "options": [
          "Titanium is the strongest metal available",
          "Titanium has the lowest density of all metals",
          "Titanium is biocompatible, has good strength-to-weight ratio, and forms a stable oxide layer for corrosion resistance",
          "Titanium is magnetic which helps with MRI imaging"
        ],
        "correctAnswer": 2,
        "explanation": "Titanium is ideal for implants because it is biocompatible (non-toxic, doesn''t trigger immune rejection), has good strength-to-weight (similar strength to bone), excellent corrosion resistance (forms stable TiO₂ layer), and elastic modulus closer to bone than other metals (reduces stress shielding)."
      },
      {
        "question": "How does copper''s electrical conductivity compare to other metals?",
        "options": [
          "Copper has the highest electrical conductivity of all metals",
          "Copper has the second highest conductivity after silver, but is much cheaper and more widely used",
          "Copper has lower conductivity than aluminum but is used because it is magnetic",
          "Copper has the same conductivity as gold"
        ],
        "correctAnswer": 1,
        "explanation": "Silver has the highest electrical conductivity of all metals, followed by copper at ~97% of silver''s conductivity. However, silver is much more expensive, so copper is the standard for electrical wiring. Copper is used because it offers excellent conductivity at reasonable cost with good mechanical properties."
      }
    ]',
    4,
    NOW()
  );

END $$;
  -- Lesson 3.5: Heat Treatment of Metals
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440305',
    chapter3_id,
    'Heat Treatment of Metals',
    'heat-treatment-of-metals',
    'Learn about heat treatment processes including annealing, normalizing, quenching, tempering, and case hardening.',
    '# Heat Treatment of Metals

## Introduction

**Heat treatment** involves heating and cooling metals to alter their properties without changing shape. It''s one of the most important processes for controlling material properties.

**Why heat treat?**
- Increase strength and hardness
- Improve ductility and toughness
- Relieve internal stresses
- Enhance machinability
- Develop specific microstructures

## Time-Temperature-Transformation (TTT) Diagrams

TTT diagrams show phase transformations as functions of:
- **Time** (log scale)
- **Temperature**
- **Transformation**

**Key features**:
- **Austenite region**: High temperature (FCC for steel)
- **Transformation start curve**: Beginning of transformation
- **Transformation finish curve**: Completion of transformation
- **Martensite start (Ms)**: Temperature where martensite forms on rapid cooling
- **Martensite finish (Mf)**: Temperature where transformation completes

## Heat Treatment Processes for Steel

### 1. Annealing

**Process**:
1. Heat to austenite region (750-900°C)
2. Hold to homogenize
3. Cool very slowly (furnace cool)

**Result**: Coarse pearlite, soft, ductile

**Microstructure**: Coarse lamellar pearlite (α + Fe₃C)

**Applications**:
- Soften after cold working
- Improve machinability
- Relieve internal stresses
- Refine grain structure (full anneal)

**Types of annealing**:
- **Full anneal**: Slow cool from austenite
- **Process anneal**: Heat below critical temperature, cool (recovery/recrystallization)
- **Spheroidize**: Form spherical Fe₃C (high carbon steel)

### 2. Normalizing

**Process**:
1. Heat to austenite region (800-920°C)
2. Hold briefly
3. Air cool

**Result**: Fine pearlite, stronger than annealed

**Applications**:
- Refine grain structure
- Homogenize castings
- Prepare for hardening

**Why stronger than annealed?**
- Faster cooling → finer pearlite
- Finer interlamellar spacing → stronger

### 3. Quenching (Hardening)

**Process**:
1. Heat to austenite region
2. Hold to dissolve carbon
3. Cool rapidly (water, oil, polymer, air)

**Quench media**:
- **Water**: Most severe (fastest cooling)
- **Oil**: Moderate severity (common for steel)
- **Polymer**: Adjustable quench rate
- **Air**: Slowest (for high-hardenability steels)

**Result**: Martensite forms

**Martensite**:
- Body-centered tetragonal (BCT) structure
- Very hard (up to 65 HRC)
- Brittle
- Supersaturated with carbon

**Hardness vs carbon content**:
| %C | Approximate hardness (HRC) |
|-----|---------------------------|
| 0.2 | ~40 |
| 0.4 | ~55 |
| 0.6 | ~62 |
| 0.8 | ~65 |
| >1.0 | ~66 |

**Hardenability**: Ability to form martensite throughout
- Higher alloy content → higher hardenability
- Thicker sections can be fully hardened

**Jominy test**: Measures hardenability
- Quench one end of round bar
- Measure hardness along length
- Hardenability curve

### 4. Tempering

**Process**:
1. Quench to form martensite
2. Reheat to 150-650°C
3. Hold (1-4 hours)
4. Cool (usually air)

**Result**: Tempered martensite

**What happens during tempering**:
1. **Stage 1 (100-250°C)**: Carbon precipitates as ε-carbide
2. **Stage 2 (200-300°C)**: Retained austenite transforms
3. **Stage 3 (250-500°C)**: Cementite (Fe₃C) forms
4. **Stage 4 (>500°C)**: Spheroidization and recovery

**Tempering temperatures**:
- **Low temper** (150-250°C): Relieves stresses, slight softening
- **Medium temper** (350-450°C): Balances strength and toughness
- **High temper** (500-650°C): Maximizes toughness, more softening

**Applications**:
- Tools: Low temper (retain hardness)
- Springs: Medium temper
- Gears: High temper (toughness critical)

**Temper embrittlement** (250-350°C):
- Reduced toughness in this range
- Problem for some steels
- Avoid by tempering above or below this range

### 5. Case Hardening

**Surface hardening** - hard surface, tough core

**Carburizing**:
- **Process**: Carbon diffusion into surface at 900-950°C
- **Quench**: Forms hard surface (high C), tough core (low C)
- **Depth**: 0.5-2 mm (depends on time)
- **Applications**: Gears, bearings, shafts

**Nitriding**:
- **Process**: Nitrogen diffusion at 500-550°C (lower T!)
- **Result**: Hard nitride layer
- **Advantage**: No distortion (low T)
- **Applications**: Precision parts, crankshafts

**Induction hardening**:
- **Process**: Local heating by induction, then quench
- **Advantage**: Localized hardening, fast
- **Applications**: Axle surfaces, gear teeth

**Flame hardening**:
- **Process**: Local heating by oxyacetylene flame, then quench
- **Applications**: Large parts (lathe beds, large gears)

## Heat Treatment of Non-Ferrous Metals

### Aluminum Alloys

**Solution heat treatment**:
- Heat to dissolve precipitates (500°C)
- Hold to homogenize
- Quench to trap solute

**Artificial aging**:
- Reheat to 150-200°C
- Hold for controlled precipitation
- Fine precipitates → strong

**Natural aging**:
- Some alloys age at room temperature
- Example: 2024 aluminum

**Annealing**:
- Heat to 400-450°C
- Cool slowly
- Softens for forming

### Titanium Alloys

**Solution treating and aging**:
- Similar to aluminum
- α-β alloys can be heat treated
- Controls α and β phase fractions

### Copper Alloys

**Annealing**:
- Heat to 400-700°C (depending on alloy)
- Cool slowly
- Softens after cold work

**Precipitation hardening** (beryllium copper):
- Solution treat at 800°C
- Quench
- Age at 300-350°C
- Very high strength

## Continuous Cooling Transformation (CCT) Diagrams

Similar to TTT but for continuous cooling (more realistic).

**Key features**:
- Shifted to right and down compared to TTT
- No time for nucleation during continuous cooling
- Critical cooling rate: Minimum rate to form all martensite

**Critical cooling rate** depends on:
- Carbon content
- Alloy content
- Section size

## Heat Treatment Defects

**Quench cracking**:
- Thermal stresses from rapid cooling
- High carbon steels more susceptible
- Minimize by: Using warmer quench, stepped quenching

**Distortion/warping**:
- Non-uniform cooling
- Thermal stresses
- Minimize by: Proper fixturing, uniform quench

**Decarburization**:
- Carbon loss at surface
- Reduces surface hardness
- Minimize by: Protective atmosphere, controlled furnace

**Overheating/burning**:
- Grain growth (overheating)
- Oxidation, irreversible damage (burning)

## Real-World Examples

### Knife Making

**Process**:
1. Forgive blade shape
2. Anneal (soften for grinding)
3. Grind to final shape
4. Harden (heat to ~800°C, quench in oil)
5. Temper (200°C for 2 hours)
6. Polish and sharpen

**Result**: Hard edge (~62 HRC), tough back

### Automotive Gears

**Process**:
1. Machine gear (soft, annealed steel)
2. Carburize (900°C for several hours)
3. Quench (hard case, tough core)
4. Temper (low temper: ~200°C)
5. Grind to final dimensions

**Result**: Wear-resistant surface, fatigue-resistant core

### Rifle Barrel

**Process**:
1. Drill bore (soft steel)
2. Rifling (button rifling)
3. Chrome plate (corrosion resistance)
4. No heat treatment (hardness not critical, maintain accuracy)

## Summary

- **Annealing**: Slow cool → soft, ductile, relieve stresses
- **Normalizing**: Air cool → fine pearlite, stronger than annealed
- **Quenching**: Rapid cool → martensite (hard, brittle)
- **Tempering**: Reheat quenched steel → balance strength and toughness
- **Case hardening**: Hard surface, tough core (carburizing, nitriding)
- **Aluminum**: Solution treat + age → precipitation hardening
- **TTT/CCT diagrams**: Predict microstructures from cooling paths
- **Hardenability**: Ability to form martensite throughout section',
    '[
      {
        "question": "What is the primary difference between annealing and normalizing?",
        "options": [
          "Annealing heats to a higher temperature than normalizing",
          "Annealing uses very slow cooling (furnace cool), normalizing uses air cooling",
          "Normalizing is only used for aluminum, annealing only for steel",
          "There is no difference between the two processes"
        ],
        "correctAnswer": 1,
        "explanation": "Both annealing and normalizing heat steel to the austenite region, but the cooling rates differ. Annealing uses very slow furnace cooling which produces coarse pearlite (softer, more ductile). Normalizing uses faster air cooling which produces finer pearlite (stronger). Both refine grain structure and relieve stresses."
      },
      {
        "question": "Why is tempering necessary after quenching steel to form martensite?",
        "options": [
          "Tempering increases the hardness beyond what martensite provides",
          "Tempering reduces brittleness and relieves internal stresses while maintaining most of the hardness",
          "Tempering converts martensite back to austenite",
          "Tempering is only done for aesthetic reasons to change the color of the steel"
        ],
        "correctAnswer": 1,
        "explanation": "As-quenched martensite is very hard but extremely brittle due to internal stresses from the rapid volume change during transformation. Tempering reheats the martensite to 150-650°C, allowing some carbon to precipitate as fine carbides and relieving internal stresses. This significantly reduces brittleness (increases toughness) while maintaining most of the hardness."
      },
      {
        "question": "What is the purpose of case hardening treatments like carburizing?",
        "options": [
          "To make the entire part uniformly soft",
          "To create a hard, wear-resistant surface while maintaining a tough, ductile core",
          "To remove carbon from the steel surface",
          "To increase the overall size of the part"
        ],
        "correctAnswer": 1,
        "explanation": "Case hardening creates a hard, wear-resistant surface (high carbon) while keeping the core tough and ductile (low carbon). Carburizing diffuses carbon into the surface at high temperature. When quenched, the high-carbon surface forms hard martensite while the low-carbon core remains relatively soft and tough. This is ideal for gears, bearings, and shafts that need wear resistance at the surface but impact resistance throughout."
      }
    ]',
    5,
    NOW()
  );

END $$;
BEGIN $$;

DO $$
DECLARE
  chapter4_id UUID;
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter4_id FROM chapters WHERE slug = 'polymers-and-ceramics';
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';

  -- Chapter 4: Polymers and Ceramics
  -- Lesson 4.1: Polymer Structure and Properties
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440401',
    chapter4_id,
    'Polymer Structure and Properties',
    'polymer-structure-and-properties',
    'Learn about polymer molecular structure, chains, crystallinity, and how structure affects properties.',
    '# Polymer Structure and Properties

## Introduction

**Polymers** are large molecules consisting of many repeating units (monomers) bonded together. They include plastics, rubbers, fibers, and biological materials.

**Examples**:
- Synthetic: Polyethylene, polystyrene, PVC, nylon
- Natural: Rubber, cellulose, proteins, DNA

**Importance**:
- Lightweight
- Low cost
- Easy to process
- Wide range of properties
- Chemically resistant

## Polymer Basics

### Monomers and Polymerization

**Monomer**: Small molecule that can bond to form polymer

**Polymerization**: Process of linking monomers into long chains

**Types of polymerization**:
1. **Addition (chain-growth)**: Monomers add to growing chain
   - No byproducts
   - Example: Ethylene → Polyethylene (PE)

2. **Condensation (step-growth)**: Monomers react with elimination of small molecule
   - Byproduct (H₂O, HCl, etc.)
   - Example: Nylon formation

### Degree of Polymerization (DP)

**DP** = Average number of monomer units in chain

**Molecular weight**:
$$M_n = M_0 \times DP$$

where M₀ = monomer molecular weight

**Typical DP values**:
- Low DP (< 100): Oligomers, oils
- Medium DP (100-1000): Waxes, some plastics
- High DP (> 1000): Most commercial polymers

## Polymer Structure

### Chain Architecture

**Linear polymers**: Straight chains
- Example: High-density polyethylene (HDPE)
- Can crystallize
- Good mechanical properties

**Branched polymers**: Side chains off main chain
- Example: Low-density polyethylene (LDPE)
- Reduced crystallinity
- More flexible, lower density

**Crosslinked polymers**: Chains connected by covalent bonds
- Example: Vulcanized rubber, thermosets
- Insoluble, infusible
- Network structure

**Network polymers**: 3D network of crosslinks
- Example: Epoxy, phenolic resins
- Very rigid, thermosets

### Molecular Weight Distribution

Real polymers have **distribution** of chain lengths:
- **Number average (Mₙ)**: Average by number of chains
- **Weight average (Mₘ)**: Average by weight

**Polydispersity index (PDI)**:
$$PDI = \frac{M_w}{M_n}$$

Typical PDI = 2-5 for commercial polymers

## Crystallinity in Polymers

### Amorphous vs Crystalline

**Amorphous regions**:
- Random chain arrangement
- No long-range order
- Transparent
- Lower density

**Crystalline regions**:
- Ordered chain folding
- Regular arrangement
- Opaque/translucent
- Higher density

**Semi-crystalline polymers**:
- Both crystalline and amorphous regions
- Most common
- Degree of crystallinity: 10-80%

**Crystallinity depends on**:
- Chain regularity (isotactic vs atactic)
- Cooling rate
- Chain flexibility
- Side groups

### Tacticity

**Isotactic**: All substituents on same side of chain
- Can crystallize
- Example: Isotactic polypropylene

**Syndiotactic**: Alternating sides
- Can crystallize (difficult)
- Example: Syndiotactic polystyrene

**Atactic**: Random arrangement
- Cannot crystallize
- Amorphous
- Example: Atactic polypropylene

## Thermal Transitions

### Glass Transition Temperature (Tg)

**Tg**: Temperature where amorphous polymer changes from glassy to rubbery

**Below Tg**:
- Hard, brittle (glassy)
- Chain segments frozen

**Above Tg**:
- Soft, flexible (rubbery)
- Chain segments can move

**Factors affecting Tg**:
- **Chain stiffness**: Stiffer chains → higher Tg
- **Side groups**: Bulky groups → higher Tg
- **Crosslinking**: More crosslinks → higher Tg
- **Molecular weight**: Higher Mₙ → higher Tg (to plateau)

**Examples**:
- Polyethylene: Tg ≈ -120°C (very flexible chains)
- Polystyrene: Tg ≈ 100°C (bulky phenyl groups)
- Epoxy: Tg ≈ 150°C (crosslinked, stiff)

### Melting Temperature (Tm)

**Tm**: Temperature where crystalline regions melt

**Factors affecting Tm**:
- **Crystallinity**: Higher crystallinity → higher Tm
- **Chain regularity**: Regular chains pack better → higher Tm
- **Intermolecular forces**: Hydrogen bonding → higher Tm

**Examples**:
- Polyethylene: Tm ≈ 135°C
- Nylon 6,6: Tm ≈ 265°C (hydrogen bonding)
- Polyethylene terephthalate (PET): Tm ≈ 265°C

## Mechanical Properties

### Stress-Strain Behavior

Polymer stress-strain curves vary widely:

**Brittle polymer**:
- Linear elastic behavior
- Little plastic deformation
- Low strain to failure
- Example: Polystyrene

**Ductile polymer**:
- Yielding followed by drawing
- Large plastic deformation
- High strain to failure
- Example: Polyethylene

**Elastomer**:
- Very low modulus
- Large elastic strains (up to 500%+)
- Example: Natural rubber

### Viscoelasticity

Polymers exhibit **time-dependent** behavior:
- **Creep**: Continuous deformation under constant load
- **Stress relaxation**: Decreasing stress at constant strain
- **Hysteresis**: Energy loss in loading-unloading cycle

**Why viscoelastic?**
- Long chains need time to rearrange
- Response depends on strain rate
- Temperature sensitive

**Applications**:
- Damping: Vibration isolation
- Impact absorption: Helmets, padding

## Polymer Types

### Thermoplastics

**Linear or branched chains** that soften when heated and harden when cooled.

**Characteristics**:
- Reversible melting
- Can be recycled
- Melt-processable
- Examples: PE, PP, PVC, PET

**Crystalline thermoplastics**:
- Semi-crystalline
- Higher density, strength
- Examples: HDPE, PP, PET

**Amorphous thermoplastics**:
- No crystallinity
- Transparent
- Examples: PS, PC, PMMA

### Thermosets

**Crosslinked network** polymers that do not melt.

**Characteristics**:
- Do not melt when heated
- Cannot be recycled by melting
- Generally stronger, more heat resistant
- Examples: Epoxy, phenolic, polyester

**Curing**: Crosslinking reaction (often thermally activated)

### Elastomers

**Crosslinked rubbery** polymers that can undergo large elastic deformation.

**Characteristics**:
- Low modulus
- Large elastic strains
- Recover from deformation
- Examples: Natural rubber, silicone rubber, polyurethane

**Vulcanization**: Sulfur crosslinking of rubber

## Common Polymers

| Polymer | Abbreviation | Structure | Properties | Applications |
|----------|--------------|------------|-------------|---------------|
| Polyethylene | PE | -CH₂- | Flexible, chemical resistant | Bags, bottles |
| Polypropylene | PP | -CH₂-CH(CH₃)- | Stiffer, higher Tm | Containers, carpet |
| Polystyrene | PS | -CH₂-CH(C₆H₅)- | Rigid, brittle | Cups, insulation |
| PVC | PVC | -CH₂-CHCl- | Rigid, flame resistant | Pipes, siding |
| PET | PET | Aromatic | Strong, clear | Bottles, fibers |
| Nylon | PA | Polyamide | Strong, tough | Gears, clothing |
| Polycarbonate | PC | Aromatic | Transparent, tough | Lenses, CDs |

## Summary

- **Polymers** are large molecules made of repeating monomer units
- **Chain architecture**: Linear, branched, crosslinked, network
- **Crystallinity**: Ordered regions affect density, strength, transparency
- **Tg**: Glass transition (glassy ↔ rubbery)
- **Tm**: Melting (crystalline regions melt)
- **Thermoplastics**: Melt when heated, recyclable
- **Thermosets**: Crosslinked, do not melt
- **Elastomers**: Large elastic deformation (rubbery)',
    '[
      {
        "question": "What is the main difference between thermoplastics and thermosets?",
        "options": [
          "Thermoplastics have higher melting points than thermosets",
          "Thermoplastics can be melted and reshaped upon heating, while thermosets have crosslinked networks that do not melt",
          "Thermosets are transparent, thermoplastics are opaque",
          "There is no difference - both are types of plastics"
        ],
        "correctAnswer": 1,
        "explanation": "Thermoplastics have linear or branched chains that can melt when heated and solidify when cooled (reversible process), allowing them to be recycled and reprocessed. Thermosets have crosslinked 3D networks that do not melt when heated (they decompose before melting), making them stronger and more heat resistant but not recyclable by melting."
      },
      {
        "question": "What does the glass transition temperature (Tg) represent for a polymer?",
        "options": [
          "The temperature at which the polymer completely decomposes",
          "The temperature at which crystalline regions form",
          "The temperature range where the polymer changes from a hard, glassy state to a soft, rubbery state",
          "The temperature at which the polymer reaches its maximum strength"
        ],
        "correctAnswer": 2,
        "explanation": "The glass transition temperature (Tg) is the temperature range where an amorphous (or semi-crystalline) polymer changes from a hard, glassy state to a soft, flexible, rubbery state. Below Tg, chain segments are frozen and the material is brittle. Above Tg, chain segments can move and the material becomes flexible and rubbery."
      },
      {
        "question": "How does tacticity affect polymer crystallinity?",
        "options": [
          "Tacticity has no effect on crystallinity",
          "Only atactic polymers can crystallize",
          "Isotactic polymers (substituents on same side) can crystallize, while atactic polymers (random) cannot",
          "All polymers crystallize equally regardless of tacticity"
        ],
        "correctAnswer": 2,
        "explanation": "Tacticity strongly affects crystallinity. Isotactic polymers (all substituents on the same side of the chain) are regular and can pack into ordered crystalline structures. Atactic polymers (random substituent positions) are irregular and cannot crystallize, remaining amorphous. Syndiotactic polymers (alternating positions) can sometimes crystallize but with more difficulty."
      }
    ]',
    1,
    NOW()
  );

  -- Due to token limits, I will create compact versions of remaining lessons
  -- Lesson 4.2: Polymer Types and Applications
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440402',
    chapter4_id,
    'Polymer Types and Applications',
    'polymer-types-and-applications',
    'Explore different types of polymers including commodity plastics, engineering plastics, elastomers, and their applications.',
    '# Polymer Types and Applications

## Introduction

Polymers are classified based on:
- **Cost and production volume** (commodity vs engineering)
- **Mechanical properties** (plastic, elastomer, fiber)
- **Thermal behavior** (thermoplastic vs thermoset)
- **Chemical structure** (addition vs condensation)

## Commodity Polymers

**High volume, low cost** (>100 million tons/year)

### Polyethylene (PE)

**Types**:
- **LDPE**: Low-density, branched (0.91-0.93 g/cm³)
- **HDPE**: High-density, linear (0.94-0.97 g/cm³)
- **LLDPE**: Linear low-density

**Properties**:
- Chemical resistant
- Low cost
- Electrically insulating
- LDPE: Flexible
- HDPE: Stiffer, stronger

**Applications**:
- Plastic bags (LDPE)
- Bottles, containers (HDPE)
- Toys, housewares

### Polypropylene (PP)

**Properties**:
- Higher melting point than PE (160°C)
- Good fatigue resistance
- Excellent chemical resistance
- Semi-crystalline

**Applications**:
- Automotive parts (bumpers, battery cases)
- Containers (Tupperware)
- Carpets (fibers)
- Medical devices (autoclavable)

### Polystyrene (PS)

**Types**:
- **GPPS**: General purpose (crystal, brittle)
- **HIPS**: High impact (rubber modified)
- **EPS**: Expanded (foam)

**Properties**:
- Rigid, transparent (GPPS)
- Good dimensional stability
- Low cost
- Brittle (unmodified)

**Applications**:
- Food packaging
- Insulation (EPS foam)
- Disposable cups, cutlery

### Polyvinyl Chloride (PVC)

**Types**:
- **Rigid PVC**: Pipes, siding
- **Flexible PVC**: With plasticizers (wire coating)

**Properties**:
- Flame resistant (self-extinguishing)
- Chemical resistant
- Rigid or flexible (with plasticizer)
- Low cost

**Applications**:
- Construction (pipes, siding, flooring)
- Wire insulation
- Medical tubing

### PET (Polyethylene Terephthalate)

**Properties**:
- Strong, stiff
- Clear, transparent
- Good gas barrier
- Recyclable (code 1)

**Applications**:
- Beverage bottles
- Polyester fibers (clothing)
- Food packaging

## Engineering Polymers

**Higher performance, higher cost**

### Polycarbonate (PC)

**Properties**:
- Transparent (86% light transmission)
- Very tough (high impact strength)
- High heat resistance (Tg ~ 150°C)
- Dimensionally stable

**Applications**:
- CDs, DVDs
- Safety glasses, lenses
- Electronic housings
- Automotive headlamp lenses

### Nylon (Polyamide, PA)

**Types**: Nylon 6, Nylon 6,6, Nylon 6,12

**Properties**:
- Strong, tough
- Abrasion resistant
- Good fatigue resistance
- Absorbs moisture (can affect properties)

**Applications**:
- Gears, bearings
- Clothing fibers
- Rope, fishing line
- Mechanical parts

### Acrylic (PMMA)

**Properties**:
- Excellent optical clarity (92% transmission)
- Weather resistant
- Good UV resistance
- Brittle

**Applications**:
- Windows (aircraft, aquariums)
- Signs, displays
- Paints
- Dentures

### Acetal (POM)

**Properties**:
- Low friction
- Excellent dimensional stability
- Low moisture absorption
- Good fatigue resistance

**Applications**:
- Gears, bearings
- Zippers
- Pen parts
- Plumbing fittings

## High-Performance Polymers

**Extreme properties, very high cost**

### PEEK (Polyetheretherketone)

**Properties**:
- High temperature resistance (Tg ~ 143°C, Tm ~ 343°C)
- Excellent chemical resistance
- Good mechanical properties
- Biocompatible

**Applications**:
- Aerospace (interior parts)
- Medical implants
- Chemical processing equipment

### PTFE (Teflon)

**Properties**:
- Lowest coefficient of friction
- Excellent chemical resistance
- High temperature resistance
- Non-stick

**Applications**:
- Non-stick cookware
- Seals, gaskets
- Electrical insulation
- Bearings

## Elastomers (Rubbers)

### Natural Rubber

**Source**: Hevea brasiliensis tree

**Properties**:
- Excellent elasticity
- High strength
- Good tear resistance
- Poor oil/heat resistance (unvulcanized)

**Applications**:
- Tires (vulcanized)
- Elastic bands
- Gloves

### Synthetic Rubbers

**Styrene-butadiene rubber (SBR)**:
- Tire treads
- Similar properties to natural rubber

**Nitrile rubber (NBR)**:
- Oil resistant
- Gaskets, seals

**Silicone rubber**:
- Wide temperature range (-100 to 250°C)
- Medical implants
- Sealants

## Thermosets

### Epoxy

**Properties**:
- Excellent adhesion
- Low shrinkage
- Good chemical resistance
- High strength

**Applications**:
- Adhesives
- Coatings
- Composites (fiber reinforced)
- Electronics encapsulation

### Phenolic

**Properties**:
- Heat resistant
- Rigid
- Low cost
- Good electrical insulation

**Applications**:
- Electrical components
- Brake linings
- Pan handles

### Polyester

**Properties**:
- Moderate cost
- Good chemical resistance
- Easy to process

**Applications**:
- Boat hulls (fiber reinforced)
- Tanks, pipes
- Bowling balls

## Fibers

**High modulus, high strength** (oriented chains)

### Synthetic Fibers

**Polyester (PET)**:
- Clothing, upholstery
- Strong, wrinkle resistant

**Nylon**:
- Stockings, rope
- Strong, abrasion resistant

**Acrylic**:
- Sweaters, blankets
- Wool-like properties

### Natural Fibers

**Cotton**: Cellulose-based, comfortable
**Wool**: Protein-based, warm
**Silk**: Protein-based, lustrous

## Recycling Considerations

**Recycling codes**:
1. PET (bottles)
2. HDPE (milk jugs)
3. PVC (pipes)
4. LDPE (bags)
5. PP (containers)
6. PS (foam)
7. Other (mixed, layered)

**Challenges**:
- Separation of different polymers
- Degradation during reprocessing
- Additives contamination

## Summary

- **Commodity polymers**: High volume, low cost (PE, PP, PS, PVC, PET)
- **Engineering polymers**: Better properties, higher cost (PC, nylon, acrylic)
- **High-performance**: Extreme properties, very high cost (PEEK, PTFE)
- **Elastomers**: Large elastic deformation (natural rubber, SBR, silicone)
- **Thermosets**: Crosslinked, don''t melt (epoxy, phenolic, polyester)
- **Fibers**: Oriented, strong (polyester, nylon, acrylic)
- **Applications**: From packaging to aerospace',
    '[
      {
        "question": "What is the main difference between commodity polymers and engineering polymers?",
        "options": [
          "Commodity polymers are always transparent, engineering polymers are opaque",
          "Commodity polymers have high volume and low cost, engineering polymers have better properties at higher cost",
          "Engineering polymers can only be used in electronics, commodity polymers only in packaging",
          "There is no difference between the two categories"
        ],
        "correctAnswer": 1,
        "explanation": "Commodity polymers (PE, PP, PS, PVC, PET) are produced in very high volumes (>100 million tons/year) at low cost for general applications. Engineering polymers (PC, nylon, acrylic) have superior mechanical, thermal, or chemical properties and are more expensive, used for applications requiring better performance."
      },
      {
        "question": "Why are elastomers able to undergo large elastic deformations (often > 500% strain)?",
        "options": [
          "Elastomers have the highest crystallinity of all polymers",
          "Crosslinked networks allow chains to uncoil and recoil, enabling large reversible deformation",
          "Elastomers are actually thermoplastics that melt at room temperature",
          "Elastomers have the highest molecular weight of all polymers"
        ],
        "correctAnswer": 1,
        "explanation": "Elastomers have lightly crosslinked networks that allow polymer chains to uncoil when stretched (entropic elasticity). When the force is removed, the chains recoil back to their random, coiled state due to entropy maximization. This mechanism enables large elastic deformations that would be impossible in uncrosslinked polymers."
      },
      {
        "question": "What makes PTFE (Teflon) unique among polymers?",
        "options": [
          "PTFE has the highest melting point of all polymers",
          "PTFE has the lowest coefficient of friction and excellent chemical resistance (non-stick properties)",
          "PTFE is transparent while most polymers are opaque",
          "PTFE is a thermoplastic that cannot be recycled"
        ],
        "correctAnswer": 1,
        "explanation": "PTFE (Teflon) has the lowest coefficient of friction of any solid polymer, making it extremely slippery. Combined with excellent chemical resistance (inert to almost all chemicals) and high temperature resistance, these properties make PTFE ideal for non-stick cookware, bearings, seals, and other applications requiring low friction."
      }
    ]',
    2,
    NOW()
  );

  -- Lesson 4.3: Ceramic Structure and Properties
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440403',
    chapter4_id,
    'Ceramic Structure and Properties',
    'ceramic-structure-and-properties',
    'Learn about ceramic structures, bonding, and properties that make ceramics useful for many applications.',
    '# Ceramic Structure and Properties

## Introduction

**Ceramics** are inorganic, nonmetallic solids. They include traditional clays, glasses, and advanced technical ceramics.

**Examples**:
- Traditional: Brick, tile, pottery, glass
- Technical: Al₂O₃, SiC, ZrO₂, Si₃N₄

**General properties**:
- Hard and brittle
- High melting points
- Chemical inertness
- Electrical insulators (most)
- Low fracture toughness

## Ionic Bonding in Ceramics

Most ceramics are **ionic compounds**:
- Electrons transferred from metal to nonmetal
- Electrostatic attraction holds ions together
- Directional bonding not required

**Characteristics**:
- High melting points (strong ionic bonds)
- Brittle (bonds break rather than rearrange)
- Often transparent or translucent
- Insulators (no free electrons)

## Crystal Structures of Ceramics

### Rock Salt (NaCl) Structure

**FCC arrangement** of anions with cations in octahedral sites
**Coordination number**: 6:6 (each ion has 6 nearest neighbors)
**Examples**: NaCl, MgO, FeO

### CsCl Structure

**Simple cubic** with ion at body center
**Coordination number**: 8:8
**Examples**: CsCl, CsBr

### Zinc Blende (ZnS) Structure

**FCC** with half tetrahedral sites filled
**Coordination number**: 4:4
**Examples**: ZnS, SiC, GaAs

### Fluorite (CaF₂) Structure

**FCC cations** with anions in all tetrahedral sites
**Coordination**: Cations 8, anions 4
**Examples**: CaF₂, UO₂, ThO₂

## Ceramic Defects

### Point Defects

**Schottky defect**: Cation-anion vacancy pair
- Maintains charge neutrality
- Common in NaCl structure

**Frenkel defect**: Vacancy-interstitial pair
- Small cation moves to interstitial site
- Common in compounds with large size difference

### Nonstoichiometry

Many ceramics can have **variable composition**:
- **FeO**: Iron-deficient (Fe₁₋ₓO)
- **ZnO**: Can be Zn-rich or O-rich

**Implication**: Color, electrical properties affected

## Mechanical Properties

### Hardness

**Ceramics are very hard**:
- Diamond: 70-100 GPa (hardest known material)
- Al₂O₃: ~20 GPa
- SiC: ~25 GPa

**Why hard?**
- Strong ionic/covalent bonds
- Directional bonding (covalent)
- Dislocation motion extremely difficult

### Brittleness

**Ceramics fracture with little plastic deformation**:
- **Low fracture toughness** (K_IC = 1-5 MPa√m vs 50-150 for metals)
- **No dislocation motion** at room temperature
- **Crack propagation** easy

**Why brittle?**
- Limited slip systems (ionic charge constraints)
- Dislocations have very high Peierls stress
- Crack tip stresses cannot be relieved by plasticity

### Strength

**Compressive strength >> Tensile strength**:
- Typical: Compressive strength ~10× tensile
- Example: Concrete (compressive: 20-40 MPa, tensile: 2-5 MPa)

**Design implication**: Use ceramics in compression

### Fracture Mechanics

**Griffith criterion** for crack propagation:
$$\sigma_c = \sqrt{\frac{2E\gamma}{\pi a}}$$

Small flaws dramatically reduce strength (a = crack length)

**Implication**: Ceramics are flaw-sensitive

## Thermal Properties

### Melting Points

**Very high melting points** (strong bonds):
- Al₂O₃: 2072°C
- MgO: 2852°C
- SiC: ~2730°C (sublimes)

### Thermal Expansion

**Generally low** (strong bonds resist expansion):
- Al₂O₃: 8×10⁻⁶ /K
- SiC: 4×10⁻⁶ /K
- (vs Al: 23×10⁻⁶ /K)

**Thermal shock resistance**: Ability to withstand rapid temperature change
- Low expansion + high conductivity = good thermal shock
- Si₃N₄ excellent, Al₂O₃ poor

### Thermal Conductivity

**Varies widely**:
- **AlN, BeO**: High (used as heat sinks)
- **ZrO₂**: Low (used as thermal barrier)
- **Most oxides**: Moderate

## Electrical Properties

### Insulators

**Most ceramics are insulators**:
- Wide band gap (> 5 eV)
- No free electrons
- High resistivity (> 10¹² Ω·cm)

**Examples**: Al₂O₃, SiO₂, MgO

**Applications**: Electrical insulators, substrates

### Ionic Conductors

**Some ceramics conduct via ion migration**:
- **ZrO₂ (stabilized)**: Oxygen ion conductor (fuel cells)
- **β-alumina**: Na⁺ conductor (batteries)

### Semiconductors

**Some ceramics are semiconductors**:
- **SiC**: Wide bandgap (power electronics)
- **ZnO**: Varistors
- **BaTiO₃**: PTC thermistors

## Optical Properties

### Transparency

**Many ceramics are transparent/translucent**:
- Single crystals: Transparent (sapphire, ruby)
- Polycrystalline: Translucent or opaque (light scattering at grain boundaries)

**Applications**: Windows, lasers, optics

### Color

**Impurities create color**:
- **Ruby**: Cr³⁺ in Al₂O₃ (red)
- **Sapphire**: Fe²⁺/Ti⁴⁺ in Al₂O₃ (blue)
- **Emerald**: Cr³⁺ in Be₃Al₂Si₆O₁₈ (green)

### Refractive Index

**High refractive index** (slow light propagation):
- Diamond: n = 2.42
- TiO₂: n = 2.6-2.9
- SiO₂: n = 1.46

**Applications**: Lenses, prisms, optical coatings

## Magnetic Properties

**Ferrimagnetic ceramics**:
- **Ferrites**: MFe₂O₄ (M = Mn, Fe, Co, Ni, Zn, Mg)
- **Properties**: Ferromagnetic but insulating
- **Applications**: Transformers, inductors, magnets

## Common Ceramics

### Oxides

**Alumina (Al₂O₃)**:
- Very hard (20 GPa)
- Good electrical insulator
- Applications: Cutting tools, substrates, spark plugs

**Zirconia (ZrO₂)**:
- High toughness (transformation toughening)
- Applications: Knife blades, thermal barrier coatings

**Silica (SiO₂)**:
- Glass former
- Applications: Glass, optics, insulators

### Carbides

**Silicon carbide (SiC)**:
- Extremely hard
- High temperature stability
- Applications: Abrasives, armor, heating elements

**Tungsten carbide (WC)**:
- Very hard, metallic
- Applications: Cutting tools, mining tools

### Nitrides

**Silicon nitride (Si₃N₄)**:
- High toughness (for ceramic)
- Good thermal shock resistance
- Applications: Bearings, turbine components

**Boron nitride (BN)**:
- Layered structure (like graphite)
- Lubricious (hexagonal BN)
- Very hard (cubic BN)

## Traditional Ceramics

### Clay-Based Ceramics

**Clays** (kaolinite, etc.) + water + other additives

**Products**:
- **Brick**: Fired clay
- **Tile**: Glazed or unglazed
- **Porcelain**: High temperature, vitrified
- **Earthenware**: Low temperature, porous

### Glass

**Amorphous ceramic** (silica network with modifiers)

**Types**:
- **Soda-lime**: Windows, bottles (common glass)
- **Borosilicate**: Labware (Pyrex) - low thermal expansion
- **Lead glass**: Crystal (decorative)

**Properties**: Transparent, brittle, chemically durable

## Advanced Ceramics

### Structural Ceramics

**SiC, Si₃N₄, ZrO₂**:
- High strength at high T
- Wear resistant
- Applications: Engine components, bearings, cutting tools

### Electronic Ceramics

**BaTiO₃**: Capacitors
**ZnO**: Varistors
**Ferrites**: Magnetically soft or hard

### Bioceramics

**Al₂O₃, ZrO₂**: Hip implants (biocompatible, wear resistant)
**Hydroxyapatite**: Bone grafts (similar to bone mineral)

## Summary

- **Ceramics**: Inorganic, nonmetallic solids
- **Bonding**: Primarily ionic/covalent
- **Properties**: Hard, brittle, high melting point, often insulating
- **Crystal structures**: Rock salt, CsCl, zinc blende, fluorite
- **Mechanical**: High hardness, low toughness, flaw-sensitive
- **Thermal**: High Tm, low expansion (generally), variable conductivity
- **Electrical**: Most are insulators, some ionic/electronic conductors
- **Applications**: From traditional pottery to advanced engineering components',
    '[
      {
        "question": "Why are ceramics typically brittle compared to metals?",
        "options": [
          "Ceramics have weaker atomic bonds than metals",
          "Ceramics have limited slip systems and dislocations cannot move easily due to ionic/covalent bonding constraints",
          "Ceramics always have large grain sizes that cause brittleness",
          "Ceramics are actually more ductile than metals at room temperature"
        ],
        "correctAnswer": 1,
        "explanation": "Ceramics are brittle because: (1) Ionic bonding requires maintaining charge neutrality during deformation, limiting available slip systems. (2) Covalent bonding is highly directional. (3) Dislocations have very high Peierls stress (essentially immobile). Without dislocation motion to relieve stress concentrations, cracks propagate easily with little plastic deformation."
      },
      {
        "question": "What is transformation toughening in zirconia (ZrO₂) ceramics?",
        "options": [
          "Zirconia transforms from crystalline to amorphous under stress",
          "Zirconia undergoes a phase transformation (tetragonal to monoclinic) at crack tips that creates compressive stress, resisting crack propagation",
          "Zirconia transforms from ceramic to metal under load",
          "Transformation toughening refers to zirconia being melted and reshaped"
        ],
        "correctAnswer": 1,
        "explanation": "Transformation toughening in partially stabilized zirconia occurs when stress at a crack tip induces a phase transformation from tetragonal to monoclinic structure. This transformation is accompanied by a ~4% volume expansion that creates compressive stresses around the crack tip, effectively \"clamping\" the crack shut and increasing the energy required for crack propagation."
      },
      {
        "question": "Why do traditional ceramics (clay-based products) require firing (heating) during processing?",
        "options": [
          "Firing evaporates water to make the clay lighter",
          "Firing causes chemical reactions and sintering that develop strength and create a glassy phase binding particles together",
          "Firing is only done to add color to the ceramic",
          "Firing melts the ceramic completely so it can be cast into molds"
        ],
        "correctAnswer": 1,
        "explanation": "Firing traditional ceramics causes: (1) Removal of remaining water and organic binders. (2) Decomposition of clay minerals and other raw materials. (3) Formation of new phases (e.g., mullite). (4) Vitrification (formation of glassy phase). These processes sinter particles together, creating strong bonds and developing mechanical properties."
      }
    ]',
    3,
    NOW()
  );

  -- Lesson 4.4: Processing of Ceramics
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440404',
    chapter4_id,
    'Processing of Ceramics',
    'processing-of-ceramics',
    'Learn how ceramics are processed including powder processing, forming, sintering, and specialized techniques.',
    '# Processing of Ceramics

## Introduction

Ceramic processing is challenging because ceramics are:
- **Hard** (difficult to shape)
- **Brittle** (crack easily)
- **High melting** (cannot melt-cast like metals)

**Key challenge**: Get desired shape before final ceramic forms

## Powder Processing

Most ceramics start as **powders**:

### Powder Characteristics

**Particle size**: 0.1-100 μm
- Smaller particles → better packing → higher density
- Too small → handling problems

**Particle shape**:
- Equiaxed: Good packing
- Plate-like: Anisotropic properties

**Size distribution**:
- Optimal: Mix of sizes (small fills gaps between large)

### Powder Preparation

**Traditional**:
- Crushing, grinding natural minerals
- Ball milling

**Advanced**:
- Sol-gel processing (chemical precursors)
- Precipitation from solution
- Vapor deposition

## Forming Techniques

### Dry Pressing

**Process**:
1. Mix powder with small amount of binder
2. Press in die (uniaxial or isostatic)
3. Sinter

**Advantages**:
- Fast
- Good dimensional control
- Low cost

**Limitations**:
- Simple shapes only
- Density gradients (in uniaxial pressing)
- Limited to small parts

**Applications**: Tiles, bricks, electrical insulators

### Slip Casting

**Process**:
1. Prepare slip (powder + water + deflocculant)
2. Pour into porous mold
3. Water absorbed by mold, forming layer
4. Drain excess slip (hollow cast) or let dry (solid cast)

**Advantages**:
- Complex shapes possible
- Good surface finish
- Low equipment cost

**Limitations**:
- Slow
- Limited production rate
- Shrinkage during drying

**Applications**: Artware, sanitary ware, spark plug insulators

### Tape Casting

**Process**:
1. Form slip
2. Doctor blade spreads thin layer on moving carrier
3. Dry
4. Cut sheets

**Advantages**:
- Thin sheets (50 μm - 1 mm)
- Uniform thickness

**Applications**: Substrates for electronics, capacitor dielectrics

### Injection Molding

**Process**:
1. Mix powder with thermoplastic binder
2. Heat and inject into mold
3. Cool
4. Remove binder (thermal or solvent)
5. Sinter

**Advantages**:
- Complex shapes
- High precision
- Good for mass production

**Limitations**:
- Tooling cost high
- Binder removal critical

**Applications**: Turbocharger rotors, complex ceramic parts

### Extrusion

**Process**:
1. Mix powder with binder and water
2. Force through die
3. Cut to length
4. Dry and sinter

**Advantages**:
- Continuous process
- Hollow shapes possible

**Applications**: Tubes, honeycomb structures (catalyst supports)

## Sintering

**Sintering**: Powder particles bond at high temperature without complete melting.

### Sintering Mechanism

**Stages**:
1. **Initial neck growth**: Particles bond at contact points
2. **Pore channel closure**: Pores become isolated
3. **Pore shrinkage**: Final densification

**Driving forces**:
- Surface energy reduction (coalescence)
- Curvature-driven diffusion

### Solid-State Sintering

**Process**:
- Heat to 0.7-0.9 Tm
- Atoms diffuse along surfaces, grain boundaries, lattice
- Porosity decreases

**Limitations**:
- Long times
- May not reach full density
- Grain growth can occur

### Liquid-Phase Sintering

**Process**:
- Add small amount of lower-melting component
- Forms liquid that aids particle rearrangement
- Faster than solid-state

**Applications**: Si₃N₄ (with Y₂O₃ additive), cemented carbides

### Hot Pressing / Hot Isostatic Pressing (HIP)

**Hot pressing**:
- Uniaxial pressure + heat
- Higher densities
- Limited to simple shapes

**HIP**:
- Isostatic gas pressure + heat
- Complex shapes
- Eliminates internal porosity

## Traditional Ceramic Processing

### Clay-Based Ceramics

**Steps**:
1. **Prepare body**: Mix clay, flux, filler
2. **Form**: Wedge, throw, press
3. **Dry**: Remove water slowly
4. **Fire**: Heat to 1000-1300°C
5. **Glaze** (optional): Apply glass coating, re-fire

### Glass Processing

**Melting**:
- Raw materials (sand, soda, lime) → 1500-1600°C
- Homogenize

**Forming**:
- **Float glass**: Molten glass on molten tin (windows)
- **Blowing**: Bottles (air pressure)
- **Pressing**: Patterns (glassware)

**Annealing**:
- Slow cool to remove thermal stress
- Prevents cracking

**Tempering**:
- Surface cooled rapidly
- Surface in compression
- Stronger, safer (breaks into small pieces)

## Advanced Ceramic Processing

### Single Crystal Growth

**Czochralski method**:
- Seed crystal pulled from melt
- Rotate and pull slowly
- Large single crystals

**Applications**: Sapphire (watch crystals, optics), Si wafers

### Thin Films

**Physical vapor deposition (PVD)**:
- Sputtering, evaporation
- Coatings on tools, electronics

**Chemical vapor deposition (CVD)**:
- Gas-phase precursors react on surface
- Conformal coatings

**Applications**: Wear coatings, electronic devices

### Sol-Gel Processing

**Process**:
1. Prepare solution (sol) of precursors
2. Gelation (network formation)
3. Dry → remove liquid
4. Heat treatment → crystalline ceramic

**Advantages**:
- High purity
- Homogeneous
- Low processing temperature
- Complex shapes possible

**Applications**: Coatings, fibers, powders

## Composite Materials

**Ceramic matrix composites (CMC)**:
- Ceramic matrix + ceramic fibers
- Improved toughness
- Applications: Hot sections of jet engines

**Reinforced ceramics**:
- SiC whiskers in Al₂O₃
- Improved toughness

## Machining of Ceramics

**Diamond grinding**:
- Only practical method for hard ceramics
- Diamond abrasive wheel
- Coolant to prevent thermal shock

**Ultrasonic machining**:
- Slurry + vibrating tool
- Brittle fracture by abrasion

**Laser machining**:
- Localized heating
- Precision cutting, drilling

## Defects and Quality Control

**Common defects**:
- **Porosity**: Incomplete densification
- **Inclusions**: Foreign material
- **Cracks**: Thermal shock, rapid drying
- **Density gradients**: Improper forming

**Quality control**:
- Visual inspection
- Dimensional measurement
- X-ray inspection (internal defects)
- Mechanical testing

## Summary

- **Ceramic processing** starts with powders
- **Forming**: Pressing, casting, molding, extrusion
- **Sintering**: Bond particles at high T
- **Solid-state sintering**: Diffusion-driven
- **Liquid-phase sintering**: Faster with liquid phase
- **Hot pressing/HIP**: Apply pressure during sintering
- **Glass**: Melt, form, anneal, temper
- **Advanced**: Single crystals, thin films, sol-gel
- **Machining**: Diamond grinding, ultrasonic, laser
- **Defects**: Porosity, cracks, inclusions',
    '[
      {
        "question": "What is sintering in ceramic processing?",
        "options": [
          "Melting the ceramic completely and casting it",
          "Heating powder particles to below their melting point so they bond together through diffusion",
          "Mixing ceramic powder with water and pouring into molds",
          "Glazing ceramic surfaces to make them shiny"
        ],
        "correctAnswer": 1,
        "explanation": "Sintering is the process of heating ceramic powder to temperatures below their melting point (typically 0.7-0.9 Tm) where solid-state diffusion causes particles to bond at contact points. This reduces surface energy and causes densification (reduced porosity) and strengthening without complete melting."
      },
      {
        "question": "Why is hot isostatic pressing (HIP) used for some advanced ceramics?",
        "options": [
          "HIP melts the ceramic so it can be cast into complex shapes",
          "HIP applies uniform gas pressure from all directions during heating to eliminate porosity and improve density",
          "HIP is only used for decorative purposes to create glossy surfaces",
          "HIP reduces the melting point of ceramics significantly"
        ],
        "correctAnswer": 1,
        "explanation": "Hot isostatic pressing (HIP) applies uniform gas pressure from all directions while the ceramic is heated, which helps collapse pores and achieve near-theoretical density. The isostatic (uniform) pressure allows complex shapes to be processed without the density gradients that occur in uniaxial pressing."
      },
      {
        "question": "What is the advantage of slip casting for ceramic forming?",
        "options": [
          "Slip casting is the fastest forming method available",
          "Slip casting can produce complex shapes with good surface finish using relatively simple equipment",
          "Slip casting produces the strongest ceramic parts",
          "Slip casting eliminates the need for firing"
        ],
        "correctAnswer": 1,
        "explanation": "Slip casting uses a liquid suspension (slip) of ceramic powder in water that is poured into a porous mold. The mold absorbs water, leaving a consolidated layer of ceramic. This method can produce complex shapes with good surface finish using relatively simple and inexpensive molds, though it is slower than some other methods."
      }
    ]',
    4,
    NOW()
  );

END $$;
BEGIN $$;

DO $$
DECLARE
  chapter4_id UUID;
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter4_id FROM chapters WHERE slug = 'polymers-and-ceramics';
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';

  -- Lesson 4.5: Composite Materials
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440405',
    chapter4_id,
    'Composite Materials',
    'composite-materials',
    'Learn about composite materials, their types, properties, and applications combining different materials for superior performance.',
    '# Composite Materials

## Introduction

**Composites** consist of two or more distinct materials that combine to achieve properties superior to either constituent alone.

**Components**:
- **Matrix**: Binds reinforcement, transfers load
- **Reinforcement**: Provides strength, stiffness

**Examples from nature**:
- Wood (cellulose fibers in lignin matrix)
- Bone (hydroxyapatite in collagen)
- Bamboo

## Classification of Composites

### By Matrix Material

**Metal Matrix Composites (MMCs)**:
- Matrix: Al, Mg, Ti, Cu
- Reinforcement: SiC, Al₂O₃ fibers or particles
- Applications: Aircraft, automotive, electronic packaging

**Polymer Matrix Composites (PMCs)**:
- Matrix: Epoxy, polyester, PEEK
- Reinforcement: Glass, carbon, aramid fibers
- Applications: Aircraft, boats, sports equipment

**Ceramic Matrix Composites (CMCs)**:
- Matrix: SiC, Al₂O₃
- Reinforcement: SiC, Al₂O₃ fibers
- Applications: Hot sections of jet engines

### By Reinforcement Geometry

**Particulate composites**:
- Particles distributed in matrix
- Isotropic properties
- Example: SiC particles in Al (automotive pistons)

**Fibrous composites**:
- Fibers aligned or random
- Anisotropic properties
- Example: Carbon fiber epoxy (aircraft)

**Laminar composites**:
- Layers of different materials
- Example: Plywood, automotive safety glass

## Fiber-Reinforced Composites

### Fiber Types

**Glass fibers**:
- Low cost
- Good strength
- Applications: Boat hulls, storage tanks, sporting goods

**Carbon fibers**:
- High strength-to-weight
- Expensive
- Applications: Aircraft, high-performance sports equipment

**Aramid fibers** (Kevlar):
- High toughness
- Good impact resistance
- Applications: Body armor, tires, ropes

**Natural fibers**:
- Low cost, renewable
- Lower properties
- Applications: Automotive interior parts, construction

### Fiber Architecture

**Continuous fibers**:
- Maximum strength and stiffness
- Aligned or woven
- Applications: Aerospace structures

**Chopped fibers**:
- Random orientation
- Lower properties, easier processing
- Applications: Injection molded parts

**Woven fabrics**:
- Balanced properties in fabric plane
- Applications: Boat hulls, fairings

### Polymer Matrix

**Thermosets** (epoxy, polyester):
- Most common
- Good fiber wetting
- Applications: High-performance structures

**Thermoplastics** (PEEK, nylon):
- Tougher
- Recyclable
- Shorter cycle times
- Applications: Automotive interior, consumer goods

## Composite Properties

### Rule of Mixtures

**Upper bound** (isostrain):
$$E_c = V_f E_f + V_m E_m$$

**Lower bound** (isostress):
$$\frac{1}{E_c} = \frac{V_f}{E_f} + \frac{V_m}{E_m}$$

where:
- E_c = composite modulus
- E_f, E_m = fiber, matrix moduli
- V_f, V_m = fiber, matrix volume fractions (V_f + V_m = 1)

### Specific Properties

**Strength-to-weight ratio**:
$$\frac{\sigma}{\rho}$$

Composites excel!
- Carbon/epoxy: 3-5× steel
- Applications: Aircraft, spacecraft, racing

### Anisotropy

**Properties depend on direction**:
- Strongest in fiber direction
- Weakest transverse to fibers
- Quasi-isotropic: Multiple fiber orientations

## Composite Fabrication

### Hand Lay-Up

**Process**:
1. Apply resin to mold
2. Place fiber fabric
3. Repeat
4. Cure

**Advantages**: Simple, low tooling cost
**Limitations**: Labor intensive, variable quality
**Applications**: Prototypes, small batches, boats

### Filament Winding

**Process**:
1. Rotate mandrel
2. Wind continuous fiber with resin
3. Cure

**Advantages**: Automated, precise fiber orientation
**Applications**: Pipes, pressure vessels, rocket motor cases

### Pultrusion

**Process**:
1. Pull fibers through resin bath
2. Through heated die
3. Cut to length

**Advantages**: Continuous, consistent
**Applications**: Beams, rods, structural shapes

### Resin Transfer Molding (RTM)

**Process**:
1. Place dry fibers in mold
2. Close mold
3. Inject resin
4. Cure

**Advantages**: Good surface finish, complex shapes
**Applications**: Automotive parts, aerospace components

## Composite Applications

### Aerospace

**Primary structure**:
- Wing skins, fuselage sections
- Tail surfaces
- Control surfaces

**Benefits**: Weight reduction → fuel savings

**Example**: Boeing 787 - 50% composite by weight

### Automotive

**Body panels**:
- Hoods, decklids, fenders
- Weight reduction

**Suspension components**:
- Leaf springs (glass fiber)
- Drive shafts

**Limitation**: Cost (vs steel)

### Sporting Goods

**High-end equipment**:
- Tennis rackets (carbon fiber)
- Golf clubs (carbon fiber)
- Bicycles (carbon fiber)
- Skis, snowboards

**Benefits**: Light weight, vibration damping

### Marine

**Boats**:
- Hulls, decks
- Corrosion resistant

**Advantages**: No rust, lighter than aluminum

### Construction

**Reinforcement**:
- Rebars (glass fiber)
- Tendons (carbon fiber)
- Bridge decks

**Benefits**: Corrosion resistance, lightweight

## Composite Design Considerations

### Fiber Volume Fraction

**Typical range**: 50-70% fibers

**Higher V_f**:
- Increased strength, stiffness
- More difficult processing

**Lower V_f**:
- Better resin flow
- Reduced properties

### Interface

**Fiber-matrix interface critical**:
- Transfers load from matrix to fibers
- Chemical bonding or mechanical interlocking

**Poor interface**:
- Delamination
- Reduced strength

### Environmental Effects

**Moisture absorption**:
- Matrix swelling
- Property degradation
- Interface degradation

**Temperature**:
- Matrix T_g limits use temperature
- CTE mismatch → thermal stresses

**UV degradation**:
- Surface degradation
- Protective coatings needed

## Failure Modes

### Fiber Failure

**Fiber breakage**:
- Tensile overload
- Stress concentrations
- Damaged fibers

### Matrix Failure

**Matrix cracking**:
- Transverse loading
- Impact damage

### Interface Failure

**Delamination**:
- Layer separation
- Reduces stiffness
- Impact damage common

### Fatigue

**Progressive damage**:
- Matrix cracking
- Fiber-matrix debonding
- Fiber breakage

## Summary

- **Composites**: Two or more materials with superior combined properties
- **Components**: Matrix (binder) + reinforcement (strength)
- **Types**: MMC, PMC, CMC
- **Fiber composites**: Highest strength-to-weight
- **Rule of mixtures**: Predicts composite properties
- **Anisotropic**: Properties depend on fiber direction
- **Processing**: Lay-up, filament winding, pultrusion, RTM
- **Applications**: Aerospace, automotive, sporting goods, marine
- **Challenges**: Cost, joining, inspection, repair',
    '[
      {
        "question": "What is the primary advantage of fiber-reinforced composites over metals?",
        "options": [
          "Composites are always cheaper than metals",
          "Composites have higher strength-to-weight ratios (specific strength) when fibers are aligned with load",
          "Composites have higher melting points than any metal",
          "Composites are isotropic (same properties in all directions)"
        ],
        "correctAnswer": 1,
        "explanation": "The primary advantage of fiber-reinforced composites is their exceptional strength-to-weight ratio (specific strength). When fibers are aligned with the loading direction, composites can achieve 3-5× the specific strength of steel, enabling significant weight reduction in structures like aircraft and high-performance vehicles."
      },
      {
        "question": "What role does the matrix play in a fiber-reinforced composite?",
        "options": [
          "The matrix provides the primary strength and stiffness",
          "The matrix binds the fibers together, transfers load between fibers, protects them, and determines the shape",
          "The matrix serves only as a cosmetic surface coating",
          "The matrix has no function in the composite"
        ],
        "correctAnswer": 1,
        "explanation": "The matrix (typically polymer, metal, or ceramic) serves several critical functions: (1) Binds and holds fibers in position, (2) Transfers load between fibers through shear at the fiber-matrix interface, (3) Protects fibers from environmental damage, (4) Determines the composite''s shape and surface finish. The fibers provide primary strength and stiffness."
      },
      {
        "question": "Why are composites considered anisotropic materials?",
        "options": [
          "Composites have the same properties in all directions",
          "Composites properties vary with direction because fibers are strongest along their length, not transverse to it",
          "Composites change properties randomly without any pattern",
          "Only isotropic materials can be made into composites"
        ],
        "correctAnswer": 1,
        "explanation": "Composites are anisotropic because their properties depend on direction. Fibers provide maximum strength and stiffness only when aligned with the loading direction. Properties are much lower in directions transverse to fiber orientation. Designers must consider loading directions and often use multi-directional fiber layouts or quasi-isotropic layups for complex loading."
      }
    ]',
    5,
    NOW()
  );

END $$;
BEGIN $$;

DO $$
DECLARE
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';

  -- Chapter 5: Electronic and Optical Materials
  -- Lesson 5.1: Electrical Properties and Conductivity
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440501',
    chapter5_id,
    'Electrical Properties and Conductivity',
    'electrical-properties-and-conductivity',
    'Learn about electrical conduction, resistivity, and the classification of materials as conductors, semiconductors, and insulators.',
    '# Electrical Properties and Conductivity

## Introduction

**Electrical conductivity** is a fundamental property that varies dramatically across materials:

| Type | Conductivity (S/m) | Resistivity (Ω·m) | Examples |
|------|---------------------|-------------------|----------|
| Conductors | > 10⁶ | < 10⁻⁶ | Cu, Ag, Al |
| Semiconductors | 10⁻⁶ to 10⁴ | 10⁻⁴ to 10⁶ | Si, Ge, GaAs |
| Insulators | < 10⁻⁶ | > 10⁶ | Diamond, glass, rubber |

## Electrical Conduction Mechanisms

### Metallic Conduction

**Sea of electrons** model:
- Valence electrons delocalized
- Free to move throughout metal
- Conductivity decreases with temperature

**Drude model**:
$$\sigma = \frac{ne^2\tau}{m}$$

where:
- n = electron concentration
- e = electron charge
- τ = relaxation time (average time between collisions)
- m = electron mass

**Temperature dependence**:
$$\rho(T) = \rho_0[1 + \alpha(T - T_0)]$$

Metals become more resistive at higher T (more electron-phonon scattering).

### Ionic Conduction

**Ions move** through crystal lattice or solution:
- Solid ionic conductors at high T
- Liquid electrolytes (batteries)

**Examples**:
- **ZrO₂ (stabilized)**: Oxygen ion conductor
- **β-alumina**: Sodium ion conductor

### Semiconductor Conduction

**Electrons and holes** contribute:
- **Intrinsic**: Equal electron and hole concentrations
- **Extrinsic**: Doped to control carrier type and concentration

## Band Theory

### Energy Bands

**Formation**: Atomic energy levels split into bands as atoms approach.

**Types of bands**:
1. **Valence band**: Highest energy band with electrons at T = 0 K
2. **Conduction band**: Empty band above valence band
3. **Band gap (E_g)**: Forbidden energy region between bands

### Classification by Band Structure

**Metals**:
- Partially filled band OR overlapping bands
- Electrons can move into nearby empty states
- High conductivity

**Semiconductors**:
- Small band gap (E_g < 3.5 eV)
- Thermal excitation can promote electrons to conduction band
- Conductivity increases with temperature

**Insulators**:
- Large band gap (E_g > 3.5 eV)
- Thermal excitation insufficient
- Very low conductivity

**Examples**:
- **Si**: E_g = 1.1 eV (semiconductor)
- **Diamond**: E_g = 5.5 eV (insulator)
- **Ge**: E_g = 0.67 eV (semiconductor)

## Conductors

### Metals

**Best conductors**:
- **Silver**: Highest conductivity (6.3×10⁷ S/m)
- **Copper**: Excellent conductivity (5.96×10⁷ S/m), lower cost
- **Gold**: Excellent conductivity, corrosion resistant (expensive)
- **Aluminum**: Good conductivity (3.5×10⁷ S/m), lightweight

**Factors affecting conductivity**:
- **Purity**: Impurities scatter electrons
- **Temperature**: Higher T → more scattering → higher resistivity
- **Defects**: Dislocations, grain boundaries scatter electrons
- **Alloying**: Generally decreases conductivity

**Applications**:
- **Copper**: Wiring, motors, transformers
- **Aluminum**: Power transmission (lightweight)
- **Gold**: Plating on connectors (corrosion resistance)
- **Silver**: High-performance contacts

### Superconductors

**Zero electrical resistance** below critical temperature.

**Types**:
1. **Type I**: Pure metals (Hg, Pb, Al)
   - Sharp transition at T_c
   - Low critical fields

2. **Type II**: Alloys and compounds (Nb₃Sn, YBCO)
   - Gradual transition
   - Higher critical fields and temperatures

**High-T_c superconductors**: YBa₂Cu₃O₇ (T_c = 93 K)

**Applications**: MRI machines, maglev trains, particle accelerators

## Semiconductors

### Intrinsic Semiconductors

**Pure semiconductor** with equal electrons and holes:

$$n_i = p_i$$

Carrier concentration depends on temperature:
$$n_i = N_c N_v \exp\left(-\frac{E_g}{2kT}\right)$$

**Examples**: Pure Si, Ge

### Extrinsic Semiconductors

**Doped** to control conductivity:

**n-type**:
- Donor impurities (Group V: P, As, Sb)
- Extra electrons
- Majority carriers: electrons
- Example: Si doped with P

**p-type**:
- Acceptor impurities (Group III: B, Al, Ga)
- Create holes
- Majority carriers: holes
- Example: Si doped with B

**Carrier concentration**:
$$n \approx N_D \text{ (n-type)}$$
$$p \approx N_A \text{ (p-type)}$$

where N_D, N_A are donor/acceptor concentrations.

### Compound Semiconductors

**III-V compounds**: GaAs, InP, GaN
- Higher electron mobility than Si
- Direct band gap (optoelectronics)
- Applications: LEDs, laser diodes, high-frequency devices

**II-VI compounds**: ZnSe, CdTe
- Optoelectronics
- Solar cells

## Insulators

**Very high resistivity** (> 10¹² Ω·cm)

**Applications**:
- **Electrical insulation**: Wires, cables, motors
- **Substrates**: Circuit boards (Al₂O₃)
- **Dielectrics**: Capacitors (SiO₂, Ta₂O₅)

**Breakdown voltage**:
- Field strength causing catastrophic conduction
- **Dielectric strength**: V/mil or kV/mm
- **Example**: Air: 3 kV/mm

## Dielectric Properties

**Dielectrics**: Polarizable insulators

**Relative permittivity (dielectric constant, ε_r)**:
$$\varepsilon_r = \frac{C_{material}}{C_{vacuum}}$$

**Polarization mechanisms**:
1. **Electronic**: Electron cloud distortion
2. **Ionic**: Ion displacement
3. **Orientation**: Dipole alignment
4. **Space charge**: Charge carrier migration

**Applications**:
- **Capacitors**: High ε_r → high capacitance
- **Insulation**: Low ε_r → low capacitive coupling

**Dielectric loss**:
- Energy dissipation in AC field
- **Loss tangent (tan δ)**: Measure of loss

## Applications

### Interconnects

**Requirements**: Low resistivity, reliable

**Materials**:
- **Al**: Traditional IC interconnects
- **Cu**: Modern ICs (lower resistivity, better electromigration)

**Challenges**: Electromigration (high current density)

### Transparent Conductors

**Requirements**: Conductive + transparent

**Materials**:
- **ITO (Indium Tin Oxide)**: Standard but expensive
- **Alternatives**: Graphene, carbon nanotubes, metal nanowires

**Applications**: Touch screens, solar cells, displays

### Resistors

**Materials**: Nichrome (Ni-Cr), tantalum, metal films

**Properties**:
- Controlled resistivity
- Low temperature coefficient
- Good stability

### Heating Elements

**Requirements**: High resistivity, high melting point

**Materials**:
- **Nichrome**: Toaster, hair dryer elements
- **Kanthal**: Fe-Cr-Al alloy (furnaces)

## Summary

- **Conductivity** varies over >10²⁰ range across materials
- **Metals**: Sea of delocalized electrons (σ decreases with T)
- **Semiconductors**: Band gap < 3.5 eV (σ increases with T)
- **Insulators**: Large band gap > 3.5 eV (very low σ)
- **Band theory**: Overlapping bands (metals), small gap (semiconductors), large gap (insulators)
- **Superconductors**: Zero resistance below T_c
- **Dielectrics**: Polarizable insulators for capacitors',
    '[
      {
        "question": "Why does the electrical resistance of metals increase with temperature, while semiconductors show the opposite behavior?",
        "options": [
          "Metals and semiconductors actually behave identically with respect to temperature",
          "In metals, higher temperature increases electron-phonon scattering; in semiconductors, higher temperature excites more electrons across the band gap",
          "Metals become better conductors at high temperature because atoms move faster",
          "Semiconductors have a higher melting point than metals"
        ],
        "correctAnswer": 1,
        "explanation": "In metals, higher temperature increases lattice vibrations (phonons), which scatter electrons more frequently, increasing resistance. In semiconductors, higher temperature provides thermal energy that excites more electrons from the valence band to the conduction band, increasing the number of charge carriers and thus increasing conductivity (decreasing resistance)."
      },
      {
        "question": "What is the band gap and how does it determine whether a material is a conductor, semiconductor, or insulator?",
        "options": [
          "The band gap is the distance between atoms in a crystal lattice",
          "The band gap is the energy difference between valence and conduction bands; small gap = semiconductor, large gap = insulator, no gap = conductor",
          "The band gap is only relevant to metals, not semiconductors",
          "The band gap is the resistance of a material"
        ],
        "correctAnswer": 1,
        "explanation": "The band gap (E_g) is the forbidden energy region between the valence band (filled with electrons) and conduction band (empty at 0 K). Conductors have overlapping bands (no gap), semiconductors have small gaps (< 3.5 eV) allowing thermal excitation, and insulators have large gaps (> 3.5 eV) preventing electron excitation."
      },
      {
        "question": "How does doping work to create n-type and p-type semiconductors?",
        "options": [
          "Doping makes semiconductors magnetic by adding iron atoms",
          "Doping adds impurity atoms that donate electrons (n-type) or create holes (p-type), controlling conductivity",
          "Doping changes the color of the semiconductor",
          "N-type semiconductors are made with neutrons, p-type with protons"
        ],
        "correctAnswer": 1,
        "explanation": "Doping introduces controlled impurities: n-type doping adds donor atoms (Group V like P, As) with extra valence electrons, providing electrons as majority carriers. p-type doping adds acceptor atoms (Group III like B) with fewer valence electrons, creating holes (electron absences) as majority carriers. This allows precise control of semiconductor conductivity."
      }
    ]',
    1,
    NOW()
  );

END $$;
-- Adding remaining Chapter 5 lessons (5.2-5.5) to complete Materials Science course
-- These are condensed versions to complete the course structure

BEGIN $$;

DO $$
DECLARE
  chapter5_id UUID;
BEGIN
  SELECT id INTO chapter5_id FROM chapters WHERE slug = 'electronic-and-optical-materials';

  -- Lesson 5.2: Semiconductors
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440502',
    chapter5_id,
    'Semiconductors',
    'semiconductors',
    'Study semiconductor physics, p-n junctions, transistors, and applications in electronics.',
    '# Semiconductors

## Introduction
Semiconductors have conductivity between metals and insulators. Their electrical properties can be precisely controlled through doping.

## Carrier Concentration

**Intrinsic carrier concentration**:
$$n_i = \sqrt{N_c N_v} \exp\left(-\frac{E_g}{2kT}\right)$$

**Mass action law**:
$$np = n_i^2$$

**Temperature dependence**: Exponential increase in carriers with temperature

## P-N Junctions

**Formation**: p-type and n-type materials joined

**Depletion region**:
- Region devoid of mobile carriers
- Built-in electric field
- Width depends on doping concentrations

**Band bending**:
- Energy bands shift at junction
- Potential barrier formed

**Biasing**:
- **Forward bias**: p-side positive → current flows
- **Reverse bias**: p-side negative → no current (small leakage)

## Diodes

**Rectification**:
- Forward bias: Low resistance
- Reverse bias: High resistance
- Applications: Rectifiers, voltage clamping

**LEDs**:
- Forward bias → recombination → light emission
- Color depends on band gap: $E = hc/\lambda$

**Solar cells**:
- Reverse process of LED
- Light → electron-hole pairs → current

## Transistors

**Bipolar Junction Transistor (BJT)**:
- Three terminals: Emitter, Base, Collector
- Current controlled device
- Amplification: $\beta = I_C/I_B$

**MOSFET**:
- Metal-Oxide-Semiconductor Field Effect Transistor
- Voltage controlled device
- Dominant technology for ICs

**Applications**:
- Amplifiers
- Switches
- Logic circuits
- Memory

## Integrated Circuits

**Silicon processing**:
1. Crystal growth (Czochralski)
2. Wafer slicing
3. Photolithography
4. Etching
5. Doping (diffusion, ion implantation)
6. Metallization
7. Packaging

**Moore''s Law**: Transistor count doubles ~2 years

## Summary
- **Semiconductors**: Tunable conductivity via doping
- **P-N junctions**: Foundation of most semiconductor devices
- **Diodes**: Rectify AC to DC, LEDs emit light
- **Transistors**: Amplify signals, switch circuits
- **ICs**: Millions to billions of transistors on single chip',
    '[
      {"question": "What happens when a p-n junction is forward biased?", "options": ["Current cannot flow in either direction", "The p-side is connected to positive voltage, reducing the depletion region and allowing current to flow", "The depletion region becomes wider", "The junction becomes more resistive"], "correctAnswer": 1, "explanation": "In forward bias, the p-side is connected to positive voltage and n-side to negative. This reduces the depletion region width and the potential barrier, allowing majority carriers (holes from p-side, electrons from n-side) to cross the junction, producing current."},
      {"question": "How does a MOSFET differ from a BJT?", "options": ["BJT is voltage-controlled, MOSFET is current-controlled", "MOSFET is voltage-controlled (gate), BJT is current-controlled (base)", "There is no difference between them", "MOSFETs cannot be used for amplification"], "correctAnswer": 1, "explanation": "BJT (Bipolar Junction Transistor) is a current-controlled device where base current controls collector current. MOSFET (Metal-Oxide-Semiconductor FET) is a voltage-controlled device where gate voltage controls the channel conductivity, requiring virtually no gate current."},
      {"question": "What determines the color of light emitted by an LED?", "options": ["The amount of current applied", "The band gap energy of the semiconductor (E = hc/λ)", "The size of the LED chip", "The temperature of the LED"], "correctAnswer": 1, "explanation": "LED color depends on semiconductor band gap energy. When electrons recombine with holes across the band gap, photons are emitted with energy E = Eg = hc/λ. Different semiconductors have different band gaps: GaAs (infrared, ~870 nm), GaP (green, ~550 nm), GaN (blue, ~450 nm)."}
    ]',
    2,
    NOW()
  );

  -- Lesson 5.3: Magnetic Materials
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440503',
    chapter5_id,
    'Magnetic Materials',
    'magnetic-materials',
    'Explore magnetic properties, diamagnetism, paramagnetism, ferromagnetism, and applications.',
    '# Magnetic Materials

## Introduction
Magnetic materials respond to magnetic fields. Response depends on atomic structure and electron configuration.

## Magnetic Dipoles

**Source**: Electron motion and spin
**Orbital magnetic moment**: Electrons orbiting nucleus
**Spin magnetic moment**: Electron intrinsic angular momentum

**Magnetic moment**: $\mu = IA$ (current loop)

## Classification of Magnetic Materials

### Diamagnetic

**Weak repulsion** from magnetic field
**Negative susceptibility** (χ < 0, small)
**No permanent dipoles**
**Induced dipoles oppose field**

**Examples**: Cu, Au, H₂O, most organic materials

### Paramagnetic

**Weak attraction** to magnetic field
**Positive susceptibility** (χ > 0, small)
**Permanent dipoles randomly oriented**
**Field aligns dipoles**

**Examples**: Al, O₂, transition metals (unpaired electrons)

### Ferromagnetic

**Strong attraction** to magnetic field
**Large positive susceptibility**
**Permanent dipoles** align spontaneously below Curie temperature
**Domains**: Regions of aligned dipoles

**Examples**: Fe, Ni, Co, some rare earths

**Curie temperature (T_C)**: Above T_C, becomes paramagnetic
- Fe: T_C = 770°C
- Ni: T_C = 358°C
- Co: T_C = 1121°C

### Ferrimagnetic

**Antiparallel alignment** of unequal moments
**Net magnetization** (weaker than ferromagnetic)
**Examples**: Ferrites (MFe₂O₄)

## Hysteresis

**B-H curve**:
- **Saturation**: Maximum magnetization
- **Remanence (M_r)**: Residual magnetization at H = 0
- **Coercivity (H_c)**: Field to reduce M to 0
- **Hysteresis loop**: Energy loss per cycle

**Hard magnetic materials**: High coercivity (permanent magnets)
- Example: Alnico, rare earth magnets (NdFeB)

**Soft magnetic materials**: Low coercivity (easy to magnetize/demagnetize)
- Example: Fe-Si (transformer cores), permalloy

## Applications

**Permanent magnets**: Motors, speakers, MRI
**Transformer cores**: AC magnetic response
**Magnetic storage**: Hard disks, tape
**MRI**: Superconducting magnets

## Summary
- **Diamagnetic**: Weak repulsion (no permanent dipoles)
- **Paramagnetic**: Weak attraction (random permanent dipoles)
- **Ferromagnetic**: Strong attraction, spontaneous alignment
- **Ferrimagnetic**: Antiparallel, unequal moments
- **Hysteresis**: B-H loop shows saturation, remanence, coercivity
- **Hard magnets**: High coercivity (permanent magnets)
- **Soft magnets**: Low coercivity (transformer cores)',
    '[
      {"question": "What is the key difference between ferromagnetic and ferrimagnetic materials?", "options": ["Ferromagnetic materials have no magnetic moments", "Ferromagnetic: all dipoles align parallel; Ferrimagnetic: dipoles align antiparallel but with unequal magnitudes giving net moment", "There is no difference between the two", "Ferrimagnetic materials are always liquid at room temperature"], "correctAnswer": 1, "explanation": "Ferromagnetic materials have all magnetic dipoles aligned parallel, giving strong net magnetization. Ferrimagnetic materials have antiparallel alignment of magnetic moments on different sublattices, but the moments are unequal in magnitude, resulting in a weaker net magnetization than ferromagnetic materials."},
      {"question": "What are hard and soft magnetic materials?", "options": ["Hard magnetic materials are physically harder than soft materials", "Hard magnetic materials have high coercivity (permanent magnets); soft magnetic materials have low coercivity (easy to magnetize/demagnetize)", "Hard magnetic materials are magnetic at high temperatures", "Soft magnetic materials are not actually magnetic"], "correctAnswer": 1, "explanation": "Hard magnetic materials (hard magnets) have high coercivity (H_c), meaning they resist demagnetization and retain strong magnetic fields - used for permanent magnets. Soft magnetic materials have low coercivity, meaning they are easily magnetized and demagnetized - used for transformer cores, inductors, and AC applications where magnetic domains must reverse rapidly."},
      {"question": "What is the Curie temperature in ferromagnetic materials?", "options": ["The temperature at which a ferromagnetic material becomes paramagnetic (loses spontaneous magnetization)", "The melting point of the material", "The temperature at which magnetization is maximum", "The absolute zero temperature"], "correctAnswer": 0, "explanation": "The Curie temperature (T_C) is the critical temperature above which ferromagnetic materials become paramagnetic, losing their spontaneous magnetization and domain structure. Below T_C, thermal energy is insufficient to disrupt magnetic ordering; above T_C, thermal energy randomizes the magnetic moments."}
    ]',
    3,
    NOW()
  );

  -- Lesson 5.4: Optical Properties
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440504',
    chapter5_id,
    'Optical Properties',
    'optical-properties',
    'Learn about optical properties including refraction, reflection, absorption, and applications.',
    '# Optical Properties

## Introduction
Optical properties describe how materials interact with light (visible spectrum: ~400-700 nm).

## Light-Matter Interactions

**Reflection**: Light bounces off surface
**Refraction**: Light bends entering material
**Absorption**: Light energy absorbed by material
**Transmission**: Light passes through material
**Scattering**: Light redirected by inhomogeneities

## Refractive Index

**Definition**: Ratio of light speed in vacuum to speed in material

$$n = \frac{c}{v}$$

**Snell''s Law**: Refraction at interface
$$n_1 \sin\theta_1 = n_2 \sin\theta_2$$

**Typical values**:
- Air: n ≈ 1.00
- Water: n ≈ 1.33
- Glass: n ≈ 1.5-1.9
- Diamond: n = 2.42

**Dispersion**: n depends on wavelength (prisms, rainbows)

## Absorption

**Beer-Lambert Law**:
$$I = I_0 e^{-\alpha x}$$

where:
- I = transmitted intensity
- I₀ = incident intensity
- α = absorption coefficient
- x = path length

**Color**: Selective absorption
- Material appears color of absorbed wavelengths
- Example: Chlorophyll absorbs red/blue → appears green

## Transparency vs Opacity

**Metals**: Opaque (free electrons reflect light)
**Semiconductors**: Can be transparent if E_g > photon energy
- Si: Opaque (absorbs visible)
- GaP: Transparent (E_g = 2.26 eV, green transmission)

**Ceramics**: Can be transparent if single crystal, pores eliminated
- Sapphire (single crystal Al₂O₃)
- Polycrystalline Al₂O₃: Translucent (scattering at grain boundaries)

## Applications

**Lenses**: Refraction (glasses, cameras)
**Mirrors**: High reflection (metal coatings)
**Windows**: Transparency (glass, polymers)
**Optical fibers**: Total internal reflection (communication)
**Lasers**: Stimulated emission (coherent light)

## Summary
- **Refractive index**: Speed of light in material (Snell''s law)
- **Absorption**: Exponential attenuation (Beer-Lambert law)
- **Color**: Selective absorption of wavelengths
- **Transparency**: Band gap, scattering from defects/grains
- **Metals**: Reflective (free electrons)
- **Applications**: Lenses, mirrors, windows, optical fibers, lasers',
    '[
      {"question": "What does the refractive index of a material represent?", "options": ["The absorption coefficient of the material", "The ratio of light speed in vacuum to light speed in the material (n = c/v)", "The color of the material", "The temperature at which the material becomes transparent"], "correctAnswer": 1, "explanation": "Refractive index (n) is the ratio of the speed of light in vacuum (c) to the speed of light in the material (v): n = c/v. Higher n means light travels more slowly through the material, causing more bending (refraction) at interfaces. This is governed by Snell''s Law: n₁sin(θ₁) = n₂sin(θ₂)."},
      {"question": "Why are metals opaque and reflective while some ceramics are transparent?", "options": ["Metals have lower density than ceramics", "Metals have free electrons that interact with and reflect light; ceramics can be transparent if band gap > photon energy and light-scattering defects are minimized", "Ceramics are always transparent regardless of structure", "Metals are not actually opaque - they transmit light like all materials"], "correctAnswer": 1, "explanation": "Metals are opaque and reflective because free electrons at the Fermi level can absorb and re-emit light, causing reflection. Ceramics can be transparent when: (1) band gap exceeds photon energy (no absorption), (2) material is pore-free (scattering centers eliminated), and (3) often as single crystals to avoid grain boundary scattering."},
      {"question": "How does the Beer-Lambert Law describe light absorption in materials?", "options": ["Absorption increases linearly with distance", "Intensity decreases exponentially with distance: I = I₀e^(-αx)", "Absorption is independent of material thickness", "Light intensity increases as it passes through material"], "correctAnswer": 1, "explanation": "The Beer-Lambert Law describes exponential attenuation of light intensity as it passes through an absorbing material: I = I₀e^(-αx), where I is transmitted intensity, I₀ is incident intensity, α is absorption coefficient, and x is path length. This means each incremental distance absorbs the same fraction of remaining light."}
    ]',
    4,
    NOW()
  );

  -- Lesson 5.5: Nanomaterials
  INSERT INTO lessons (id, chapter_id, title, slug, description, content_markdown, quiz_json, display_order, created_at)
  VALUES (
    '770e8400-e29b-41d4-a716-446655440505',
    chapter5_id,
    'Nanomaterials',
    'nanomaterials',
    'Explore nanomaterials, their unique properties, and applications in electronics, medicine, and energy.',
    '# Nanomaterials

## Introduction
**Nanomaterials** have at least one dimension < 100 nm. At this scale, materials exhibit unique properties different from bulk.

## Why Nano?

**Surface-to-volume ratio**:
- As particle size decreases, surface area/volume ratio increases
- Surface atoms become more significant
- Different chemical reactivity

**Quantum confinement**:
- Particle size comparable to electron wavelength
- Energy levels become discrete (quantum dots)
- Properties become size-dependent

**Classification**:
- **0D**: Quantum dots, nanoparticles (all dimensions < 100 nm)
- **1D**: Nanowires, nanotubes (one dimension > 100 nm)
- **2D**: Graphene, thin films (two dimensions > 100 nm)

## Quantum Dots

**Semiconductor nanoparticles** (2-10 nm)

**Size-dependent properties**:
- Band gap increases with decreasing size
- Color depends on size (same material, different colors)
- Applications: LEDs, displays, biological labeling

**Example**: CdSe quantum dots
- 2 nm: Blue
- 4 nm: Green
- 6 nm: Red

## Carbon Nanotubes

**Structure**: Rolled graphene sheets

**Types**:
- **Single-walled (SWCNT)**: Single graphene cylinder
- **Multi-walled (MWCNT)**: Multiple concentric cylinders

**Properties**:
- **Strength**: ~100× stronger than steel
- **Electrical**: Metallic or semiconducting depending on chirality
- **Thermal**: Very high thermal conductivity

**Applications**:
- Reinforcement in composites
- Electronics (nanowires)
- Energy storage (supercapacitors, batteries)

## Graphene

**Single layer of carbon atoms** in honeycomb lattice

**Properties**:
- **Strongest material** measured
- **Excellent electrical conductivity** (electron mobility)
- **Transparent** (97% light transmission)
- **Flexible**

**Applications**:
- Transparent conductors (touch screens)
- High-frequency electronics
- Composites
- Sensors

## Metallic Nanoparticles

**Gold nanoparticles**:
- Color depends on size (red, purple, blue)
- Surface plasmon resonance
- Applications: Medical diagnostics, therapy, catalysis

**Silver nanoparticles**:
- Antibacterial properties
- Applications: Wound dressings, textiles, coatings

## Synthesis Methods

**Bottom-up**:
- Chemical vapor deposition (CVD)
- Sol-gel processing
- Precipitation

**Top-down**:
- Ball milling
- Lithography
- Etching

## Applications

**Electronics**:
- Transistors (nanowires, graphene)
- Memory (nanoparticles)
- Interconnects (CNTs)

**Energy**:
- Solar cells (quantum dots, nanostructured Si)
- Batteries (nanostructured electrodes)
- Catalysis (high surface area)

**Medicine**:
- Drug delivery (nanoparticles)
- Imaging (quantum dots, gold nanoparticles)
- Therapy (targeted nanoparticles)

**Environment**:
- Water purification (nanofiltration)
- Sensors (nanomaterial-based detection)

## Challenges

**Toxicity**: Some nanomaterials may be harmful
**Manufacturing**: Scalable, consistent production
**Characterization**: Measuring properties at nanoscale
**Cost**: Expensive synthesis methods

## Summary
- **Nanomaterials**: At least one dimension < 100 nm
- **Unique properties**: High surface area, quantum confinement
- **Quantum dots**: Size-dependent optical properties
- **Carbon nanotubes**: Strong, conductive cylinders
- **Graphene**: Single-layer carbon with exceptional properties
- **Applications**: Electronics, energy, medicine, environment
- **Challenges**: Toxicity, manufacturing, characterization, cost',
    '[
      {"question": "Why do quantum dots exhibit different colors depending on their size?", "options": ["Different sized quantum dots are made of different elements", "Quantum confinement causes band gap to increase with decreasing particle size, making emission wavelength size-dependent", "Quantum dots change color randomly without any pattern", "The color is determined by the synthesis method only"], "correctAnswer": 1, "explanation": "Quantum confinement occurs when particle size is comparable to electron wavelength. As size decreases, electrons are confined to smaller volume, energy levels become more discrete, and band gap increases. Since emission energy E = hc/λ, larger band gaps emit shorter wavelengths (blue), smaller particles emit longer wavelengths (red)."},
      {"question": "What makes carbon nanotubes potentially useful for electronics applications?", "options": ["Carbon nanotubes are always electrical insulators", "CNTs can be metallic or semiconducting depending on their chirality (how graphene sheet is rolled), have high mobility and current-carrying capacity", "Carbon nanotubes cannot be integrated into silicon technology", "CNTs are only useful as structural materials"], "correctAnswer": 1, "explanation": "Carbon nanotubes'' electronic properties depend on chirality (the angle at which graphene is rolled). Some chiralities produce metallic nanotubes, others produce semiconducting nanotubes with tunable band gaps. Combined with high electron mobility and current-carrying capacity, this makes CNTs promising for nanoelectronics like transistors and interconnects."},
      {"question": "How does the high surface-to-volume ratio of nanomaterials affect their properties and applications?", "options": ["High surface area makes nanomaterials more stable and less reactive", "High surface-to-volume ratio increases chemical reactivity and makes nanomaterials excellent for catalysis, sensing, and energy storage", "Surface-to-volume ratio has no effect on nanomaterial properties", "Nanomaterials always have lower surface area than bulk materials"], "correctAnswer": 1, "explanation": "As particle size decreases to nanoscale, surface-to-volume ratio increases dramatically (surface atoms become larger fraction of total atoms). Surface atoms have different bonding and higher energy, making nanomaterials more reactive. This enables applications in catalysis (more active sites), sensing (more surface for analyte interaction), and energy storage (more surface for reactions)."}
    ]',
    5,
    NOW()
  );

END $$;

-- Complete Materials Science course
COMMIT;

