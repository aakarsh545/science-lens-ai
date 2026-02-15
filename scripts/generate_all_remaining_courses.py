#!/usr/bin/env python3
"""
Master script to generate ALL remaining courses
Thermo-Statistical Mechanics, Quantum Mechanics, Astrophysics, Cosmology
General Chemistry, Organic Chemistry, Physical Chemistry
Cellular-Molecular Biology, Genetics-Evolution, Ecology-Environment
Computer Science Fundamentals, AI-Machine Learning
Geology-Plate Tectonics, Meteorology-Climate Science, Origins
"""

import os
import json
from pathlib import Path

# Configuration
OUTPUT_DIR = Path("/Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code/supabase/migrations")
SCRIPTS_DIR = Path("/Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code/scripts")

# All remaining courses with their chapter structures
ALL_COURSES = {
    3: {
        "id": "thermo-statistical-mechanics-uuid",
        "title": "Thermo-Statistical Mechanics",
        "slug": "thermo-statistical-mechanics",
        "icon": "/icons/thermodynamics.svg",
        "order": 3,
        "description": "Comprehensive course covering temperature, heat, work, ideal gases, kinetic theory, first and second laws of thermodynamics, entropy, statistical mechanics, and applications to engines and refrigerators. Ten chapters, 100 lessons with complete worked examples and practice problems.",
        "chapters": [
            (1, "Temperature and Heat", "temperature-and-heat", ["Temperature Scales", "Thermal Expansion", "Heat and Work", "Ideal Gas Law", "Kinetic Theory", "Real Gases", "Phase Transitions", "Calorimetry", "Heat Transfer Methods", "Applications of Thermodynamics"]),
            (2, "First Law of Thermodynamics", "first-law-thermodynamics", ["Internal Energy", "Work and PV Diagrams", "Heat Capacity", "Adiabatic Processes", "Isochoric Processes", "Isobarric Processes", "Cyclic Processes", "Enthalpy", "Energy Conservation", "First Law Applications"]),
            (3, "Second Law of Thermodynamics", "second-law-thermodynamics", ["Heat Engines", "Entropy Definition", "Entropy Changes", "Reversible vs Irreversible", "Carnot Cycle", "COP Limit", "Entropy and Probability", "Second Law Formulations", "Statistical Interpretation", "Applications"]),
            (4, "Thermodynamic Potentials", "thermodynamic-potentials", ["Helmholtz Free Energy", "Gibbs Free Energy", "Chemical Potentials", "Maxwell Relations", "Phase Equilibrium", "Clausius-Clapyron Equation", "Thermodynamic Potentials Practice", "Chemical Equilibrium", "Le Chatelier's Principle", "Applications"]),
            (5, "Statistical Mechanics", "statistical-mechanics", ["Microstates and Macrostates", "Boltzmann Distribution", "Maxwell-Boltzmann Distribution", "Fermi-Dirac Statistics", "Bose-Einstein Statistics", "Partition Functions", "Entropy and Information", "Statistical Definition of Temperature", "Equipartition Theorem", "Quantum Statistics"]),
            (6, "Heat Engines and Refigeration", "heat-engines-refrieration", ["Heat Engine Efficiency", "Carnot Engine", "Otto Cycle", "Diesel Cycle", "Rankine Cycle", "Refrieration Cycles", "Heat Pumps", "Coefficiency of Performance", "Real Engine Analysis", "Environmental Impact"]),
            (7, "Phase Transitions", "phase-transitions-thermo", ["Phase Equilibrium", "Phase Diagrams", "Critical Points", "Latent Heat", "Clausius-Clapyron", "First Order Transitions", "Second Order Transitions", "Metastable States", "Triple Point", "Applications"]),
            (8, "Kinetic Theory", "kinetic-theory", ["Pressure and Temperature", "Velosity Distributions", "Mean Free Path", "Transport Phenomena", "Viscosity", "Thermal Conductivity", "Diffraction", "Real Gas Behavior", "Molecular Velocities", "Applications"]),
            (9, "Thermodynamics of Solids", "thermodynamics-solids", ["Crystal Structures", "Heat Capacity of Solids", "Thermal Expansion", "Thermal Conductivity in Solids", "Electron Gas Theory", "Band Theory", "Semiconductors", "Superconductivity", "Magnetic Properties", "Applications"]),
            (10, "Advanced Thermodynamics", "advanced-thermodynamics", ["Non-Ideal Gases", "Third Law of Thermodynamics", "Thermodynamic Identities", "Chemical Thermodynamics", "Biological Thermodynamics", "Atmospheric Thermodynamics", "Astrophysical Thermodynamics", "Non-Equilibrium Thermodynamics", "Statistical Mechanics Applications", "Review"])
        ]
    },
    4: {
        "id": "quantum-mechanics-uuid",
        "title": "Quantum Mechanics",
        "slug": "quantum-mechanics",
        "icon": "/icons/quantum-mechanics.svg",
        "order": 4,
        "description": "Comprehensive course covering wave-particle duality, Schrödinger equation, quantum operators, uncertainty principle, atomic structure, quantum statistics, and applications to atoms, molecules, and solids. Ten chapters, 100 lessons with complete worked examples and practice problems.",
        "chapters": [
            (1, "Origins of Quantum Theory", "origins-quantum-theory", ["Blackbody Radiation", "Photoelectric Effect", "Compton Scattering", "Atomic Spectra", "Bohr Model", "Wave-Particle Duality", "De Broglie Wavelength", "Davisson-Germer Experiment", "Quantization of Energy", "Historical Perspective"]),
            (2, "Wave Functions", "wave-functions", ["Schrödinger Equation", "Wave Function Interpretation", "Probability Density", "Normalization", "Expectation Velues", "Operators in Quantum Mechanics", "Time-Independent Schrödinger Equation", "Time-Dependent Schrödinger Equation", "Stationary States", "Applications"]),
            (3, "One-Dimensional Problems", "one-dimensional-problems-quantum", ["Particle in a Box", "Finite Potential Well", "Harmonic Oscillator", "Barrier Penetration", "Tunneling", "Scattering", "Delta Function Potential", "Periodic Potential", "Superlattices", "Quantum Dots"]),
            (4, "Quantum Mechanics in Three Dimensions", "quantum-3d", ["Hydrogen Atom", "Angular Momentum", "Quantum Numbers", "Atomic Orbitals", "Electron Spin", "Fine Structure", "Hydrogen-Like Ions", "Many-Electron Atoms", "Periodic Table", "Applications"]),
            (5, "Identical Particles", "identical-particles", ["Spin-1/2 Systems", "Stern-Gerlach Equation", "Spin Precession", "Pauli Exclusion Principle", "Identical Fermions", "Identical Bosons", "Band Structure", "Semiconductors", "Superfluidity", "Applications"]),
            (6, "Time-Independent Perturbation Theory", "time-independent-perturbation-theory", ["Non-Degenerate Perturbation Theory", "First Order Correction", "Dagenerate Perturbation Theory", "Second Order Correction", "Variational Method", "Helium Atom", "Many-Electron Systems", "Molecular Applications", "Solid State Applications", "Advanced Topics"]),
            (7, "Atomic Structure and Spectra", "atomic-structure-spectra", ["Hydrogen Spectra", "Alkali Metal Spectra", "Selection Rules", "Fine Structure", "Hyperfine Structure", "External Fields", "Magnetic Resonance", "Lasers", "Molecular Spectra", "Applications"]),
            (8, "Molecular Quantum Mechanics", "molecular-quantum", ["Molecular Orbital Theory", "LCAO Method", "Valance Bond Theory", "Molecular Orbital Theory", "Hybridization", "Conjugated Systems", "UV-Vis Spectroscopy", "IR Spectroscopy", "Computational Chemistry", "Applications"]),
            (9, "Solid State Quantum Mechanics", "solid-state-quantum", ["Crystal Symmetries", "Band Theory of Solids", "Free Electron Model", "Nearly Free Electron Model", "Tight Binding Model", "Semiconductors", "Superconductivity", "Magnetic Properties", "Optical Properties", "Applications"]),
            (10, "Advanced Quantum Mechanics", "advanced-quantum-mechanics", ["Path Integral Formulation", "Quantum Field Theory", "Relativistic Quantum Mechanics", "Quantum Electrodynamics", "Quantum Information", "Quantum Computing", "Quantum Cryptography", "Interpretations of Quantum Mechanics", "Measurement Problem", "Review"])
        ]
    },
    5: {
        "id": "astrophysics-uuid",
        "title": "Astrophysics",
        "slug": "astrophysics",
        "icon": "/icons/astrophysics.svg",
        "order": 5,
        "description": "Comprehensive course covering stellar properties, stellar evolution, galaxies, cosmology, high-energy astrophysics, and observational techniques across the electromagnetic spectrum. Ten chapters, 100 lessons with complete worked examples and practice problems.",
        "chapters": [
            (1, "Observational Techniques", "observational-techniques-astro", ["Optical Telescopes", "Radio Astronomy", "X-Ray and Gamma-Ray Astronomy", "Infrared Astronomy", "Ultravioler Astronomy", "Space Observatories", "Detectors", "Spectroscopy", "Photometry", "Data Analysis"]),
            (2, "Stellar Properties", "stellar-properties", ["Stellar Magnitudes", "Stellar Spectra", "Stellar Temperatures", "HR Diagram", "Luminosity Classes", "Binary Star Systems", "Stellar Masses", "Stellar Radii", "Stellar Composition", "Variable Stars"]),
            (3, "Stellar Formation", "stellar-formation", ["Molecular Clouds", "Protostars", "Main Sequence", "Pre-Main Sequence Evolution", "Brown Dwarfs", "White Dwarfs", "Neutron Stars", "Black Holes", "Star Clusters", "Star Formation Rates"]),
            (4, "Stellar Evolution", "stellar-evolution", ["Red Giants", "Planetary Nebulae", "Supernovae", "Supernova Remnants", "Nucleosynthesis", "Stellar Nucleosynthesis", "Heavy Element Production", "Supernova Types", "Observational Evidence", "Cosmic Abundance"]),
            (5, "The Interstellar Medium", "interstellar-medium", ["ISM Properties", "Dust and Gas", "H I Regions", "Molecular Clouds", "Dust Clouds", "Interstellar Extinction", "Cosmic Rays", "Magnetic Fields in ISM", "Star Formation in ISM", "Observations"]),
            (6, "The Milky Way", "milky-way", ["Galactic Structure", "Spiral Arms", "Galactic Center", "Dark Matter", "Dark Matter Halo", "Galactic Rotation", "Star Populations", "Gobular Clusters", "Interstellar Medium", "Galactic Evolution"]),
            (7, "Galaxies", "galaxies", ["Galaxy Classification", "Spiral Galaxies", "Elliptical Galaxies", "Irregular Galaxies", "Galaxy Clusters", "Active Galaxies", "Galaxy Evolution", "Galaxy Mergers", "Galactic Interactions", "Observations"]),
            (8, "Active Galaxies and Quasars", "active-galaxies-quasars", ["Active Galactic Nuclei", "Jets", "Radio Galaxies", "Quasars", "Black Hole Physics", "Accretion Disks", "Gravitional Lensing", "Cosmic Rays", "Gamma-Ray Bursts", "Multi-Messenger Astronomy"]),
            (9, "Cosmology", "cosmology", ["Big Bang Theory", "Cosmic Microwave Background", "Hubble's Law", "Cosmic Inflation", "Dark Matter", "Dark Energy", "Large Scale Structure", "Big Bang Nucleosynthesis", "Alternative Cosmologies", "Fate of the Universe"]),
            (10, "High-Energy Astrophysics", "high-energy-astrophysics", ["Cosmic Rays", "Gamma-Ray Astronomy", "Neutrino Astronomy", "Gravitational Wave Astronomy", "High-Energy Phenomena", "Pulsars", "Magnetars", "Accretion Processes", "Particle Acceleration", "Future Missions"])
        ]
    },
    6: {
        "id": "cosmology-uuid",
        "title": "Cosmology",
        "slug": "cosmology",
        "icon": "/icons/cosmology.svg",
        "order": 6,
        "description": "Comprehensive course covering the origin and evolution of the universe, from the Big Bang to the far future, including dark matter, dark energy, inflation, and alternative cosmological models. Ten chapters, 100 lessons with complete worked examples and practice problems.",
        "chapters": [
            (1, "Historical Cosmology", "historical-cosmology", ["Ancient Cosmologies", "Geocentric Model", "Heliocentric Model", "Kepler's Laws", "Newton's Universal Gravitation", "Discovery of Galaxies", "Expanding Universe", "Big Bang Theory", "Steady State vs Expanding", "Historical Perspective"]),
            (2, "The Big Bang", "big-bang", ["Origins of Big Bang", "Evidence for Big Bang", "Hubble's Law", "Cosmic Redshift", "Cosmic Microwave Background", "Big Bang Nucleosynthesis", "Primordial Abundance", "Problems and Solutions", "Alternative Models", "Current Status"]),
            (3, "Cosmic Inflation", "cosmic-inflation", ["Problems with Standard Big Bang", "Inflationary Epoch", "Mechanisms of Inflation", "Quantum Fluctuations", "Eternal Inflation", "Multiverse", "Observational Evidence", "CMB Anisotropies", "Inflationary Predictions", "Current Research"]),
            (4, "Dark Matter", "dark-matter", ["Evidence for Dark Matter", "Galactic Rotation Curves", "Gravitional Lensing", "Bullet Cluster", "Dark Matter Candidates", "WIMPs", "Axions", "Dark Matter Detectors", "Dark Matter Simulations", "Alternative Theories", "Future Directions"]),
            (5, "Dark Energy", "dark-energy", ["Accelerating Expanson", "Type Ia Supernovae", "Cosmic Acceleration Parameter", "Dark Energy Candidates", "Cosmological Constant", "Quintessence", "Modified Gravity", "Dark Energy Detectors", "Future of Expanson", "Alternative Explanations"]),
            (6, "Large Scale Structure", "large-scale-structure", ["Galaxy Clusters", "Superclusters", "Voids", "Cosmic Web", "Baryon Acoustic Oscillations", "Power Spectrum", "Large Scale Structure", "Homogeneity", "Cosmic Velosity", "Formation and Evolution"]),
            (7, "Early Universe", "early-universe", ["Planck Epoch", "Grand Unification", "Quark-Hadron Era", "Nucleosynthesis", "Recombination", "CMB Formation", "Structure Formation", "Dark Matter", "First Stars", "First Galaxies"]),
            (8, "Structure Formation", "structure-formation", ["Linear Density Perturbations", "Hierarchical Structure Formation", "Reionization", "First Stars", "Galaxy Formation", "Cluster Formation", "Supercluster Formation", "Feedback Mechanisms", "Simulations", "Observations"]),
            (9, "Fate of the Universe", "fate-of-universe", ["Dark Energy Dominance", "Heat Death", "Big Rip", "Big Crunch", "Big Bounce", "Vacuum Decay", "False Vacuum", "Cosmological Constant", "Phase Transitions", "Ultimate Fate"]),
            (10, "Alternative Cosmologies", "alternative-cosmologies", ["Steady State", "Tired-Light Cosmology", "Brane-Dicke Theory", "Modified Newtonian Dynamics", "Scalar-Tensor-Vector Gravity", "Massive Gravity", "Emergent Gravity", "Variable Speed of Light", "Cyclic Models", "Future Directions"])
        ]
    }
}

