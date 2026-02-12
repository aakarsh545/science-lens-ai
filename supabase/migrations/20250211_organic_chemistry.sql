-- =====================================================
-- ORGANIC CHEMISTRY COURSE
-- Topics: Hydrocarbons, Functional Groups, Reaction Mechanisms
-- Difficulty: Advanced
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Organic Chemistry
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Organic Chemistry',
  'organic-chemistry',
  'Study carbon-based compounds: hydrocarbons, functional groups, isomers, naming conventions, and reaction mechanisms. For advanced students who have completed Chemistry Basics.',
  'chemistry',
  'advanced',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: STRUCTURE AND BONDING OF ORGANIC MOLECULES
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Structure and Bonding of Organic Molecules',
  'structure-bonding-organic',
  'Understand how carbon forms four covalent bonds, creating chains, rings, and aromatic systems.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'structure-bonding-organic' LIMIT 1),
  'Introduction to Organic Chemistry',
  'introduction-organic-chemistry',
  1,
  '# Introduction to Organic Chemistry

## What Is Organic Chemistry?

**Organic chemistry** is the study of carbon compounds and their reactions.

**Organic compounds** contain primarily carbon-hydrogen bonds, though they may also contain oxygen, nitrogen, sulfur, halogens, and other elements.

**Importance**:
- **Basis of life**: DNA, proteins, carbohydrates, fats, oils
- **Medicines**: Aspirin, ibuprofen, antibiotics
- **Materials**: Plastics, textiles, dyes, explosives
- **Energy**: Fossil fuels (hydrocarbons)

## Why Carbon?

Carbon''s unique ability to form **four covalent bonds** with itself and other carbon atoms creates the incredible diversity of organic molecules!

$$4 \text{bonds}$$

### Carbon''s Versatility

Carbon forms stable bonds to many elements, creating:
- **Chains** (unbranched or branched)
- **Rings** (cyclic compounds)
- **Branched chains** (with side branches)
- **Aromatic systems** (conjugated ring systems)

### Hybridization

$$\text{C}_n\text{H}_{2n+2}$$

**$sp^2$**: 2 hybridized orbitals (s + p character)
- Allows carbon to form 4 bonds instead of just 3
- Found in: Ethene (C₂H₄), aromatic systems

**$sp^3$**: 3 hybridized orbitals
- Found in: Acetylene (C₂H₂), benzene

This explains why carbon is the foundation of organic chemistry!

## Key Concepts

| Concept | Description |
|----------|-------------|
| Organic chemistry | Study of carbon compounds | Carbon always forms 4 covalent bonds |
| Tetravalence | Carbon forms 4 bonds in most organic compounds | $sp^2$ |
| Hybridization | Mixing s, p, d orbitals | Explains carbon''s versatility |
| Functional groups | Groups of atoms with similar bonding behavior | Determines reactivity |

## Historical Context

**Friedrich Wöhler** (1828): First synthesized urea (organic compound from inorganic precursors)

Proved that "vital force" concept was wrong—organic compounds could be synthesized!

