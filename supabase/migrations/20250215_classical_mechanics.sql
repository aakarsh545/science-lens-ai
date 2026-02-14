-- Classical Mechanics Course Migration
-- 10 chapters, 10 lessons each = 100 lessons total
-- Category: Physics
-- Difficulty: Beginner

-- Insert course
INSERT INTO courses (id, slug, title, description, category, difficulty, lesson_count, order_index, created_at)
VALUES (
  'classical-mechanics-uuid',
  'classical-mechanics',
  'Classical Mechanics',
  'Master the fundamental principles of motion and forces. From vectors to projectile motion, Newton''s laws to energy and momentum - build the foundation for all of physics.',
  'Physics',
  'beginner',
  100,
  1,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

-- ============================================================================
-- CHAPTER 1: Introduction to Mechanics
-- ============================================================================

INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch1-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Introduction to Mechanics',
  'Build the foundational language and tools for describing motion. Learn about scalars vs vectors, master unit conversions, understand displacement versus distance, and analyze one-dimensional motion with constant acceleration before progressing to two-dimensional projectile motion.',
  1,
  NOW()
) ON CONFLICT DO NOTHING;

-- Lesson 1.1: Scalars, Vectors, and Units
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
  'classical-mechanics-ch1-l1-uuid',
  (SELECT id FROM chapters WHERE id = 'classical-mechanics-ch1-uuid'),
  'scalars-vectors-units',
  'Scalars, Vectors, and Units',
  '{
    "learningObjectives": [
      "Distinguish between scalar and vector quantities",
      "Perform dimensional analysis to check equation validity",
      "Convert between different unit systems confidently",
      "Add and subtract vectors using both graphical and component methods",
      "Understand why vectors are essential for describing motion"
    ],
    "prerequisites": [
      "Basic arithmetic and algebra",
      "Simple trigonometry (sine, cosine, tangent)",
      "The Pythagorean theorem",
      "Working with negative numbers"
    ],
    "whyThisMatters": "Before we can describe how things move, we need a precise language for talking about physical quantities. You might say \"the car is going fast,\" but that''s not enough for physics. We need to know exactly how fast, in what direction, and in what units we''re measuring. This lesson gives you the foundational vocabulary and tools for all of mechanics.",
    "parts": [
      {
        "title": "Part 1: Understanding Scalars and Vectors",
        "content": "A scalar is a quantity that has only magnitude—just a number with units. When someone tells you \"the temperature is 25 degrees Celsius,\" they''ve given you complete information. Temperature doesn''t have a direction; it''s just a value.\n\nExamples of scalar quantities:\n- Temperature: 25°C, 98.6°F\n- Mass: 5 kilograms, 150 pounds\n- Time: 10 seconds, 3 hours\n- Speed: 60 miles per hour (notice: speed, not velocity!)\n- Energy: 100 joules\n- Volume: 2 liters\n\nScalars follow ordinary arithmetic. If you have 5 kilograms of flour and add 3 kilograms more, you have 8 kilograms total. Simple addition works because there''s no directional aspect to worry about.\n\nA vector is a quantity that has both magnitude and direction. If someone says \"the wind is blowing at 20 miles per hour,\" you naturally want to ask: \"In which direction?\" Without knowing direction, you don''t have complete information.\n\nExamples of vector quantities:\n- Displacement: 5 meters to the north\n- Velocity: 60 miles per hour heading east\n- Acceleration: 9.8 meters per second squared downward\n- Force: 50 newtons pushing to the right\n- Momentum: related to both how fast something moves and in what direction",
        "subsections": [
          {
            "title": "Speed versus Velocity: A Critical Distinction",
            "content": "**Speed** is a scalar. It tells you how fast something is moving but not where it''s going. Your car''s speedometer shows speed—it reads 60 mph whether you''re heading north, south, or driving in circles.\n\n**Velocity** is a vector. It tells you both how fast and in what direction. If two cars are both traveling at 60 mph but one is heading north and the other south, they have the same speed but different velocities.\n\nHere''s why this matters: If you''re traveling in a circle at constant speed, your velocity is constantly changing (because your direction keeps changing), even though your speed stays the same. This will become crucial when we study circular motion later."
          }
        ]
      },
      {
        "title": "Part 2: The SI System of Units",
        "content": "Physics uses the International System of Units (SI), which is based on the metric system. Understanding units isn''t just bureaucracy—it''s essential for making sure your calculations make physical sense.\n\n**The Seven Base SI Units:**\n1. **Length**: meter (m)\n2. **Mass**: kilogram (kg)\n3. **Time**: second (s)\n4. **Electric current**: ampere (A)\n5. **Temperature**: kelvin (K)\n6. **Amount of substance**: mole (mol)\n7. **Luminous intensity**: candela (cd)\n\nFor mechanics, we primarily use the first three: meters, kilograms, and seconds. These are often called the \"MKS\" system.\n\n**Common Prefixes:**\n- giga (G) = 10⁹ = 1,000,000,000\n- mega (M) = 10⁶ = 1,000,000\n- kilo (k) = 10³ = 1,000\n- centi (c) = 10⁻² = 0.01\n- milli (m) = 10⁻³ = 0.001\n- micro (μ) = 10⁻⁶ = 0.000001\n- nano (n) = 10⁻⁹ = 0.000000001\n\nSo 1 kilometer = 1000 meters, and 1 millimeter = 0.001 meters."
      },
      {
        "title": "Part 3: Dimensional Analysis",
        "content": "Every physical equation must be dimensionally consistent. This means the units on both sides of the equation must match. This principle is incredibly powerful for checking whether an equation could possibly be correct.\n\nLet''s look at an example. Suppose someone claims that the distance traveled by a car is given by:\n\ndistance = speed × time²\n\nIs this possible? Let''s check the dimensions:\n- Distance has dimensions of length: [L]\n- Speed has dimensions of length per time: [L]/[T]\n- Time has dimensions of... time: [T]\n\nSo the right side gives us: [L]/[T] × [T]² = [L][T]\n\nThe left side is [L], but the right side is [L][T]. These don''t match! The equation cannot be correct. The correct formula is actually distance = speed × time, which gives [L] = ([L]/[T]) × [T] = [L]. Now both sides match.\n\nThis technique has saved countless physicists from embarrassing mistakes. Before you accept any equation, check that the dimensions work out."
      },
      {
        "title": "Part 4: Adding Vectors Graphically",
        "content": "Vectors don''t add like ordinary numbers because direction matters. If you walk 3 meters north and then 4 meters north, you''ve gone 7 meters north total—that''s straightforward. But what if you walk 3 meters north and then 4 meters east? You certainly haven''t traveled 7 meters north!\n\n**The Tip-to-Tail Method:**\n1. Draw the first vector as an arrow\n2. Draw the second vector starting from the tip of the first arrow\n3. The sum (called the resultant) is the vector from the tail of the first to the tip of the last\n\n**Worked Example 3: Adding Perpendicular Vectors**\n**Problem**: You walk 3.0 meters north, then 4.0 meters east. What is your displacement from your starting point?\n\n**Solution**:\n\nGraphically, we draw an arrow 3.0 meters pointing north, then from its tip, we draw an arrow 4.0 meters pointing east. The displacement is the straight-line arrow from start to finish.\n\nThis forms a right triangle! We can use the Pythagorean theorem:\n\nMagnitude of displacement = √(3.0² + 4.0²) = √(9.0 + 16.0) = √25.0 = 5.0 meters\n\nThe direction can be found using trigonometry. If we measure the angle θ from north toward east:\n\ntan(θ) = opposite/adjacent = 4.0/3.0 = 1.33\nθ = arctan(1.33) = 53°\n\nSo your displacement is **5.0 meters at 53° east of north**.\n\nNotice that 3 + 4 = 7, but vector addition gives us 5. The magnitude of the sum of two vectors is not generally equal to the sum of their magnitudes. Direction matters!",
        "examples": [
          {
            "problem": "A car travels at 72 kilometers per hour. What is this speed in meters per second?",
            "solution": "First, let''s convert kilometers to meters:\n- 1 kilometer = 1000 meters\n- So 72 km = 72 × 1000 m = 72,000 m\n\nNow convert hours to seconds:\n- 1 hour = 60 minutes\n- 1 minute = 60 seconds\n- So 1 hour = 60 × 60 = 3600 seconds\n\nTherefore:\n72 km/hr = 72,000 m / 3600 s = 20 m/s\n\n**Memory trick**: To quickly convert km/hr to m/s, divide by 3.6. To go the other way, multiply by 3.6."
          },
          {
            "problem": "A rectangular room measures 5.0 meters by 4.0 meters. What is its area in square centimeters?",
            "solution": "First, find the area in square meters:\nArea = 5.0 m × 4.0 m = 20 m²\n\nNow convert to square centimeters. Be careful—this is where many students make mistakes!\n\nSince 1 m = 100 cm, you might think 1 m² = 100 cm². But that''s wrong!\n\nThe correct conversion is:\n1 m² = (1 m)² = (100 cm)² = 10,000 cm²\n\nTherefore:\n20 m² = 20 × 10,000 cm² = 200,000 cm²\n\n**Why this matters**: Always square (or cube) your conversion factor when dealing with area (or volume). This is a very common source of errors."
          }
        ]
      },
      {
        "title": "Part 5: Vector Components",
        "content": "The graphical method works, but it''s not practical for complex problems. The component method is more powerful and forms the basis for almost all vector calculations in physics.\n\n**What Are Components?**\n\nAny vector can be broken down into perpendicular components—typically horizontal (x) and vertical (y) components. These components are the vector''s \"shadow\" along each axis.\n\nFor a vector **A** at angle θ from the positive x-axis:\n- Horizontal component: Aₓ = A cos(θ)\n- Vertical component: Aᵧ = A sin(θ)\n\nwhere A is the magnitude of the vector.\n\nGoing the other direction, if you know the components:\n- Magnitude: A = √(Aₓ² + Aᵧ²)\n- Direction: θ = arctan(Aᵧ/Aₓ)",
        "examples": [
          {
            "problem": "A bird flies with velocity 15 m/s at an angle of 30° above the horizontal. What are the horizontal and vertical components of its velocity?",
            "solution": "**Given:**\n- Magnitude: v = 15 m/s\n- Angle: θ = 30° above the horizontal\n\n**Horizontal component:**\nvₓ = v cos(θ) = 15 × cos(30°) = 15 × 0.866 = 13.0 m/s\n\n**Vertical component:**\nvᵧ = v sin(θ) = 15 × sin(30°) = 15 × 0.500 = 7.5 m/s\n\nThe bird is moving at 13.0 m/s horizontally and 7.5 m/s vertically.\n\n**Check**: Does √(13.0² + 7.5²) = √(169 + 56.25) = √225.25 ≈ 15 m/s? Yes!"
          }
        ]
      }
    ],
    "commonMisconceptions": [
      {
        "misconception": "\"Speed and velocity are the same thing.\"",
        "reality": "Speed is how fast you''re going (scalar). Velocity includes direction (vector). A car going around a curve at constant speed has changing velocity because its direction changes."
      },
      {
        "misconception": "\"When you add vectors, you just add their magnitudes.\"",
        "reality": "Direction matters! Two forces of 10 N each could combine to give anywhere from 0 N (if opposite) to 20 N (if same direction) depending on their directions."
      },
      {
        "misconception": "\"Units don''t matter as long as you get the right number.\"",
        "reality": "An answer without units is meaningless in physics. Is a speed of \"50\" fast? Not if it''s 50 meters per year! Always include units and make sure they''re correct."
      },
      {
        "misconception": "\"The magnitude of a vector sum equals the sum of the magnitudes.\"",
        "reality": "In general, |**A** + **B**| ≤ |**A**| + |**B**|. Equality holds only when the vectors point in exactly the same direction."
      }
    ],
    "practiceProblems": [
      {
        "problem": "Convert 25 m/s to km/hr.",
        "solution": "25 m/s × (1 km / 1000 m) × (3600 s / 1 hr) = 25 × 3.6 km/hr = 90 km/hr"
      },
      {
        "problem": "A box measures 50 cm × 30 cm × 20 cm. What is its volume in cubic meters?",
        "solution": "First convert to meters: 0.50 m × 0.30 m × 0.20 m = 0.030 m³"
      },
      {
        "problem": "You walk 100 meters north, then 100 meters west. What is your displacement?",
        "solution": "This forms a right triangle with legs of 100 m each.\nMagnitude = √(100² + 100²) = √20,000 = 141 m\nDirection = 45° west of north (or 45° north of west)"
      },
      {
        "problem": "A velocity vector has magnitude 20 m/s and points 60° above the horizontal. Find its horizontal and vertical components.",
        "solution": "Horizontal: vₓ = 20 × cos(60°) = 20 × 0.5 = 10 m/s\nVertical: vᵧ = 20 × sin(60°) = 20 × 0.866 = 17.3 m/s"
      },
      {
        "problem": "Three forces act on an object: 10 N east, 8 N north, and 6 N west. What is the net force?",
        "solution": "x-components: 10 - 6 = 4 N east\ny-components: 8 N north\nMagnitude = √(4² + 8²) = √80 = 8.94 N\nDirection = arctan(8/4) = 63.4° north of east"
      }
    ],
    "furtherStudy": [
      "**Reading**: Any introductory physics textbook chapter on kinematics (Halliday & Resnick, Young & Freedman, or Giancoli)",
      "**Video**: Khan Academy''s \"Introduction to Vectors and Scalars\"",
      "**Practice**: Work through at least 10-15 vector addition problems before moving on"
    ]
  }',
  1,
  NOW()
) ON CONFLICT DO NOTHING;

