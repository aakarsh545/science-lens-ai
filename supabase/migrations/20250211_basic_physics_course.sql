-- =====================================================
-- BASIC PHYSICS COURSE - SCIENCE LENS AI
-- Beginner Level - 28 Lessons across 6 Chapters
-- Sources: Khan Academy, OpenStax, NASA, Britannica
-- =====================================================

-- COURSE: Basic Physics
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at)
VALUES (
  UUID_GENERATE_V4(),
  'Basic Physics',
  'basic-physics',
  'Learn the fundamentals of physics including motion, forces, energy, momentum, and waves. This beginner-level course covers all essential concepts needed for high school physics.',
  'physics',
  'beginner',
  28,
  NOW()
);

-- Get course ID for chapters (replace with actual UUID after insertion)
-- For now, using placeholder UUIDs - update with actual values after first run

-- =====================================================
-- CHAPTER 1: INTRODUCTION TO PHYSICS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Introduction to Physics',
  'introduction-to-physics',
  'Learn what physics is, how we measure things, and the fundamental units used in science.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-to-physics' LIMIT 1),
  'What is Physics?',
  'what-is-physics',
  1,
  '# What is Physics?

Physics is the study of **matter**, **energy**, and the **interactions** between them. It''s one of the most fundamental sciences because it helps us understand how the universe works!

## What Physics Studies

Physics explores:
- **Motion**: How and why things move
- **Forces**: Pushes and pulls that change motion
- **Energy**: The ability to do work or cause change
- **Matter**: What everything is made of

## Why Learn Physics?

Understanding physics helps you:
- Explain everyday phenomena (why things fall, how cars move)
- Build technology (phones, computers, rockets)
- Solve real-world problems (bridges, renewable energy)
- Understand the universe (stars, planets, atoms)

## Branches of Physics

| Branch | What It Studies |
|---------|----------------|
| **Mechanics** | Motion and forces |
| **Thermodynamics** | Heat and energy |
| **Waves & Optics** | Sound, light, vision |
| **Electromagnetism** | Electricity and magnetism |
| **Modern Physics** | Atoms, quantum mechanics, relativity |

## The Scientific Method in Physics

Physics uses the **scientific method**:
1. **Observe** - Notice something interesting
2. **Question** - Ask "why?" or "how?"
3. **Hypothesize** - Make a prediction
4. **Test** - Do an experiment
5. **Analyze** - Look at the data
6. **Conclude** - Accept or reject the hypothesis

> 💡 **Fun Fact**: The word "physics" comes from the Greek word *physika*, meaning "natural things"!

---

