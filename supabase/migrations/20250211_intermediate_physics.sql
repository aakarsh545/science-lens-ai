-- =====================================================
-- INTERMEDIATE PHYSICS COURSE
-- Topics: Rotational Motion, Fluid Mechanics, Thermodynamics, Electromagnetism
-- Difficulty: Intermediate
-- Lessons: ~30 lessons across 6 chapters
-- =====================================================

-- COURSE: Intermediate Physics
INSERT INTO courses (id, title, slug, description, category, difficulty, lesson_count, created_at) VALUES
(
  UUID_GENERATE_V4(),
  'Intermediate Physics',
  'intermediate-physics',
  'Build on Basic Physics to explore rotational motion, fluid mechanics, heat transfer, electromagnetism, and atomic physics. Perfect for students ready for advanced topics.',
  'physics',
  'intermediate',
  30,
  NOW()
);

-- =====================================================
-- CHAPTER 1: ROTATIONAL MOTION
-- =====================================================
INSERT INTO chapters (id, course_id, title, slug, description, order_index, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM courses WHERE slug = 'intermediate-physics' LIMIT 1),
  'Rotational Motion',
  'rotational-motion',
  'Learn how objects rotate, analyze torque, and understand angular momentum.',
  1,
  NOW()
);

-- LESSONS FOR CHAPTER 1
INSERT INTO lessons (id, chapter_id, title, slug, order_index, content_markdown, quiz_json, created_at) VALUES
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Rotational Kinematics',
  'rotational-kinematics',
  1,
  '# Rotational Kinematics

Linear motion has position, velocity, acceleration. **Rotational motion** has analogous quantities!

## Angular Position

**Angular position** ($\theta$) = angle rotated from reference

- **Units**: radians (rad) or degrees (°)
- **Full rotation**: $2\pi$ radians = 360°
- **Angular displacement**: $\Delta\theta = \theta_f - \theta_i$

> 💡 **Radian advantage**: Calculations simpler than degrees!

## Angular Velocity

**Angular velocity** ($\omega$) = rate of rotation

$$\omega = \frac{\Delta\theta}{\Delta t}$$

Where:
- $\omega$ = angular velocity (rad/s)
- $\Delta\theta$ = angle rotated (rad)
- $\Delta t$ = time interval (s)

**Units**: rad/s or rev/s (revolutions per second)

### Relation to Linear Velocity

For a point at distance $r$ from rotation axis:

$$v = r\omega$$

Where:
- $v$ = linear (tangential) velocity (m/s)
- $r$ = radius (m)
- $\omega$ = angular velocity (rad/s)

## Angular Acceleration

**Angular acceleration** ($\alpha$) = rate of change of angular velocity

$$\alpha = \frac{\Delta\omega}{\Delta t} = \frac{\Delta^2\theta}{\Delta t^2}$$

**Units**: rad/s²

### Direction

| Motion | $\alpha$ | Effect on $\omega$ |
|---------|-------|-------------------|
| **Speeding up rotation** | Positive | Increases |
| **Slowing rotation** | Negative | Decreases |
| **Reversing direction** | Changes sign | Changes direction |

## Example: CD Player

A CD rotates at $\omega = 200\pi$ rad/min.

**Convert to rad/s**:
$$\omega = \frac{200\pi\text{ rad}}{60\text{ s}} = \frac{10\pi}{3}\text{ rad/s} \approx 10.47\text{ rad/s}$$

**Tangential velocity** at $r = 0.04$ m (outer edge):

$$v = r\omega = (0.04)(10.47) \approx \mathbf{0.42\text{ m/s}}$$

> 💡 **Real example**: DVDs spin faster than CDs, so they hold more data!

---