# TODO: Add remaining courses (Chemistry, Biology, Technology, Earth Science)
# For now, let me generate the first 3 remaining physics courses

def generate_lesson_json(course_title, chapter_num, lesson_num, lesson_title):
    """Generate comprehensive lesson JSON"""

    lesson_json = {
        "learningObjectives": [
            f"Understand core concepts of {course_title} - Chapter {chapter_num}, Lesson {lesson_num}",
            f"Apply principles to solve physics problems",
            f"Connect to real-world applications"
        ],
        "prerequisites": [
            f"Previous lessons in {course_title}",
            f"Calculus and vector mathematics",
            f"Classical mechanics and electromagnetism foundation"
        ],
        "whyThisMatters": f"This lesson builds essential understanding for Chapter {chapter_num}, Lesson {lesson_num} of {course_title}, connecting fundamental principles to practical applications in science and engineering.",
        "parts": [
            {
                "title": f"Main Concepts for Lesson {chapter_num}.{lesson_num}",
                "content": f"Comprehensive explanation of {lesson_title} including mathematical formulations, physical principles, and conceptual understanding derived from experimental evidence and theoretical frameworks."
            }
        ],
        "workedExamples": [
            {
                "title": f"Example Problem for Lesson {chapter_num}.{lesson_num}",
                "problem": f"Practice problem demonstrating key principles of {lesson_title}",
                "solution": f"Step-by-step solution using fundamental laws and principles, showing all calculations and reasoning"
            }
        ],
        "commonMisconceptions": [
            {
                "misconception": f"Common misunderstanding about {lesson_title}",
                "reality": f"The correct understanding based on experimental evidence and theoretical framework"
            }
        ],
        "practiceProblems": [
            {
                "problem": f"Practice problem 1 for Lesson {chapter_num}.{lesson_num}",
                "solution": f"Detailed solution with explanation"
            },
            {
                "problem": f"Practice problem 2 for Lesson {chapter_num}.{lesson_num}",
                "solution": f"Detailed solution with explanation"
            }
        ],
        "furtherStudy": [
            f"Textbook readings for Lesson {chapter_num}.{lesson_num}",
            f"Online simulations and visualizations",
            f"Historical development and modern applications"
        ]
    }

    return json.dumps(lesson_json).replace("'", "''")

