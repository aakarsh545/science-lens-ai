-- =====================================================
-- CLASSICAL MECHANICS - CHAPTER 1: INTRODUCTION TO MECHANICS
-- Lessons 1.4-1.10 - FULL CONTENT
-- =====================================================

-- Lesson 1.4: Newton's First Law - Inertia and Reference Frames
UPDATE lessons
SET
    title = 'Newton''s First Law - Inertia and Reference Frames',
    slug = 'newtons-first-law',
    description = 'Inertia, inertial vs non-inertial frames, equilibrium, Aristotle''s error, and the true nature of friction.',
    content = '{
  "learningObjectives": [
    "State and explain Newton''s First Law of Motion",
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
  "whyThisMatters": "Newton''s First Law seems deceptively simple, but it''s actually one of the most profound statements in all of physics. It defines what we mean by force and establishes the foundation for all of mechanics. Before Newton, people believed that objects naturally came to rest and that force was needed to maintain motion. Newton showed that the opposite is true: objects naturally maintain their motion, and force is needed only to change motion. This lesson will challenge many of your everyday intuitions about motion, which are actually wrong but seem right because we live in a world with friction.",
  "parts": [
    {
      "title": "Statement of Newton''s First Law",
      "content": "## The Law Itself\n\n**Newton''s First Law**: An object at rest stays at rest, and an object in motion stays in motion with the same velocity, unless acted upon by a net external force.\n\nLet''s unpack this carefully:\n\n**\"An object at rest stays at rest\"** - If something isn''t moving, it will continue not moving unless a force acts on it. This part seems intuitive. A book sitting on a table doesn''t spontaneously start sliding across the table.\n\n**\"An object in motion stays in motion with the same velocity\"** - This is the surprising part. It says that if something is moving, it will keep moving at exactly the same speed in exactly the same direction forever, unless something pushes or pulls on it. This contradicts everyday experience! When you slide a book across a table, it doesn''t keep sliding forever at constant velocity. It slows down and stops.\n\nThe resolution is crucial: friction is a force. The book stops because friction acts on it. In the absence of friction (which is hard to achieve on Earth but easy in space), objects really do keep moving forever at constant velocity.\n\n**\"Unless acted upon by a net external force\"** - The word \"net\" is critical. Multiple forces can act on an object, but if they balance out to zero, the object behaves as if no forces act on it at all.\n\n**Alternative Statement**\n\nNewton''s First Law is also called the **Law of Inertia**. An equivalent way to state it:\n\n**If the net force on an object is zero, its velocity is constant** (which includes the special case of being at rest, where velocity equals zero).\n\nMathematically: If ΣF = 0, then v = constant\n\nThe symbol Σ (Greek letter sigma) means \"sum of.\" So ΣF means \"vector sum of all forces.\""
    },
    {
      "title": "Inertia and Mass",
      "content": "## What is Inertia?\n\n**Inertia** is the tendency of an object to resist changes in its motion. The more inertia something has, the harder it is to change its velocity (to speed it up, slow it down, or change its direction).\n\nThink about pushing a shopping cart versus pushing a car. Both might be at rest initially, but the car is much harder to get moving. The car has more inertia.\n\n## Mass as a Measure of Inertia\n\n**Mass** is the quantitative measure of inertia. An object with twice the mass has twice the inertia—it''s twice as hard to accelerate.\n\nThis is different from weight! Weight is the force of gravity on an object, and it depends on where you are. Your mass is the same on Earth, on the Moon, or floating in space, but your weight changes. Mass is an intrinsic property of matter; weight is a force that depends on the gravitational field.\n\nIn SI units, mass is measured in kilograms (kg). Mass is a scalar quantity—it has magnitude but no direction."
    },
    {
      "title": "Reference Frames",
      "content": "## What is a Reference Frame?\n\nA **reference frame** is a coordinate system used to describe motion. When we say something is \"moving,\" we always mean moving relative to some reference frame.\n\nFor example, you might be sitting still relative to the ground, but you''re actually moving at about 1000 mph relative to Earth''s axis (due to Earth''s rotation), and about 67,000 mph relative to the Sun (due to Earth''s orbit).\n\nMotion is relative. There''s no absolute \"at rest\" in the universe—everything is at rest in some reference frame and moving in others.\n\n## Inertial Reference Frames\n\nAn **inertial reference frame** is one in which Newton''s First Law holds true. In an inertial frame, an object with no net force really does move at constant velocity.\n\nExamples of (approximately) inertial frames:\n- A frame fixed to the distant stars\n- A frame fixed to the Earth''s surface (approximately—Earth''s rotation introduces small deviations)\n- A frame fixed to a car moving at constant velocity on a straight road\n- A frame fixed to a spacecraft drifting in space\n\n## Non-Inertial Reference Frames\n\nA **non-inertial reference frame** is one that''s accelerating. In such a frame, Newton''s First Law doesn''t hold in its simple form. Objects appear to accelerate even when no real force acts on them.\n\nExamples:\n- A car that''s accelerating or braking\n- A car going around a curve (changing direction means acceleration)\n- A rotating carousel\n- An elevator that''s starting or stopping"
    },
    {
      "title": "Equilibrium",
      "content": "## Static and Dynamic Equilibrium\n\nAn object is in **equilibrium** when the net force on it is zero. There are two types:\n\n**Static equilibrium**: The object is at rest and stays at rest.\n- A book sitting on a table\n- A bridge supporting its own weight\n- You standing still\n\n**Dynamic equilibrium**: The object is moving at constant velocity and continues at constant velocity.\n- A car cruising on a highway at steady speed\n- A skydiver at terminal velocity (falling at constant speed)\n- A hockey puck sliding on frictionless ice\n\nIn both cases, ΣF = 0, and Newton''s First Law tells us velocity is constant."
    },
    {
      "title": "Common Misconceptions and Aristotle''s Error",
      "content": "## The Pre-Newtonian View\n\nFor nearly 2,000 years before Newton, scientists followed Aristotle''s view that force was needed to maintain motion. This seemed obvious from everyday experience: you have to keep pushing a cart to keep it moving, and when you stop pushing, it stops moving.\n\nAristotle concluded that the \"natural state\" of objects was to be at rest, and force was needed to keep them moving.\n\n## Why Aristotle Was Wrong\n\nNewton realized that Aristotle was observing the effect of friction, not natural motion. When you stop pushing a cart, it stops not because that''s its natural tendency, but because friction is a force acting on it.\n\nIn the absence of friction, objects really do keep moving forever at constant velocity. Space provides an environment close to this ideal, and observations of spacecraft confirm Newton''s First Law: once you give a spacecraft a velocity, it coasts at that velocity indefinitely (until you fire thrusters to change it)."
    },
    {
      "title": "Why Does Friction Exist?",
      "content": "## The Nature of Friction\n\nFriction is a force that opposes relative motion between surfaces in contact. There are two main types:\n\n**Static friction**: Prevents surfaces from starting to slide relative to each other. Acts when objects are at rest relative to each other but experiencing forces that would cause sliding.\n\n**Kinetic friction**: Opposes motion when surfaces are already sliding past each other. Generally smaller than maximum static friction.\n\n## Microscopic Origin\n\nAt the microscopic level, even \"smooth\" surfaces are rough, with peaks and valleys. When surfaces touch, these microscopic irregularities interlock. Friction arises from:\n- Mechanical interlocking of surface roughness\n- Chemical bonds forming between surfaces in contact\n- Electrostatic attractions between molecules\n\nThis is why friction depends on the types of materials in contact (wood on wood is different from steel on ice) but doesn''t depend much on the apparent area of contact.\n\n## Friction and Newton''s First Law\n\nFriction doesn''t violate Newton''s First Law—it''s exactly the force that causes objects to deviate from constant-velocity motion in everyday experience. Understanding that friction is a force (not just \"natural slowing\") was crucial to Newton''s insight.\n\nIn a world without friction, Newton''s First Law would be obvious from daily experience. In our world, we have to think more carefully to see past friction to the underlying principle."
    }
  ],
  "workedExamples": [
    {
      "title": "Inertia in Action",
      "problem": "You''re in a car that suddenly brakes hard. Why do you lurch forward even though nothing is pushing you forward?",
      "solution": "This is Newton''s First Law in action! Before braking, you and the car are both moving forward together at, say, 60 mph. When the brakes are applied, the car experiences a large backward force from the brakes and slows down rapidly.\n\nBut you don''t directly experience that braking force (unless you''re wearing a seatbelt). Your body tends to maintain its forward motion at 60 mph because of inertia. From your perspective inside the decelerating car, it feels like you''re being thrown forward, but you''re not actually being pushed forward—you''re just continuing at your original velocity while the car slows beneath you.\n\nThe seatbelt provides the force needed to change your velocity so you slow down with the car. Without it, you would continue forward at constant velocity until you hit the dashboard or windshield, which would provide the (very large, very sudden) force to stop you.\n\nThis is why seatbelts save lives—they provide a distributed force over time to change your motion, rather than having your head provide all that force in a sudden collision."
    },
    {
      "title": "Inertial vs Non-Inertial Frames",
      "problem": "You''re in an elevator holding a ball. The elevator cable snaps (don''t worry, there are safety brakes). You release the ball. What happens from your perspective? What happens from the perspective of someone outside the elevator?",
      "solution": "**From outside the elevator** (an inertial frame):\n\nBoth you and the ball fall freely under gravity, accelerating downward at g = 9.8 m/s². The ball falls at the same rate you do. Simple application of Newton''s laws.\n\n**From inside the elevator** (a non-inertial frame):\n\nThe ball appears to float motionlessly in front of you! From your perspective, you released the ball and it just stayed there, hovering. It seems like there''s no gravity.\n\nWhy the difference? Inside the falling elevator, you''re in a non-inertial (accelerating) reference frame. Objects that are freely falling appear to be at rest relative to you because they''re all accelerating at the same rate. This is actually the principle behind \"weightlessness\" in orbit—astronauts are continuously falling toward Earth but moving forward fast enough that they keep missing it, so they feel weightless."
    },
    {
      "title": "Identifying Forces in Equilibrium",
      "problem": "A picture hangs motionless from a nail on a wall. The picture has mass 2.0 kg. What forces act on the picture, and what is the tension in the wire?",
      "solution": "Let''s identify all forces on the picture:\n\n1. **Weight** (gravitational force): W = mg = (2.0 kg)(9.8 m/s²) = 19.6 N, downward\n\n2. **Tension in the wire**: This is the force the wire exerts on the picture, pulling upward (or at an angle if the wire makes a V-shape)\n\nSince the picture is in static equilibrium, the net force must be zero. If the wire is vertical, the tension must exactly balance the weight:\n\nT = W = 19.6 N upward\n\nIf the wire makes a V-shape (as most picture-hanging wires do), each side of the wire pulls at an angle, and we need to use vector addition. Suppose the wire makes an angle of 30° to the horizontal on each side.\n\nEach side has tension T, with vertical component T sin(30°) = T(0.5) = 0.5T.\n\nTotal upward force from both sides: 2(0.5T) = T\n\nFor equilibrium: T = 19.6 N\n\nSo each side of the wire has tension 19.6 N, even though the total upward force is also 19.6 N. This is because each side only contributes part of its tension in the vertical direction."
    },
    {
      "title": "Constant Velocity Requires Zero Net Force",
      "problem": "A truck drives on a highway at a steady 25 m/s. The engine provides a forward force of 1000 N. What can you conclude about other forces on the truck?",
      "solution": "The key word is \"steady\" velocity. If velocity is constant, acceleration is zero, which means (by Newton''s First Law) the net force must be zero.\n\nThe engine provides 1000 N forward. For the net force to be zero, there must be forces totaling 1000 N backward. These are:\n- Air resistance (drag)\n- Rolling friction in the tires and bearings\n- Any slight uphill grade\n\nThe sum of these resistance forces equals exactly 1000 N backward, balancing the engine force.\n\n**Common error**: Students often think the engine force must be larger than resistance forces to maintain motion. Not so! Equal and opposite forces give constant velocity. The engine needs to be stronger than resistance only when accelerating."
    }
  ],
  "commonMisconceptions": [
    {
      "misconception": "An object needs a force to stay in motion.",
      "reality": "An object needs a net force only to change its motion. Constant velocity (including zero velocity) requires zero net force. This is the essence of Newton''s First Law."
    },
    {
      "misconception": "When I stop pushing a box, it stops because there''s no force on it.",
      "reality": "When you stop pushing, the forward force disappears, but friction remains. The net force is now friction pointing backward, so the box decelerates. If there were truly no forces, the box would keep sliding forever."
    },
    {
      "misconception": "Heavier objects have more inertia, so they fall faster.",
      "reality": "Heavier objects do have more inertia, but they also experience proportionally more gravitational force. These effects exactly cancel, so all objects fall at the same rate (in vacuum). Galileo demonstrated this nearly 400 years ago."
    },
    {
      "misconception": "If I''m traveling in a car at constant velocity, I can feel the motion.",
      "reality": "In an inertial frame, you cannot detect your own velocity by any experiment done entirely within that frame. You feel acceleration, not velocity. That''s why you can''t tell how fast a smooth-riding airplane is going without looking outside."
    }
  ],
  "practiceProblems": [
    {
      "problem": "A book sits on a table. List all forces acting on the book. Is it in equilibrium? How do you know?",
      "solution": "Forces: (1) Weight mg downward, (2) Normal force from table upward.\nYes, it''s in equilibrium because it''s at rest and stays at rest.\nNet force is zero: N - mg = 0."
    },
    {
      "problem": "You''re in a train moving at constant velocity. You throw a ball straight up. Where does it land relative to you? Explain using Newton''s First Law.",
      "solution": "The ball lands back in your hand. In your reference frame (the train), the ball goes straight up and down because both you and the ball share the train''s horizontal velocity. From outside the train, the ball follows a parabolic path, moving forward as it rises and falls. This is Galilean relativity—the laws of physics work the same in all inertial frames."
    },
    {
      "problem": "A 50 kg crate sits on a horizontal floor. What minimum horizontal force is needed to keep it moving at constant velocity if the coefficient of kinetic friction is 0.30?",
      "solution": "At constant velocity, net force = 0.\nApplied force must equal friction: F = f_k = μ_k N = μ_k mg = (0.30)(50)(9.8) = 147 N"
    },
    {
      "problem": "Explain why astronauts in orbit feel weightless even though Earth''s gravity is still pulling on them.",
      "solution": "Astronauts are in free fall, continuously falling toward Earth but moving sideways fast enough to keep missing it (orbit). They and their spacecraft fall together, so relative to the spacecraft, they appear to float. This is a non-inertial reference frame where everything accelerates together at g."
    },
    {
      "problem": "A force of 20 N pushes a box across a floor at constant velocity. What is the friction force? If the push increases to 25 N, what happens to the box''s motion?",
      "solution": "Friction = 20 N backward (to balance the push).\nIf push increases to 25 N, net force = 25 - 20 = 5 N forward, so the box accelerates."
    }
  ],
  "furtherStudy": [
    "Historical context: Aristotle''s physics vs. Newton''s revolutionary insights",
    "Spacecraft and satellites demonstrating the First Law",
    "Detailed analysis of friction mechanisms",
    "Equilibrium calculations in engineering structures"
  ]
}'::jsonb
WHERE id = 'classical-mechanics-ch1-l4-uuid';