-- Lesson 1.2: One-Dimensional Motion
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
  'classical-mechanics-ch1-l2-uuid',
  (SELECT id FROM chapters WHERE id = 'classical-mechanics-ch1-uuid'),
  'one-dimensional-motion',
  'One-Dimensional Motion',
  '{
    "learningObjectives": [
      "Use kinematic equations to solve motion problems in one dimension",
      "Distinguish between position, displacement, velocity, and acceleration",
      "Interpret position-time and velocity-time graphs",
      "Solve problems involving constant acceleration",
      "Understand the physical meaning of negative velocity and acceleration"
    ],
    "prerequisites": [
      "Lesson 1.1: Vectors and scalars",
      "Basic algebra (solving equations, quadratic formula)",
      "Understanding of graphs and slopes"
    ],
    "whyThisMatters": "One-dimensional motion is the simplest type of motion—movement along a straight line. Before we can analyze complex motions in two or three dimensions, we need to master the one-dimensional case thoroughly. Nearly every principle we learn here will extend to more complex situations later.",
    "parts": [
      {
        "title": "Part 1: Position, Displacement, and Distance",
        "content": "**Position** tells you where an object is located. To specify position, you need a reference point (the origin) and a coordinate system. In one dimension, position is just a single number with units of length.\n\n**Displacement** is the change in position. It''s a vector quantity (even in one dimension, it can be positive or negative).\n\nDisplacement = Δx = x_final - x_initial\n\nThe Greek letter Δ (delta) means \"change in.\" So Δx means \"change in x\" or \"final x minus initial x.\"\n\n**Important**: Displacement is not the same as distance traveled!\n\n**Distance vs. Displacement: A Crucial Difference:**\n\n**Distance** is the total length of path traveled (scalar, always positive).\n\n**Displacement** is the straight-line change in position from start to finish (vector, can be positive, negative, or zero).\n\nConsider this example: You walk 5 meters east, then 3 meters west.\n- Distance traveled: 5 + 3 = 8 meters\n- Displacement: +5 + (-3) = +2 meters east (or simply 2 meters east)\n\nIf you walk 5 meters east and then 5 meters back west:\n- Distance traveled: 10 meters\n- Displacement: 0 meters (you ended where you started)\n\nThis distinction becomes crucial when we discuss velocity versus speed."
      },
      {
        "title": "Part 2: Velocity and Speed",
        "content": "**Average Velocity:**\nv_avg = Δx / Δt = (x_final - x_initial) / (t_final - t_initial)\n\nSince displacement is a vector, velocity is also a vector. In one dimension, the sign tells you the direction:\n- Positive velocity means motion in the positive direction\n- Negative velocity means motion in the negative direction\n\n**Average Speed:**\nspeed_avg = distance / time\n\nSpeed is always positive or zero (it''s a scalar). You cannot have negative speed.",
        "examples": [
          {
            "problem": "A car travels from position x = 0 m to x = 100 m in 5 seconds, then back to x = 40 m in another 3 seconds. Find (a) average velocity for the entire trip, and (b) average speed for the entire trip.",
            "solution": "**Car motion from 0 to 100 m:**\nTime: Δt = 5 s\nDisplacement: Δx = 100 - 0 = 100 m\nVelocity: v = 100/5 = 20 m/s\n\n**Car motion from 100 m to 40 m:**\nDistance traveled: |100 - 40| = 60 m\nTime: Δt = 3 s\nVelocity: v = (40 - 100)/3 = -20 m/s\n\n**(a) Average velocity:**\nTotal displacement: 40 - 0 = 40 m\nTotal time: 5 + 3 = 8 s\nv_avg = 40/8 = 5.0 m/s\n\n**(b) Average speed:**\nTotal distance: 100 + 60 = 160 m\nTotal time: 8 s\nspeed_avg = 160/8 = 20 m/s\n\nNotice that the average speed (20 m/s) is much larger than the average velocity (5.0 m/s) because the car backtracked."
          }
        ]
      },
      {
        "title": "Part 3: Acceleration",
        "content": "Acceleration is the rate of change of velocity. Just as velocity measures how quickly position changes, acceleration measures how quickly velocity changes.\n\n**Average Acceleration:**\na_avg = Δv / Δt = (v_final - v_initial) / (t_final - t_initial)\n\nAcceleration is a vector. In one dimension:\n- Positive acceleration means velocity is becoming more positive\n- Negative acceleration means velocity is becoming more negative\n\n**Critical misconception**: Negative acceleration does NOT always mean \"slowing down\"!\n\nConsider these cases:\n1. Moving forward (+) and speeding up: positive velocity, positive acceleration\n2. Moving forward (+) and slowing down: positive velocity, negative acceleration\n3. Moving backward (-) and speeding up backward: negative velocity, negative acceleration\n4. Moving backward (-) and slowing down: negative velocity, positive acceleration\n\nAn object is \"slowing down\" when velocity and acceleration have opposite signs. It''s \"speeding up\" when they have the same sign.",
        "examples": [
          {
            "problem": "A car is moving east (positive direction) at 20 m/s. It applies brakes and comes to rest in 4 seconds. What is the acceleration?",
            "solution": "Initial velocity: v₀ = +20 m/s (eastward)\nFinal velocity: v = 0 m/s\nTime interval: Δt = 4 s\n\na = (v - v₀) / Δt = (0 - 20) / 4 = -5 m/s²\n\nThe acceleration is negative. But notice: the car was moving in the positive direction and slowing down. Negative acceleration here means the acceleration vector points opposite to the velocity vector, which causes slowing."
          }
        ]
      },
      {
        "title": "Part 4: Motion with Constant Acceleration",
        "content": "When acceleration is constant, motion follows predictable patterns described by kinematic equations. These equations are among the most important in all of introductory physics.\n\n**The Kinematic Equations:**\n\nFor motion with constant acceleration along a straight line, we have five key equations:\n\n1. v = v₀ + at\n2. x = x₀ + v₀t + ½at²\n3. v² = v₀² + 2a(x - x₀)\n4. x = x₀ + ½(v₀ + v)t\n5. x = x₀ + vt - ½at²\n\nWhere:\n- x = position at time t\n- x₀ = initial position at t = 0\n- v = velocity at time t\n- v₀ = initial velocity at t = 0\n- a = constant acceleration\n- t = time\n\n**You don''t need to memorize all five**. Equations 1-3 are the most fundamental. Equation 4 is useful because it doesn''t involve acceleration, and equation 5 is just a rearrangement.\n\n**Which Equation Should I Use?**\n\nChoose the equation that contains the variable you''re solving for and doesn''t contain a variable you don''t know.\n\nEach equation involves four of the five kinematic variables (x, x₀, v, v₀, a, t). The equation that''s missing the variable you don''t know (and don''t need) is usually your best choice."
      },
      {
        "title": "Part 5: Graphical Analysis of Motion",
        "content": "**Position-Time Graphs:**\n\nOn a position-time (x vs t) graph:\n- The slope at any point gives the instantaneous velocity\n- A steeper slope means higher speed\n- A horizontal line (zero slope) means the object is at rest\n- Positive slope means motion in the positive direction\n- Negative slope means motion in the negative direction\n\n**Velocity-Time Graphs:**\n\nOn a velocity-time (v vs t) graph:\n- The slope at any point gives the instantaneous acceleration\n- The area under the curve gives the displacement\n- A horizontal line means constant velocity (zero acceleration)\n- A line with positive slope means positive acceleration\n- A line with negative slope means negative acceleration"
      }
    ],
    "commonMisconceptions": [
      {
        "misconception": "\"Negative acceleration always means slowing down.\"",
        "reality": "Negative acceleration means acceleration in the negative direction. Whether this causes slowing depends on the direction of velocity. If velocity is positive, negative acceleration does cause slowing. If velocity is negative, negative acceleration causes speeding up (in the negative direction)."
      },
      {
        "misconception": "\"Acceleration and velocity must have the same sign.\"",
        "reality": "When acceleration and velocity have the same sign, the object speeds up. When they have opposite signs, the object slows down. Both situations are common."
      },
      {
        "misconception": "\"If acceleration is zero, velocity must be zero.\"",
        "reality": "Zero acceleration means velocity is constant, not zero. An object can move at constant velocity (like a car cruising on a highway) with zero acceleration."
      },
      {
        "misconception": "\"Distance and displacement are the same thing.\"",
        "reality": "Distance is the total path length traveled (scalar, always positive). Displacement is the net change in position from start to end (vector, can be positive, negative, or zero)."
      }
    ],
    "practiceProblems": [
      {
        "problem": "A car accelerates from rest to 30 m/s in 6 seconds. What is its acceleration? How far does it travel during this time?",
        "solution": "a = (v - v₀)/t = (30 - 0)/6 = 5 m/s²\nx = v₀t + ½at² = 0 + ½(5)(36) = 90 m"
      },
      {
        "problem": "A ball is thrown straight up with initial velocity 20 m/s. How high does it go? (Use g = 10 m/s²)",
        "solution": "At maximum height, v = 0:\nv² = v₀² + 2a(y - y₀)\n0 = 20² + 2(-10)(y_max - 0)\ny_max = 20 m"
      },
      {
        "problem": "At t = 0, object A is at x = 0 moving at 10 m/s. Object B is at x = 100 m moving at -5 m/s (toward A). When and where do they meet?",
        "solution": "x_A = 10t\nx_B = 100 - 5t\nWhen they meet: 10t = 100 - 5t → 15t = 100 → t = 6.67 s\nPosition: x = 10(6.67) = 66.7 m"
      },
      {
        "problem": "A position-time graph shows x = 5t - 2t² (in SI units). What is the velocity at t = 1 s? When is the object at rest?",
        "solution": "v = dx/dt = 5 - 4t\nAt t = 1: v = 5 - 4(1) = 1 m/s\nAt rest when v = 0: 5 - 4t = 0 → t = 1.25 s"
      },
      {
        "problem": "An object undergoes motion with velocity v(t) = 8 - 2t m/s. When is it moving backward? What is its maximum displacement from the origin?",
        "solution": "Moving backward when v < 0: 8 - 2t < 0 → t > 4 s\nMaximum displacement at v = 0: t = 4 s\nx = ∫v dt = 8t - t² (assuming x₀ = 0)\nAt t = 4: x = 8(4) - 16 = 16 m"
      }
    ]
  }',
  2,
  NOW()
) ON CONFLICT DO NOTHING;