**Key Terms**:
- **Angular position**: Angle from reference ($\theta$)
- **Angular velocity**: Rate of rotation ($\omega = \Delta\theta/\Delta t$)
- **Angular acceleration**: Change in angular velocity ($\alpha = \Delta\omega/\Delta t$)
- **Tangential velocity**: Linear speed at rotating edge ($v = r\omega$)',
  '[
    {
      "question": "A wheel rotates at 2 rad/s. What is its angular velocity in rad/s?",
      "options": ["2 rad/s", "1 rad/s", "4 rad/s", "360°/s"],
      "correctAnswer": 0,
      "explanation": "Angular velocity is already in rad/s. 2 rad/s means the wheel completes 2 radians every second (about 1/3 of a full rotation)."
    },
    {
      "question": "A point 0.1 m from rotation axis has angular velocity 5 rad/s. What is its linear (tangential) velocity?",
      "options": ["0.5 m/s", "5 m/s", "0.05 m/s", "50 m/s"],
      "correctAnswer": 0,
      "explanation": "v = rω = 0.1 × 5 = 0.5 m/s. This is the linear speed of that point."
    },
    {
      "question": "Which is TRUE about angular acceleration?",
      "options": ["It measures rate of change of angular position", "It measures rate of change of linear velocity", "It''s the same as centripetal acceleration", "It always points toward the center"],
      "correctAnswer": 0,
      "explanation": "Angular acceleration (α) measures how fast angular velocity changes, just as linear acceleration (a) measures how fast linear velocity changes."
    },
    {
      "question": "Full rotation is equal to:",
      "options": ["π radians", "2π radians", "360°", "180°"],
      "correctAnswer": 2,
      "explanation": "One complete rotation equals 2π radians or 360°. Both represent the same full circle."
    },
    {
      "question": "A CD spins at 200π rad/min. What is its angular velocity in rad/s?",
      "options": ["200π rad/s", "(10π)/3 rad/s", "20π rad/s", "10.47 rad/s"],
      "correctAnswer": 3,
      "explanation": "200π rad/min = (200π/60) rad/s = (10π/3) rad/s ≈ 10.47 rad/s."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Moment of Inertia and Torque',
  'moment-of-inertia-torque',
  2,
  '# Moment of Inertia and Torque

**Torque** = rotational analogue of force!

## What is Torque?

**Torque** ($\tau$) = force × lever arm

$$\tau = rF\sin\theta = r_{\perp}F$$

Where:
- $\tau$ = torque (N·m)
- $r$ = distance from axis to force (m)
- $F$ = applied force (N)
- $\theta$ = angle between r and F

> 💡 **Key**: Perpendicular distance ($r_{\perp}$) matters!

## Moment of Inertia

**Moment of inertia** ($I$) = resistance to rotational acceleration

$$I = \sum mr^2$$

Where:
- $I$ = moment of inertia (kg·m²)
- $m$ = mass of each particle (kg)
- $r$ = distance from axis (m)

**Objects with mass farther from axis** = harder to rotate!

### Common Shapes

| Shape | $I$ (about) | Formula |
|-------|-----------|----------|
| **Solid cylinder** | $\frac{1}{2}mr^2$ | $\frac{1}{2}mR^2$ |
| **Solid sphere** | $\frac{2}{5}mr^2$ | $\frac{2}{5}mR^2$ |
| **Thin hoop** | $mr^2$ | $mR^2$ |
| **Rod through center** | $\frac{1}{12}mL^2$ | $\frac{1}{12}m(\frac{L}{2})^2$ |

> 💡 **Distribution matters**: Mass farther from axis = harder to rotate!

## Rotational Dynamics

**Newton''s Second Law for Rotation**:

$$\tau = I\alpha$$

Where:
- $\tau$ = net torque (N·m)
- $I$ = moment of inertia (kg·m²)
- $\alpha$ = angular acceleration (rad/s²)

## Example Problem

A solid cylinder ($m = 5$ kg, $r = 0.3$ m) has $\tau = 15$ N·m applied. What is $\alpha$?

**Moment of inertia**:
$$I = \frac{1}{2}mr^2 = \frac{1}{2}(5)(0.3)^2 = \mathbf{0.225\text{ kg·m}^2}$$

**Angular acceleration**:
$$\alpha = \frac{\tau}{I} = \frac{15}{0.225} \approx \mathbf{66.7\text{ rad/s}^2}$$

## Equilibrium Conditions

**Translational** equilibrium: $\sum \vec{F} = 0$

**Rotational** equilibrium: $\sum \tau = 0$

| Condition | Translation | Rotation |
|-----------|--------------|-------------|
| **Balanced forces** | No acceleration ($\vec{a} = 0$) | No angular acceleration ($\alpha = 0$) |
| **Unbalanced forces** | Linear acceleration | Angular acceleration |
| **Zero net torque** | Any constant $\omega$ | Constant $\omega$ |

---

**Key Terms**:
- **Torque**: Force × lever arm distance ($\tau = rF\sin\theta$)
- **Moment of inertia**: Resistance to rotational acceleration ($I = \sum mr^2$)
- **Rotational analog of F=ma**: $\tau = I\alpha$
- **Perpendicular distance**: Distance from rotation axis to force ($r_{\perp}$)',
  '[
    {
      "question": "Torque can be INCREASED by:",
      "options": ["Moving force closer to axis", "Moving force farther from axis", "Increasing force", "Using a longer lever"],
      "correctAnswer": 1,
      "explanation": "Since τ = rF (perpendicular distance), moving force CLOSER to axis decreases r, which increases torque (τ = rF with same F)."
    },
    {
      "question": "Which has GREATER moment of inertia?",
      "options": ["Solid sphere (mass m at radius R)", "Thin hoop (mass m at radius R)", "Solid cylinder (mass m at radius R/2)", "Thick-walled cylinder"],
      "correctAnswer": 2,
      "explanation": "Thin hoop has all mass at radius R, so I = mR² is LARGEST. Solid cylinder (mass at R/2) has I = ½mR², and sphere has I = 2/5 mR²."
    },
    {
      "question": "A solid cylinder (m=5kg, r=0.3m) needs τ=15 N·m to accelerate. What is α?",
      "options": ["66.7 rad/s²", "100 rad/s²", "222 rad/s²", "500 rad/s²"],
      "correctAnswer": 0,
      "explanation": "α = τ/I = 15/0.225 = 66.7 rad/s². I = ½mr² = 0.5×5×0.3² = 0.225 kg·m²"
    },
    {
      "question": "When is rotational equilibrium achieved?",
      "options": ["When α = 0 (constant ω)", "When net torque = 0", "When all torques balance", "When the object stops rotating"],
      "correctAnswer": 2,
      "explanation": "Rotational equilibrium occurs when net torque Στ = 0. This means no angular acceleration (α = 0), so ω stays constant."
    },
    {
      "question": "Two children on a merry-go-round: Child A (m=30kg) at 4m, Child B (m=20kg) at 3m. Who experiences greater centripetal force?",
      "options": ["Child A experiences greater force", "Child B experiences greater force", "Both experience same force (since v²/r differs)", "Cannot determine from info given"],
      "correctAnswer": 0,
      "explanation": "Centripetal force F_c = mv²/r. Child A: (30×v²)/4, Child B: (20×v²)/3. At same ω, Child A needs 4× the force of B!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Angular Momentum',
  'angular-momentum',
  3,
  '# Angular Momentum

**Angular momentum** ($L$) = rotational analogue of linear momentum!

## Defining Angular Momentum

$$L = I\omega$$

Where:
- $L$ = angular momentum (kg·m²/s)
- $I$ = moment of inertia (kg·m²)
- $\omega$ = angular velocity (rad/s)

> 💡 **Conserved**: In isolated systems with no external torque!

## Comparison with Linear Momentum

| Quantity | Linear | Rotational |
|-----------|---------|--------------|
| **Momentum** | $\vec{p} = m\vec{v}$ | $L = I\omega$ |
| **Mass** | $m$ (scalar) | $I$ (distribution, kg·m²) |
| **Velocity** | $\vec{v}$ (vector) | $\omega$ (pseudo-vector, rad/s) |

## Conservation of Angular Momentum

**With no external torque**, angular momentum is conserved:

$$I_i\omega_i = I_f\omega_f$$

### Example: Figure Skater

**Initial**: Arms out, spinning slowly ($I = 3$ kg·m², $\omega_i = 1$ rad/s)

**Pulls arms in** (mass at $r$): $I$ decreases to $1.5$ kg·m²

**Final angular velocity**:

$$(3)(1) = (1.5)(\omega_f)$$

$$\omega_f = 2\text{ rad/s}$$

**Conservation check**: $L_i = L_f$ ✓

> 💡 **Everyday**: Cats rotate faster (tuck in) to increase $\omega$ when landing!

## Gyroscopes

**Gyroscope** = device that maintains angular orientation

- **Spinning gyroscope**: Resists changes (angular momentum!)
- **Precession**: Slow rotation of spin axis due to torque

### Applications

| Use | Principle |
|------|-----------|
| **Navigation** | Gyroscopes maintain direction | Conservation of L |
| **Stabilization** | Ships, spacecraft | Resist rotation changes |
| **Toys** | Tops, fidget spinners | Demonstrate angular momentum |

---

**Key Terms**:
- **Angular momentum**: $L = I\omega$ (rotational analogue of $p = mv$)
- **Conservation**: With no external torque, $L$ stays constant
- **Moment of inertia**: $I$ determines resistance to angular acceleration
- **Gyroscope**: Device maintaining orientation using angular momentum',
  '[
    {
      "question": "Angular momentum L equals:",
      "options": ["mω", "Iω", "mv²", "Iα"],
      "correctAnswer": 1,
      "explanation": "L = Iω, where I is moment of inertia (kg·m²) and ω is angular velocity (rad/s). Units are kg·m²/s."
    },
    {
      "question": "A figure skater with arms out (I=3 kg·m², ω=1 rad/s) pulls arms in (I decreases to 1.5 kg·m²). What is new ω?",
      "options": ["1 rad/s", "1.5 rad/s", "2 rad/s", "0.67 rad/s"],
      "correctAnswer": 2,
      "explanation": "Conservation: I_iω_i = I_fω_f, so 3×1 = 1.5×ω_f. Solving: ω_f = 3/1.5 = 2 rad/s."
    },
    {
      "question": "Why does a spinning top stay upright?",
      "options": ["Gravity is pulling on it", "Angular momentum is conserved", "It''s perfectly balanced on its tip", "The fast spin creates a stabilizing gyroscopic effect"],
      "correctAnswer": 1,
      "explanation": "The spinning top has angular momentum. As it slows, angular momentum is conserved but the axis precesses (wobbles) due to torque from gravity."
    },
    {
      "question": "Which object has GREATER angular momentum: A solid sphere (m=2kg, r=0.5m) spinning at ω=5 rad/s, or B solid cylinder (m=4kg, r=0.3m) at ω=4 rad/s?",
      "options": ["Sphere A (L = Iω = 0.25 kg·m²/s)", "Sphere B (L = Iω = 0.24 kg·m²/s)", "B has greater L", "Cannot determine without knowing ω direction"],
      "correctAnswer": 2,
      "explanation": "Sphere A: L = Iω = mr²ω = (2)(0.5)²(5) = 0.25 kg·m²/s. Sphere B: L = mr²ω = (4)(0.3)²(4) = 0.24 kg·m²/s. Sphere B has slightly less L despite 2× the mass."
    },
    {
      "question": "In a system with no external torques, angular momentum:",
      "options": ["Decreases over time", "Stays constant", "Becomes zero", "Oscillates randomly"],
      "correctAnswer": 1,
      "explanation": "With no external torque (Στ = 0), angular momentum L is conserved and remains constant. This is the rotational form of Newton''s first law."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Rolling Motion',
  'rolling-motion',
  4,
  '# Rolling Motion

**Rolling motion** = combined rotation + translation without slipping!

## Pure Rolling vs Slipping

| Type | Motion | Energy Loss |
|------|---------|-------------|
| **Pure rolling** | $v = r\omega$ | None (friction does no work) |
| **Rolling with slip** | $v > r\omega$ | Significant (kinetic friction acts) |
| **Pure sliding** | No rotation | Complete loss to friction |

> 💡 **Efficiency**: Rolling is much more efficient than sliding!

## Condition for Pure Rolling

**No slip condition**:

$$v_{CM} = r\omega$$

Where:
- $v_{CM}$ = velocity of center of mass
- $r$ = radius of object
- $\omega$ = angular velocity

**Static friction limit**:

$$F_{f,max} = \mu_s N$$

Where:
- $\mu_s$ = coefficient of static friction
- $N$ = normal force ($mg$ on flat surface)

For pure rolling: $\sum F_{friction} \leq \mu_s N$ required to prevent slipping

## Examples

### 1. Car Tire Rolling

**Tire**: $r = 0.3$ m, $\mu_s = 0.8$ (dry asphalt)

**Maximum speed before slipping**:

For $m = 1500$ kg car, $N = mg = 14715$ N:

$$v_{max} = \sqrt{\frac{r g \mu_s}{1 + \frac{r^2\alpha_{max}}{g}}}$$

$$v_{max} = \sqrt{\frac{(0.3)(9.8)(0.8)}{1 + \frac{(0.3)^2(0.5)}{9.8}}} \approx \mathbf{23.2\text{ m/s}}$$

> 🚗 **~83 km/h** = 52 mph before tire slip!

### 2. Ball Rolling Down Incline

**Acceleration**: Pure rolling ($v = r\omega$) with rolling down slope:

$$a = \frac{g\sin\theta}{1 + \frac{r^2}{I_{CM}}}{mr^2}$$

Where $I_{CM} = \frac{2}{5}mr^2$ for solid sphere

## Energy in Rolling

**Translational + Rotational KE**:

$$KE_{total} = \frac{1}{2}mv_{CM}^2 + \frac{1}{2}I_{CM}\omega^2$$

For pure rolling ($v_{CM} = r\omega$):

$$KE = \frac{1}{2}m(r\omega)^2 + \frac{2}{5}mr^2\omega^2 = \frac{7}{10}mr^2\omega^2$$

**Distribution**: $\frac{2}{7}$ translational, $\frac{5}{7}$ rotational (for sphere)

> 💡 **Rolling efficiency**: Most energy goes into translation, NOT rotation!

---

**Key Terms**:
- **Pure rolling**: $v_{CM} = r\omega$ (no slipping, no energy loss to friction)
- **Slipping**: When $v_{CM} > r\omega$ (friction insufficient, kinetic friction acts)
- **Rolling resistance**: $\mu_s N$ (maximum static friction before slipping)
- **Energy distribution**: For sphere, $\frac{2}{7}$ translational KE, $\frac{5}{7}$ rotational KE',
  '[
    {
      "question": "Pure rolling motion occurs when:",
      "options": ["v_CM > rω", "v_CM = rω exactly", "v_CM < rω", "Friction is zero"],
      "correctAnswer": 1,
      "explanation": "Pure rolling: v_CM = rω (no slipping). Contact point velocity matches rolling condition, so no relative motion at contact."
    },
    {
      "question": "A 1500 kg car on 0.8 μ tires has max speed before slipping of:",
      "options": ["14.2 m/s", "23.2 m/s", "52 km/h", "83 km/h"],
      "correctAnswer": 0,
      "explanation": "v_max = √(rgμ_s/(1 + r²α/g)) with I = 2/5 mr² = 2/5(1500)(0.3)². Calculates to ~23.2 m/s (83 km/h or 52 mph)."
    },
    {
      "question": "Why is rolling more efficient than sliding?",
      "options": ["Rolling has no friction", "Rolling reduces contact area", "Rolling keeps object moving longer", "Static friction is higher than kinetic"],
      "correctAnswer": 2,
      "explanation": "In rolling, the contact point is instantaneously at rest (v=0 at that point), so static friction does NEGATIVE work. Sliding has continuous friction doing negative work along entire path."
    },
    {
      "question": "For a solid sphere rolling without slipping, how is its KE distributed?",
      "options": ["100% translational, 0% rotational", "70% translational, 30% rotational", "Cannot determine from shape alone"],
      "correctAnswer": 2,
      "explanation": "For a solid sphere, I = 2/5 mr², so KE_rot = ½Iω² = ½(2/5)mr²ω² = (1/5)mr²ω². Distribution: 2/5 (≈29%) rotational, 3/5 (≈71%) translational."
    },
    {
      "question": "The condition v_CM = rω ensures:",
      "options": ["No slipping occurs", "Energy is conserved", "Maximum acceleration", "Rolling resistance is not exceeded"],
      "correctAnswer": 0,
      "explanation": "The no-slip condition v_CM = rω means the contact point velocity equals the rolling velocity. This maximizes efficiency since static friction does no negative work (contact point is instantaneously at rest relative to surface)."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Centripetal Force',
  'centripetal-force',
  5,
  '# Centripetal Force

**Centripetal force** = inward force causing circular motion!

## What is Centripetal Force?

**Centripetal acceleration** ($a_c$) toward center of circular path:

$$\vec{F}_c = m\vec{a}_c$$

Where:
- $\vec{F}_c$ = centripetal force (N)
- $m$ = mass (kg)
- $a_c$ = centripetal acceleration (m/s²)
- Direction: Always toward center of circle!

> ⚠️ **NOT centrifugal**: Centripetal force points INWARD, not outward!

## Centripetal Acceleration

$$a_c = \frac{v^2}{r} = \omega^2 r = \frac{4\pi^2 r}{T^2}$$

Where:
- $v$ = tangential speed (m/s)
- $r$ = radius of circular path (m)
- $\omega$ = angular velocity (rad/s)
- $T$ = period of rotation (s)

### Examples

| Situation | $v$ | $r$ | $a_c$ |
|-----------|--------|-------|----------|
| **Earth satellite** | 7800 m/s | 6,700,000 m | 9.1 m/s² |
| **Car on ramp** | 20 m/s | 50 m | 8 m/s² |
| **Mercury equator** | 172,340 m/s | 2,440,000 m | 12.4 m/s² |
| **CD (inner track)** | ~1 m/s | 0.05 m | ~20 m/s² |

> 💡 **Maximum**: $r$ smaller → larger $a_c$ needed!

## Calculating Centripetal Force

### Example: Car on Flat Curve

Car of mass $m = 1500$ kg, velocity $v = 25$ m/s, curve radius $r = 80$ m.

**Centripetal acceleration**:
$$a_c = \frac{v^2}{r} = \frac{25^2}{80} = \mathbf{7.81\text{ m/s}^2}$$

**Centripetal force**:
$$F_c = ma_c = (1500)(7.81) = \mathbf{11,\!715\text{ N}}$$

> ⚠️ **About 1.2 tons of force**!

## Banked Curves

Roads are **banked** (tilted) to help provide centripetal force!

$$\theta = \arctan\left(\frac{v^2}{rg}\right)$$

Angle where friction alone provides needed $F_c$.

---

**Key Terms**:
- **Centripetal force**: Center-seeking force causing circular motion ($F_c = mv²/r$)
- **Centripetal acceleration**: $a_c = v²/r$ toward circle center
- **Period**: Time for one rotation ($T = 2\pi/\omega$ or $T = 1/f$)
- **Centrifugal tendency**: Apparent outward force (inertia, NOT real force)',
  '[
    {
      "question": "Centripetal force points:",
      "options": ["Away from center of circle", "Toward center of circle", "In direction of motion", "Opposite to velocity vector"],
      "correctAnswer": 1,
      "explanation": "Centripetal force ALWAYS points toward the center of the circular path, perpendicular to velocity. It is NOT outward (that''s centrifugal - a fictitious force from your reference frame)."
    },
    {
      "question": "A 1500 kg car travels 25 m/s around an 80 m radius curve. Centripetal force is:",
      "options": ["2,943 N", "11,715 N", "11,715 N but toward center", "46,860 N"],
      "correctAnswer": 2,
      "explanation": "F_c = mv²/r = 1500 × (25²/80) = 1500 × 7.81 = 11,715 N toward center."
    },
    {
      "question": "Which requires MORE centripetal force?",
      "options": ["Faster speed on same radius", "Slower speed on same radius", "Tighter radius at same speed", "More mass at same v and r"],
      "correctAnswer": 0,
      "explanation": "F_c = mv²/r. For a given speed, F_c ∝ 1/r. So smaller r (tighter curve) requires MORE force. At constant r, F_c ∝ v² (faster needs more force)."
    },
    {
      "question": "How does banking a road curve help?",
      "options": ["Elimates need for centripetal force", "Reduces reliance on friction", "Makes cars go faster", "Allows higher speeds"],
      "correctAnswer": 1,
      "explanation": "Banking provides a component of normal force toward center, reducing the needed friction force. F_c from horizontal + F_friction = mv²/r, so banking reduces friction requirement."
    },
    {
      "question": "Why is ''centrifugal force'' called fictitious?",
      "options": ["Because it doesn''t exist", "Because it points outward from rotating frame", "Because gravity affects it", "Because it varies with mass"],
      "correctAnswer": 1,
      "explanation": "Centrifugal force is fictitious because it only appears in the ROTATING reference frame. In an inertial frame, there is no outward force - only inertia carrying you in a straight line."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Rotational Work and Energy',
  'rotational-work-energy',
  6,
  '# Rotational Work and Energy

Linear work/energy concepts have **rotational analogues**!

## Rotational Work

**Work** ($W$) = torque × angular displacement

$$W = \tau\Delta\theta$$

Where:
- $W$ = work (Joules)
- $\tau$ = torque (N·m)
- $\Delta\theta$ = angular displacement (rad)

> 💡 **Same units**: N·m = J (for rotations)!

## Example Problem

Torque $\tau = 50$ N·m applied through rotation of $\Delta\theta = 2\pi$ rad.

$$W = (50)(2\pi) = \mathbf{314\text{ J}}$$

## Rotational Kinetic Energy

$$KE_{rot} = \frac{1}{2}I\omega^2$$

Where:
- $KE_{rot}$ = rotational kinetic energy (J)
- $I$ = moment of inertia (kg·m²)
- $\omega$ = angular velocity (rad/s)

### Examples

| Object | $I$ | $\omega$ | $KE_{rot}$ |
|---------|--------|----------|----------|
| **CD spinning** | $\sim 10^{-4}$ kg·m² | 200 rad/s | 0.2 J |
| **Flywheel** | $10$ kg·m² | 50 rad/s | 12.5 kJ |
| **Ice skater spin** | $2$ kg·m² | 10 rad/s | 100 J |

> 💡 **Energy storage**: Flywheels store rotational energy for later use!

## Work-Energy Theorem

**Net work = change in rotational KE**

$$W_{net} = \Delta KE_{rot} = \frac{1}{2}I(\omega_f^2 - \omega_i^2)$$

## Power in Rotation

**Rotational power** ($P_{rot}$):

$$P_{rot} = \tau\omega$$

Average power = work/time in rotational systems too!

---

**Key Terms**:
- **Rotational work**: $W = \tau\Delta\theta$ (torque × angular displacement)
- **Rotational KE**: $KE_{rot} = \frac{1}{2}I\omega^2$ (analogous to $\frac{1}{2}mv^2$)
- **Rotational power**: $P_{rot} = \tau\omega$ (torque × angular velocity)
- **Moment of inertia**: $I$ determines resistance to angular acceleration',
  '[
    {
      "question": "Rotational work W = τΔθ is measured in:",
      "options": ["Joules only", "Newton-meters", "Joules per radian", "Watt-seconds"],
      "correctAnswer": 0,
      "explanation": "Rotational work units are Joules (J), same as linear work. N·m (force × distance) simplifies to N·m = J for rotational work too."
    },
    {
      "question": "A solid cylinder (I = 0.5 kg·m²) rotates at ω = 4 rad/s. Its rotational KE is:",
      "options": ["1 J", "2 J", "4 J", "8 J"],
      "correctAnswer": 2,
      "explanation": "KE_rot = ½Iω² = ½(0.5)(4²) = 0.5 × 16 = 8 J."
    },
    {
      "question": "How does rotational work relate to power?",
      "options": ["W = P/ω", "P = τω", "W = τΔθ/Δt", "Power = τω/Δt"],
      "correctAnswer": 1,
      "explanation": "Rotational power P_rot = τω = torque × angular velocity (N·m × rad/s = W). Average power = W/t."
    },
    {
      "question": "A flywheel (I = 50 kg·m², ω_f = 50 rad/s) has KE of:",
      "options": ["25 kJ", "31 kJ", "62.5 kJ", "125 kJ"],
      "correctAnswer": 2,
      "explanation": "KE_rot = ½Iω² = ½(50)(50²) = 25 × 2500 = 62,500 J = 62.5 kJ. This energy can be recovered as useful work!"
    },
    {
      "question": "For pure rolling, the work done by static friction is:",
      "options": ["Maximum (negative)", "Zero (no work done at contact point)", "Positive (accelerates the object)", "Minimum (helps rolling)"],
      "correctAnswer": 1,
      "explanation": "In pure rolling, the contact point is instantaneously at rest relative to the surface. Static friction does NO WORK (W = F·d = 0 since d=0). This is why rolling is efficient!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'rotational-motion' LIMIT 1),
  'Fluid Mechanics',
  'fluid-mechanics',
  2,
  '# Fluid Mechanics

**Fluids** differ from solids - they flow and deform!

## What is a Fluid?

**Fluid** = substance that **flows** (continuous deformation under shear stress)

| Phase | Flows? | Examples |
|-------|---------|----------|
| **Liquids** | ✅ Yes | Water, oil, blood |
| **Gases** | ✅ Yes | Air, helium |
| **Plasmas** | ✅ Yes | Stars, lightning |
| **Solids** | ❌ No | Ice, rock |

> 💡 **Continuum**: Treats fluids as collections of moving particles!

## Density

**Density** ($\rho$) = mass per unit volume

$$\rho = \frac{m}{V}$$

Where:
- $\rho$ = density (kg/m³)
- $m$ = mass (kg)
- $V$ = volume (m³)

### Densities of Materials

| Material | Density (kg/m³) | g/cm³ |
|----------|-------------------|----------|
| **Water** (4°C) | 1000 | 1.00 |
| **Ice** | 917 | 0.92 |
| **Aluminum** | 2700 | 2.70 |
| **Iron** | 7870 | 7.87 |
| **Gold** | 19,300 | 19.3 |
| **Mercury** | 13,600 | 13.6 |

> 💡 **Archimedes**: Discovered buoyancy with density!

## Pressure in Fluids

**Pressure** ($P$) = force per unit area

$$P = \frac{F}{A}$$

Where:
- $P$ = pressure (Pa = N/m²)
- $F$ = force (N)
- $A$ = area (m²)

**Hydrostatic pressure** (depth variation):

$$P = P_0 + \rho g h$$

Where:
- $P_0$ = atmospheric pressure
- $\rho$ = fluid density
- $g$ = 9.8 m/s²
- $h$ = depth below surface

### Example

Pressure at 10 m underwater in water:

$$P = 101,325 + (1000)(9.8)(10) = 101,325 + 98,\!000 = \mathbf{199,\!325\text{ Pa}}$$

> 🌊 **About 2 atmospheres** of pressure!

---

**Key Terms**:
- **Fluid**: Substance that flows (liquids, gases, plasma)
- **Density**: Mass per unit volume ($\rho = m/V$)
- **Pressure**: Force per unit area ($P = F/A$)
- **Hydrostatic pressure**: Pressure variation with depth ($P = P_0 + \rho g h$)',
  '[
    {
      "question": "Which of these is a fluid?",
      "options": ["Ice cube", "Liquid water", "Steel beam", "Flowing lava"],
      "correctAnswer": 1,
      "explanation": "A fluid is a substance that FLOWS (continuous deformation under shear). Liquid water is a fluid. Ice cubes and steel beams are SOLIDS that don''t flow."
    },
    {
      "question": "What is the density of water (approximately)?",
      "options": ["100 kg/m³", "1 kg/m³", "1000 kg/m³", "10,000 kg/m³"],
      "correctAnswer": 2,
      "explanation": "Water has density ρ ≈ 1000 kg/m³ = 1 g/cm³. This means 1 m³ of water has a mass of about 1000 kg (1 metric ton)."
    },
    {
      "question": "A cube of aluminum (ρ=2700 kg/m³) has mass 5.4 kg. What is its volume?",
      "options": ["0.002 m³", "0.002 m³ (2 L)", "0.02 m³", "0.05 m³"],
      "correctAnswer": 0,
      "explanation": "V = m/ρ = 5.4/2700 = 0.002 m³. Each side would be 0.126 m, making it a 12.6 cm cube."
    },
    {
      "question": "Pressure at 10 m underwater in water is about:",
      "options": ["101,325 Pa", "199,325 Pa (2 atm)", "491,325 Pa (5 atm)", "1,013,250 Pa (10 atm)"],
      "correctAnswer": 0,
      "explanation": "P = P₀ + ρgh = 101,325 + (1000)(9.8)(10) = 101,325 + 98,000 = 199,325 Pa. This is about 2 atmospheres of pressure (1 atm ≈ 101,325 Pa)."
    },
    {
      "question": "Which material has the GREATEST density?",
      "options": ["Water (1000 kg/m³)", "Gold (19,300 kg/m³)", "Osmium (22,610 kg/m³)", "Platinum (21,500 kg/m³)"],
      "correctAnswer": 1,
      "explanation": "Gold is one of the densest materials at 19,300 kg/m³ (19.3 g/cm³). This is why gold is so heavy for its size!"
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'fluid-mechanics' LIMIT 1),
  'Pascal''s Principle and Hydraulics',
  'pascals-principle-hydraulics',
  2,
  '# Pascal''s Principle and Hydraulics

**Pascal''s principle** explains how pressure transmits through fluids!

## Pascal''s Principle

**Pressure applied anywhere in confined fluid is transmitted equally in all directions.**

$$\frac{\Delta P}{\Delta h} = -\rho g$$

Where:
- $\Delta P$ = change in pressure (Pa)
- $\Delta h$ = change in height (m)
- $\rho$ = fluid density (kg/m³)
- $g$ = 9.8 m/s²

> 💡 **Key insight**: Pressure depends on DEPTH, not shape!

### Applications

| Application | How It Works |
|-----------|---------------|
| **Hydraulic lift** | Small force on small piston creates HUGE force on large piston |
| **Hydraulic press** | Force multiplication for crushing/bending |
| **Hydraulic brakes** | Small foot pressure creates large stopping force |
| **Blood pressure** | Heart pressure transmitted throughout body |

### Hydraulic Lift Formula

$$\frac{F_1}{A_1} = \frac{F_2}{A_2}$$

Where:
- $F_1, F_2$ = forces on pistons 1 and 2
- $A_1, A_2$ = areas of pistons

### Example

Small piston ($A_1 = 0.001$ m²) with 50 N:

$$F_2 = \frac{50}{0.001} = \mathbf{50,\!000\text{ N}}$$

> 💪 **1000× force multiplication**!

## Manometers

**Manometer** = U-shaped tube measuring pressure difference

```
   Open end (P₁)          Closed end (P₂)
      ↓                    ↓
    ├────────────────────┤
         Mercury (ρHg)
    ├────────────────────┤
      Δh = h₂ - h₁
```

$$\Delta P = \rho_Hg g \Delta h$$

Where:
- $\Delta P$ = pressure difference (Pa)
- $\rho_Hg$ = mercury density (13,600 kg/m³)
- $\Delta h$ = height difference of mercury columns

---

**Key Terms**:
- **Pascal''s principle**: Pressure change is same throughout fluid ($\Delta P/\Delta h = -\rho g$)
- **Hydraulics**: Force multiplication using confined fluid ($F_1/A_1 = F_2/A_2$)
- **Manometer**: U-tube device measuring pressure difference using fluid column',
  '[
    {
      "question": "Pascal''s principle states that pressure applied to a confined fluid:",
      "options": ["Is transmitted equally in all directions", "Creates the greatest pressure at the bottom", "Decreases with depth according to ρgh", "Transmits only horizontally"],
      "correctAnswer": 0,
      "explanation": "Pascal''s principle: pressure applied ANYWHERE in confined fluid is transmitted EQUALLY in ALL directions. Same pressure everywhere, no matter the shape of container!"
    },
    {
      "question": "A hydraulic press has a small piston of area 0.001 m² with 100 N force. What force does the large piston (area 0.1 m²) exert?",
      "options": ["100 N", "1,000 N", "10,000 N", "100,000 N"],
      "correctAnswer": 1,
      "explanation": "F₂ = F₁ × (A₁/A₂) = 100 × (0.001/0.1) = 100 × 0.01 = 1,000 N (10× force multiplication)."
    },
    {
      "question": "A U-tube manometer has mercury columns of heights 20 cm and 25 cm. What is the pressure difference ΔP?",
      "options": ["13.3 kPa", "26.6 kPa", "39.9 kPa", "53.2 kPa"],
      "correctAnswer": 1,
      "explanation": "ΔP = ρ_Hg × g × Δh = 13,600 × 9.8 × 0.05 = 6,664 Pa (6.7 kPa). Δh = 25 cm - 20 cm = 5 cm = 0.05 m."
    },
    {
      "question": "Which best describes why hydraulic systems work?",
      "options": ["Pressure increases with depth in fluids", "Incompressible fluid transmits pressure instantly", "Fluids push harder in narrower spaces", "Small forces on large areas create huge forces"],
      "correctAnswer": 1,
      "explanation": "Hydraulics work because confined fluids transmit pressure INSTANTLY throughout. Since fluid is nearly incompressible, pressure applied anywhere is transmitted everywhere immediately."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'fluid-mechanics' LIMIT 1),
  'Bernoulli''s Equation',
  'bernoullis-equation',
  3,
  '# Bernoulli''s Equation

**Bernoulli''s equation** relates pressure, speed, and height in flowing fluids!

## The Equation

$$P_1 + \frac{1}{2}\rho v_1^2 + \rho g h_1 = P_2 + \frac{1}{2}\rho v_2^2 + \rho g h_2$$

Assumptions:
- **Incompressible** fluid (constant $\rho$)
- **Steady flow** (no turbulence)
- **No friction** (no energy loss)
- **No height change** (horizontal, $\Delta h = 0$)

> 💡 **Energy conservation**: KE converts to PE/pressure work!

## Terms in Bernoulli''s Equation

| Symbol | Meaning | Units |
|---------|----------|--------|
| $P_1, P_2$ | Pressure at points 1 and 2 | Pa (N/m²) |
| $\rho$ | Fluid density | kg/m³ | Constant (given) |
| $v_1, v_2$ | Fluid speed at points 1 and 2 | m/s |
| $h_1, h_2$ | Height at points 1 and 2 | m |

## Simplified Form

**Faster fluid → LOWER pressure**:

$$P + \frac{1}{2}\rho v^2 = \text{constant}$$

## Applications

### 1. Airplane Wing

**Lift comes from pressure difference**:

- **Top curve**: Longer path, slower speed, HIGHER pressure
- **Bottom curve**: Shorter path, faster speed, LOWER pressure

$$F_{lift} = (P_{below} - P_{above}) A_{wing}$$

### 2. Venturi Meter

**Constriction** → speed increase → pressure **DROP**:

```
  Wide pipe → Slow flow (P₁, v₁)
     ↓  ↓
    ╲  ╱ ╲
  Narrow pipe → Fast flow (P₂, v₂)
    ↓  ↓
```

### 3. Perfume Atomizer

**Bernoulli acceleration** sprays perfume!

Fast air over tube creates low pressure, draws fluid up.

### 4. Curveball Pitch

**Topspin** → ball drops (faster on top, lower P, curves down)

**Backspin** → ball rises (slower on top, higher P, curves up)

---

**Key Terms**:
- **Bernoulli''s equation**: Energy conservation in fluids: $P + ½ρv² + ρgh = constant$
- **Venturi effect**: Speed increase through constriction causes pressure drop
- **Airfoil**: Wing shape creating pressure difference for lift',
  '[
    {
      "question": "In Bernoulli''s equation, P + ½ρv² + ρgh represents:",
      "options": ["Total energy", "Total pressure", "Dynamic pressure (moving fluid) only", "Static pressure (ρgh) only"],
      "correctAnswer": 0,
      "explanation": "The sum P + ½ρv² + ρgh represents total mechanical energy per unit volume, which is CONSERVED in steady, incompressible, frictionless flow along a streamline."
    },
    {
      "question": "According to Bernoulli''s principle, where is pressure LOWEST in a flowing fluid?",
      "options": ["Where velocity is highest", "Where height is greatest", "Where the tube is narrowest", "Where fluid is densest"],
      "correctAnswer": 0,
      "explanation": "Where velocity is HIGHEST (v² is maximum), the ½ρv² term is SMALLEST, so P = constant - ½ρv² is MINIMUM. Fast fluid = lowest pressure!"
    },
    {
      "question": "A Venturi meter has a wide section (v₁=5 m/s) and narrow throat (v₂=15 m/s). What happens to pressure?",
      "options": ["Pressure increases in throat", "Pressure drops in throat", "Pressure stays the same", "Cannot determine from speeds alone"],
      "correctAnswer": 1,
      "explanation": "P + ½ρv² = constant. Narrow section: ½ρ(15)² = 112.5ρ. Wide: ½ρ(5)² = 12.5ρ. Since 15 > 5, the narrow term is LARGER, so P₂ = constant - larger term = LOWER pressure."
    },
    {
      "question": "How does an airplane wing generate lift?",
      "options": ["By creating a vacuum above the wing", "By having higher pressure below than above", "By pushing air downward", "By using the engine thrust directly"],
      "correctAnswer": 1,
      "explanation": "Wings are shaped so air flows FASTER over the top curved surface (longer path) creating LOWER pressure (P₂) than the flatter bottom surface (P₁). This pressure difference creates upward LIFT force."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'fluid-mechanics' LIMIT 1),
  'Viscosity and Turbulence',
  'viscosity-turbulence',
  4,
  '# Viscosity and Turbulence

**Viscosity** = fluid resistance to flow!

## Viscosity

**Viscosity** ($\eta$) = resistance to shear deformation

$$\eta = \frac{F/A}{\Delta v/\Delta y}$$

Where:
- $F/A$ = shear stress (force ÷ area)
- $\Delta v/\Delta y$ = velocity gradient (s⁻¹, 1/s)

### Viscosity Comparisons

| Fluid | Temp (°C) | Viscosity (Pa·s) | Flow Behavior |
|--------|---------------|-------------------|-----------------|
| **Water** | 20 | 0.001 | Low viscosity, flows easily |
| **Olive oil** | 20 | 0.084 | Medium viscosity |
| **SAE 30 motor oil** | 20 | 0.2-0.3 | Higher viscosity |
| **Honey** | 20 | ~10 | Very high viscosity |
| **Peanut butter** | 20 | ~100 | Extremely viscous |
| **Air** | 20 | ~0.00002 | Negligible viscosity |

> 💡 **Temperature effect**: Viscosity $\propto 1/T$ (hotter = less viscous!)

### Reynolds Number

Predicts flow regime:

$$\text{Re} = \frac{\rho v D}{\eta}$$

Where:
- $\rho$ = fluid density (kg/m³)
- $v$ = flow velocity (m/s)
- $D$ = characteristic length (m)
- $\eta$ = dynamic viscosity (Pa·s)

| Re | Flow Type |
|----|-----------|
| **Re < 2000** | Laminar (smooth) |
| **Re > 4000** | Turbulent (chaotic) |

### Example

Water ($\eta = 0.001$ Pa·s) through 1 cm pipe ($D = 0.01$ m) at $v = 1$ m/s:

$$\text{Re} = \frac{(1000)(1)(0.01)}{0.001} = \mathbf{10,\!000\text{ (laminar)}$$

> ✅ **Smooth flow** = predictable streamlines!

## Turbulence

**Turbulence** = chaotic, irregular fluid motion

**Characteristics**:
- **Eddies** swirling through fluid
- **Unpredictable** mixing and fluctuations
- **Energy waste** increases drag

### Causes

| Source | Example |
|---------|----------|
| **High Re flow** | Fast water, blood vessels |
| **Rough surfaces** | Golf balls, aircraft wings |
| **Obstructions** | Rocks, buildings in wind |
| **Mixing fluids** | Jets, exhausts |

### Drag in Turbulent Flow

$$F_d = \frac{1}{2} C_d A v^2$$

Where:
- $F_d$ = drag force (N)
- $C_d$ = drag coefficient (depends on shape)
- $A$ = cross-sectional area (m²)
- $v$ = flow speed (m/s)
- $\rho$ = fluid density (kg/m³)

---

**Key Terms**:
- **Viscosity ($\eta$)**: Fluid resistance to shear ($\eta = \tau/(\Delta v/\Delta y)$)
- **Reynolds number (Re)**: $\rho v D/\eta$ predicts laminar (Re < 2000) vs turbulent flow
- **Laminar flow**: Smooth, predictable streamlines (low Re)
- **Turbulence**: Chaotic, mixing flow with eddies (high Re)',
  '[
    {
      "question": "Which has HIGHEST viscosity?",
      "options": ["Water (0.001 Pa·s)", "Honey (~100 Pa·s)", "SAE 30 oil (0.3 Pa·s)", "Peanut butter (~100 Pa·s)"],
      "correctAnswer": 1,
      "explanation": "Honey has extremely high viscosity (~100 Pa·s at 20°C). This means it resists flow strongly - 100× more than water!"
    },
    {
      "question": "Water flows through a 1 cm pipe at 1 m/s. What is the Reynolds number? (ρ=1000 kg/m³, D=0.01 m)",
      "options": ["100", "1,000", "10,000", "100,000 (turbulent)"],
      "correctAnswer": 1,
      "explanation": "Re = ρvD/η = (1000)(1)(0.01)/0.001 = 10,000. This is at the boundary between laminar and turbulent flow."
    },
    {
      "question": "Why does turbulence increase drag?",
      "options": ["Turbulence creates chaotic motion that resists flow", "Eddies in the flow increase the effective cross-sectional area", "Turbulent mixing transfers momentum to the fluid more efficiently", "Turbulence creates pressure fluctuations that increase form drag"],
      "correctAnswer": 0,
      "explanation": "Turbulence creates eddies (swirling vortices) that increase momentum transfer to the fluid, effectively increasing the fluid''s inertia and resistance to flow."
    },
    {
      "question": "Which statement about viscosity is TRUE?",
      "options": ["Viscosity increases with temperature", "Higher viscosity means more resistance to flow", "Laminar flow occurs at low Reynolds numbers only", "Gases have zero viscosity"],
      "correctAnswer": 1,
      "explanation": "For liquids, viscosity DECREASES with temperature (inverse relationship). Higher T = thinner fluid = less viscous. Gases have essentially zero viscosity."
    }
  ]',
  NOW()
),
(
  UUID_GENERATE_V4(),
  (SELECT id FROM chapters WHERE slug = 'fluid-mechanics' LIMIT 1),
  'Surface Tension',
  'surface-tension',
  5,
  '# Surface Tension

**Surface tension** = elastic tendency at fluid interface!

## What is Surface Tension?

**Surface tension** ($\gamma$) = force per unit length along liquid surface

$$\gamma = \frac{F}{L}$$

Where:
- $\gamma$ = surface tension (N/m)
- $F$ = force (N)
- $L$ = length (m)

> 💡 **Minimizes surface area** - like an invisible elastic skin!

## Molecular Origin

**Cohesive forces** between liquid molecules pull surface inward

| Liquid | $\gamma$ (N/m) | Force (mN/m) |
|---------|---------------|-------------------|
| **Water** | 0.073 | 72 | H-bonding |
| **Mercury** | 0.487 | 487 | Metallic bonding |
| **Ethanol** | 0.022 | 22 | Hydrogen bonding |
| **Helium** | 0.00037 | 0.37 | Weak London forces |

> 🌡 **Stronger intermolecular forces = higher $\gamma$**

## Capillary Action

**Capillary rise** in thin tube:

$$h = \frac{2\gamma \cos\theta}{\rho g r}$$

Where:
- $h$ = rise height (m)
- $\gamma$ = surface tension (N/m)
- $\theta$ = contact angle (°)
- $\rho$ = liquid density (kg/m³)
- $r$ = tube radius (m)
- $g$ = 9.8 m/s²

### Examples

| Liquid | $\gamma$ (mN/m) | Rise in 0.5 mm tube |
|---------|---------------|----------------------|
| **Water** | 0.073 | 14 cm |
| **Mercury** | 0.487 | 5 cm |
| **Ethanol** | 0.022 | 3.3 cm |

> 💡 **Smaller tube = higher rise** (proportional to 1/r)!

## Contact Angle

**Jurin''s law** for wetting:

$$\cos\theta = \frac{\gamma_{SG}}{\gamma_{SL}}$$

Where:
- $\theta$ = contact angle
- $\gamma_{SG}$ = solid-gas tension
- $\gamma_{SL}$ = solid-liquid tension

**Perfect wetting**: $\theta = 0°$ (cos $\theta$ = 1)

### Examples

| Material Pair | $\cos\theta$ | $\theta$ |
|--------------|-----------|-------|
| **Water-glass** | ~1.0 | 0° |
| **Mercury-glass** | ~0.3 | 139° |
| **Water-mercury** | ~1.0 | 149° |

> 💡 **Superhydrophobic**: Mercury doesn''t wet glass ($\theta > 90°$)!

---

**Key Terms**:
- **Surface tension ($\gamma$)**: Force per unit length along liquid surface (N/m)
- **Capillary action**: Fluid rise in narrow tube ($h = 2\gamma\cos\theta/\rho g r$)
- **Contact angle**: Angle between liquid and solid surface
- **Wetting**: Spreading of liquid on solid ($\cos\theta = \gamma_{SL}/\gamma_{SG}$)',
  '[
    {
      "question": "Surface tension is caused by:",
      "options": ["Gravitational forces pulling liquid molecules down", "Cohesive forces between liquid molecules", "Air pressure pushing on the liquid surface", "Electrical attractions between polar molecules"],
      "correctAnswer": 1,
      "explanation": "Surface tension is caused by COHESIVE forces between liquid molecules. These intermolecular attractions (like hydrogen bonds, van der Waals forces) pull molecules toward the liquid interior, creating surface tension."
    },
    {
      "question": "Water (γ=0.073 N/m) rises 14 cm in a 0.5 mm radius glass tube. Mercury (γ=0.487 N/m) would rise:",
      "options": ["5.0 cm", "7.0 cm", "10.0 cm", "14.0 cm"],
      "correctAnswer": 0,
      "explanation": "h = 2γcosθ/ρgr = 2(0.487)(1)/(13,600×9.8×0.0005). Mercury: 2(0.487)(0.999)/(13,600×9.8×0.0005) = 0.050 m = 5.0 cm (higher γ, but also much denser ρ)"
    },
    {
      "question": "What is capillary action?",
      "options": ["Fluid being pulled up a narrow tube", "Fluid flowing out of a porous material", "Fluid spreading as a thin film on a surface", "Fluid evaporating from a free surface"],
      "correctAnswer": 0,
      "explanation": "Capillary action is when a liquid rises in a narrow tube (or porous material) due to surface tension overcoming gravity. The narrower the tube, the higher the rise."
    },
    {
      "question": "Why does mercury NOT wet glass?",
      "options": ["Mercury has zero surface tension", "Mercury has very high cohesive forces (mercury-mercury bonds stronger than glass-glass bonds)", "Mercury is too dense to rise effectively"],
      "correctAnswer": 1,
      "explanation": "Mercury has extremely strong cohesive (Hg-Hg) metallic bonds (γ_Hg-Hg ≈ 0) that are STRONGER than mercury-glass adhesive forces. Since γ_mercury < γ_glass, cos θ > 1 is impossible, so mercury beads up (superhydrophobic)."
    }
  ]',
  NOW()
);