**Key Terms**:
- **Matter**: Anything that has mass and takes up space
- **Energy**: The capacity to do work
- **Force**: A push or pull on an object
- **Hypothesis**: A testable prediction',
  '[
    {
      "question": "What does physics study?",
      "options": ["Only living things", "Matter, energy, and their interactions", "Only chemicals and reactions", "Only rocks and minerals"],
      "correctAnswer": 1,
      "explanation": "Physics studies matter, energy, and the interactions between them - from tiny atoms to the entire universe."
    },
    {
      "question": "Which of these is NOT a branch of physics?",
      "options": ["Mechanics", "Thermodynamics", "Botany", "Electromagnetism"],
      "correctAnswer": 2,
      "explanation": "Botany is the study of plants (biology). Mechanics, thermodynamics, and electromagnetism are all branches of physics."
    },
    {
      "question": "What is the first step of the scientific method?",
      "options": ["Make a conclusion", "Observe and question", "Test an experiment", "Write a hypothesis"],
      "correctAnswer": 1,
      "explanation": "The scientific method starts with observation and asking questions about what you notice."
    },
    {
      "question": "The word physics comes from which Greek word?",
      "options": ["Physika (natural things)", "Physis (growth)", "Physos (motion)", "Phronesis (wisdom)"],
      "correctAnswer": 0,
      "explanation": "Physics comes from the Greek word ''physika'', meaning ''natural things''."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-to-physics' LIMIT 1),
  'Physical Quantities and Units',
  'physical-quantities-and-units',
  2,
  '# Physical Quantities and Units

Physics is built on **measurement**. To measure things, we need **standard units** that everyone agrees on.

## What are Physical Quantities?

A **physical quantity** is any property that can be measured.

Examples:
- **Length**: How long something is
- **Mass**: How much matter something has
- **Time**: How long something takes
- **Temperature**: How hot or cold something is

## SI Units - The International System

Scientists use the **SI system** (Système International) for measurements. This ensures consistency worldwide.

### Base SI Units

| Quantity | Unit | Symbol |
|-----------|--------|---------|
| **Length** | meter | m |
| **Mass** | kilogram | kg |
| **Time** | second | s |
| **Temperature** | kelvin | K |
| **Current** | ampere | A |
| **Amount of substance** | mole | mol |
| **Luminous intensity** | candela | cd |

> 💡 **Why Meters?** A meter was originally defined as 1/10,000,000 of the distance from the equator to the North Pole!

## Standard Prefixes

Physics deals with very big and very small numbers. **Prefixes** help us write these conveniently.

| Prefix | Symbol | Factor | Example |
|---------|----------|----------|----------|
| **giga** | G | 10⁹ (billion) | Gigabyte (GB) |
| **mega** | M | 10⁶ (million) | Megawatt (MW) |
| **kilo** | k | 10³ (thousand) | Kilometer (km) |
| **centi** | c | 10⁻² (hundredth) | Centimeter (cm) |
| **milli** | m | 10⁻³ (thousandth) | Milligram (mg) |
| **micro** | μ | 10⁻⁶ (millionth) | Micrometer (μm) |
| **nano** | n | 10⁻⁹ (billionth) | Nanometer (nm) |

## Examples

- **1 km** = 1,000 m (kilometer = thousand meters)
- **1 cm** = 0.01 m (centimeter = hundredth of a meter)
- **1 mm** = 0.001 m (millimeter = thousandth of a meter)

## Derived Units

Some units are **combinations** of base units:

| Quantity | Formula | Unit | Name |
|-----------|----------|--------|-------|
| **Speed** | distance/time | m/s | meters per second |
| **Area** | length × width | m² | square meters |
| **Volume** | length × width × height | m³ | cubic meters |

> ⚠️ **Important**: Always write units with numbers! "5" means nothing. "5 meters" (5 m) has meaning!

---

**Key Terms**:
- **SI Units**: International System of Units - standard measurement system
- **Base quantity**: Fundamental measurable property (length, mass, time)
- **Derived unit**: Unit made from combining base units (speed = m/s)
- **Prefix**: Added before a unit to change its size (kilo, milli)',
  '[
    {
      "question": "What is the SI unit for length?",
      "options": ["Foot", "Meter", "Inch", "Yard"],
      "correctAnswer": 1,
      "explanation": "The meter (m) is the SI base unit for length, used by scientists worldwide."
    },
    {
      "question": "What does the prefix ''kilo'' mean?",
      "options": ["One hundredth (1/100)", "One thousandth (1/1000)", "One thousand (1000)", "One million (1,000,000)"],
      "correctAnswer": 2,
      "explanation": "The prefix ''kilo'' means one thousand (10³ or 1000). So 1 kilometer = 1000 meters."
    },
    {
      "question": "Which is a derived unit?",
      "options": ["Meter (m)", "Second (s)", "Meters per second (m/s)", "Kilogram (kg)"],
      "correctAnswer": 2,
      "explanation": "Meters per second (m/s) is derived from distance (meters) divided by time (seconds). The others are base units."
    },
    {
      "question": "1 centimeter is equal to:",
      "options": ["0.1 meters", "0.01 meters", "0.001 meters", "10 meters"],
      "correctAnswer": 1,
      "explanation": "The prefix ''centi'' means hundredth (10⁻²), so 1 cm = 0.01 meters."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-to-physics' LIMIT 1),
  'Vectors and Scalars',
  'vectors-and-scalars',
  3,
  '# Vectors and Scalars

In physics, quantities come in two types: those with **direction** and those without.

## Scalars

A **scalar** is a quantity that has only **magnitude** (size).

Examples of scalars:
- **Mass**: 5 kg (direction doesn''t matter)
- **Temperature**: 25°C (no direction)
- **Time**: 30 seconds (just an amount)
- **Speed**: 20 m/s (how fast, not which way)

> 📏 **Scalar = Size only**

## Vectors

A **vector** has both **magnitude AND direction**.

Examples of vectors:
- **Velocity**: 20 m/s **north** (speed + direction)
- **Force**: 50 N **upward** (strength + which way)
- **Displacement**: 10 m **east** (distance + direction)
- **Acceleration**: 5 m/s² **down** (how fast + which way)

> 🧭 **Vector = Size + Direction**

## Vector Notation

Scientists write vectors in special ways:

| Notation | Example | Meaning |
|-----------|----------|----------|
| **Bold** | **F** | F is a vector |
| **Arrow above** | $\vec{v}$ | v is a vector |
| **Arrow** | $\rightarrow$ | Points in direction |

## Drawing Vectors

Vectors are drawn as **arrows**:
- **Arrow length** = magnitude (longer = bigger)
- **Arrow direction** = direction of the quantity

```
Example: Velocity vector
      ↑
      |  10 m/s north
      |
```

## Adding Vectors

When vectors act together, we **add them** (called **resultant**).

### Same Direction
Just add magnitudes: 5 N east + 3 N east = **8 N east**

### Opposite Direction
Subtract: 10 N right - 4 N left = **6 N right**

### Different Directions
Use geometry (head-to-tail method) or trigonometry.

> 💡 **Real Example**: If you row a boat 5 m/s across a river flowing 3 m/s sideways, your actual path is diagonal (vector sum).

---

**Key Terms**:
- **Scalar**: Quantity with magnitude only (mass, temperature, time)
- **Vector**: Quantity with magnitude AND direction (velocity, force)
- **Magnitude**: The size or amount of a quantity
- **Resultant**: The sum of two or more vectors',
  '[
    {
      "question": "Which of these is a scalar quantity?",
      "options": ["Velocity", "Force", "Mass", "Displacement"],
      "correctAnswer": 2,
      "explanation": "Mass is a scalar because it only has magnitude (how much matter). It has no direction."
    },
    {
      "question": "Which of these is a vector quantity?",
      "options": ["Temperature", "Time", "Speed", "Acceleration"],
      "correctAnswer": 3,
      "explanation": "Acceleration is a vector because it has both magnitude (how fast speed changes) and direction (which way)."
    },
    {
      "question": "A car moves 50 km/h north. This describes:",
      "options": ["Speed (scalar)", "Velocity (vector)", "Distance (scalar)", "Time (scalar)"],
      "correctAnswer": 1,
      "explanation": "50 km/h north is velocity because it includes both speed (50 km/h) and direction (north)."
    },
    {
      "question": "What do you get when you add 5 N right and 3 N left?",
      "options": ["8 N right", "2 N right", "8 N left", "2 N left"],
      "correctAnswer": 1,
      "explanation": "5 N right - 3 N left = 2 N right (they partially cancel since they''re opposite)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'introduction-to-physics' LIMIT 1),
  'Accuracy, Precision, and Significant Figures',
  'accuracy-precision-significant-figures',
  4,
  '# Accuracy, Precision, and Significant Figures

When measuring things, two concepts matter: **accuracy** and **precision**.

## Accuracy vs Precision

| **Accuracy** | **Precision** |
|----------------|----------------|
| How close to the **true value** | How **consistent** repeated measurements are |
| "Near the bullseye" | "Tight grouping" |

### Examples

| Scenario | Accurate? | Precise? |
|-----------|--------------|-------------|
| Hits all near bullseye, scattered | ✅ Yes | ❌ No |
| Hits all in same spot, far from bullseye | ❌ No | ✅ Yes |
| Hits all tightly grouped at bullseye | ✅ Yes | ✅ Yes |

```
Target Practice Analogy:
  High precision, low accuracy
     ●●●●

  High accuracy, low precision
  ●   ●   ●

  High accuracy AND precision
     ●●●
```

> 🎯 **Goal**: Be BOTH accurate AND precise!

## Significant Figures (Sig Figs)

**Significant figures** show how precise a measurement is.

### Rules for Counting Sig Figs

1. **Non-zero digits** are always significant
   - 123.4 = **4 sig figs**

2. **Zeros between non-zeros** are significant
   - 101.5 = **4 sig figs**

3. **Leading zeros** are NOT significant
   - 0.0045 = **2 sig figs** (only 4 and 5)

4. **Trailing zeros after decimal** ARE significant
   - 4.50 = **3 sig figs** (shows precision to hundredths)

5. **Trailing zeros without decimal** are ambiguous
   - 4000 = unclear (use scientific notation!)

## Scientific Notation

Write numbers as **coefficient × 10^exponent**:

| Number | Scientific Notation | Sig Figs |
|---------|---------------------|-------------|
| 4,500 | 4.5 × 10³ | 2 |
| 4,500 (precise) | 4.500 × 10³ | 4 |
| 0.00034 | 3.4 × 10⁻⁴ | 2 |

## Calculations with Sig Figs

**Multiplication/Division**: Answer has same sig figs as the **least precise** value.

Example: 2.5 cm × 3.42 cm = **8.6 cm²** (2 sig figs)

**Addition/Subtraction**: Answer has same decimal places as **least precise** value.

Example: 5.123 + 2.3 = **7.4** (one decimal place)

---

**Key Terms**:
- **Accuracy**: Closeness to true value
- **Precision**: Consistency of repeated measurements
- **Significant figures**: Digits that carry meaning about precision
- **Scientific notation**: Writing numbers as coefficient × 10^exponent',
  '[
    {
      "question": "A measurement reads 5.23 cm. How many significant figures?",
      "options": ["2", "3", "4", "5"],
      "correctAnswer": 1,
      "explanation": "5.23 has 3 significant figures: 5, 2, and 3. All non-zero digits are significant."
    },
    {
      "question": "Which shows high precision but low accuracy?",
      "options": ["All hits scattered near bullseye", "All hits tightly grouped far from bullseye", "All hits tightly grouped at bullseye", "Hits spread randomly everywhere"],
      "correctAnswer": 1,
      "explanation": "Tightly grouped hits show precision (consistency), but being far from bullseye means not accurate."
    },
    {
      "question": "How many sig figs in 0.00450?",
      "options": ["2", "3", "5", "6"],
      "correctAnswer": 1,
      "explanation": "0.00450 has 3 sig figs: 4, 5, and the trailing 0. Leading zeros aren''t significant."
    },
    {
      "question": "Calculate 2.5 × 3.42 (with correct sig figs):",
      "options": ["8.55", "8.6", "8.55", "8"],
      "correctAnswer": 1,
      "explanation": "2.5 has 2 sig figs, 3.42 has 3. Answer must have 2 sig figs (least precise): 8.55 rounds to 8.6."
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 2: MOTION AND KINEMATICS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Motion and Kinematics',
  'motion-and-kinematics',
  'Learn about displacement, velocity, acceleration, and the equations that describe motion.',
  2,
  NOW()
);

-- LESSONS FOR CHAPTER 2
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'motion-and-kinematics' LIMIT 1),
  'Displacement and Velocity',
  'displacement-and-velocity',
  1,
  '# Displacement and Velocity

Motion is everywhere - cars driving, balls rolling, planets orbiting. Let''s describe it mathematically!

## Displacement vs Distance

### Distance
**Distance** is how much ground an object covers.
- **Scalar** (magnitude only)
- Always **positive**
- Path-dependent (depends on route)

Example: Walk 10 m east, then 10 m west
**Distance = 20 m** (total ground covered)

### Displacement
**Displacement** is change in position.
- **Vector** (magnitude + direction)
- Can be **positive, negative, or zero**
- Independent of path

Example: Walk 10 m east, then 10 m west
**Displacement = 0 m** (ended where started!)

> 💡 **Key Idea**: Distance = "how far" | Displacement = "how far from start"

## Velocity

**Velocity** is speed **with direction**.

### Speed (Scalar)
$$\text{Speed} = \frac{\text{distance}}{\text{time}}$$

Units: m/s, km/h, mph

### Velocity (Vector)
$$\vec{v} = \frac{\Delta\vec{x}}{\Delta t}$$

Where:
- $\vec{v}$ = velocity
- $\Delta\vec{x}$ = displacement (change in position)
- $\Delta t$ = time interval

Units: m/s **north**, km/h **west**, etc.

## Average vs Instantaneous

| Type | Meaning | Formula |
|-------|----------|----------|
| **Average velocity** | Overall displacement over total time | $\vec{v}_{avg} = \frac{\Delta\vec{x}}{\Delta t}$ |
| **Instantaneous velocity** | Velocity at one exact moment | Speedometer reading |

## Example Problems

### Example 1: Average Velocity
A car travels 150 km east in 2 hours. Find average velocity.

**Given**:
- Displacement: 150 km east
- Time: 2 h

**Solution**:
$$\vec{v}_{avg} = \frac{150\text{ km east}}{2\text{ h}} = \mathbf{75\text{ km/h east}}$$

### Example 2: Displacement from Distance
You walk 5 m north, then 3 m south. Find displacement.

**Solution**:
- Distance = 5 m + 3 m = **8 m**
- Displacement = 5 m north - 3 m south = **2 m north**

> ⚠️ **Remember**: Velocity includes direction! "10 m/s" is speed. "10 m/s north" is velocity.

---

**Key Terms**:
- **Distance**: Total path length (scalar)
- **Displacement**: Change in position (vector)
- **Speed**: Distance/time (scalar)
- **Velocity**: Displacement/time (vector)
- **Average**: Total over entire time interval
- **Instantaneous**: At one specific moment',
  '[
    {
      "question": "What is the difference between speed and velocity?",
      "options": ["They are the same thing", "Speed is a vector, velocity is a scalar", "Speed is scalar, velocity is a vector", "Speed depends on time, velocity doesn''t"],
      "correctAnswer": 2,
      "explanation": "Speed is scalar (magnitude only) while velocity is a vector (magnitude + direction)."
    },
    {
      "question": "If you walk 10 m east then 10 m west, what is your displacement?",
      "options": ["20 m east", "20 m west", "0 m", "10 m"],
      "correctAnswer": 2,
      "explanation": "10 m east + 10 m west = 0 m displacement (you ended where you started). Distance = 20 m though!"
    },
    {
      "question": "A car travels 200 km in 4 hours. What is its average speed?",
      "options": ["40 km/h", "50 km/h", "80 km/h", "800 km/h"],
      "correctAnswer": 1,
      "explanation": "Average speed = distance/time = 200 km / 4 h = 50 km/h."
    },
    {
      "question": "Which quantity is a vector?",
      "options": ["Speed", "Distance", "Velocity", "Time"],
      "correctAnswer": 2,
      "explanation": "Velocity is a vector because it includes both magnitude (speed) and direction."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'motion-and-kinematics' LIMIT 1),
  'Acceleration',
  'acceleration',
  2,
  '# Acceleration

**Acceleration** describes how velocity changes. It''s the rate of change of velocity.

## What is Acceleration?

$$\vec{a} = \frac{\Delta\vec{v}}{\Delta t} = \frac{\vec{v}_f - \vec{v}_i}{t}$$

Where:
- $\vec{a}$ = acceleration
- $\Delta\vec{v}$ = change in velocity
- $\Delta t$ = change in time
- $\vec{v}_f$ = final velocity
- $\vec{v}_i$ = initial velocity

**Units**: m/s² (meters per second squared)

> 💡 **Meaning**: "meters per second... per second" - how much speed changes each second.

## Types of Acceleration

### 1. Positive Acceleration
Velocity increases (speeding up).

Example: Car goes from 0 to 20 m/s in 5 seconds
$\vec{a} = \frac{20 - 0}{5} = \mathbf{+4\text{ m/s}^2}$

### 2. Negative Acceleration (Deceleration)
Velocity decreases (slowing down).

Example: Bike goes from 10 m/s to 0 in 5 seconds
$\vec{a} = \frac{0 - 10}{5} = \mathbf{-2\text{ m/s}^2}$

### 3. Zero Acceleration
Velocity is constant (cruising).

Example: Car at steady 20 m/s for 10 seconds
$\vec{a} = \frac{20 - 20}{10} = \mathbf{0\text{ m/s}^2}$

> ⚠️ **Important**: Acceleration is a **vector** - direction matters!

## Direction of Acceleration

Acceleration can be in different direction than velocity!

| Situation | Velocity Direction | Acceleration | What Happens |
|------------|-------------------|----------------|---------------|
| Speeding up going right | → | → | Velocity increases rightward |
| Slowing down going right | → | ← | Velocity decreases (but still right!) |
| Turning | → | ↑ | Direction changes |

## Example Problem

A car accelerates from rest (0 m/s) to 30 m/s in 6 seconds. Find acceleration.

**Given**:
- $\vec{v}_i = 0$ m/s
- $\vec{v}_f = 30$ m/s
- $t = 6$ s

**Solution**:
$$\vec{a} = \frac{30 - 0}{6} = \mathbf{+5\text{ m/s}^2}$$

The car gains 5 m/s of speed **every second**.

---

**Key Terms**:
- **Acceleration**: Rate of change of velocity
- **Positive acceleration**: Speeding up
- **Deceleration**: Slowing down (negative acceleration)
- **Initial velocity**: Starting speed ($\vec{v}_i$)
- **Final velocity**: Ending speed ($\vec{v}_f$)',
  '[
    {
      "question": "A car goes from 0 to 20 m/s in 4 seconds. What is its acceleration?",
      "options": ["4 m/s²", "5 m/s²", "16 m/s²", "80 m/s²"],
      "correctAnswer": 1,
      "explanation": "a = (v_f - v_i) / t = (20 - 0) / 4 = 5 m/s². The car gains 5 m/s each second."
    },
    {
      "question": "Units of acceleration are:",
      "options": ["m/s", "m/s²", "m²/s", "m·s"],
      "correctAnswer": 1,
      "explanation": "Acceleration units are meters per second squared (m/s²), meaning ''meters per second, per second''."
    },
    {
      "question": "If a car is slowing down, its acceleration is:",
      "options": ["Positive", "Negative", "Zero", "Impossible"],
      "correctAnswer": 1,
      "explanation": "Slowing down means decreasing velocity, which is negative acceleration (also called deceleration)."
    },
    {
      "question": "An object moves at constant 10 m/s. Its acceleration is:",
      "options": ["10 m/s²", "1 m/s²", "0 m/s²", "100 m/s²"],
      "correctAnswer": 2,
      "explanation": "Constant velocity means no change in velocity, so acceleration = 0 m/s²."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'motion-and-kinematics' LIMIT 1),
  'Kinematic Equations',
  'kinematic-equations',
  3,
  '# Kinematic Equations

The **kinematic equations** describe motion with constant acceleration. They relate displacement, velocity, acceleration, and time.

## The Four Kinematic Equations

When acceleration is constant, we can use these powerful equations:

### Equation 1: Velocity-Time
$$\vec{v}_f = \vec{v}_i + \vec{a}t$$

Relates: final velocity, initial velocity, acceleration, time

### Equation 2: Displacement-Time
$$\Delta\vec{x} = \vec{v}_i t + \frac{1}{2}\vec{a}t^2$$

Relates: displacement, initial velocity, time, acceleration

### Equation 3: Velocity-Displacement
$$\vec{v}_f^2 = \vec{v}_i^2 + 2\vec{a}\Delta\vec{x}$$

Relates: final velocity, initial velocity, acceleration, displacement (no time!)

### Equation 4: Average Velocity
$$\Delta\vec{x} = \frac{1}{2}(\vec{v}_i + \vec{v}_f)t$$

Relates: displacement, both velocities, time

## The Variables

| Symbol | Quantity | Typical Units |
|--------|------------|---------------|
| $\vec{v}_i$ | Initial velocity | m/s |
| $\vec{v}_f$ | Final velocity | m/s |
| $\vec{a}$ | Acceleration | m/s² |
| $t$ | Time | s |
| $\Delta\vec{x}$ | Displacement | m |

> 🎯 **Strategy**: Identify which 3 variables you know, then use the equation that relates them!

## Example 1: Find Final Velocity

A car starts at 15 m/s and accelerates at 3 m/s² for 4 seconds. Find final velocity.

**Given**:
- $\vec{v}_i = 15$ m/s
- $\vec{a} = 3$ m/s²
- $t = 4$ s
- $\vec{v}_f = ?$

**Equation**: Use Equation 1 ($\vec{v}_f = \vec{v}_i + \vec{a}t$)

**Solution**:
$$\vec{v}_f = 15 + (3)(4) = 15 + 12 = \mathbf{27\text{ m/s}}$$

## Example 2: Find Displacement

A bike accelerates from rest at 2 m/s² for 5 seconds. How far does it travel?

**Given**:
- $\vec{v}_i = 0$ m/s (rest)
- $\vec{a} = 2$ m/s²
- $t = 5$ s
- $\Delta\vec{x} = ?$

**Equation**: Use Equation 2 ($\Delta\vec{x} = \vec{v}_i t + \frac{1}{2}\vec{a}t^2$)

**Solution**:
$$\Delta\vec{x} = 0(5) + \frac{1}{2}(2)(5^2) = 0 + 25 = \mathbf{25\text{ m}}$$

> ⚠️ **Warning**: These only work for **constant acceleration**!

---

**Key Terms**:
- **Kinematics**: Study of motion without considering forces
- **Constant acceleration**: Acceleration that doesn''t change
- **Initial velocity**: Speed at the start ($\vec{v}_i$)
- **Final velocity**: Speed at the end ($\vec{v}_f$)',
  '[
    {
      "question": "Which kinematic equation relates velocity and time without displacement?",
      "options": ["v_f = v_i + at", "Δx = v_i t + ½at²", "v_f² = v_i² + 2aΔx", "Δx = ½(v_i + v_f)t"],
      "correctAnswer": 0,
      "explanation": "v_f = v_i + at (Equation 1) relates final velocity, initial velocity, acceleration, and time - no displacement involved."
    },
    {
      "question": "A car accelerates from 20 m/s to 30 m/s in 5 seconds. What is its acceleration?",
      "options": ["1 m/s²", "2 m/s²", "5 m/s²", "10 m/s²"],
      "correctAnswer": 1,
      "explanation": "Using v_f = v_i + at: 30 = 20 + a(5), so 10 = 5a, a = 2 m/s²."
    },
    {
      "question": "An object starts from rest and accelerates at 4 m/s² for 3 seconds. How far does it travel?",
      "options": ["6 m", "12 m", "18 m", "36 m"],
      "correctAnswer": 2,
      "explanation": "Using Δx = v_i t + ½at²: Δx = 0(3) + ½(4)(9) = 0 + 18 = 18 m."
    },
    {
      "question": "When can you use kinematic equations?",
      "options": ["For any motion", "Only for constant acceleration", "Only for vertical motion", "Only when time is known"],
      "correctAnswer": 1,
      "explanation": "Kinematic equations only work when acceleration is CONSTANT (doesn''t change during the motion)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'motion-and-kinematics' LIMIT 1),
  'Free Fall and Gravity',
  'free-fall-gravity',
  4,
  '# Free Fall and Gravity

**Free fall** is motion under gravity alone - no air resistance.

## Gravity

All objects near Earth''s surface accelerate downward at:

$$\vec{g} = 9.8\text{ m/s}^2 \approx 10\text{ m/s}^2$$

> 🌍 **Important**: $g$ is ALWAYS directed **downward** (toward Earth center)

## What is Free Fall?

**Free fall** = motion where **only gravity acts**.

Conditions:
- No air resistance
- Only force is gravity

### Myth vs Reality

❌ **Myth**: Heavier objects fall faster
✅ **Reality**: All objects fall at SAME rate (in vacuum!)

Famous experiment: **Apollo astronaut** dropped hammer and feather on Moon - they hit together!

> 💡 **Why same rate?** Gravity accelerates by $g$ regardless of mass!

## Free Fall Equations

Use kinematic equations with $\vec{a} = \vec{g} = -9.8\text{ m/s}^2$ (downward = negative)

### Dropping from Rest

When $\vec{v}_i = 0$:

$$\vec{v}_f = \vec{g}t$$

$$\Delta\vec{y} = \frac{1}{2}\vec{g}t^2$$

Note: We use $\Delta\vec{y}$ (vertical) instead of $\Delta\vec{x}$ (horizontal).

## Example 1: Drop

A ball is dropped from rest. How fast after 3 seconds?

**Given**:
- $\vec{v}_i = 0$ m/s
- $\vec{g} = -9.8$ m/s²
- $t = 3$ s
- $\vec{v}_f = ?$

**Solution**:
$$\vec{v}_f = \vec{g}t = (-9.8)(3) = \mathbf{-29.4\text{ m/s}}$$

(negative means **downward**)

## Example 2: Throw Upward

You throw a ball up at 20 m/s. How high does it go?

**Given**:
- $\vec{v}_i = +20$ m/s (up = positive)
- $\vec{g} = -9.8$ m/s²
- $\vec{v}_f = 0$ m/s (at top, velocity = 0)
- $\Delta\vec{y} = ?$

**Equation**: $\vec{v}_f^2 = \vec{v}_i^2 + 2\vec{g}\Delta\vec{y}$

**Solution**:
$$0 = 20^2 + 2(-9.8)\Delta\vec{y}$$
$$0 = 400 - 19.6\Delta\vec{y}$$
$$19.6\Delta\vec{y} = 400$$
$$\Delta\vec{y} = \mathbf{20.4\text{ m}}$$

> ⚠️ **Air Resistance**: Real falling objects DO have air resistance, which slows them. Free fall is an idealization!

---

**Key Terms**:
- **Free fall**: Motion under gravity only (no air resistance)
- **g**: Gravitational acceleration = 9.8 m/s² downward
- **Vacuum**: Space with no air (all objects fall at same rate)
- **Terminal velocity**: Max speed when air resistance equals gravity',
  '[
    {
      "question": "What is the acceleration due to gravity on Earth?",
      "options": ["9.8 m/s", "9.8 m/s²", "10 m/s", "10 m/s²"],
      "correctAnswer": 1,
      "explanation": "Gravity on Earth is 9.8 m/s² (meters per second squared), directed downward."
    },
    {
      "question": "In free fall (no air resistance), which hits ground first?",
      "options": ["Heavier object", "Lighter object", "Both hit simultaneously", "Depends on shape"],
      "correctAnswer": 2,
      "explanation": "In vacuum (no air resistance), ALL objects fall at the same rate regardless of mass or weight."
    },
    {
      "question": "A ball is dropped from rest. After 2 seconds, its velocity is:",
      "options": ["9.8 m/s down", "19.6 m/s down", "4.9 m/s down", "20 m/s down"],
      "correctAnswer": 1,
      "explanation": "v_f = gt = (-9.8)(2) = -19.6 m/s (negative means downward)."
    },
    {
      "question": "What condition must be met for free fall?",
      "options": ["Object must be heavy", "Object must be dropped, not thrown", "Only gravity acts (no air resistance)", "Object must be round"],
      "correctAnswer": 2,
      "explanation": "Free fall requires ONLY gravity to act. No air resistance or other forces can be present."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'motion-and-kinematics' LIMIT 1),
  'Projectile Motion Basics',
  'projectile-motion-basics',
  5,
  '# Projectile Motion Basics

**Projectile motion** = curved path of an object thrown through air (gravity affects it!).

## What is Projectile Motion?

A **projectile** is any object:
- Thrown, shot, or dropped
- Only gravity acts on it (after launch)
- Moves in a **curved path** (parabola)

Examples: Baseball, cannonball,跳水 diver, thrown keys

## Key Principle

**Horizontal and vertical motion are INDEPENDENT!**

| Component | What Happens | Acceleration? |
|-----------|----------------|----------------|
| **Horizontal** | Constant velocity | NO (ignoring air) |
| **Vertical** | Changed by gravity | YES ($\vec{g} = -9.8\text{ m/s}^2$) |

> 💡 **Amazing**: A dropped bullet and fired bullet hit ground SIMULTANEOUSLY (same height)!

## Analyzing Projectile Motion

### Horizontal Motion
$$\vec{x} = \vec{v}_x t$$

No horizontal acceleration (constant horizontal velocity)

### Vertical Motion
Use free fall equations:
$$\vec{y} = \vec{v}_{yi} t + \frac{1}{2}\vec{g}t^2$$

### Breaking Initial Velocity into Components

$$\vec{v}_x = \vec{v} \cos\theta$$

$$\vec{v}_y = \vec{v} \sin\theta$$

Where $\theta$ is the launch angle.

## Example: Horizontal Launch

A ball rolls off a 1.5 m high table at 3 m/s. How far from table does it land?

**Step 1: Find time to fall (vertical)**
$\vec{v}_{yi} = 0$ (no initial vertical speed)
$\Delta\vec{y} = -1.5$ m (falls down)
$\vec{g} = -9.8$ m/s²

$$\Delta\vec{y} = \vec{v}_{yi} t + \frac{1}{2}\vec{g}t^2$$
$$-1.5 = 0 + \frac{1}{2}(-9.8)t^2$$
$$t = 0.55\text{ s}$$

**Step 2: Find horizontal distance**
$$\vec{x} = \vec{v}_x t = (3)(0.55) = \mathbf{1.65\text{ m}}$$

## Real-World Considerations

- **Air resistance**: Slows projectiles (real bullets don''t go as far as predicted)
- **Spin**: Curveballs, Magnus effect
- **Wind**: Changes trajectory

> ⚠️ **Idealization**: We ignore air resistance in basic projectile problems!

---

**Key Terms**:
- **Projectile**: Object moving through air under gravity only
- **Trajectory**: The curved path of a projectile
- **Parabola**: U-shaped curve of projectile path
- **Components**: Horizontal and vertical parts of motion (independent)',
  '[
    {
      "question": "In projectile motion, what is the horizontal acceleration?",
      "options": ["9.8 m/s²", "-9.8 m/s²", "0 m/s²", "Same as vertical acceleration"],
      "correctAnswer": 2,
      "explanation": "Horizontal acceleration is 0 (no force acts horizontally). Only vertical has gravity (9.8 m/s²)."
    },
    {
      "question": "A ball is thrown horizontally off a cliff. What happens to its horizontal velocity?",
      "options": ["Increases", "Decreases", "Stays constant", "Becomes zero"],
      "correctAnswer": 2,
      "explanation": "With no horizontal acceleration (ignoring air resistance), horizontal velocity stays constant throughout flight."
    },
    {
      "question": "The path of a projectile is called:",
      "options": ["Circle", "Ellipse", "Parabola", "Straight line"],
      "correctAnswer": 2,
      "explanation": "Projectiles follow a parabolic (U-shaped) path due to constant horizontal velocity and accelerating vertical motion."
    },
    {
      "question": "A bullet is fired horizontally from a gun. At the same instant, another bullet is dropped from same height. Which hits ground first?",
      "options": ["Fired bullet", "Dropped bullet", "Both hit simultaneously", "Fired bullet, but only slightly"],
      "correctAnswer": 2,
      "explanation": "Both have same vertical acceleration (g) and initial vertical velocity (0), so they fall together!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 3: FORCES AND NEWTON''S LAWS
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Forces and Newton''s Laws',
  'forces-and-newtons-laws',
  'Understand forces and how they cause motion according to Newton''s three laws.',
  3,
  NOW()
);

-- LESSONS FOR CHAPTER 3
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'What is a Force?',
  'what-is-a-force',
  1,
  '# What is a Force?

A **force** is a push or pull on an object. Forces can make objects move, stop, or change direction.

## Defining Force

**Force** = an interaction that can change an object''s motion

- **Vector** (has magnitude AND direction)
- **Unit**: Newton (N)
- **Symbol**: $\vec{F}$

$$1\text{ N} \approx 0.22\text{ pounds (force)}$$

> 💡 **1 Newton** = about the weight of a small apple!

## Types of Forces

| Force Type | Description | Example |
|-------------|---------------|----------|
| **Contact force** | Objects touching | Push, friction, tension, normal |
| **Non-contact force** | Objects NOT touching | Gravity, magnetism, electric |

## Contact Forces

### Applied Force
Direct push or pull (you pushing a box).

### Normal Force
Perpendicular force from a surface.

Example: Floor pushing up on you

### Friction
Force that **opposes motion** between surfaces.

### Tension
Pulling force through ropes/strings/cables.

## Non-Contact Forces

### Gravity
Pulls objects toward each other.

$$\vec{F}_g = m\vec{g}$$

Weight = force of gravity on you

### Magnetic Force
Push/pull between magnets (or magnetic materials).

### Electric Force
Between charged particles (attract or repel).

## Force Diagrams (Free Body Diagrams)

Draw arrows representing ALL forces on an object:

```
      Normal force (↑)
        ↑
        |
        | ← Applied force
        | Box
        |
        ↓
  Friction (→)
      Weight (↓)
```

> ⚠️ **Rule**: Draw ONLY forces ON the object (not BY the object)!

## Measuring Force

**Spring scale** or **force sensor** measures force in Newtons.

---

**Key Terms**:
- **Force**: Push or pull (vector measured in Newtons)
- **Contact force**: Requires touching (normal, friction, tension)
- **Non-contact force**: Acts at a distance (gravity, magnetic, electric)
- **Free body diagram**: Drawing showing all forces on an object
- **Normal force**: Perpendicular force from surface',
  '[
    {
      "question": "What is the SI unit of force?",
      "options": ["Joule (J)", "Watt (W)", "Newton (N)", "Pound (lb)"],
      "correctAnswer": 2,
      "explanation": "The Newton (N) is the SI unit of force, named after Isaac Newton."
    },
    {
      "question": "Which is a contact force?",
      "options": ["Gravity", "Magnetism", "Friction", "Electric force"],
      "correctAnswer": 2,
      "explanation": "Friction is a contact force because it requires surfaces to touch and rub against each other."
    },
    {
      "question": "Which is a non-contact force?",
      "options": ["Normal force", "Tension", "Applied push", "Gravity"],
      "correctAnswer": 3,
      "explanation": "Gravity acts at a distance (no touching needed), making it a non-contact force."
    },
    {
      "question": "Approximately how much is 1 Newton?",
      "options": ["Weight of a car", "Weight of a small apple", "Weight of a person", "Weight of a textbook"],
      "correctAnswer": 1,
      "explanation": "1 Newton is approximately the weight (force of gravity) on a small apple (about 0.22 lbs or 100 grams)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'Newton''s First Law - Inertia',
  'newtons-first-law-inertia',
  2,
  '# Newton''s First Law - The Law of Inertia

Isaac Newton''s first law describes what happens when forces are balanced.

## Newton''s First Law

**An object at rest stays at rest, and an object in motion stays in motion with the same speed and direction, unless acted upon by an unbalanced force.**

> 🧱 **In simple terms**: Objects keep doing what they''re doing until you make them stop or change.

## Key Concept: Inertia

**Inertia** = resistance to change in motion

| Object | Inertia (More = Harder to change) |
|---------|-------------------------------------|
| Tennis ball | Low (easy to throw/stop) |
| Bowling ball | High (hard to throw/stop) |
| Truck | Very high (hard to start/stop) |

> 💡 **Mass measures inertia**: More mass = more inertia

## Examples of First Law

### 1. Seatbelt

Car suddenly stops → Your body keeps moving (inertia!)
Seatbelt applies force to stop you safely

### 2. Coffee Spill

Car accelerates forward → Coffee spills backward
Coffee was at rest, wants to stay at rest (inertia!)

### 3. Headrest

Car hit from behind → Head snaps back
Head was at rest, wants to stay at rest

### 4. Hammer

Hammer head keeps moving when handle stops
You "set" the hammer by tapping handle

## Balanced vs Unbalanced Forces

| Situation | Forces | Motion |
|-----------|----------|---------|
| **Balanced** | Equal and opposite | No change (constant velocity or rest) |
| **Unbalanced** | NOT equal | Acceleration (change in motion) |

### Example: Book on Table

- **Gravity pulls down** (weight)
- **Table pushes up** (normal force)
- **Forces balanced** → Book stays at rest

### Example: Pushing Box

- **Push right** > **friction left** → Unbalanced
- Box **accelerates right**

> ⚠️ **Common misconception**: Forces are NOT needed to KEEP something moving! Friction stops things, not "laziness" of objects.

---

**Key Terms**:
- **Inertia**: Tendency to resist change in motion
- **Balanced forces**: Equal and opposite, no acceleration
- **Unbalanced force**: Net force causes acceleration
- **Mass**: Measure of inertia (more mass = more inertia)',
  '[
    {
      "question": "Newton''s first law is also called the law of:",
      "options": ["Acceleration", "Inertia", "Action-reaction", "Universal gravitation"],
      "correctAnswer": 1,
      "explanation": "Newton''s first law is called the Law of Inertia - objects resist changes to their motion."
    },
    {
      "question": "Which has more inertia?",
      "options": ["Ping pong ball", "Bowling ball", "Tennis ball", "Baseball"],
      "correctAnswer": 1,
      "explanation": "The bowling ball has more mass, and mass measures inertia. More mass = more inertia = harder to change its motion."
    },
    {
      "question": "A car traveling 60 mph turns off its engine and coasts. Why does it eventually stop?",
      "options": ["Inertia makes it stop", "No forces acting on it", "Friction and air resistance", "Running out of gas"],
      "correctAnswer": 2,
      "explanation": "The car stops because of unbalanced forces: friction and air resistance oppose motion. Inertia makes it WANT to keep going!"
    },
    {
      "question": "A book sits at rest on a table. Are forces acting on it?",
      "options": ["No forces (it''s at rest)", "Only gravity", "Yes - gravity down and normal force up (balanced)", "Yes - only upward force"],
      "correctAnswer": 2,
      "explanation": "Gravity pulls down, table pushes up with equal force. Forces are BALANCED, so no acceleration (stays at rest)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'Newton''s Second Law - F = ma',
  'newtons-second-law-f-ma',
  3,
  '# Newton''s Second Law - F = ma

Newton''s second law explains how force, mass, and acceleration relate.

## Newton''s Second Law

$$\vec{F} = m\vec{a}$$

Where:
- $\vec{F}$ = **net force** (sum of all forces)
- $m$ = **mass** (kg)
- $\vec{a}$ = **acceleration** (m/s²)

> 💡 **In words**: Net force equals mass times acceleration

## What the Law Means

| Quantity | Effect |
|-----------|---------|
| **More force** → More acceleration |
| **More mass** → Less acceleration (harder to accelerate) |
| **Same force, double mass** → Half the acceleration |

## Net Force

**Net force** ($\vec{F}_{net}$) = sum of all forces on an object

$$\vec{F}_{net} = \vec{F}_1 + \vec{F}_2 + \vec{F}_3 + ...$$

Example:
- Push box right with 50 N
- Friction pulls left with 10 N
- **Net force** = 50 N right - 10 N left = **40 N right**

## Example Problems

### Example 1: Find Acceleration

A 5 kg box is pushed with 20 N net force.

**Given**:
- $m = 5$ kg
- $\vec{F}_{net} = 20$ N
- $\vec{a} = ?$

**Solution**:
$$\vec{a} = \frac{\vec{F}_{net}}{m} = \frac{20}{5} = \mathbf{4\text{ m/s}^2}$$

### Example 2: Find Force Needed

A 1000 kg car needs to accelerate at 3 m/s². What force is required?

**Given**:
- $m = 1000$ kg
- $\vec{a} = 3$ m/s²
- $\vec{F}_{net} = ?$

**Solution**:
$$\vec{F}_{net} = m\vec{a} = (1000)(3) = \mathbf{3000\text{ N}}$$

## Unit Check

$$\text{N} = \text{kg} \cdot \frac{\text{m}}{\text{s}^2}$$

> ⚠️ **Important**: $\vec{F}$ is NET force (sum of all forces), not just one force!

## Real Examples

| Situation | Mass | Force | Acceleration |
|------------|--------|--------|-------------|
| Push shopping cart | 30 kg | 60 N | 2 m/s² |
| Push truck | 3000 kg | 6000 N | 2 m/s² |
| Same force, more mass | → | Same | Less acceleration |

---

**Key Terms**:
- **F = ma**: Newton''s second law - net force equals mass times acceleration
- **Net force**: Sum of all forces acting on an object
- **Acceleration**: Change in motion (caused by unbalanced force)
- **Mass**: Amount of matter (resistance to acceleration)',
  '[
    {
      "question": "According to Newton''s second law, if you double the mass but use same force, acceleration:",
      "options": ["Doubles", "Halves", "Stays the same", "Becomes zero"],
      "correctAnswer": 1,
      "explanation": "F = ma, so a = F/m. Doubling m halves a. More mass = harder to accelerate!"
    },
    {
      "question": "A 10 kg box is pushed with 50 N of net force. What is its acceleration?",
      "options": ["5 m/s²", "10 m/s²", "40 m/s²", "500 m/s²"],
      "correctAnswer": 0,
      "explanation": "a = F/m = 50/10 = 5 m/s². The box gains 5 m/s of speed each second."
    },
    {
      "question": "Which requires more force: accelerating 100 kg at 2 m/s² or 50 kg at 5 m/s²?",
      "options": ["100 kg at 2 m/s²", "50 kg at 5 m/s²", "Both require same force", "Cannot determine"],
      "correctAnswer": 2,
      "explanation": "F = ma: Case 1: F = 100 × 2 = 200 N. Case 2: F = 50 × 5 = 250 N. Case 2 needs more force."
    },
    {
      "question": "What unit relationship is correct?",
      "options": ["N = kg/m", "N = kg·m/s", "N = kg·m/s²", "N = kg·s²/m"],
      "correctAnswer": 2,
      "explanation": "Force (N) = mass (kg) × acceleration (m/s²), so N = kg·m/s²."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'Newton''s Third Law - Action-Reaction',
  'newtons-third-law-action-reaction',
  4,
  '# Newton''s Third Law - Action and Reaction

Newton''s third law reveals that forces always come in pairs.

## Newton''s Third Law

**For every action, there is an equal and opposite reaction.**

$$\vec{F}_{action} = -\vec{F}_{reaction}$$

Forces always occur in **pairs**:
- **Action force**: Object A pushes on B
- **Reaction force**: Object B pushes back on A

> 💡 **Key point**: Action and reaction act on DIFFERENT objects (NOT same object!)

## Examples of Action-Reaction Pairs

### 1. Walking

| Action | Reaction |
|---------|-----------|
| Your foot pushes ground backward | Ground pushes your foot forward |

You move forward because of **reaction** force from ground!

### 2. Rocket

| Action | Reaction |
|---------|-----------|
| Rocket pushes gases down | Gases push rocket up |

### 3. Book on Table

| Action | Reaction |
|---------|-----------|
| Book pushes table down | Table pushes book up (normal force) |

### 4. Swimming

| Action | Reaction |
|---------|-----------|
| Hand pushes water backward | Water pushes hand forward |

### 5. Balloon

| Action | Reaction |
|---------|-----------|
| Balloon pushes air out | Air pushes balloon opposite way |

## Common Misconceptions

❌ **Wrong**: "Action and reaction cancel, so nothing moves"
✅ **Right**: They act on DIFFERENT objects, so they DON''T cancel!

Example: You push on a wall:
- **Action**: You push wall
- **Reaction**: Wall pushes you
- **Why no motion?** Wall is anchored (friction with ground balances)

## Forces Always in Pairs

You CANNOT have a single force. Every force has a partner.

```
Person A ← pushes → Person B
         ↑           ↑
    Reaction   Action
   (on A)      (on B)
```

> ⚠️ **Memory trick**: "If you push on the world, the world pushes back on YOU!"

---

**Key Terms**:
- **Action force**: Force one object exerts on another
- **Reaction force**: Equal and opposite force back on first object
- **Force pair**: Two equal and opposite forces acting on different objects
- **Third law**: For every action, there is an equal and opposite reaction',
  '[
    {
      "question": "Newton''s third law states that forces occur in:",
      "options": ["Single", "Triples", "Pairs", "Quadruples"],
      "correctAnswer": 2,
      "explanation": "Forces always occur in pairs - action on one object, equal and opposite reaction on the other object."
    },
    {
      "question": "When you walk, you move forward because of which force?",
      "options": ["Your foot pushing ground", "Ground pushing your foot forward", "Your leg muscles", "Gravity"],
      "correctAnswer": 1,
      "explanation": "Your foot pushes ground backward (action), ground pushes your foot forward (reaction). The reaction force moves you!"
    },
    {
      "question": "Action and reaction forces cancel each other:",
      "options": ["Always", "Sometimes", "Never - they act on different objects", "Only in space"],
      "correctAnswer": 2,
      "explanation": "Action and reaction NEVER cancel because they act on DIFFERENT objects. Only forces on SAME object can cancel."
    },
    {
      "question": "A rocket moves upward because:",
      "options": ["Rocket pushes itself", "Gases push rocket up (reaction)", "Air pushes rocket", "Gravity pulls up"],
      "correctAnswer": 1,
      "explanation": "Rocket pushes gases down (action), gases push rocket up (reaction). The reaction force propels the rocket."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'Types of Forces',
  'types-of-forces',
  5,
  '# Types of Forces

Several important forces appear constantly in physics problems.

## Weight (Force of Gravity)

**Weight** = force of gravity on an object

$$\vec{F}_g = m\vec{g}$$

Where:
- $\vec{F}_g$ = weight (N)
- $m$ = mass (kg)
- $\vec{g} = 9.8$ m/s² (downward)

> ⚠️ **Weight ≠ Mass!** Mass is amount of matter (kg). Weight is force (N).

### Example

A 60 kg person weighs:

$$\vec{F}_g = (60)(9.8) = \mathbf{588\text{ N}}$$

## Normal Force

**Normal force** ($\vec{F}_N$ or just **N**) = perpendicular force from a surface

"Normal" means "perpendicular" in math!

```
      ↑ N (normal force)
      |
      | Box on table
      |
      ↓ F_g (weight)
```

For an object on a **horizontal surface** (not accelerating vertically):

$$\vec{F}_N = \vec{F}_g$$

> 💡 **Why?** Box doesn''t fall through table, so upward N balances downward weight

## Friction

**Friction** ($\vec{F}_f$) = force opposing motion between surfaces

$$\vec{F}_f \leq \mu\vec{F}_N$$

Where:
- $\mu$ (mu) = coefficient of friction (depends on materials)
- $\vec{F}_N$ = normal force

### Types of Friction

| Type | When |
|-------|--------|
| **Static** ($\mu_s$) | Not moving (harder to start) |
| **Kinetic** ($\mu_k$) | Moving (easier to keep moving) |

### Example

A 10 kg box on floor ($\mu_k = 0.3$):

$$\vec{F}_N = \vec{F}_g = (10)(9.8) = 98\text{ N}$$

$$\vec{F}_f = 0.3 \times 98 = \mathbf{29.4\text{ N}}$$

## Tension

**Tension** ($\vec{F}_T$ or **T**) = pulling force in ropes/strings/cables

Tension is **same throughout** a massless, frictionless rope.

```
     T → T → T ← (tension pulls both ways)
     |  Hanging mass
     ↓ F_g
```

For a single hanging mass:

$$\vec{F}_T = \vec{F}_g = m\vec{g}$$

## Applied Force

**Applied force** ($\vec{F}_{app}$) = force you actively exert

Examples:
- Pushing a box
- Pulling a wagon
- Kicking a ball

## Spring Force

**Hooke''s Law**:

$$\vec{F}_s = -k\Delta x$$

Where:
- $\vec{F}_s$ = spring force
- $k$ = spring constant (stiffness)
- $\Delta x$ = stretch distance

> 💡 **Negative sign**: Spring force opposes stretch (restoring force)

---

**Key Terms**:
- **Weight**: Force of gravity on an object ($F_g = mg$)
- **Normal force**: Perpendicular force from surface ($F_N$)
- **Friction**: Force opposing motion ($F_f \leq \mu F_N$)
- **Tension**: Pulling force in rope/cable ($F_T$)
- **Coefficient of friction**: Number representing "roughness" ($\mu$)',
  '[
    {
      "question": "What is the weight of a 70 kg person?",
      "options": ["70 N", "686 N", "9.8 N", "700 N"],
      "correctAnswer": 1,
      "explanation": "Weight = F_g = mg = 70 × 9.8 = 686 N (about 154 lbs)."
    },
    {
      "question": "Why doesn''t a book on a table fall through?",
      "options": ["No gravity on it", "Table applies upward normal force", "Friction holds it", "Books are magnetic"],
      "correctAnswer": 1,
      "explanation": "The table exerts an upward normal force that balances the downward weight, so the book stays in equilibrium."
    },
    {
      "question": "Friction always acts:",
      "options": ["In direction of motion", "Opposite to motion", "Upward", "Downward"],
      "correctAnswer": 1,
      "explanation": "Friction ALWAYS opposes the direction of motion (or attempted motion), creating resistance."
    },
    {
      "question": "In a massless rope supporting a 50 kg hanging mass, the tension is:",
      "options": ["0 N", "50 N", "490 N", "9.8 N"],
      "correctAnswer": 2,
      "explanation": "Tension equals weight: T = mg = 50 × 9.8 = 490 N. The rope pulls up with 490 N to balance weight."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'forces-and-newtons-laws' LIMIT 1),
  'Friction and Applications',
  'friction-and-applications',
  6,
  '# Friction and Applications

Friction is everywhere - it makes cars stop and people walk!

## What is Friction?

**Friction** = force that **opposes motion** between two surfaces in contact

Causes:
- Microscopic "hills and valleys" catch
- Chemical bonds form between surfaces
- Deformation of materials

> 💡 **No friction?** Nothing would stop! You couldn''t walk or hold things.

## Calculating Friction

$$\vec{F}_f = \mu\vec{F}_N$$

Where:
- $\mu$ (mu) = coefficient of friction
- $\vec{F}_N$ = normal force

### Static vs Kinetic Friction

| Type | Symbol | When | Value |
|-------|----------|--------|--------|
| **Static** | $\mu_s$ | Not moving | Higher (harder to start) |
| **Kinetic** | $\mu_k$ | Moving | Lower (easier to keep moving) |

### Example

Box with mass 20 kg, $\mu_s = 0.5$, $\mu_k = 0.3$:

**Normal force**: $\vec{F}_N = \vec{F}_g = (20)(9.8) = 196\text{ N}$

**Static friction max**: $\vec{F}_{f,max} = 0.5 \times 196 = \mathbf{98\text{ N}}$

**Kinetic friction**: $\vec{F}_{f,k} = 0.3 \times 196 = \mathbf{59\text{ N}}$

> 💡 **Why harder to start?** Static friction (98 N) > kinetic friction (59 N)

## Factors Affecting Friction

| Factor | Effect |
|---------|----------|
| **Surface roughness** | More rough = more friction |
| **Mass/weight** | More weight = more friction |
| **Surface area** | Surprisingly, NO effect (for dry friction)! |
| **Lubrication** | Oil/water reduces friction |

## Real-World Applications

### Car Tires
- **Tread patterns** channel away water (reduce hydroplaning)
- **Rubber compound** balances grip and wear

### Climbing
- **Chalk** increases friction on hands
- **Rough shoes** prevent slipping

### Ice Skating
- **Low friction** allows smooth gliding
- **Sharp edges** dig in for control

## Air Resistance (Drag)

**Air resistance** = friction with air (depends on speed)

$$\vec{F}_{drag} \propto v^2$$

Faster = MUCH more drag

| Speed | Drag Force |
|--------|-------------|
| Walking (1 m/s) | Tiny |
| Running (5 m/s) | Noticeable |
| Highway (30 m/s) | HUGE |

> ⚠️ **Terminal velocity**: When drag = weight, you stop accelerating (falling at constant speed)

---

**Key Terms**:
- **Static friction**: Friction when not moving ($\mu_s$)
- **Kinetic friction**: Friction when sliding ($\mu_k$)
- **Coefficient of friction**: Number for surface pair (roughness)
- **Air resistance/drag**: Friction with air (increases with speed)
- **Terminal velocity**: Max falling speed (drag = weight)',
  '[
    {
      "question": "Static friction is generally _____ kinetic friction.",
      "options": ["Less than", "Greater than", "Equal to", "Unrelated to"],
      "correctAnswer": 1,
      "explanation": "Static friction (starting) is greater than kinetic friction (sliding). That''s why it''s harder to start moving!"
    },
    {
      "question": "What factors affect friction force?",
      "options": ["Mass and surface roughness", "Surface area and color", "Temperature only", "Speed and weight"],
      "correctAnswer": 0,
      "explanation": "Friction depends on mass (normal force) and surface roughness (coefficient μ). Surface area doesn''t affect dry friction!"
    },
    {
      "question": "A 50 kg box sits on floor with μ = 0.4. What is friction force?",
      "options": ["20 N", "50 N", "196 N", "490 N"],
      "correctAnswer": 2,
      "explanation": "F_f = μF_N = μmg = 0.4 × 50 × 9.8 = 196 N."
    },
    {
      "question": "Why do parachutes work?",
      "options": ["Reduce gravity", "Increase air resistance (drag)", "Reduce weight", "Create lift"],
      "correctAnswer": 1,
      "explanation": "Parachutes increase air resistance (drag force), slowing descent to safe terminal velocity."
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 4: WORK AND ENERGY
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Work and Energy',
  'work-and-energy',
  'Learn about work, kinetic energy, potential energy, and conservation of energy.',
  4,
  NOW()
);

-- LESSONS FOR CHAPTER 4
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'work-and-energy' LIMIT 1),
  'What is Work?',
  'what-is-work',
  1,
  '# What is Work?

In everyday language, "work" means effort. In physics, it has a specific meaning!

## Defining Work

**Work** = force × displacement IN SAME DIRECTION

$$W = \vec{F} \cdot \Delta\vec{x} \cdot \cos\theta$$

Where:
- $W$ = work (Joules, J)
- $\vec{F}$ = applied force (N)
- $\Delta\vec{x}$ = displacement (m)
- $\theta$ = angle between force and displacement

> ⚠️ **Key**: If force is perpendicular to motion, NO work is done!

## When is Work Done?

| Situation | Work Done? | Why |
|-----------|--------------|-------|
| Pushing a box across floor | ✅ Yes | Force and displacement same direction |
| Lifting a weight upward | ✅ Yes | Force and displacement same direction |
| Carrying heavy box horizontally | ❌ No | Force up, displacement horizontal (θ = 90°) |
| Pushing on a wall (doesn''t move) | ❌ No | No displacement (Δx = 0) |

## Units of Work

$$1\text{ Joule (J)} = 1\text{ N} \cdot \text{m}$$

Named after **James Prescott Joule**.

### Examples

- Lifting 1 N by 1 m = **1 J**
- Lifting 100 N by 2 m = **200 J**
- Pushing with 10 N over 5 m = **50 J**

## Example Problem

You pull a box with 50 N force at 30° above horizontal. The box moves 10 m. How much work?

**Given**:
- $\vec{F} = 50$ N
- $\Delta\vec{x} = 10$ m
- $\theta = 30$°

**Solution**:
$$W = (50)(10)\cos(30°) = 500(0.866) = \mathbf{433\text{ J}}$$

> 💡 **Negative work**: Force opposing motion (friction) does NEGATIVE work on object!

---

**Key Terms**:
- **Work**: Force × displacement in same direction (measured in Joules)
- **Joule**: SI unit of work (1 N·m = 1 J)
- **Cosine factor**: Only component of force in displacement direction does work
- **Negative work**: Work done by opposing force (friction)',
  '[
    {
      "question": "Work is done only when:",
      "options": ["A force is applied", "Force causes displacement in same direction", "Any force acts on object", "Object moves in any direction"],
      "correctAnswer": 1,
      "explanation": "Work requires BOTH force AND displacement in same direction. If force ⟂ motion, no work is done."
    },
    {
      "question": "A waiter carries a tray horizontally. Is he doing work on the tray?",
      "options": ["Yes, he''s exerting force", "No, force is vertical but motion is horizontal", "Yes, gravity does work", "Depends on tray weight"],
      "correctAnswer": 1,
      "explanation": "No work is done because the upward force is perpendicular to horizontal displacement (θ = 90°, cos90° = 0)."
    },
    {
      "question": "What is the SI unit of work?",
      "options": ["Newton (N)", "Watt (W)", "Joule (J)", "Pound-foot (lb·ft)"],
      "correctAnswer": 2,
      "explanation": "The Joule (J) is the SI unit of work, equal to 1 Newton-meter (N·m)."
    },
    {
      "question": "You push with 100 N over 5 m. How much work?",
      "options": ["20 J", "100 J", "500 J", "5000 J"],
      "correctAnswer": 2,
      "explanation": "W = F×d = 100 × 5 = 500 J of work."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'work-and-energy' LIMIT 1),
  'Kinetic Energy',
  'kinetic-energy',
  2,
  '# Kinetic Energy

**Kinetic energy (KE)** is energy of motion.

## What is Kinetic Energy?

**Kinetic energy** = energy an object has due to its motion

$$KE = \frac{1}{2}mv^2$$

Where:
- $KE$ = kinetic energy (Joules, J)
- $m$ = mass (kg)
- $v$ = velocity (m/s)

> 💡 **Key Point**: Velocity is SQUARED! Double speed = 4× energy!

## Kinetic Energy Depends On...

| Factor | Effect on KE |
|---------|---------------|
| **Mass** (linear) | Double mass = double KE |
| **Velocity** (squared!) | Double velocity = 4× KE |

### Example

| Object | Mass | Velocity | KE |
|---------|--------|----------|-----|
| Tennis ball (serving) | 0.06 kg | 50 m/s | 75 J |
| Baseball (pitched) | 0.15 kg | 40 m/s | 120 J |
| Car (highway) | 1500 kg | 30 m/s | 675,000 J |

$$KE_{car} = \frac{1}{2}(1500)(30^2) = 675,\!000\text{ J}$$

## Work-Energy Theorem

**Net work** on an object equals its **change in kinetic energy**.

$$W_{net} = \Delta KE = \frac{1}{2}mv_f^2 - \frac{1}{2}mv_i^2$$

### Example

A 1000 kg car accelerates from 20 m/s to 30 m/s. How much work was done?

**Given**:
- $m = 1000$ kg
- $\vec{v}_i = 20$ m/s
- $\vec{v}_f = 30$ m/s

**Solution**:
$$W = \frac{1}{2}(1000)(30^2) - \frac{1}{2}(1000)(20^2)$$
$$W = 450,\!000 - 200,\!000 = \mathbf{250,\!000\text{ J}}$$

> ⚠️ **Braking**: Negative work removes KE (car slows down)!

---

**Key Terms**:
- **Kinetic energy**: Energy of motion ($KE = \frac{1}{2}mv^2$)
- **Work-energy theorem**: Net work equals change in KE ($W_{net} = \Delta KE$)
- **Joule**: SI unit of energy
- **Velocity squared**: KE depends on v² (doubling speed = 4× KE)',
  '[
    {
      "question": "Kinetic energy depends on:",
      "options": ["Mass and velocity", "Mass only", "Velocity only", "Position and height"],
      "correctAnswer": 0,
      "explanation": "KE = ½mv² depends on BOTH mass (linearly) and velocity (squared - so more important!)"
    },
    {
      "question": "If you double a car''s speed, its kinetic energy:",
      "options": ["Doubles", "Triples", "Quadruples", "Stays the same"],
      "correctAnswer": 2,
      "explanation": "Since KE ∝ v², doubling velocity increases KE by 4× (quadruples)."
    },
    {
      "question": "A 1000 kg car moves at 20 m/s. What is its KE?",
      "options": ["10,000 J", "20,000 J", "200,000 J", "400,000 J"],
      "correctAnswer": 3,
      "explanation": "KE = ½mv² = ½(1000)(20²) = 500 × 400 = 200,000 J."
    },
    {
      "question": "What happens to KE when car brakes from 30 m/s to 0 m/s?",
      "options": ["Increases", "Decreases to zero", "Stays constant", "Becomes negative"],
      "correctAnswer": 1,
      "explanation": "When velocity goes to zero, all kinetic energy is removed (negative work done by brakes)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'work-and-energy' LIMIT 1),
  'Potential Energy',
  'potential-energy',
  3,
  '# Potential Energy

**Potential energy (PE)** is stored energy due to position.

## What is Potential Energy?

**Potential energy** = stored energy that CAN become kinetic

Types:
- **Gravitational**: Due to height in gravity field
- **Elastic**: Due to stretched/compressed springs
- **Chemical**: Stored in molecular bonds

## Gravitational Potential Energy

$$PE_g = mgh$$

Where:
- $PE_g$ = gravitational PE (Joules)
- $m$ = mass (kg)
- $g$ = gravitational acceleration (9. m/s²)
- $h$ = height above reference level (m)

> 💡 **Reference level**: PE depends on WHERE you set h = 0!

### Example: Diver

| Position | Height (m) | PE (for 70 kg diver) |
|-----------|-------------|------------------------|
| Top platform | 10 | 70 × 9.8 × 10 = 6,860 J |
| Mid-air | 5 | 70 × 9.8 × 5 = 3,430 J |
| Water surface | 0 | 0 J (reference level) |

> 📊 **PE → KE conversion**: As diver falls, PE becomes KE!

## Elastic Potential Energy

Springs store energy when stretched or compressed!

$$PE_{spring} = \frac{1}{2}kx^2$$

Where:
- $PE_{spring}$ = elastic PE (J)
- $k$ = spring constant (N/m) - stiffness!
- $x$ = displacement from equilibrium (m)

### Stiff vs Loose Springs

| Spring | k Value | Meaning |
|---------|---------|---------|
| **Stiff** | High k | Harder to stretch, stores more energy |
| **Loose** | Low k | Easier to stretch, less energy |

## Example Problems

### Example 1: Gravitational PE

A 5 kg book is on a 2 m high shelf. What is its PE?

$$PE_g = (5)(9.8)(2) = \mathbf{98\text{ J}}$$

### Example 2: Spring

A spring (k = 200 N/m) is stretched 0.3 m. What is its PE?

$$PE_{spring} = \frac{1}{2}(200)(0.3)^2 = 100(0.09) = \mathbf{9\text{ J}}$$

---

**Key Terms**:
- **Potential energy**: Stored energy due to position ($PE_g = mgh$ for gravitational)
- **Gravitational PE**: Energy from height in gravity field
- **Elastic PE**: Energy in stretched/compressed spring ($PE_s = ½kx²$)
- **Spring constant (k)**: Measure of spring stiffness (N/m)
- **Reference level**: Where you define h = 0 (PE = 0)',
  '[
    {
      "question": "Gravitational potential energy depends on:",
      "options": ["Mass only", "Mass, height, and gravity", "Height and velocity", "Gravity only"],
      "correctAnswer": 1,
      "explanation": "PE_g = mgh depends on mass (m), height (h), and gravitational acceleration (g)."
    },
    {
      "question": "A 10 kg object is at 5 m height. What is its gravitational PE?",
      "options": ["49 J", "98 J", "245 J", "490 J"],
      "correctAnswer": 3,
      "explanation": "PE = mgh = 10 × 9.8 × 5 = 490 J of stored energy."
    },
    {
      "question": "Where is potential energy ZERO?",
      "options": ["On the ground", "At the reference level (where h = 0)", "In outer space", "When velocity is zero"],
      "correctAnswer": 1,
      "explanation": "PE = mgh, so PE = 0 wherever you define h = 0 (reference level). You choose this!"
    },
    {
      "question": "A stiffer spring (higher k) stretched the same amount has:",
      "options": ["Less PE", "Same PE", "More PE", "Cannot determine"],
      "correctAnswer": 2,
      "explanation": "PE_spring = ½kx², so higher k (stiffer) means more stored energy."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'work-and-energy' LIMIT 1),
  'Conservation of Energy',
  'conservation-of-energy',
  4,
  '# Conservation of Energy

Energy cannot be created or destroyed - only transformed!

## The Law of Conservation of Energy

**Total mechanical energy** of an isolated system remains constant.

$$E_{total} = KE + PE = \text{constant}$$

Where:
- $KE$ = kinetic energy
- $PE$ = potential energy
- $E_{total}$ = total mechanical energy

> 💡 **Key insight**: Energy changes FORM but not AMOUNT!

## Energy Transformations

### Falling Object

| Position | KE | PE | Total |
|-----------|-----|-----|--------|
| Top (height h) | 0 | mgh | mgh |
| Mid-fall | ½mv² | Decreasing | ½mv² + PE | mgh (constant!) |
| Just before impact | Maximum | 0 | mgh | mgh |

Energy shifts from PE → KE, but **sum stays constant**!

### Pendulum

```
    Top (max height):     PE max, KE = 0
           ↘
         ↙  ↘
        (swinging)       KE increases, PE decreases
         ↙  ↘
           ↘
    Bottom (lowest):      KE max, PE = 0
```

## Example: Roller Coaster

A 500 kg cart starts from rest at 20 m height. What is its speed at bottom (h = 0)?

**Top (h = 20 m)**:
$$PE_i = (500)(9.8)(20) = 98,\!000\text{ J}$$
$$KE_i = 0\text{ J}$$

**Bottom (h = 0 m)**:
$$PE_f = 0\text{ J}$$

**Conservation**:
$$KE_i + PE_i = KE_f + PE_f$$
$$0 + 98,\!000 = KE_f + 0$$

$$KE_f = \frac{1}{2}(500)v_f^2 = 98,\!000$$

$$250v_f^2 = 98,\!000$$

$$v_f^2 = 392$$

$$v_f = \mathbf{19.8\text{ m/s}}$$

> ⚠️ **With friction**: Total energy decreases (some becomes heat/sound)!

---

**Key Terms**:
- **Conservation of energy**: Energy cannot be created/destroyed, only transformed
- **Mechanical energy**: Sum of KE + PE (constant without friction)
- **Isolated system**: No external energy enters or leaves
- **Dissipation**: Energy lost to friction (becomes heat)',
  '[
    {
      "question": "The law of conservation of energy states that energy:",
      "options": ["Can be created but not destroyed", "Cannot be created or destroyed, only transformed", "Is always lost over time", "Comes from nothing"],
      "correctAnswer": 1,
      "explanation": "Energy cannot be created or destroyed, only changed from one form to another (like PE to KE)."
    },
    {
      "question": "A ball at the top of its trajectory has:",
      "options": ["Maximum KE, zero PE", "Zero KE, maximum PE", "Equal KE and PE", "Zero total energy"],
      "correctAnswer": 1,
      "explanation": "At the top (highest point), velocity = 0 so KE = 0, but height = max so PE = maximum."
    },
    {
      "question": "As a pendulum swings downward, what happens to its energy?",
      "options": ["KE increases, PE decreases, total stays same", "PE increases, KE decreases", "Both KE and PE increase", "Total energy decreases"],
      "correctAnswer": 0,
      "explanation": "As PE converts to KE, PE decreases and KE increases, but total mechanical energy stays constant!"
    },
    {
      "question": "In a real system with friction, total mechanical energy:",
      "options": ["Increases", "Stays constant", "Decreases over time", "Becomes zero"],
      "correctAnswer": 2,
      "explanation": "Friction dissipates mechanical energy as heat, so total mechanical energy decreases (not lost, just transformed)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'work-and-energy' LIMIT 1),
  'Power',
  'power',
  5,
  '# Power

**Power** is how FAST work is done or energy is transferred.

## What is Power?

**Power** = rate of doing work or transferring energy

$$P = \frac{W}{t} = \frac{\Delta E}{t}$$

Where:
- $P$ = power (Watts, W)
- $W$ = work (Joules, J)
- $t$ = time (seconds, s)
- $\Delta E$ = energy change (J)

> 💡 **Unit named after**: James Watt (steam engine inventor)!

## Units of Power

$$1\text{ Watt (W)} = 1\text{ Joule/second (J/s)}$$

### Prefixes

| Prefix | Power | Example |
|---------|---------|----------|
| **kilowatt** (kW) | 1000 W | Microwave |
| **megawatt** (MW) | 1,000,000 W | Power plant |
| **gigawatt** (GW) | 1,000,000,000 W | Large countries |

## Power vs Work

| Concept | Meaning |
|---------|----------|
| **Work** | Total energy transferred (J) |
| **Power** | How FAST energy is transferred (J/s = W) |

### Examples

| Device | Work in 1 min | Power |
|---------|---------------|---------|
| Light bulb (60 W) | 3600 J | 60 J/s |
| Hair dryer (1200 W) | 72,000 J | 1200 J/s |
| Horse (1 hp) | 447,000 J | 746 W |

> 💡 **1 horsepower** ≈ 746 Watts!

## Calculating Power

### Example 1: Lifting

You lift a 50 kg box 2 m in 5 seconds. What is your power output?

**Work**:
$$W = \Delta PE = mgh = (50)(9.8)(2) = 980\text{ J}$$

**Power**:
$$P = \frac{W}{t} = \frac{980}{5} = \mathbf{196\text{ W}}$$

### Example 2: Car Acceleration

A 1000 kg car accelerates from 0 to 20 m/s in 10 seconds. What is average power?

**Work** (from KE change):
$$W = \Delta KE = \frac{1}{2}(1000)(20^2) - 0 = 200,\!000\text{ J}$$

**Power**:
$$P = \frac{200,\!000}{10} = \mathbf{20,\!000\text{ W}} = \mathbf{20\text{ kW}}$$

---

**Key Terms**:
- **Power**: Rate of doing work ($P = W/t$ in Watts)
- **Watt**: SI unit of power (1 J/s)
- **Horsepower**: Older unit, 1 hp ≈ 746 W
- **Power vs Work**: Power is RATE (how fast), work is TOTAL (amount)',
  '[
    {
      "question": "What is the SI unit of power?",
      "options": ["Joule (J)", "Newton (N)", "Watt (W)", "Horsepower (hp)"],
      "correctAnswer": 2,
      "explanation": "The Watt (W) is the SI unit of power, equal to 1 Joule per second (J/s)."
    },
    {
      "question": "Power measures:",
      "options": ["Total work done", "Rate of doing work", "Force applied", "Energy stored"],
      "correctAnswer": 1,
      "explanation": "Power is HOW FAST work is done (work per time), not the total amount of work."
    },
    {
      "question": "A 60 W light bulb left on for 2 minutes. How much energy does it use?",
      "options": ["30 J", "120 J", "7200 J", "7200 W"],
      "correctAnswer": 2,
      "explanation": "Energy = Power × time = 60 × 120 = 7200 J (remember: 2 minutes = 120 seconds)."
    },
    {
      "question": "If you do same work in half the time, your power:",
      "options": ["Halves", "Doubles", "Stays the same", "Becomes zero"],
      "correctAnswer": 1,
      "explanation": "P = W/t. Same W, half t means 2× the power output!"
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 5: MOMENTUM
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Momentum',
  'momentum',
  'Learn about momentum, conservation of momentum, impulse, and collisions.',
  5,
  NOW()
);

-- LESSONS FOR CHAPTER 5
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'momentum' LIMIT 1),
  'What is Momentum?',
  'what-is-momentum',
  1,
  '# What is Momentum?

**Momentum** = measure of how hard it is to stop something!

## Defining Momentum

$$\vec{p} = m\vec{v}$$

Where:
- $\vec{p}$ = momentum (kg·m/s)
- $m$ = mass (kg)
- $\vec{v}$ = velocity (m/s)

> 💡 **"Motion quantity"**: Momentum combines mass AND velocity!

## Why is Momentum Important?

Momentum tells us:
- How hard to STOP (more momentum = harder)
- How much "oomph" a moving object has
- What happens in collisions

### Examples

| Object | Mass | Velocity | Momentum |
|---------|--------|----------|-----------|
| Bullet | 0.01 kg | 500 m/s | 5 kg·m/s |
| Truck | 10,000 kg | 10 m/s | 100,000 kg·m/s |
| Baseball pitch | 0.15 kg | 40 m/s | 6 kg·m/s |

> ⚠️ **Truck vs bullet**: Truck has 100× momentum of bullet despite being 200× slower!

## Momentum and Mass/Velocity

| Change | Effect on $\vec{p}$ |
|---------|---------------|
| **Double mass** → 2× momentum |
| **Double velocity** → 2× momentum |
| **Double BOTH** → 4× momentum! |

> 💡 **Safety**: Crumple zones in cars extend stopping time (reduce force, not momentum!)

## Vector Nature

Momentum is a **vector** - direction matters!

$$\vec{p} = m\vec{v}$$

A 5 kg ball moving right at 10 m/s:
$$\vec{p} = (5)(\text{right }10) = 50\text{ kg·m/s right}$$

Same ball moving LEFT at 10 m/s:
$$\vec{p} = (5)(\text{left }10) = 50\text{ kg·m/s left}$$

> ⚠️ **Different momenta** (different directions = NOT equal!)!

---

**Key Terms**:
- **Momentum**: "Motion quantity" = mass × velocity ($\vec{p} = m\vec{v}$)
- **kg·m/s**: Units of momentum (kilogram-meters per second)
- **Conservation**: In isolated system, total momentum stays constant',
  '[
    {
      "question": "Momentum equals:",
      "options": ["Mass divided by velocity", "Mass times velocity", "Mass plus velocity", "Velocity divided by mass"],
      "correctAnswer": 1,
      "explanation": "Momentum p = mv (mass times velocity), in units of kg·m/s."
    },
    {
      "question": "A 1000 kg car moves at 20 m/s. What is its momentum?",
      "options": ["20 kg·m/s", "200 kg·m/s", "20,000 kg·m/s", "400,000 kg·m/s"],
      "correctAnswer": 2,
      "explanation": "p = mv = 1000 × 20 = 20,000 kg·m/s."
    },
    {
      "question": "If you double mass and halve velocity, momentum:",
      "options": ["Doubles", "Halves", "Stays the same", "Quadruples"],
      "correctAnswer": 2,
      "explanation": "New p = (2m)(0.5v) = mv. Momentum stays the same!"
    },
    {
      "question": "Why is a bullet dangerous despite having less momentum than a slow truck?",
      "options": ["Bullet moves faster", "Truck has less mass", "Momentum doesn''t matter", "Bullet is sharper"],
      "correctAnswer": 0,
      "explanation": "Actually a 5 kg·m/s bullet has LESS momentum than 100,000 kg·m/s truck. A bullet is dangerous due to CONCENTRATED force on small area, not momentum!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'momentum' LIMIT 1),
  'Conservation of Momentum',
  'conservation-of-momentum',
  2,
  '# Conservation of Momentum

In an isolated system, **total momentum never changes**!

## The Law of Conservation of Momentum

$$\vec{p}_{total, initial} = \vec{p}_{total, final}$$

$$\sum m_i\vec{v}_i = \sum m_f\vec{v}_f$$

**Key point**: Momentum is transferred, NOT lost!

> 💡 **"Isolated"**: No external forces (like friction) act on system

## Examples of Conservation

### 1. Ice Skater Push-Off

Two skaters at rest push off each other:

- Skater A: 50 kg, moves at 2 m/s right
- Skater B: 70 kg, moves at ? m/s left

**Before push**:
$$\vec{p}_i = 0 + 0 = 0$$

**After push**:
$$\vec{p}_f = (50)(2) + (70)(-v_B)$$

Since $\vec{p}_f = \vec{p}_i$:
$$100 - 70v_B = 0$$

$$v_B = \mathbf{1.43\text{ m/s left}}$$

### 2. Recoil

Cannon fires a 10 kg shell at 200 m/s. Cannon mass = 500 kg. What is recoil velocity?

**Before**:
$$\vec{p}_i = 0$$

**After**:
$$(500 + 10)\text{ at }200\text{ m/s (forward)} = (500)\vec{v}_{cannon} + (10)(200)$$

Solving for cannon recoil:
$$\vec{v}_{cannon} = \mathbf{-4\text{ m/s}} \text{ (backward)}$$

### 3. Collisions

Before collision, total momentum = after collision!

## Types of Systems

| System Type | Momentum? |
|-------------|-------------|
| **Isolated** (no external forces) | Conserved |
| **Open** (external forces act) | Not conserved (friction changes p) |

> ⚠️ **Real world**: True isolation is rare (friction usually exists)!

---

**Key Terms**:
- **Conservation of momentum**: Total momentum in isolated system stays constant
- **Isolated system**: No external forces act (momentum conserved)
- **Open system**: External forces present (momentum changes)
- **Recoil**: Backward motion from firing forward (conservation!)',
  '[
    {
      "question": "Momentum is conserved in:",
      "options": ["All situations", "Isolated systems (no external forces)", "Only when objects stick together", "Only in space"],
      "correctAnswer": 1,
      "explanation": "Momentum is conserved only in ISOLATED systems with no external forces acting. Friction or gravity can change total momentum."
    },
    {
      "question": "Two ice skaters push off from rest. If one has twice the mass, she moves:",
      "options": ["Twice as fast", "Half as fast", "Same speed", "Four times as fast"],
      "correctAnswer": 1,
      "explanation": "p_i = 0, so p_f = 0. m₁v₁ + m₂v₂ = 0. If m₂ = 2m₁, then v₂ = v₁/2 (half as fast)."
    },
    {
      "question": "A 500 kg cannon fires a 10 kg shell at 200 m/s. Recoil velocity is:",
      "options": ["0.4 m/s", "4 m/s", "40 m/s", "400 m/s"],
      "correctAnswer": 1,
      "explanation": "Conservation: p_i = p_f, so 0 = 500v_c + 10(200), v_c = -2000/500 = -4 m/s (negative = backward)."
    },
    {
      "question": "Why is momentum NOT conserved during a car crash?",
      "options": ["Math is wrong", "Gravity acts", "External friction force acts", "Momentum doesn''t exist in crashes"],
      "correctAnswer": 2,
      "explanation": "External friction forces act during the crash, changing total momentum. Conservation requires isolated system (no external forces)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'momentum' LIMIT 1),
  'Impulse',
  'impulse',
  3,
  '# Impulse

**Impulse** = change in momentum, caused by force over time.

## What is Impulse?

**Impulse** = product of force and time

$$\vec{J} = \vec{F}\Delta t = \Delta\vec{p} = m\Delta\vec{v}$$

Where:
- $\vec{J}$ = impulse (N·s)
- $\vec{F}$ = average force (N)
- $\Delta t$ = time interval (s)
- $\Delta\vec{p}$ = change in momentum

> 💡 **Same units**: N·s (force·time) = kg·m/s (momentum)!

## Impulse-Momentum Theorem

**Impulse equals change in momentum!**

$$\vec{J} = \Delta\vec{p} = m(\vec{v}_f - \vec{v}_i)$$

### Example 1: Bat Hitting Ball

A 0.15 kg baseball approaches at 30 m/s. Bat hits it with 500 N force for 0.002 s. Final speed = 40 m/s opposite direction.

**Impulse**:
$$\vec{J} = (500)(0.002) = \mathbf{1\text{ N·s}}$$

**Momentum change**:
$$\Delta\vec{p} = 0.15(40 - (-30)) = 0.15(70) = \mathbf{10.5\text{ kg·m/s}}$$

### Example 2: Catching a Ball

You catch a 0.6 kg ball moving at 20 m/s in 0.1 s. What force does your hand exert?

**Momentum change**:
$$\Delta\vec{p} = 0.6(0 - 20) = -12\text{ kg·m/s}$$

**Force**:
$$\vec{F} = \frac{\Delta\vec{p}}{\Delta t} = \frac{-12}{0.1} = \mathbf{-120\text{ N}}$$

(Negative means your hand pushed opposite to motion to stop it)

## Increasing Impact Time

$$\vec{J} = \vec{F}\Delta t$$

For a given momentum change:
- **Large $\Delta t$** → Small force (gentle)
- **Small $\Delta t$** → Large force (painful!)

> 💡 **Safety**: Airbags, padding, flexing knees EXTEND stopping time!

## Real-World Applications

| Application | How Impulse Helps |
|-------------|-------------------|
| **Crumple zones** | Extend collision time → reduce force |
| **Airbags** | Increase stopping time for head |
| **Follow-through** | Bat stays in contact longer → more impulse |
| **Catching with body** | Give with hands (more time) vs stiff arms |

---

**Key Terms**:
- **Impulse**: Force × time ($\vec{J} = \vec{F}\Delta t$)
- **Impulse-momentum theorem**: Impulse equals change in momentum ($\vec{J} = \Delta\vec{p}$)
- **Impact time**: Duration of collision (longer time = less force)',
  '[
    {
      "question": "Impulse equals:",
      "options": ["Force divided by time", "Force times time", "Force times acceleration", "Mass times velocity change"],
      "correctAnswer": 1,
      "explanation": "Impulse J = FΔt (force multiplied by time), in units of N·s."
    },
    {
      "question": "To reduce force during a collision, you should:",
      "options": ["Decrease impact time", "Increase impact time", "Decrease mass", "Increase velocity"],
      "correctAnswer": 1,
      "explanation": "Since J = FΔt, increasing Δt (impact time) reduces F for same momentum change. Airbags and padding do this!"
    },
    {
      "question": "A 0.5 kg object changes velocity from 10 m/s to 20 m/s in 2 seconds. What was the impulse?",
      "options": ["5 N·s", "10 N·s", "15 N·s", "20 N·s"],
      "correctAnswer": 0,
      "explanation": "J = Δp = m(v_f - v_i) = 0.5(20 - 10) = 5 kg·m/s = 5 N·s."
    },
    {
      "question": "Which has same units as momentum?",
      "options": ["Force (N)", "Energy (J)", "Power (W)", "Impulse (N·s)"],
      "correctAnswer": 3,
      "explanation": "Impulse units are N·s, which simplifies to kg·m/s - same as momentum!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'momentum' LIMIT 1),
  'Collisions',
  'collisions',
  4,
  '# Collisions

When objects collide, momentum is transferred between them!

## Types of Collisions

| Type | Definition | KE Conserved? |
|-------|-------------|----------------|
| **Elastic** | Objects bounce, no energy loss | ✅ Yes |
| **Inelastic** | Objects stick/deform, KE becomes heat/sound | ❌ No |
| **Perfectly inelastic** | Maximum KE lost (stick together) | ❌ No |

> 💡 **Spectrum**: Real collisions are somewhere between!

## Elastic Collisions

**Both momentum AND kinetic energy are conserved.**

$$\sum \vec{p}_i = \sum \vec{p}_f$$

$$\sum KE_i = \sum KE_f$$

### Example: Billiard Balls

Ball A (1 kg at 3 m/s) hits Ball B (1 kg at rest). After collision, Ball A stops, B moves at 3 m/s.

**Before**:
$$\vec{p}_i = (1)(3) + 0 = 3\text{ kg·m/s}$$

$$KE_i = \frac{1}{2}(1)(3)^2 + 0 = 4.5\text{ J}$$

**After**:
$$\vec{p}_f = 0 + (1)(3) = 3\text{ kg·m/s}$$ ✓

$$KE_f = 0 + \frac{1}{2}(1)(3)^2 = 4.5\text{ J}$$ ✓

**Momentum AND energy conserved!**

## Inelastic Collisions

**Only momentum is conserved** - KE becomes heat/sound/deformation.

$$\sum \vec{p}_i = \sum \vec{p}_f \quad \text{BUT } \quad \sum KE_i > \sum KE_f$$

### Example: Car Crash

A 1000 kg car at 20 m/s rear-ends a 1500 kg truck at rest. They stick together.

**Before**:
$$\vec{p}_i = (1000)(20) + 0 = 20,\!000\text{ kg·m/s}$$

$$KE_i = \frac{1}{2}(1000)(20^2) + 0 = 200,\!000\text{ J}$$

**After** (they stick):
$$20,\!000 = (1000 + 1500)\vec{v}_f$$

$$\vec{v}_f = 8\text{ m/s}$$

$$KE_f = \frac{1}{2}(2500)(8^2) = 80,\!000\text{ J}$$

**Lost to deformation/heat**:
$$200,\!000 - 80,\!000 = \mathbf{120,\!000\text{ J lost}}$$

> ⚠️ **Seatbelts**: Don''t prevent crash, just keep you in car to benefit from slowing time!

## Perfectly Inelastic

Maximum KE loss, objects stick together.

$$\vec{v}_f = \frac{m_1\vec{v}_{1i} + m_2\vec{v}_{2i}}{m_1 + m_2}$$

---

**Key Terms**:
- **Elastic collision**: Bouncing, no KE lost (p and KE conserved)
- **Inelastic collision**: Objects stick/deform, KE lost (only p conserved)
- **Perfectly inelastic**: Maximum KE loss (stick together)
- **Coefficient of restitution**: How "bouncy" collision is (1 = perfectly elastic)',
  '[
    {
      "question": "In an elastic collision, what is conserved?",
      "options": ["Only momentum", "Only kinetic energy", "Both momentum and kinetic energy", "Neither"],
      "correctAnswer": 2,
      "explanation": "Elastic collisions conserve BOTH momentum AND kinetic energy (no energy lost to heat/deformation)."
    },
    {
      "question": "Two objects collide and stick together. This is:",
      "options": ["Elastic collision", "Inelastic collision", "Perfectly elastic collision", "Explosion"],
      "correctAnswer": 1,
      "explanation": "When objects stick together, it''s an inelastic collision (maximum kinetic energy is lost as heat/deformation)."
    },
    {
      "question": "A 1000 kg car at 10 m/s hits a parked 1000 kg car. They stick. Final speed is:",
      "options": ["0 m/s", "5 m/s", "10 m/s", "20 m/s"],
      "correctAnswer": 1,
      "explanation": "Conservation: p_i = p_f, so (1000)(10) + 0 = (2000)v_f, v_f = 5 m/s. KE is lost though!"
    },
    {
      "question": "Why are billiard ball collisions nearly elastic?",
      "options": ["They gain energy", "Balls are perfectly bouncy", "Little KE becomes heat/sound", "Momentum isn''t conserved"],
      "correctAnswer": 2,
      "explanation": "Billiard balls are designed to be very elastic, with minimal energy lost to heat/sound during collision."
    }
  ]',
  NOW()
);

-- =====================================================
-- CHAPTER 6: WAVES
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'basic-physics' LIMIT 1),
  'Waves',
  'waves',
  'Learn about waves, their properties, and how sound and light travel as waves.',
  6,
  NOW()
);

-- LESSONS FOR CHAPTER 6
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'waves' LIMIT 1),
  'What are Waves?',
  'what-are-waves',
  1,
  '# What are Waves?

**Waves** are disturbances that transfer energy without transferring matter!

## What is a Wave?

**Wave** = disturbance that carries energy through a medium

> 💡 **Key**: The MEDIUM doesn''t move with the wave!

### Examples

| Wave Type | Medium | What Moves |
|-----------|---------|-----------|
| **Water wave** | Water | Energy (water moves up/down) |
| **Sound wave** | Air | Energy (molecules vibrate) |
| **Stadium wave** | People | Energy (people stand/sit in sequence) |
| **Light wave** | Electric/magnetic fields | Energy (NO medium needed!) |

## Wave vs Particle Motion

```
Particle Motion (Wave Motion)
        ↓ ●→ ●→ ●→
      Matter moves this way

Wave Motion
        ↕ ↕ ↕ ↕
      Energy moves this way
      Matter stays in place!
```

> ⚠️ ** stadium "wave": People stay in seats, only the disturbance (standing/sitting) moves!

## Mechanical vs Electromagnetic Waves

| Type | Medium Needed? | Speed | Example |
|-------|-----------------|------|----------|
| **Mechanical** | Yes (matter) | ~340 m/s (sound in air) | Water, sound |
| **Electromagnetic** | No (fields) | 300,000,000 m/s (light) | Light, radio |

Light is fastest thing in universe!

---

**Key Terms**:
- **Wave**: Disturbance transferring energy (not matter)
- **Medium**: Material wave travels through
- **Mechanical wave**: Requires medium (water, sound)
- **Electromagnetic wave**: No medium needed (light, radio)',
  '[
    {
      "question": "What does a wave transfer?",
      "options": ["Matter", "Energy only", "Both matter and energy", "Neither"],
      "correctAnswer": 1,
      "explanation": "Waves transfer ENERGY without transferring matter. The medium vibrates in place but doesn''t travel with the wave."
    },
    {
      "question": "In a stadium ''wave'', what travels around the stadium?",
      "options": ["The people", "Energy (the standing/sitting motion)", "The seats", "Sound"],
      "correctAnswer": 1,
      "explanation": "Only the disturbance (people standing/sitting in sequence) moves - not the people themselves."
    },
    {
      "question": "Light waves are different from sound because light:",
      "options": ["Is slower", "Requires a medium", "Travels through empty space", "Is a particle wave"],
      "correctAnswer": 2,
      "explanation": "Light is an electromagnetic wave requiring NO medium (unlike sound which needs air/water), so it travels through empty space."
    },
    {
      "question": "Which is NOT a mechanical wave?",
      "options": ["Water waves", "Sound waves", "Light waves (requires no medium)", "Seismic waves"],
      "correctAnswer": 2,
      "explanation": "Light is an electromagnetic wave, not mechanical. Mechanical waves require a material medium like air, water, or solids."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'waves' LIMIT 1),
  'Wave Properties',
  'wave-properties',
  2,
  '# Wave Properties

Waves are characterized by several measurable properties.

## Amplitude

**Amplitude** = maximum displacement from equilibrium

```
        ↑ Amplitude (height of wave)
       ╱ ╲ ╱ ╲ ╲
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Equilibrium position
```

| Amplitude | Perception |
|-----------|-------------|
| **Large** | Loud sound, bright light |
| **Small** | Quiet sound, dim light |

> 💡 **Energy**: Amplitude relates to ENERGY (louder/brighter)!

## Wavelength

**Wavelength** ($\lambda$) = distance between consecutive crests

```
       ↑        ↑        ↑
      ╱ ╲ ╱ ╲ ╲ ╱ ╲
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ←── λ ──→ ←── λ ──→ ←───
       ↑        ↑        ↑
```

**Units**: meters (m)

### Radio Waves

| Station | Wavelength |
|----------|-----------|
| **AM radio** | ~300 m |
| **FM radio** | ~3 m |
| **Microwave** | ~0.1 m (10 cm) |

## Frequency

**Frequency** ($f$) = how many cycles pass per second

$$f = \frac{v}{\lambda}$$

| Unit | Meaning |
|------|----------|
| **Hertz (Hz)** | Cycles per second |
| **kHz** | Kilohertz = 1000 Hz |
| **MHz** | Megahertz = 1,000,000 Hz |

### Human Hearing Range

20 Hz to 20,000 Hz (20 kHz)

| Sound | Frequency |
|-------|-----------|
| **Bass** | Low (50-250 Hz) |
| **Mid** | Middle (250-4000 Hz) |
| **Treble** | High (4000-20,000 Hz) |

## Period

**Period** ($T$) = time for one complete cycle

$$T = \frac{1}{f}$$

| Frequency | Period |
|-----------|----------|
| **1 Hz** | 1 second |
| **2 Hz** | 0.5 seconds |
| **440 Hz** (musical A) | 0.00227 seconds |

## Wave Speed

$$v = f\lambda$$

All related!

$$v = \frac{\lambda}{T}$$

### Example

Middle C (261 Hz) has wavelength in air (343 m/s) of:

$$\lambda = \frac{v}{f} = \frac{343}{261} = \mathbf{1.31\text{ m}}$$

---

**Key Terms**:
- **Amplitude**: Maximum displacement from equilibrium (loudness/brightness)
- **Wavelength (λ)**: Distance between consecutive crests (meters)
- **Frequency (f)**: Cycles per second (Hertz)
- **Period (T)**: Time for one cycle ($T = 1/f$)
- **Wave speed**: $v = f\lambda$ or $\lambda/T$ (all three connected)',
  '[
    {
      "question": "Amplitude of a wave determines its:",
      "options": ["Speed", "Wavelength", "Energy/loudness", "Frequency"],
      "correctAnswer": 2,
      "explanation": "Amplitude relates to energy - larger amplitude means louder sound, brighter light, more energy."
    },
    {
      "question": "Wavelength measures:",
      "options": ["Wave height", "Wave speed", "Distance between consecutive crests", "Time for one cycle"],
      "correctAnswer": 2,
      "explanation": "Wavelength (λ) is the distance between identical points on consecutive wave cycles (crest to crest)."
    },
    {
      "question": "A wave has frequency 440 Hz. Its period is:",
      "options": ["440 seconds", "1/440 seconds", "0.00227 seconds", "2.27 seconds"],
      "correctAnswer": 2,
      "explanation": "Period T = 1/f = 1/440 = 0.00227 seconds. This is the note A4 on a piano!"
    },
    {
      "question": "Which relationship is correct for waves?",
      "options": ["v = fλ", "v = f/λ", "v = λ/T", "All are correct"],
      "correctAnswer": 3,
      "explanation": "All three are correct and connected! v = fλ = λ/T since T = 1/f. They are different forms of same equation."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'waves' LIMIT 1),
  'Sound Waves',
  'sound-waves',
  3,
  '# Sound Waves

**Sound** = mechanical waves through air (or other materials)!

## What is Sound?

**Sound** = longitudinal mechanical waves through a medium

> 💡 **Longitudinal**: Particles vibrate PARALLEL to wave direction!

### How We Hear

1. **Source vibrates** (vocal cords, speaker)
2. **Air molecules** compress and rarefy
3. **Pressure waves** travel to ear
4. **Eardrum vibrates** → brain interprets as sound

```
       → → → → Wave motion (air direction)
      | | | |
    Compressions | Rarefactions
```

## Speed of Sound

| Material | Speed (m/s) | Speed (km/h) |
|-----------|----------------|--------------|
| **Air (20°C)** | 343 | 1,235 |
| **Air (0°C)** | 331 | 1,192 |
| **Water** | 1,480 | 5,328 |
| **Steel** | 5,960 | 21,456 |

> 💡 **Faster in warm air**: Molecules move faster, transmit energy quicker!

## Frequency = Pitch

**Pitch** = how high or low a sound is

| Frequency | Pitch | Example |
|-----------|----------|----------|
| **Low (50-250 Hz)** | Low pitch | Bass guitar, thunder |
| **Mid (250-4000 Hz)** | Medium pitch | Human speech |
| **High (4000-20,000 Hz)** | High pitch | Bird chirp, whistle |

> ⚠️ **Hearing range**: Humans hear 20 Hz - 20 kHz

## Amplitude = Loudness

**Intensity** = power/area (W/m²)

| Sound | Intensity (W/m²) | Decibels (dB) |
|---------|-------------------|---------------|
| **Breathing** | 10⁻¹² | 10 |
| **Whisper** | 10⁻¹⁰ | 20 |
| **Conversation** | 10⁻⁵ | 60 |
| **Lawn mower** | 1 | 90 |
| **Jackhammer** | 1 | 100 |
| **Jet engine** | 10 | 120 |
| **Rocket launch** | 10⁶ | 180 |

> 💡 **Logarithmic**: +10 dB = 10× the intensity!

## Doppler Effect

**Moving source** changes observed frequency!

| Source Motion | Effect on Pitch |
|--------------|-----------------|
| **Moving toward** | Higher (blue shift) |
| **Moving away** | Lower (red shift) |
| **Not moving** | Normal |

Example: Ambulance siren drops pitch as it passes you!

---

**Key Terms**:
- **Longitudinal wave**: Particles vibrate parallel to wave direction (sound)
- **Pitch**: Perception of frequency (high = high frequency, low = low frequency)
- **Loudness**: Perception of amplitude/intensity (measured in decibels)
- **Doppler effect**: Frequency shift from moving source (approach = higher, recede = lower)',
  '[
    {
      "question": "Sound waves are:",
      "options": ["Transverse waves", "Longitudinal waves", "Electromagnetic waves", "Standing waves only"],
      "correctAnswer": 1,
      "explanation": "Sound is a longitudinal mechanical wave - air particles vibrate back and forth PARALLEL to the direction the wave travels."
    },
    {
      "question": "Sound travels faster in:",
      "options": ["Cold air", "Warm air", "Vacuum (no difference)", "Water"],
      "correctAnswer": 1,
      "explanation": "Sound travels faster in warmer air because molecules are more energetic and transmit vibrations quicker."
    },
    {
      "question": "Pitch of a sound is determined by its:",
      "options": ["Amplitude", "Frequency", "Wavelength", "Speed"],
      "correctAnswer": 1,
      "explanation": "Pitch is our perception of frequency - higher frequency = higher pitch, lower frequency = lower pitch."
    },
    {
      "question": "Why does an ambulance siren sound higher-pitched when approaching you?",
      "options": ["It''s actually louder", "Doppler effect increases observed frequency", "Air compression changes", "Driver adjusts it"],
      "correctAnswer": 1,
      "explanation": "The Doppler effect causes sound waves to compress as source approaches, increasing the observed frequency (pitch)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'waves' LIMIT 1),
  'Light Waves',
  'light-waves',
  4,
  '# Light Waves

**Light** = electromagnetic waves that don''t need a medium!

## What is Light?

**Light** = electromagnetic wave in visible spectrum

$$v = c = 3.00 \times 10^8\text{ m/s}$$

> 🌟 **Speed of light**: Universal constant, fastest thing in universe!

## Electromagnetic Spectrum

| Type | Wavelength | Frequency | Use |
|-------|------------|----------|------|
| **Radio** | >1 m | <300 MHz | Communication |
| **Microwave** | 1 m - 1 mm | 300 MHz - 300 GHz | Cooking, radar |
| **Infrared** | 1 mm - 700 nm | 300 GHz - 430 THz | Heat, night vision |
| **Visible** | 700 - 400 nm | 430 THz - 750 THz | Vision |
| **UV** | 400 - 10 nm | 750 THz - 30 PHz | Vitamin D, sterilization |
| **X-rays** | 10 nm - 0.01 nm | 30 PHz - 30 EHz | Medical imaging |
| **Gamma rays** | <0.01 nm | >30 EHz | Cancer treatment, nuclear |

### Visible Light Colors

| Color | Wavelength | Frequency |
|-------|------------|----------|
| **Red** | 700-635 nm | Lowest frequency |
| **Orange** | 635-590 nm | |
| **Yellow** | 590-560 nm | |
| **Green** | 560-520 nm | |
| **Blue** | 520-490 nm | |
| **Violet** | 490-400 nm | Highest frequency |

> 💡 **ROYGBIV**: Remember the rainbow in order!

## How We See Color

Objects **absorb** some colors, **reflect** others

| Object Appearance | What It Does |
|-----------------|---------------|
| **Red shirt** | Absorbs non-red, reflects red | |
| **Green leaf** | Absorbs non-green, reflects green | Photosynthesis uses this! |
| **White paper** | Reflects ALL colors equally | |
| **Black object** | Absorbs ALL colors (no reflection) | Heats in sun!

## Reflection of Light

**Angle of incidence = Angle of reflection**

$$\theta_i = \theta_r$$

```
        ↗ Incident ray
             ↘
      Surface  ↔  Mirror
             ↙
          Reflected ray
```

### Types of Reflection

| Type | Surface | Result |
|-------|----------|---------|
| **Specular** | Smooth/mirror | Clear image |
| **Diffuse** | Rough | Scattered light (no image) |

## Refraction of Light

**Bending** when entering new medium at an angle!

$$n_1 \sin\theta_1 = n_2 \sin\theta_2$$

Where $n$ = refractive index (how much light slows)

| Material | Refractive Index (n) |
|----------|---------------------|
| **Vacuum** | 1.0000 |
| **Air** | 1.0003 |
| **Water** | 1.33 |
| **Glass** | 1.5 |
| **Diamond** | 2.42 |

### Why It Bends

Light **slows down** in denser medium, causing **bending toward normal**.

> 🎯 **Analogy**: Like a car wheel hitting mud - it pulls (slows) and turns!

---

**Key Terms**:
- **Electromagnetic spectrum**: Range of EM waves from radio to gamma rays
- **Visible spectrum**: 400-700 nm wavelengths (ROYGBIV)
- **Refraction**: Bending of light when entering new medium
- **Reflection**: Bouncing of light off surface (angle in = angle out)
- **Refractive index**: How much light slows in material (n)',
  '[
    {
      "question": "Light waves differ from sound waves because light:",
      "options": ["Is slower", "Requires a medium", "Can travel through vacuum (empty space)", "Is a particle wave"],
      "correctAnswer": 2,
      "explanation": "Light is an electromagnetic wave that doesn''t need a medium - it travels through empty space at 300,000,000 m/s."
    },
    {
      "question": "Which has the LONGEST wavelength in visible spectrum?",
      "options": ["Blue", "Green", "Red", "Violet"],
      "correctAnswer": 2,
      "explanation": "Red light has longest wavelength (~700 nm) and lowest frequency in visible spectrum."
    },
    {
      "question": "Why does a white object appear white?",
      "options": ["It emits white light", "It absorbs all colors", "It reflects all colors equally", "It transmits all colors"],
      "correctAnswer": 2,
      "explanation": "White objects reflect ALL visible colors equally, while black objects absorb all colors (no light reaches your eyes)."
    },
    {
      "question": "Light bends when entering water because:",
      "options": ["Water has higher refractive index", "Light speeds up in water", "Water reflects the light", "Gravity pulls on light"],
      "correctAnswer": 0,
      "explanation": "Light SLOWS DOWN in water (higher refractive index n=1.33 vs air n=1.0003), causing bending toward normal line."
    }
  ]',
  NOW()
);