-- Lesson 1.3: Two-Dimensional Motion (Projectile Motion)
INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
VALUES (
  'classical-mechanics-ch1-l3-uuid',
  (SELECT id FROM chapters WHERE id = 'classical-mechanics-ch1-uuid'),
  'two-dimensional-projectile-motion',
  'Two-Dimensional Motion (Projectile Motion)',
  '{
    "learningObjectives": [
      "Analyze motion in two dimensions by treating x and y independently",
      "Solve projectile motion problems systematically",
      "Determine range, maximum height, and time of flight for projectiles",
      "Understand the independence of horizontal and vertical motion",
      "Apply vector concepts to two-dimensional kinematics"
    ],
    "prerequisites": [
      "Lesson 1.1: Vector addition and components",
      "Lesson 1.2: One-dimensional kinematics",
      "Trigonometry (sin, cos, tan)",
      "Comfort with simultaneous equations"
    ],
    "whyThisMatters": "Most real-world motion happens in more than one dimension. A ball thrown through the air, a car turning a corner, a planet orbiting the sun—all involve motion in two or three dimensions. Projectile motion is our first encounter with this complexity, and it introduces a profound principle: perpendicular components of motion are independent of each other.",
    "parts": [
      {
        "title": "Part 1: The Principle of Independence",
        "content": "Here''s one of the most important principles in all of physics: **Motion in perpendicular directions occurs independently.**\n\n**What does this mean?** Consider a ball rolling off a table. Its horizontal motion (rolling forward) continues unchanged while it simultaneously falls vertically. The horizontal motion doesn''t \"know about\" the vertical motion, and vice versa.\n\nThis principle allows us to solve complex two-dimensional problems by breaking them into two simpler one-dimensional problems."
      },
      {
        "title": "Part 2: Setting Up Projectile Motion Problems",
        "content": "**Standard Projectile Motion Setup:**\n\nFor a projectile launched at angle θ above the horizontal with initial speed v₀:\n\n**Horizontal components:**\n- Initial velocity: v₀ₓ = v₀ cos(θ)\n- Acceleration: aₓ = 0 (ignoring air resistance)\n- Position: x = x₀ + v₀ₓt = x₀ + (v₀ cos θ)t\n- Velocity: vₓ = v₀ₓ = v₀ cos(θ) = constant\n\n**Vertical components:**\n- Initial velocity: v₀ᵧ = v₀ sin(θ)\n- Acceleration: aᵧ = -g (taking upward as positive)\n- Position: y = y₀ + v₀ᵧt - ½gt²\n- Velocity: vᵧ = v₀ᵧ - gt\n\n**The Trajectory Equation:**\n\nIf we eliminate time from the position equations, we get the trajectory—the path followed by the projectile:\n\ny = y₀ + (tan θ)x - (g/2v₀²cos²θ)x²\n\nThis is the equation of a parabola. All projectiles follow parabolic paths (when air resistance is negligible)."
      },
      {
        "title": "Part 3: Key Quantities in Projectile Motion",
        "content": "**Time of Flight:**\n\nFor a projectile launched and landing at the same height (y₀ = y_final):\n\nT = (2v₀ sin θ)/g\n\n**Maximum Height:**\n\nAt maximum height, the vertical velocity is zero:\nvᵧ = 0 = v₀ᵧ - gt_top\nt_top = v₀ᵧ/g = (v₀ sin θ)/g\n\nh_max = y₀ + (v₀ sin θ)²/(2g)\n\n**Range:**\n\nThe range is the horizontal distance traveled during the time of flight:\n\nR = v₀ₓ × T = (v₀ cos θ) × (2v₀ sin θ)/g = (v₀² × 2 sin θ cos θ)/g\n\nUsing the trig identity 2 sin θ cos θ = sin(2θ):\n\n**Range**: R = (v₀² sin(2θ))/g\n\nThis formula reveals something interesting: maximum range occurs when sin(2θ) = 1, which means 2θ = 90°, so θ = 45°. A 45° launch angle gives maximum range!"
      },
      {
        "title": "Part 4: Worked Examples",
        "content": "Multiple detailed examples covering projectile motion calculations including time of flight, maximum height, range, and landing velocity.",
        "examples": [
          {
            "problem": "A ball is thrown from ground level with initial speed 25 m/s at an angle of 37° above the horizontal. Find (a) time of flight, (b) maximum height reached, (c) horizontal range, and (d) velocity (magnitude and direction) when it lands.",
            "solution": "**Given:** v₀ = 25 m/s, θ = 37°, g = 10 m/s²\nsin(37°) ≈ 0.60, cos(37°) ≈ 0.80\n\n**(a) Time of flight:**\nT = 2v₀ᵧ/g = 2(15)/10 = 3.0 s\n\n**(b) Maximum height:**\nh_max = (v₀ᵧ)²/(2g) = 15²/(2×10) = 225/20 = 11.25 m\n\n**(c) Range:**\nR = v₀ₓ × T = 20 × 3.0 = 60 m\n\n**(d) Landing velocity:**\nHorizontal component: vₓ = 20 m/s (unchanged)\nVertical component: vᵧ = v₀ᵧ - gt = 15 - 10(3) = -15 m/s (downward)\n\nMagnitude: v = √(vₓ² + vᵧ²) = √(20² + 15²) = √(400 + 225) = √625 = 25 m/s\n\nDirection: tan(φ) = |vᵧ|/vₓ = 15/20 = 0.75, so φ = 37° below horizontal"
          }
        ]
      }
    ],
    "commonMisconceptions": [
      {
        "misconception": "\"The horizontal velocity of a projectile decreases as it flies.\"",
        "reality": "With no air resistance, horizontal velocity remains constant throughout the flight. Only the vertical component changes due to gravity."
      },
      {
        "misconception": "\"At the top of its arc, a projectile''s velocity is zero.\"",
        "reality": "At maximum height, only the vertical component of velocity is zero. The horizontal component continues unchanged. The projectile is still moving horizontally at the top of its arc."
      },
      {
        "misconception": "\"Heavier objects fall faster, so they have different flight times.\"",
        "reality": "In the absence of air resistance, all objects fall with the same acceleration regardless of mass. A heavy projectile and a light projectile launched identically will follow the same trajectory."
      }
    ],
    "practiceProblems": [
      {
        "problem": "A soccer ball is kicked with initial velocity 20 m/s at 30° above the horizontal. How long is it in the air? How far does it travel? How high does it go?",
        "solution": "v₀ₓ = 20 cos(30°) = 17.3 m/s\nv₀ᵧ = 20 sin(30°) = 10 m/s\n\nTime: T = 2v₀ᵧ/g = 2(10)/10 = 2.0 s\nRange: R = v₀ₓT = 17.3 × 2.0 = 34.6 m\nHeight: h = v₀ᵧ²/(2g) = 100/20 = 5.0 m"
      },
      {
        "problem": "A baseball leaves a bat at 40 m/s. What launch angle gives maximum range? What is that maximum range?",
        "solution": "Maximum range at θ = 45°:\nR_max = v₀²/g = 1600/10 = 160 m"
      },
      {
        "problem": "You throw a ball horizontally from a window 20 m above ground at 15 m/s. Where does it land?",
        "solution": "Time: t = 2.0 s\nDistance: x = 15 × 2.0 = 30 m"
      },
      {
        "problem": "An archer shoots an arrow at a target 80 m away and 5 m above the launch point. The arrow''s initial speed is 35 m/s. At what angle should she aim?",
        "solution": "R = 80 m, v₀ = 35 m/s, g = 10 m/s²\nUsing range formula: θ ≈ 8° or 82°\nThere are two solutions!"
      },
      {
        "problem": "At t = 1.0 s, a projectile launched from the origin is at position (12, 8) m. What was its initial velocity?",
        "solution": "x = v₀ₓt: 12 = v₀ₓ(1) → v₀ₓ = 12 m/s\ny = v₀ᵧt - ½gt²: 8 = v₀ᵧ(1) - 5(1) → v₀ᵧ = 13 m/s\nv₀ = √(12² + 13²) = √313 ≈ 17.7 m/s\nθ = arctan(13/12) ≈ 47°"
      }
    ]
  }',
  3,
  NOW()
) ON CONFLICT DO NOTHING;

