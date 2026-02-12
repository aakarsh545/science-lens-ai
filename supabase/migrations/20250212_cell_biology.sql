-- =====================================================
-- CELL BIOLOGY COURSE
-- Topics: Cell Structure, Membranes, Organelles, Division, Metabolism, Signaling
-- Difficulty: Beginner
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Cell Biology
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Cell Biology',
  'cell-biology',
  'Study the fundamental unit of life: cell structure, membranes, organelles, division, metabolism, and signaling. Learn how cells work, communicate, and reproduce.',
  'biology',
  'beginner',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: CELL STRUCTURE AND ORGANIZATION
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Cell Structure and Organization',
  'cell-structure-organization',
  'Understand the basic structure and organization of cells - from the cell membrane to the internal organization of organelles.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-structure-organization' LIMIT 1),
  'Introduction to Cells',
  'introduction-cells',
  1,
  '# Introduction to Cells

## What Is a Cell?

**Cell**: The basic structural and functional unit of all living organisms.

**Cell Theory** (developed 1838-1839):
1. All living things are composed of cells
2. Cells are the basic unit of structure and function in living organisms
3. All cells come from pre-existing cells

## Types of Cells

### Prokaryotic Cells

**Characteristics**:
- No nucleus (DNA floats freely in cytoplasm)
- No membrane-bound organelles
- Small (0.1-5.0 μm)
- Simple structure

**Examples**: Bacteria, Archaea

### Eukaryotic Cells

**Characteristics**:
- True nucleus with nuclear envelope
- Membrane-bound organelles
- Larger (10-100 μm)
- Complex internal structure

**Examples**: Animals, plants, fungi, protists

## Cell Theory Timeline

| Year | Scientist | Discovery |
|-------|-----------|------------|
| 1665 | Robert Hooke | Discovered "cells" in cork |
| 1830s | Schleiden & Schwann | All plants made of cells |
| 1838-1839 | Schleiden, Schwann, Virchow | Cell Theory developed |
| 1855 | Rudolph Virchow | "All cells come from cells" (omnis cellula e cellula) |
| 1931 | Modern cell biology | Complete cell theory established |

