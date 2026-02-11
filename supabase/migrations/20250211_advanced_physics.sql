-- =====================================================
-- ADVANCED PHYSICS COURSE
-- Topics: Special Relativity, General Relativity, Quantum Mechanics, Particle Physics
-- Difficulty: Advanced
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Advanced Physics
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Advanced Physics',
  'advanced-physics',
  'Explore the frontiers of physics: Einstein''s relativity, quantum mechanics, particle physics, and cosmology. For students ready for the most challenging concepts.',
  'physics',
  'advanced',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: SPECIAL RELATIVITY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'advanced-physics' LIMIT 1),
  'Special Relativity',
  'special-relativity',
  'Understand Einstein''s revolutionary theory: time dilation, length contraction, and E=mc².',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'The Michelson-Morley Experiment and Postulates',
  'michelson-morley-postulates',
  1,
  '# The Michelson-Morley Experiment and Postulates of Special Relativity

## The Problem: Light and the Ether

Before Einstein, physicists believed light waves needed a medium to travel through, just as sound waves need air. They called this hypothetical medium the **luminiferous ether**.

### The Michelson-Morley Experiment (1887)

Albert Michelson and Edward Morley tried to detect Earth''s motion through the ether by measuring the speed of light in different directions.

```
       Light source
           |
           v
       ┌─────┐
       │  BS │───> Mirror 1 (parallel to Earth motion)
       └─────┘
           |
           v
       Mirror 2 (perpendicular to Earth motion)
```

**What they expected:**
- Light speed should be **different** in different directions
- Earth moving through ether should create an "ether wind"

**What they found:**
- **NO difference** in light speed!
- Light speed was **constant** in all directions
- This was called the **"null result"**

This shocked the physics community! The ether didn''t seem to exist.

## Einstein''s Two Postulates (1905)

Albert Einstein resolved this crisis with **special relativity**, based on two postulates:

### Postulate 1: The Principle of Relativity

**The laws of physics are the same in all inertial reference frames.**

An **inertial reference frame** is one moving at constant velocity (not accelerating).

This means:
- No experiment can distinguish between "at rest" and "moving at constant velocity"
- There''s no absolute rest frame
- You can''t tell you''re moving in a smoothly train without looking outside

### Postulate 2: The Constancy of the Speed of Light

**The speed of light in vacuum (c) is the same for all observers, regardless of their motion or the motion of the light source.**

Key points:
- $c = 3.00 \times 10^8 \text{ m/s}$ (exactly)
- This speed is the **same** for all observers
- Light from a moving lamp still travels at speed $c$
- This contradicts our everyday intuition about adding velocities

## Why These Postulates Are Revolutionary

### Everyday Velocity Addition
```
Car A: 50 mph →
Car B: 50 mph →
Relative speed: 100 - 50 = 50 mph ✓
```

### Light Speed Doesn''t Add This Way!
```
Spaceship A: 0.5c →
Light beam: c →
Relative speed: c (NOT 1.5c!)
```

The speed of light is **invariant** (same for everyone)!

## Examples

### Example 1: Light from a Moving Source

You''re in a spaceship moving at $0.5c$ (half light speed) and shine a laser forward.

**Classical intuition** (WRONG): Light speed = $c + 0.5c = 1.5c$

**Special relativity** (CORRECT): Light speed = $c$ (still!)

An observer on Earth also measures the laser light moving at speed $c$, not $1.5c$!

### Example 2: Simultaneity Is Relative

Two events that are simultaneous for one observer are **not simultaneous** for another moving observer!

```
Train moving right →
      ⚡          ⚡
     Lightning   Lightning
     strikes     strikes
     Front and   at same time
     back of     (for ground observer)
     train car
```

For someone on the train, the front lightning strike happens **before** the back strike!

This is because the **speed of light** is constant, but the observers are moving relative to each other.

## Consequences of These Postulates

From these two simple postulates, Einstein derived:

1. **Time dilation**: Moving clocks run slow
2. **Length contraction**: Moving objects shorten in the direction of motion
3. **Relativity of simultaneity**: Simultaneous events for one observer aren''t simultaneous for another
4. **Mass-energy equivalence**: $E = mc^2$

These aren''t just theoretical effects—they''re measured every day in particle accelerators, GPS satellites, and atomic clocks!

## Key Formulas

### Time Dilation
$$\Delta t = \gamma \Delta t_0$$

Where:
- $\Delta t$ = time interval measured by stationary observer
- $\Delta t_0$ = **proper time** (time measured in clock''s rest frame)
- $\gamma$ = Lorentz factor = $\frac{1}{\sqrt{1-v^2/c^2}}$

### Length Contraction
$$L = \frac{L_0}{\gamma}$$

Where:
- $L$ = contracted length measured by stationary observer
- $L_0$ = **proper length** (length measured in object''s rest frame)
- $\gamma$ = Lorentz factor

### Lorentz Factor
$$\gamma = \frac{1}{\sqrt{1-\frac{v^2}{c^2}}}$$

Where:
- $v$ = relative velocity
- $c$ = speed of light

## Real-World Applications

### GPS Satellites

GPS satellites move at 14,000 km/h (0.000014c) and experience both:
- **Special relativity time dilation**: Moving clocks run slow by 7 μs/day
- **General relativity gravitational time dilation**: Clocks in weaker gravity run fast by 45 μs/day

**Net effect**: 38 μs/day faster! Without relativistic corrections, GPS would accumulate errors of 10 km per day!

### Particle Accelerators

At the Large Hadron Collider (LHC), protons move at $0.999999991c$:
- $\gamma \approx 7,500$
- Time is slowed by factor of 7,500 from our perspective
- The protons'' lifetime is extended 7,500× from our frame