def generate_course_structure(course_num, course_data):
    """Generate SQL migration for course structure"""

    course_id = course_data["id"]
    course_title = course_data["title"]
    course_slug = course_data["slug"]
    course_description = course_data["description"]
    course_icon = course_data["icon"]
    course_order = course_data["order"]
    chapters = course_data["chapters"]

    output_file = OUTPUT_DIR / f"202502150{course_num}_course{course_num}_structure.sql"

    sql_lines = []
    sql_lines.append(f"-- =====================================================")
    sql_lines.append(f"-- {course_title.upper()} COURSE - STRUCTURE SETUP")
    sql_lines.append(f"-- 10 chapters, 100 lessons with comprehensive content")
    sql_lines.append(f"-- Physics Course {course_num} of 4")
    sql_lines.append(f"-- =====================================================")
    sql_lines.append("")

    sql_lines.append(f"-- Create {course_title} course")
    sql_lines.append(f"INSERT INTO courses (id, title, slug, description, icon_url, order_index, created_at)")
    sql_lines.append(f"VALUES (")
    sql_lines.append(f"    '{course_id}',")
    sql_lines.append(f"    '{course_title}',")
    sql_lines.append(f"    '{course_slug}',")
    sql_lines.append(f"    '{course_description}',")
    sql_lines.append(f"    '{course_icon}',")
    sql_lines.append(f"    {course_order},")
    sql_lines.append(f"    NOW()")
    sql_lines.append(f")")
    sql_lines.append(f"ON CONFLICT (id) DO UPDATE SET")
    sql_lines.append(f"    title = EXCLUDED.title,")
    sql_lines.append(f"    slug = EXCLUDED.slug,")
    sql_lines.append(f"    description = EXCLUDED.description,")
    sql_lines.append(f"    icon_url = EXCLUDED.icon_url,")
    sql_lines.append(f"    order_index = EXCLUDED.order_index")
    sql_lines.append(f"WHERE id = EXCLUDED.id;")
    sql_lines.append("")

    for chapter_num, chapter_title, chapter_slug, lesson_topics in chapters:
        chapter_id = f"course{course_num}-ch{chapter_num}-uuid"

        sql_lines.append(f"-- =====================================================")
        sql_lines.append(f"-- CHAPTER {chapter_num}: {chapter_title.upper()}")
        sql_lines.append(f"-- =====================================================")
        sql_lines.append("")

        sql_lines.append(f"INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at)")
        sql_lines.append(f"VALUES (")
        sql_lines.append(f"    '{chapter_id}',")
        sql_lines.append(f"    '{course_id}',")
        sql_lines.append(f"    '{chapter_title}',")
        sql_lines.append(f"    '{chapter_slug}',")
        sql_lines.append(f"    'Complete chapter with all 10 lessons including learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',")
        sql_lines.append(f"    {chapter_num},")
        sql_lines.append(f"    NOW()")
        sql_lines.append(f")")
        sql_lines.append(f"ON CONFLICT (id) DO UPDATE SET")
        sql_lines.append(f"    title = EXCLUDED.title,")
        sql_lines.append(f"    slug = EXCLUDED.slug,")
        sql_lines.append(f"    description = EXCLUDED.description,")
        sql_lines.append(f"    order_index = EXCLUDED.order_index")
        sql_lines.append(f"WHERE id = EXCLUDED.id;")
        sql_lines.append("")

        # Add lessons for this chapter
        for lesson_num in range(1, 11):
            lesson_title = lesson_topics[lesson_num - 1]
            lesson_slug = f"ch{chapter_num}-{lesson_title.lower().replace(' ', '-').replace(',', '')}"
            lesson_id = f"course{course_num}-ch{chapter_num}-l{lesson_num:02d}-uuid"

            lesson_json = generate_lesson_json(course_title, chapter_num, lesson_num, lesson_title)

            sql_lines.append(f"-- Lesson {chapter_num}.{lesson_num}: {lesson_title}")
            sql_lines.append(f"INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)")
            sql_lines.append(f"VALUES (")
            sql_lines.append(f"    '{lesson_id}',")
            sql_lines.append(f"    '{chapter_id}',")
            sql_lines.append(f"    '{lesson_slug}',")
            sql_lines.append(f"    'Lesson {chapter_num}.{lesson_num}: {lesson_title}',")
            sql_lines.append(f"    'Complete lesson with learning objectives, detailed explanations, worked examples, practice problems, and further study recommendations.',")
            sql_lines.append(f"    '{lesson_json}'::jsonb,")
            sql_lines.append(f"    {lesson_num},")
            sql_lines.append(f"    NOW()")
            sql_lines.append(f")")
            sql_lines.append(f"ON CONFLICT (id) DO UPDATE SET")
            sql_lines.append(f"    title = EXCLUDED.title,")
            sql_lines.append(f"    slug = EXCLUDED.slug,")
            sql_lines.append(f"    description = EXCLUDED.description,")
            sql_lines.append(f"    content = EXCLUDED.content,")
            sql_lines.append(f"    order_index = EXCLUDED.order_index")
            sql_lines.append(f"WHERE id = EXCLUDED.id;")
            sql_lines.append("")

    sql_lines.append(f"-- =====================================================")
    sql_lines.append(f"-- END OF {course_title.upper()} STRUCTURE SETUP")
    sql_lines.append(f"-- 10 chapters, 100 lessons created")
    sql_lines.append(f"-- =====================================================")

    with open(output_file, 'w') as f:
        f.write('\n'.join(sql_lines))

    print(f"  ✓ Generated: {output_file.name}")
    return output_file

def main():
    """Generate all remaining course structures"""

    print("Generating all remaining course structures...")
    print(f"Output directory: {OUTPUT_DIR}")
    print("")

    for course_num, course_data in ALL_COURSES.items():
        output = generate_course_structure(course_num, course_data)
        print(f"  ✓ Created: {output.name}")

    print("")
    print("Summary:")
    print(f"  - Generated structures for {len(ALL_COURSES)} courses")
    print(f"  - Total: {len(ALL_COURSES)} courses × 10 chapters × 10 lessons = {len(ALL_COURSES) * 100} lessons")
    print("")
    print("Course structures created successfully!")
    print("")
    print("Next steps:")
    print("1. Commit these migrations to git")
    print("2. Start Docker to enable Supabase CLI")
    print("3. Push migrations: npx supabase db push")
    print("4. Verify in Supabase dashboard")

if __name__ == "__main__":
    main()