## Sources
- CK-12 Biology: "Cell Structure"
- Khan Academy: "Introduction to Cells"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the basic structural and functional unit of all living organisms?",
      "options": ["Atoms", "Molecules", "Cells", "Tissues"],
      "correctAnswer": 2,
      "explanation": "CELLS are the basic structural and functional unit of all living organisms according to Cell Theory (1838-1839). While organisms can be made of tissues, organs, and organ systems, the CELL is the smallest independent living unit that carries out all life processes. All living things are either single-celled (unicellular) or made of many cells (multicellular)!"
    },
    {
      "question": "What is the main difference between prokaryotic and eukaryotic cells?",
      "options": ["Eukaryotes have a nucleus, prokaryotes do not", "Prokaryotes are larger than eukaryotes", "Eukaryotes have membrane-bound organelles, prokaryotes have more", "Only eukaryotes can be multicellular"],
      "correctAnswer": 0,
      "explanation": "The KEY DIFFERENCE is that EUKARYOTES have a TRUE NUCLEUS (DNA enclosed within nuclear envelope) while PROKARYOTES lack a nucleus - their DNA floats freely in cytoplasm. Both have cell membranes and ribosomes, but eukaryotes are also larger and contain membrane-bound organelles like mitochondria and Golgi apparatus. This makes eukaryotes more complex!"
    },
    {
      "question": "Who first discovered and named 'cells' in 1665?",
      "options": ["Charles Darwin", "Robert Hooke", "Louis Pasteur", "Gregor Mendel"],
      "correctAnswer": 1,
      "explanation": "ROBERT HOOKE discovered cells in 1665 while examining cork under a microscope. He saw tiny box-like structures and called them 'cells' (from Latin 'cellula' meaning 'small room'). Hooke was actually looking at dead plant cell walls, not living cells, but his discovery and naming began the study of cell biology!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-structure-organization' LIMIT 1),
  'Cell Membrane Structure',
  'cell-membrane-structure',
  2,
  '# Cell Membrane Structure

## The Cell Membrane

**Plasma membrane**: Thin, flexible barrier that surrounds the cell.

**Structure**: Phospholipid bilayer with embedded proteins

## Phospholipid Bilayer

### Phospholipid Structure

**Components**:
1. **Phosphate head**: Hydrophilic (water-loving)
2. **Two fatty acid tails**: Hydrophobic (water-fearing)

$$\text{Head} + 2 \times \text{Tails}$$

**Arrangement**:
- Heads face OUTWARD (toward water)
- Tails face INWARD (away from water)

### Fluid Mosaic Model

**Proposed by S.J. Singer and G.L. Nicolson (1972)**

**Features**:
- **Mosaic**: Proteins float in lipid sea like tiles in mosaic
- **Fluid**: Lipids and proteins can move laterally

## Membrane Proteins

### Integral Proteins

**Transmembrane proteins**: Span entire membrane
- Channels (allow specific molecules through)
- Pumps (active transport using ATP)
- Receptors (detect signals)

### Peripheral Proteins

**Attached to surface**:
- Enzymes
- Structural proteins
- Recognition markers

## Carbohydrates

**Glycocalyx**: Carbohydrate coat on cell surface

**Functions**:
- Cell recognition
- Protection
- Adhesion

## Sources
- CK-12 Biology: "Cell Membranes"
- Khan Academy: "Fluid Mosaic Model"
- OpenStax Biology 2e: "Cell Membranes"
',

  '[
    {
      "question": "What is the fluid mosaic model of the cell membrane?",
      "options": ["Proteins form a solid barrier around the cell", "Phospholipids and proteins form a flexible, moving mosaic like tiles in fluid", "Carbohydrates form the main structure", "Lipids are stationary while proteins float around them"],
      "correctAnswer": 1,
      "explanation": "The FLUID MOSAIC MODEL (Singer & Nicolson, 1972) describes the membrane as a MOSAIC of proteins floating in a fluid sea of lipids. The lipid bilayer is FLUID - lipids and proteins can move laterally. Proteins are embedded like tiles in a mosaic, creating both structure and function. This replaced the earlier sandwich model!"
    },
    {
      "question": "Why do phospholipid tails face inward while heads face outward?",
      "options": ["Tails are attracted to the cytoplasm", "Heads are hydrophilic (attracted to water), tails are hydrophobic (avoid water)", "Tails provide structural support", "Heads need to be outside to capture food"],
      "correctAnswer": 1,
      "explanation": "Phospholipid TAILS are HYDROPHOBIC (water-fearing) so they face INWARD away from the watery environment inside and outside the cell. HEADS are HYDROPHILIC (water-loving) and face OUTWARD toward the water-based cytoplasm and external environment. This amphiphilic nature creates the stable bilayer that forms the membrane barrier!"
    },
    {
      "question": "What is function of glycocalyx on cell surface?",
      "options": ["Energy production", "Cell recognition and protection", "Protein synthesis", "DNA replication"],
      "correctAnswer": 1,
      "explanation": "The GLYCOCALYX is a carbohydrate coat on the cell surface involved in CELL RECOGNITION (identifying self vs non-self cells for immune system), PROTECTION (cushioning and protecting the membrane), and ADHESION (helping cells stick together). It acts as an identification card allowing cells to recognize and interact with each other!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-structure-organization' LIMIT 1),
  'Cytoplasm and Cytoskeleton',
  'cytoplasm-cytoskeleton',
  3,
  '# Cytoplasm and Cytoskeleton

## Cytoplasm

**Cytoplasm**: Gel-like substance inside cell membrane containing organelles.

**Components**:
- **Cytosol**: Liquid portion (mostly water)
- **Organelles**: Suspended structures
- **Cytoskeleton**: Protein fiber network

## Cytoskeleton

**Function**: Provides structural support, organization, and movement.

### Components

**Microfilaments** (Actin):
- Diameter: 7 nm
- Function: Cell movement, shape changes

**Intermediate filaments**:
- Diameter: 10 nm
- Function: Structural support

**Microtubules**:
- Diameter: 25 nm
- Function: Chromosome movement, organelle transport

### Dynamic Instability

**Rapid assembly and disassembly**:
- Microtubules: quick to assemble/disassemble
- Allows cell to change shape rapidly

## Motor Proteins

**Myosin**: Moves along actin filaments
**Dynein**: Moves along microtubules

**ATP provides energy** for movement

## Cytoplasmic Streaming

**Streaming**: Directed flow of cytoplasm

**Function**:
- Distributes nutrients
- Moves organelles
- Facilitates cell division

## Sources
- CK-12 Biology: "Cytoplasm and Cytoskeleton"
- Khan Academy: "Cytoskeleton"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the function of the cytoskeleton?",
      "options": ["Energy production", "Provides structural support, organization, and movement", "DNA packaging", "Protein synthesis"],
      "correctAnswer": 1,
      "explanation": "The CYTOSKELETON is a network of protein fibers (microfilaments, intermediate filaments, and microtubules) that provides STRUCTURAL SUPPORT, maintains CELL SHAPE, and enables MOVEMENT and intracellular transport. Unlike our skeleton (which is static), the cytoskeleton is DYNAMIC - it can rapidly assemble and disassemble allowing cells to change shape and divide!"
    },
    {
      "question": "What is the difference between cytosol and cytoplasm?",
      "options": ["Cytosol contains organelles, cytoplasm does not", "Cytosol is the solid portion, cytoplasm is liquid", "Cytosol is outside the nucleus, cytoplasm is inside", "No difference - they are the same thing"],
      "correctAnswer": 1,
      "explanation": "CYTOSOL is the liquid, gel-like portion of the cytoplasm (mostly water with dissolved substances) while ORGANELLES are the suspended structures within it. The cytoplasm includes BOTH the cytosol AND everything suspended in it. Cytosol fills the space between organelles and provides medium for diffusion and cellular processes!"
    },
    {
      "question": "What are motor proteins and what do they do?",
      "options": ["Produce ATP for the cell", "Move along cytoskeleton fibers using ATP energy", "Synthesize cytoskeleton components", "Transport nutrients across the membrane"],
      "correctAnswer": 1,
      "explanation": "Motor proteins like MYOSIN (moves along actin) and DYNEIN (moves along microtubules) convert ATP chemical energy into MECHANICAL WORK to move organelles, vesicles, or chromosomes along the cytoskeleton fibers. They \"walk\" directionally along the fibers, carrying cargo and enabling intracellular transport and cell division!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-structure-organization' LIMIT 1),
  'Nucleus and Ribosomes',
  'nucleus-ribosomes',
  4,
  '# Nucleus and Ribosomes

## The Nucleus

**Nucleus**: Control center of the cell containing genetic material.

### Nuclear Envelope

**Double membrane** with nuclear pores:
- Controls what enters/exits nucleus
- Protects DNA

**Nucleolus**: Site of ribosome assembly

### Chromatin and Chromosomes

**Chromatin**: DNA wrapped around histone proteins

$$\text{DNA} + \text{Histones} \rightarrow \text{Chromatin}$$

**Chromosomes**: Condensed chromatin (visible during division)

**Human cells**: 46 chromosomes (23 pairs)

### DNA Packaging

**Nucleosome**: DNA wrapped around histone core (8 histones)

**Hierarchy**:
1. DNA helix (2 nm wide)
2. Nucleosome (11 nm diameter)
3. Chromatin fiber (30 nm)
4. Condensed chromosome (700 nm diameter)

## Ribosomes

**Ribosome**: Site of protein synthesis.

**Structure**: Large and small subunits

### Protein Synthesis

**Transcription** (nucleus): DNA → mRNA

**Translation** (ribosome/cytoplasm): mRNA → Protein

$$\text{DNA} \xrightarrow{\text{transcription}} \text{mRNA} \xrightarrow{\text{translation}} \text{Protein}$$

**Central Dogma** (Crick 1958):
$$\text{DNA} \rightarrow \text{RNA} \rightarrow \text{Protein}$$

## Sources
- CK-12 Biology: "Nucleus and Ribosomes"
- Khan Academy: "Central Dogma"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the central dogma of molecular biology?",
      "options": ["Protein → DNA → RNA", "DNA → RNA → Protein", "RNA → DNA → Protein", "DNA → Protein → RNA"],
      "correctAnswer": 1,
      "explanation": "The CENTRAL DOGMA (Crick, 1958) states that genetic information flows: DNA → RNA → PROTEIN. DNA is transcribed into messenger RNA (transcription in nucleus), then mRNA is translated into protein (translation on ribosomes in cytoplasm). This unidirectional flow explains how genetic information becomes cellular structure and function!"
    },
    {
      "question": "What is the nucleolus?",
      "options": ["Site of DNA replication", "Site of ribosome synthesis and assembly", "Control center for cell division", "Storage area for RNA molecules"],
      "correctAnswer": 1,
      "explanation": "The NUCLEOLUS is a dense region within the nucleus where RIBOSOMAL RNA (rRNA) is synthesized and ribosomal subunits are ASSEMBLED. It is NOT the site of protein synthesis (that happens on ribosomes), but rather the \"factory\" that makes the ribosome components before they exit to the cytoplasm!"
    },
    {
      "question": "How is DNA packaged in the nucleus?",
      "options": ["DNA is wrapped around ATP molecules", "DNA is wrapped around histone proteins forming nucleosomes that coil into chromosomes", "DNA is packaged into RNA molecules", "DNA is free-floating in the nucleoplasm"],
      "correctAnswer": 1,
      "explanation": "DNA is WRAPPED AROUND HISTONE PROTEINS (positively charged) to form nucleosomes (DNA + 8 histones). These nucleosomes coil and fold into chromatin fibers, which further condense into visible chromosomes during cell division. This PACKAGING allows meters of DNA to fit into the microscopic nucleus!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-structure-organization' LIMIT 1),
  'Cell Types and Specialization',
  'cell-types-specialization',
  5,
  '# Cell Types and Specialization

## Cell Specialization

**Multicellular organisms**: Cells specialize for specific functions.

## Stem Cells

**Stem cell**: Unspecialized cell that can differentiate into any cell type.

### Types of Stem Cells

**Totipotent**: Can become ANY cell type (embryonic stem cells)

**Pluripotent**: Can become most cell types (adult stem cells)

**Multipotent**: Can become limited range of related cells

## Examples of Specialized Cells

### Muscle Cells

**Characteristics**:
- Contains many mitochondria (ATP production)
- Contractile proteins (actin, myosin)

**Function**: Movement and contraction

### Nerve Cells (Neurons)

**Structure**:
- Cell body (contains nucleus)
- Dendrites (receive signals)
- Axon (transmits signals)

**Synapse**: Junction between neurons

### Red Blood Cells

**Hemoglobin**: Binds oxygen (no nucleus = more space)

**Function**: Transport oxygen throughout body

### White Blood Cells

**Immune defense**:
- Attack pathogens
- Produce antibodies

## Plant Cells

### Guard Cells

**Function**: Control stomata openings

**Regulate**: Gas exchange (CO₂ in, O₂ and water vapor out)

## Sources
- CK-12 Biology: "Cell Specialization"
- Khan Academy: "Stem Cells"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is a stem cell?",
      "options": ["A cell that has stopped dividing", "A specialized cell that produces multiple identical cells", "An unspecialized cell that can differentiate into any cell type", "A cell that can only become muscle or nerve cells"],
      "correctAnswer": 2,
      "explanation": "A STEM CELL is an unspecialized cell capable of DIFFERENTIATING into any specialized cell type. TOTIPOTENT stem cells (like embryonic stem cells) can become ANY cell type in the body, while pluripotent cells can become most but not all types, and multipotent cells are limited to related lineages. This property makes them valuable for research and medicine!"
    },
    {
      "question": "Why do red blood cells have no nucleus?",
      "options": ["They are not true cells", "Having no nucleus makes them smaller for oxygen transport", "Losing the nucleus provides more space for hemoglobin", "They are not eukaryotic"],
      "correctAnswer": 1,
      "explanation": "Red blood cells lack a nucleus to provide MORE SPACE for HEMOGLOBIN. The additional room allows more hemoglobin molecules, increasing oxygen-carrying capacity. This is an adaptation - mature mammalian red blood cells eject their nucleus during development to maximize oxygen transport. Other blood cell types (white blood cells) do have nuclei!"
    },
    {
      "question": "What is the function of dendrites on a neuron?",
      "options": ["Transmit electrical signals to other neurons", "Produce neurotransmitters", "Receive signals from other neurons and conduct toward cell body", "Support and protect the neuron"],
      "correctAnswer": 2,
      "explanation": "DENDRITES are branched extensions that RECEIVE signals from other neurons and conduct them TOWARD the cell body. They are the INPUT structures of the neuron. The AXON transmits signals AWAY from the cell body to other neurons. This directional flow (dendrites → cell body → axon) allows nervous system communication!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: CELL MEMBRANE AND TRANSPORT
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Cell Membrane and Transport',
  'cell-membrane-transport',
  'Learn how materials move across cell membranes: passive diffusion, osmosis, and active transport pumps.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-membrane-transport' LIMIT 1),
  'Passive Transport',
  'passive-transport',
  1,
  '# Passive Transport

## What Is Passive Transport?

**Passive transport**: Movement of substances across cell membrane WITHOUT energy input.

**Types**: Diffusion and Osmosis

## Diffusion

**Diffusion**: Net movement from HIGH concentration to LOW concentration.

$$\text{High} \rightarrow \text{Low}$$

**Factors affecting rate**:
1. **Concentration gradient**: Steeper = faster
2. **Temperature**: Higher = faster
3. **Particle size**: Smaller = faster
4. **Membrane thickness**: Thinner = faster

### Facilitated Diffusion

**Channel proteins**: Provide passage for specific molecules

**Characteristics**:
- Specific (only certain molecules)
- Passive (no energy required)
- Saturable (can become full)

**Example**: Glucose transport in red blood cells

## Osmosis

**Osmosis**: Diffusion of WATER across selectively permeable membrane.

$$\text{H}_2\text{O} \rightarrow \text{Membrane} \rightarrow \text{H}_2\text{O}$$

**Tonicity**:
- **Isotonic**: Equal concentrations (no net movement)
- **Hypotonic**: Lower solute outside (water enters cell)
- **Hypertonic**: Higher solute outside (water leaves cell)

## Examples in Living Systems

### Plant Roots

**Root pressure**: Water enters by osmosis, creating turgor pressure

**Turgor pressure**: Presses cell membrane against cell wall

### Kidney Function

**Filtration**: Small molecules pass, blood cells retained

**Reabsorption**: Useful substances return to blood

## Sources
- CK-12 Biology: "Transport Across Membranes"
- Khan Academy: "Passive Transport"
- OpenStax Biology 2e: "Cell Membranes"
',

  '[
    {
      "question": "What is the difference between diffusion and osmosis?",
      "options": ["Diffusion requires energy, osmosis does not", "Diffusion moves solutes, osmosis moves water only", "Osmosis is passive transport, diffusion is active", "Diffusion is for small molecules, osmosis is for all molecules"],
      "correctAnswer": 1,
      "explanation": "DIFFUSION is the movement of ANY substances (solutes) from high to low concentration, while OSMOSIS is specifically the movement of WATER across a selectively permeable membrane. Both are passive (require no energy). Osmosis creates osmotic pressure due to water concentration differences, while diffusion equalizes solute concentrations!"
    },
    {
      "question": "What happens to an animal cell placed in a hypotonic solution?",
      "options": ["Water will leave the cell causing it to shrink", "Water will enter the cell causing it to swell and possibly burst", "No net movement of water occurs", "The cell will use active transport to restore balance"],
      "correctAnswer": 1,
      "explanation": "In a HYPOTONIC solution (lower solute concentration outside), WATER ENTERS the cell by osmosis. Without a cell wall to resist the pressure, the cell will SWELL and may potentially burst (lysis). This is why freshwater organisms must maintain water balance - their cells would gain too much water and burst in pure freshwater!"
    },
    {
      "question": "What is facilitated diffusion?",
      "options": ["Active transport using ATP pumps", "Passive movement of molecules through channel proteins", "Energy-independent movement of all molecules across the membrane", "Diffusion of water through the lipid bilayer"],
      "correctAnswer": 1,
      "explanation": "Facilitated diffusion is PASSIVE transport through PROTEIN CHANNELS that allow specific molecules to pass. Unlike simple diffusion through the lipid bilayer, these channels are SPECIFIC to certain molecules (like glucose), require NO ATP energy, and can become SATURATED (filled) when concentration gradient is high. They speed up transport while maintaining selectivity!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-membrane-transport' LIMIT 1),
  'Active Transport',
  'active-transport',
  2,
  '# Active Transport

## What Is Active Transport?

**Active transport**: Movement of substances AGAINST concentration gradient requiring ENERGY (ATP).

$$\text{Low} \xrightarrow{\text{ATP}} \text{High}$$

## Primary Active Transport

**Direct use of ATP**: Pump proteins use ATP energy directly.

**Examples**:
- **Sodium-potassium pump** (Na⁺/K⁺-ATPase):
  - Pumps 3 Na⁺ OUT, 2 K⁺ IN
  - Maintains resting membrane potential
  - Essential for nerve impulse propagation

- **Proton pump**: Plants create proton gradient for ATP synthesis
- **Calcium pump**: Muscle contraction, signaling

## Secondary Active Transport

**Coupled transport**: Uses energy from one gradient to move another substance.

**Sodium-glucose symport**:
- Na⁺ moving INTO cell (down gradient)
- Glucose moving INTO cell (against gradient)
- Energy from Na⁺ gradient drives glucose transport

**Antiport**: Two substances move SAME direction
**Symport**: Two substances move OPPOSITE directions

## Vesicular Transport

**Endocytosis**: Cell membrane folds inward, engulfing materials

**Exocytosis**: Vesicle fuses with membrane, releasing contents

**Phagocytosis**: \"Cell eating\" - engulfs large particles

## Bulk Transport

**Purpose**: Transport large quantities or materials that cannot cross membrane

## Sources
- CK-12 Biology: "Active Transport"
- Khan Academy: "Active Transport"
- OpenStax Biology 2e: "Cell Membranes"
',

  '[
    {
      "question": "What is the main difference between primary and secondary active transport?",
      "options": ["Primary uses diffusion, secondary uses ATP", "Primary directly uses ATP, secondary uses energy from ion gradients", "Secondary is for large molecules only, primary is for small molecules"],
      "correctAnswer": 1,
      "explanation": "PRIMARY active transport DIRECTLY uses ATP to pump substances against their gradient. SECONDARY active transport does NOT use ATP directly - instead it uses energy STORED in an electrochemical gradient (created by primary pumps) to drive transport of another substance. The Na⁺-glucose symport is a classic example of secondary active transport!"
    },
    {
      "question": "What does the sodium-potassium pump do?",
      "options": ["Pumps 3 K⁺ out and 2 Na⁺ out of the cell", "Pumps 3 Na⁺ in and 2 K⁺ out maintaining resting potential", "Moves 3 Na⁺ in and 2 K⁺ out using ATP energy", "Creates an electrical gradient used for nerve impulses"],
      "correctAnswer": 1,
      "explanation": "The Na⁺/K⁺-ATPase pump moves 3 SODIUM ions OUT of the cell and 2 POTASSIUM ions INTO the cell against their concentration gradients, using ATP energy. This creates and maintains the RESTING MEMBRANE POTENTIAL (negative inside) essential for nerve impulse propagation. This electrochemical gradient is later used for secondary transport!"
    },
    {
      "question": "What is endocytosis?",
      "options": ["Release of materials from the cell through vesicles", "Cell membrane folds inward to engulf external materials", "Breakdown of cell membrane using digestive enzymes", "Movement of ions through protein channels"],
      "correctAnswer": 1,
      "explanation": "ENDOCYTOSIS is the process by which the cell membrane folds INWARD to engulf external materials, forming a vesicle that brings substances INTO the cell. This is how cells take in large molecules, nutrients, or even whole microorganisms. The reverse process (EXOCYTOSIS) releases materials from the cell. Both are forms of bulk transport!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-membrane-transport' LIMIT 1),
  'Exocytosis and Endocytosis',
  'exocytosis-endocytosis',
  3,
  '# Exocytosis and Endocytosis

## Bulk Transport Mechanisms

**Vesicular transport**: Moving materials in/out via membrane-bound vesicles.

## Exocytosis

**Process**: Vesicle fusion with plasma membrane releasing contents OUTWARD.

### Types

**Constitutive exocytosis**: Continuous release (membrane repair, mucus secretion)

**Regulated exocytosis**: Signaled release (neurotransmitters, hormones)

### Steps

1. **Vesicle formation** (Golgi)
2. **Movement to membrane** (cytoskeleton)
3. **Docking** (v-SNARE proteins)
4. **Fusion**: Membranes merge, contents released

## Examples

**Neurotransmitters**: Chemical signals released from neurons
**Digestive enzymes**: Released to break down food
**Hormones**: Insulin, glucagon released into bloodstream

## Endocytosis

**Process**: Cell membrane folds INWARD engulfing external materials.

### Types

**Phagocytosis**: \"Cell eating\" - large particles like bacteria

$$\text{Bacteria} \rightarrow \text{Phagosome} \rightarrow \text{Lysosome}$$

**Pinocytosis**: \"Cell drinking\" - fluids and small solutes

**Receptor-mediated endocytosis**: Specific molecule uptake (e.g., cholesterol)

### Phagosome to Lysosome

**Digestion**: Enzymes break down engulfed material

## Sources
- CK-12 Biology: "Vesicular Transport"
- Khan Academy: "Exocytosis and Endocytosis"
- OpenStax Biology 2e: "Cell Membranes"
',

  '[
    {
      "question": "What is the main difference between exocytosis and endocytosis?",
      "options": ["Exocytosis uses energy, endocytosis does not", "Exocytosis releases materials from the cell, endocytosis brings materials in", "Exocytosis is for small molecules, endocytosis for large particles"],
      "correctAnswer": 1,
      "explanation": "EXOCYTOSIS releases materials FROM the cell by fusing vesicles with the plasma membrane - contents are expelled OUTWARD. ENDOCYTOSIS brings materials INTO the cell by folding membrane inward to engulf external substances. Both are bulk transport mechanisms that move materials that cannot pass directly through the membrane!"
    },
    {
      "question": "What is phagocytosis?",
      "options": ["Cell drinking of fluids", "Cell eating of large particles like bacteria", "Receptor-mediated uptake of specific molecules", "Breaking down of damaged organelles"],
      "correctAnswer": 1,
      "explanation": "PHAGOCYTOSIS (\"cell eating\") is the process where a cell engulfs LARGE PARTICLES like bacteria, dead cells, or debris by extending its membrane around them. The engulfed material becomes a phagosome which fuses with lysosomes for digestion. This is how immune cells (macrophages, neutrophils) destroy pathogens!"
    },
    {
      "question": "What role do SNARE proteins play in vesicular transport?",
      "options": ["They provide ATP for vesicle movement", "They mediate docking and fusion of vesicles with target membranes", "They synthesize new membrane for the vesicle", "They package materials into vesicles in the Golgi apparatus"],
      "correctAnswer": 1,
      "explanation": "SNARE proteins (Soluble NSF Attachment Protein REceptors) mediate the DOCKING and FUSION of vesicles with target membranes. V-SNARE on vesicles pairs with T-SNARE on target membrane, pulling membranes together until they fuse and contents are released. This specificity ensures vesicles deliver materials to correct locations!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 3: ORGANELLES
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Organelles',
  'organelles',
  'Explore membrane-bound compartments that perform specialized functions: nucleus, mitochondria, chloroplasts, ER, Golgi, and more.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 3
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'organelles' LIMIT 1),
  'Mitochondria',
  'mitochondria',
  1,
  '# Mitochondria

## The Powerhouse of the Cell

**Mitochondria**: Organelles that produce ATP through cellular respiration.

## Structure

**Double membrane**:
- Outer membrane smooth
- Inner membrane folded into cristae (increases surface area)

**Matrix**: Fluid-filled space inside inner membrane

### Mitochondrial DNA

Mitochondria have their own DNA (circular, like bacteria).

**Evidence for endosymbiosis**: Mitochondria evolved from engulfed bacteria.

## Cellular Respiration

**Stages**:

### Glycolysis (Cytoplasm)

$$\text{Glucose} + 2\text{ATP} + 2\text{NAD}^+ \rightarrow 2\text{Pyruvate}$$

**Products**: 2 pyruvate, 2 ATP, 2 NADH

### Pyruvate Oxidation (Mitochondrial matrix)

$$\text{Pyruvate} + \text{NAD}^+ \rightarrow \text{Acetyl-CoA} + \text{CO}_2$$

**Products**: 2 acetyl-CoA, 2 CO₂, 1 NADH

### Citric Acid Cycle (Matrix)

$$3 \times \text{Acetyl-CoA} + 6 \times \text{NAD}^+ + 2\text{FAD} \rightarrow 6 \times \text{NADH} + 2\text{FADH}_2 + 2\text{ATP} + \text{CO}_2$$

**Products**: 6 NADH, 2 FADH₂, 2 ATP (per glucose)

### Oxidative Phosphorylation (Inner membrane)

$$\text{NADH} + \text{FADH}_2 + \text{O}_2 \rightarrow \text{NAD}^+ + \text{FAD} + \text{ATP} + \text{H}_2\text{O}$$

**Products**: 32-34 ATP (per glucose)

## ATP Production Total

**Glycolysis**: 2 ATP (net)
**Citric Acid Cycle**: 2 ATP
**Oxidative Phosphorylation**: ~28-30 ATP
**Total**: ~32-34 ATP per glucose molecule

## Sources
- CK-12 Biology: "Mitochondria"
- Khan Academy: "Cellular Respiration"
- OpenStax Biology 2e: "Cell Respiration"
',

  '[
    {
      "question": "What is the total ATP yield from one glucose molecule?",
      "options": ["2 ATP", "30-32 ATP", "36-38 ATP", "40+ ATP"],
      "correctAnswer": 1,
      "explanation": "Complete cellular respiration of ONE GLUCOSE molecule yields approximately 30-32 ATP: 2 ATP from glycolysis (net), 2 ATP from citric acid cycle, and ~28-30 ATP from oxidative phosphorylation. The exact yield varies (some sources say 30, others 36) but 30-32 ATP is the commonly taught range. This high-yield process makes mitochondria the \"powerhouse\"!"
    },
    {
      "question": "What is the evidence that mitochondria evolved from bacteria?",
      "options": ["Mitochondria have a cell wall like bacteria", "Mitochondria have their own circular DNA like bacteria", "Mitochondria have double membranes unlike bacteria", "Mitochondria divide by binary fission like bacteria"],
      "correctAnswer": 1,
      "explanation": "Mitochondria have their OWN CIRCULAR DNA similar to bacterial DNA, supporting the ENDOSYMBIOSIS theory that mitochondria evolved from engulfed aerobic bacteria (proteobacteria) that became organelles. Other evidence: double membrane structure, ribosomes similar to bacterial ribosomes, and division by binary fission (similar to bacterial division)!"
    },
    {
      "question": "What is the function of cristae in mitochondria?",
      "options": ["Site of ATP synthesis", "Storage area for mitochondrial DNA", "Folded inner membrane that increases surface area for ATP production", "Transport channel for molecules entering mitochondria"],
      "correctAnswer": 2,
      "explanation": "CRISTAE are the folds in the mitochondrial inner membrane that DRAMATICALLY INCREASE SURFACE AREA. More surface area means more electron transport chain proteins and ATP synthase enzymes can be packed in, allowing GREATER ATP PRODUCTION. This adaptation maximizes energy output - cells with high energy demand have more cristae!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'organelles' LIMIT 1),
  'Chloroplasts',
  'chloroplasts',
  2,
  '# Chloroplasts

## Photosynthesis Organelles

**Chloroplasts**: Organelles in plant cells where photosynthesis occurs.

## Structure

**Double membrane** with inner sacs called **thylakoids**

**Stroma**: Fluid-filled space outside thylakoids (contains DNA, ribosomes)

**Grana**: Stacks of thylakoids (where light reactions occur)

## Photosynthesis Overview

**Equation**:
$$6\text{CO}_2 + 6\text{H}_2\text{O} \xrightarrow{\text{light}} \text{C}_6\text{H}_{12}\text{O}_6 + 6\text{O}_2$$

## Light-Dependent Reactions (Thylakoids)

### Purpose

**Split water**:
$$2\text{H}_2\text{O} \rightarrow 4\text{H}^+ + 4\text{e}^-$$

**Products**: Oxygen, electrons, H⁺ gradient

### Electron Transport Chain

**Process**:
- Electrons flow through protein complexes
- H⁺ pumped across thylakoid membrane
- ATP produced (chemiosmosis)

**Products**:
- ATP from chemiosmosis
- NADPH (electron carrier)

## Light-Independent Reactions (Calvin Cycle)

**Location**: Stroma (fluid outside thylakoids)

### Carbon Fixation

$$\text{CO}_2 + \text{RuBP} \rightarrow \text{G3P}$$

**Uses ATP and NADPH** from light reactions

### Products

**G3P**: Converts to glucose, other sugars

## Sources
- CK-12 Biology: "Chloroplasts"
- Khan Academy: "Photosynthesis"
- OpenStax Biology 2e: "Cell Respiration"
',

  '[
    {
      "question": "Where do the light-dependent reactions of photosynthesis occur?",
      "options": ["In the stroma (fluid outside thylakoids)", "On the thylakoid membranes where chlorophyll is located", "In the chloroplast outer membrane", "Throughout the entire chloroplast"],
      "correctAnswer": 1,
      "explanation": "Light-dependent reactions occur ON THE THYLAKOID MEMBRANES where chlorophyll and other photosystems are embedded. These membranes are stacked into GRANA to maximize light capture. The stroma contains enzymes for light-independent Calvin Cycle reactions, but the actual light capture and electron transport happen on the thylakoids!"
    },
    {
      "question": "What are the products of the light-dependent reactions?",
      "options": ["Glucose and water", "ATP, NADPH, and oxygen", "Carbon dioxide and RuBP", "Pyruvate and NADH"],
      "correctAnswer": 1,
      "explanation": "The light-dependent reactions produce THREE key products: 1) ATP through chemiosmosis (using H⁺ gradient), 2) NADPH as an electron carrier (from NADP⁺ reduction), and 3) OXYGEN as a byproduct of water splitting. These products (ATP and NADPH) are then USED in the Calvin Cycle to fix carbon dioxide into sugars!"
    },
    {
      "question": "What is the Calvin Cycle responsible for?",
      "options": ["Splitting water molecules to produce oxygen", "Converting light energy into ATP and NADPH", "Synthesizing chlorophyll and other pigments", "Carbon fixation - converting CO₂ into glucose and other sugars"],
      "correctAnswer": 3,
      "explanation": "The Calvin Cycle (light-independent reactions) is responsible for CARBON FIXATION - converting atmospheric CO₂ into organic molecules like glucose. Using ATP and NADPH from the light reactions, it fixes CO₂ into RuBP then G3P, eventually producing glucose. This is how photosynthesis creates stored chemical energy from atmospheric carbon!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'organelles' LIMIT 1),
  'Endoplasmic Reticulum and Golgi',
  'er-golgi',
  3,
  '# Endoplasmic Reticulum and Golgi

## Endoplasmic Reticulum (ER)

**ER**: Network of membranes throughout cytoplasm.

### Rough ER

**Studded with ribosomes** - synthesizes proteins destined for secretion or membrane insertion.

**Functions**:
- Protein synthesis (ribosomes)
- Folding and modification of proteins
- Calcium storage

### Smooth ER

**No ribosomes** - lipid synthesis, detoxification.

**Functions**:
- Lipid and steroid hormone synthesis
- Drug detoxification
- Calcium storage and release

## Golgi Apparatus

**Structure**: Stacks of flattened membranous sacs (cisternae).

### Functions

1. **Modification**: Add carbohydrates or other tags to proteins
2. **Sorting**: Separate proteins for different destinations
3. **Packaging**: Package into vesicles
4. **Shipping**: Release vesicles for transport

## Secretory Pathway

**ER → Golgi → Plasma membrane → Exocytosis**

$$\text{Protein} \xrightarrow{\text{ER synthesis}} \text{Golgi modification} \xrightarrow{\text{Vesicle}} \text{Release}$$

## Sources
- CK-12 Biology: "ER and Golgi"
- Khan Academy: "Golgi Apparatus"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the difference between rough and smooth ER?",
      "options": ["Rough ER synthesizes lipids, smooth ER synthesizes proteins", "Rough ER has ribosomes attached, smooth ER does not", "Rough ER is found only in muscle cells", "Smooth ER is responsible for protein synthesis"],
      "correctAnswer": 1,
      "explanation": "The key difference is that ROUGH ER is STUDDED WITH RIBOSOMES (giving it a 'rough' appearance under electron microscopy) and primarily synthesizes PROTEINS destined for secretion. SMOOTH ER lacks ribosomes and primarily synthesizes LIPIDS (including phospholipids and steroids), detoxifies drugs, and stores calcium. Both are interconnected membrane networks!"
    },
    {
      "question": "What are the main functions of the Golgi apparatus?",
      "options": ["DNA replication and transcription", "Protein modification, sorting, packaging, and shipping", "ATP production and protein synthesis", "Lipid synthesis and drug detoxification"],
      "correctAnswer": 1,
      "explanation": "The Golgi apparatus acts as a processing and DISTRIBUTION CENTER. It receives proteins from the ER, MODIFIES them (adds carbohydrates or other tags), SORTS them according to their final destination, and packages them into VESICLES for shipping to plasma membrane, lysosomes, or secretion. It's like the cell's postal service facility!"
    },
    {
      "question": "What is the secretory pathway from ER to cell exterior?",
      "options": ["ER → Nucleus → Golgi → Mitochondria", "ER → Golgi → Vesicles → Plasma membrane → Exocytosis", "ER → Lysosomes → Golgi → Cell membrane", "ER → Ribosomes → Proteins → Cell membrane"],
      "correctAnswer": 1,
      "explanation": "The standard secretory pathway is: PROTEIN SYNTHESIS in rough ER → TRANSPORT to Golgi apparatus in vesicles → MODIFICATION and PACKAGING in Golgi → VESICLE transport to plasma membrane → EXOCYTOSIS releasing contents outside cell. This pathway delivers membrane proteins, digestive enzymes, hormones, and other secreted products!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'organelles' LIMIT 1),
  'Lysosomes and Vacuoles',
  'lysosomes-vacuoles',
  4,
  '# Lysosomes and Vacuoles

## Lysosomes

**Lysosome**: Digestive organelle containing enzymes to break down materials.

### Structure

**Digestive enzymes** (hydrolases):
- Lipases (break down lipids)
- Proteases (break down proteins)
- Nucleases (break down nucleic acids)
- Glycosidases (break down carbohydrates)

**Acidic pH** (~5.0): Optimizes enzyme activity

### Functions

**Autophagy**: Recycle damaged organelles

$$\text{Damaged organelle} + \text{Lysosome} \rightarrow \text{Digestion}$$

**Phagocytosis digestion**: Break down engulfed particles

## Vacuoles

**Vacuole**: Storage organelle (especially prominent in plant cells).

### Plant Vacuoles

**Central vacuole**: Can occupy 80-90% of mature plant cell volume

**Functions**:
- **Turgor pressure**: Pushes cell membrane against wall
- **Storage**: Water, nutrients, pigments, waste
- **Defense**: Toxic compounds stored to deter herbivores

### Animal Vacuoles

**Smaller and multiple**:
- Food vacuoles (protozoa)
- Contractile vacuoles (water regulation)
- Storage vacuoles

## Sources
- CK-12 Biology: "Lysosomes and Vacuoles"
- Khan Academy: "Lysosomes"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the main function of lysosomes?",
      "options": ["Protein synthesis and lipid production", "Contain digestive enzymes to break down various cellular materials", "Energy production through cellular respiration", "Storage of genetic information"],
      "correctAnswer": 1,
      "explanation": "Lysosomes are the CELL'S RECYCLING CENTER containing 50+ different digestive ENZYMES (hydrolases) that break down lipids, proteins, carbohydrates, and nucleic acids. They digest worn-out organelles (autophagy), engulfed bacteria (phagocytosis), and other cellular debris. The acidic pH (~5.0) optimizes these enzymes for efficient breakdown!"
    },
    {
      "question": "What is the function of the central vacuole in plant cells?",
      "options": ["Protein synthesis", "Storage and maintaining turgor pressure against cell wall", "Chlorophyll production for photosynthesis", "DNA replication and cell division"],
      "correctAnswer": 1,
      "explanation": "The CENTRAL VACUOLE in plant cells can occupy 80-90% of cell volume and provides STORAGE for water, nutrients, pigments, and waste products. By filling with water, it creates TURGOR PRESSURE that pushes the plasma membrane against the rigid cell wall, maintaining plant STRUCTURE and rigidity. Without turgor pressure, plants would wilt!"
    },
    {
      "question": "How do vacuoles differ between plant and animal cells?",
      "options": ["Plant cells have one large vacuole, animal cells have many small ones", "Plant vacuoles store water only, animal vacuoles store nutrients", "Animal vacuoles provide turgor pressure, plant vacuoles do not", "Plant vacuoles are permanent, animal vacuoles are temporary"],
      "correctAnswer": 0,
      "explanation": "Plant cells typically have ONE LARGE CENTRAL VACUOLE that provides structural support (turgor pressure). Animal cells usually have MULTIPLE SMALLER vacuoles with specialized functions: food vacuoles (storage), contractile vacuoles (water balance in protozoa), and storage vacuoles. Both serve storage functions but plants rely more on the single large vacuole for structural support!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: CELL DIVISION AND CYCLE
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Cell Division and Cycle',
  'cell-division-cycle',
  'Study how cells reproduce: the cell cycle, mitosis, meiosis, and regulation of cell division.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-division-cycle' LIMIT 1),
  'The Cell Cycle',
  'cell-cycle',
  1,
  '# The Cell Cycle

## What Is the Cell Cycle?

**Cell cycle**: Series of events from one cell division to the next.

## Phases of the Cell Cycle

### Interphase

**Longest phase** (90% of cycle):
- Cell growth
- DNA replication
- Preparation for division

**Subphases**:

**G₁ (Gap 1)**: Cell grows, organelles duplicate

**S Phase (Synthesis)**: DNA replicates

$$\text{DNA} \rightarrow 2 \times \text{DNA}$$

**Semi-conservative**: One strand new, one strand conserved

**G₂ (Gap 2)**: Continued growth, preparation for mitosis

### Checkpoints

**G₁ checkpoint**: Ensures cell is large enough
**G₂ checkpoint**: Ensures DNA replication is complete
**M checkpoint**: Ensures chromosomes properly attached to spindle

## Mitosis (M Phase)

**Prophase**:
- Chromosomes condense
- Nuclear envelope breaks down
- Spindle forms

**Metaphase**:
- Chromosomes align at metaphase plate (equator)

**Anaphase**:
- Sister chromatids separate
- Move toward opposite poles

**Telophase**:
- Nuclear envelopes reform
- Chromosomes decondense
- Cytoplasm divides (cytokinesis)

## Cytokinesis

**Cytokinesis**: Division of cytoplasm.

**Animals**: Cleavage furrow forms
**Plants**: Cell plate forms

## Sources
- CK-12 Biology: "Cell Division"
- Khan Academy: "The Cell Cycle"
- OpenStax Biology 2e: "Cell Reproduction"
',

  '[
    {
      "question": "What happens during S phase of the cell cycle?",
      "options": ["Cell grows and organelles are duplicated", "DNA is replicated creating two identical copies", "Chromosomes are separated and moved to opposite poles", "The cell prepares for mitosis by breaking down the nuclear membrane"],
      "correctAnswer": 1,
      "explanation": "During S PHASE (Synthesis), DNA REPLICATION occurs - each chromosome is duplicated creating two identical sister chromatids. This is SEMI-CONSERVATIVE replication (one original strand serves as template, one new strand is synthesized). The cell now has 4N DNA content (twice the 2N of starting cell) preparing for division!"
    },
    {
      "question": "What is the purpose of cell cycle checkpoints?",
      "options": ["To slow down the cell cycle and conserve energy", "To ensure conditions are proper before proceeding to next phase", "To allow DNA to repair any damage before division", "To randomly stop division when cell becomes too old"],
      "correctAnswer": 1,
      "explanation": "Cell cycle checkpoints (G₁, G₂, and M) act as QUALITY CONTROL to prevent errors. G₁ ensures sufficient cell size/resources, G₂ verifies DNA replication is complete and undamaged, and M confirms proper chromosome attachment to spindle before anaphase. This prevents damaged or incompletely replicated cells from dividing!"
    },
    {
      "question": "What is the difference between metaphase and anaphase?",
      "options": ["Metaphase - sister chromatids separate and move to poles", "Anaphase - chromosomes align at the equator of the cell", "Metaphase occurs before anaphase", "Metaphase is for DNA replication, anaphase is for chromosome separation"],
      "correctAnswer": 1,
      "explanation": "In METAPHASE, chromosomes line up along the METAPHASE PLATE at the cell's equator, with spindle fibers attached to kinetochores on each chromatid. In ANAPHASE, sister chromatids SEPARATE and are pulled toward opposite poles by the shortening spindle fibers. Metaphase alignment ensures equal distribution, while anaphase movement creates the two daughter chromosome groups!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-division-cycle' LIMIT 1),
  'Meiosis',
  'meiosis',
  2,
  '# Meiosis

## What Is Meiosis?

**Meiosis**: Specialized cell division producing GAMETES (sex cells) with HALF the chromosomes.

$$2n \rightarrow n$$

## Meiosis I

**Prophase I**:
- Homologous chromosomes pair up (synapsis)
- Crossing over occurs (genetic exchange)
- Spindle forms

**Metaphase I**:
- Homologous pairs align at metaphase plate

**Anaphase I**:
- Homologous chromosomes separate
- Sister chromatids remain together

**Telophase I**:
- Two haploid nuclei form
- Brief interphase

## Meiosis II

**Prophase II**:
- No chromosome replication
- New spindle forms

**Metaphase II**:
- Chromosomes align at metaphase plate

**Anaphase II**:
- Sister chromatids separate
- Move toward poles

**Telophase II**:
- Four haploid nuclei form
- Cytokinesis

## Crossing Over

**Genetic recombination**: Exchange of DNA between homologous chromosomes.

**Significance**:
- Increases genetic variation
- Occurs at chiasmata during Prophase I
- Random breakage and exchange

## Sources
- CK-12 Biology: "Meiosis"
- Khan Academy: "Meiosis"
- OpenStax Biology 2e: "Cell Reproduction"
',

  '[
    {
      "question": "What is the main difference between mitosis and meiosis?",
      "options": ["Mitosis produces 4 daughter cells, meiosis produces 2", "Mitosis produces identical daughter cells, meiosis produces genetically different cells", "Mitosis is for growth and repair, meiosis is for reproduction", "Mitosis produces haploid cells, meiosis produces diploid cells"],
      "correctAnswer": 1,
      "explanation": "The KEY DIFFERENCE is that MITOSIS produces TWO IDENTICAL diploid daughter cells (2n → 2n) for growth and asexual reproduction, while MEIOSIS produces FOUR GENETICALLY DIFFERENT haploid gametes (2n → 4n). Mitosis maintains chromosome number; meiosis reduces it by half. Meiosis also includes crossing over for genetic variation!"
    },
    {
      "question": "What is crossing over and when does it occur?",
      "options": ["Separation of sister chromatids during anaphase I", "Exchange of genetic material between non-homologous chromosomes in mitosis", "Genetic recombination between homologous chromosomes during Prophase I of meiosis", "Duplication of chromosomes before meiosis begins"],
      "correctAnswer": 2,
      "explanation": "CROSSING OVER is the exchange of genetic material between HOMOLOGOUS chromosomes (matching pairs from each parent) that occurs during PROPHASE I of meiosis I. At sites called chiasmata, non-sister chromatids break and recombine, creating new combinations of genes. This increases genetic variation in offspring!"
    },
    {
      "question": "What is the chromosome number change from beginning to end of meiosis?",
      "options": ["2n → n (no change)", "2n → 2n (doubles)", "2n → 4n (doubles)", "2n → n (halves)"],
      "correctAnswer": 3,
      "explanation": "Meiosis reduces chromosome number by HALF: starting with DIPLOID (2n) cells and ending with FOUR HAPLOID (n) gametes. Each gamete has HALF the original chromosome number. When two gametes fuse during fertilization (n + n = 2n), the diploid chromosome number is restored in the offspring!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-division-cycle' LIMIT 1),
  'Regulation of Cell Division',
  'regulation-cell-division',
  3,
  '# Regulation of Cell Division

## Cell Cycle Control

**Checkpoints**: Ensure proper conditions before proceeding.

### Internal Controls

**Cyclin-dependent kinases (CDKs)**: Enzymes that drive cell cycle forward

**Cyclins**: Proteins that activate CDKs at specific times

$$\text{Cyclin} + \text{CDK} \rightarrow \text{Active kinase}$$

### Phases

**G₁/S cyclin**: Active in G₁ phase
**G₂/M cyclin**: Active in G₂ phase
**M-phase promoting factor (MPF)**: Triggers entry into mitosis

## External Controls

**Contact inhibition**: Cells stop dividing when crowded

**Anchorage dependence**: Cells must be attached to substrate to divide

**Growth factors**: External signals stimulate division

## Cancer

**Cancer**: Uncontrolled cell division.

**Characteristics**:
- No contact inhibition
- Ignore growth signals
- Bypass checkpoints
- Immortal cell line

## Apoptosis

**Programmed cell death**: Controlled cell suicide.

**Trigger**: DNA damage, viral infection, developmental signals

**Execution**:
- Cell shrinks
- DNA fragments
- Blebs form (apoptotic bodies)
- Phagocytic cells remove remains

## Sources
- CK-12 Biology: "Cancer"
- Khan Academy: "Cell Cycle Regulation"
- OpenStax Biology 2e: "Cell Reproduction"
',

  '[
    {
      "question": "What happens when cells lose contact inhibition?",
      "options": ["They divide more slowly", "They undergo apoptosis", "They continue dividing uncontrollably like cancer cells", "They stop dividing and enter G₀ phase"],
      "correctAnswer": 2,
      "explanation": "When cells lose CONTACT INHIBITION (normal cells stop dividing when they touch surrounding cells), they may undergo ANOIKIS - programmed cell death. Apoptosis eliminates unwanted or damaged cells in a controlled manner, unlike the uncontrolled proliferation seen in cancer where cells ignore inhibitory signals!"
    },
    {
      "question": "What is the role of cyclins and CDKs in the cell cycle?",
      "options": ["They inhibit cell division at checkpoints", "They are enzymes that break down the cell membrane", "Cyclins activate CDKs which drive the cell cycle forward", "They repair DNA damage before replication"],
      "correctAnswer": 2,
      "explanation": "Cyclins and CDKs form protein complexes that ACTIVATE at specific times - cyclins bind to and activate CDK (cyclin-dependent kinase) enzymes. Different cyclin-CDK combinations act at different phases: G₁/S cyclin in G₁, G₂/M cyclin in G₂, and M-phase promoting factor (MPF) triggers entry into mitosis. These are internal regulators controlling cell cycle progression!"
    },
    {
      "question": "What is apoptosis?",
      "options": ["Uncontrolled cell division seen in cancer", "Cell division that produces genetically identical cells", "Programmed cell death that eliminates unwanted or damaged cells", "Cell growth and division without mitosis"],
      "correctAnswer": 2,
      "explanation": "Apoptosis is PROGRAMMED CELL DEATH - a controlled process eliminating unwanted, damaged, or potentially dangerous cells. Unlike necrosis (accidental cell death), apoptosis involves cell shrinking, DNA fragmentation, blebbing, and phagocytic removal. It prevents cancer by eliminating cells before they become harmful!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-division-cycle' LIMIT 1),
  'Prokaryotic vs Eukaryotic Division',
  'prokaryotic-eukaryotic-division',
  4,
  '# Prokaryotic vs Eukaryotic Division

## Prokaryotic Cell Division

**Binary fission**: Simple division process.

**Process**:
1. DNA replicates
2. Cell elongates
3. Septum forms (division wall)
4. Cell splits

**Speed**: 20 minutes (E. coli)

## Eukaryotic Cell Division

**Mitosis**: Complex, multi-phase process.

**Time**: 1-2 hours (human cells)

**Complexity**:
- Multiple chromosomes
- Nuclear envelope breakdown/reformation
- Spindle apparatus
- Cytokinesis

## Comparison

| Feature | Prokaryotes | Eukaryotes |
|----------|--------------|-------------|
| Chromosome shape | Circular | Linear |
| Number | 1 (usually) | Multiple |
| Nucleus | No | Yes (breaks down/reforms) |
| Mitosis | Binary fission | Complex mitosis |
| Time | 20 minutes | 1-2 hours |

## FtsZ Proteins

**Filamenting temperature-sensitive**: Controls septum placement

**Ensures**: Each daughter gets DNA

## Sources
- CK-12 Biology: "Cell Division"
- Khan Academy: "Bacterial Division"
- OpenStax Biology 2e: "Cell Reproduction"
',

  '[
    {
      "question": "What is binary fission in prokaryotes?",
      "options": ["Process where two nuclei fuse to form diploid cell", "Division where cell splits into two identical daughter cells", "Method of sexual reproduction in bacteria", "Process where DNA is transferred between bacteria"],
      "correctAnswer": 1,
      "explanation": "BINARY FISSION is asexual reproduction where a prokaryotic cell splits into TWO IDENTICAL daughter cells. The process: DNA replicates, cell elongates, a septum (division wall) forms at midcell, and cell divides. Each daughter receives one copy of DNA. This simple process takes only ~20 minutes in E. coli!"
    },
    {
      "question": "Why is eukaryotic cell division more complex than prokaryotic?",
      "options": ["Eukaryotes have circular DNA, prokaryotes have linear", "Eukaryotes have multiple chromosomes, prokaryotes have one", "Eukaryotes use binary fission, eukaryotes use mitosis", "Eukaryotes are larger and need more energy to divide"],
      "correctAnswer": 1,
      "explanation": "Eukaryotic cell division is more complex because: 1) MULTIPLE LINEAR CHROMOSOMES (vs one circular) require careful alignment on a spindle, 2) NUCLEAR ENVELOPE must breakdown and reform, 3) Complex MITOSIS with multiple phases vs simple binary fission, 4) Cytokinesis divides cytoplasm, and 5) Takes 1-2 HOURS vs ~20 MINUTES for bacteria. This complexity allows precise chromosome distribution needed for larger genomes!"
    },
    {
      "question": "What is the function of FtsZ proteins in bacteria?",
      "options": ["They replicate bacterial DNA", "They control septum placement ensuring each daughter cell gets DNA", "They provide energy for binary fission", "They synthesize the cell wall for division"],
      "correctAnswer": 1,
      "explanation": "FtsZ proteins are FILAMENTOUS TEMPERATURE-SENSITIVE proteins that control SEPTUM PLACEMENT at the future division site in bacteria. By forming a ring at midcell, they ensure the septum forms between properly segregated chromosomes so EACH DAUGHTER CELL receives one copy of the genetic material. This prevents unequal distribution during binary fission!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: CELLULAR METABOLISM
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Cellular Metabolism',
  'cellular-metabolism',
  'Study how cells obtain and use energy: enzymes, glycolysis, cellular respiration, fermentation, and photosynthesis.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cellular-metabolism' LIMIT 1),
  'Enzymes',
  'enzymes',
  1,
  '# Enzymes

## What Are Enzymes?

**Enzyme**: Biological catalyst that speeds up chemical reactions.

## Enzyme Structure

**Active site**: Where substrate binds

**Activation energy**: Enzyme lowers energy needed for reaction

### Lock and Key Model

**Enzyme**: Lock
**Substrate**: Key

**Highly specific**: One enzyme fits one substrate

## Factors Affecting Enzyme Activity

### Temperature

**Optimum temperature**: Maximum activity

**Too high**: Denatures (unfolds)
**Too low**: Slow molecular motion

### pH

**Optimum pH**: Each enzyme has specific pH range

**Extreme pH**: Denatures enzyme

### Substrate Concentration

**More substrate** = Faster reaction (until saturation point)

## Enzyme Inhibition

### Competitive Inhibition

**Inhibitor**: Resembles substrate, competes for active site

**Overcome**: Add more substrate to outcompete inhibitor

### Noncompetitive Inhibition

**Inhibitor**: Binds elsewhere on enzyme

**Effect**: Reduces Vmax (maximum rate)

## Examples

**DNA polymerase**: Builds DNA during replication
**ATP synthase**: Makes ATP
**Catalase**: Breaks down hydrogen peroxide

## Sources
- CK-12 Biology: "Enzymes"
- Khan Academy: "Enzymes"
- OpenStax Biology 2e: "Bioenergetics"
',

  '[
    {
      "question": "What is the active site of an enzyme?",
      "options": ["The region where the enzyme is synthesized", "The specific region where substrate binds and reaction occurs", "The portion of the enzyme that provides energy for the reaction", "The area that gives the enzyme its three-dimensional shape"],
      "correctAnswer": 1,
      "explanation": "The ACTIVE SITE is the specific three-dimensional region on the enzyme where the SUBSTRATE binds and the chemical reaction is catalyzed. This site has a precise shape complementary to the substrate (like a lock and key). The enzyme-substrate complex is called the ENZYME-SUBSTRATE COMPLEX, and the active site determines reaction specificity!"
    },
    {
      "question": "What is the difference between competitive and noncompetitive enzyme inhibition?",
      "options": ["Both types block the active site permanently", "Competitive inhibition reduces Vmax, noncompetitive does not affect Vmax", "Noncompetitive binds to the enzyme-substrate complex, competitive binds to the active site", "Competitive can be overcome by adding more substrate, noncompetitive cannot be overcome"],
      "correctAnswer": 1,
      "explanation": "COMPETITIVE inhibitors resemble the substrate and BIND TO THE ACTIVE SITE, directly competing for access. They REDUCE the apparent affinity (increase Km) but DO NOT change Vmax because adding enough substrate can overcome them. NONCOMPETITIVE inhibitors bind ELSEWHERE on the enzyme, reducing its maximum velocity (Vmax) but cannot be overcome by adding more substrate!"
    },
    {
      "question": "What happens to enzymes at high temperatures?",
      "options": ["They work faster due to increased molecular motion", "They denature (unfold) and lose function", "They become more specific to their substrate", "High temperatures increase the activation energy of reactions"],
      "correctAnswer": 1,
      "explanation": "At HIGH TEMPERATURES, enzymes DENATURE - the three-dimensional structure UNFOLDS and the active site is destroyed. This is because the weak bonds maintaining protein structure (hydrogen bonds, etc.) break with heat. Denatured enzymes usually cannot refold and become permanently inactive. Each enzyme has an optimum temperature above which denaturation occurs!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cellular-metabolism' LIMIT 1),
  'ATP and Energy',
  'atp-energy',
  2,
  '# ATP and Energy

## ATP: The Energy Currency

**ATP (Adenosine Triphosphate)**: Primary energy carrier molecule.

## Structure

**Adenine** + **Ribose** + **Three phosphates**

$$\text{A-P} \sim \text{P} \sim \text{P}$$

**High-energy bonds**: Between phosphates

## ATP Hydrolysis

**Energy release**:
$$\text{ATP} + \text{H}_2\text{O} \rightarrow \text{ADP} + \text{P}_i + \text{Energy}$$

**ATP → ADP**: Lower energy state
**Energy released**: ~7.3 kcal/mol

## ATP Functions

**Cellular work**:
- Muscle contraction
- Active transport
- Nerve impulse propagation
- Protein synthesis
- Cell division

## ATP Production Methods

### Substrate-Level Phosphorylation

**Direct transfer** of phosphate to ADP

**Examples**:
- Glycolysis (net 2 ATP)
- Citric acid cycle (2 ATP)

### Oxidative Phosphorylation

**Chemiosmosis**: ATP production using H⁺ gradient

**Yield**: ~28-30 ATP (majority of cellular ATP)

## Other Energy Molecules

**GTP**: Guanosine triphosphate (protein synthesis)
**CTP**: Cytidine triphosphate (lipid synthesis)
**NADH**: Electron carrier (produces 2.5 ATP each)

## Sources
- CK-12 Biology: "ATP"
- Khan Academy: "ATP: Adenosine Triphosphate"
- OpenStax Biology 2e: "Bioenergetics"
',

  '[
    {
      "question": "What happens during ATP hydrolysis?",
      "options": ["ADP is converted to ATP with release of energy", "ATP reacts with water to form ADP, inorganic phosphate, and release of energy", "ATP is synthesized from ADP using solar energy", "Energy is stored in the phosphate bonds for later use"],
      "correctAnswer": 1,
      "explanation": "During ATP HYDROLYSIS, water breaks the high-energy phosphate bonds, converting ATP to ADP + inorganic phosphate (Pi) and RELEASING ENERGY (~7.3 kcal/mol). The last phosphate bond holds the most energy. This released energy powers nearly all cellular work - from muscle contraction to active transport to biosynthesis!"
    },
    {
      "question": "What is the main difference between substrate-level phosphorylation and oxidative phosphorylation?",
      "options": ["Substrate-level uses oxygen, oxidative does not", "Substrate-level directly transfers phosphate to ADP, oxidative uses chemiosmosis", "Substrate-level produces 2 ATP, oxidative produces 28-30 ATP", "Substrate-level occurs in cytoplasm, oxidative occurs in mitochondria"],
      "correctAnswer": 1,
      "explanation": "SUBSTRATE-LEVEL PHOSPHORYLATION directly transfers a phosphate group from a substrate molecule to ADP, producing a small amount of ATP (net 2 from glycolysis). OXIDATIVE PHOSPHORYLATION uses the H⁺ gradient across the inner mitochondrial membrane (chemiosmosis) to produce MUCH more ATP (~28-30). Most cellular ATP comes from oxidative phosphorylation!"
    },
    {
      "question": "What is chemiosmosis?",
      "options": ["Diffusion of water across a selectively permeable membrane", "Movement of ions down their electrochemical gradient generating ATP", "Synthesis of ATP from ADP using solar energy", "Active transport of protons across the mitochondrial membrane"],
      "correctAnswer": 1,
      "explanation": "CHEMIOSMOSIS is the movement of ions (usually H⁺) DOWN their electrochemical gradient through ATP synthase, which simultaneously uses this flow to PHOSPHORYLATE ADP (add phosphate). The ion gradient is maintained by electron transport chain, and the energy released is used to make ATP. It couples exergonic ion flow to endergonic phosphorylation!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cellular-metabolism' LIMIT 1),
  'Cellular Respiration',
  'cellular-respiration',
  3,
  '# Cellular Respiration

## What Is Cellular Respiration?

**Cellular respiration**: Process that breaks down glucose to produce ATP.

## Stages of Aerobic Respiration

### Glycolysis (Cytoplasm)

**Glucose breakdown**:
$$\text{C}_6\text{H}_{12}\text{O}_6 + 2\text{NAD}^+ + 2\text{ADP} + 2\text{P}_i \rightarrow 2\text{Pyruvate} + 2\text{ATP} + 2\text{NADH}$$

**Location**: Cytoplasm
**Products**: 2 pyruvate, 2 ATP (net), 2 NADH

### Pyruvate Oxidation (Mitochondria)

**Pyruvate to Acetyl-CoA**:
$$2 \times \text{Pyruvate} + 2 \times \text{NAD}^+ + 2 \times \text{CoA} \rightarrow 2 \times \text{Acetyl-CoA} + 2 \times \text{CO}_2 + 2 \times \text{NADH}$$

**Products**: 2 acetyl-CoA, 2 CO₂, 2 NADH

### Citric Acid Cycle (Mitochondrial Matrix)

$$3 \times \text{Acetyl-CoA} + 6 \times \text{NAD}^+ + 2 \times \text{FAD} + 2\text{ADP} + 2\text{P}_i \rightarrow 6 \times \text{NADH} + 2 \times \text{FADH}_2 + 2\text{ATP} + \text{CO}_2$$

**Products**: 6 NADH, 2 FADH₂, 2 ATP

### Oxidative Phosphorylation (Inner Membrane)

**Electron transport chain**:
$$\text{NADH} + \text{FADH}_2 + \text{O}_2 \rightarrow \text{NAD}^+ + \text{FAD} + \text{ATP} + \text{H}_2\text{O}$$

**ATP yield**: ~28-30 ATP

**Electron acceptor**: Oxygen (forms water)

## Anaerobic Respiration

**Fermentation**: Glycolysis without citric acid cycle or oxidative phosphorylation.

**Lactate fermentation** (animals):
$$\text{Pyruvate} + \text{NADH} \rightarrow \text{Lactate} + \text{NAD}^+$$

**Alcoholic fermentation** (yeast):
$$\text{Pyruvate} \rightarrow \text{Ethanol} + \text{CO}_2$$

## Sources
- CK-12 Biology: "Cellular Respiration"
- Khan Academy: "Cellular Respiration"
- OpenStax Biology 2e: "Cell Respiration"
',

  '[
    {
      "question": "What is the net ATP production from glycolysis?",
      "options": ["2 ATP", "4 ATP", "8 ATP", "36 ATP"],
      "correctAnswer": 0,
      "explanation": "Glycolysis produces a GROSS of 4 ATP but uses 2 ATP in the investment phase, resulting in a NET YIELD of 2 ATP per glucose molecule. This ATP is produced in the cytoplasm during the energy payoff phase. The 2 NADH produced will later yield more ATP (~5 ATP) through oxidative phosphorylation!"
    },
    {
      "question": "What happens during the citric acid cycle?",
      "options": ["Glucose is completely broken down releasing all energy as heat", "Each acetyl-CoA produces 1 ATP and 3 NADH while releasing 2 CO₂", "Pyruvate is converted to glucose", "Electrons are extracted from NADH and FADH₂"],
      "correctAnswer": 1,
      "explanation": "In the citric acid cycle (Krebs cycle), each acetyl-CoA entering is completely oxidized, releasing 2 CO₂ per turn (turns twice per glucose). The cycle produces 3 NADH, 1 FADH₂, and 1 ATP per turn. These high-energy electron carriers (NADH, FADH₂) will drive oxidative phosphorylation to produce the majority of ATP!"
    },
    {
      "question": "Why does oxidative phosphorylation produce the most ATP?",
      "options": ["Because it is the longest process in cellular respiration", "Because it uses the high-energy electrons from NADH to create a proton gradient", "Because oxygen is the final electron acceptor", "Because the electron transport chain has the most protein complexes"],
      "correctAnswer": 1,
      "explanation": "Oxidative phosphorylation produces the most ATP (~28-30) because it harnesses the energy from the HIGH-ENERGY ELECTRONS carried by NADH and FADH₂. These electrons flow through the electron transport chain, pumping protons to create the electrochemical gradient (chemiosmosis). The H⁺ gradient drives ATP synthase, with oxygen as the final electron acceptor forming water!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cellular-metabolism' LIMIT 1),
  'Photosynthesis Overview',
  'photosynthesis-overview',
  4,
  '# Photosynthesis Overview

## What Is Photosynthesis?

**Photosynthesis**: Process converting light energy into chemical energy (glucose).

## Location

**Chloroplasts** (plants):
- Thylakoids (light reactions)
- Stroma (Calvin cycle)

**Light-dependent vs Light-independent**:
- Light reactions: Require light, produce ATP and NADPH
- Dark reactions: Use ATP/NADPH to fix CO₂

## Light-Dependent Reactions

### Photosystem II

**Splits water**:
$$2\text{H}_2\text{O} \rightarrow 4\text{H}^+ + 4\text{e}^- + \text{O}_2$$

**Byproduct**: Oxygen

**Products**: ATP, NADPH

### Photosystem I

**Cyclic electron flow**:
- Produces ATP only
- Replaces electrons lost by Photosystem II

## Light-Independent Reactions (Calvin Cycle)

### Carbon Fixation

**RuBP (Ribulose-1,5-bisphosphate)**: Accepts CO₂

**Rubisco**: Enzyme catalyzing carbon fixation

$$\text{CO}_2 + \text{RuBP} \rightarrow \text{G3P}$$

### ATP and NADPH Use

**G3P reduction**: Uses ATP and NADPH to make G3P

**Glucose synthesis**: 2 G3P → glucose

## Overall Equation

$$6\text{CO}_2 + 6\text{H}_2\text{O} + \text{light energy} \rightarrow \text{C}_6\text{H}_{12}\text{O}_6 + 6\text{O}_2$$

## Sources
- CK-12 Biology: "Photosynthesis"
- Khan Academy: "Photosynthesis"
- OpenStax Biology 2e: "Photosynthesis"
',

  '[
    {
      "question": "What is the main product of the light-dependent reactions?",
      "options": ["Glucose and other sugars", "ATP and NADPH only", "Carbon dioxide and water", "Oxygen and hydrogen ions"],
      "correctAnswer": 1,
      "explanation": "The light-dependent reactions produce ATP (through chemiosmosis) and NADPH (through electron transport) but do NOT directly produce sugars. Oxygen is released as a byproduct of water splitting. The ATP and NADPH are then USED in the Calvin Cycle (light-independent reactions) to fix CO₂ and produce glucose. Light reactions capture energy; dark reactions use it!"
    },
    {
      "question": "What is the role of RuBP in the Calvin Cycle?",
      "options": ["It is the enzyme that fixes carbon dioxide", "It accepts CO₂ and forms glucose directly", "It stores solar energy as ATP", "It is the final product of photosynthesis"],
      "correctAnswer": 0,
      "explanation": "RuBP (ribulose-1,5-bisphosphate) is a 5-carbon sugar that ACCEPTS CO₂ from the atmosphere. The enzyme RUBISCO catalyzes the attachment of CO₂ to RuBP, which is then converted into G3P (using ATP) and eventually into glucose. RuBP is continuously RECYCLED within the Calvin Cycle - it''s not consumed but regenerated!"
    },
    {
      "question": "Why do plants need light for photosynthesis?",
      "options": ["Light provides carbon atoms for glucose synthesis", "Light energy is converted to ATP to power the Calvin Cycle", "Light splits water to provide electrons for the electron transport chain", "Light is required to activate chlorophyll molecules"],
      "correctAnswer": 1,
      "explanation": "Light provides the ENERGY needed to convert carbon dioxide (low energy) into glucose (high energy). The light reactions capture photons to excite electrons, creating proton gradients for ATP synthesis and NADPH production. This ATP and NADPH then power the Calvin Cycle to fix CO₂ into sugar. Without light energy, the carbon-fixing reactions cannot proceed!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 6: CELL SIGNALING AND COMMUNICATION
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'cell-biology' LIMIT 1),
  'Cell Signaling and Communication',
  'cell-signaling-communication',
  'Learn how cells communicate: chemical signals, membrane receptors, signal transduction pathways, and cell-to-cell recognition.',
  6,
  NOW()
);

-- LESSONS FOR CHAPTER 6
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-signaling-communication' LIMIT 1),
  'Chemical Signaling',
  'chemical-signaling',
  1,
  '# Chemical Signaling

## Cell Signaling

**Cell signaling**: Communication between cells using chemical messengers.

## Types of Signaling Molecules

### Autocrine Signaling

**Cell signals to itself**:

**Example**: Immune cells release cytokines to stimulate their own response

### Paracrine Signaling

**Cell signals to nearby cells**:

**Example**: Pancreas releases insulin (signals liver to store glucose)

### Endocrine Signaling

**Hormones travel through bloodstream**:

**Example**: Pituitary releases growth hormone (affects entire body)

### Juxtacrine Signaling

**Cell signals to touching cells**:

**Example**: Immune cell contact (direct membrane-to-membrane)

## Signaling Molecules

### Neurotransmitters

**Synaptic transmission**:
- Nerve cell releases neurotransmitters
- Diffuse across synapse
- Bind to receptors on next neuron

**Examples**: Dopamine, serotonin, acetylcholine

### Hormones

**Long-range signaling**:

**Steroid hormones** (derived from cholesterol):
- Estrogen, testosterone
- Can pass through membranes

**Peptide hormones**:
- Insulin, glucagon
- Bind to surface receptors

## Sources
- CK-12 Biology: "Cell Signaling"
- Khan Academy: "Cell Signaling"
- OpenStax Biology 2e: "Cell Communication"
',

  '[
    {
      "question": "What is the difference between paracrine and endocrine signaling?",
      "options": ["Paracrine signals affect distant cells, endocrine affects nearby cells", "Paracrine signals travel through the bloodstream, endocrine signals affect the signaling cell itself", "Paracrine is for local communication, endocrine is for long-distance"],
      "correctAnswer": 3,
      "explanation": "PARACRINE signaling targets NEARBY CELLS (local communication) - signaling molecules diffuse through extracellular fluid to nearby cells. ENDOCRINE signaling uses the BLOODSTREAM to reach DISTANT TARGETS throughout the body. Paracrine examples include neurotransmitters (local), while endocrine examples include hormones (long-distance). Range and delivery method are the key differences!"
    },
    {
      "question": "What is the main difference between steroid and peptide hormones?",
      "options": ["Steroid hormones are proteins, peptide hormones are lipids", "Steroid hormones can pass through cell membranes, peptide hormones cannot", "Steroid hormones are slower acting, peptide hormones are faster acting", "Steroid hormones are made from amino acids, peptide hormones are made from cholesterol"],
      "correctAnswer": 1,
      "explanation": "STERIOD hormones (estrogen, testosterone) are LIPID-SOLUBLE and can DIFFUSE directly through cell membranes to bind intracellular receptors. PEPTIDE hormones (insulin, glucagon) are WATER-SOLUBLE proteins that CANNOT pass through membranes and must bind to SURFACE receptors. This difference affects how quickly each type acts and their mechanism of action!"
    },
    {
      "question": "What is a neurotransmitter?",
      "options": ["A chemical that stimulates the signaling cell to release hormones", "A chemical messenger released from neurons that transmits signals to other neurons", "A protein that creates receptors on target cells", "A hormone released by the brain"],
      "correctAnswer": 1,
      "explanation": "NEUROTRANSMITTERS are chemical messengers released from AXON TERMINALS of neurons that diffuse across the SYNAPTIC CLEFT to bind receptors on the POSTSYNAPTIC neuron. This transmits the electrical signal from one neuron to the next. Examples include dopamine, serotonin, GABA, and acetylcholine. They are rapidly cleared to ensure precise signaling!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-signaling-communication' LIMIT 1),
  'Signal Transduction',
  'signal-transduction',
  2,
  '# Signal Transduction

## Signal Transduction Pathways

**Signal transduction**: Process by which a cell converts an external signal into a cellular response.

## Reception

**Cell surface receptors**: Detect signaling molecules.

### Types of Receptors

**G-protein coupled receptors**:
- Receptor activates G-protein
- G-protein activates effector enzyme

**Enzyme-linked receptors**:
- Receptor is itself an enzyme
- Binding activates enzymatic activity

**Ion channel receptors**:
- Ligand binding opens ion channel
- Ions flow through (depolarization)

## Transduction

**Second messengers**: Amplify the signal.

**Examples**:
- **cAMP** (cyclic AMP): Activates protein kinase A
- **cGMP**: Similar role in vision
- **IP₃**: Calcium release from ER

**Protein kinase cascade**: Series of phosphorylation events

$$\text{Signal} \rightarrow \text{Receptor} \rightarrow \text{Protein kinase} \rightarrow \text{Phosphorylation}$$

## Response

### Cellular Responses

**Gene expression changes**:
- New proteins synthesized
- Existing proteins degraded

**Metabolic changes**:
- Enzymes activated/inhibited
- Cytoskeleton rearranged

**Migration**:
- Cells move toward/away from signal

## Examples

**Epinephrine**: Binds receptor → G-protein → Adenylate cyclase → cAMP → Protein kinase A → Glycogen breakdown

**Insulin signaling**:
- Insulin binds receptor → Autophosphorylation → Glucose transporter activation → Glucose uptake

## Sources
- CK-12 Biology: "Signal Transduction"
- Khan Academy: "Signal Transduction"
- OpenStax Biology 2e: "Cell Communication"
',

  '[
    {
      "question": "What is a second messenger?",
      "options": ["A signaling molecule that travels through the bloodstream to distant cells", "An intracellular molecule that amplifies the signal from membrane receptors", "A protein that creates the cellular response to the signal", "The final product of signal transduction"],
      "correctAnswer": 1,
      "explanation": "SECOND MESSENGERS are small, diffusible molecules (like cAMP, cGMP, IP₃, Ca²⁺) that RELAY and AMPLIFY signals from membrane receptors to target proteins inside the cell. They allow one receptor to activate multiple effector proteins, greatly amplifying the original signal. This creates a cascade effect for precise cellular control!"
    },
    {
      "question": "What is the role of protein kinases in signal transduction?",
      "options": ["They synthesize second messenger molecules", "They add phosphate groups to proteins to activate or inhibit them", "They break down signaling molecules after the response is complete", "They transport signaling molecules across the cell membrane"],
      "correctAnswer": 1,
      "explanation": "Protein kinases are enzymes that TRANSFER PHOSPHATE GROUPS from ATP to specific target proteins (PHOSPHORYLATION). This addition/removal of phosphate acts like a switch - turning proteins ON or OFF to activate, inactivate, or mark them for degradation. This reversible modification allows rapid, precise control of cellular processes like growth and metabolism!"
    },
    {
      "question": "How does the epinephrine signaling pathway work?",
      "options": ["Epinephrine directly causes glycogen synthesis", "Epinephrine binds receptor activating a G-protein which inhibits adenylate cyclase", "Epinephrine is converted to cAMP which directly activates protein kinase A", "Epinephrine causes glucose channels to open releasing stored glucose"],
      "correctAnswer": 1,
      "explanation": "Epinephrine binds to a G-protein coupled receptor, which INHIBITS adenylate cyclase (the enzyme that makes cAMP). With adenylate cyclase inhibited, cAMP levels DROP. But wait - G-protein also ACTIVATES a different enzyme (phosphodiesterase) that DEGRADES cAMP! The net effect is actually increased cAMP, activating protein kinase A and triggering glycogen breakdown!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-signaling-communication' LIMIT 1),
  'Cell Adhesion and Recognition',
  'cell-adhesion-recognition',
  3,
  '# Cell Adhesion and Recognition

## Cell Junctions

**Cell junctions**: Specialized connections between adjacent cells.

### Tight Junctions

**Function**: Prevent leakage between cells

**Location**: Epithelial cells (lining organs)

**Structure**:
- Membrane proteins woven together
- Creates water-tight seal

### Gap Junctions

**Function**: Communication channels

**Structure**:
- Connexons form channels (connexons)
- Allow ion passage and electrical signals

### Desmosomes

**Function**: Mechanical attachment

**Structure**:
- Intermediate filaments attach to cell adhesion molecules
- Rivets cells together

## Extracellular Matrix

**ECM**: Non-cellular material providing structural support.

**Components**:
- **Collagen**: Strong fibers (tensile strength)
- **Proteoglycans**: Gel-like filling
- **Integrins**: Cell adhesion receptors

**Functions**:
- Cell anchorage
- Tissue organization
- Growth factor binding

## Cell Adhesion Molecules (CAMs)

**Cadherins**: Calcium-dependent adhesion
- **Integrins**: Bind to ECM proteins
- **Selectins**: Cell-cell recognition

### Homophilic Binding

**Like binds like**:
- Cell sorts itself (aggregates)
- Tissue formation

## Immune Recognition

### MHC Proteins

**MHC (Major Histocompatibility Complex)**:
- Present antigen fragments on cell surface
- T cells recognize self vs non-self

**Class I MHC**: Found on all nucleated cells
**Class II MHC**: Found only on antigen-presenting cells

## Sources
- CK-12 Biology: "Cell Junctions"
- Khan Academy: "Cell Junctions and Adhesion"
- OpenStax Biology 2e: "Cell Structure"
',

  '[
    {
      "question": "What is the main difference between tight junctions and gap junctions?",
      "options": ["Tight junctions allow passage of materials between cells, gap junctions prevent leakage", "Tight junctions are for mechanical support, gap junctions are for communication", "Tight junctions use cadherins, gap junctions use connexons", "Tight junctions are found only in epithelial cells, gap junctions are found in many tissues"],
      "correctAnswer": 1,
      "explanation": "TIGHT JUNCTIONS create a WATER-TIGHT seal between cells, PREVENTING LEAKAGE of solutes and water. GAP JUNCTIONS are intercellular CHANNELS formed by connexons that allow COMMUNICATION (ion passage, electrical signals). Tight junctions are common in epithelia (barrier tissues), while gap junctions allow controlled exchange between connected cells!"
    },
    {
      "question": "What is the extracellular matrix?",
      "options": ["The fluid space inside the cell membrane", "The network of proteins that makes up the cytoskeleton", "Non-cellular material outside cells providing structural support", "The space between adjacent cells"],
      "correctAnswer": 2,
      "explanation": "The EXTRACELLULAR MATRIX (ECM) is a complex network of proteins (especially COLLAGEN for strength) and proteoglycans filling the space OUTSIDE cells. It provides structural support for tissues, helps with cell anchorage via integrins, organizes tissue, and binds growth factors. The ECM is distinct from cytoplasm or intercellular space!"
    },
    {
      "question": "What is the function of MHC proteins?",
      "options": ["They produce antibodies to tag pathogens for destruction", "They present antigen fragments on cell surface for T cell recognition", "They create holes in pathogen membranes to destroy them", "They secrete signaling molecules to attract immune cells"],
      "correctAnswer": 1,
      "explanation": "MHC (Major Histocompatibility Complex) proteins are cell surface receptors that DISPLAY ANTIGEN FRAGMENTS for inspection by T cells. This allows the immune system to distinguish SELF (normal MHC) from NON-SELF (foreign antigens). Class I MHC is on all nucleated cells, while Class II is specialized for antigen-presenting cells. This is key to immune recognition!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'cell-signaling-communication' LIMIT 1),
  'Apoptosis',
  'apoptosis',
  4,
  '# Apoptosis

## What Is Apoptosis?

**Apoptosis**: Programmed cell death (\"cell suicide\").

## Purpose of Apoptosis

**Development**: Shaping tissues (removes webbing between fingers)
**Homeostasis**: Eliminating old or damaged cells
**Defense**: Virus-infected cells sacrifice themselves

## Apoptosis vs Necrosis

| Feature | Apoptosis | Necrosis |
|----------|-----------|----------|
| Trigger | Programmed, controlled | Accidental, uncontrolled |
| Cell swelling | No | Yes (cell bursts) |
| Inflammation | No | Yes |
| Energy | ATP required | No energy required |
| Phagocytosis | Orderly removal | Chaos, releases contents |

## Apoptotic Pathways

### Intrinsic Pathway (Mitochondrial)

**Trigger**: DNA damage, cellular stress

**Process**:
1. Pro-apoptotic proteins (Bax, Bak) permeabilize mitochondria
2. Cytochrome c released
3. Caspase cascade activated
4. Cell dismantles

### Extrinsic Pathway (Death Receptor)

**Trigger**: External death signals (Fas ligand)

**Process**:
1. Fas receptor binds Fas ligand
2. FADD protein recruited
3. Caspase-8 activated
4. Caspase cascade (execution phase)

## Execution Phase

**Caspases**: Proteases that dismantle cell

**Targets**:
- Nuclear lamins (break down nucleus)
- Cytoskeletal proteins
- DNA fragmentation
- Formation of apoptotic bodies

## Sources
- CK-12 Biology: "Apoptosis"
- Khan Academy: "Apoptosis"
- OpenStax Biology 2e: "Cell Death"
',

  '[
    {
      "question": "What is the main difference between apoptosis and necrosis?",
      "options": ["Apoptosis releases cellular contents causing inflammation, necrosis is clean removal", "Apoptosis is programmed cell death, necrosis is accidental cell death", "Apoptosis requires ATP, necrosis produces ATP", "Apoptosis occurs during development, necrosis occurs from injury"],
      "correctAnswer": 2,
      "explanation": "Apoptosis is PROGRAMMED, controlled cell death that eliminates unwanted or damaged cells in an orderly manner without triggering inflammation. NECROSIS is ACCIDENTAL cell death from injury, toxins, or lack of oxygen that causes cells to SWELL and BURST, releasing cellular contents that trigger INFLAMMATION. Apoptosis is 'cellular suicide', necrosis is 'cell murder'!"
    },
    {
      "question": "What activates the intrinsic apoptotic pathway?",
      "options": ["External death ligands binding to surface receptors", "DNA damage and cellular stress signals from within the cell", "Viral infection of the mitochondria", "Detection of foreign antigens by the immune system"],
      "correctAnswer": 1,
      "explanation": "The INTRINSIC (mitochondrial) pathway is activated by INTERNAL signals like DNA damage, oxidative stress, or developmental cues. These signals cause pro-apoptotic proteins (Bax, Bak) to permeabilize the mitochondrial membrane, releasing cytochrome c, which activates the caspase cascade that executes apoptosis. No external death receptors are involved!"
    },
    {
      "question": "What is the role of caspases in apoptosis?",
      "options": ["They repair DNA damage and prevent apoptosis", "They are executioner proteases that systematically dismantle the cell during apoptosis", "They protect the mitochondrial membrane from damage", "They synthesize anti-apoptotic proteins"],
      "correctAnswer": 1,
      "explanation": "Caspases are CYSTEINE PROTEASES (executioner proteases) that act as the final executioners of apoptosis. They cleave key cellular proteins: nuclear lamins (nuclear breakdown), cytoskeletal proteins (dismantle cell structure), and inhibitor of caspases (removing protection). Once activated, caspases systematically dismantle the cell forming apoptotic bodies for phagocytic removal!"
    }
  ]',
  NOW()
);