-- Placeholder lessons for Chapter 1 (Lessons 1.4-1.10)
-- These would be populated with actual content as it's provided

DO $$
DECLARE
  lesson_num INTEGER;
  lesson_slug TEXT;
BEGIN
  FOR lesson_num IN 4..10
    LOOP
      lesson_slug := 'classical-mechanics-ch1-l' || lesson_num::TEXT || '-uuid';

      INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
      VALUES (
        lesson_slug,
        (SELECT id FROM chapters WHERE id = 'classical-mechanics-ch1-uuid'),
        'Lesson ' || lesson_num::TEXT || ' - Placeholder',
        'Detailed content to be provided based on curriculum structure',
        '{"placeholder": "Lesson content under development"}',
        lesson_num,
        NOW()
      ) ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

-- ============================================================================
-- Remaining chapters (2-10) - Structure placeholders
-- ============================================================================

-- Chapter 2: Forces and Newton's Laws
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch2-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Forces and Newton''s Laws',
  'Explore the fundamental relationship between forces and motion. Learn to draw free-body diagrams, apply Newton''s three laws to predict motion, understand friction, tension, and normal forces.',
  2,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 3: Work, Energy, and Power
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch3-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Work, Energy, and Power',
  'Discover how forces transfer energy. Master the work-energy theorem, distinguish between kinetic and potential energy, understand conservation of energy, and calculate power in physical systems.',
  3,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 4: Momentum and Collisions
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch4-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Momentum and Collisions',
  'Learn about momentum conservation, analyze elastic and inelastic collisions, understand impulse and momentum change, and apply momentum principles to predict collision outcomes.',
  4,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 5: Circular Motion and Rotation
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch5-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Circular Motion and Rotation',
  'Study objects moving in circles, understand centripetal acceleration and force, master rotational kinematics, explore moment of inertia and torque.',
  5,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 6: Oscillations and Waves
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch6-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Oscillations and Waves',
  'Analyze periodic motion from simple pendulums to mass-spring systems. Understand wave properties, calculate wave speed, and explore interference and standing waves.',
  6,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 7: Fluid Mechanics
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch7-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Fluid Mechanics',
  'Master buoyancy, density, and pressure. Apply Bernoulli''s equation to fluid flow, understand viscosity, and solve problems involving hydrostatics and hydrodynamics.',
  7,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 8: Thermal Physics (Brief Introduction)
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch8-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Thermal Physics (Brief Introduction)',
  'Explore temperature, heat, and thermodynamics basics. Understand thermal expansion, heat transfer mechanisms, and apply ideal gas law concepts.',
  8,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 9: Gravitation
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch9-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Gravitation',
  'Study universal gravitation and orbits. Calculate gravitational fields, understand satellite motion, explore escape velocity, and apply Kepler''s laws to planetary motion.',
  9,
  NOW()
) ON CONFLICT DO NOTHING;

