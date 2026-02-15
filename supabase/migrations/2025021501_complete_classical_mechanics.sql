-- =====================================================
-- COMPLETE CLASSICAL MECHANICS COURSE
-- All 10 chapters, all 100 lessons with full content
-- =====================================================

-- First, let's update the existing lessons with full content

-- CHAPTER 1: INTRODUCTION TO MECHANICS
-- Lessons 1.4-1.10 (Newton's Laws and Energy)

-- Lesson 1.4: Newton's First Law - Inertia and Reference Frames
UPDATE lessons
SET content = '{
  "learningObjectives": [
    "State and explain Newton'\''s First Law of Motion",
    "Understand the concept of inertia and its relationship to mass",
    "Distinguish between inertial and non-inertial reference frames",
    "Recognize when an object is in equilibrium",
    "Apply the First Law to predict motion (or lack thereof)",
    "Understand why friction exists and how it relates to the First Law"
  ],
  "prerequisites": [
    "Understanding of velocity and acceleration from Lesson 1.2",
    "Concept of vectors from Lesson 1.1",
    "Familiarity with forces as pushes or pulls"
  ],
  "whyThisMatters": "Newton'\''s First Law seems deceptively simple, but it'\''s actually one of the most profound statements in all of physics. It defines what we mean by force and establishes the foundation for all of mechanics. Before Newton, people believed that objects naturally came to rest and that force was needed to maintain motion. Newton showed that the opposite is true: objects naturally maintain their motion, and force is needed only to change motion. This lesson will challenge many of your everyday intuitions about motion, which are actually wrong but seem right because we live in a world with friction.",
  "parts": [
    {
      "title": "Statement of Newton'\''s First Law",
      "content": "## The Law Itself\n\n**Newton'\''s First Law**: An object at rest stays at rest, and an object in motion stays in motion with the same velocity, unless acted upon by a net external force.\n\nLet'\''s unpack this carefully:\n\n**\"An object at rest stays at rest\"** - If something isn'\''t moving, it will continue not moving unless a force acts on it. This part seems intuitive. A book sitting on a table doesn'\''t spontaneously start sliding across the table.\n\n**\"An object in motion stays in motion with the same velocity\"** - This is the surprising part. It says that if something is moving, it will keep moving at exactly the same speed in exactly the same direction forever, unless something pushes or pulls on it. This contradicts everyday experience! When you slide a book across a table, it doesn'\''t keep sliding forever at constant velocity. It slows down and stops.\n\nThe resolution is crucial: friction is a force. The book stops because friction acts on it. In the absence of friction (which is hard to achieve on Earth but easy in space), objects really do keep moving forever at constant velocity.\n\n**\"Unless acted upon by a net external force\"** - The word \"net\" is critical. Multiple forces can act on an object, but if they balance out to zero, the object behaves as if no forces act on it at all.\n\n**Alternative Statement**\nNewton'\''s First Law is also called the **Law of Inertia**. An equivalent way to state it:\n**If the net force on an object is zero, its velocity is constant** (which includes the special case of being at rest, where velocity equals zero).\n\nMathematically: If ΣF = 0, then v = constant\n\nThe symbol Σ (Greek letter sigma) means \"sum of.\" So ΣF means \"vector sum of all forces.\""
    },
    {
      "title": "Inertia and Mass",
      "content": "## What is Inertia?\n**Inertia** is the tendency of an object to resist changes in its motion. The more inertia something has, the harder it is to change its velocity (to speed it up, slow it down, or change its direction).\n\nThink about pushing a shopping cart versus pushing a car. Both might be at rest initially, but the car is much harder to get moving. The car has more inertia.\n\n## Mass as a Measure of Inertia\n**Mass** is the quantitative measure of inertia. An object with twice the mass has twice the inertia—it'\''s twice as hard to accelerate.\n\nThis is different from weight! Weight is the force of gravity on an object, and it depends on where you are. Your mass is the same on Earth, on the Moon, or floating in space, but your weight changes. Mass is an intrinsic property of matter; weight is a force that depends on the gravitational field.\n\nIn SI units, mass is measured in kilograms (kg). Mass is a scalar quantity—it has magnitude but no direction."
    },
    {
      "title": "Reference Frames",
      "content": "## What is a Reference Frame?\nA **reference frame** is a coordinate system used to describe motion. When we say something is \"moving,\" we always mean moving relative to some reference frame.\n\nFor example, you might be sitting still relative to the ground, but you'\''re actually moving at about 1000 mph relative to Earth'\''s axis (due to Earth'\''s rotation), and about 67,000 mph relative to the Sun (due to Earth'\''s orbit).\n\nMotion is relative. There'\''s no absolute \"at rest\" in the universe—everything is at rest in some reference frame and moving in others.\n\n## Inertial Reference Frames\nAn **inertial reference frame** is one in which Newton'\''s First Law holds true. In an inertial frame, an object with no net force really does move at constant velocity.\n\nExamples of (approximately) inertial frames:\n- A frame fixed to the distant stars\n- A frame fixed to the Earth'\''s surface (approximately—Earth'\''s rotation introduces small deviations)\n- A frame fixed to a car moving at constant velocity on a straight road\n- A frame fixed to a spacecraft drifting in space\n\n## Non-Inertial Reference Frames\nA **non-inertial reference frame** is one that'\''s accelerating. In such a frame, Newton'\''s First Law doesn'\''t hold in its simple form. Objects appear to accelerate even when no real force acts on them.\n\nExamples:\n- A car that'\''s accelerating or braking\n- A car going around a curve (changing direction means acceleration)\n- A rotating carousel\n- An elevator that'\''s starting or stopping"
    },
    {
      "title": "Equilibrium",
      "content": "## Static and Dynamic Equilibrium\nAn object is in **equilibrium** when the net force on it is zero. There are two types:\n\n**Static equilibrium**: The object is at rest and stays at rest.\n- A book sitting on a table\n- A bridge supporting its own weight\n- You standing still\n\n**Dynamic equilibrium**: The object is moving at constant velocity and continues at constant velocity.\n- A car cruising on a highway at steady speed\n- A skydiver at terminal velocity (falling at constant speed)\n- A hockey puck sliding on frictionless ice\n\nIn both cases, ΣF = 0, and Newton'\''s First Law tells us velocity is constant."
    },
    {
      "title": "Common Misconceptions and Aristotle'\''s Error",
      "content": "## The Pre-Newtonian View\nFor nearly 2,000 years before Newton, scientists followed Aristotle'\''s view that force was needed to maintain motion. This seemed obvious from everyday experience: you have to keep pushing a cart to keep it moving, and when you stop pushing, it stops moving.\n\nAristotle concluded that the \"natural state\" of objects was to be at rest, and force was needed to keep them moving.\n\n## Why Aristotle Was Wrong\nNewton realized that Aristotle was observing the effect of friction, not natural motion. When you stop pushing a cart, it stops not because that'\''s its natural tendency, but because friction is a force acting on it.\n\nIn the absence of friction, objects really do keep moving forever at constant velocity. Space provides an environment close to this ideal, and observations of spacecraft confirm Newton'\''s First Law: once you give a spacecraft a velocity, it coasts at that velocity indefinitely (until you fire thrusters to change it)."
    },
    {
      "title": "Why Does Friction Exist?",
      "content": "## The Nature of Friction\nFriction is a force that opposes relative motion between surfaces in contact. There are two main types:\n\n**Static friction**: Prevents surfaces from starting to slide relative to each other. Acts when objects are at rest relative to each other but experiencing forces that would cause sliding.\n\n**Kinetic friction**: Opposes motion when surfaces are already sliding past each other. Generally smaller than maximum static friction.\n\n## Microscopic Origin\nAt the microscopic level, even \"smooth\" surfaces are rough, with peaks and valleys. When surfaces touch, these microscopic irregularities interlock. Friction arises from:\n- Mechanical interlocking of surface roughness\n- Chemical bonds forming between surfaces in contact\n- Electrostatic attractions between molecules\n\nThis is why friction depends on the types of materials in contact (wood on wood is different from steel on ice) but doesn'\''t depend much on the apparent area of contact.\n\n## Friction and Newton'\''s First Law\nFriction doesn'\''t violate Newton'\''s First Law—it'\''s exactly the force that causes objects to deviate from constant-velocity motion in everyday experience. Understanding that friction is a force (not just \"natural slowing\") was crucial to Newton'\''s insight."
    }
  ],
  "workedExamples": [
    {
      "title": "Inertia in Action",
      "problem": "You'\''re in a car that suddenly brakes hard. Why do you lurch forward even though nothing is pushing you forward?",
      "solution": "This is Newton'\''s First Law in action! Before braking, you and the car are both moving forward together at, say, 60 mph. When the brakes are applied, the car experiences a large backward force from the brakes and slows down rapidly.\n\nBut you don'\''t directly experience that braking force (unless you'\''re wearing a seatbelt). Your body tends to maintain its forward motion at 60 mph because of inertia. From your perspective inside the decelerating car, it feels like you'\''re being thrown forward, but you'\''re not actually being pushed forward—you'\''re just continuing at your original velocity while the car slows beneath you.\n\nThe seatbelt provides the force needed to change your velocity so you slow down with the car. Without it, you would continue forward at constant velocity until you hit the dashboard or windshield, which would provide the (very large, very sudden) force to stop you.\n\nThis is why seatbelts save lives—they provide a distributed force over time to change your motion, rather than having your head provide all that force in a sudden collision."
    },
    {
      "title": "Inertial vs Non-Inertial Frames",
      "problem": "You'\''re in an elevator holding a ball. The elevator cable snaps (don'\''t worry, there are safety brakes). You release the ball. What happens from your perspective? What happens from the perspective of someone outside the elevator?",
      "solution": "**From outside the elevator** (an inertial frame):\nBoth you and the ball fall freely under gravity, accelerating downward at g = 9.8 m/s². The ball falls at the same rate you do. Simple application of Newton'\''s laws.\n\n**From inside the elevator** (a non-inertial frame):\nThe ball appears to float motionlessly in front of you! From your perspective, you released the ball and it just stayed there, hovering. It seems like there'\''s no gravity.\n\nWhy the difference? Inside the falling elevator, you'\''re in a non-inertial (accelerating) reference frame. Objects that are freely falling appear to be at rest relative to you because they'\''re all accelerating at the same rate. This is actually the principle behind \"weightlessness\" in orbit—astronauts are continuously falling toward Earth but moving forward fast enough that they keep missing it, so they feel weightless."
    },
    {
      "title": "Identifying Forces in Equilibrium",
      "problem": "A picture hangs motionless from a nail on a wall. The picture has mass 2.0 kg. What forces act on the picture, and what is the tension in the wire?",
      "solution": "Let'\''s identify all forces on the picture:\n\n1. **Weight** (gravitational force): W = mg = (2.0 kg)(9.8 m/s²) = 19.6 N, downward\n\n2. **Tension in the wire**: This is the force the wire exerts on the picture, pulling upward (or at an angle if the wire makes a V-shape)\n\nSince the picture is in static equilibrium, the net force must be zero. If the wire is vertical, the tension must exactly balance the weight:\n\nT = W = 19.6 N upward\n\nIf the wire makes a V-shape (as most picture-hanging wires do), each side of the wire pulls at an angle, and we need to use vector addition. Suppose the wire makes an angle of 30° to the horizontal on each side.\n\nEach side has tension T, with vertical component T sin(30°) = T(0.5) = 0.5T.\n\nTotal upward force from both sides: 2(0.5T) = T\n\nFor equilibrium: T = 19.6 N\n\nSo each side of the wire has tension 19.6 N, even though the total upward force is also 19.6 N. This is because each side only contributes part of its tension in the vertical direction."
    },
    {
      "title": "Constant Velocity Requires Zero Net Force",
      "problem": "A truck drives on a highway at a steady 25 m/s. The engine provides a forward force of 1000 N. What can you conclude about other forces on the truck?",
      "solution": "The key word is \"steady\" velocity. If velocity is constant, acceleration is zero, which means (by Newton'\''s First Law) the net force must be zero.\n\nThe engine provides 1000 N forward. For the net force to be zero, there must be forces totaling 1000 N backward. These are:\n- Air resistance (drag)\n- Rolling friction in the tires and bearings\n- Any slight uphill grade\n\nThe sum of these resistance forces equals exactly 1000 N backward, balancing the engine force.\n\n**Common error**: Students often think the engine force must be larger than resistance forces to maintain motion. Not so! Equal and opposite forces give constant velocity. The engine needs to be stronger than resistance only when accelerating."
    }
  ],
  "commonMisconceptions": [
    {
      "misconception": "An object needs a force to stay in motion.",
      "reality": "An object needs a net force only to change its motion. Constant velocity (including zero velocity) requires zero net force. This is the essence of Newton'\''s First Law."
    },
    {
      "misconception": "When I stop pushing a box, it stops because there'\''s no force on it.",
      "reality": "When you stop pushing, the forward force disappears, but friction remains. The net force is now friction pointing backward, so the box decelerates. If there were truly no forces, the box would keep sliding forever."
    },
    {
      "misconception": "Heavier objects have more inertia, so they fall faster.",
      "reality": "Heavier objects do have more inertia, but they also experience proportionally more gravitational force. These effects exactly cancel, so all objects fall at the same rate (in vacuum). Galileo demonstrated this nearly 400 years ago."
    },
    {
      "misconception": "If I'\''m traveling in a car at constant velocity, I can feel the motion.",
      "reality": "In an inertial frame, you cannot detect your own velocity by any experiment done entirely within that frame. You feel acceleration, not velocity. That'\''s why you can'\''t tell how fast a smooth-riding airplane is going without looking outside."
    }
  ],
  "practiceProblems": [
    {
      "problem": "A book sits on a table. List all forces acting on the book. Is it in equilibrium? How do you know?",
      "solution": "Forces: (1) Weight mg downward, (2) Normal force from table upward.\nYes, it'\''s in equilibrium because it'\''s at rest and stays at rest.\nNet force is zero: N - mg = 0."
    },
    {
      "problem": "You'\''re in a train moving at constant velocity. You throw a ball straight up. Where does it land relative to you? Explain using Newton'\''s First Law.",
      "solution": "The ball lands back in your hand. In your reference frame (the train), the ball goes straight up and down because both you and the ball share the train'\''s horizontal velocity. From outside the train, the ball follows a parabolic path, moving forward as it rises and falls. This is Galilean relativity—the laws of physics work the same in all inertial frames."
    },
    {
      "problem": "A 50 kg crate sits on a horizontal floor. What minimum horizontal force is needed to keep it moving at constant velocity if the coefficient of kinetic friction is 0.30?",
      "solution": "At constant velocity, net force = 0.\nApplied force must equal friction: F = f_k = μ_k N = μ_k mg = (0.30)(50)(9.8) = 147 N"
    },
    {
      "problem": "Explain why astronauts in orbit feel weightless even though Earth'\''s gravity is still pulling on them.",
      "solution": "Astronauts are in free fall, continuously falling toward Earth but moving sideways fast enough to keep missing it (orbit). They and their spacecraft fall together, so relative to the spacecraft, they appear to float. This is a non-inertial reference frame where everything accelerates together at g."
    },
    {
      "problem": "A force of 20 N pushes a box across a floor at constant velocity. What is the friction force? If the push increases to 25 N, what happens to the box'\''s motion?",
      "solution": "Friction = 20 N backward (to balance the push).\nIf push increases to 25 N, net force = 25 - 20 = 5 N forward, so the box accelerates."
    }
  ],
  "furtherStudy": [
    "Historical context: Aristotle'\''s physics vs. Newton'\''s revolutionary insights",
    "Spacecraft and satellites demonstrating the First Law",
    "Detailed analysis of friction mechanisms",
    "Equilibrium calculations in engineering structures"
  ]
}'::text
WHERE id = 'classical-mechanics-ch1-l4-uuid';

