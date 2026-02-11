-- =====================================================
-- ADVANCED PHYSICS COURSE - PART 2
-- Topics: Quantum Mechanics, Particle Physics, Atomic Structure
-- =====================================================

-- LESSONS FOR CHAPTER 3 (Quantum Mechanics) - continued
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'quantum-mechanics' LIMIT 1),
  'The Uncertainty Principle',
  'uncertainty-principle',
  2,
  '# The Uncertainty Principle

## What Is the Uncertainty Principle?

The **Heisenberg Uncertainty Principle** (1927) states that you cannot simultaneously know certain pairs of physical properties with perfect precision.

**There is a fundamental limit to measurement accuracy in quantum mechanics!**

## Position-Momentum Uncertainty

$$\Delta x \Delta p \geq \frac{\hbar}{2}$$

Where:
- $\Delta x$ = uncertainty in position
- $\Delta p$ = uncertainty in momentum
- $\hbar = \frac{h}{2\pi}$ = reduced Planck constant = $1.055 \times 10^{-34} \text{ J}\cdot\text{s}$

### Key Implications

**NOT about measurement limitations** (common misconception):
- This is a fundamental property of nature
- Better instruments won''t overcome it
- Particles DON''T have definite position AND momentum

Particles have **intrinsic uncertainty**—they''re "fuzzy"!

## Energy-Time Uncertainty

$$\Delta E \Delta t \geq \frac{\hbar}{2}$$

Where:
- $\Delta E$ = uncertainty in energy
- $\Delta t$ = uncertainty in time (measurement duration)

This allows:
- **Vacuum fluctuations**: Energy "borrows" from uncertainty for short times
- **Virtual particles**: Particle-antiparticle pairs popping in/out of existence

## Examples

### Example 1: Electron Position Measurement

Localize an electron to 1 atomic diameter ($\Delta x \approx 10^{-10} \text{ m}$).

**Momentum uncertainty**:
$$\Delta p \geq \frac{\hbar}{2\Delta x} = \frac{1.055 \times 10^{-34}}{2 \times 10^{-10}} \approx 5 \times 10^{-25} \text{ kg}\cdot\text{m/s}$$

For an electron ($m = 9.11 \times 10^{-31} \text{ kg}$):
$$\Delta v = \frac{\Delta p}{m} = \frac{5 \times 10^{-25}}{9.11 \times 10^{-31}} \approx 5.5 \times 10^5 \text{ m/s}$$

The electron''s velocity is uncertain by **55 km/s**!

After measurement, electron recoils with unknown velocity—you can''t predict where it will be next!

### Example 2: Photon Energy-Time Uncertainty

A photon passes through a filter in $\Delta t = 1 \text{ ns}$.

**Energy uncertainty**:
$$\Delta E \geq \frac{\hbar}{2\Delta t} = \frac{1.055 \times 10^{-34}}{2 \times 10^{-9}} \approx 5 \times 10^{-26} \text{ J}$$

**In electron-volts**:
$$\Delta E = \frac{5 \times 10^{-26}}{1.6 \times 10^{-19}} \approx 3 \times 10^{-7} \text{ eV}$$

**Spectral line broadening**: Short-lived excited states have uncertain energy → wider emission lines!

### Example 3: Why Electrons Don''t Collapse into Nucleus

In classical physics, electron should spiral into nucleus (oppositely charged).

**Quantum explanation**:
- If electron were confined to nucleus ($\Delta x \approx 10^{-15} \text{ m}$)
- Momentum uncertainty: $\Delta p \geq \frac{\hbar}{2 \times 10^{-15}} \approx 5 \times 10^{-20} \text{ kg}\cdot\text{m/s}$
- Kinetic energy: $KE = \frac{p^2}{2m} \approx 1.4 \times 10^{-10} \text{ J} \approx 900 \text{ eV}$

This is enough energy to **escape nucleus**!

Electron can''t be trapped in nucleus due to uncertainty principle!

## The Microscope Limit

Why can''t we see atoms with optical microscopes?

**To resolve** feature of size $d$, need wavelength $\lambda \lesssim d$.

Visible light: $\lambda \approx 500 \text{ nm}$

Can resolve: $d \approx 500 \text{ nm}$ (hundreds of atoms)

But what if we try to localize electron more precisely?

**If** $\Delta x = 0.1 \text{ nm}$ (to resolve atoms):
$$\Delta p \geq \frac{\hbar}{2\Delta x} = \frac{10^{-34}}{2 \times 10^{-10}} \approx 5 \times 10^{-25} \text{ kg}\cdot\text{m/s}$$

Electron momentum becomes so uncertain it **escapes the atom**!

**Conclusion**: To see an atom, you must disturb it so much you destroy it!

## Zero-Point Energy

Even in its ground state, a quantum system has **non-zero energy**:

Quantum harmonic oscillator:
$$E_0 = \frac{1}{2}\hbar\omega > 0$$

**Implication**: Particle is still "jiggling" even at absolute zero!

This is **NOT from uncertainty principle alone** (it''s from commutation relations), but uncertainty prevents $\Delta x = 0$ (perfect localization).

## Generalized Uncertainty Relations

For any observables $A$ and $B$:

$$\Delta A \Delta B \geq \frac{1}{2}|\langle[\hat{A}, \hat{B}]\rangle|$$

Where $[\hat{A}, \hat{B}] = \hat{A}\hat{B} - \hat{B}\hat{A}$ is the **commutator**.

### Position-Momentum Commutator

$$[\hat{x}, \hat{p}] = i\hbar \neq 0$$

Since they don''t commute, $\Delta x$ and $\Delta p$ can''t both be zero!

### Energy-Time Relation (No Commutator!)

Time is not an operator—$\Delta E \Delta t$ relation is different in nature!

## Measurement Disturbance

Every measurement disturbs the system:

```
Before: After:
   │   wavefunction      │   localized
   Ψ(x)            Ψ(x - x₀)
     │               └─ delta function
   uncertain position   certain position
   (superposition)    (collapsed)
```

**The act of measurement** creates definite properties!

## Applications

### Scanning Tunneling Microscope (STM)

Uses quantum tunneling (related to uncertainty) to image atoms:

```
Voltage tip                Sample
     ↓                       ↕
    (─)                     ══
     gap                    surface
  (~0.5 nm)
     Δx known → Δp large
     (electron confined)
```

**Principle**: Electron "leaks" through classically forbidden barrier due to position-momentum uncertainty!

### Quantum Cryptography

**BB84 protocol** (Bennett and Brassard, 1984):

Uses uncertainty principle to detect eavesdropping:
- Measure in **X basis** → disturbs **Z basis**
- Eavesdropper can''t measure both without introducing errors

## Common Misconceptions

**Misconception**: "Uncertainty is due to clumsy experimental techniques."

**Reality**: Uncertainty is **intrinsic to nature**—a fundamental property of quantum systems. Perfect instruments still hit this limit!

**Misconception**: "Particles have hidden definite values we can''t access."

**Reality**: Particles **don''t have** definite position and momentum simultaneously. The properties don''t exist prior to measurement!

## Key Equations

| Equation | Quantity |
|----------|----------|
| $\Delta x \Delta p \geq \hbar/2$ | Position-momentum uncertainty |
| $\Delta E \Delta t \geq \hbar/2$ | Energy-time uncertainty |
| $[\hat{x}, \hat{p}] = i\hbar$ | Position-momentum commutator |
| $\Delta A \Delta B \geq |\langle[A,B]\rangle|/2$ | General uncertainty relation |