-- Chapter 10: Special Relativity (Introduction)
INSERT INTO chapters (id, course_id, title, description, order_index, created_at)
VALUES (
  'classical-mechanics-ch10-uuid',
  (SELECT id FROM courses WHERE slug = 'classical-mechanics'),
  'Special Relativity (Introduction)',
  'Introduction to Einstein''s revolutionary theory. Understand the limits of classical mechanics, explore time dilation, length contraction, and glimpse the connection between mass and energy.',
  10,
  NOW()
) ON CONFLICT DO NOTHING;

-- Placeholder lessons for remaining chapters (2-10)
DO $$
DECLARE
  chapter_id TEXT;
  chapter_num INTEGER;
  lesson_num INTEGER;
  lesson_slug TEXT;
BEGIN
  FOR chapter_num IN 2..10
    LOOP
      chapter_id := 'classical-mechanics-ch' || chapter_num::TEXT || '-uuid';

      FOR lesson_num IN 1..10
        LOOP
          lesson_slug := chapter_id || '-l' || lesson_num::TEXT || '-uuid';

          INSERT INTO lessons (id, chapter_id, slug, title, description, content, order_index, created_at)
          VALUES (
            lesson_slug,
            chapter_id,
            'Lesson ' || lesson_num::TEXT || ' - Placeholder',
            'Detailed lesson content following curriculum structure: learning objectives, prerequisites, detailed explanations with parts, worked examples, common misconceptions, practice problems, and further study recommendations.',
            '{"placeholder": "Comprehensive lesson content to be developed. Will include: learning objectives, prerequisites, why this matters, multiple content parts with subsections, worked examples with step-by-step solutions, common misconceptions with reality checks, practice problems with detailed solutions, and further study resources."}',
            lesson_num,
            NOW()
          ) ON CONFLICT DO NOTHING;
        END LOOP;
  END LOOP;
END $$;

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_lessons_chapter ON lessons(chapter_id);
CREATE INDEX IF NOT EXISTS idx_lessons_order ON lessons(order_index);
CREATE INDEX IF NOT EXISTS idx_chapters_course ON chapters(course_id);

-- Update course lesson count
UPDATE courses
SET lesson_count = (
  SELECT COUNT(*)
  FROM lessons
  WHERE chapter_id IN (
    SELECT id FROM chapters WHERE course_id = (SELECT id FROM courses WHERE slug = 'classical-mechanics')
  )
)
WHERE slug = 'classical-mechanics';