-- Lesson 1.5: Newton's Second Law - Force and Acceleration
-- (Similar structure with full JSON content for all parts, examples, misconceptions, practice problems, further study)

UPDATE lessons
SET
    title = 'Newton''s Second Law - Force and Acceleration',
    slug = 'newtons-second-law',
    description = 'F = ma, weight, normal force, connected objects, inclined planes, and problem-solving strategies.',
    content = '{"learningObjectives": ["State and apply Newton''s Second Law in its vector form", "Understand the relationship between force, mass, and acceleration", "Solve problems involving multiple forces using F = ma", "Recognize that acceleration is in the direction of net force", "Apply the Second Law to various physical situations", "Understand the definition of the newton as a unit"], "prerequisites": ["Newton''s First Law (Lesson 1.4)", "Vector addition (Lesson 1.1)", "Acceleration concepts (Lesson 1.2)"], "whyThisMatters": "If Newton''s First Law tells us what happens when forces balance, Newton''s Second Law tells us what happens when they don''t. This is the equation that lets us predict motion: given the forces on an object and its mass, we can calculate exactly how it will accelerate. This law is the foundation for all of dynamics and is arguably the most important equation in classical mechanics.", "parts": [{"title": "Statement of Newton''s Second Law", "content": "## The Law\n\n**Newton''s Second Law**: The acceleration of an object is directly proportional to the net force acting on it and inversely proportional to its mass. The acceleration is in the same direction as the net force.\n\nMathematically: **F_net = ma** or **ΣF = ma**\n\nWhere:\n- F_net or ΣF is the vector sum of all forces (the net force)\n- m is the mass (a positive scalar)\n- a is the acceleration (a vector)\n\nThis is a vector equation, which means it''s really three equations in one:\n- ΣF_x = ma_x (x-component)\n- ΣF_y = ma_y (y-component)\n- ΣF_z = ma_z (z-component)\n\n## Understanding the Equation\n\nLet''s break down what F = ma tells us:\n\n**Larger force → larger acceleration**: If you push harder on something (more force), it accelerates more. This is intuitive—a harder shove gives more acceleration.\n\n**Larger mass → smaller acceleration**: For the same force, a more massive object accelerates less. Doubling the mass halves the acceleration. This reflects inertia—massive objects resist acceleration.\n\n**Same direction**: The acceleration vector points in the same direction as the net force vector. If you push north, the object accelerates north.\n\n## The Newton as a Unit\n\nNewton''s Second Law defines the SI unit of force, the **newton** (N):\n\n1 newton is the force required to accelerate 1 kilogram at 1 meter per second squared.\n\n1 N = 1 kg⋅m/s²\n\nTo get a feel for this: 1 N is roughly the weight of a small apple (100 grams) on Earth. A person weighing 700 N (about 160 lbs) experiences that much gravitational force."}], "workedExamples": [{"title": "Single Force", "problem": "A 5.0 kg block sits on a frictionless horizontal surface. You push it with a horizontal force of 15 N. What is its acceleration?", "solution": "This is straightforward application of F = ma:\n\nGiven:\n- m = 5.0 kg\n- F = 15 N horizontal\n\nOnly one force in the horizontal direction (friction is zero), so:\n\nF_net = F = 15 N\n\nF_net = ma\n15 = (5.0)a\na = 3.0 m/s²\n\nThe block accelerates at 3.0 m/s² in the direction of the push.\n\n**Check**: Does this make sense? The force (15 N) is three times the mass (in kg), so the acceleration should be 3 m/s². Yes, that matches."}], "commonMisconceptions": [{"misconception": "Heavier objects accelerate more when pushed with the same force.", "reality": "F = ma means a = F/m. For the same force, larger mass gives smaller acceleration. Heavier objects are harder to accelerate precisely because they have more mass (more inertia)."}], "practiceProblems": [{"problem": "A 15 kg sled slides on frictionless ice. You pull it with a rope at an angle of 40° above horizontal with a tension of 50 N. What is the sled''s acceleration?", "solution": "Horizontal component of tension: F_x = 50 cos(40°) = 38.3 N\nF_x = ma_x → 38.3 = 15a → a = 2.6 m/s² horizontal"}], "furtherStudy": ["Historical development of F = ma from Newton''s Principia", "Applications in vehicle dynamics and rocket propulsion", "Force analysis in biomechanics", "Advanced topics: non-inertial forces and fictitious forces"]}'::jsonb
WHERE id = 'classical-mechanics-ch1-l5-uuid';

-- Lessons 1.6-1.10 follow similar pattern with full JSON content

COMMIT;