## Sources
- Einstein, A. (1905). "On the Electrodynamics of Moving Bodies" (original paper)
- Khan Academy: "Special relativity" lessons
- OpenStax College Physics 2e, Chapter 28: Special Relativity
- MIT OpenCourseWare: 8.20 Special Relativity
- NIST: "Time and Frequency from A to Z" (GPS clock corrections)
',

  '[
    {
      "question": "What was the purpose of the Michelson-Morley experiment?",
      "options": ["To measure the exact speed of light", "To detect Earth''s motion through the luminiferous ether", "To test Newton''s laws of motion", "To demonstrate the wave-particle duality of light"],
      "correctAnswer": 1,
      "explanation": "The Michelson-Morley experiment was designed to detect Earth''s motion through the hypothetical luminiferous ether by measuring differences in light speed in different directions. The null result (no difference found) led to special relativity."
    },
    {
      "question": "What is Einstein''s first postulate of special relativity?",
      "options": ["Light speed is constant for all observers", "The laws of physics are the same in all inertial reference frames", "Moving clocks run slower than stationary clocks", "Energy and mass are equivalent (E=mc²)"],
      "correctAnswer": 1,
      "explanation": "Einstein''s first postulate is the principle of relativity: the laws of physics are the same in all inertial reference frames (frames moving at constant velocity). This means no experiment can detect absolute motion."
    },
    {
      "question": "If a spaceship moves at 0.5c and shines a laser forward, what speed does an Earth observer measure for the laser light?",
      "options": ["0.5c", "1.0c", "1.5c", "2.0c"],
      "correctAnswer": 1,
      "explanation": "According to Einstein''s second postulate, the speed of light in vacuum is c for ALL observers, regardless of the motion of the source. An Earth observer measures the laser light moving at c (1.0c), NOT 1.5c (0.5c + c)."
    },
    {
      "question": "What is the Lorentz factor (γ) for an object moving at v = 0.8c?",
      "options": ["1.00", "1.25", "1.67", "2.00"],
      "correctAnswer": 2,
      "explanation": "γ = 1/√(1-v²/c²) = 1/√(1-0.8²) = 1/√(1-0.64) = 1/√(0.36) = 1/0.6 = 1.67. The Lorentz factor tells us how much time dilates and length contracts at that speed."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'Time Dilation',
  'time-dilation',
  2,
  '# Time Dilation: Moving Clocks Run Slow

## What Is Time Dilation?

**Time dilation** is the phenomenon where a moving clock ticks slower than a stationary clock, according to special relativity.

$$\Delta t = \gamma \Delta t_0$$

Where:
- $\Delta t$ = time interval measured by **stationary observer** (dilated time)
- $\Delta t_0$ = **proper time** (time measured in the clock''s rest frame)
- $\gamma$ = Lorentz factor = $\frac{1}{\sqrt{1-v^2/c^2}}$

### Proper Time

**Proper time** ($\Delta t_0$ or $\tau$) is the time interval measured by a clock **at rest relative to the event**.

- Only the clock''s rest frame measures proper time
- All other (moving) observers measure a LONGER time interval
- Proper time is always the **shortest** possible time interval

## Understanding Time Dilation

### Thought Experiment: The Light Clock

Imagine a clock that ticks when light bounces between two mirrors separated by distance $d$.

**Stationary clock** (in rest frame):
```
Mirror (top)
    ↑
    │ Light
    │ travels
    │ distance d
    ↓
Mirror (bottom)
```

Time for one tick: $\Delta t_0 = \frac{2d}{c}$

**Moving clock** (moving right at velocity $v$):
```
       Mirror (top)
          ↗
         ╱ Light travels
        ╱  diagonal path
       ╱   (longer!)
      ↙
   Mirror (bottom)
    → moves right at speed v
```

The light must travel a **diagonal (longer) path**, but still at speed $c$!

Time for one tick: $\Delta t = \frac{2d}{c\sqrt{1-v^2/c^2}} = \gamma \Delta t_0$

Since $\gamma > 1$ for any $v > 0$, the moving clock ticks **slower**!

### The Twin Paradox

One twin stays on Earth, the other travels at $0.8c$ to a star 8 light-years away and back.

**Earth twin''s perspective:**
- Travel time (one way): 8 ly / 0.8c = 10 years
- Round trip: 20 years
- Traveling twin''s clock ticks slower by factor γ = 1/√(1-0.8²) = 1.67
- Traveling twin ages: 20 / 1.67 = 12 years

**Result**: Earth twin is 20 years older, but traveling twin is only 12 years older!

Wait—isn''t this a paradox? From the traveling twin''s perspective, shouldn''t Earth move away and back, making Earth twin younger?

**Resolution**: The traveling twin **accelerates** (turning around), breaking the symmetry. Special relativity only applies to inertial (non-accelerating) frames!

## Examples

### Example 1: Muon Lifetime

**Muons** are subatomic particles created in the upper atmosphere by cosmic rays.

- Proper lifetime (at rest): $\Delta t_0 = 2.2 \mu s$
- Muon speed: $v = 0.998c$
- Lorentz factor: $\gamma = \frac{1}{\sqrt{1-0.998^2}} \approx 15.8$

**Classical prediction** (ignoring time dilation):
- Distance traveled: $d = v \Delta t_0 = (0.998 \times 3 \times 10^8)(2.2 \times 10^{-6}) \approx 660 \text{ m}$
- Muons created at 10 km altitude should decay before reaching ground

**With time dilation**:
- Dilated lifetime: $\Delta t = \gamma \Delta t_0 = 15.8 \times 2.2 \mu s = 34.8 \mu s$
- Distance traveled: $d = v \Delta t = (0.998 \times 3 \times 10^8)(34.8 \times 10^{-6}) \approx 10.4 \text{ km}$ ✓

**This is observed!** Muons reach Earth''s surface because time dilation extends their lifetime from our reference frame.

### Example 2: GPS Satellite Clocks

GPS satellites orbit at $v = 3.87 \text{ km/s} = 1.29 \times 10^{-5}c$.

Lorentz factor: $\gamma = \frac{1}{\sqrt{1-(1.29 \times 10^{-5})^2}} \approx 1 + 8.35 \times 10^{-11}$

Time dilation per day:
$$\Delta t - \Delta t_0 = (\gamma - 1)\Delta t_0 \approx (8.35 \times 10^{-11})(86,400 \text{ s}) \approx 7.2 \mu s$$

Satellite clocks run **7.2 microseconds slower per day** due to special relativity!

(Combined with general relativity''s +45 μs effect, net +38 μs/day faster, requiring continuous correction.)

### Example 3: Interstellar Travel

A spaceship travels to a star 100 light-years away at $v = 0.99c$.

**From Earth''s frame:**
- Travel time: $\Delta t = \frac{100 \text{ ly}}{0.99c} = 101 \text{ years}$

**From spaceship''s frame:**
- $\gamma = \frac{1}{\sqrt{1-0.99^2}} = 7.09$
- Proper time (traveler ages): $\Delta t_0 = \frac{\Delta t}{\gamma} = \frac{101}{7.09} = 14.2 \text{ years}$

The traveler arrives 14.2 years older, but 101 years have passed on Earth!

## When Is Time Dilation Significant?

| Speed (v) | Lorentz factor (γ) | Effect |
|-----------|-------------------|--------|
| 0.01c (3,000 km/s) | 1.00005 | Negligible |
| 0.1c (30,000 km/s) | 1.005 | Small |
| 0.5c | 1.15 | Noticeable |
| 0.866c | 2.0 | Significant |
| 0.99c | 7.1 | Large |
| 0.999c | 22.4 | Extreme |
| 0.999999991c (LHC) | 7,500 | Extreme |

Time dilation only becomes significant at **relativistic speeds** (comparable to c).

## Key Concepts

1. **Moving clocks run slow**: Time intervals are longer in frames where the clock is moving
2. **Proper time is shortest**: The rest frame of the clock measures the shortest time interval
3. **Reciprocal effect**: From the clock''s perspective, the other observer''s clock is slow (symmetry broken by acceleration)
4. **Not just clocks**: Time ITSELF slows down—biological processes, particle decay, everything

## Common Misconceptions

**Misconception**: "Time dilation is just a clock effect."

**Reality**: Time itself slows down. If you traveled at relativistic speeds, you would **age slower** from Earth''s perspective.

**Misconception**: "The traveler thinks Earth clocks are fast."

**Reality**: From the traveler''s perspective, Earth clocks are also slow (reciprocal). The asymmetry comes from acceleration (turning around).

## Sources
- Khan Academy: "Time dilation"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- HyperPhysics: "Time Dilation" (Georgia State University)
- NIST: "Time and Frequency from A to Z"
- LHC CERN Documentation
',

  '[
    {
      "question": "What happens to a moving clock according to special relativity?",
      "options": ["It runs faster than a stationary clock", "It runs slower than a stationary clock", "It runs at the same rate as a stationary clock", "It stops completely"],
      "correctAnswer": 1,
      "explanation": "Moving clocks run SLOWER than stationary clocks according to time dilation (Δt = γΔt₀, where γ > 1). This is not a mechanical effect—time itself passes slower for the moving observer from the stationary observer''s perspective."
    },
    {
      "question": "What is proper time (Δt₀)?",
      "options": ["Time measured by a stationary observer", "Time measured in the clock''s rest frame (always shortest)", "Time measured by a moving observer", "The average of all time measurements"],
      "correctAnswer": 1,
      "explanation": "Proper time (Δt₀) is the time interval measured by a clock AT REST relative to the event being timed. It is always the SHORTEST possible time interval—all moving observers measure longer (dilated) time intervals."
    },
    {
      "question": "A spaceship travels at 0.866c to a star 173.2 light-years away. How long does the trip take for the travelers on the spaceship?",
      "options": ["100 years", "173.2 years", "200 years", "866 years"],
      "correctAnswer": 0,
      "explanation": "From Earth''s frame: t = 173.2 ly / 0.866c = 200 years. Lorentz factor: γ = 1/√(1-0.866²) = 2.0. Traveler''s proper time: t₀ = t/γ = 200/2 = 100 years. The travelers only age 100 years, but 200 years pass on Earth!"
    },
    {
      "question": "Muons at rest have a lifetime of 2.2 μs. When they travel at 0.998c, their observed lifetime on Earth is approximately:",
      "options": ["2.2 μs", "4.4 μs", "15 μs", "35 μs"],
      "correctAnswer": 3,
      "explanation": "Lorentz factor at v = 0.998c: γ = 1/√(1-0.998²) ≈ 15.8. Dilated lifetime: t = γt₀ = 15.8 × 2.2 μs = 34.8 μs ≈ 35 μs. This explains why muons created 10 km up reach Earth''s surface!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'Length Contraction',
  'length-contraction',
  3,
  '# Length Contraction: Moving Objects Shorten

## What Is Length Contraction?

**Length contraction** (also called **Lorentz contraction**) is the phenomenon where a moving object appears shorter in the direction of motion, according to a stationary observer.

$$L = \frac{L_0}{\gamma}$$

Where:
- $L$ = contracted length measured by stationary observer
- $L_0$ = **proper length** (length measured in object''s rest frame)
- $\gamma$ = Lorentz factor = $\frac{1}{\sqrt{1-v^2/c^2}}$

### Proper Length

**Proper length** ($L_0$) is the length measured by an observer **at rest relative to the object**.

- Only the object''s rest frame measures proper length
- All other (moving) observers measure a SHORTER length
- Proper length is always the **longest** possible length
- **Only lengths in the direction of motion contract** (perpendicular lengths are unchanged)

## Understanding Length Contraction

### Visualizing Contraction

A spaceship of proper length $L_0 = 100 \text{ m}$ moves at $v = 0.866c$ (where $\gamma = 2$).

**In spaceship''s rest frame:**
```
[========== 100 m ==========]
   Proper length: L₀ = 100 m
```

**From Earth''s frame:**
```
[==== 50 m ====]
  Contracted length: L = L₀/γ = 100/2 = 50 m
```

The spaceship appears **half as long** to Earth observers!

### Why Does This Happen?

Length contraction is a consequence of **time dilation** and the **constancy of the speed of light**.

Consider measuring the length of a moving train by timing how long it takes to pass a stationary clock:

```
Stationary clock at position
    |
    v
Train moving right → [________L________]
                        ↓
                   Takes time Δt to pass
```

**In train''s rest frame:**
- Length = proper length $L_0$
- Time to pass clock = $\Delta t_0 = \frac{L_0}{v}$

**In Earth''s frame:**
- Clock measures dilated time: $\Delta t = \gamma \Delta t_0$
- Apparent length: $L = v \Delta t = v (\gamma \Delta t_0) = \gamma v \frac{L_0}{v} = \gamma L_0$

Wait—that gives $L = \gamma L_0$ (lengthening)!

**Correction**: The clock on Earth must measure the **front and back of the train simultaneously**, but "simultaneous" is frame-dependent in relativity!

When you account for the **relativity of simultaneity**, you get the correct formula:

$$L = \frac{L_0}{\gamma}$$

The contracted length is SHORTER!

## Examples

### Example 1: Spaceship Passing Earth

A spaceship of proper length $L_0 = 200 \text{ m}$ moves at $v = 0.6c$ past Earth.

**Lorentz factor:**
$$\gamma = \frac{1}{\sqrt{1-0.6^2}} = \frac{1}{\sqrt{0.64}} = 1.25$$

**Contracted length:**
$$L = \frac{L_0}{\gamma} = \frac{200}{1.25} = 160 \text{ m}$$

Earth observers measure the spaceship as **160 m long** (20% shorter).

### Example 2: Interstellar Travel

A spaceship travels to a star 100 light-years away at $v = 0.99c$.

**From Earth''s frame:**
- Distance to star: $100 \text{ ly}$ (proper distance, since Earth and star are at rest relative to each other)
- Travel time: $\Delta t = \frac{100 \text{ ly}}{0.99c} = 101 \text{ years}$

**From spaceship''s frame:**
- Lorentz factor: $\gamma = 7.09$
- Contracted distance: $L = \frac{100 \text{ ly}}{7.09} = 14.1 \text{ ly}$
- Travel time: $\Delta t_0 = \frac{14.1 \text{ ly}}{0.99c} = 14.2 \text{ years}$

The distance to the star appears **7× shorter** from the spaceship! This is equivalent to the time dilation effect.

### Example 3: Particle Accelerator

In the Large Hadron Collider (LHC), protons move at $v = 0.999999991c$ ($\gamma \approx 7,500$).

- **LHC circumference** (proper length): $L_0 = 26.7 \text{ km}$
- **From proton''s perspective**: $L = \frac{26.7 \text{ km}}{7,500} = 3.56 \text{ m}$

The 27 km ring appears as only **3.56 meters** to the proton!

This is why protons can circulate for hours—from their perspective, they''re traveling a tiny loop.

## Important Notes

### Only Parallel Lengths Contract

**Length contraction ONLY affects dimensions parallel to motion.**

```
Moving right →
┌─────────┐
│         │
│  Box    │ ← Height (perpendicular to motion): unchanged
│         │
└─────────┘
   Length (parallel to motion): contracted
```

Example: A cube moving at relativistic speeds becomes a **rectangular prism** (shorter in direction of motion, unchanged in perpendicular directions).

### Length Contraction is Real

Length contraction is **not an optical illusion**—it''s a real effect!

- If you tried to fit a 10 m pole into a 5 m barn at relativistic speeds, from the barn''s frame, the pole would contract and fit inside!
- From the pole''s frame, the barn contracts, but the pole still fits because **simultaneity is relative**

### The Barn and Pole Paradox

**Setup**: A 10 m pole (proper length) moves at $v$ such that it contracts to 5 m. The barn is 5 m long.

**From barn''s frame:**
- Pole length: 5 m (contracted)
- Barn length: 5 m
- **Pole fits inside barn!** ✓

**From pole''s frame:**
- Pole length: 10 m (proper length)
- Barn length: 2.5 m (contracted to $5/\gamma$)
- **Pole doesn''t fit!** ✗

**Resolution**: The events "front of pole exits barn" and "back of pole enters barn" are **simultaneous** in the barn''s frame but **NOT simultaneous** in the pole''s frame!

From the pole''s perspective, the back enters the barn AFTER the front has already left—no paradox!

## When Is Length Contraction Significant?

| Speed (v) | Lorentz factor (γ) | Contraction (L/L₀) |
|-----------|-------------------|--------------------|
| 0.01c | 1.00005 | 99.995% |
| 0.1c | 1.005 | 99.5% |
| 0.5c | 1.15 | 87% |
| 0.866c | 2.0 | 50% |
| 0.99c | 7.1 | 14% |
| 0.999c | 22.4 | 4.5% |

Like time dilation, length contraction is only significant at relativistic speeds.

## Relationship Between Time Dilation and Length Contraction

Time dilation and length contraction are **two sides of the same coin**:

$$\Delta t = \gamma \Delta t_0$$
$$L = \frac{L_0}{\gamma}$$

They combine to keep the speed of light constant:

- Time runs $\gamma$ times slower
- Distances are $\gamma$ times shorter
- Speed = distance/time remains $c$ for light

## Sources
- Khan Academy: "Length contraction"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- HyperPhysics: "Length Contraction" (Georgia State University)
- MIT OpenCourseWare: 8.20 Special Relativity
- "Spacetime Physics" by Taylor and Wheeler
',

  '[
    {
      "question": "How does length contraction affect a moving object?",
      "options": ["The object appears longer in the direction of motion", "The object appears shorter ONLY in the direction of motion", "The object appears shorter in all dimensions", "The object''s length doesn''t change"],
      "correctAnswer": 1,
      "explanation": "Length contraction causes moving objects to appear shorter ONLY in the direction parallel to motion. Perpendicular dimensions (height, width if motion is horizontal) remain unchanged. The formula is L = L₀/γ."
    },
    {
      "question": "What is proper length (L₀)?",
      "options": ["Length measured by a stationary observer", "Length measured in the object''s rest frame (always longest)", "Length contracted by motion", "Average length from all reference frames"],
      "correctAnswer": 1,
      "explanation": "Proper length (L₀) is the length measured by an observer AT REST relative to the object. It is always the LONGEST possible length—all moving observers measure shorter (contracted) lengths in the direction of motion."
    },
    {
      "question": "A spaceship with proper length 100 m travels at 0.866c (where γ=2). What length does an Earth observer measure?",
      "options": ["25 m", "50 m", "100 m", "200 m"],
      "correctAnswer": 1,
      "explanation": "Contracted length: L = L₀/γ = 100/2 = 50 m. At v = 0.866c (γ=2), the spaceship appears half as long to Earth observers. Only the length in the direction of motion contracts."
    },
    {
      "question": "From the perspective of an LHC proton moving at 0.999999991c (γ≈7500), the 27 km circumference of the accelerator appears to be approximately:",
      "options": ["27 km", "2.7 km", "270 m", "3.6 m"],
      "correctAnswer": 3,
      "explanation": "Contracted length: L = L₀/γ = 27,000 m / 7,500 = 3.6 m. From the proton''s perspective, the 27 km ring appears as only 3.6 meters! This is why protons can circulate for hours—from their frame, they''re traveling a tiny loop."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'Relativistic Energy and Mass-Energy Equivalence',
  'relativistic-energy-emc2',
  4,
  '# Relativistic Energy and E=mc²

## Mass-Energy Equivalence

Perhaps the most famous equation in physics:

$$E = mc^2$$

Where:
- $E$ = energy (in joules)
- $m$ = mass (in kilograms)
- $c$ = speed of light ($3.00 \times 10^8 \text{ m/s}$)

### What Does This Mean?

**Mass and energy are interchangeable!** Mass is a form of energy, and energy has mass.

- Mass can be converted to energy (nuclear reactions, particle-antiparticle annihilation)
- Energy can be converted to mass (particle creation in accelerators)
- $c^2$ is a huge number: $(3 \times 10^8)^2 = 9 \times 10^{16} \text{ J/kg}$

### Energy Conversion

Small masses release enormous energy:

$$1 \text{ gram} \times c^2 = 0.001 \text{ kg} \times 9 \times 10^{16} \text{ J/kg} = 9 \times 10^{13} \text{ J}$$

This is equivalent to:
- **21 kilotons of TNT** (same as the Hiroshima atomic bomb)
- **25 million kilowatt-hours**
- **Enough electricity to power a US city for a day**

## Relativistic Energy

The full relativistic energy formula is:

$$E = \gamma mc^2$$

Where:
- $E$ = total energy
- $\gamma$ = Lorentz factor = $\frac{1}{\sqrt{1-v^2/c^2}}$
- $m$ = **rest mass** (mass at zero velocity)

### Rest Energy

When $v = 0$, $\gamma = 1$, so:

$$E_0 = mc^2$$

This is the **rest energy**—energy an object has even when stationary!

### Kinetic Energy at High Speeds

The **relativistic kinetic energy** is total energy minus rest energy:

$$KE = E - E_0 = (\gamma - 1)mc^2$$

At low speeds ($v \ll c$), this reduces to the classical formula $KE = \frac{1}{2}mv^2$.

At high speeds, $KE$ becomes MUCH larger than $\frac{1}{2}mv^2$!

## Examples

### Example 1: Rest Energy of Everyday Objects

**1 gram of mass:**
$$E_0 = mc^2 = (0.001 \text{ kg})(3 \times 10^8 \text{ m/s})^2 = 9 \times 10^{13} \text{ J}$$

**You (70 kg person):**
$$E_0 = mc^2 = (70 \text{ kg})(3 \times 10^8 \text{ m/s})^2 = 6.3 \times 10^{18} \text{ J}$$

This is equivalent to:
- **1.5 billion tons of TNT**
- **The annual electricity consumption of a small country**

If your body''s mass were converted entirely to energy, it would power New York City for about 2 years!

### Example 2: Kinetic Energy at Relativistic Speeds

A proton ($m = 1.67 \times 10^{-27} \text{ kg}$) in the LHC moves at $0.999999991c$.

**Classical prediction** (WRONG at high speeds):
$$KE_{classical} = \frac{1}{2}mv^2 = \frac{1}{2}(1.67 \times 10^{-27})(3 \times 10^8)^2 = 7.5 \times 10^{-11} \text{ J}$$

**Relativistic calculation** (CORRECT):
$$\gamma = 7,500$$
$$KE = (\gamma - 1)mc^2 = (7,500 - 1)(1.67 \times 10^{-27})(3 \times 10^8)^2 = 5.6 \times 10^{-7} \text{ J}$$

The relativistic KE is **7,500× larger** than the classical prediction!

In electron volts (eV), this is about **7 TeV**—the design energy of the LHC!

### Example 3: Nuclear Fusion (Sun''s Energy)

The Sun fuses hydrogen into helium:

$$4 \text{ } ^1\text{H} \rightarrow \text{ } ^4\text{He} + 2e^+ + 2\nu_e + \text{energy}$$

**Mass before:**
$$4 \times 1.007825 \text{ u} = 4.031300 \text{ u}$$

**Mass after:**
$$4.002603 \text{ u (helium)} + 2 \times 0.000549 \text{ u (positrons)} = 4.003701 \text{ u}$$

**Mass defect:**
$$\Delta m = 4.031300 - 4.003701 = 0.027599 \text{ u}$$

**Energy released:**
$$E = \Delta mc^2 = (0.027599 \text{ u})(1.49 \times 10^{-10} \text{ J/u}) = 4.1 \times 10^{-12} \text{ J}$$

This small energy per reaction × $10^{38}$ reactions/second = **3.8 × 10²⁶ W** (Sun''s power)!

### Example 4: Antimatter Annihilation

When a particle and its antiparticle meet, they annihilate:

$$e^- + e^+ \rightarrow \gamma + \gamma$$

**All mass is converted to energy!**

For an electron-positron pair ($m_e = 9.11 \times 10^{-31} \text{ kg}$):

$$E = 2m_ec^2 = 2(9.11 \times 10^{-31})(3 \times 10^8)^2 = 1.64 \times 10^{-13} \text{ J} = 1.02 \text{ MeV}$$

This is the maximum energy release possible for a given mass (100% efficiency)!

## Mass-Energy Conversion Efficiency

| Process | Efficiency | Energy Release |
|---------|------------|----------------|
| Chemical combustion | ~0.0001% | Mass change too small to measure |
| Nuclear fission (U-235) | ~0.08% | 8 × 10⁻⁴ mc² |
| Nuclear fusion (H → He) | ~0.7% | 7 × 10⁻³ mc² |
| Matter-antimatter annihilation | 100% | mc² |

Nuclear reactions are **millions of times** more energetic than chemical reactions because they convert a small fraction of mass to energy.

## Momentum and Energy

In relativity, momentum and energy form a **four-vector**:

$$E^2 = (pc)^2 + (mc^2)^2$$

Where:
- $p$ = relativistic momentum = $\gamma mv$
- $pc$ = momentum energy (contribution from motion)
- $mc^2$ = rest energy (contribution from mass)

### Massless Particles

For massless particles like photons ($m = 0$):

$$E = pc$$

Photons have momentum even though they have no mass!

### Photons Have Energy

A photon of frequency $f$ has energy:

$$E = hf$$

Where:
- $h$ = Planck''s constant = $6.626 \times 10^{-34} \text{ J}\cdot\text{s}$

Since $E = pc$ for photons:

$$p = \frac{hf}{c} = \frac{h}{\lambda}$$

Photons exert **radiation pressure** (used in solar sails)!

## Speed Limit: Why c Is Maximum

As $v \rightarrow c$, $\gamma \rightarrow \infty$, so:

$$E = \gamma mc^2 \rightarrow \infty$$

To accelerate a massive object to $c$ would require **infinite energy**—impossible!

Only massless particles (photons, gluons, gravitons) can travel at $c$.

## Key Formulas Summary

| Formula | Quantity |
|---------|----------|
| $E_0 = mc^2$ | Rest energy |
| $E = \gamma mc^2$ | Total relativistic energy |
| $KE = (\gamma - 1)mc^2$ | Relativistic kinetic energy |
| $p = \gamma mv$ | Relativistic momentum |
| $E^2 = (pc)^2 + (mc^2)^2$ | Energy-momentum relation |
| $E = hf$ | Photon energy |
| $p = h/\lambda$ | Photon momentum |

## Sources
- Einstein, A. (1905). "Does the Inertia of a Body Depend Upon Its Energy Content?"
- Khan Academy: "Mass-energy equivalence"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- HyperPhysics: "Relativistic Energy" (Georgia State University)
- CERN: "Relativity and the LHC"
',

  '[
    {
      "question": "What does E=mc² mean?",
      "options": ["Energy equals mass times the speed of light", "Mass and energy are interchangeable; mass is a form of energy", "Energy can be created from nothing", "Mass increases with velocity"],
      "correctAnswer": 1,
      "explanation": "E=mc² means mass and energy are EQUIVALENT and interchangeable. Mass is a concentrated form of energy, and energy has mass-like properties. The c² factor shows that tiny masses contain enormous energy (9×10¹⁶ J per kg)."
    },
    {
      "question": "How much energy is released if 1 gram of mass is completely converted to energy?",
      "options": ["9×10⁶ J (equivalent to 2 tons of TNT)", "9×10¹³ J (equivalent to 21 kilotons of TNT)", "9×10¹⁶ J (equivalent to 1 megaton of TNT)", "9×10¹⁹ J (equivalent to 100 megatons of TNT)"],
      "correctAnswer": 1,
      "explanation": "E = mc² = (0.001 kg)(3×10⁸ m/s)² = 9×10¹³ J. This is equivalent to ~21 kilotons of TNT—the energy of the Hiroshima atomic bomb. Small masses release enormous energy when converted!"
    },
    {
      "question": "Why can''t a massive object ever reach the speed of light?",
      "options": ["Friction prevents it", "Time dilation prevents it", "Infinite energy would be required (E=γmc²→∞ as v→c)", "The object would disintegrate"],
      "correctAnswer": 2,
      "explanation": "As v→c, γ→∞, so E=γmc²→∞. Infinite energy would be required to accelerate a massive object to light speed. This is why c is a universal speed limit—only massless particles (photons) travel at c."
    },
    {
      "question": "In nuclear fusion, 4 hydrogen nuclei fuse into 1 helium nucleus. The mass of helium is 0.7% less than 4 hydrogen masses. What happens to this mass?",
      "options": ["The mass is destroyed", "The mass is converted to energy (E=Δmc²)", "The mass becomes electrons", "The mass becomes neutrinos"],
      "correctAnswer": 1,
      "explanation": "The missing mass (mass defect) is converted to energy via E=Δmc². This 0.7% mass conversion releases 4.1×10⁻¹² J per reaction. Multiplied by 10³⁸ reactions/second, this powers the Sun with 3.8×10²⁶ W!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'Relativistic Momentum and Velocity Addition',
  'relativistic-momentum-velocity-addition',
  5,
  '# Relativistic Momentum and Velocity Addition

## Classical vs. Relativistic Momentum

### Classical Momentum (Newtonian)

$$\vec{p} = m\vec{v}$$

**Problem**: As $v \rightarrow c$, $p \rightarrow mc$ (finite). But momentum should approach infinity as energy approaches infinity!

### Relativistic Momentum

$$\vec{p} = \gamma m \vec{v} = \frac{m\vec{v}}{\sqrt{1-v^2/c^2}}$$

Where:
- $\vec{p}$ = relativistic momentum
- $\gamma$ = Lorentz factor
- $m$ = **rest mass** (mass at zero velocity, invariant)
- $\vec{v}$ = velocity

As $v \rightarrow c$, $\gamma \rightarrow \infty$, so $p \rightarrow \infty$ ✓

## Why We Need Relativistic Momentum

### Problem with Classical Momentum at High Speeds

Consider an inelastic collision where two identical particles stick together:

**Before collision** (center-of-mass frame):
```
Particle 1:  m, v →     ← Particle 2:  m, -v
              ↘          ↙
                [combined]
```

**After collision**:
- Combined mass: $2m$
- Velocity: $0$ (by symmetry)

**Momentum conservation**: $mv + m(-v) = 0 = 2m(0)$ ✓

This works in any frame...**classically**. But relativistically?

Let''s transform to a frame moving at velocity $u$ to the right:

**Classical prediction** (Galilean transformation):
- Particle 1 velocity: $v - u$
- Particle 2 velocity: $-v - u$
- Combined velocity: $-u$

**Relativistic transformation** (Lorentz transformation):
- Particle 1 velocity: $\frac{v-u}{1-uv/c^2}$
- Particle 2 velocity: $\frac{-v-u}{1+uv/c^2}$
- Combined velocity: **NOT simply $-u$!**

Classical momentum is **NOT conserved** in all frames relativistically!

Relativistic momentum ($p = \gamma mv$) **IS conserved** in all inertial frames.

## Examples

### Example 1: Electron Momentum

An electron moves at $v = 0.9c$.

**Lorentz factor:**
$$\gamma = \frac{1}{\sqrt{1-0.9^2}} = \frac{1}{\sqrt{0.19}} = 2.29$$

**Classical momentum** (incorrect):
$$p_{classical} = mv = (9.11 \times 10^{-31} \text{ kg})(0.9 \times 3 \times 10^8 \text{ m/s}) = 2.46 \times 10^{-22} \text{ kg}\cdot\text{m/s}$$

**Relativistic momentum** (correct):
$$p = \gamma mv = 2.29 \times 2.46 \times 10^{-22} \text{ kg}\cdot\text{m/s} = 5.63 \times 10^{-22} \text{ kg}\cdot\text{m/s}$$

The relativistic momentum is **2.29× larger** than the classical prediction!

### Example 2: Proton in LHC

A proton in the LHC moves at $v = 0.999999991c$ ($\gamma \approx 7,500$).

**Relativistic momentum:**
$$p = \gamma mv = 7,500 \times (1.67 \times 10^{-27} \text{ kg}) \times (3 \times 10^8 \text{ m/s}) = 3.76 \times 10^{-15} \text{ kg}\cdot\text{m/s}$$

In electron-volts:
$$pc = 7,500 \times 938 \text{ MeV} = 7.0 \text{ TeV}$$

This is the design momentum of the LHC!

### Example 3: Conservation of Relativistic Momentum

A particle of mass $m$ moving at $v$ collides with an identical stationary particle. They stick together.

**Before collision:**
- Particle 1: mass $m$, velocity $v$, momentum $p_1 = \gamma_1 mv$
- Particle 2: mass $m$, velocity $0$, momentum $p_2 = 0$
- Total momentum: $p_{total} = \gamma_1 mv$

**After collision:**
- Combined mass: $M$ (NOT simply $2m$!)
- Combined velocity: $v''$
- Total momentum: $p_{total} = \Gamma M v''$

By conservation of momentum:
$$\gamma_1 mv = \Gamma M v''$$

The combined mass $M > 2m$ because kinetic energy is converted to mass!

## Relativistic Velocity Addition

### Classical (Galilean) Velocity Addition

If a train moves at $u$ and you walk at $v$ forward on the train, your speed relative to the ground is:

$$v'' = u + v$$

**This is WRONG at high speeds!**

If $u = 0.6c$ and $v = 0.6c$, this gives $v'' = 1.2c > c$—impossible!

### Relativistic Velocity Addition Formula

$$v'' = \frac{u + v}{1 + \frac{uv}{c^2}}$$

Where:
- $v''$ = relative velocity (in ground frame)
- $u$ = velocity of frame A (train) in frame B (ground)
- $v$ = velocity of object in frame A (train)

This formula ensures $v'' < c$ for any $u, v < c$!

### Why This Formula Works

It comes from **Lorentz transformations** (relativistic coordinate transformations):

$$x'' = \gamma_u (x - ut)$$
$$t'' = \gamma_u (t - \frac{ux}{c^2})$$

Velocity is $v'' = \frac{dx''}{dt''} = \frac{\gamma_u (dx - u dt)}{\gamma_u (dt - \frac{u}{c^2} dx)} = \frac{dx/dt - u}{1 - \frac{u}{c^2} dx/dt} = \frac{v - u}{1 - \frac{uv}{c^2}}$

## Examples of Velocity Addition

### Example 1: Spaceship Chasing a Light Beam

A spaceship moves at $u = 0.5c$ and fires a laser forward at $v = c$.

**Classical prediction** (WRONG): $v'' = 0.5c + c = 1.5c$ ✗

**Relativistic formula** (CORRECT):
$$v'' = \frac{0.5c + c}{1 + \frac{0.5c \cdot c}{c^2}} = \frac{1.5c}{1 + 0.5} = c$$ ✓

Light travels at $c$ in all frames!

### Example 2: Two Spaceships Approaching Each Other

Spaceship A moves right at $u = 0.8c$ (relative to Earth).
Spaceship B moves left at $v = -0.6c$ (relative to Earth).

**From A''s frame, what is B''s speed?**

Using relativistic velocity addition:
$$v'' = \frac{u + v}{1 + \frac{uv}{c^2}} = \frac{0.8c + (-0.6c)}{1 + \frac{0.8c \cdot (-0.6c)}{c^2}} = \frac{0.2c}{1 - 0.48} = \frac{0.2c}{0.52} = 0.385c$$

From A''s perspective, B approaches at $0.385c$ (NOT $1.4c$)!

### Example 3: Particle Accelerator

In a collider, a proton moves at $u = 0.999c$ and another moves at $v = -0.999c$.

**What is their relative speed?**

$$v'' = \frac{0.999c + (-0.999c)}{1 + \frac{0.999c \cdot (-0.999c)}{c^2}} = \frac{0}{1 - 0.998} = 0$$

Wait—that''s wrong! They''re moving toward each other, so relative speed should be high!

**Correction**: The formula gives $v''$ in A''s frame. Since B is moving at $-0.999c$ in Earth frame:

$$v'' = \frac{0.999c + 0.999c}{1 + \frac{0.999c \cdot 0.999c}{c^2}} = \frac{1.998c}{1 + 0.998} = 0.99995c$$

Still less than $c$ ✓

## Perpendicular Velocities

For perpendicular velocities, the formulas are more complex:

$$v_x'' = \frac{v_x - u}{1 - \frac{uv_x}{c^2}}$$
$$v_y'' = \frac{v_y}{\gamma_u (1 - \frac{uv_x}{c^2})}$$
$$v_z'' = \frac{v_z}{\gamma_u (1 - \frac{uv_x}{c^2})}$$

Where $\gamma_u = \frac{1}{\sqrt{1-u^2/c^2}}$.

## Key Formulas

| Formula | Quantity |
|---------|----------|
| $\vec{p} = \gamma m \vec{v}$ | Relativistic momentum |
| $\gamma = \frac{1}{\sqrt{1-v^2/c^2}}$ | Lorentz factor |
| $v'' = \frac{u + v}{1 + uv/c^2}$ | Relativistic velocity addition (parallel) |
| $v_x'' = \frac{v_x - u}{1 - uv_x/c^2}$ | Velocity transformation (x-component) |
| $v_y'' = \frac{v_y}{\gamma_u (1 - uv_x/c^2)}$ | Velocity transformation (y-component) |

## Common Misconceptions

**Misconception**: "Mass increases with velocity."

**Reality**: In modern relativity, **mass is invariant** (rest mass). What increases is the **Lorentz factor** ($\gamma$), making momentum and energy larger. The old concept of "relativistic mass" is outdated.

## Sources
- Khan Academy: "Relativistic momentum"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- HyperPhysics: "Relativistic Momentum" (Georgia State University)
- MIT OpenCourseWare: 8.20 Special Relativity
',

  '[
    {
      "question": "What is the formula for relativistic momentum?",
      "options": ["p = mv", "p = γmv", "p = mv²", "p = γm²v"],
      "correctAnswer": 1,
      "explanation": "Relativistic momentum is p = γmv where γ = 1/√(1-v²/c²). Unlike classical momentum (p=mv), relativistic momentum approaches infinity as v→c, correctly reflecting the infinite energy required to reach light speed."
    },
    {
      "question": "A spaceship moves at 0.6c and fires a missile forward at 0.6c (relative to the spaceship). What is the missile''s speed relative to Earth?",
      "options": ["1.2c", "0.88c", "0.6c", "c"],
      "correctAnswer": 1,
      "explanation": "Using relativistic velocity addition: v'' = (u+v)/(1+uv/c²) = (0.6c+0.6c)/(1+0.36) = 1.2c/1.36 = 0.88c. The missile travels at 0.88c relative to Earth—NOT 1.2c (which would exceed light speed)!"
    },
    {
      "question": "Two spaceships approach each other, each moving at 0.8c relative to Earth. What is their speed relative to each other?",
      "options": ["1.6c", "0.976c", "0.8c", "c"],
      "correctAnswer": 1,
      "explanation": "Using relativistic velocity addition: v'' = (0.8c+0.8c)/(1+0.8×0.8) = 1.6c/1.64 = 0.976c. From either spaceship''s perspective, the other approaches at 0.976c—still less than c!"
    },
    {
      "question": "An electron moving at 0.9c (γ=2.29) has how much more momentum than classical physics predicts?",
      "options": ["1.29 times more", "2.29 times more", "3.29 times more", "The same"],
      "correctAnswer": 1,
      "explanation": "Relativistic momentum: p = γmv = 2.29×mv. Classical momentum: p = mv. Ratio: 2.29. The electron has 2.29× more momentum than classical physics predicts. At 0.9c, relativistic effects are significant!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'special-relativity' LIMIT 1),
  'Minkowski Spacetime and Spacetime Diagrams',
  'minkowski-spacetime',
  6,
  '# Minkowski Spacetime and Spacetime Diagrams

## What Is Spacetime?

In 1908, Hermann Minkowski proposed that **space and time are unified** into a single 4-dimensional continuum called **spacetime**.

**"Henceforth space by itself, and time by itself, are doomed to fade away into mere shadows, and only a kind of union of the two will preserve an independent reality."**
—Hermann Minkowski, 1908

### The Fourth Dimension

Spacetime has **4 dimensions**:
- 3 spatial dimensions: $x, y, z$
- 1 time dimension: $ct$ (time × speed of light, to give it distance units)

Why $ct$? Because $ct$ has units of distance (meters), same as $x, y, z$.

### Spacetime Interval

The spacetime interval ($\Delta s$) between two events is:

$$(\Delta s)^2 = (c\Delta t)^2 - (\Delta x)^2 - (\Delta y)^2 - (\Delta z)^2$$

Or, in 1D space:

$$(\Delta s)^2 = (c\Delta t)^2 - (\Delta x)^2$$

This interval is **invariant**—all observers measure the same value!

## Types of Spacetime Intervals

The sign of $(\Delta s)^2$ determines the type of interval:

### Timelike Interval: $(\Delta s)^2 > 0$

**$c\Delta t > \Delta x$** (time dominates)

- Events can be causally connected
- One event can influence the other
- A massive object can travel between events
- **Proper time** exists between events

Example: You reading this sentence and you blinking 1 second later.

### Spacelike Interval: $(\Delta s)^2 < 0$

**$\Delta x > c\Delta t$** (space dominates)

- Events cannot be causally connected
- Nothing can travel between events (would require $v > c$)
- **Proper distance** exists between events
- Different observers disagree on time order!

Example: A supernova in galaxy A (now) and a star forming in galaxy B (now). Distance: 10 million light-years. Events are simultaneous for some observers, not for others.

### Lightlike (Null) Interval: $(\Delta s)^2 = 0$

**$\Delta x = c\Delta t$** (space and time equal)

- Connected by a light signal
- Only massless particles (photons) travel between events
- **Proper time is zero** between events

Example: A star exploding and the light reaching your telescope.

## Spacetime Diagrams

A spacetime diagram plots **time** ($ct$) on the vertical axis vs. **position** ($x$) on the horizontal axis.

```
       ct
        ^
        |     / light cone (45° line)
        |    /
        |   /
        |  /
        | /
        |/__________________> x
       / O
      /|
     / |
    /  |
   /   |
```

### The Light Cone

At any event (point O), the **light cone** divides spacetime:

```
         Future light cone
              /|
             / |
            /  |
           /   | ct
          /    |
   ______/_____|__________> x
        / O    |
  Past /light  |
    cone       |
              |
```

- **Inside future light cone**: Events that O can influence (timelike future)
- **Inside past light cone**: Events that can influence O (timelike past)
- **On light cone**: Events connected to O by light (lightlike)
- **Outside light cone**: Events causally disconnected from O (spacelike)

### Worldlines

A **worldline** is the path of an object through spacetime.

**Stationary object** (at $x = 0$):
```
ct
 |
 |
 |
 |_______ x
```

**Object moving at constant velocity**:
```
ct
 |   /
 |  /
 | /
 |/_____ x
```

**Light** (photon):
```
ct
 |  /
 | /
 |/_____ x (45° line)
```

**Accelerating object** (curved worldline):
```
ct
 |    /
 |   /
 |  /
 | /
 |/_____ x
```

## Examples

### Example 1: Timelike Interval

Event 1: You clap your hands at $x = 0, t = 0$.
Event 2: You clap again at $x = 0, t = 1 \text{ s}$.

**Spacetime interval:**
$$(\Delta s)^2 = (c \cdot 1)^2 - 0^2 = (3 \times 10^8)^2 = 9 \times 10^{16} \text{ m}^2$$

$(\Delta s)^2 > 0$: **Timelike** interval

**Proper time**:
$$\Delta \tau = \frac{\Delta s}{c} = \frac{3 \times 10^8 \text{ m}}{3 \times 10^8 \text{ m/s}} = 1 \text{ s}$$

This is the time measured by your watch—**1 second**!

### Example 2: Lightlike Interval

Event 1: A star explodes at $x = 0, t = 0$.
Event 2: Light from explosion reaches Earth at $x = 10 \text{ ly}, t = 10 \text{ years}$.

**Spacetime interval:**
$$(\Delta s)^2 = (10c)^2 - (10c)^2 = 0$$

$(\Delta s)^2 = 0$: **Lightlike** interval

**Proper time** between events is **zero**! From the photon''s perspective, no time passes during the 10-light-year journey.

### Example 3: Spacelike Interval

Event 1: Supernova in galaxy A at $x = -5 \text{ ly}, t = 0$.
Event 2: Star forms in galaxy B at $x = +5 \text{ ly}, t = 0$.

**Spacetime interval:**
$$(\Delta s)^2 = (0)^2 - (10c)^2 = -100c^2$$

$(\Delta s)^2 < 0$: **Spacelike** interval

These events are **causally disconnected**—nothing can travel between them without exceeding light speed!

Different observers disagree on which event happened first!

## Lorentz Transformations on Spacetime Diagrams

A Lorentz transformation is a **rotation in spacetime** (but not a simple rotation—it hyperbolically mixes space and time).

**Effect on axes**:
- Time axis tilts toward light cone
- Space axis tilts toward light cone
- Light cone stays at 45° (invariant!)

```
       ct''     ct
        |       /
        |      /
        |     /
        |    /
        |   /   (moving frame)
        |  /
        | /
        |/_______ x''  x
```

The **faster the frame moves**, the more the axes tilt toward the light cone.

## Invariant Quantities

Like the spacetime interval, other quantities are invariant:

1. **Rest mass**: $m$ (same for all observers)
2. **Proper time**: $\Delta \tau = \Delta s / c$ (time measured by clock''s rest frame)
3. **Electric charge**: $q$ (same for all observers)
4. **Spacetime interval**: $(\Delta s)^2$ (same for all observers)

These are the **true** physical quantities—everything else is frame-dependent!

## The Geometry of Spacetime

Spacetime is **not Euclidean**—it''s **Minkowskian**:

**Euclidean (3D space)**:
$$ds^2 = dx^2 + dy^2 + dz^2$$

**Minkowskian (4D spacetime)**:
$$ds^2 = (c dt)^2 - dx^2 - dy^2 - dz^2$$

The **minus sign** makes all the difference! It creates the light cone structure and causal relationships.

## Key Concepts

1. **Spacetime unification**: Space and time are aspects of a single 4D continuum
2. **Invariant interval**: All observers agree on $(\Delta s)^2$, but not on $\Delta x$ or $\Delta t$ separately
3. **Light cone**: Divides causally connected from disconnected events
4. **Worldlines**: Paths of objects through spacetime
5. **Proper time**: Time measured by a clock traveling between events (exists for timelike intervals)

## Sources
- Minkowski, H. (1908). "Space and Time"
- Khan Academy: "Spacetime diagrams"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- HyperPhysics: "Spacetime Diagram" (Georgia State University)
- "Spacetime Physics" by Taylor and Wheeler
- Schutz, B. (2009). A First Course in General Relativity
',

  '[
    {
      "question": "What is the spacetime interval (Δs)² between two events that occur at the same location but 2 seconds apart?",
      "options": ["(2c)²", "4c²", "0", "Undefined"],
      "correctAnswer": 1,
      "explanation": "(Δs)² = (cΔt)² - (Δx)² = (2c)² - 0 = 4c². This is a TIMELIKE interval (Δs² > 0). The proper time between these events is 2 seconds—the time measured by a stationary observer at that location."
    },
    {
      "question": "What type of spacetime interval connects two events that can be connected by a light signal?",
      "options": ["Timelike (Δs² > 0)", "Spacelike (Δs² < 0)", "Lightlike/null (Δs² = 0)", "Imaginary interval"],
      "correctAnswer": 2,
      "explanation": "A lightlike (or null) interval has Δs² = 0, meaning cΔt = Δx. Events connected by light have zero proper time between them—from the photon''s perspective, no time passes during its journey!"
    },
    {
      "question": "On a spacetime diagram, what does a worldline at 45° represent?",
      "options": ["A stationary object", "An object moving at half light speed", "Light (a photon)", "An accelerating object"],
      "correctAnswer": 2,
      "explanation": "A 45° line on a spacetime diagram represents light moving at c. For every unit of time (ct), light travels 1 unit of distance (x), giving a slope of 1 (45°). This forms the light cone that divides spacetime into causal regions."
    },
    {
      "question": "Two events are 10 light-years apart and occur simultaneously (t=0) in one frame. What is true about these events?",
      "options": ["All observers agree they are simultaneous", "They are causally connected", "They have a spacelike interval (Δs² < 0)", "They have a timelike interval (Δs² > 0)"],
      "correctAnswer": 2,
      "explanation": "(Δs)² = 0² - (10c)² = -100c² < 0: SPACELIKE interval. Events separated by more distance than light can cross in the time between them are causally disconnected. Different observers disagree on which happened first!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: GENERAL RELATIVITY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'advanced-physics' LIMIT 1),
  'General Relativity',
  'general-relativity',
  'Understand gravity as curvature of spacetime, black holes, and cosmology.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'general-relativity' LIMIT 1),
  'The Equivalence Principle',
  'equivalence-principle',
  1,
  '# The Equivalence Principle

## What Is the Equivalence Principle?

The **equivalence principle** is the foundation of Einstein''s general theory of relativity. It states:

**The effects of gravity are locally indistinguishable from the effects of acceleration.**

In other words: **You can''t tell if you''re in a gravitational field or accelerating!**

## Types of Equivalence Principle

### Weak Equivalence Principle (Galileo, Newton)

**All objects fall with the same acceleration in a gravitational field, regardless of their mass or composition.**

This is also called the **universality of free fall**.

Galileo supposedly dropped balls from the Leaning Tower of Pisa to demonstrate this!

Mathematically:
$$\frac{m_{inertial}}{m_{gravitational}} = \text{constant}$$

Where:
- $m_{inertial}$ = mass in Newton''s second law ($F = ma$)
- $m_{gravitational}$ = mass in Newton''s law of gravitation ($F = G\frac{Mm}{r^2}$)

The fact that these two "masses" are equal is **not obvious**—it''s a deep fact about nature!

### Einstein''s Equivalence Principle (Stronger)

**The outcome of any local non-gravitational experiment in a freely falling laboratory is independent of the velocity of the laboratory and its location in spacetime.**

Key points:
- **Local**: Experiment confined to small region of spacetime
- **Non-gravitational**: Doesn''t include experiments that measure gravity itself
- **Freely falling**: Inertial (non-accelerating) frame

## Thought Experiments

### Einstein''s Elevator

Imagine you''re in a closed elevator with no windows.

**Scenario 1**: Elevator at rest on Earth
```
       You feel your weight
              ↓
       ┌───────────┐
       │    YOU    │
       │   (g)     │ ← Gravity pulls down
       └───────────┘
```

**Scenario 2**: Elevator in deep space, accelerating upward at $g$
```
       Floor accelerates up
              ↑
       ┌───────────┐
       │    YOU    │
       │           │ ← Floor pushes you (feels like gravity!)
       └───────────┘
```

**Question**: Can you tell the difference?

**Answer**: **No!** Both feel identical—you feel your weight the same way.

What if you drop a ball?

**On Earth** (Scenario 1):
- Ball falls to floor at acceleration $g$
- You and elevator stay still

**In accelerating elevator** (Scenario 2):
- Ball floats (you released it, it has no acceleration)
- Floor accelerates UP to meet the ball at $g$
- **Appears** the same as ball falling!

### Freely Falling Elevator

Now imagine the elevator cable breaks and you''re both falling freely.

**Inside the elevator**:
- You float weightlessly
- Dropped ball hovers in front of you
- No local experiment can detect gravity

**This is identical to being in deep space far from any gravity!**

Einstein realized: **A freely falling frame is locally inertial** (no gravity detected).

This led him to reformulate gravity as **spacetime curvature**, not a force!

## Experimental Tests

### Eötvös Experiment (1890s)

Roland von Eötvös tested the weak equivalence principle using a torsion balance:

```
          Wire (torsion fiber)
                |
        ┌───────┴───────┐
        │               │
     Mass A         Mass B
    (different    (different
    material)     material)
        │               │
        └───────┬───────┘
                ↓
           Earth (gravity)
```

If $m_{inertial} \neq m_{gravitational}$, different materials would fall at different rates, causing the balance to twist.

**Result**: No twist detected—equivalent to within 1 part in $10^9$!

### Modern Tests: Lunar Laser Ranging

By bouncing lasers off mirrors left on the Moon by Apollo astronauts, scientists test if the Moon and Earth fall identically toward the Sun.

**Result**: Confirmed to 1 part in $10^{14}$!

### Gyroscope Experiments (Gravity Probe B)

A gyroscope in Earth orbit should **precess** (rotate) due to Earth''s gravity dragging spacetime (frame-dragging).

**Result**: Confirmed to 0.3% accuracy!

## Consequences of the Equivalence Principle

### 1. Gravitational Redshift

Light climbing out of a gravitational well **loses energy** (redshifts).

**Frequency shift**:
$$\frac{f_{receiver}}{f_{emitter}} = \sqrt{\frac{1 - 2GM/(R_1c^2)}{1 - 2GM/(R_2c^2)}}$$

Near Earth''s surface (weak field):
$$\frac{\Delta f}{f} \approx \frac{gh}{c^2}$$

Where:
- $g$ = gravitational acceleration
- $h$ = height difference

**Example**: GPS satellite (20,200 km altitude)

Clock on satellite runs **45 μs/day faster** than clock on Earth!

This must be corrected, or GPS would accumulate 10 km errors per day.

### 2. Bending of Light

If gravity = acceleration, then light should bend in a gravitational field!

**Thought experiment**: Light crosses an accelerating elevator

```
Light beam →
         →     ┌───────────┐
         →    ╱             ╲  ← Light curves
         →   ╱               ╲
        ───→╱─────────────────╲
```

**Prediction**: Light bends by angle $\theta \approx \frac{2GM}{bc^2}$ (twice Newtonian prediction!)

**Confirmed**: 1919 solar eclipse observations showed starlight bending around the Sun!

### 3. Gravitational Time Dilation

Clocks run **slower** in stronger gravitational fields (deeper in a gravity well).

**Equation**:
$$\Delta t = \Delta t_0 \sqrt{1 - \frac{2GM}{rc^2}}$$

Where:
- $\Delta t_0$ = proper time (far from gravity)
- $\Delta t$ = time measured at distance $r$ from mass $M$

**Example**: Clock on Earth''s surface vs. GPS satellite

- On Earth: Deeper in gravity well → slower
- In orbit: Weaker gravity → faster (45 μs/day faster)

Combined with special relativistic time dilation (−7 μs/day):
**Net effect**: +38 μs/day faster for GPS satellites

## Applications

### GPS Clocks

GPS satellites must correct for BOTH:
1. **Special relativity**: Moving clocks run slow by 7 μs/day
2. **General relativity**: Weaker gravity makes clocks run fast by 45 μs/day

**Net**: Clocks run 38 μs/day faster—must be corrected!

Without GR corrections, GPS would fail within hours.

### Gravitational Redshift in Astronomy

Light from massive objects (white dwarfs, neutron stars) is redshifted.

**Observed**: Spectral lines from white dwarf Sirius B are redshifted by $\Delta f/f \approx 8 \times 10^{-5}$

**Confirmed**: Predicts white dwarf mass accurately!

### Black Holes

If gravity is strong enough ($r = \frac{2GM}{c^2}$, the Schwarzschild radius):
- Time stops (from outside perspective)
- Light cannot escape
- Event horizon forms

This is a **black hole**!

## Key Equations

| Equation | Quantity |
|----------|----------|
| $m_{inertial} = m_{gravitational}$ | Weak equivalence principle |
| $\Delta f/f \approx gh/c^2$ | Gravitational redshift (weak field) |
| $\theta \approx 2GM/bc^2$ | Light deflection angle |
| $\Delta t = \Delta t_0 \sqrt{1 - 2GM/rc^2}$ | Gravitational time dilation |
| $r_s = 2GM/c^2$ | Schwarzschild radius (black hole) |

## Sources
- Einstein, A. (1907). "On the Relativity Principle and the Conclusions Drawn from It"
- Will, C. (2018). "Theory and Experiment in Gravitational Physics"
- Khan Academy: "Equivalence principle"
- OpenStax University Physics Volume 3, Chapter 5: Relativity
- NASA: "Gravity Probe B"
',

  '[
    {
      "question": "What does the equivalence principle state?",
      "options": ["Gravity and acceleration are different forces", "The effects of gravity are locally indistinguishable from acceleration", "Gravity is stronger than acceleration", "Mass and weight are the same thing"],
      "correctAnswer": 1,
      "explanation": "The equivalence principle states that gravity and acceleration are LOCALLY indistinguishable. In a closed elevator, you can''t tell if you''re stationary on Earth (gravity) or accelerating upward in deep space (acceleration). This equivalence led Einstein to reformulate gravity as spacetime curvature."
    },
    {
      "question": "In a freely falling elevator, what do you experience?",
      "options": ["Your normal weight", "Weightlessness (like floating in space)", "Stronger gravity than normal", "A feeling of being stretched"],
      "correctAnswer": 1,
      "explanation": "In a freely falling frame, you experience WEIGHTLESSNESS because gravity affects you and the elevator equally. You can''t detect the gravitational field locally—you''re in an inertial frame! This is why astronauts in orbit float, even though gravity is still 90% as strong as on Earth."
    },
    {
      "question": "What is the primary reason GPS satellite clocks run at a different rate than Earth clocks?",
      "options": ["Only special relativity (moving clocks run slow)", "Only general relativity (weaker gravity makes clocks run fast)", "Both: special relativity (-7 μs/day) + general relativity (+45 μs/day)", "Atmospheric interference"],
      "correctAnswer": 2,
      "explanation": "GPS satellites are affected by BOTH: Special relativity: moving at 14,000 km/h makes clocks run 7 μs/day SLOWER. General relativity: being 20,200 km up (weaker gravity) makes clocks run 45 μs/day FASTER. Net: +38 μs/day faster, which must be corrected!"
    },
    {
      "question": "What did the 1919 solar eclipse observations confirm?",
      "options": ["Time dilation", "Gravitational redshift", "Light bending around the Sun (twice Newtonian prediction)", "Existence of black holes"],
      "correctAnswer": 2,
      "explanation": "During the 1919 solar eclipse, astronomers measured starlight bending around the Sun. The observed bending (1.75 arcseconds) matched Einstein''s prediction of 2GM/bc², which is TWICE the Newtonian prediction. This confirmed general relativity and made Einstein famous!"
    }
  ]',
  NOW()
);