## Sources
- OpenStax Organic Chemistry 1e (2015). "Structure and Bonding"
- Khan Academy: "Organic Chemistry"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the defining characteristic of carbon that allows it to form the basis of organic chemistry?",
      "options": ["Ability to form ionic bonds", "Ability to form hydrogen bonds", "Ability to form four covalent bonds with itself", "Ability to form triple bonds"],
      "correctAnswer": 2,
      "explanation": "Carbon''s defining characteristic is its ability to form FOUR COVALENT BONDS with itself and other carbon atoms (tetravalence = 4). While it can also form double and triple bonds (C=C, C≡C), the four-bond capability ($sp^2$) with hybridized orbitals (mixing s, p, and d orbitals) creates the incredible diversity of organic molecules—chains, rings, and branched structures!"
    },
    {
      "question": "What is hybridization in organic chemistry?",
      "options": ["Mix of s, p, and d orbitals to form 4 bonds instead of 3", "Carbon forming single, double, and triple bonds with itself", "Conversion of sp² to sp³ orbitals"],
      "correctAnswer": 0,
      "explanation": "Hybridization is mixing of s, p, and d atomic orbitals to form hybridized orbitals ($sp^2$, $sp^3$). In $sp^2$ carbon mixes with one s and three p orbitals (tetrahedral geometry) → forms 4 single bonds. In $sp^3$, carbon mixes with two s and one p orbital (trigonal planar) → forms 3 double bonds with one p bond being shorter. This allows carbon to form 4 bonds instead of being limited to just 3!"
    },
    {
      "question": "Why was Friedrich Wöhler''s 1828 synthesis of urea significant?",
      "options": ["First synthesis of a natural product", "First synthesis of a polymer", "First synthesis of a pharmaceutical drug", "Disproved the vitalism theory of organic compounds"],
      "correctAnswer": 3,
      "explanation": "Wöhler synthesized urea (an organic compound) from inorganic precursors (silver cyanate, KCNO). This DISPROVED the \"vitalism\" theory—that organic compounds required a mysterious \"vital force\" from living organisms and could not be synthesized. This marked the birth of organic chemistry as a distinct discipline, proving organic molecules follow the same chemical laws as inorganic compounds!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'structure-bonding-organic' LIMIT 1),
  'Hydrocarbons',
  'hydrocarbons',
  2,
  '# Hydrocarbons

## What Are Hydrocarbons?

**Hydrocarbons**: Organic compounds containing only carbon and hydrogen atoms.

**General formula**: $\text{C}_n\text{H}_{2n+2}$

### Saturated vs. Unsaturated

- **Saturated**: Contains only single bonds (max possible hydrogen atoms)
- **Unsaturated**: Contains one or more double/triple bonds (can add more hydrogen)

### Examples

**Methane**: $\text{CH}_4$
- Saturated (4 single bonds)
- Natural gas, main component of biogas

**Ethene**: $\text{C}_2\text{H}_4$
- Unsaturated (one double bond)
- Plant hormone (ripening control)
- Simplest alkene

**Ethylene**: $\text{C}_2\text{H}_4$
- Unsaturated (two double bonds)
- Ripens fruit
- Used to ripen fruit (premature aging)

**Propane**: $\text{C}_3\text{H}_8$
- Saturated
- LP gas, fuel for heating

**Butene**: $\text{C}_4\text{H}_6$
- Unsaturated (two double bonds)
- Used in lighters

### Degree of Unsaturation

Number of $\pi$ bonds (C=C) that a compound can theoretically add.

For mono-unsaturated compounds (1 double bond):
$$\text{C}_n\text{H}_{2n}$$

Where $n$ = number of degrees of unsaturation (number of $\pi$ bonds).

**Example**:
- Ethene: $\text{C}_2\text{H}_4$ → $n = 1$ (mono-unsaturated)
- Butene: $\text{C}_2\text{H}_4$ → $n = 2$ (1,2-diene)

### Naming Hydrocarbons

**IUPAC nomenclature** (systematic naming):

1. **Identify longest chain** (parent chain)
2. **Number carbons** from the end that chain attaches to (indicating degree of unsaturation)
3. **Add -ane** suffix for single bonds
4. **Add -ene** suffix for double bonds
5. **Add -diene** suffix for two double bonds
6. **Add -triene** suffix for three double bonds

**Numbering**:
- Meth-, eth-, prop-, but-, pent-
- 1, 2, 3, 4, 5, 6, 7, etc.

**Examples**:
- $\text{CH}_4$: Methane
- $\text{C}_2\text{H}_6$: Ethane
- $\text{C}_3\text{H}_8$: Propene
- $\text{C}_4\text{H}_{10}$: Butene

### Cycloalkanes

Saturated or unsaturated hydrocarbons in rings.

**Cyclopropane**: $\text{C}_3\text{H}_6$ (ring)
- $\text{C}_4\text{H}_8$ (ring)
- $\text{C}_5\text{H}_{10}$ (ring)
- $\text{C}_6\text{H}_{12}$ (ring)

### Benzene Derivatives

Alkylbenzenes are benzene rings with substituents.

**Examples**:
- Methylbenzene: Toluene + CH₃- on benzene
- Phenol: Hydroxybenzene (benzene ring with -OH group)

### Uses of Hydrocarbons

- **Fuels**: Propane, butane (heating, cooking gas)
- **Chemical feedstocks**: Ethylene (plant growth hormone)
- **Polymers**: Polyethylene (plastics)
- **Solvents**: Hexane, heptane (industrial processes)

## Key Equations

| Formula | Meaning |
|----------|----------|
| $\text{C}_n\text{H}_{2n+2}$ | General formula for hydrocarbons |
| Degree of unsaturation (n) | Number of $\pi$ bonds that can add |

## Sources
- OpenStax Organic Chemistry 1e (2015). "Structure and Bonding"
- Khan Academy: "Hydrocarbons"
',

  '[
    {
      "question": "What is the general formula for all hydrocarbons?",
      "options": ["CₓH₂ₙ", "CH₄", "CₓH₄", "CₓH₃"],
      "correctAnswer": 0,
      "explanation": "The general formula for all hydrocarbons is CₙH₂ₙ₊₂ₙ (general alkane formula). This reflects that hydrocarbons are saturated compounds containing only single bonds (maximum hydrogen atoms). Examples: methane (CH₄), ethane (C₂H₆), propane (C₃H₈)."
    },
    {
      "question": "What is the difference between a saturated and an unsaturated hydrocarbon?",
      "options": ["Saturated has more hydrogen atoms", "Unsaturated has at least one double bond", "Saturated contains ring structures, unsaturated contains chains", "Saturated is more reactive than unsaturated"],
      "correctAnswer": 1,
      "explanation": "Saturated hydrocarbons contain only single bonds (maximum possible hydrogen atoms for the carbon skeleton). Unsaturated hydrocarbons contain one or more double/triple bonds (C=C, C≡C), allowing them to ADD more hydrogen. The presence of double bonds makes unsaturated compounds more reactive in addition reactions (like bromine addition)!"
    },
    {
      "question": "How many degrees of unsaturation does butene (C₄H₆) have?",
      "options": ["0 (saturated like ethane)", "1 (one double bond)", "2 (two double bonds like butene)", "3 (three double bonds)"],
      "correctAnswer": 1,
      "explanation": "Butene (C₄H₆) has ONE double bond (C=C), so n=1 degree of unsaturation. It has 2 fewer hydrogen atoms than the saturated alkane formula (C₄H₁₀), making it a mono-unsaturated compound (can add 1 mole of bromine). Degree of unsaturation refers to the number of π bonds that a compound can theoretically add!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'structure-bonding-organic' LIMIT 1),
  'Functional Groups',
  'functional-groups',
  3,
  '# Functional Groups

## What Are Functional Groups?

**Functional group**: Specific arrangement of atoms in a molecule that gives it characteristic chemical properties.

**In organic chemistry**, functional groups are based on the heteroatom (non-carbon atom) and its bonding.

### Common Functional Groups

| Group | Formula | Characteristic Reactions | Example |
|-------|---------|------------------------|------------------|
| Hydroxyl (-OH) | R-OH | Substitution: Alcohol → Alkoxide | Ethanol, methanol |
| Carbonyl (C=O) | Addition/oxidation | Ketone + Alcohol → Hemiacetal | Acetone → Ethanol oxidation |
| Carboxyl (-COOH) | Acid/base + esterification | Acid + Alcohol → Ester | Aspirin synthesis |
| Amino (-NH₂) | Amine formation | Aldehyde → Imine → Schiff base | Amino acids |
| Nitro (NO₂) | Reduction to amine | Nitrobenzene → Aniline |

### Hydroxyl Group (-OH)

**Structure**: -OH bonded to carbon chain

**Reactions**:
- Substitution: Replace -OH with another group
- Elimination: Remove -OH and H (dehydration)
- Oxidation: Convert to carbonyl (C=O)

### Examples

**Ethanol** ($\text{C}_2\text{H}_5\text{OH}$):
- Oxidation to ethanal: $\text{CH}_3\text{CHO}$ → $\text{CH}_3\text{COH} + \text{H}_2\text{O}$
- Reduction to ethane: $\text{CH}_3\text{CHO} + \text{H}_2$ → $\text{C}_2\text{H}_5\text{OH} + \text{H}_2\text{O}$

### Carbonyl Group (C=O)

**Structure**: Carbon double-bonded to oxygen

**Reactions**:
- Addition: Grignard reagent adds to carbonyl
- Reduction: Carbonyl reduced to alcohol
- Esterification: Carbonyl + alcohol → ester

**Example**:
Acetone + ethanol → Ethyl acetate + $\text{H}_2\text{O}$

### Amino Group (-NH₂)

**Structure**: -NH₂ bonded to carbon chain (or aromatic ring)

**Ammonia** ($\text{NH}_3$): Simplest amine

**Reactions**:
- Alkylation: Amine + alkyl halide → Substituted amine + HCl (replaced H)
- Reductive amination: Ketone + amine → Imine (replaces =O with H)

**Example**:
Acetone + $\text{NH}_3$ → N-substituted acetone + $\text{H}_2\text{O}$

### Nitro Compounds

**Structure**: -NO₂ bonded to carbon

**Classification**:
- **Nitroalkanes**: C-N single bonds
- **Nitroalkenes**: C=C double bonds
- **Nitroaromatics**: Aromatic rings with -NO₂

**Examples**:
- Nitromethane: $\text{CH}_3\text{NO}_2$
- Nitrobenzene: Benzene ring with -NO₂ group

### Summary

| Functional Group | Characteristic Atom | Priority |
|--------------|------------------|----------|
| Hydroxyl | Oxygen | 1 |
| Carbonyl | Oxygen | 3 |
| Carboxyl | Oxygen | 2 |
| Amino | Nitrogen | 2 |
| Nitro | Nitrogen | 3 |

## Sources
- OpenStax Organic Chemistry 1e (2015). "Functional Groups"
- Khan Academy: "Organic Chemistry"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is a functional group?",
      "options": ["A specific element in a molecule", "A class of structurally similar molecules", "An arrangement of atoms that gives characteristic properties", "A substituent that replaces hydrogen in reactions"],
      "correctAnswer": 2,
      "explanation": "A functional group is a SPECIFIC ELEMENT in a molecule (the heteroatom with its bonding electrons) that gives the entire molecule its characteristic chemical properties. Common organic functional groups are: Hydroxyl (-OH), Carbonyl (C=O), Carboxyl (-COOH), Amino (-NH₂), and Nitro (-NO₂). Each group undergoes characteristic reactions: substitution, elimination, addition/oxidation, etc. The functional group DETERMINES the molecule''s reactivity!"
    },
    {
      "question": "What is the oxidation product of a primary alcohol (ethanol)?",
      "options": ["Ethanal (acetaldehyde)", "Acetic acid (ethanoic acid)", "Ethyl acetate", "Ethane (ethane)"],
      "correctAnswer": 2,
      "explanation": "Ethanol (CH₃CH₂OH) is oxidized to ethanal (CH₃CHO) then to acetic acid (CH₃COOH) or further to ethyl acetate (CH₃COOCH₃). Oxidation: -[H] represents loss of electrons, [O] represents gain. In ethanol oxidation: C₂H₅OH (oxidized to C₂H₄O) becomes C₂H₄O (reduced) + CH₃CO (oxidized) → CH₃COOH. Note that different products form depending on oxidation conditions!"
    },
    {
      "question": "What type of reaction is: RCHO + NH₃ → imine?",
      "options": ["Substitution reaction", "Elimination reaction", "Addition reaction", "Reductive amination"],
      "correctAnswer": 3,
      "explanation": "This is REDUCTIVE AMINATION of a ketone (R) with ammonia (NH₃). The amine nitrogen NUCLEOPHILES the carbonyl carbon (C=O), removing the oxygen and replacing it. This forms an imine (R-NH-R) where the nitrogen is bonded to the former carbonyl carbon. Reductive amination is a two-step process: formation of imine in a separate step, then addition of that imine to the carbonyl carbon!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'structure-bonding-organic' LIMIT 1),
  'Isomers',
  'isomers',
  4,
  '# Isomers

## What Are Isomers?

**Isomers**: Compounds with **same molecular formula** but **different structural arrangements**.

### Types of Isomerism

### Constitutional Isomers

**Same connectivity**, different arrangement of atoms.

**Example**: Butane and isobutane

```
Butane:           Isobutane:
    CH₃-CH₂-CH₂-CH₃
         |
     CH₃-CH-CH₃
    (linear alkane)

Isobutane:
    CH₃-CH₂-CH₂-CH₃
        |
     CH₃-CH-CH₃
    (branched alkane)
```

**Constitutional isomers** require breaking a bond (requires energy).

### Stereoisomers

**Same connectivity**, different 3D arrangement in space.

### Enantiomers

**Non-superimposable mirror images** (left-handed vs right-handed).

**Example**: (R)- and (S)-lactic acid

### Cis-Trans Isomers

Similar functional groups on OPPOSITE sides of double bond or ring.

**Example**: Maleic acid and fumaric acid

### Structural Isomers

Same molecular formula, different connectivity due to ring size.

## Sources
- Khan Academy: "Stereochemistry"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What is the difference between constitutional isomers and stereoisomers?",
      "options": ["Constitutional isomers differ in 3D arrangement, stereoisomers are mirror images", "Constitutional isomers have different connectivity of bonds, stereoisomers have same connectivity", "Constitutional isomers require rotation around single bonds, stereoisomers don''t"],
      "correctAnswer": 0,
      "explanation": "Constitutional isomers have the SAME molecular formula and SAME connectivity of atoms (bonding), but atoms are arranged differently in 3D space. To convert between constitutional isomers requires breaking and reforming a bond (high energy). Stereoisomers are NON-SUPERIMPOSABLE mirror images with same connectivity—they differ only in the spatial arrangement of atoms in 3D!"
    },
    {
      "question": "Which pair represents enantiomers?",
      "options": ["(R)- and (S)-lactic acid", "(R)-glyceraldehyde and (S)-glyceraldehyde", "R)-2-butanol and S-2-butanol", "(R)-alanine and (S)-alanine"],
      "correctAnswer": 0,
      "explanation": "(R)- and (S)-lactic acid are ENANTIOMERS—non-superimposable mirror images. They have the same molecular formula and connectivity but are arranged as mirror images (like left and right hands). In Fischer projections, the horizontal bonds are shown as wedges (solid or dashed) to indicate 3D orientation. Enantiomers have identical physical properties except for their interaction with polarized light (they rotate plane of polarized light in opposite directions)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'structure-bonding-organic' LIMIT 1),
  'Alkanes, Cycloalkanes, and Alkenes',
  'alkanes-cycloalkanes-alkenes',
  5,
  '# Alkanes, Cycloalkanes, and Alkenes

## What Are Alkanes?

**Alkanes**: Saturated hydrocarbons with only single bonds.

**General formula**: $\text{C}_n\text{H}_{2n+2}$

**Naming**:
- **-ane** suffix: indicates single bonds only
- **Methane**: $\text{CH}_4$
- **Ethane**: $\text{C}_2\text{H}_6$
- **Propane**: $\text{C}_3\text{H}_8$
- **Butane**: $\text{C}_4\text{H}_{10}$

## Structural Isomers

**Straight-chain**: No branching
- **Branched**: With branching

### Cycloalkanes

One or more rings in the carbon chain.

**Examples**:
- **Cyclopropane**: 3-membered ring
- **Cyclohexane**: 6-membered ring
- **Cycloheptane**: 7-membered ring

### Alkenes

**General formula**: $\text{C}_n\text{H}_{2n}$

Contain at least one double bond (C=C).

**Naming**: Replace -ane with -ene

**Examples**:
- **Ethene** ($\text{C}_2\text{H}_4$): Simplest alkene
- **Propene** ($\text{C}_3\text{H}_6$): Smaller alkene
- **Butene** ($\text{C}_4\text{H}_8$): Larger alkene

### Structural Isomers

Same formula, different arrangement (branching position).

**Example**: Butane and isobutane

### Sources
- Khan Academy: "Alkanes, Cycloalkanes, and Alkenes"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What is the general formula for all alkanes?",
      "options": ["CₙH₃₊", "CₙH₄₊", "CₙH₅₊", "CₙH₂ₙ₊"],
      "correctAnswer": 0,
      "explanation": "The general formula for alkanes (saturated hydrocarbons with only single bonds) is CₙH₂ₙ₊₊, where n = 2n+2 (methane: CH₄ = 1, ethane: C₂H₆ = 3, propane: C₃H₈ = 4, etc.). This reflects that each carbon is bonded to 2 hydrogen atoms, and the chain ends with a -CH₃ group (methyl group). Alkanes are acyclic (no rings) and can be straight-chain or branched!"
    },
    {
      "question": "What is the difference between an alkene and an alkane?",
      "options": ["Alkanes have only single bonds, alkenes have at least one double bond", "Alkanes are saturated, alkenes are unsaturated", "Alkenes contain -ene suffix, alkanes contain -ane suffix"],
      "correctAnswer": 1,
      "explanation": "Alkenes contain at least one C=C double bond and are therefore UNSATURATED (can add more hydrogen). Alkanes contain only single C-C bonds and are SATURATED. The suffix -ene indicates the presence of a double bond. Alkanes have -ane suffix, alkenes have -ene suffix!"
    },
    {
      "question": "What type of isomers do butane and isobutane represent?",
      "options": ["Constitutional isomers", "Stereoisomers", "Enantiomers", "Geometric isomers", "Cis-trans isomers"],
      "correctAnswer": 0,
      "explanation": "Butane (straight chain) and isobutane (branched at C2) are CONSTITUTIONAL ISOMERS. They have the same molecular formula (C₄H₁₀) but different 3D arrangement due to branching at the second carbon. The carbon skeleton is identical, but butane has a linear CH₃-CH₃ chain while isobutane has a CH(CH₃)-CH₃ branch at C2. No bonds are broken—the isomerism is purely due to different spatial arrangement!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: HYDROCARBONS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Hydrocarbons',
  'hydrocarbons',
  'Study alkanes, alkenes, alkynes, and aromatic hydrocarbons - the foundation of organic chemistry.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'hydrocarbons' LIMIT 1),
  'Alkanes and Cycloalkanes',
  'alkanes-cycloalkanes',
  1,
  '# Alkanes and Cycloalkanes

## What Are Alkanes?

**Alkanes**: Saturated hydrocarbons containing only single C-C bonds.

**General formula**: $\text{C}_n\text{H}_{2n+2}$

### Naming Alkanes

**IUPAC nomenclature**:
1. Find the longest continuous carbon chain (parent chain)
2. Number the chain from the end nearest the first substituent
3. Name substituents and assign their positions
4. List substituents in alphabetical order

**Parent chain names**:
- Meth- (1 carbon)
- Eth- (2 carbons)
- Prop- (3 carbons)
- But- (4 carbons)
- Pent- (5 carbons)
- Hex- (6 carbons)
- Hept- (7 carbons)
- Oct- (8 carbons)

**Examples**:
- $\text{CH}_4$: Methane
- $\text{C}_2\text{H}_6$: Ethane
- $\text{C}_3\text{H}_8$: Propane
- $\text{C}_4\text{H}_{10}$: Butane
- $\text{C}_5\text{H}_{12}$: Pentane

### Structural Isomers

**Constitutional isomers**: Same molecular formula, different bonding arrangements.

**Example**: Pentane has 3 isomers:
1. **n-pentane** (straight chain)
2. **isopentane** (2-methylbutane)
3. **neopentane** (2,2-dimethylpropane)

### Cycloalkanes

**Cycloalkanes**: Saturated hydrocarbons with rings.

**General formula**: $\text{C}_n\text{H}_{2n}$

**Naming**: Add "cyclo-" prefix

**Examples**:
- Cyclopropane ($\text{C}_3\text{H}_6$)
- Cyclobutane ($\text{C}_4\text{H}_8$)
- Cyclopentane ($\text{C}_5\text{H}_{10}$)
- Cyclohexane ($\text{C}_6\text{H}_{12}$)

### Ring Strain

**Angle strain**: Deviation from ideal tetrahedral angle (109.5°)

**Stability**: Cyclohexane > cyclopentane > cyclobutane > cyclopropane

## Sources
- OpenStax Organic Chemistry 1e (2015). "Alkanes and Cycloalkanes"
- Khan Academy: "Alkanes and Cycloalkanes"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the general formula for alkanes?",
      "options": ["CₙH₂ₙ₊₂", "CₙH₂ₙ", "CₙH₂ₙ₋₂", "CₙH₂ₙ₊₁"],
      "correctAnswer": 0,
      "explanation": "The general formula for alkanes (saturated hydrocarbons) is CₙH₂ₙ₊₂. This formula reflects that each carbon forms 4 single bonds, with maximum hydrogen atoms. For example: methane (CH₄), ethane (C₂H₆), propane (C₃H₈)."
    },
    {
      "question": "How is cyclopentane named differently from pentane?",
      "options": ["Cyclopentane has 5 fewer hydrogen atoms", "Cyclopentane contains a ring structure", "Cyclopentane is an unsaturated hydrocarbon", "Cyclopentane has double bonds"],
      "correctAnswer": 1,
      "explanation": "Cyclopentane contains a ring (cyclic) structure, indicated by the 'cyclo-' prefix. While both have 5 carbons, cyclopentane (C₅H₁₀) has 2 fewer hydrogens than pentane (C₅H₁₂) because the ring formation eliminates two terminal hydrogens. Both are saturated with only single bonds!"
    },
    {
      "question": "Which cycloalkane has the greatest ring strain?",
      "options": ["Cyclohexane", "Cyclopentane", "Cyclobutane", "Cyclopropane"],
      "correctAnswer": 3,
      "explanation": "Cyclopropane has the GREATEST ring strain because its 60° bond angles deviate significantly from the ideal tetrahedral angle (109.5°). Ring strain decreases with ring size: cyclopropane (most strained) > cyclobutane > cyclopentane > cyclohexane (least strained, chair conformation with perfect tetrahedral angles)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'hydrocarbons' LIMIT 1),
  'Alkenes and Alkynes',
  'alkenes-alkynes',
  2,
  '# Alkenes and Alkynes

## What Are Alkenes?

**Alkenes**: Unsaturated hydrocarbons containing at least one C=C double bond.

**General formula**: $\text{C}_n\text{H}_{2n}$

### Naming Alkenes

**IUPAC rules**:
1. Find longest chain containing the double bond
2. Number from end nearest the double bond
3. Name the parent chain with "-ene" suffix
4. Indicate double bond position with the lower-numbered carbon

**Examples**:
- Ethene ($\text{C}_2\text{H}_4$): Simplest alkene
- Propene ($\text{C}_3\text{H}_6$)
- 1-Butene ($\text{C}_4\text{H}_8$)
- 2-Butene ($\text{C}_4\text{H}_8$)

### Cis-Trans Isomerism

**Cis isomer**: Similar groups on SAME side of double bond

**Trans isomer**: Similar groups on OPPOSITE sides of double bond

**Example**: 2-Butene
- **cis-2-butene**: CH₃ groups on same side
- **trans-2-butene**: CH₃ groups on opposite sides

### E-Z Notation

**Priority rules (Cahn-Ingold-Prelog)**:
1. Higher atomic number = higher priority
2. If tied, look at next atom in chain
3. Double bonds count as two single bonds

**E** (Entgegen): High priority groups on OPPOSITE sides
**Z** (Zusammen): High priority groups on SAME side

## What Are Alkynes?

**Alkynes**: Unsaturated hydrocarbons containing at least one C≡C triple bond.

**General formula**: $\text{C}_n\text{H}_{2n-2}$

**Naming**: Replace "-ane" with "-yne"

**Examples**:
- Ethyne ($\text{C}_2\text{H}_2$): Also called acetylene
- Propyne ($\text{C}_3\text{H}_4$)
- 1-Butyne ($\text{C}_4\text{H}_6$)

## Sources
- OpenStax Organic Chemistry 1e (2015). "Alkenes and Alkynes"
- Khan Academy: "Alkenes and Alkynes"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the general formula for alkenes?",
      "options": ["CₙH₂ₙ₊₂", "CₙH₂ₙ", "CₙH₂ₙ₋₂", "CₙH₂"],
      "correctAnswer": 1,
      "explanation": "The general formula for alkenes (hydrocarbons with one C=C double bond) is CₙH₂ₙ. Each double bond reduces the hydrogen count by 2 compared to alkanes (CₙH₂ₙ₊₂). For example: ethene (C₂H₄), propene (C₃H₆)."
    },
    {
      "question": "What is the difference between cis and trans isomers?",
      "options": ["Cis has higher molecular weight", "Cis has similar groups on same side of double bond", "Trans has similar groups on same side", "There is no difference"],
      "correctAnswer": 1,
      "explanation": "In cis-trans isomerism, CIS isomers have similar groups on the SAME side of the double bond, while TRANS isomers have similar groups on OPPOSITE sides. This type of stereoisomerism occurs because double bonds cannot rotate (unlike single bonds), creating distinct spatial arrangements with different physical properties!"
    },
    {
      "question": "What is the general formula for alkynes?",
      "options": ["CₙH₂ₙ₊₂", "CₙH₂ₙ", "CₙH₂ₙ₋₂", "CₙH₂"],
      "correctAnswer": 2,
      "explanation": "The general formula for alkynes (hydrocarbons with one C≡C triple bond) is CₙH₂ₙ₋₂. Each triple bond reduces the hydrogen count by 4 compared to alkanes (or by 2 compared to alkenes). For example: ethyne/acetylene (C₂H₂), propyne (C₃H₄). Triple bonds contain one sigma and two pi bonds!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'hydrocarbons' LIMIT 1),
  'Aromatic Hydrocarbons',
  'aromatic-hydrocarbons',
  3,
  '# Aromatic Hydrocarbons

## What Is Aromaticity?

**Aromatic compound**: Cyclic, planar molecule with (4n+2) π electrons in a continuous, overlapping p-orbital system.

**Benzene** ($\text{C}_6\text{H}_6$): The prototypical aromatic compound.

### Huckel''s Rule

**Aromatic compounds** have $(4n + 2)$ π electrons where $n$ = 0, 1, 2, 3...

**Examples**:
- Benzene: 6 π electrons ($4n + 2$ where $n = 1$)
- Naphthalene: 10 π electrons ($4n + 2$ where $n = 2$)
- Cyclopentadienyl anion: 6 π electrons

### Benzene Structure

**Resonance structures**: Two equivalent Kekulé structures

**Actual structure**: Delocalized π electron cloud above and below the ring

**Bond length**: All C-C bonds equal (139 pm) - between single (154 pm) and double (134 pm)

### Nomenclature

**Monosubstituted benzene**:
- Methylbenzene = Toluene
- Hydroxybenzene = Phenol
- Aminobenzene = Aniline
- Nitrobenzene

**Disubstituted benzene**:
- **ortho** (o-): 1,2- positions
- **meta** (m-): 1,3- positions
- **para** (p-): 1,4- positions

### Polycyclic Aromatic Hydrocarbons (PAHs)

**Naphthalene** ($\text{C}_{10}\text{H}_8$): Two fused benzene rings
**Anthracene** ($\text{C}_{14}\text{H}_{10}$): Three linearly fused benzene rings
**Phenanthrene** ($\text{C}_{14}\text{H}_{10}$): Three angularly fused benzene rings

## Electrophilic Aromatic Substitution

**General mechanism**:
1. Electrophile attacks benzene ring (slow step)
2. Formation of arenium ion intermediate
3. Deprotonation restores aromaticity

## Sources
- OpenStax Organic Chemistry 1e (2015). "Aromatic Compounds"
- Khan Academy: "Aromatic Compounds"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is Huckel''s rule for aromaticity?",
      "options": ["4n π electrons", "4n+2 π electrons", "6 π electrons only", "8 π electrons"],
      "correctAnswer": 1,
      "explanation": "Huckel''s rule states that aromatic compounds must have (4n+2) π electrons in a continuous, cyclic, planar system of overlapping p-orbitals, where n = 0, 1, 2, 3... For example: benzene has 6 π electrons (4n+2 where n=1), naphthalene has 10 π electrons (4n+2 where n=2). Compounds with 4n π electrons are antiaromatic (unstable)!"
    },
    {
      "question": "What describes the actual structure of benzene?",
      "options": ["Alternating single and double bonds", "Delocalized π electron cloud above and below ring", "Three double bonds and three single bonds", "Only single bonds"],
      "correctAnswer": 1,
      "explanation": "The actual structure of benzene is a DELocalized π electron cloud above and below the ring. While we draw two Kekulé resonance structures (alternating double bonds), reality is that all 6 π electrons are equally shared among all 6 carbons, making all C-C bonds identical (139 pm - between single 154 pm and double 134 pm bond lengths). This delocalization provides aromatic stability!"
    },
    {
      "question": "What does the prefix \"ortho-\" indicate in disubstituted benzene naming?",
      "options": ["1,2- positions (adjacent)", "1,3- positions", "1,4- positions (opposite)", "Random substitution"],
      "correctAnswer": 0,
      "explanation": "Ortho- (o-) indicates 1,2- positions (adjacent carbons) on a benzene ring. The other positional prefixes are: meta- (m-) for 1,3- positions (one carbon between), and para- (p-) for 1,4- positions (opposite sides of ring). These Greek prefixes describe the relative positions of substituents on disubstituted benzene derivatives!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'hydrocarbons' LIMIT 1),
  'Reactions of Hydrocarbons',
  'reactions-hydrocarbons',
  4,
  '# Reactions of Hydrocarbons

## Alkane Reactions

**Combustion**:
$$\text{C}_n\text{H}_{2n+2} + \frac{3n+1}{2}\text{O}_2 \rightarrow n\text{CO}_2 + (n+1)\text{H}_2\text{O}$$

**Complete combustion**: Produces $\text{CO}_2$ and $\text{H}_2\text{O}$
**Incomplete combustion**: Produces CO and C (soot)

**Halogenation** (radical substitution):
$$\text{CH}_4 + \text{Cl}_2 \xrightarrow{\text{heat or light}} \text{CH}_3\text{Cl} + \text{HCl}$$

**Mechanism**: Radical chain reaction
1. **Initiation**: $\text{Cl}_2 \rightarrow 2\text{Cl}•$ (homolysis)
2. **Propagation**: $\text{Cl}• + \text{CH}_4 \rightarrow \text{HCl} + \text{CH}_3•$
3. **Propagation**: $\text{CH}_3• + \text{Cl}_2 \rightarrow \text{CH}_3\text{Cl} + \text{Cl}•$
4. **Termination**: Radical combinations

## Alkene Reactions

**Electrophilic Addition**:
$$\text{CH}_2=\text{CH}_2 + \text{HBr} \rightarrow \text{CH}_3\text{CH}_2\text{Br}$$

**Markovnikov''s Rule**: In addition of HX to alkene, hydrogen adds to carbon with MORE hydrogens already attached.

**Anti-Markovnikov** (peroxide effect):
$$\text{CH}_2=\text{CH}_2 + \text{HBr} \xrightarrow{\text{ROOR}} \text{BrCH}_2\text{CH}_3$$

**Other additions**:
- **Halogen addition**: $\text{CH}_2=\text{CH}_2 + \text{Br}_2 \rightarrow \text{BrCH}_2\text{CH}_2\text{Br}$
- **Hydration**: $\text{CH}_2=\text{CH}_2 + \text{H}_2\text{O} \xrightarrow{\text{H}^+} \text{CH}_3\text{CH}_2\text{OH}$
- **Hydrogenation**: $\text{CH}_2=\text{CH}_2 + \text{H}_2 \xrightarrow{\text{Pd}} \text{CH}_3\text{CH}_3$

**Polymerization**:
$$n\,\text{CH}_2=\text{CH}_2 \rightarrow (-\text{CH}_2-\text{CH}_2-)_n$$

## Alkyne Reactions

Similar to alkenes but can add TWO equivalents of reagent.

**Example**:
$$\text{HC}\equiv\text{CH} + 2\text{Br}_2 \rightarrow \text{Br}_2\text{CH}-\text{CHBr}_2$$

## Aromatic Reactions

**Electrophilic Aromatic Substitution** (EAS):

1. **Nitration**: $\text{C}_6\text{H}_6 + \text{HNO}_3 \xrightarrow{\text{H}_2\text{SO}_4} \text{C}_6\text{H}_5\text{NO}_2$
2. **Sulfonation**: $\text{C}_6\text{H}_6 + \text{H}_2\text{SO}_4 \rightarrow \text{C}_6\text{H}_5\text{SO}_3\text{H}$
3. **Halogenation**: $\text{C}_6\text{H}_6 + \text{Br}_2 \xrightarrow{\text{FeBr}_3} \text{C}_6\text{H}_5\text{Br}$

## Sources
- OpenStax Organic Chemistry 1e (2015). "Reactions of Hydrocarbons"
- Khan Academy: "Alkene Reactions"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is Markovnikov''s rule for alkene reactions?",
      "options": ["Hydrogen adds to carbon with more hydrogens", "Hydrogen adds to carbon with fewer hydrogens", "Bromine always adds to terminal carbon", "Reaction proceeds via carbocation intermediate"],
      "correctAnswer": 0,
      "explanation": "Markovnikov''s rule states that in addition of HX (H-Cl, H-Br) to an unsymmetrical alkene, the HYDROGEN adds to the carbon that already has MORE hydrogens attached, while the halogen (X) adds to the carbon with fewer hydrogens. This occurs because the more stable carbocation intermediate forms (tertiary > secondary > primary) on the more substituted carbon!"
    },
    {
      "question": "What type of mechanism is halogenation of alkanes?",
      "options": ["Electrophilic addition", "Radical chain reaction", "Nucleophilic substitution", "Elimination"],
      "correctAnswer": 1,
      "explanation": "Halogenation of alkanes proceeds via a RADICAL CHAIN REACTION mechanism initiated by heat or UV light. The mechanism has three stages: 1) INITIATION - homolysis of Cl₂ to form two Cl• radicals, 2) PROPAGATION - Cl• abstracts H from methane forming HCl and CH₃• radical, then CH₃• reacts with Cl₂ forming product and another Cl•, 3) TERMINATION - radicals combine ending the chain!"
    },
    {
      "question": "Why are electrophilic aromatic substitution reactions different from alkene additions?",
      "options": ["Aromatics are less reactive", "Aromatics would lose stability if they underwent addition", "Aromatics only react with strong acids", "Aromatics require nucleophiles not electrophiles"],
      "correctAnswer": 1,
      "explanation": "Aromatic compounds undergo SUBSTITUTION not ADDITION because addition would destroy the aromatic π system and its special stability. In electrophilic aromatic substitution, the electrophile adds temporarily forming an arenium ion intermediate, but then a proton is LOST (deprotonation) restoring aromaticity. This preserves the aromatic stability that provides benzene with its special thermodynamic stability!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 3: FUNCTIONAL GROUPS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Functional Groups',
  'functional-groups',
  'Master the identification, properties, and reactions of organic functional groups including alcohols, carbonyls, and amines.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 3
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'functional-groups' LIMIT 1),
  'Alcohols, Ethers, and Phenols',
  'alcohols-ethers-phenols',
  1,
  '# Alcohols, Ethers, and Phenols

## Alcohols

**Alcohol**: Organic compound containing hydroxyl (-OH) group bonded to saturated carbon.

**General formula**: R-OH

**Classification**:
- **Primary** (1°): -OH on carbon attached to ONE other carbon
- **Secondary** (2°): -OH on carbon attached to TWO other carbons
- **Tertiary** (3°): -OH on carbon attached to THREE other carbons

**Naming**: Replace -e with -ol

**Examples**:
- Methanol ($\text{CH}_3\text{OH}$)
- Ethanol ($\text{C}_2\text{H}_5\text{OH}$)
- 2-Propanol (isopropyl alcohol)

### Alcohol Reactions

**Oxidation**:
- **Primary alcohol** → Aldehyde → Carboxylic acid
- **Secondary alcohol** → Ketone
- **Tertiary alcohol** → No oxidation (no H on C-OH carbon)

**Dehydration** (elimination):
$$\text{CH}_3\text{CH}_2\text{OH} \xrightarrow{\text{H}_2\text{SO}_4, \text{heat}} \text{CH}_2=\text{CH}_2 + \text{H}_2\text{O}$$

**Substitution**:
$$\text{ROH} + \text{HX} \rightarrow \text{RX} + \text{H}_2\text{O}$$

## Ethers

**Ether**: Organic compound with oxygen bonded to TWO alkyl groups.

**General formula**: R-O-R'' (symmetrical) or R-O-R'' (unsymmetrical)

**Naming**: Alkoxyalkane (alkyl + alk-oxy + parent chain)

**Examples**:
- Dimethyl ether ($\text{CH}_3\text{OCH}_3$)
- Diethyl ether ($\text{C}_2\text{H}_5\text{OC}_2\text{H}_5$)
- Methyl ethyl ether

### Ether Synthesis

**Williamson ether synthesis**:
$$\text{RO}^- + \text{R''X} \rightarrow \text{ROR''} + \text{X}^-$$

**Acid-catalyzed dehydration**:
$$2\text{ROH} \xrightarrow{\text{H}^+} \text{ROR} + \text{H}_2\text{O}$$

## Phenols

**Phenol**: Hydroxyl group (-OH) directly attached to benzene ring.

**Structure**: $\text{C}_6\text{H}_5\text{OH}$

### Phenol Reactions

**Acidity**: Phenols are more acidic than alcohols (pKa ~10 vs pKa ~16-18)

**Electrophilic aromatic substitution**: -OH is ortho/para director

**Oxidation**: Phenols easily oxidized to quinones

## Sources
- OpenStax Organic Chemistry 1e (2015). "Alcohols, Ethers, and Phenols"
- Khan Academy: "Alcohols and Ethers"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What classifies an alcohol as primary, secondary, or tertiary?",
      "options": ["Number of carbon atoms in molecule", "Number of carbons attached to C-OH carbon", "Number of -OH groups", "Molecular weight"],
      "correctAnswer": 1,
      "explanation": "Alcohols are classified by how many OTHER CARBON ATOMS are attached to the carbon bearing the -OH group. Primary (1°): carbon attached to ONE other carbon; Secondary (2°): attached to TWO other carbons; Tertiary (3°): attached to THREE other carbons. This classification determines reactivity - primary oxidize to aldehydes, secondary to ketones, tertiary cannot oxidize!"
    },
    {
      "question": "Why are phenols more acidic than alcohols?",
      "options": ["Phenols have more -OH groups", "Phenoxide ion is resonance-stabilized by benzene ring", "Phenols have higher molecular weight", "Phenols contain nitrogen"],
      "correctAnswer": 1,
      "explanation": "Phenols are more acidic (pKa ~10) than alcohols (pKa ~16-18) because the phenoxide anion formed after losing H+ is RESONANCE-STABILIZED by the benzene ring. The negative charge delocalizes into the aromatic π system over multiple positions, making the conjugate base much more stable than alkoxide ions which have no resonance stabilization!"
    },
    {
      "question": "What is the Williamson ether synthesis?",
      "options": ["Acid-catalyzed dehydration of two alcohols", "Reaction of alkoxide ion with primary alkyl halide", "Addition of alcohol to alkene", "Reduction of ester with alcohol"],
      "correctAnswer": 1,
      "explanation": "Williamson ether synthesis is an SN2 reaction between an alkoxide ion (RO⁻) and a PRIMARY alkyl halide (R''X) to form an ether (ROR''). The mechanism is: 1) Deprotonate alcohol with strong base (NaH, Na) forming alkoxide, 2) Alkoxide attacks primary alkyl halide in SN2 reaction, 3) Ether product forms. Works best with primary halides to avoid E2 elimination!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'functional-groups' LIMIT 1),
  'Aldehydes and Ketones',
  'aldehydes-ketones',
  2,
  '# Aldehydes and Ketones

## Carbonyl Group

**Carbonyl group**: C=O double bond

**Polar**: Oxygen is more electronegative, creating dipole

## Aldehydes

**Aldehyde**: Carbonyl group at END of carbon chain (bonded to at least ONE hydrogen).

**General formula**: R-CHO (where R can be H)

**Naming**: Replace -e with -al

**Examples**:
- Formaldehyde (HCHO)
- Acetaldehyde ($\text{CH}_3\text{CHO}$)
- Benzaldehyde ($\text{C}_6\text{H}_5\text{CHO}$)

## Ketones

**Ketone**: Carbonyl group in MIDDLE of carbon chain (bonded to TWO carbons).

**General formula**: R-CO-R'' (where R and R'' are alkyl groups)

**Naming**: Replace -e with -one

**Examples**:
- Acetone/propanone ($\text{CH}_3\text{COCH}_3$)
- Butanone ($\text{CH}_3\text{COCH}_2\text{CH}_3$)

### Physical Properties

**Boiling points**: Higher than hydrocarbons (dipole-dipole interactions)

**Solubility**: Lower carbonyls (C1-C4) soluble in water (H-bonding)

## Reactions of Aldehydes and Ketones

### Nucleophilic Addition

**General mechanism**:
1. Nucleophile attacks electrophilic carbonyl carbon
2. Tetrahedral intermediate forms
3. Proton transfer gives product

**Examples**:

**Grignard addition**:
$$\text{RCHO} + \text{R''MgX} \rightarrow \text{RR''COH}$$

**Hydration**:
$$\text{RCHO} + \text{H}_2\text{O} \rightleftharpoons \text{RCH(OH)}_2$$

**Alcohol addition** (hemiacetal/acetal formation):
$$\text{RCHO} + \text{R''OH} \rightarrow \text{RCH(OH)OR''} \rightarrow \text{RCH(OR'')}_2$$

### Oxidation-Reduction

**Aldehyde oxidation**:
$$\text{RCHO} + [\text{O}] \rightarrow \text{RCOOH}$$

**Aldehyde reduction**:
$$\text{RCHO} + \text{NaBH}_4 \rightarrow \text{RCH}_2\text{OH}$$

**Ketone reduction**:
$$\text{R}_2\text{CO} + \text{NaBH}_4 \rightarrow \text{R}_2\text{CHOH}$$

### Condensation Reactions

**Aldol condensation**:
$$2\text{CH}_3\text{CHO} \xrightarrow{\text{OH}^-} \text{CH}_3\text{CH(OH)CH}_2\text{CHO}$$

## Sources
- OpenStax Organic Chemistry 1e (2015). "Aldehydes and Ketones"
- Khan Academy: "Aldehydes and Ketones"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the structural difference between an aldehyde and a ketone?",
      "options": ["Aldehydes have higher molecular weight", "Aldehyde carbonyl is at chain end (bonded to H), ketone is internal (bonded to two C)", "Ketones contain nitrogen", "Aldehydes have two carbonyl groups"],
      "correctAnswer": 1,
      "explanation": "Aldehydes have the carbonyl group (C=O) at the END of the carbon chain, bonded to at least ONE hydrogen atom (R-CHO where R can be H). Ketones have the carbonyl in the MIDDLE of the chain, bonded to TWO carbon atoms (R-CO-R''). This structural difference affects reactivity - aldehydes are more easily oxidized to carboxylic acids because they have a hydrogen on the carbonyl carbon!"
    },
    {
      "question": "What type of reaction is the addition of a Grignard reagent to a carbonyl?",
      "options": ["Elimination reaction", "Nucleophilic addition", "Electrophilic aromatic substitution", "Radical substitution"],
      "correctAnswer": 1,
      "explanation": "Grignard reagents (R-MgX) are strong NUCLEOPHILES that add to the electrophilic carbonyl carbon (C=O). The mechanism: 1) Nucleophilic attack of R- on carbonyl carbon forms tetrahedral alkoxide intermediate, 2) Protonation (with H₃O⁺) gives alcohol product. Grignard addition converts aldehydes to secondary alcohols and ketones to tertiary alcohols!"
    },
    {
      "question": "Why are lower aldehydes and ketones (C1-C4) soluble in water?",
      "options": ["They have low molecular weight", "They can form hydrogen bonds with water", "They are ionic compounds", "They contain oxygen"],
      "correctAnswer": 1,
      "explanation": "Lower molecular weight aldehydes and ketones (C1-C4) are water-soluble because they can form HYDROGEN BONDS with water molecules. The carbonyl oxygen acts as H-bond acceptor from water's hydrogen atoms. As carbon chain length increases (C5+), the hydrophobic alkyl portion dominates and solubility decreases dramatically!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'functional-groups' LIMIT 1),
  'Carboxylic Acids and Derivatives',
  'carboxylic-acids-derivatives',
  3,
  '# Carboxylic Acids and Derivatives

## Carboxylic Acids

**Carboxylic acid**: Contains carboxyl group (-COOH)

**General formula**: R-COOH

**Naming**: Replace -e with -oic acid

**Examples**:
- Formic acid (HCOOH)
- Acetic acid ($\text{CH}_3\text{COOH}$)
- Benzoic acid ($\text{C}_6\text{H}_5\text{COOH}$)

### Acidity

**pKa**: Typically 4-5 (much more acidic than alcohols)

**Resonance stabilization**: Negative charge delocalized over TWO oxygens

### Carboxylic Acid Reactions

**Acid-base reactions**:
$$\text{RCOOH} + \text{NaOH} \rightarrow \text{RCOONa} + \text{H}_2\text{O}$$

**Esterification** (Fischer esterification):
$$\text{RCOOH} + \text{R''OH} \xrightarrow{\text{H}^+} \text{RCOOR''} + \text{H}_2\text{O}$$

**Reduction**:
$$\text{RCOOH} \xrightarrow{\text{LiAlH}_4} \text{RCH}_2\text{OH}$$

## Carboxylic Acid Derivatives

### Esters

**Ester**: RCOOR'' (alkyl group replaces -H of acid)

**Naming**: Alkyl alkanoate

**Examples**:
- Methyl ethanoate ($\text{CH}_3\text{COOCH}_3$)
- Ethyl butanoate

**Hydrolysis**:
$$\text{RCOOR''} + \text{H}_2\text{O} \rightarrow \text{RCOOH} + \text{R''OH}$$

### Acid Anhydrides

**Anhydride**: (RCO)₂O (two acyl groups bonded to oxygen)

**Formation**: Dehydration of two carboxylic acids
$$2\text{RCOOH} \rightarrow (\text{RCO})_2\text{O} + \text{H}_2\text{O}$$

### Acid Halides (Acyl Halides)

**Acid chloride**: RCOCl (most reactive derivative)

**Formation**:
$$\text{RCOOH} + \text{SOCl}_2 \rightarrow \text{RCOCl} + \text{SO}_2 + \text{HCl}$$

### Amides

**Amide**: RCONH₂ (nitrogen replaces -OH of acid)

**Peptide bond**: Amide linkage between amino acids
$$\text{R-CO-NH-R''}$$

## Reactivity Order

**Most reactive** → **Least reactive**:
Acyl halides > Anhydrides > Esters ≈ Acids > Amides

## Sources
- OpenStax Organic Chemistry 1e (2015). "Carboxylic Acids and Derivatives"
- Khan Academy: "Carboxylic Acids"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the correct order of reactivity for carboxylic acid derivatives?",
      "options": ["Amides > Esters > Anhydrides > Acyl halides", "Acyl halides > Anhydrides > Esters > Amides", "Acids > Esters > Amides > Acyl halides", "All have equal reactivity"],
      "correctAnswer": 1,
      "explanation": "Reactivity order: ACYL HALIDES (most reactive) > ANHYDRIDES > ESTERS ≈ ACIDS > AMIDES (least reactive). This trend reflects how well the leaving group can stabilize the negative charge: Cl⁻ (best) > RCOO⁻ > RO⁻ ≈ HO⁻ > NH₂⁻ (worst). More reactive derivatives can be converted to less reactive ones, but not the reverse!"
    },
    {
      "question": "What is Fischer esterification?",
      "options": ["Hydrolysis of ester to acid", "Acid-catalyzed reaction of carboxylic acid with alcohol to form ester", "Oxidation of alcohol to acid", "Reduction of acid to alcohol"],
      "correctAnswer": 1,
      "explanation": "Fischer esterification is the ACID-CATALYZED reaction of a carboxylic acid with an alcohol to form an ester plus water. The reaction is: RCOOH + R''OH (H⁺ catalyst, heat) → RCOOR'' + H₂O. This is an equilibrium process, so excess of one reactant or removal of water drives it forward. The mechanism involves protonation of carbonyl oxygen, nucleophilic attack by alcohol, and loss of water!"
    },
    {
      "question": "Why are carboxylic acids more acidic than alcohols?",
      "options": ["Higher molecular weight", "Carboxylate anion is resonance-stabilized over two oxygens", "More oxygen atoms", "Stronger bonds"],
      "correctAnswer": 1,
      "explanation": "Carboxylic acids (pKa ~4-5) are much more acidic than alcohols (pKa ~16-18) because the carboxylate anion (RCOO⁻) formed after losing H+ is RESONANCE-STABILIZED over TWO oxygens. The negative charge is delocalized equally between both oxygen atoms, making the conjugate base very stable. In contrast, alkoxide ions (RO⁻) have no resonance stabilization!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'functional-groups' LIMIT 1),
  'Amines and Amides',
  'amines-amides',
  4,
  '# Amines and Amides

## Amines

**Amine**: Organic compound derived from ammonia ($\text{NH}_3$) by replacing hydrogen atoms with alkyl/aryl groups.

**General formula**: R₃N where R can be H or alkyl/aryl

### Classification

**Primary** (1°): RNH₂ (one alkyl group)
**Secondary** (2°): R₂NH (two alkyl groups)
**Tertiary** (3°): R₃N (three alkyl groups)

**Examples**:
- Methylamine ($\text{CH}_3\text{NH}_2$)
- Dimethylamine ($( \text{CH}_3)_2\text{NH}$)
- Trimethylamine ($( \text{CH}_3)_3\text{N}$)

### Basicity

**Lone pair on nitrogen**: Accepts protons

**Reaction with acids**:
$$\text{RNH}_2 + \text{HCl} \rightarrow \text{RNH}_3^+\text{Cl}^-$$

**pKb**: Measures base strength (lower = stronger base)

**Basicity trend**: 2° > 1° > 3° (in aqueous solution)

### Amine Reactions

**Alkylation**:
$$\text{RNH}_2 + \text{R''X} \rightarrow \text{RR''NH} + \text{HX}$$

**Acylation**:
$$\text{RNH}_2 + \text{R''COCl} \rightarrow \text{R''CONHR} + \text{HCl}$$

**Hofmann elimination**:
$$\text{RCH}_2\text{CH}_2\text{N(CH}_3)_3^+ \text{OH}^- \rightarrow \text{RCH}=\text{CH}_2 + \text{N(CH}_3)_3 + \text{H}_2\text{O}$$

## Amides

**Amide**: Carbonyl group attached to nitrogen (-CONH₂)

**General formula**: RCONH₂, RCONHR'', or RCONR''₂

### Structure

**Resonance**: Lone pair on nitrogen delocalized onto carbonyl oxygen

$$\text{R-C(=O)-NH}_2 \leftrightarrow \text{R-C(-O^-)=N^+H_2}$$

**Planar geometry**: Trigonal planar around nitrogen

### Properties

**High melting/boiling points**: Strong hydrogen bonding

**Weak base**: Nitrogen lone pair is delocalized (less available)

**Neutral pH**: Amides are neither acidic nor basic (mostly)

### Amide Formation

**From carboxylic acid derivatives**:
$$\text{RCOCl} + \text{NH}_3 \rightarrow \text{RCONH}_2 + \text{HCl}$$

**From esters (aminolysis)**:
$$\text{RCOOR''} + \text{NH}_3 \rightarrow \text{RCONH}_2 + \text{R''OH}$$

### Amide Hydrolysis

**Acidic**:
$$\text{RCONH}_2 + \text{H}_2\text{O} + \text{H}^+ \rightarrow \text{RCOOH} + \text{NH}_4^+$$

**Basic**:
$$\text{RCONH}_2 + \text{OH}^- \rightarrow \text{RCOO}^- + \text{NH}_3$$

## Sources
- OpenStax Organic Chemistry 1e (2015). "Amines and Amides"
- Khan Academy: "Amines"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the difference between primary, secondary, and tertiary amines?",
      "options": ["Molecular weight", "Number of alkyl groups attached to nitrogen", "Number of carbon atoms", "Degree of basicity"],
      "correctAnswer": 1,
      "explanation": "Amines are classified by the NUMBER OF ALKYL GROUPS attached to the nitrogen atom. Primary (1°): ONE alkyl group (RNH₂); Secondary (2°): TWO alkyl groups (R₂NH); Tertiary (3°): THREE alkyl groups (R₃N). The hydrogen atoms on ammonia are progressively replaced by alkyl groups. This affects basicity, solubility, and reactivity!"
    },
    {
      "question": "Why are amides less basic than amines?",
      "options": ["Higher molecular weight", "Nitrogen lone pair is delocalized by resonance with carbonyl", "More carbon atoms", "Amides are acidic not basic"],
      "correctAnswer": 1,
      "explanation": "Amides are much LESS basic than amines because the nitrogen lone pair is DELOCALIZED by resonance with the adjacent carbonyl group. The lone pair participates in resonance: R-C(=O)-NH₂ ↔ R-C(-O⁻)=N⁺H₂. This makes the lone pair less available to accept protons. Amides are essentially neutral at physiological pH, whereas amines are basic (accept protons)!"
    },
    {
      "question": "What type of reaction is the Hofmann elimination?",
      "options": ["Nucleophilic addition", "Elimination reaction forming alkene from quaternary ammonium", "Electrophilic substitution", "Reduction"],
      "correctAnswer": 1,
      "explanation": "Hofmann elimination is an ELIMINATION reaction that converts a quaternary ammonium hydroxide to an alkene, amine, and water. When a quaternary ammonium ion (RCH₂CH₂N(CH₃)₃⁺) is treated with strong base (OH⁻) and heated, it undergoes E2 elimination to form the least substituted alkene (Hofmann product). The driving force is formation of stable tertiary amine (N(CH₃)₃) which leaves!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: REACTION MECHANISMS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Reaction Mechanisms',
  'reaction-mechanisms',
  'Study how organic molecules transform: addition, elimination, oxidation, reduction, and rearrangement reactions.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'reaction-mechanisms' LIMIT 1),
  'Reaction Mechanisms Overview',
  'reaction-mechanisms-overview',
  1,
  '# Reaction Mechanisms Overview

## What Are Reaction Mechanisms?

**Reaction mechanism**: Detailed pathway at molecular level showing how bonds break and form.

**Why study mechanisms?**
- Predict products
- Understand rates
- Control reactions
- Design syntheses

## Types of Organic Reactions

### Substitution Reactions

One atom/group replaces another.

$$\text{Nu-L} + \text{R}-\text{X} \rightarrow \text{Nu-R} + \text{X}$$

**Example**: Chloromethane + NaOH → Methanol + NaCl

**Nucleophile vs. Electrole**:

- **Nucleophile**: Rich in electrons, seeks positive/partially negative charge
- **Electrole**: Poor in electrons, seeks positive/partially negative charge

### Elimination Reactions

Removal of atoms or groups to form double/triple bonds.

**Dehydration**: Removal of H and OH from adjacent carbons (requires strong acid and heat).

### Addition Reactions

Two molecules combine to form larger single molecule.

**Example**: Ethene + HBr → Bromoethane (Markovnikov addition)

**Oxidation**

Alcohol to carbonyl compound:
$$\text{RCH}_2\text{OH} + [\text{O}] \rightarrow \text{RCHO} + \text{H}_2\text{O}$$

[Ketone formation]: Aldehyde + alcohol → hemiacetal (cyclic)

### Reduction Reactions

Gain of electrons (or hydrogen), decrease in oxidation state.

**Example**: Aldehyde + $\text{NaBH}_4$ → Alcohol (reduction)

### Oxidation-Reduction

Gain of oxygen, loss of electrons.

**Example**: $\text{CH}_4 + 2\text{O}_2 \rightarrow 2\text{CO}_2 + 2\text{H}_2\text{O}$

**Combustion**: Hydrocarbon reacts with oxygen to produce CO₂ and H₂O.

### Polymerization

Many small molecules (monomers) join to form large chains.

**Addition polymerization**: Monomers add together (initiated by radical or ion).

**Condensation polymerization**: Monomers join eliminating small molecule (like H₂O).

## Sources
- Khan Academy: "Streochemistry"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What type of reaction replaces an atom or group with another?",
      "options": ["Addition reaction", "Elimination reaction", "Reduction reaction", "Oxidation"],
      "correctAnswer": 0,
      "explanation": "SUBSTITUTION reaction replaces one atom/group with another. A nucleophile (electron-rich) replaces a leaving group, while an electrophile (electron-poor) is eliminated. Example: CH₃Cl + NaOH → CH₃OH + NaCl. The OH from nucleophile attacks the electrophilic carbon, replacing the chlorine atom. This forms a new bond!"
    },
    {
      "question": "What is the product of oxidation of an aldehyde using alcohol in the presence of heat?",
      "options": ["Carbolic acid", "Ketone", "Alcohol", "Alkane"],
      "correctAnswer": 1,
      "explanation": "Aldehyde (RCHO) in the presence of alcohol and heat undergoes OXIDATION to form a ketone (R(C=O)R). The mechanism involves: 1) oxidation of alcohol to carboxylic acid, 2) formation of a hemiacetal (cyclic compound) formed when two alcohol molecules react. The ketone carbonyl (C=O) is more oxidized than the starting aldehyde!"
    },
    {
      "question": "What is combustion in the context of organic chemistry?",
      "options": ["Rapid oxidation producing light", "Slow oxidation at room temperature", "Addition reaction where molecules combine", "Reaction with oxygen that produces CO₂ and H₂O"],
      "correctAnswer": 3,
      "explanation": "COMBUSTION in organic chemistry is the rapid oxidation of hydrocarbons with oxygen to produce carbon dioxide (CO₂) and water (H₂O). This is an exothermic redox reaction that releases large amounts of heat and light. Complete combustion: hydrocarbon + excess O₂ → CO₂ + H₂O. Incomplete combustion (limited oxygen) produces CO + C (soot) and/or CO!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'reaction-mechanisms' LIMIT 1),
  'Nucleophilic and Electrophilic Addition',
  'nucleophilic-electrophilic-addition',
  2,
  '# Nucleophilic and Electrophilic Addition

## What Is Nucleophilic Addition?

**Nucleophile**: Electron-rich species (has $\pi$ electrons or lone pairs)

**Electrophile**: Electron-deficient species (seeks electrons)

**Reaction**: Nucleophile attacks electrophile, forming new bond.

$$\text{Nu}: + \text{E} \rightarrow \text{Nu-E}$$

**Markovnikov addition**: Nucleophile attacks electrophilic $\pi$ bond.

## Mechanism

**Step 1**: Nucleophile''s $\pi$ electrons attack electrophile''s $\pi$ bond

**Step 2**: Formation of new bond between carbons

**Step 3**: Deprotonation of electrophile (regain $\pi$ electrons)

## Examples

**Example 1**: Propene + HBr (electrophilic addition)

$$\text{CH}_2=\text{CH}-\text{CH} + \text{HBr} \rightarrow \text{CH}_2\text{CH}-\text{CH}_2$$

- **Mechanism**:
 1. Electrophile''s $\pi$ electrons attack alkene $\pi$ bond
 2. $\pi$ complex shifts to Br
 3. Bromide adds to carbon
 4. New C-Br bond forms

**Example 2**: Benzene + Br₂

$$\chemfig{C}_6\text{H}_6 + \text{Br}_2 \xrightarrow \text{C}_6\text{H}_5\text{Br}$$

- **Mechanism**:
 1. Bromine molecule polarizes $\pi$ bond of benzene
 2. Benzene''s $\pi$ electrons shift toward Br
 3. Electrophilic bromide intermediate

## Stereochemistry

**Markovnikov rule** (anti-addition):

- **Add to LESS substituted carbon**
- **Bromine adds OPPOSITE to Markovnikov preference**

**Example**: Addition to $\alpha$-methylstyrene

**Anti-Markovnikov** product is MAJOR product (more stable)

## Key Concepts

| Concept | Description |
|----------|-------------|
| Electrophile | Electron-rich, seeks $\pi$ electrons | Attacks $\pi$ bonds |
| Nucleophile | Electron-rich, has lone pairs | Donates $\pi$ electrons |
| $\pi$ bond | Bond formed by sharing electrons in p orbital | Found in alkenes, aromatics |
| Markovnikov rule | Anti-addition (opposite carbon) | Explains regioselectivity |

## Sources
- Khan Academy: "Addition to Alkenes"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What is the Markovnikov rule for nucleophilic addition?",
      "options": ["Bromine always adds to the LESS substituted carbon", "Bromine adds to the carbon with MORE hydrogens", "Bromine adds to whichever carbon is MORE substituted", "Bromine addition is random and has no regioselectivity"],
      "correctAnswer": 0,
      "explanation": "The Markovnikov rule states: Add to the LESS substituted carbon (the carbon with fewer hydrogens). Bromine is electrophilic and seeks out carbon atoms with some electron density. It adds to the carbon that is LESS substituted (has more hydrogens attached), regardless of other factors. This anti-addition preference leads to formation of the MAJOR product (more thermodynamically stable) from the less substituted starting materials!"
    },
    {
      "question": "What happens to the electrophile''s π electrons during the attack?",
      "options": ["They are transferred to the new bond", "They are expelled and become lone pair electrons", "They shift to form a new geometry", "They remain in place and the new bond forms behind them"],
      "correctAnswer": 2,
      "explanation": "The electrophile''s π electrons attack the electrophilic π bond. During the reaction, the π electrons TRANSFER to the bromine atom, becoming part of the new C-Br σ bond. The carbon''s π electrons are expelled and become a LONE PAIR (non-bonding electrons). After the new bond forms, the carbon has regained an octet (through hyperconjugation) with its other three bonds!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'reaction-mechanisms' LIMIT 1),
  'Aromatic Compounds',
  'aromatic-compounds',
  3,
  '# Aromatic Compounds

## What Is Aromaticity?

**Aromatic compound**: Contains benzene ring (6 $\pi$-electron system).

**Benzene** ($\text{C}_6\text{H}_6$): Simplest aromatic compound.

### Huckel''s Rule

For electrophilic aromatic substitution:

1. **Ortho/para directing**: New group is ortho or para to existing group

2. **Nucleophile attacks electrophile**: Carbocation intermediate forms

3. **Deprotonation**: Electrophile loses its $\pi$ bond

## Benzene Derivatives

### Phenol derivatives

**Phenol**: -OH directly attached to benzene ring.

**Examples**:
- Phenol
- Cresol
- Resorcinol

### Polycyclic Aromatic Hydrocarbons (PAH)

Multiple benzene rings fused together.

**Examples**:
- Naphthalene (2 benzene rings)
- Anthracene (3 benzene rings)

### Heterocyclic Compounds

Rings contain non-carbon atoms (O, N, S, etc.).

## Sources
- Khan Academy: "Aromatic Compounds and Huckel''s Rule"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What is Huckel''s rule for electrophilic aromatic substitution?",
      "options": ["Ortho and para directing groups", "Nucleophile attacks only when ortho/para directing", "Deprotonation occurs regardless of directing", "Addition is allowed regardless of existing group"],
      "correctAnswer": 0,
      "explanation": "Huckel''s rule guides electrophilic aromatic substitution: 1) Ortho/para director (new group) must be ortho or para to the existing group it''s replacing, 2) Nucleophile attacks the electrophile, forming a carbocation intermediate, 3) Deprotonation occurs (electrophile loses its π bond) regardless of which group the new group entered, 4) Addition is allowed at any position on the ring (doesn''t matter if other positions are occupied). This predicts and explains the orientation and reactivity patterns observed in electrophilic aromatic substitutions!"
    },
    {
      "question": "What type of aromatic system has two benzene rings fused together?",
      "options": ["Benzene derivatives", "Polycyclic aromatic hydrocarbons (PAH)", "Heterocyclic compounds", "Condensed aromatics"],
      "correctAnswer": 1,
      "explanation": "Two benzene rings fused together is called a POLYCYCLIC AROMATIC HYDROCARBON (PAH) system. This has three benzene rings sharing one or more carbon atoms between them (like sharing a side). Examples: naphthalene (2 benzenes), anthracene (3 benzenes). Each ring maintains aromaticity through continuous overlap of π electrons above and below the ring plane (delocalized π system)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'reaction-mechanisms' LIMIT 1),
  'Oxidation and Reduction',
  'oxidation-reduction',
  4,
  '# Oxidation and Reduction

## What Is Oxidation?

**Oxidation**: Gain of oxygen, loss of electrons.

**Examples**:

### Primary Alcohol to Aldehyde

**Aldehyde oxidation**:
$$\text{RCHO} + [\text{O}] \xrightarrow{\text{RCHO}} + \text{H}_2\text{O}$$

**Mechanism**:
1. Hemiametal formation (cyclic)
2. Oxidation to carboxylic acid
3. Reduction (gain 2 electrons)

**Product**: Carboxylic acid + $\text{H}_2\text{O}$

### Alcohol to Carboxylic Acid (oxidation)

$$\text{RCH}_2\text{OH} + \text{COOH} \rightarrow \text{RCOOH}$$

**Mechanism**:
1. Oxidation of alcohol to aldehyde (2 electrons)
2. Esterification
3. Deprotonation of acid (loss of oxygen)

**Product**: Ester + water

### Alcohol to Ketone

$$\text{R}_2\text{CHO} + [\text{O}] \rightarrow \text{R}_2\text{C}$$

**Mechanism**:
1. Oxidation of secondary alcohol (2° alcohol)
2. Formation of ketone
3. Reduction of ketone

**Product**: Ketone + alcohol

### Aldehyde to Acid

$$\text{RCHO} + [\text{O}] \rightarrow \text{RCOOH}$$

**Mechanism**:
1. Hydration (addition of water)
2. Formation of hydrate
3. Oxidation to carboxylic acid

**Product**: Carboxylic acid + $\text{H}_2\text{O}$

### Combustion

**Hydrocarbon + excess $\text{O}_2 \rightarrow \text{CO}_2 + \text{H}_2\text{O}$$

**Mechanism**:
1. Radical chain initiation (high temperature breaks C-H and C-H bonds)
2. Oxygen molecule adds to carbon radical
3. Propagation of chain reaction
4. Formation of peroxides
5. Fragmentation and recombination

**Complete**: $\text{CO}_2 + 2\text{H}_2\text{O}$

## Key Concepts

| Process | Change | Oxidation State | Reduction |
|----------|--------|---------------|----------|
| Primary → Secondary | Oxidation | Oxidation number increases |
| Alcohol → Aldehyde | +2 | R loses 2e⁻ |
| Aldehyde → Acid | +2 | R gains 2e⁻ |
| Alcohol → Ketone | +2 | R gains 2e⁻ |
| Combustion | Carbon | C=0, H = -1 | Carbon oxidized |

## Sources
- Khan Academy: "Oxidation and Reduction"
- OpenStax Organic Chemistry
',

  '[
    {
      "question": "What is the oxidation state change of a primary alcohol becoming an aldehyde?",
      "options": ["Gain of 2 electrons (reduction)", "Loss of 2 electrons (oxidation)", "No change in oxidation state", "Transfer of electrons"],
      "correctAnswer": 1,
      "explanation": "When primary alcohol (RCH₂OH) is oxidized to aldehyde (RCHO), the alcohol carbon LOSES 2 electrons (oxidation). RCH₂OH → RCHO + 2e⁻ (reduction). The aldehyde carbon GAINS 2 electrons (reduction). Overall: R is oxidized (loses electrons) and O is reduced (gains electrons)!"
    },
    {
      "question": "What is the role of peroxides in combustion reactions?",
      "options": ["They initiate radical chain reactions", "They are intermediate compounds that decompose", "They transfer oxygen atoms to carbon radicals", "They stabilize reactive intermediates"],
      "correctAnswer": 0,
      "explanation": "Peroxydes (ROO•) are INITIATORS of radical chain reactions in combustion. They form by high-temperature homolysis of C-H and C-C bonds (or C-H bonds in hydrocarbons) at 400-600°C. ROO• then adds to carbon radical (R•), propagating the chain reaction and forming new O-O peroxy linkages between radical fragments. This leads to formation of stable products (CO₂ and H₂O) and termination of the reaction. Without peroxydes, the reaction would not propagate or would be explosively fast!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: POLYMERS AND BIOPOLYMERS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Polymers and Biopolymers',
  'polymers-biopolymers',
  'Study the formation, properties, and reactions of giant molecules including proteins, nucleic acids, and synthetic polymers.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'polymers-biopolymers' LIMIT 1),
  'Polymerization Mechanisms',
  'polymerization-mechanisms',
  1,
  '# Polymerization Mechanisms

## What Are Polymers?

**Polymer**: Large molecule composed of many repeating subunits (monomers).

**Monomer**: Small molecule that can join to form polymers.

**General formula**: $(\text{monomer})_n$ where $n$ = degree of polymerization

### Polymer Types

**Addition polymers**: Formed by addition of monomers (no byproduct)
- Polyethylene, polypropylene, PVC

**Condensation polymers**: Formed with elimination of small molecule (e.g., water)
- Nylon, polyester, proteins

## Addition Polymerization

**Free radical polymerization**:

1. **Initiation**: Radical forms from initiator
   $$\text{I}_2 \rightarrow 2\text{I}•$$

2. **Propagation**: Radical adds to monomer
   $$\text{I}• + \text{CH}_2=\text{CH}_2 \rightarrow \text{I}-\text{CH}_2-\text{CH}_2•$$
   $$\text{I}-\text{CH}_2-\text{CH}_2• + \text{CH}_2=\text{CH}_2 \rightarrow \text{I}-\text{CH}_2-\text{CH}_2-\text{CH}_2-\text{CH}_2•$$

3. **Termination**: Two radicals combine
   $$2\text{R}• \rightarrow \text{R}-\text{R}$$

**Chain transfer**: Radical transfers to another molecule

## Condensation Polymerization

**Step-growth mechanism**:

1. **Monomer activation**: Functional groups react
2. **Oligomer formation**: Small chains form
3. **Polymer growth**: Chains join with loss of small molecule

**Example**:
$$n\,\text{HOOC-R-COOH} + n\,\text{HO-R''-OH} \rightarrow (-\text{CO-R-CO-O-R''-O-)_n + 2n\,\text{H}_2\text{O}$$

## Sources
- OpenStax Organic Chemistry 1e (2015). "Polymerization"
- Khan Academy: "Polymers"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the difference between addition and condensation polymerization?",
      "options": ["Addition produces water, condensation does not", "Addition has no byproduct, condensation eliminates small molecule like water", "Condensation is faster than addition", "Addition requires catalyst, condensation does not"],
      "correctAnswer": 1,
      "explanation": "In ADDITION polymerization, monomers simply add together without eliminating any molecules (e.g., ethylene → polyethylene). In CONDENSATION polymerization, monomers join while ELIMINATING a small molecule like water or methanol (e.g., nylon formation eliminates H₂O). This is why condensation polymers are often formed in equilibrium reactions!"
    },
    {
      "question": "What are the three stages of free radical polymerization?",
      "options": ["Nucleation, growth, termination", "Initiation, propagation, termination", "Activation, reaction, cooling", "Mixing, heating, molding"],
      "correctAnswer": 1,
      "explanation": "Free radical polymerization has three stages: 1) INITIATION - radical forms from initiator compound (I₂ → 2I•); 2) PROPAGATION - radical adds to monomer, and the new radical at chain end adds to more monomers (chain grows); 3) TERMINATION - two radicals combine ending chain growth (R• + R• → R-R)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'polymers-biopolymers' LIMIT 1),
  'Synthetic Polymers',
  'synthetic-polymers',
  2,
  '# Synthetic Polymers

## Common Synthetic Polymers

### Polyethylene

**Structure**: $(-\text{CH}_2-\text{CH}_2-)_n$

**Types**:
- **LDPE** (Low-density): Branched chains, flexible
- **HDPE** (High-density): Linear chains, rigid

**Uses**: Plastic bags, bottles, toys

### Polypropylene

**Structure**: $(-\text{CH}_2-\text{CH(CH}_3)-)_n$

**Uses**: Carpets, ropes, thermal underwear

### PVC (Polyvinyl Chloride)

**Structure**: $(-\text{CH}_2-\text{CHCl}-)_n$

**Uses**: Pipes, credit cards, window frames

### Polystyrene

**Structure**: Benzene ring with vinyl group

**Uses**: Foam cups, packaging, insulation

### Nylon (Polyamide)

**Structure**: Amide linkages between diamine and diacid

**Uses**: Clothing, ropes, parachutes

### PET (Polyethylene Terephthalate)

**Structure**: Ester linkages

**Uses**: Plastic bottles, polyester fabric

## Polymer Properties

**Crystallinity**: Ordered regions increase strength
- HDPE: 60-80% crystalline
- LDPE: 40-60% crystalline

**Glass transition temperature** ($T_g$): Temperature where polymer softens

**Melting temperature** ($T_m$): Temperature where crystalline regions melt

## Sources
- OpenStax Organic Chemistry 1e (2015). "Synthetic Polymers"
- Khan Academy: "Polymers"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the main difference between LDPE and HDPE?",
      "options": ["Different monomers", "LDPE has branched chains (flexible), HDPE has linear chains (rigid)", "LDPE is synthetic, HDPE is natural", "HDPE has lower density than LDPE"],
      "correctAnswer": 1,
      "explanation": "LDPE (Low-Density Polyethylene) has BRANCHED polymer chains that prevent tight packing, making it flexible and lower density. HDPE (High-Density Polyethylene) has LINEAR chains that pack tightly together, making it rigid and higher density. Both are made from the same ethylene monomer, just different polymerization conditions create different chain architectures!"
    },
    {
      "question": "What type of linkages are found in nylon?",
      "options": ["Ester linkages", "Amide linkages", "Ether linkages", "Hydrogen bonds"],
      "correctAnswer": 1,
      "explanation": "Nylon is a POLYAMIDE, meaning it contains AMIDE linkages (-CO-NH-) between monomer units. It''s formed by condensation polymerization between a diamine (two amine groups) and a diacid (two carboxylic acid groups), eliminating water. The amide bond is strong and gives nylon its strength and durability!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'polymers-biopolymers' LIMIT 1),
  'Proteins',
  'proteins',
  3,
  '# Proteins

## What Are Proteins?

**Protein**: Biopolymer made of amino acid monomers linked by peptide bonds.

**Amino acid**: Contains amino group (-NH₂) and carboxyl group (-COOH)

**General structure**: $\text{H}_2\text{N}-\text{CHR}-\text{COOH}$

## Protein Structure

### Primary Structure

**Linear sequence** of amino acids linked by peptide bonds.

**Peptide bond formation**:
$$\text{H}_2\text{N}-\text{CHR}_1-\text{COOH} + \text{H}_2\text{N}-\text{CHR}_2-\text{COOH} \rightarrow \text{H}_2\text{N}-\text{CHR}_1-\text{CO}-\text{NH}-\text{CHR}_2-\text{COOH} + \text{H}_2\text{O}$$

### Secondary Structure

**Local folding** patterns:
- **α-helix**: Coiled structure (keratin, collagen)
- **β-pleated sheet**: Extended strands (silk fibroin)

**Stabilized by**: Hydrogen bonds between backbone atoms

### Tertiary Structure

**3D shape** of single polypeptide chain.

**Stabilized by**:
- Hydrophobic interactions
- Hydrogen bonds
- Disulfide bridges
- Ionic interactions

### Quaternary Structure

**Assembly** of multiple polypeptide chains.

**Example**: Hemoglobin (4 subunits)

## Amino Acids

**20 standard amino acids** in proteins:

**Essential amino acids**: Cannot be synthesized by humans (must obtain from diet)
- Examples: Valine, leucine, isoleucine, phenylalanine

**Non-essential**: Can be synthesized by humans

## Protein Functions

**Enzymes**: Catalyze biochemical reactions
**Structural**: Provide support (collagen, keratin)
**Transport**: Carry molecules (hemoglobin)
**Hormones**: Chemical messengers (insulin)
**Antibodies**: Immune defense

## Sources
- OpenStax Organic Chemistry 1e (2015). "Proteins"
- Khan Academy: "Proteins"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What type of bond links amino acids in proteins?",
      "options": ["Hydrogen bond", "Ionic bond", "Peptide (amide) bond", "Glycosidic bond"],
      "correctAnswer": 2,
      "explanation": "Amino acids are linked by PEPTIDE BONDS (which are amide bonds: -CO-NH-) between the carboxyl group (-COOH) of one amino acid and the amino group (-NH₂) of another, eliminating water (H₂O). This condensation reaction forms the polypeptide chain. Multiple peptide bonds make up the primary structure of proteins!"
    },
    {
      "question": "What stabilizes the secondary structure of proteins?",
      "options": ["Disulfide bridges", "Hydrophobic interactions", "Hydrogen bonds between backbone atoms", "Ionic interactions"],
      "correctAnswer": 2,
      "explanation": "Secondary structures (α-helices and β-pleated sheets) are stabilized by HYDROGEN BONDS between backbone atoms (specifically between the carbonyl oxygen C=O of one amino acid and the amide hydrogen N-H of another). These regular hydrogen bonding patterns create the characteristic coiled (helix) or folded (sheet) structures!"
    },
    {
      "question": "What is the difference between tertiary and quaternary protein structure?",
      "options": ["Tertiary is 2D, quaternary is 3D", "Tertiary is 3D folding of one chain, quaternary is assembly of multiple chains", "Tertiary has α-helices, quaternary has β-sheets", "No difference"],
      "correctAnswer": 1,
      "explanation": "TERTIARY structure is the 3D folding of a SINGLE polypeptide chain stabilized by various interactions (hydrophobic, H-bonds, disulfide bridges). QUATERNARY structure is the assembly of MULTIPLE polypeptide chains (subunits) into a functional protein complex. Not all proteins have quaternary structure (e.g., myoglobin has only tertiary structure)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'polymers-biopolymers' LIMIT 1),
  'Carbohydrates and Nucleic Acids',
  'carbohydrates-nucleic-acids',
  4,
  '# Carbohydrates and Nucleic Acids

## Carbohydrates

**Carbohydrate**: Biomolecule with formula $\text{C}_m(\text{H}_2\text{O})_n$

**Monosaccharides**: Simple sugars (glucose, fructose, ribose)

**Disaccharides**: Two monosaccharides linked (sucrose, lactose)

**Polysaccharides**: Many monosaccharides (starch, cellulose, glycogen)

### Glucose

**Structure**: $\text{C}_6\text{H}_{12}\text{O}_6$

**Isomers**:
- **Glucose**: Blood sugar
- **Fructose**: Fruit sugar
- **Galactose**: Milk sugar

### Glycosidic Bonds

**Formation**: Condensation reaction between hydroxyl groups
$$\text{C}_6\text{H}_{12}\text{O}_6 + \text{C}_6\text{H}_{12}\text{O}_6 \rightarrow \text{C}_{12}\text{H}_{22}\text{O}_{11} + \text{H}_2\text{O}$$

## Polysaccharides

**Starch**: Plant energy storage (amylose + amylopectin)
- α-glycosidic bonds (digestible)

**Cellulose**: Plant structural material
- β-glycosidic bonds (indigestible by humans)

**Glycogen**: Animal energy storage
- Highly branched structure

## Nucleic Acids

**DNA**: Deoxyribonucleic acid (genetic material)

**RNA**: Ribonucleic acid (protein synthesis, gene regulation)

### Nucleotides

**Structure**: Three components
1. **Phosphate group**: Links nucleotides
2. **Pentose sugar**: Deoxyribose (DNA) or ribose (RNA)
3. **Nitrogenous base**: A, T, G, C (DNA) or A, U, G, C (RNA)

### DNA Structure

**Double helix**: Two antiparallel strands

**Base pairing**:
- Adenine (A) ↔ Thymine (T) - 2 H-bonds
- Guanine (G) ↔ Cytosine (C) - 3 H-bonds

**Directionality**: 5'' end to 3'' end

### RNA vs DNA

| Feature | DNA | RNA |
|----------|-------|------|
| Sugar | Deoxyribose | Ribose |
| Bases | A, T, G, C | A, U, G, C |
| Strands | Double | Single |
| Stability | More stable | Less stable |

## Sources
- OpenStax Organic Chemistry 1e (2015). "Carbohydrates and Nucleic Acids"
- Khan Academy: "Biomolecules"
- LibreTexts: "Organic Chemistry"
',

  '[
    {
      "question": "What is the main structural difference between starch and cellulose?",
      "options": ["Different monomers", "Starch has α-glycosidic bonds, cellulose has β-glycosidic bonds", "Cellulose is branched, starch is linear", "Starch contains nitrogen, cellulose does not"],
      "correctAnswer": 1,
      "explanation": "Both starch and cellulose are polymers of glucose, but they differ in GLYCOSIDIC BOND ORIENTATION. Starch has α-glycosidic bonds (helical structure, digestible by human enzymes), while cellulose has β-glycosidic bonds (linear fibers, indigestible by humans). This small difference in bond orientation creates very different properties!"
    },
    {
      "question": "What are the three components of a nucleotide?",
      "options": ["Phosphate, sugar, base", "Phosphate, lipid, protein", "Sugar, amino acid, fatty acid", "Phosphate, nitrogen, carbon"],
      "correctAnswer": 0,
      "explanation": "Nucleotides have THREE components: 1) PHOSPHATE group (links nucleotides and provides negative charge), 2) PENTOSE SUGAR (deoxyribose in DNA or ribose in RNA - 5-carbon sugar), 3) NITROGENOUS BASE (A, T, G, C in DNA or A, U, G, C in RNA). These three components together form the building blocks of nucleic acids!"
    },
    {
      "question": "What is the key difference between DNA and RNA?",
      "options": ["DNA has ribose, RNA has deoxyribose", "DNA is double-stranded with A-T and G-C base pairing, RNA is single-stranded with A-U and G-C", "DNA uses uracil, RNA uses thymine", "RNA is more stable than DNA"],
      "correctAnswer": 1,
      "explanation": "KEY DIFFERENCES: DNA has DEOXYRIBOSE sugar and is DOUBLE-STRANDED with base pairing A↔T (2 H-bonds) and G↔C (3 H-bonds). RNA has RIBOSE sugar (extra OH group) and is SINGLE-STRANDED with base pairing A↔U (substitutes for T) and G↔C. RNA is less stable than DNA due to the extra 2''-OH making it more susceptible to hydrolysis!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 6: SPECTROSCOPY AND STRUCTURAL ANALYSIS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'organic-chemistry' LIMIT 1),
  'Spectroscopy and Structural Analysis',
  'spectroscopy-structural-analysis',
  'Learn techniques to identify and characterize organic compounds: IR, NMR, MS, and UV-Vis spectroscopy.',
  6,
  NOW()
);

-- LESSONS FOR CHAPTER 6
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'spectroscopy-structural-analysis' LIMIT 1),
  'Infrared Spectroscopy (IR)',
  'infrared-spectroscopy',
  1,
  '# Infrared Spectroscopy (IR)

## What Is IR Spectroscopy?

**Infrared spectroscopy**: Analytical technique that measures absorption of infrared light by molecules.

**Principle**: Bonds vibrate at specific frequencies; IR absorption indicates functional groups.

### Molecular Vibrations

**Stretching**: Change in bond length
- Symmetric stretch
- Asymmetric stretch

**Bending**: Change in bond angle
- Scissoring
- Rocking
- Wagging
- Twisting

### IR Regions

| Region (cm⁻¹) | Bond Type |
|------------------|------------|
| 4000-2500 | X-H single bonds (O-H, N-H, C-H) |
| 2500-2000 | Triple bonds (C≡C, C≡N) |
| 2000-1500 | Double bonds (C=O, C=C) |
| Below 1500 | Fingerprint region (unique to molecule) |

### Characteristic Absorptions

**O-H stretch**: 3200-3600 cm⁻¹ (broad, strong)
- Alcohols, carboxylic acids

**N-H stretch**: 3300-3500 cm⁻¹ (medium)
- Amines, amides

**C=O stretch**: 1700-1750 cm⁻¹ (strong)
- Aldehydes, ketones, esters, carboxylic acids

**C-H stretch**: 2850-3000 cm⁻¹
- Alkanes, alkenes, aromatics

### Applications

**Identify functional groups**: Match absorption peaks to known frequencies

**Confirm structure**: Verify proposed structure matches spectrum

**Purity check**: Identify impurities from extra peaks

## Sources
- Khan Academy: "Infrared Spectroscopy"
- OpenStax Organic Chemistry 1e (2015). "Spectroscopy"
- LibreTexts: "Spectroscopy"
',

  '[
    {
      "question": "What type of molecular vibration causes IR absorption at 1700-1750 cm⁻¹?",
      "options": ["O-H stretching", "C=O stretching", "C-H stretching", "N-H stretching"],
      "correctAnswer": 1,
      "explanation": "C=O (carbonyl) stretching vibrations absorb at 1700-1750 cm⁻¹ in IR spectroscopy. This strong absorption is characteristic of aldehydes, ketones, esters, and carboxylic acids. The exact position within this range indicates the specific carbonyl type (e.g., esters ~1740 cm⁻¹, carboxylic acids ~1710 cm⁻¹, saturated aldehydes ~1730 cm⁻¹)!"
    },
    {
      "question": "What is the fingerprint region in IR spectroscopy?",
      "options": ["4000-2500 cm⁻¹ where O-H and N-H absorb", "Below 1500 cm⁻¹ unique to each molecule", "2000-1500 cm⁻¹ where C=O absorbs", "2500-2000 cm⁻¹ for triple bonds"],
      "correctAnswer": 1,
      "explanation": "The FINGERPRINT REGION (below 1500 cm⁻¹) contains complex absorption patterns unique to each molecule, like a molecular fingerprint. This region contains bending vibrations and whole-molecule vibrations that are highly specific to the exact molecular structure. Matching the fingerprint region confirms identity by comparing unknown spectrum to known reference spectra!"
    },
    {
      "question": "Why is the O-H absorption in IR spectroscopy broad and strong?",
      "options": ["O-H bond is very weak", "Hydrogen bonding causes variable O-H distances broadening the absorption", "O-H stretching is at very high frequency", "O-H does not absorb in IR"],
      "correctAnswer": 1,
      "explanation": "O-H absorption (3200-3600 cm⁻¹) is BROAD because HYDROGEN BONDING creates a range of O-H distances in the sample. Molecules engaged in hydrogen bonding have different O-H stretching frequencies than free O-H groups, creating a broad envelope of absorption rather than a sharp peak. This broad band is characteristic of alcohols and carboxylic acids!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'spectroscopy-structural-analysis' LIMIT 1),
  'Nuclear Magnetic Resonance (NMR)',
  'nuclear-magnetic-resonance',
  2,
  '# Nuclear Magnetic Resonance (NMR)

## What Is NMR Spectroscopy?

**Nuclear Magnetic Resonance**: Technique that detects nuclei with spin in magnetic field.

**Principle**: Nuclei with odd mass (¹H, ¹³C) absorb radiofrequency when placed in strong magnetic field.

### ¹H NMR (Proton NMR)

**Chemical shift (δ)**: Position of signal relative to reference
- **TMS** (tetramethylsilane): δ = 0 ppm reference

**Shielding**: Electrons around nucleus reduce effective field (lower δ)
**Deshielding**: Electron-withdrawing groups increase δ (higher δ)

### Chemical Shift Ranges

| Proton Type | δ (ppm) |
|--------------|------------|
| TMS (reference) | 0.0 |
| Primary alkyl (RCH₃) | 0.9 |
| Secondary alkyl (R₂CH₂) | 1.3 |
| Tertiary alkyl (R₃CH) | 1.5 |
| Allylic (C=C-CH) | 1.6-2.0 |
| Aromatic | 6.5-8.0 |
| Aldehyde (RCHO) | 9.5-10.0 |
| Carboxylic acid (RCOOH) | 10.5-12.0 |

### Signal Integration

**Area under peak**: Proportional to number of equivalent protons

**Example**: CH₃ group integrates to 3H

### Splitting (Multiplicity)

**n+1 rule**: Signal splits into n+1 peaks where n = neighboring equivalent protons

**Patterns**:
- **Singlet** (s): 0 neighbors
- **Doublet** (d): 1 neighbor
- **Triplet** (t): 2 neighbors
- **Quartet** (q): 3 neighbors

### ¹³C NMR

**Broader chemical shift range**: 0-220 ppm

**Lower natural abundance**: 1.1% of carbon (vs 99.9% ¹²C)

**Direct detection**: Requires more scans than ¹H NMR

## Applications

**Structure determination**: Count signals, identify environments

**Molecular symmetry**: Equivalent carbons/protons give same signal

**Skeleton mapping**: Assemble structure piece by piece

## Sources
- Khan Academy: "Proton NMR"
- OpenStax Organic Chemistry 1e (2015). "NMR Spectroscopy"
- LibreTexts: "Spectroscopy"
',

  '[
    {
      "question": "What is the chemical shift range for aromatic protons in ¹H NMR?",
      "options": ["0.9-1.5 ppm", "1.6-2.0 ppm", "6.5-8.0 ppm", "9.5-10.0 ppm"],
      "correctAnswer": 2,
      "explanation": "Aromatic protons (on benzene rings) appear at 6.5-8.0 ppm in ¹H NMR. This is DOWNFIELD (higher chemical shift) because aromatic RING CURRENT deshields the protons - the circulating π electrons create a magnetic field that adds to the applied field at the proton position. This strong deshielding moves signals far from TMS reference!"
    },
    {
      "question": "What does the integration of an NMR signal tell you?",
      "options": ["Number of neighboring protons", "Number of equivalent protons", "Type of functional group", "Molecular weight"],
      "correctAnswer": 1,
      "explanation": "The INTEGRATION (area under peak) is proportional to the NUMBER OF EQUIVALENT PROTONS represented by that signal. A CH₃ group integrates to 3H, a CH₂ integrates to 2H, and a CH integrates to 1H. This quantitative information helps determine the ratio of different proton environments in the molecule!"
    },
    {
      "question": "How many peaks will a CH₃ group neighboring a CH₂ group produce in ¹H NMR?",
      "options": ["1 peak (singlet)", "2 peaks (doublet)", "3 peaks (triplet)", "4 peaks (quartet)"],
      "correctAnswer": 2,
      "explanation": "The CH₃ group has 2 neighboring protons on the adjacent CH₂ (n=2), so according to the n+1 rule, it splits into 2+1 = 3 PEAKS (triplet). This splitting occurs because the neighboring CH₂ protons can have 3 different spin combinations relative to the CH₃ protons, creating slightly different magnetic environments!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'spectroscopy-structural-analysis' LIMIT 1),
  'Mass Spectrometry',
  'mass-spectrometry',
  3,
  '# Mass Spectrometry

## What Is Mass Spectrometry?

**Mass spectrometry**: Technique that measures mass-to-charge ratio (m/z) of ionized molecules.

**Principle**: Molecules are ionized, separated by mass, and detected.

### The Mass Spectrometer

**Components**:

1. **Ionization source**: Creates gas-phase ions
   - Electron impact (EI): High energy, fragments molecule
   - Electrospray (ESI): Soft ionization, preserves molecular ion

2. **Mass analyzer**: Separates ions by m/z
   - Time-of-flight (TOF)
   - Quadrupole
   - Magnetic sector

3. **Detector**: Counts ions

### The Mass Spectrum

**X-axis**: m/z (mass-to-charge ratio)
**Y-axis**: Relative abundance

**Molecular ion (M⁺)**: Ionized intact molecule (gives molecular weight)

**Base peak**: Most intense peak (set to 100%)

### Fragmentation Patterns

**Cleavage**: Bonds break at weakest points

**Alkane fragmentation**:
- Cleavage at C-C bonds
- Forms smaller carbocations

**Carbocation stability**:
$$\text{tertiary} > \text{secondary} > \text{primary} > \text{methyl}$$

### Common Fragment Ions

**Alpha cleavage**: Break next to carbonyl
**McLafferty rearrangement**: γ-hydrogen transfer to carbonyl
**Tropylium ion**: Benzyl cation stabilization

### Isotopic Patterns

**Carbon**: ¹²C (98.9%) and ¹³C (1.1%)
**Chlorine**: ³⁵Cl (75%) and ³⁷Cl (25%) - M and M+2 pattern
**Bromine**: ⁷⁹Br (51%) and ⁸¹Br (49%) - M and M+2 equal

### Applications

**Molecular weight**: From M⁺ peak
**Molecular formula**: From high-resolution mass (exact mass)
**Structure**: From fragmentation pattern

## Sources
- Khan Academy: "Mass Spectrometry"
- OpenStax Organic Chemistry 1e (2015). "Spectroscopy"
- LibreTexts: "Spectroscopy"
',

  '[
    {
      "question": "What does the molecular ion peak (M⁺) in mass spectrometry represent?",
      "options": ["Most abundant fragment", "Intact ionized molecule", "Base peak set to 100%", "Isotopic pattern"],
      "correctAnswer": 1,
      "explanation": "The MOLECULAR ION PEAK (M⁺) represents the INTACT ionized molecule, giving the MOLECULAR WEIGHT. This is crucial information - the m/z value of M⁺ equals the molecular weight of the original compound. If M⁺ is absent or very weak, it suggests the compound easily fragments under the ionization conditions!"
    },
    {
      "question": "Why do chlorine-containing compounds show M and M+2 peaks of equal intensity?",
      "options": ["Chlorine has two electrons", "Chlorine has two isotopes (³⁵Cl 75% and ³⁷Cl 25%) with nearly equal abundance", "Chlorine forms dimers", "Chlorine fragments in two ways"],
      "correctAnswer": 1,
      "explanation": "Chlorine has two stable isotopes: ³⁵Cl (75.8%) and ³⁷Cl (24.2%). A compound with ONE chlorine atom shows TWO molecular ion peaks separated by 2 amu (mass units) - M from ³⁵Cl and M+2 from ³⁷Cl. The 3:1 ratio reflects the natural isotope abundances. This isotopic pattern is a diagnostic signature for chlorine-containing compounds!"
    },
    {
      "question": "What determines the fragmentation pattern in mass spectrometry?",
      "options": ["Molecular weight only", "Strength of bonds and stability of resulting carbocations", "Ionization energy only", "Detector sensitivity"],
      "correctAnswer": 1,
      "explanation": "Fragmentation occurs at WEAKEST BONDS and produces the MOST STABLE CARBOCATIONS. Cleavage follows carbocation stability: tertiary > secondary > primary > methyl. Bonds next to carbonyls or heteroatoms often break (α-cleavage). The fragmentation pattern reveals structural features like the presence of benzyl groups (tropylium ion at m/z 91)!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'spectroscopy-structural-analysis' LIMIT 1),
  'Combined Spectroscopy Problems',
  'combined-spectroscopy-problems',
  4,
  '# Combined Spectroscopy Problems

## Structure Determination Strategy

### Step 1: Determine Molecular Formula

**High-resolution MS**: Exact mass gives formula
**Isotopic patterns**: Reveal Cl, Br, S atoms

**Degree of unsaturation**:
$$\text{DOU} = C + 1 - \frac{H}{2} - \frac{X}{2} + \frac{N}{2}$$

Where X = halogens

### Step 2: Identify Functional Groups (IR)

**Characteristic absorptions**:
- O-H: 3200-3600 cm⁻¹ (alcohols, acids)
- C=O: 1700-1750 cm⁻¹ (carbonyls)
- C=C: 1620-1680 cm⁻¹ (alkenes)
- C≡C: 2100-2260 cm⁻¹ (alkynes)

### Step 3: Assemble Carbon Skeleton (¹³C NMR)

**Number of signals**: Different carbon environments
**Chemical shifts**: Identify sp³, sp², sp carbons
- sp³ (alkanes): 0-50 ppm
- sp² (alkenes): 100-150 ppm
- sp (alkynes): 65-90 ppm
- Carboxyl: 160-220 ppm

### Step 4: Add Hydrogens (¹H NMR)

**Splitting patterns**: Reveal connectivity
- **CH₃**: Quartet if next to CH₂
- **CH₂**: Sextet if next to CH₃ and CH

**Integration**: Count protons per environment

### Step 5: Verify Consistency

**Check**: All data consistent
- Sum of integrations = molecular formula H count
- Splitting matches proposed connectivity
- IR groups match NMR environments

## Example Problem

**MS**: Molecular ion at m/z 150
**IR**: Strong C=O at 1715 cm⁻¹, no O-H
**¹³C NMR**: 8 signals (carbons at 210, 170, 140, 130, 128, 125, 30, 15 ppm)
**¹H NMR**: Triplets integrating to 3H at 1.0 ppm, quartet integrating to 2H at 2.5 ppm

**Solution**: Ethyl benzoate (C₉H₁₀O₂, MW = 150)

## Sources
- Khan Academy: "Structure Determination"
- OpenStax Organic Chemistry 1e (2015). "Spectroscopy"
- LibreTexts: "Spectroscopy"
',

  '[
    {
      "question": "What information does the degree of unsaturation (DOU) formula provide?",
      "options": ["Number of hydrogen atoms only", "Number of rings plus π bonds in molecule", "Number of carbon atoms", "Molecular weight"],
      "correctAnswer": 1,
      "explanation": "The Degree of Unsaturation (DOU) or Index of Hydrogen Deficiency (IHD) tells you the total number of RINGS plus π BONDS in a molecule. Each double bond or ring counts as 1 DOU, triple bond counts as 2. DOU = C + 1 - H/2 - X/2 + N/2. This helps identify how many multiple bonds/rings must exist in the structure!"
    },
    {
      "question": "What does the ¹³C NMR chemical shift range 100-150 ppm indicate?",
      "options": ["sp³ carbons (alkanes)", "sp² carbons (alkenes and aromatics)", "sp carbons (alkynes)", "Carbonyl carbons"],
      "correctAnswer": 1,
      "explanation": "Chemical shifts of 100-150 ppm in ¹³C NMR indicate SP²-HYBRIDIZED CARBONS (alkenes and aromatics). These carbons are deshielded compared to sp³ carbons because the π electrons create ring currents. Alkenes appear 100-150 ppm, while aromatic carbons are typically 120-150 ppm. sp³ carbons appear further upfield (0-50 ppm)!"
    },
    {
      "question": "What splitting pattern does a CH₂ group next to a CH₃ group show in ¹H NMR?",
      "options": ["Singlet", "Doublet", "Triplet", "Quartet"],
      "correctAnswer": 3,
      "explanation": "A CH₂ group with 3 neighboring protons on an adjacent CH₃ (n=3) will split into 3+1 = 4 PEAKS (quartet) according to the n+1 rule. The three equivalent protons on CH₃ can have 4 possible spin combinations relative to the CH₂ protons, creating 4 slightly different magnetic environments. The relative intensities follow Pascal''s triangle (1:3:3:1)!"
    }
  ]',
  NOW()
);