## Sources
- Heisenberg, W. (1927). "On the Perceptual Content of Quantum Theoretical Kinematics"
- Griffiths, D. (2018). "Introduction to Quantum Mechanics, 2nd ed."
- Shankar, R. (2012). "Principles of Quantum Mechanics, 2nd ed."
- Khan Academy: "Heisenberg uncertainty principle"
- MIT OpenCourseWare: 8.04 Quantum Physics
',

  '[
    {
      "question": "What is the Heisenberg uncertainty principle for position (Δx) and momentum (Δp)?",
      "options": ["ΔxΔp ≥ 0 (both can be zero)", "ΔxΔp ≥ ℏ/2 (fundamental limit to simultaneous precision)", "ΔxΔp ≥ ℏ", "ΔxΔp ≥ h/2"],
      "correctAnswer": 1,
      "explanation": "The Heisenberg uncertainty principle states ΔxΔp ≥ ℏ/2. This means you cannot simultaneously know position and momentum with perfect precision. It''s NOT a measurement limitation but a fundamental property of nature—particles don''t have definite x and p simultaneously!"
    },
    {
      "question": "If an electron is localized to within 1 atomic diameter (10⁻¹⁰ m), what is the minimum uncertainty in its velocity?",
      "options": ["10 m/s", "55 km/s (5.5×10⁴ m/s)", "1,000 km/s", "c (speed of light)"],
      "correctAnswer": 1,
      "explanation": "Δp ≥ ℏ/2Δx = (1.055×10⁻³⁴)/(2×10⁻¹⁰) ≈ 5×10⁻²⁵ kg·m/s. For electron (m=9.11×10⁻³¹ kg): Δv = Δp/m ≈ 5.5×10⁴ m/s ≈ 55 km/s. The electron''s velocity becomes uncertain by 55 km/s—you can''t know both its position AND future momentum!"
    },
    {
      "question": "Why don''t electrons spiral into atomic nuclei due to electrostatic attraction?",
      "options": ["Nuclei are positively charged, repelling electrons", "Uncertainty principle gives electrons kinetic energy to escape if confined to nucleus size", "Electrons move too fast to be captured", "Quantum tunneling prevents capture"],
      "correctAnswer": 1,
      "explanation": "If electron were confined to nucleus (Δx≈10⁻¹⁵ m), uncertainty gives Δp≥ℏ/2Δx≈5×10⁻²⁰ kg·m/s. This corresponds to KE≈900 eV—enough to escape! Electrons can''t be trapped in nuclei due to position-momentum uncertainty."
    },
    {
      "question": "What does energy-time uncertainty (ΔEΔt ≥ ℏ/2) allow?",
      "options": ["Perpetual motion machines", "Vacuum fluctuations and virtual particles for short times", "Time travel", "Electrons to exceed light speed"],
      "correctAnswer": 1,
      "explanation": "Energy-time uncertainty allows temporary violations of energy conservation: ΔE can be large for very short Δt. This permits vacuum fluctuations (virtual particle-antiparticle pairs) that briefly borrow energy from the vacuum, as long as they repay it within Δt ≈ ℏ/2ΔE!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'quantum-mechanics' LIMIT 1),
  'Quantum Entanglement',
  'quantum-entanglement',
  3,
  '# Quantum Entanglement

## What Is Quantum Entanglement?

**Quantum entanglement** is a phenomenon where two or more particles become **correlated** in such a way that the quantum state of each particle cannot be described independently—even when separated by large distances!

Einstein called it **"spooky action at a distance"** (spukhafte Fernwirkung)!

## The EPR Paradox (1935)

Einstein, Podolsky, and Rosen proposed a thought experiment to show quantum mechanics is incomplete.

### Setup

1. Create **entangled particle pair** (e.g., two electrons with opposite spins)
2. Separate particles by large distance (light-years!)
3. Measure spin of particle A
4. **Instantly know** spin of particle B (without disturbing it!)

**EPR argument**: This violates locality (no faster-than-light influence) → QM is incomplete → there must be **hidden variables**!

### Bell''s Theorem (1964)

John Bell proved that **any local hidden variable theory** makes different predictions than quantum mechanics.

**Bell''s inequality**:
$$|E(a, b) - E(a, c)| \leq 1 + E(b, c)$$

Quantum mechanics can **violate** this inequality!

## Experimental Tests

### Aspect''s Experiment (1982)

Alain Aspect tested Bell inequalities using entangled photons:

```
Source    →   Polarizer A   →   Detector A
   (entangled)       ↗               ↓
                 ↖              Photon A
                  Polarizer B   →   Detector B
                              ↗               ↓
                                            Photon B
```

**Results**: Violated Bell inequalities → **No local hidden variables!**

### 2022 Nobel Prize

**Clauser, Aspect, and Zeilinger** proved the world is **nonlocal** at the quantum level!

Entanglement is real—you measure one particle, you **instantly affect** the other, regardless of distance!

## How Entanglement Works

### Singlet State (Two Spin-1/2 Particles)

$$|\Psi\rangle = \frac{1}{\sqrt{2}}(|\uparrow\downarrow\rangle - |\downarrow\uparrow\rangle)$$

**Properties**:
- Total spin = 0 (conserved)
- Individual particles don''t have definite spin
- Measuring one **collapses** both!

If you measure particle A and find $\uparrow$:
- Particle B **immediately** becomes $\downarrow$ (opposite spin)
- This happens **instantly**, even at 1 billion light-years!

### Entanglement Types

| Type | System | Properties |
|------|--------|------------|
| Spin singlet | 2 spin-1/2 particles | Opposite spins, no individual definite state |
| GHZ state (Greenberger-Horne-Zeilinger) | 3+ qubits | Maximally entangled |
| Cluster state | Multiple particles | Highly correlated for certain measurements |
| Bell state | 2 qubits | Simplest maximally entangled state |

## Quantum Teleportation

**NOT faster-than-light communication** (common misconception)!

Protocol (Bennett et al., 1993):

1. Alice has **qubit** A (entangled with B, held by Bob)
2. Alice has **qubit** C in unknown state $|\psi\rangle$
3. Alice measures A and C together (**Bell measurement**)
4. Result tells her which operation to apply to B
5. Alice sends **2 classical bits** to Bob (which operation)
6. Bob applies operation to B → B recreates $|\psi\rangle$!

**Key**: Quantum state is "teleported" but **classical information** is limited to light speed!

The **original** qubit C is **destroyed** in the process (no-cloning theorem).

## Applications

### Quantum Cryptography: BB84 Protocol

Charles Bennett and Gilles Brassard (1984) proposed using entanglement for secure key distribution:

```
Alice                      Bob
  ↓                         ↑
Source →   [Choose        [Measure
(entangled)    basis]          basis]
    ↘         ↙             ↓
     A       B
 (random)   (correlated)
```

1. Source emits entangled photon pair
2. Alice and Bob **randomly choose measurement bases**
3. They communicate their bases publicly
4. **Discard** mismatched bases (where results are random)
5. **Keep** matching bases (perfect anti-correlation)

**Security**: Eavesdropper can''t measure without introducing errors (detected by comparing subset of bits)!

### Quantum Computing

Entangled qubits enable **quantum parallelism**:

$$|\Psi\rangle = \sum_{i=1}^{2^n} \alpha_i |i\rangle$$

An n-qubit register exists in **superposition** of $2^n$ states simultaneously!

Algorithms:
- **Shor''s algorithm**: Factor integers exponentially faster than classical
- **Grover''s algorithm**: Search unsorted databases in $\sqrt{N}$ vs. $N$

## Nonlocality vs. Causality

**Apparent paradox**: Entanglement is instantaneous, but relativity says nothing travels faster than light!

**Resolution**: Entanglement cannot transmit **information** faster than light!

- Measurement outcomes are **random** at each location
- Only by **comparing** results (classical communication) do you see correlation
- No **causal influence**—can''t signal or send energy FTL

## Quantum Eraser

Delayed-choice quantum eraser (Scully and Drühl, 1982):

Shows that **measurement choice** can affect whether entanglement existed in the past!

```
Entangled photons →   Double slit
   ↘         ↙
     A         B
     ↓         ↓
 (which goes     (which goes
  through slit?)  through slit?)
         ↓         ↓
    Detect (which     Detect
    path?)        path?)
```

**Quantum eraser**: Can "erase" which-path information, restoring interference!

This shows **quantum weirdness goes deeper** than just entanglement!

## Key Equations

| Equation | Quantity |
|----------|----------|
| $|\Psi\rangle_{AB} \neq |\Psi\rangle_A \otimes |\Psi\rangle_B$ | Entangled state |
| $\frac{1}{\sqrt{2}}(|\uparrow\downarrow\rangle - |\downarrow\uparrow\rangle)$ | Singlet state |
| $|E(a, b) - E(a, c)| > 1 + E(b, c)$ | Bell inequality violation |
| $\rho_{AB} = \text{Tr}_B(\rho_{AB})$ | Reduced density matrix |

## Sources
- Einstein, A., Podolsky, B., Rosen, N. (1935). "Can Quantum-Mechanical Description of Physical Reality Be Considered Complete?"
- Bell, J. (1964). "On the Einstein Podolsky Rosen Paradox"
- Aspect, A., Dalibard, J., Roger, G. (1982). "Experimental Test of Bell Inequalities"
- Bennett, C.H., Brassard, G. (1984). "Quantum Cryptography: Public Key Distribution and Coin Tossing"
- Zeilinger, A. (1999). "Experiment and the Foundations of Quantum Physics"
',

  '[
    {
      "question": "What is quantum entanglement?",
      "options": ["Classical correlation between particles", "Correlation where particles share a quantum state that cannot be described independently, even when separated", "A way to communicate faster than light", "A type of particle decay"],
      "correctAnswer": 1,
      "explanation": "Quantum entanglement is a phenomenon where two or more particles become so correlated that their quantum states cannot be described independently. Measuring one particle instantly determines the state of the other, regardless of distance. Einstein called it ''spooky action at a distance!''"
    },
    {
      "question": "What was the 2022 Nobel Prize in Physics awarded for?",
      "options": ["Discovery of quantum entanglement", "Experiments with entangled photons proving the universe is not locally real (violating Bell inequalities)", "Invention of quantum computing", "Discovery of the Higgs boson"],
      "correctAnswer": 1,
      "explanation": "Clauser, Aspect, and Zeilinger received the 2022 Nobel Prize for experiments with entangled photons that proved Bell inequalities are violated. This showed that the world is fundamentally quantum—no local hidden variables can explain these results!"
    },
    {
      "question": "Can quantum entanglement be used for faster-than-light communication?",
      "options": ["Yes, that''s the main application", "No—measurement outcomes are random; only classical comparison (limited to c) reveals correlations", "Only if you have a quantum internet connection", "Yes, but only for distances less than 1 km"],
      "correctAnswer": 1,
      "explanation": "No! While entanglement correlations are instantaneous, the measurement outcomes at each location are RANDOM. You can''t control or predict what the other person measures. To see the correlation, you must compare results via classical communication (limited to light speed). No faster-than-light signaling!"
    },
    {
      "question": "What is the singlet state for two spin-1/2 particles?",
      "options": ["|↑↑⟩ + |↓↓⟩", "(|↑↓⟩ - |↓↑⟩)/√2", "(|↑↑⟩ + |↓↑⟩)/√2", "|↑↓⟩ × |↓↑⟩"],
      "correctAnswer": 1,
      "explanation": "The singlet state is (|↑↓⟩ - |↓↑⟩)/√2. This describes two spin-1/2 particles with opposite spins (total spin = 0). Neither particle has a definite spin individually, but measuring one immediately determines the other! It''s maximally entangled."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'quantum-mechanics' LIMIT 1),
  'Schrödinger Equation and Wavefunctions',
  'schrodinger-equation-wavefunctions',
  4,
  '# Schrödinger Equation and Wavefunctions

## What Is the Schrödinger Equation?

The **Schrödinger equation** (1926) is the fundamental equation of quantum mechanics—it describes how wavefunctions evolve in time.

**Time-dependent Schrödinger equation**:

$$i\hbar\frac{\partial}{\partial t}\Psi(\vec{r}, t) = \hat{H}\Psi(\vec{r}, t)$$

Where:
- $i$ = imaginary unit ($\sqrt{-1}$)
- $\hbar$ = reduced Planck constant
- $\Psi(\vec{r}, t)$ = **wavefunction** (complex-valued)
- $\hat{H}$ = Hamiltonian operator (total energy)

This is the **quantum analog of Newton''s second law** ($F = ma$)!

## What Is a Wavefunction?

The **wavefunction** $\Psi(\vec{r}, t)$ contains all information about a quantum system.

### Probability Interpretation (Born, 1926)

$$|\Psi(\vec{r}, t)|^2 = \text{probability density}$$

**Born rule**: The square modulus of wavefunction gives the probability of finding the particle at position $\vec{r}$.

### Key Properties

1. **Complex-valued**: $\Psi$ is a complex number (has amplitude and phase)
2. **Normalized**: $\int |\Psi|^2 d^3r = 1$ (total probability = 1)
3. **Linear**: Can add wavefunctions ($\Psi = \Psi_1 + \Psi_2$)
4. **Continuous evolution**: Wavefunction evolves smoothly via Schrödinger equation

## The Hamiltonian Operator

For a particle in potential $V(\vec{r})$:

$$\hat{H} = -\frac{\hbar^2}{2m}\nabla^2 + V(\vec{r})$$

Where:
- $-\frac{\hbar^2}{2m}\nabla^2$ = kinetic energy operator
- $V(\vec{r})$ = potential energy

**Schrödinger equation** becomes:
$$i\hbar\frac{\partial}{\partial t}\Psi = -\frac{\hbar^2}{2m}\nabla^2\Psi + V\Psi$$

## Time-Independent Schrödinger Equation

For stationary states (energy eigenstates):

$$\hat{H}\psi_n = E_n\psi_n$$

Where:
- $\psi_n$ = eigenfunction (stationary state)
- $E_n$ = eigenvalue (energy level)

The general solution is:
$$\Psi(\vec{r}, t) = \sum_n c_n \psi_n(\vec{r}) e^{-iE_n t/\hbar}$$

Each eigenstate oscillates with frequency $\omega_n = E_n/\hbar$.

## Examples

### Example 1: Infinite Square Well

A particle trapped in 1D box of length $L$:

```
      V = ∞       V = 0      V = ∞
         │           ║            │
    0   │           ║            │  L
  ───────────       ║            ─────────
         │           ║            │
         │           ║            │
      x = 0      x = L        x
```

**Potential**: $V(x) = 0$ for $0 < x < L$, $\infty$ otherwise

**Solutions**:
$$\psi_n(x) = \sqrt{\frac{2}{L}}\sin\left(\frac{n\pi x}{L}\right)$$

$$E_n = \frac{n^2\pi^2\hbar^2}{2mL^2}$$

where $n = 1, 2, 3, ...$

**Ground state** ($n=1$):
$$E_1 = \frac{\pi^2\hbar^2}{2mL^2}$$

$$\psi_1(x) = \sqrt{\frac{2}{L}}\sin\left(\frac{\pi x}{L}\right)$$

**Zero-point energy**: Even in ground state, $E_1 > 0$!

### Example 2: Quantum Harmonic Oscillator

**Potential**: $V(x) = \frac{1}{2}m\omega^2 x^2$ (parabolic well)

**Energy levels**:
$$E_n = \left(n + \frac{1}{2}\right)\hbar\omega$$

where $n = 0, 1, 2, ...$

**Ground state energy**:
$$E_0 = \frac{1}{2}\hbar\omega > 0$$

Even at absolute zero, the oscillator has **non-zero energy** due to uncertainty principle!

### Example 3: Hydrogen Atom

**Potential**: $V(r) = -\frac{ke^2}{r}$ (Coulomb potential)

**Solutions** (Bohr model energies):
$$E_n = -\frac{13.6 \text{ eV}}{n^2}$$

where $n = 1, 2, 3, ...$

**Wavefunctions**: $\psi_{nlm}(r, \theta, \phi)$ (spherical harmonics)

For ground state ($n=1, l=0, m=0$):
$$\psi_{100}(r) = \frac{1}{\sqrt{\pi a_0^3}} e^{-r/a_0}$$

where $a_0 = \frac{4\pi\epsilon_0\hbar^2}{me^4} \approx 0.053 \text{ nm}$ (Bohr radius)

## Tunneling

A particle can "tunnel" through a classically forbidden barrier:

```
    E       V(x)         E
    ────────╮              ─────
     │       ╲  Barrier    │
     │        ╲            │
     │         ╲           │
  ═════      ╲          ═════
  incoming    ╲        │  transmitted
    │         ╲       │
    ─          ╲      │
                    ╲    │
                     ╲──
```

**Transmission probability** (rectangular barrier):
$$T \approx e^{-2\gamma L}, \quad \gamma = \frac{\sqrt{2m(V_0 - E)}}{\hbar}$$

**Real-world application**: Alpha decay!

## Measurement and Collapse

When you measure position (e.g., detect particle at $x_0$):

**Before measurement**:
$$|\Psi|^2 = \text{spread-out probability distribution}$$

**After measurement**:
$$\Psi \rightarrow \delta(x - x_0)$$

The wavefunction **collapses** to a localized state!

This collapse is:
- **Non-unitary** (not described by Schrödinger equation)
- **Irreversible** (can''t "undo" measurement)
- **Controversial**: What constitutes "measurement"? (Measurement problem)

## Operators in Quantum Mechanics

Observables correspond to **Hermitian operators**:

| Observable | Operator | Action on $\Psi$ |
|----------|---------|-------------------|
| Position | $\hat{x} = x$ | Multiply by $x$ |
| Momentum | $\hat{p} = -i\hbar\frac{\partial}{\partial x}$ | Take derivative |
| Energy | $\hat{H} = i\hbar\frac{\partial}{\partial t}$ | Time derivative |
| Angular momentum | $\hat{L}_z = -i\hbar\frac{\partial}{\partial \phi}$ | Azimuthal derivative |

**Eigenvalue equation**:
$$\hat{A}\psi_a = a\psi_a$$

Measuring observable $\hat{A}$ yields one of its eigenvalues $a$ with probability:
$$P(a) = |\langle\psi_a|\Psi\rangle|^2$$

## Key Equations

| Equation | Quantity |
|----------|----------|
| $i\hbar\partial_t\Psi = \hat{H}\Psi$ | Time-dependent SE |
| $\hat{H}\psi_n = E_n\psi_n$ | Time-independent SE |
| $|\Psi|^2$ = probability density | Born rule |
| $E_n = \hbar\omega(n + 1/2)$ | Harmonic oscillator |
| $T \approx e^{-2\gamma L}$ | Tunneling probability |

## Sources
- Schrödinger, E. (1926). "Quantization as an Eigenvalue Problem"
- Griffiths, D. (2018). "Introduction to Quantum Mechanics, 2nd ed."
- Shankar, R. (2012). "Principles of Quantum Mechanics, 2nd ed."
- Liboff, R.L. (2003). "Introductory Quantum Mechanics"
- Khan Academy: "Schrödinger equation"
',

  '[
    {
      "question": "What is the Schrödinger equation?",
      "options": ["An equation describing how wavefunctions evolve in time (quantum analog of F=ma)", "An equation for classical wave motion", "An equation describing electron orbits in atoms", "An equation for particle diffusion"],
      "correctAnswer": 0,
      "explanation": "The Schrödinger equation (iℏ∂Ψ/∂t = ĤΨ) describes how quantum wavefunctions evolve in time. It''s the fundamental equation of quantum mechanics—the analog of Newton''s second law (F=ma) for quantum systems. The Hamiltonian Ĥ represents total energy."
    },
    {
      "question": "What does the wavefunction Ψ represent?",
      "options": ["A physical wave moving through space", "A complex-valued function whose squared modulus |Ψ|² gives probability density", "A description of particle''s definite trajectory", "A type of energy field"],
      "correctAnswer": 1,
      "explanation": "The wavefunction Ψ contains all information about a quantum system. According to the Born rule, |Ψ|² gives the probability density of finding the particle at a given position. Ψ is complex (amplitude + phase) and describes probabilities, not definite values."
    },
    {
      "question": "What is the ground state energy of a quantum harmonic oscillator?",
      "options": ["0 (no energy at absolute zero)", "ℏω/2 (non-zero due to uncertainty principle)", "ℏω", "∞"],
      "correctAnswer": 1,
      "explanation": "E₀ = (n + 1/2)ℏω with n=0 gives E₀ = ℏω/2. Even in its ground state (lowest energy), a quantum oscillator has non-zero energy! This is due to position-momentum uncertainty preventing Δx = 0 (perfect localization)."
    },
    {
      "question": "What is the energy of the nth level in an infinite square well of length L?",
      "options": ["En = n²π²ℏ²/2mL²", "En = nπ²ℏ²/2mL²", "En = n²π²ℏ²/mL²", "En = π²ℏ²/2n²mL²"],
      "correctAnswer": 0,
      "explanation": "En = n²π²ℏ²/2mL². The energy levels are QUADRATIC in n (E ∝ n²) for an infinite square well. Ground state (n=1) has E₁ = π²ℏ²/2mL², first excited (n=2) has E₂ = 2π²ℏ²/mL² = 4E₁, and so on. Energy is quantized!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'quantum-mechanics' LIMIT 1),
  'Quantum Tunneling and Barriers',
  'quantum-tunneling',
  5,
  '# Quantum Tunneling and Barriers

## What Is Quantum Tunneling?

**Quantum tunneling** is a quantum phenomenon where a particle penetrates a **potential barrier** that it classically could not surmount.

The particle "tunnels" through the barrier like a ghost walking through a wall!

### Classical vs. Quantum Behavior

**Classical particle**:
$$E < V_0 \rightarrow \text{cannot penetrate!}$$

If a ball doesn''t have enough energy to roll over a hill, it rolls back—simple as that!

**Quantum particle**:
$$\text{Probability} > 0 \text{ even if } E < V_0$$

Wavefunction extends into and through barrier—small probability of being on the other side!

## The Tunneling Probability

For a rectangular barrier of height $V_0$ and width $L$:

$$T \approx e^{-2\gamma L}$$

Where:
- $T$ = transmission probability
- $\gamma = \frac{\sqrt{2m(V_0 - E)}}{\hbar}$ (decay constant)
- $L$ = barrier width

**Exponential dependence**: Small increases in width or height cause exponentially smaller transmission!

### Scanning Tunneling Microscope (STM)

An STM uses tunneling to image surfaces:

```
      Metal tip          Sample surface
           ↘                ↕
        (─)  Voltage          ══════
           bias              atoms
       (~0.1-1 V)
           ~1 nm
           (tunneling
           gap)
```

**Principle**: Sharp metal tip brought within ~1 nm of surface. Voltage bias creates electron tunneling current.

**Current** depends exponentially on distance:
$$I \propto e^{-2\kappa d}$$

Where:
- $\kappa$ = decay constant
- $d$ = tip-sample separation

**Resolution**: Can image **individual atoms**!

## Real-World Applications

### 1. Alpha Decay

Alpha particle ($^4$He nucleus) tunnels out of heavy nucleus:

```
        Parent nucleus (U-238)
              ╔═══╦═══╗
              ║  ║   Barrier
              ║  ║   (nuclear
        alpha →  ║  ╱  ╲   force)
      particle  ║ ╱    ╲
                ↓   ↓
              Daughter (Th-234)
```

**Gamow factor** (tunneling probability):
$$P \approx e^{-2G(Z-2)z/R/\hbar v}$$

Where:
- $G, Z$ = nuclear constants
- $R$ = nuclear radius
- $v$ = alpha particle velocity

**Half-lives**: U-238 ($4.5 \times 10^9$ years), Pu-239 ($24,000$ years)

More massive nuclei → higher barrier → shorter half-life!

### 2. Nuclear Fusion in Stars

**Proton-proton fusion** requires tunneling through Coulomb barrier:

```
    p⁺          p⁺          (²H)
     ↘          ↙
      ╱  ╲    ╱   ╲
     ╱    ╲   ╱     ╲
    ╱      ╲  →  ╲  →  ╲  ╱  ╲
   Barrier     ╱     ╲      ╲→ → (³He)
 (Coulomb     ╱       ╲  → ²H
  repulsion)  ↘        ↙
```

**Sun''s core temperature**: $1.5 \times 10^7$ K

**Barrier height**: $\sim 400$ keV

**Thermal energy**: $\sim 1$ keV

**Tunneling**: Allows fusion despite $E \ll V_0$!

### 3. Esaki Diode (Tunnel Diode)

Leo Esaki (1975 Nobel Prize) created first **quantum device** using tunneling:

```
        p      n         p
    (metal)  (thin      (metal)
      │       insulator)   │
      │      1-3 nm)     │
    ───────                ───────
      ↓                    ↓
    Current flows          Current blocked
    (tunneling)         (classically)
```

**Characteristics**:
- **Negative resistance**: Current decreases as voltage increases
- **Non-Ohmic**: Doesn''t follow $V = IR$
- **Fast response**: Electrons tunnel instantaneously (no drift in insulator)

### 4. Josephson Junctions

Two superconductors separated by thin insulator:

$$I = I_c \sin(\phi)$$

Where:
- $I_c$ = critical current
- $\phi$ = phase difference

**Applications**:
- SQUIDs (Superconducting QUantum Interference Devices)
- Voltage standard
- Qubit readout

## Examples

### Example 1: Electron Tunneling

Barrier: $V_0 = 10 \text{ eV}$, $L = 0.5 \text{ nm}$
Electron energy: $E = 5 \text{ eV}$

$$\gamma = \frac{\sqrt{2(9.11 \times 10^{-31})(10 - 5)(1.6 \times 10^{-19})}}{1.055 \times 10^{-34}} \approx 1.1 \times 10^{10} \text{ m}^{-1}$$

$$T \approx e^{-2(1.1 \times 10^{10})(0.5 \times 10^{-9})} \approx e^{-11} \approx 1.7 \times 10^{-5}$$

**About 0.002%** of electrons tunnel through!

### Example 2: STM Current

Tip-sample distance: $d = 1 \text{ nm}$
Barrier height: $V_0 = 4 \text{ eV}$ (work function)

$$\kappa = \frac{\sqrt{2(9.11 \times 10^{-31})(4)(1.6 \times 10^{-19})}}{1.055 \times 10^{-34}} \approx 10^{10} \text{ m}^{-1}$$

Current change for $\Delta d = 0.1 \text{ nm}$:
$$\frac{I(d+\Delta d)}{I(d)} = e^{-2\kappa \Delta d} = e^{-2(10^{10})(10^{-10})} = e^{-2} \approx 0.135$$

**Current changes by factor of ~7** for 0.1 nm change—enormous sensitivity!

## Cold Emission (Field Emission)

Tunneling from **electric field** lowering barrier:

```
     Vacuum level         Metal
         ╱                   ══════
        ╱  ╲                     ║
       ╱    ╲                    ║
      ╱      ╲    Field          ║
     ╱  F  ╲  ╲═→══→════════╗
    ╱        ╲     (triangular)      ║ electrons
   ╱          ╲                  ║
  E                           ══════╝
```

**Fowler-Nordheim equation**:
$$J \propto E^2 \exp\left(-\frac{B^{3/2}}{E}\right)$$

Stronger fields dramatically increase electron emission (used in flat panel displays)!

## Semiclassical Approximation

For energies **just below** barrier top:

Use WKB approximation:
$$T \approx \exp\left[-2\int_0^L \sqrt{\frac{2m(V(x) - E)}{\hbar^2}} dx\right]$$

Accounts for:
- **Barrier shape** (not just rectangular)
- **Energy dependence** of tunneling

**Applications**:
- Nuclear fusion rates
- Molecular reactions
- Semiconductor device modeling

## Key Equations

| Equation | Quantity |
|----------|----------|
| $T \approx e^{-2\gamma L}$ | Rectangular barrier transmission |
| $\gamma = \sqrt{2m(V_0-E)}/\hbar$ | Decay constant |
| $I \propto e^{-2\kappa d}$ | STM tunneling current |
| $J \propto E^2 \exp(-B^{3/2}/E)$ | Field emission (Fowler-Nordheim) |

## Common Misconceptions

**Misconception**: "Tunneling violates energy conservation."

**Reality**: The particle doesn''t "go over" the barrier—it appears on the other side with **same energy** it started with. Total energy is conserved; tunneling is a purely quantum effect with no classical analog!

**Misconception**: "Particles move faster than light while tunneling."

**Reality**: No measurable faster-than-light motion. Tunneling time is consistent with relativity—phase accumulation in barrier, not superluminal propagation!

## Sources
- Esaki, L. (1958). "New Phenomenon in Rectifying Barrier in Germanium"
- Gamow, G. (1928). "Quantum Theory of Nuclear Alpha-Disintegration"
- Gurney, R.W. et al. (1977). "Tunneling in Semiconductors"
- Bardeen, J. (1961). "Tunneling from a Many-Particle Point of View"
',

  '[
    {
      "question": "What is quantum tunneling?",
      "options": ["Particles overcoming barriers with enough energy", "Particles penetrating classically forbidden barriers by being ''wavelike'' and passing through", "Particles moving faster than light", "Particles bouncing off barriers"],
      "correctAnswer": 1,
      "explanation": "Quantum tunneling occurs when a particle''s wavefunction extends through a potential barrier higher than the particle''s energy. The particle doesn''t go ''over'' the barrier—it appears on the other side with same energy, due to its wavelike nature. Probability decreases exponentially with barrier width and height."
    },
    {
      "question": "How does tunneling probability depend on barrier width (L)?",
      "options": ["T ∝ 1/L (linear decrease)", "T ∝ L (linear)", "T ∝ e^(-2γL) (exponential decrease)", "T ∝ e^(2γL) (exponential increase)"],
      "correctAnswer": 2,
      "explanation": "Transmission probability T ≈ e^(-2γL) decreases EXPONENTIALLY with barrier width L. Doubling width dramatically reduces tunneling probability (e.g., 1% → 0.01% → 0.0001%). This is why thin barriers allow much more tunneling than thick ones!"
    },
    {
      "question": "What is the primary application of scanning tunneling microscopy (STM)?",
      "options": ["Measuring electrical conductivity of materials", "Imaging individual atoms by measuring electron tunneling current between tip and surface", "Observing light emission from samples", "Detecting magnetic fields at atomic scale"],
      "correctAnswer": 1,
      "explanation": "STM works by bringing a sharp metal tip within ~1 nm of a sample surface. Electrons tunnel through the vacuum gap, creating a current that depends exponentially on distance. By scanning the tip and measuring current variations, individual atoms can be imaged!"
    },
    {
      "question": "Why does nuclear fusion occur in the Sun despite core temperature (~1 keV) being far below the Coulomb barrier height (~400 keV)?",
      "options": ["The temperature is actually high enough", "Quantum tunneling allows protons to penetrate the barrier", "The barrier becomes weaker at high densities", "Classical physics is wrong—fusion doesn''t actually happen"],
      "correctAnswer": 1,
      "explanation": "Protons tunnel through the Coulomb barrier despite E << V₀! Tunneling probability is small but non-zero. In the Sun''s dense core, enough protons tunnel to sustain fusion. Without tunneling, stars wouldn''t shine—fusion would require impossibly high temperatures!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: PARTICLE PHYSICS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'advanced-physics' LIMIT 1),
  'Particle Physics',
  'particle-physics',
  'Explore the Standard Model: quarks, leptons, bosons, and the fundamental forces.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'particle-physics' LIMIT 1),
  'The Standard Model of Particle Physics',
  'standard-model',
  1,
  '# The Standard Model of Particle Physics

## What Is the Standard Model?

The **Standard Model** is the most successful theory of particle physics, describing **all known fundamental particles** and three of the four fundamental forces (excluding gravity).

It''s a quantum field theory combining quantum mechanics and special relativity!

## Fundamental Particles

### Fermions (Matter Particles)

Fermions have **half-integer spin** ($1/2, 3/2, 5/2, ...$) and obey **Pauli exclusion principle**.

**Quarks** (spin-1/2, make up hadrons):

| Generation | Up-type | Down-type |
|----------|---------|----------|
| 1 | Up ($u$) | Down ($d$) |
| 2 | Charm ($c$) | Strange ($s$) |
| 3 | Top ($t$) | Bottom ($b$) |

**Leptons** (spin-1/2, don''t participate in strong force):

| Generation | Charged | Neutral |
|----------|--------|--------|
| 1 | Electron ($e^-$) | Electron neutrino ($\nu_e$) |
| 2 | Muon ($\mu$) | Muon neutrino ($\nu_\mu$) |
| 3 | Tau ($\tau$) | Tau neutrino ($\nu_\tau$) |

**Properties**:
- 3 **generations** (each heavier than the last)
- 12 fermions total (6 quarks + 6 leptons)
- Quarks have **color charge** (red, green, blue)
- Leptons have **weak isospin**

### Bosons (Force Carriers)

Bosons have **integer spin** ($0, 1, 2, ...$) and can occupy the same state.

**Gauge bosons** (mediate forces):

| Force | Mediator | Mass | Spin | Range |
|-------|----------|------|------|------|
| Electromagnetic | Photon ($\gamma$) | 0 | ∞ |
| Weak | W⁺, W⁻, Z⁰ | 80-90 GeV | ~10⁻¹⁸ m |
| Strong | 8 gluons ($g$) | 0 | ~10⁻¹⁵ m |
| Gravity (?) | Graviton (?) | (?) | (?) |

**Higgs boson** ($H$): Mass ~125 GeV, gives mass to W/Z, quarks, leptons

### Composite Particles

**Hadrons** (quark bound states):

- **Mesons**: Quark-antiquark pair ($q\bar{q}$)
  - Pions ($\pi^+, \pi^0, \pi^-$)
  - Kaons ($K^+, K^0, K^-$)
  - ...over 200 types

- **Baryons**: Three quarks ($qqq$)
  - Proton ($uud$)
  - Neutron ($udd$)
  - ...hundreds of types

**Atomic nuclei**: Bound states of protons and neutrons

## The Four Fundamental Forces

### 1. Electromagnetic Force

**Mediated by**: Photons ($\gamma$)
**Strength**: $\alpha \approx 1/137$ (fine-structure constant)
**Range**: Infinite
**Acts on**: All charged particles
**Theory**: QED (Quantum Electrodynamics)

### 2. Weak Nuclear Force

**Mediated by**: W⁺, W⁻, Z⁰ bosons
**Strength**: $G_F \approx 10^{-6}$ (Fermi constant)
**Range**: ~10⁻¹⁸ m (very short!)
**Acts on**: Quarks, leptons
**Theory**: Electroweak theory

**Key processes**:
- Beta decay ($n \rightarrow p + e^- + \bar{\nu}_e$)
- Neutrino interactions
- Fusion in stars

### 3. Strong Nuclear Force

**Mediated by**: 8 gluons ($g$)
**Strength**: $\alpha_s \approx 1$ (strong coupling constant)
**Range**: ~10⁻¹⁵ m (size of proton)
**Acts on**: Quarks and gluons only (color charge)
**Theory**: QCD (Quantum Chromodynamics)

**Properties**:
- **Confinement**: Quarks never found alone (always in hadrons)
- **Asymptotic freedom**: Quarks behave freely at high energies
- **Self-interaction**: Gluons interact with each other (carry color)

### 4. Gravity

**Mediated by**: Gravitons (hypothetical, not yet detected)
**Strength**: $G_N \approx 6.67 \times 10^{-11}$ (very weak!)
**Range**: Infinite
**Acts on**: Everything with mass/energy
**Theory**: General relativity (classical), quantum gravity (unknown)

**Problem**: Not successfully integrated with Standard Model!

## Beyond the Standard Model

### Known Issues

1. **Neutrino masses**: Standard Model assumes massless, but neutrinos oscillate
2. **Dark matter**: Not in Standard Model—requires new particles (WIMPs?)
3. **Matter-antimatter asymmetry**: Why is there more matter than antimatter?
4. **Gravity**: No quantum description—string theory? Loop quantum gravity?
5. **Hierarchy problem**: Why is gravity so weak compared to other forces?
6. **Strong CP problem**: Why no strong CP violation to explain baryon asymmetry?

### Proposed Extensions

| Theory | Key Idea | Status |
|----------|---------|--------|
| Supersymmetry (SUSY) | Fermion-boson symmetry | Not yet detected |
| String theory | Particles as vibrating strings | No experimental confirmation |
| Extra dimensions | 4D spacetime too small | No direct evidence |
| Grand Unified Theories (GUTs) | Unify electroweak + strong | Not tested |
| Technicolor | Higgs as composite | Unconfirmed |

## The Higgs Mechanism

**Spontaneous symmetry breaking** gives mass to particles:

```
  Symmetry         Higgs field
   (all massless)  →  ◯◯◯◯◯
                         (Mexican hat
                          potential)
                              ↓
                     Particles acquire mass
                    by interacting with Higgs
```

**Higgs vacuum expectation value**: $v \approx 246$ GeV

**Particle masses**: $m = \frac{yv}{\sqrt{2}}$

Where:
- $y$ = Yukawa coupling constant
- $v$ = Higgs field value

**Top quark**: $y_t \approx 1$ → $m_t \approx 173$ GeV
**Electron**: $y_e \approx 10^{-6}$ → $m_e \approx 0.511$ MeV

## Examples

### Example 1: Proton Composition

Proton = $uud$ (up quark, up quark, down quark)

**Charge**: $2/3 + 2/3 - 1/3 = +1$ ✓
**Spin**: $1/2 + 1/2 + 1/2 = 3/2$ (integer for composite)
**Mass**: $2.3 + 2.3 + 4.8 \approx 938$ MeV (close to 938.3 MeV)

**Color wavefunction**: $\varepsilon_{abc} (u^a_R d^b_G u^c_B)$ where $a,b,c$ are color indices

### Example 2: Beta Decay

Neutron ($udd$) → Proton ($uud$) + $e^-$ + $\bar{\nu}_e$

**Weak interaction**: $d \rightarrow u + W^-$
**W boson decay**: $W^- \rightarrow e^- + \bar{\nu}_e$

**Matter flow**:
$$udd \rightarrow uud + e^- + \bar{\nu}_e$$

**Conservation**:
- Charge: $0 \rightarrow 1 - 1 + 0 = 0$ ✓
- Lepton number: $0 \rightarrow 0 + 1 - 1 = 0$ ✓
- Baryon number: $1 \rightarrow 1 + 0 + 0 = 1$ ✓

### Example 3: Particle Accelerations

**LHC energies**: $\sqrt{s} = 13$ TeV

Where:
- $\sqrt{s}$ = center-of-mass energy
- Protons have $E = 6.5$ TeV each

**Production**:
- **Higgs boson**: Discovered 2012! ($m_H \approx 125$ GeV)
- **Top quark**: $m_t \approx 173$ GeV (heaviest elementary particle)
- **BSM searches**: No deviations from SM yet

## Key Equations

| Equation | Quantity |
|----------|----------|
| $L_{SM} = \sum_{fermions} \bar{\psi}_f(i\partial\!\!\!\!/ - m_f)\psi_f + ...$ | Standard Model Lagrangian |
| $m_f = y_f v/\sqrt{2}$ | Higgs mechanism mass |
| $G_F \approx 10^{-6}$ | Fermi constant (weak force) |
| $\alpha \approx 1/137$ | Fine-structure constant (EM force) |
| $\sigma_{tot} = \sigma_{weak} + \sigma_{strong} + \dots$ | Cross sections |

## Sources
- Griffiths, D. (2008). "Introduction to Elementary Particles, 2nd ed."
- Peskin, M., Schroeder, D. (1995). "An Introduction to Quantum Field Theory"
- CERN: "Standard Model"
- PDG (Particle Data Group): "Review of Particle Physics"
- Thomson, M. (2013). "Modern Particle Physics"
',

  '[
    {
      "question": "What are the three generations of fermions in the Standard Model?",
      "options": ["(up, down), (charm, strange), (top, bottom) for both quarks and leptons", "Only leptons: (electron, muon), (muon neutrino, tau neutrino)", "Only quarks with all six types", "Up quark and electron only"],
      "correctAnswer": 0,
      "explanation": "The Standard Model has 3 generations of both quarks and leptons: Generation 1 (up/down quarks, electron, electron neutrino), Generation 2 (charm/strange quarks, muon, muon neutrino), Generation 3 (top/bottom quarks, tau, tau neutrino). Each generation is identical except for mass—heavier generations decay to lighter ones!"
    },
    {
      "question": "Which fundamental force has the SHORTEST range and is mediated by W± and Z bosons?",
      "options": ["Electromagnetic force", "Strong nuclear force", "Weak nuclear force (~10⁻¹⁸ m range)", "Gravity"],
      "correctAnswer": 2,
      "explanation": "The weak nuclear force has the shortest range (~10⁻¹⁸ m, about 0.1% of proton diameter) and is mediated by W⁺, W⁻, and Z⁰ bosons with masses 80-90 GeV. This short range explains why weak interactions are rare compared to electromagnetic and strong forces!"
    },
    {
      "question": "What is color charge in quantum chromodynamics (QCD)?",
      "options": ["Electric charge of quarks", "A property of quarks that comes in three types (red, green, blue) and is confined to hadrons", "The polarization of photons", "The weak isospin of leptons"],
      "correctAnswer": 1,
      "explanation": "Color charge is a property of quarks (NOT visual color) that comes in three types: red, green, blue. All hadrons (protons, neutrons, mesons) must be color-neutral. Color is confined—quarks are never observed alone, always bound in colorless hadrons!"
    },
    {
      "question": "What gives mass to elementary particles in the Standard Model?",
      "options": ["The Higgs field spontaneous symmetry breaking gives particles mass by coupling strength", "Particles have intrinsic mass from the Big Bang", "Mass comes from the kinetic energy of particles", "Only W and Z bosons get mass from Higgs"],
      "correctAnswer": 0,
      "explanation": "The Higgs field permeates all space (in vacuum state). Particles acquire mass m = yv/√2 by coupling to the Higgs field with strength y. The top quark (y≈1) gets ~173 GeV, while the electron (y≈10⁻⁶) gets only 0.511 MeV. Heavier couplings → larger masses!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'particle-physics' LIMIT 1),
  'Particle Accelerators and Detectors',
  'particle-accelerators-detectors',
  2,
  '# Particle Accelerators and Detectors

## How Do We Study Particles?

Since particles are too small to see directly, we:
1. **Accelerate** them to high energies
2. **Collide** them to create new particles
3. **Detect** decay products indirectly

## Particle Accelerators

### Basic Principles

**Cyclotron motion** (in magnetic field):
$$F = q(\vec{v} \times \vec{B}) = \frac{mv^2}{r}$$

Centripetal force = magnetic force → **circular orbit**!

**Radius of curvature**:
$$r = \frac{mv}{qB}$$

**Cyclotron frequency**:
$$f_c = \frac{qB}{2\pi m}$$

Particle spirals outward as energy increases!

### Synchrotron

As particle approaches light speed, mass increases relativistically:
$$m = \gamma m_0$$

Fixed magnetic field doesn''t work → **vary B with radius** to keep particles in sync!

```
     RF cavities          Ring magnets
         ↓                  ↓
    (─)                    ╔═══╦═══╗
  accelerating    →→→→→  →   ║     ║
  particles      circular    ║     ║
                 orbit      ║     ║
                            ╚═══╩═══╝
```

**Examples**:
- LHC: 27 km circumference, 8.33 Tesla magnetic field
- Fermilab: 6.3 km ring, 0.75 Tesla (historical)

### Linear Accelerators

For linear acceleration (not circular):

```
Target
    ↓
     ══════
      │
      │
      │
   ════════→→→→
  drift tubes
      (quadrupole
       focusing)
```

**Examples**:
- SLAC (Stanford Linear Accelerator): 3 km long
- ILC (proposed): 20 km linear collider

## Major Accelerators

### 1. Large Hadron Collider (LHC)

**Location**: CERN, Geneva (French-Swiss border)
**Type**: Proton-proton, heavy ion
**Energy**: $\sqrt{s} = 13$ TeV
**Circumference**: 27 km
**Magnets**: 1,232 dipole magnets (8.33 T)
**Discoveries**:
- Higgs boson (2012)
- Top quark properties
- Pentaquark states
- **No new physics beyond SM** (as of 2024)

### 2. Tevatron (Fermilab, USA)

**Type**: Proton-antiproton
**Energy**: $\sqrt{s} = 1.96$ TeV
**Circumference**: 6.3 km
**Decommissioned**: 2011 (after LHC surpassed)
**Discoveries**: Top quark (1995), tau neutrino (2000)

### 3. SLAC (Stanford Linear Accelerator)

**Type**: Linear electron-positron
**Energy**: 50 GeV
**Discoveries**: Charm quark (1974), tau lepton (1975)

### 4. SuperKEKB (Japan)

**Type**: Electron-positron
**Energy**: $\sqrt{s} \approx 10$ GeV (asymetric)
**Status**: World''s highest-energy lepton collider

### Future: Proposed Colliders

| Proposal | Energy | Type | Timeline |
|----------|-------|------|----------|
| FCC (Future Circular Collider) | 100 TeV | 2040s? |
| ILC (International Linear Collider) | 250 GeV | 2030s? |
| CLIC (Compact Linear Collider) | 3 TeV | 2040s? |
| Muon Collider | 10 TeV | Uncertain (muons decay!) |

## Particle Detectors

### General Detector Layers

```
             Forward detectors
                  ↓
            ╔═══════╦══════╗
            ║ tracking  ║ calorimeter
            ║ (silicon) ║ (PbWO₄,
            ║           ║  scintillator)
            ╚═══════╩══════╝
                  ↓
            Muon chambers
                  ↓
             ┌───────┐
             │  Toroidal│
             │  magnet  │
             └───────┘
```

### Detector Components

**1. Tracking detectors** (inner):
- Silicon pixel/strip detectors
- **Precision**: ~10 μm position resolution
- **Purpose**: Reconstruct decay vertices

**2. Calorimeters** (energy measurement):
- **Electromagnetic**: PbWO₄ (lead tungstate), detect photons/e⁻
- **Hadronic**: Scintillator + steel, detect hadrons
- **Purpose**: Measure particle energy

**3. Muon chambers** (outer):
- **Drift tubes** or **cathode strip chambers**
- **Purpose**: Identify penetrating muons

**4. Magnet system**:
- **Solenoid** (bending for momentum measurement)
- **Toroid** (returning field)

### ATLAS vs. CMS

**ATLAS** (A Toroidal LHC ApparatuS):
- Length: 44 m, diameter: 25 m
- Weight: 7,000 tonnes
- ** Barrel + end-cap** geometry

**CMS** (Compact Muon Solenoid):
- Length: 21 m, diameter: 15 m
- Weight: 14,000 tonnes
- **Solenoid-centered** design

## How Detectors Work

### Event Reconstruction

1. **Track finding**: Connect detector hits to particle tracks
2. **Vertexing**: Find where particles originated (collision point)
3. **Particle identification**: Use track patterns, calorimeter deposits
4. **Momentum**: Measure curvature in magnetic field
5. **Missing energy**: Look for neutrinos or new particles

### Trigger Systems

Collision rate: **40 MHz** (40 million per second!)

Most are uninteresting—**trigger** selects ~1 kHz for storage:

**Trigger types**:
- **Muon trigger**: High-pT muons
- **Missing energy**: Imbalanced calorimeters
- **High-pT jets**: Narrow cone of energy

## Data Analysis

### Monte Carlo Simulations

**Simulate** Standard Model predictions:
$$\sigma(pp \rightarrow X) = \text{predicted cross-section}$$

Compare with **observed rates**:
- **Agreement**: Standard Model confirmed
- **Discrepancy**: New physics hint!

### Analysis Challenges

- **Pile-up**: Multiple interactions per bunch crossing
- **Luminosity**: Number of collisions per area-time
  $$L = \frac{N_{events}}{\sigma \cdot \text{integrated luminosity}}$$
- **Systematic uncertainties**: Detector calibration effects

## Discoveries and Limits

### Confirmed Discoveries

- **Higgs boson** (2012): Mass 125 GeV, SM-like properties
- **Top quark**: Mass 173 GeV (heaviest fermion)
- **W/Z bosons**: Masses confirmed to high precision
- **Neutrino oscillations**: Proof of mass (beyond SM)

### Null Results (Constraints on BSM)

- **Supersymmetry**: No superpartners found at LHC energies
- **Extra dimensions**: No microscopic black hole signatures
- **Dark matter**: No WIMP candidates detected

## Key Equations

| Equation | Quantity |
|----------|----------|
| $r = mv/qB$ | Cyclotron radius |
| $f_c = qB/2\pi m$ | Cyclotron frequency |
| $m = \gamma m_0$ | Relativistic mass increase |
| $L = \int \mathcal{L} dt$ | Integrated luminosity |
| $\sigma = N/\mathcal{L}$ | Cross section |

## Sources
- CERN: "LHC Guide"
- ATLAS Experiment: "Detector Performance"
- CMS Experiment: "Detector Overview"
- Grupen, C., Shupe, M. (2008). "Experimental Methods in High Energy Physics"
- Thomson, M. (2013). "Modern Particle Physics"
',

  '[
    {
      "question": "What is the basic principle behind a circular particle accelerator?",
      "options": ["Electric fields accelerate in straight line", "Magnetic fields bend charged particles into circular paths (F = qv×B)", "Particles are reflected between mirrors", "Particles move faster than light in a vacuum"],
      "correctAnswer": 1,
      "explanation": "In circular accelerators (cyclotrons, synchrotrons), charged particles are bent into circular orbits by magnetic fields via the Lorentz force F = q(v×B). As particles gain energy from RF cavities, they spiral outward at larger radius while maintaining the cyclotron frequency f = qB/2πm!"
    },
    {
      "question": "What is the energy scale of the Large Hadron Collider (LHC)?",
      "options": ["1.96 TeV (Tevatron)", "13 TeV center-of-mass energy", "100 GeV", "250 GeV"],
      "correctAnswer": 1,
      "explanation": "LHC collides protons at √s = 13 TeV. Each proton has 6.5 TeV energy. At these energies, protons move at 0.999999991c (γ ≈ 7,000). LHC discovered the Higgs boson (2012) and has placed stringent limits on physics beyond the Standard Model."
    },
    {
      "question": "Why do LHC detectors need muon chambers OUTSIDE the calorimeters?",
      "options": ["Calorimeters don''t work at low energies", "Muons are minimum ionizing and penetrate deeply to outer layers", "Muons are the only particles detected", "To measure magnetic field more accurately"],
      "correctAnswer": 1,
      "explanation": "Muons are minimum ionizing—they pass through the entire calorimeter without depositing much energy. Muon chambers in the outermost detector layer identify muons by their tracks and measure their momentum from curvature in the magnetic field. This helps distinguish muons from other particles!"
    },
    {
      "question": "What is integrated luminosity in particle physics?",
      "options": ["Total energy of all collisions", "Number of useful events divided by cross-section", "Total data storage capacity", "Frequency of collisions"],
      "correctAnswer": 1,
      "explanation": "Integrated luminosity ℒ = N_events/(σ × time). Cross-section σ is the effective interaction area for a process. Higher luminosity means more collisions and better statistics for rare processes. LHC achieves record-breaking luminosities to enable rare particle discoveries!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'particle-physics' LIMIT 1),
  'Dark Matter and Dark Energy',
  'dark-matter-dark-energy',
  3,
  '# Dark Matter and Dark Energy

## What Are Dark Matter and Dark Energy?

Astronomical observations reveal that **95% of the universe** is invisible and unknown!

**Composition of universe**:
- **5% ordinary matter** (atoms, stars, galaxies we see)
- **27% dark matter** (invisible but gravitates)
- **68% dark energy** (mysterious acceleration force)

Together, dark matter + dark energy = **95% of the universe**!

## Dark Matter

### Evidence for Dark Matter

#### 1. Galaxy Rotation Curves (1970s)

Vera Rubin observed that stars in spiral galaxies orbit **too fast**:

```
    Observed rotation:   Expected (visible mass only):
     ↑ fast                ↑ slow
    ↗   ↖               ↗   ↖
   ★   ★  →→→→       ★   ★  →→→→
  (fast!)             (slow!)
```

**If only visible mass**: Outer stars should fly off!

**Conclusion**: **Galaxies contain 5-10× more mass** than we see—dark matter halo!

#### 2. Gravitational Lensing

Mass bends light (Einstein''s prediction):

```
      Observer
          ↓
  ( distorted
   images)
       ↖      ↗
    ╱  ╲
   ╱    ╲
Galaxy  →  ╲  ●  ╱  (dark matter
(visible)   ╲  ╱            cluster)
             ╲ ╱
              ●
          (background
            galaxy)
```

**More lensing** than visible mass can explain → **dark matter**!

#### 3. Cosmic Microwave Background (CMB)

CMB fluctuations show:
- Matter grew to form structures: $\Omega_m \approx 0.27$
- **Most matter is dark** ($\Omega_{dm} \approx 0.26$, ordinary matter $\Omega_b \approx 0.05$)

#### 4. Bullet Cluster

Two galaxy clusters collided:

```
   Before (X-ray)    After
    ══╤═╗           ══╤═╗
    ║  ║             ║│  ║
  ══╪  ║    +     ══╪  ║
    ║  ║   →→     ║  ║
    ╚═╦═╝           ╚═╦═╝
 (normal)         (separated:
   ordinary matter   dark matter
    slows down     passes through)
```

**X-rays** show gas slowed (collision), but **lensing shows mass kept going** → dark matter!

### Dark Matter Candidates

| Candidate | Properties | Detection Status |
|----------|----------|-----------------|
| WIMPs (Weakly Interacting Massive Particles) | Mass 100 GeV-1 TeV | Not yet detected |
| Axions | Light pseudoscalar particle | Not yet detected |
| Neutrinos | Known to exist | Insufficient mass |
| Primordial black holes | 10¹⁵-10²⁰ kg | Not yet detected |
| MACHOs (Massive Compact Halo Objects) | Brown dwarfs, black holes | L ruled out most |

**WIMP detection strategies**:
1. **Direct detection**: Underground detectors (LUX, XENON, PandaX)
2. **Indirect detection**: Annihilation products (gamma rays, neutrinos)
3. **Collider production**: Create at LHC

## Dark Energy

### Discovery (1998)

Two teams measured distant supernovae:

**Expected**: Expansion should be **slowing down** (gravity)

**Observed**: Expansion is **speeding up**!

```
   Deceleration       Acceleration
    (expected)      (observed!)
      ↖              ↗
     ↖  ↘          ↖  ↗
    (⋆)   (⋆)      (⋆)   (⋆)
```

Nobel Prize (2011): Perlmutter, Schmidt, Riess!

### Properties

| Property | Value | Mystery |
|----------|-------|---------|
| Density | $\rho_\Lambda \approx 7 \times 10^{-27}$ kg/m³ | Constant as universe expands? |
| Pressure | $p = -\rho_\Lambda c^2$ | **Negative pressure!** |
| Equation of state | $w = p/\rho = -1$ | Unlike any matter! |

### The Cosmological Constant

$$\Lambda \approx 1.1 \times 10^{-52} \text{ m}^{-2}$$

In Einstein''s equations, $\Lambda$ acts like **repulsive gravity**!

## Fate of the Universe

Depends on dark energy behavior:

### Scenario 1: Big Freeze (Most Likely)

Dark energy remains constant → universe expands forever, cooling to absolute zero.

- Stars burn out ($10^{14}$ years)
- Black holes evaporate ($10^{67}$ years)
- Protons decay? ($10^{35}$+ years?)
- Heat death at $T \rightarrow 0$

### Scenario 2: Big Rip

If dark energy **increases** ($w < -1$):

- Galaxies torn apart
- Stars torn apart
- Atoms torn apart
- Spacetime itself rips apart!

Timeline: Tens of billions of years (if $w$ decreases)

### Scenario 3: Big Crunch

If dark energy **decreases** (becomes attractive):

- Expansion reverses
- Universe collapses to hot dense state
- **Big Bounce**? Could re-cycle?

**Current data**: Favors Big Freeze!

## Key Equations

| Equation | Quantity |
|----------|----------|
| $\Omega_m + \Omega_\Lambda = 1$ | Critical density |
| $\rho_\Lambda = \Lambda c^2 / 8\pi G$ | Dark energy density |
| $w = p/\rho$ | Equation of state parameter |
| $\Delta a/a \propto t^{2/3(1+w)}$ | Expansion history |

## Unsolved Mysteries

| Mystery | Description | Status |
|----------|-------------|--------|
| Coincidence problem | Why is $\rho_\Lambda \sim \rho_m$ now? | Unexplained |
| Nature of dark energy | Cosmological constant? Quintessence? | Unknown |
| Dark matter particle | What is it? | Not detected |
| Why $w \approx -1$? | Fundamental theory needed | Active research |

## Sources
- Perlmutter, S. et al. (1999). "Measurements of Omega and Lambda from 42 High-Redshift Supernovae"
- Riess, A. et al. (1998). "Observational Evidence from Supernovae for an Accelerating Universe and a Cosmological Constant"
- Planck Collaboration (2018). "Planck 2018 Results"
- Rubin, V. (1983). "Dark Matter in Spiral Galaxies"
- Bertone, G. et al. (2012). "Dark Matter vs. Modified Gravity"
',

  '[
    {
      "question": "What is the approximate composition of the universe?",
      "options": ["100% ordinary matter (atoms, stars, galaxies)", "68% dark energy, 27% dark matter, 5% ordinary matter", "50% matter, 50% dark energy", "95% ordinary matter, 5% unknown"],
      "correctAnswer": 1,
      "explanation": "The universe is ~68% dark energy (causing accelerated expansion), ~27% dark matter (invisible mass holding galaxies together), and only ~5% ordinary matter (protons, neutrons, electrons—everything we observe). 95% of the universe is dark and mysterious!"
    },
    {
      "question": "What was the key evidence for dark matter from galaxy rotation curves?",
      "options": ["Stars orbiting too slowly at galaxy edges", "Stars orbiting too fast—visible mass insufficient to hold them", "Galaxies are expanding", "Dark matter blocks light from stars"],
      "correctAnswer": 1,
      "explanation": "Vera Rubin (1970s) measured that stars at the edges of spiral galaxies orbit TOO FAST for the visible mass alone. According to Kepler''s laws, outer stars should fly off! This indicates 5-10× more mass than we see—dark matter halo surrounding galaxies."
    },
    {
      "question": "What is the main evidence for dark energy (1998 Nobel Prize)?",
      "options": ["Galaxy rotation curves", "Distant supernovae are FAINTER than expected (expansion accelerating)", "CMB fluctuations", "Gravitational waves"],
      "correctAnswer": 1,
      "explanation": "Perlmutter, Schmidt, and Riess (1998) measured Type Ia supernovae and found they were 20-30% FAINTER than expected in a decelerating universe. This meant expansion is ACCELERATING due to dark energy—the most shocking cosmological discovery since Hubble''s law!"
    },
    {
      "question": "What distinguishes dark energy from ordinary or dark matter?",
      "options": ["Dark energy has positive pressure", "Dark energy has w = p/ρ ≈ -1 (negative pressure)", "Dark energy repels gravity", "All of the above"],
      "correctAnswer": 3,
      "explanation": "Dark energy has w = -1, meaning its pressure is NEGATIVE (p = -ρc²). This is unlike any known form of matter or radiation (which all have positive pressure). Negative pressure causes repulsive gravity—accelerating the universe''s expansion!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: ATOMIC AND NUCLEAR PHYSICS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'advanced-physics' LIMIT 1),
  'Atomic and Nuclear Structure',
  'atomic-nuclear-structure',
  'Study of atomic nuclei, radioactivity, fission, fusion, and applications.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'atomic-nuclear-structure' LIMIT 1),
  'Nuclear Structure and Binding Energy',
  'nuclear-structure-binding-energy',
  1,
  '# Nuclear Structure and Binding Energy

## What Is Nuclear Structure?

**Atomic nuclei** are bound states of protons and neutrons (**nucleons**) held together by the **strong nuclear force**.

### Liquid Drop Model

Nuclei behave like **liquid droplets**:

- **Volume energy**: Nucleons attract each other
- **Surface energy**: Surface nucleons have fewer neighbors (less binding)
- **Coulomb energy**: Protons repel each other
- **Asymmetry energy**: Prefers N ≈ Z
- **Pairing energy**: Nucleons pair up (proton-proton, neutron-neutron)

**Semi-empirical mass formula** (von Weizsäcker, 1935):

$$m(A, Z) = Zm_p + (A-Z)m_n - a_vA + a_sA^{2/3} + \delta(A, Z)$$

Where:
- $A$ = mass number ($Z + N$)
- $Z$ = atomic number (protons)
- $a_v = 15.8$ MeV (volume term)
- $a_s = 18.3$ MeV (surface term)
- $\delta$ = pairing term ($\pm 11.2/\sqrt{A}$ MeV for even/odd)

**Binding energy**:
$$BE = Zm_p + (A-Z)m_n - m_{nuclear}$$

Or using von Weizsäcker:
$$BE = a_vA - a_sA^{2/3} + a_c\frac{Z(Z-1)}{A^{1/3}} + \delta(A, Z)$$

### Shell Model

Nucleons fill **energy shells** (like electron shells):

**Magic numbers**: 2, 8, 20, 28, 50, 82, 126

Nuclei with magic proton OR neutron numbers are especially stable!

```
        Shell closures
         (more stable):
      2  |     8    |   20    |  28
    ●○ |   ●○○○○ | ●○○○○○○○○○○○○ | ●○○○○○○○○○○○○○○●●●●
```

**Examples**:
- Helium-4 ($^4$He): Magic Z = 2, N = 2
- Calcium-40 ($^{40}$Ca): Magic Z = 20
- Lead-208 ($^{208}$Pb): Magic Z = 82, N = 126 (doubly magic!)

## Radioactive Decay

### Alpha Decay

Emits **helium-4 nucleus** ($^4$He):

$$^A_Z X \rightarrow ^{A-4}_{Z-2} Y + ^4_2He$$

**Mechanism**: Tunneling through Coulomb barrier

**Gamow factor** (tunneling probability):
$$T \approx e^{-2G(Z-2)z/R/\hbar v}$$

**Geiger-Nuttall law** (empirical):

$$\log_{10} t_{1/2} = aZ + b$$

Where $t_{1/2}$ = half-life, and $a, b$ depend on element.

### Beta Decay

**Beta-minus** ($n \rightarrow p + e^- + \bar{\nu}_e$):

$$^A_Z X \rightarrow ^{A}_{Z+1} Y + e^- + \bar{\nu}_e$$

**Weak interaction**: $d \rightarrow u + W^-$

**Q-value** (energy released):
$$Q = [m(^A_Z X) - m(^{A}_{Z+1} Y) - m_e]c^2$$

**Beta-plus** ($p \rightarrow n + e^+ + \nu_e$):

$$^A_Z X \rightarrow ^{A}_{Z-1} Y + e^+ + \nu_e$$

Requires energy (rare for neutron-rich nuclei)!

### Gamma Decay

Excited nucleus decays to lower energy state by emitting **gamma photon**:

$$^A_Z X^* \rightarrow ^A_Z X + \gamma$$

**Typical energies**: 0.1 - 10 MeV

**Isomeric states**: Same $A$ and $Z$ but different arrangements → different decay patterns

## Nuclear Fission

**Heavy nucleus splits** into lighter fragments:

$$^ {235}_92U + n \rightarrow ^{236}_{92}U^* \rightarrow ^{141}_{56}Ba + ^{92}_{36}Kr + 3n$$

**Energy release**: ~200 MeV per fission

**Binding energy per nucleon**:
- $^{235}$U: 7.6 MeV/nucleon
- Fission products: 8.5 MeV/nucleon
- **Difference**: 0.9 MeV × 235 ≈ 200 MeV released

### Chain Reactions

```
    Neutron
      ↓
   U-235    Ba-141    Kr-92
     ════╦   →  →  →   +   2-3n
     ║   ╲    ╱   ╲     ↘   (can
    ║    ╲  ╱     ╲       trigger
    ║     ╲╱        ╲    more
    ║      →→→→       ╲  fission)
    ║        ╲           ╱    ↙
    ╚═══╩═════════════╧═╗
                ║ 2-3n
                ║ (slow/
  (controlled)     fast neutrons)
```

**Critical mass**: Minimum fissile material for sustained chain reaction

- U-235: 52 kg (bare sphere)
- Pu-239: ~10 kg

**Moderators**: Slow neutrons to thermal energies (water, graphite)

**Control rods**: Absorb neutrons (boron, cadmium)

## Nuclear Fusion

**Light nuclei combine** to form heavier ones:

### Proton-Proton Chain (pp chain)

Dominates in Sun and low-mass stars:

$$^1_1H + ^1_1H \rightarrow ^2_1H + e^+ + \nu_e$$
$$^2_1H + ^1_1H \rightarrow ^3_2He + \gamma$$

**Net effect** (4p → He-4):
$$4^1_1H \rightarrow ^4_2He + 2e^+ + 2\nu_e + 26.7 \text{ MeV}$$

### CNO Cycle

In hotter stars (T > 15 million K):

$$^ {12}_6C + ^1_1H \rightarrow ^ {13}_7N + \gamma$$
...series of reactions...
$$^ {15}_8O + ^1_1H \rightarrow ^ {12}_6C + ^4_2He$$

### Triple-Alpha Process

In even hotter stars (T > 100 million K):

$$^4_2He + ^4_2He + ^4_2He \rightarrow ^ {12}_6C + \gamma$$

**Burning helium** to carbon!

## Applications

### Nuclear Reactors

**Pressurized water reactors (PWR)**:

```
    Fuel rods      Control rods
       ↓              ↓
   (U-235)         (B, Cd)
     ════╗         ════╦
     ║   ╲          ║  │
     ║    ╲    moderator     ║
     ║     ╲ (water)      ║
     ║      ╲                ║
     ╚═══════╧═══════════════╝
            Hot water → Steam → Turbine → Electricity
```

**Efficiency**: ~33% (Carnot limit + practical losses)

### Nuclear Weapons

**Fission bomb**:
- Compressed subcritical masses → conventional explosives → rapid assembly → **supercritical** → 20 kilotons TNT equivalent

**Fusion bomb** (thermonuclear):
- Fission trigger → X-rays heat T/D → fusion compressed → **50 megatons**

### Medical Isotopes

| Isotope | Half-life | Use |
|----------|---------|-----|
| Tc-99m | 6 hours | SPECT imaging (heart perfusion) |
| F-18 | 110 minutes | PET scans (brain metabolism) |
| I-131 | 8 days | Thyroid diagnosis/treatment |
| Co-60 | 5.3 years | Radiotherapy source |

## Key Equations

| Equation | Quantity |
|----------|----------|
| $BE = [Zm_p + (A-Z)m_n]c^2 - m_{nuc}c^2$ | Binding energy |
| $m(A,Z) = Zm_p + (A-Z)m_n - a_vA + ...$ | von Weizsäcker formula |
| $Q = [m_{initial} - \sum m_{final}]c^2$ | Decay Q-value |
| $\log t_{1/2} = aZ + b$ | Geiger-Nuttall law |

## Sources
- Krane, K. (1987). "Introductory Nuclear Physics"
- Lamarsh, J.R., Baratta, A.J. (2001). "Introduction to Nuclear Engineering"
- Fermi, E. (1934). "Attempt at a Theory of Beta Decay"
- von Weizsäcker, C. (1935). "Mass Formulae for Nuclei"
- Cottingham, W.N., et al. (2016). "Nuclear Physics"
',

  '[
    {
      "question": "What is the semi-empirical mass formula (von Weizsäcker) used for?",
      "options": ["Calculating electron binding energies", "Estimating nuclear masses based on volume, surface, Coulomb, asymmetry, and pairing terms", "Predicting radioactive decay products", "Calculating atomic radii"],
      "correctAnswer": 1,
      "explanation": "The von Weizsäcker formula estimates nuclear masses by treating nuclei like liquid drops: volume term (attractive force), surface term (fewer neighbors at surface), Coulomb term (proton repulsion), asymmetry term (N≈Z preference), and pairing term (nucleon pairs). It accurately predicts binding energies!"
    },
    {
      "question": "What is the binding energy per nucleon for uranium-235?",
      "options": ["~2 MeV (unstable)", "~7.6 MeV (moderately stable)", "~12 MeV (very stable)", "~20 MeV (iron-56 peak)"],
      "correctAnswer": 1,
      "explanation": "U-235 has BE ≈ 7.6 MeV/nucleon. This is positive but much lower than iron-56 (~8.8 MeV/nucleon, the peak). Lower binding energy means U-235 can release energy via fission, splitting into medium-mass nuclei with higher binding energy per nucleon."
    },
    {
      "question": "What is the net result of the proton-proton chain (pp chain) that powers the Sun?",
      "options": ["4 hydrogen nuclei fuse to form helium-3, releasing energy", "4 protons form a helium-4 nucleus and 2 neutrons, releasing energy", "Hydrogen fuses into uranium, releasing energy", "Hydrogen converts to carbon and oxygen"],
      "correctAnswer": 1,
      "explanation": "The pp chain''s net effect: 4¹H → ⁴He + 2e⁺ + 2νₑ + 26.7 MeV. Four protons form a helium-4 nucleus, releasing 26.7 MeV of energy (plus neutrinos and positrons that carry away some energy). This is the primary power source for the Sun and low-mass stars!"
    },
    {
      "question": "What is the Q-value in nuclear reactions?",
      "options": ["The total kinetic energy of incoming particles", "The difference between initial and final nuclear masses × c² (energy released)", "The quantum number of the reaction", "The temperature needed for the reaction"],
      "correctAnswer": 1,
      "explanation": "Q-value = [m_initial - Σm_final]c². It''s the energy released from the difference in nuclear binding energy between initial and final nuclei. For fission of U-235, Q ≈ 200 MeV—enormous energy per nucleus! Positive Q → exothermic (releases energy)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'atomic-nuclear-structure' LIMIT 1),
  'Medical and Industrial Applications of Nuclear Physics',
  'medical-industrial-nuclear',
  2,
  '# Medical and Industrial Applications of Nuclear Physics

## Medical Imaging and Therapy

### Radiography

**X-ray imaging**: High-energy photons penetrate tissue to varying degrees:

```
    X-ray source          Patient
         ↓                 ↓
    (─)    →→→→→→     ╔═══╦═══╗
   bremsstrahlung     bones      ║ image  ║
   from metal                   ║ forms  ║
   target         (film or    ╚═══╩═══╝
                digital detector)
```

**Contrast**: Bone absorbs more X-rays than soft tissue

**CT scans** (Computed Tomography): Rotate X-ray tube → 3D reconstruction

### Nuclear Medicine (SPECT and PET)

**SPECT** (Single Photon Emission Computed Tomography):

Inject **radioactive tracer** (e.g., Tc-99m):

```
Injected into bloodstream
         ↓
    (Tc-99m) → accumulates in organs
         ↓
    Gamma camera
         ↓
    (detects 140 keV photons)
         ↓
    Reconstruction → 3D image
```

**Tracer uses**:
- **Brain perfusion**: Blood flow studies
- **Bone scans**: Metastasis detection
- **Cardiac**: Function imaging

**PET** (Positron Emission Tomography):

Inject **positron-emitting** isotope (e.g., F-18, C-11):

$$^{18}_9F \rightarrow ^{18}_8O + e^+ + \nu_e$$

$$e^+ + e^- \rightarrow 2\gamma (511 \text{ keV})$$

**Coincidence detection** identifies annihilation event!

```
   Ring of detectors
      ↖    ↗    ↘
      ╱  ╲  ╱  ╲
     ╱    ╲╱    ╲╱
    ╱      ↙     ╲  ↙
 (patient in center)
```

**Applications**:
- **Oncology**: Tumor detection (FDG tracer)
- **Neurology**: Brain metabolism, Alzheimer''s
- **Cardiology**: Heart function

### Radiation Therapy

**Teletherapy** (external beam):

```
Linear accelerator
         ↓
    (6-20 MV
      photons/e⁻)
         ↓
   (shaped beam)
         ↓
    ════════╗
    ║Tumor  ║
    ║ (dose  ║
    ║  given)  ║
    ╚═══════╝
         ↓
   (rotate gantry)
```

**IMRT** (Intensity Modulated):
- **MLC** (Multi-Leaf Collimator): Shapes beam to tumor
- **Dose painting**: Deliver uniform dose to irregular volumes

**Brachytherapy** (internal):

```
    Ir-192 or Cs-137
    (high activity)
         ↓
    ════╦═══╗
    ║   sealed  ║
    ║  source  ║   →→ Placed near tumor
    ║           ║      (direct dose,
    ╚═══╩═══╝        minimal to healthy tissue)
```

**Isotopes**: Ir-192 (half-life 74 days), Cs-137 (30 years)

## Industrial Applications

### NDT (Non-Destructive Testing)

**Radiography**:

```
    Gamma source      Test object
         ↓                ↓
    (Ir-192)    (metal pipe)
         ↓            with welds
    (radiation)      or defects
         ↓                ↓
    [Film or detector]
         ↓
    Image shows defects
```

**Thickness gauging**: Measure absorption → determine material thickness

**Applications**:
- Weld inspection (pipeline, aircraft)
- Casting porosity detection
- Corrosion mapping

### Tracer Studies

**Leak detection** in pipes:
Inject radioactive fluid → detect leaks with external detector

**Flow measurement**: Track tracer movement → measure flow rates

### Food Irradiation

**Purpose**: Sterilize without heat (preserves nutrition)

**Sources**:
- Co-60 gamma rays
- Electron beams (E-beam)

**Benefits**:
- Extended shelf life
- Kill pathogens (E. coli, Salmonella)
- No residue (unlike chemical pesticides)

**Safety**: Food remains **not radioactive**—irradiation doesn''t induce radioactivity!

## Nuclear Power Generation

### Pressurized Water Reactor (PWR)

```
            Steam
             ↑
    ══════╦═════╗
    ║ Turbine  ║
    ║  ══════╦  ║
    ║        ║  ║
    ║Primary  ║ ║
    ║ coolant  ║ ║
    ║ (hot)   ║ ║
    ║    ══════╩ ║
    ╚═════════════╧══╝
    Core
 (fuel assemblies,
  moderator,
  control rods)
```

**Efficiency breakdown**:
- Thermal efficiency: 33%
- Electrical efficiency: 30%
- **Overall**: ~30%

**Safety systems**:
- **Control rods**: Absorb neutrons (emergency shutdown)
- **Moderator**: Slows neutrons to thermal energies
- **Coolant**: Removes heat (water, liquid sodium, gas)
- **Containment**: Prevents radiation release

### Breeder Reactors

**Generate more fuel** than they consume:

$$^{238}_{92}U + n \rightarrow ^{239}_{92}U + 2n$$

Then $^{239}$U + $n \rightarrow ^{239}_{93}Np + 2n$ (beta decay)

**Net**: Convert non-fissile U-238 to fissile Pu-239!

**Challenges**:
- **Sodium coolant**: Highly reactive (leaks!)
- **Fuel reprocessing**: Separates plutonium (complex, proliferation risk)

## Fusion Power

### Tokamak Design

**Magnetic confinement** of toroidal plasma:

```
        Top view
            ╔═══════╦═════╗
    Toroidal    ║  Plasma ║  Toroidal
    field coils  ║ (100M°C) ║ field coils
    (B_external) ║          ║  (B_toroidal)
                ╚═══════╩═════╝
```

**Challenges**:
- **Plasma instabilities**: Kink modes, disruptions
- **Heat management**: Divertor handles exhaust heat
- **Neutron flux**: First wall damage

### Inertial Confinement

**NIF** (National Ignition Facility):

```
      Lasers (192 beams)
            ↓
         (→→→→→→)
            Target
        ════╦═══╗
        ║ D-T   ║
        ║ pellet  ║   →→ Fusion
        ║ (2mm)  ║      (imploding)
        ╚═══╩═══╝
             ↓
        Neutrons
        (blanket absorbs)
```

**Achievement**: Ignition (2022)! But net energy gain still elusive.

## Radiation Protection

### ALARA Principle

**A**s **L**ow **A**s **R**easonably **A**chievable:

Minimize radiation dose:
- Time: Minimize exposure duration
- Distance: Maximize distance from source
- Shielding: Use appropriate barriers

### Shielding Materials

| Material | Use | Half-value layer |
|----------|-----|----------------|
| Lead | High Z, X-ray/gamma shielding | 1 mm for 100 keV |
| Concrete | Structural + shielding | ~2 cm for 100 keV |
| Tungsten | High melting point | Spacecraft shielding |
| Water | Hydrogen content good for neutrons | ~20 cm thermal neutrons |

## Key Equations

| Equation | Quantity |
|----------|----------|
| $D = \Gamma \cdot t$ | Absorbed dose (Gray) |
| $H = 10 \text{ mSv}^{-1}$ | Dose equivalent |
| $\lambda_{phys} = \ln 2 / \Sigma$ | Half-value layer |
| $BE/A \approx 8.5 \text{ MeV}$ | Peak binding (Fe-56) |

## Sources
- Herman, C. (2009). "Health Physics and Radiation Protection"
- Chandra, R. et al. (2010). "Nuclear Medicine"
- IAEA: "Nuclear Power Plant Design"
- WNA: "World Nuclear Association"
- LLE, review (2010). "Applications of Fusion Research"
',

  '[
    {
      "question": "What is the main difference between SPECT and PET imaging?",
      "options": ["SPECT detects positrons, PET detects single gamma photons", "SPECT uses single gamma detection; PET detects coincident 511 keV photons from positron-electron annihilation", "SPECT is for anatomy, PET is for therapy", "SPECT uses CT scans, PET uses MRI"],
      "correctAnswer": 1,
      "explanation": "SPECT (Single Photon Emission CT) detects single gamma photons from radiotracers like Tc-99m. PET detects the TWO 511 keV photons from positron-electron annihilation (e⁺ + e⁻ → 2γ). Coincidence detection gives PET better spatial resolution (~4 mm vs. ~10 mm)!"
    },
    {
      "question": "What is ALARA in radiation protection?",
      "options": ["A Legal Radiation Allowance regulation", "A Low As Reasonably Achievable—keep dose As Low As Reasonably Achievable", "Always Use Radioactive Assays", "Avoid Long Radiation Areas"],
      "correctAnswer": 1,
      "explanation": "ALARA (As Low As Reasonably Achievable) is the principle of minimizing radiation exposure by reducing TIME (shorter procedures), increasing DISTANCE (from sources), and using SHIELDING. It''s not a regulatory limit but a best practice for all radiation work!"
    },
    {
      "question": "What is the main advantage of a breeder reactor over a conventional nuclear reactor?",
      "options": ["Breeder reactors generate electricity more efficiently", "Breeders produce more fissile fuel (Pu-239) than they consume (converting U-238)", "Breeders use cheaper fuel", "Breeders don''t require control rods"],
      "correctAnswer": 1,
      "explanation": "Breeder reactors convert non-fissile U-238 to fissile Pu-239, producing MORE fuel than they consume (breeding ratio >1). This extends uranium resources from ~100 years to thousands of years. However, reprocessing is complex and raises proliferation concerns (Pu-239 is weapons-usable)."
    },
    {
      "question": "What is the main challenge in achieving net energy gain from fusion?",
      "options": ["Creating high enough temperatures", "Confining and compressing fuel long enough for fusion while getting more energy out than laser heating puts in", "Producing enough neutrons", "Finding light enough elements for fusion"],
      "correctAnswer": 1,
      "explanation": "The main challenge is achieving NET ENERGY GAIN (Q>1). The fuel must be confined long enough and compressed enough for significant fusion, while the energy output exceeds the laser/heating input. NIF achieved ignition (2022) but net gain requires even better confinement and compression!"
    }
  ]',
  NOW()
);