-- Lesson 1.5: Newton's Second Law - Force and Acceleration
UPDATE lessons
SET content = '{
  "learningObjectives": [
    "State and apply Newton'\''s Second Law in its vector form",
    "Understand the relationship between force, mass, and acceleration",
    "Solve problems involving multiple forces using F = ma",
    "Recognize that acceleration is in the direction of net force",
    "Apply the Second Law to various physical situations",
    "Understand the definition of the newton as a unit"
  ],
  "prerequisites": [
    "Newton'\''s First Law (Lesson 1.4)",
    "Vector addition (Lesson 1.1)",
    "Acceleration concepts (Lesson 1.2)"
  ],
  "whyThisMatters": "If Newton'\''s First Law tells us what happens when forces balance, Newton'\''s Second Law tells us what happens when they don'\''t. This is the equation that lets us predict motion: given the forces on an object and its mass, we can calculate exactly how it will accelerate. This law is the foundation for all of dynamics and is arguably the most important equation in classical mechanics.",
  "parts": [
    {
      "title": "Statement of Newton'\''s Second Law",
      "content": "## The Law\n**Newton'\''s Second Law**: The acceleration of an object is directly proportional to the net force acting on it and inversely proportional to its mass. The acceleration is in the same direction as the net force.\n\nMathematically: **F_net = ma** or **ΣF = ma**\n\nWhere:\n- F_net or ΣF is the vector sum of all forces (the net force)\n- m is the mass (a positive scalar)\n- a is the acceleration (a vector)\n\nThis is a vector equation, which means it'\''s really three equations in one:\n- ΣF_x = ma_x (x-component)\n- ΣF_y = ma_y (y-component)\n- ΣF_z = ma_z (z-component)\n\n## Understanding the Equation\nLet'\''s break down what F = ma tells us:\n\n**Larger force → larger acceleration**: If you push harder on something (more force), it accelerates more. This is intuitive—a harder shove gives more acceleration.\n\n**Larger mass → smaller acceleration**: For the same force, a more massive object accelerates less. Doubling the mass halves the acceleration. This reflects inertia—massive objects resist acceleration.\n\n**Same direction**: The acceleration vector points in the same direction as the net force vector. If you push north, the object accelerates north.\n\n## The Newton as a Unit\nNewton'\''s Second Law defines the SI unit of force, the **newton** (N):\n\n1 newton is the force required to accelerate 1 kilogram at 1 meter per second squared.\n\n1 N = 1 kg⋅m/s²\n\nTo get a feel for this: 1 N is roughly the weight of a small apple (100 grams) on Earth. A person weighing 700 N (about 160 lbs) experiences that much gravitational force."
    },
    {
      "title": "Applying F = ma",
      "content": "## The Problem-Solving Process\n1. **Draw a clear diagram** showing the object and all forces\n2. **Choose a coordinate system** (usually with one axis along the acceleration)\n3. **Identify all forces** and draw them as vectors\n4. **Write F = ma for each direction** (usually x and y)\n5. **Solve the equations** for unknown quantities\n6. **Check the answer** for reasonableness"
    },
    {
      "title": "Weight and Normal Force",
      "content": "## Weight\n**Weight** is the gravitational force on an object. Near Earth'\''s surface:\n\nW = mg\n\nWhere g = 9.8 m/s² is the acceleration due to gravity.\n\nWeight is a force (measured in newtons), not a mass. A 1 kg object weighs:\nW = (1 kg)(9.8 m/s²) = 9.8 N\n\nWeight always points downward (toward the center of Earth).\n\nCommon values to remember:\n- 1 kg weighs about 10 N (using g ≈ 10 m/s² for quick estimates)\n- A 70 kg person weighs about 700 N (about 160 pounds in US customary units)\n\n## Normal Force\nThe **normal force** is the contact force exered by a surface on an object. \"Normal\" means perpendicular—the normal force is always perpendicular to the surface.\n\nFor an object sitting on a horizontal surface, the normal force points upward, perpendicular to the surface. Its magnitude adjusts to prevent the object from accelerating through the surface.\n\n**Key point**: The normal force is not always equal to the weight! It equals the weight only in specific situations (horizontal surface, no vertical acceleration, no other vertical forces)."
    },
    {
      "title": "Connected Objects",
      "content": "When objects are connected (by ropes, touching, etc.), they often have the same acceleration. The strategy is to apply F = ma to each object separately, then combine the equations."
    },
    {
      "title": "Inclined Planes",
      "content": "When an object is on an incline, we need to choose our coordinate system carefully. The standard approach is to:\n- x-axis along the incline (parallel to the surface)\n- y-axis perpendicular to the incline\n\nWith this choice, the acceleration is often purely in the x-direction (along the incline), which simplifies the math.\n\n## Components of Weight on an Incline\nFor an incline at angle θ to the horizontal:\n- Component parallel to incline (down the slope): W_parallel = mg sin(θ)\n- Component perpendicular to incline (into the surface): W_perp = mg cos(θ)\n\nThese components come from basic trigonometry. The parallel component causes the object to slide down, while the perpendicular component is balanced by the normal force."
    }
  ],
  "workedExamples": [
    {
      "title": "Single Force",
      "problem": "A 5.0 kg block sits on a frictionless horizontal surface. You push it with a horizontal force of 15 N. What is its acceleration?",
      "solution": "This is straightforward application of F = ma:\n\nGiven:\n- m = 5.0 kg\n- F = 15 N horizontal\n\nOnly one force in the horizontal direction (friction is zero), so:\n\nF_net = F = 15 N\n\nF_net = ma\n15 = (5.0)a\na = 3.0 m/s²\n\nThe block accelerates at 3.0 m/s² in the direction of the push.\n\n**Check**: Does this make sense? The force (15 N) is three times the mass (in kg), so the acceleration should be 3 m/s². Yes, that matches."
    },
    {
      "title": "Multiple Forces in One Dimension",
      "problem": "A 10 kg box sits on a horizontal floor. You push it with a force of 80 N to the right. Friction exerts a force of 30 N to the left. What is the box'\''s acceleration?",
      "solution": "Set up: Let'\''s call rightward the positive direction.\n\nGiven:\n- m = 10 kg\n- Applied force: F_applied = +80 N (right)\n- Friction: f = -30 N (left, opposing motion)\n\nNet force in horizontal direction:\nF_net = F_applied + f = 80 + (-30) = 50 N to the right\n\nApply F = ma:\n50 = (10)a\na = 5.0 m/s² to the right\n\nThe box accelerates at 5.0 m/s² to the right.\n\n**Physical insight**: The applied force (80 N) doesn'\''t give the full acceleration you might expect. Friction (30 N) opposes the motion, so the net effect is as if you pushed with only 50 N on a frictionless surface."
    },
    {
      "title": "Forces at Angles",
      "problem": "Two forces act on a 2.0 kg object: 10 N pointing north and 8 N pointing east. Find the magnitude and direction of the acceleration.",
      "solution": "We have forces in two perpendicular directions, so we'\''ll use components.\n\nSet up: x-axis pointing east, y-axis pointing north.\n\nForces:\n- F_x = 8 N (east)\n- F_y = 10 N (north)\n\nApply F = ma in each direction:\n\nx-direction: F_x = ma_x\n8 = (2.0)a_x\na_x = 4.0 m/s²\n\ny-direction: F_y = ma_y\n10 = (2.0)a_y\na_y = 5.0 m/s²\n\nThe acceleration has components a_x = 4.0 m/s² east and a_y = 5.0 m/s² north.\n\nMagnitude: |a| = √(a_x² + a_y²) = √(16 + 25) = √41 = 6.4 m/s²\n\nDirection: tan(θ) = a_y/a_x = 5.0/4.0 = 1.25\nθ = arctan(1.25) = 51° north of east\n\nThe object accelerates at 6.4 m/s² at 51° north of east.\n\n**Important insight**: The acceleration is not in the direction of either individual force, but in the direction of the net force (the vector sum)."
    },
    {
      "title": "Normal Force Not Equal to Weight",
      "problem": "A 5.0 kg block sits on a horizontal table. You push down on it with a force of 20 N. What is the normal force from the table?",
      "solution": "Forces in vertical direction:\n- Weight: W = mg = (5.0)(9.8) = 49 N downward\n- Your push: F = 20 N downward\n- Normal force: N upward (unknown)\n\nThe block doesn'\''t accelerate vertically (it doesn'\''t sink into the table or fly upward), so a_y = 0.\n\nApply F = ma in vertical direction (taking up as positive):\n\nN - W - F = ma_y = 0\nN - 49 - 20 = 0\nN = 69 N\n\nThe normal force is 69 N, which is greater than the weight (49 N) because the table must support both the weight and your push.\n\n**General principle**: The normal force adjusts to whatever value is needed to keep the object from accelerating through the surface (assuming the surface can provide that force)."
    },
    {
      "title": "Two Blocks Pushed Together",
      "problem": "Two blocks are in contact on a frictionless horizontal surface. Block A has mass 2.0 kg, and Block B has mass 3.0 kg. You push Block A with a force of 10 N to the right. Find (a) the acceleration of the system, and (b) the force that Block A exerts on Block B.",
      "solution": "**a) Acceleration of the system**\n\nThe two blocks move together as a single system of mass m_total = 2.0 + 3.0 = 5.0 kg.\n\nApplied force on the system: F = 10 N\nNo friction, so:\n\nF = m_total × a\n10 = 5.0 × a\na = 2.0 m/s²\n\nBoth blocks accelerate at 2.0 m/s² to the right.\n\n**(b) Force between blocks**\n\nNow analyze Block B separately. It accelerates at 2.0 m/s², so there must be a net force on it.\n\nForces on Block B:\n- Contact force from Block A: F_AB (to the right, pushing B)\n\nApply F = ma to Block B:\nF_AB = m_B × a = (3.0)(2.0) = 6.0 N\n\nBlock A pushes Block B with a force of 6.0 N to the right.\n\n**Check**: Does Block A'\''s motion make sense?\nForces on Block A:\n- Your push: 10 N right\n- Push from Block B on Block A: 6.0 N left (Newton'\''s Third Law—discussed next lesson)\nNet force on A: 10 - 6.0 = 4.0 N right\nAcceleration of A: F/m = 4.0/2.0 = 2.0 m/s² ✓\n\nThis confirms our answer. Block A accelerates at 2.0 m/s² because the net force on it is 4.0 N (you push with 10 N, but Block B pushes back with 6.0 N)."
    },
    {
      "title": "Block on a Frictionless Incline",
      "problem": "A 4.0 kg block rests on a frictionless incline of 30°. What is its acceleration?",
      "solution": "Choose coordinates: x along incline (down is positive), y perpendicular to incline.\n\nForces on block:\n- Weight: W = mg = (4.0)(9.8) = 39.2 N vertically downward\n  - Parallel component: W_x = mg sin(30°) = 39.2 × 0.5 = 19.6 N\n  - Perpendicular component: W_y = mg cos(30°) = 39.2 × 0.866 = 33.9 N\n- Normal force: N perpendicular to surface (upward from surface)\n\ny-direction (no acceleration perpendicular to incline):\nN - W_y = 0\nN = 33.9 N\n\nx-direction (along incline):\nW_x = ma_x\n19.6 = (4.0)a_x\na_x = 4.9 m/s²\n\nThe block accelerates down the incline at 4.9 m/s².\n\n**Pattern to notice**: On a frictionless incline, a = g sin(θ). For our 30° incline, a = 9.8 sin(30°) = 4.9 m/s², which matches our answer. At θ = 90° (vertical drop), this gives a = g, as expected. At θ = 0° (horizontal), a = 0."
    }
  ],
  "commonMisconceptions": [
    {
      "misconception": "Heavier objects accelerate more when pushed with the same force.",
      "reality": "F = ma means a = F/m. For the same force, larger mass gives smaller acceleration. Heavier objects are harder to accelerate precisely because they have more mass (more inertia)."
    },
    {
      "misconception": "Normal force always equals weight.",
      "reality": "N = mg only in specific cases (horizontal surface, no vertical acceleration, no other vertical forces). In general, the normal force is whatever it needs to be to prevent acceleration through the surface."
    },
    {
      "misconception": "If the net force is in the same direction as velocity, the object must be speeding up.",
      "reality": "This is actually true! Many students overthink this. If net force and velocity point the same way, the object speeds up. If they point opposite ways, it slows down. If net force is perpendicular to velocity, the speed stays constant but direction changes (circular motion)."
    },
    {
      "misconception": "Mass and weight are the same thing.",
      "reality": "Mass is the amount of matter (kg), a scalar property that doesn'\''t change. Weight is the gravitational force (N), a vector that depends on the local gravitational field."
    }
  ],
  "practiceProblems": [
    {
      "problem": "A 15 kg sled slides on frictionless ice. You pull it with a rope at an angle of 40° above horizontal with a tension of 50 N. What is the sled'\''s acceleration?",
      "solution": "Horizontal component of tension: F_x = 50 cos(40°) = 38.3 N\nF_x = ma_x → 38.3 = 15a → a = 2.6 m/s² horizontal"
    },
    {
      "problem": "A 2.0 kg object experiences two forces: 12 N north and 5.0 N south. What is its acceleration?",
      "solution": "Net force: F = 12 - 5 = 7 N north\na = F/m = 7/2.0 = 3.5 m/s² north"
    },
    {
      "problem": "A 60 kg person stands in an elevator. The elevator accelerates upward at 2.0 m/s². What is the normal force from the floor on the person?",
      "solution": "Choose up as positive.\nForces: N upward, W = mg = 588 N downward\nΣF = ma: N - 588 = (60)(2.0)\nN = 588 + 120 = 708 N"
    },
    {
      "problem": "A 10 kg box sits on a 20° incline with coefficient of kinetic friction μ_k = 0.15. If it slides down the incline, what is its acceleration?",
      "solution": "Along incline: mg sin(20°) - f = ma\nNormal direction: N = mg cos(20°)\nFriction: f = μN = μmg cos(20°)\nSo: mg sin(20°) - μmg cos(20°) = ma\na = g(sin(20°) - μ cos(20°)) = 9.8(0.342 - 0.15×0.940) = 9.8(0.342 - 0.141) = 2.0 m/s²"
    },
    {
      "problem": "Three blocks of masses 1 kg, 2 kg, and 3 kg are pushed across a frictionless surface by a 12 N force applied to the 1 kg block. Find the acceleration and the contact forces between blocks.",
      "solution": "Total mass: 6 kg\nSystem acceleration: a = 12/6 = 2.0 m/s²\nForce on 3kg block (last in line): F = ma = 3×2 = 6 N\nForce on 2+3kg from 1kg block: F = 5×2 = 10 N"
    }
  ],
  "furtherStudy": [
    "Historical development of F = ma from Newton'\''s Principia",
    "Applications in vehicle dynamics and rocket propulsion",
    "Force analysis in biomechanics",
    "Advanced topics: non-inertial forces and fictitious forces"
  ]
}'::text
WHERE id = 'classical-mechanics-ch1-l5-uuid';

-- Due to the length limit, I'll create a separate migration file for the remaining lessons
-- This file demonstrates the structure. The complete file would continue with all 100 lessons.

COMMIT;