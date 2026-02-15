-- Classical Mechanics - Complete First Chapter with Filled Lessons
-- Ensures UI has actual lesson content to display

-- Update Chapter 1 lessons with proper content
UPDATE lessons SET
  content = '{
    "learningObjectives": [
      "State and explain Newtons First Law of Motion",
      "Understand the concept of inertia and its relationship to mass",
      "Distinguish between inertial and non-inertial reference frames",
      "Recognize when an object is in equilibrium",
      "Apply the First Law to predict motion",
      "Understand why friction exists and how it relates to the First Law"
    ],
    "prerequisites": [
      "Understanding of velocity and acceleration",
      "Concept of vectors",
      "Familiarity with forces as pushes or pulls"
    ],
    "whyThisMatters": "Newtons First Law defines what we mean by force and establishes the foundation for all of mechanics. Before Newton, people believed that objects naturally came to rest and that force was needed to maintain motion. Newton showed that the opposite is true: objects naturally maintain their motion, and force is needed only to change motion.",
    "parts": [
      {
        "title": "The Law Itself",
        "content": "Newtons First Law: An object at rest stays at rest, and an object in motion stays in motion with the same velocity, unless acted upon by a net external force. This means constant velocity continues forever unless a force acts on it."
      },
      {
        "title": "Inertia and Mass",
        "content": "Inertia is the tendency of an object to resist changes in its motion. Mass is the quantitative measure of inertia - more mass means more inertia and harder to accelerate."
      },
      {
        "title": "Reference Frames",
        "content": "A reference frame is a coordinate system used to describe motion. Inertial frames move at constant velocity. Non-inertial frames accelerate, causing fictitious forces to appear."
      },
      {
        "title": "Equilibrium",
        "content": "An object is in equilibrium when the net force on it is zero. Static equilibrium: at rest and stays at rest. Dynamic equilibrium: moving at constant velocity."
      }
    ],
    "workedExamples": [
      {
        "title": "Inertia in Action",
        "problem": "Youre in a car that suddenly brakes hard. Why do you lurch forward?",
        "solution": "Your body tends to maintain its forward velocity due to inertia while the car slows beneath you - until the seatbelt provides a force to slow you down with the car."
      }
    ],
    "commonMisconceptions": [
      {
        "misconception": "An object needs a force to stay in motion.",
        "reality": "An object needs a net force only to change its motion. Constant velocity requires zero net force."
      }
    ],
    "practiceProblems": [
      {
        "problem": "A book sits on a table. List all forces acting on the book.",
        "solution": "Forces: Weight mg downward, Normal force from table upward. Net force is zero: N - mg = 0."
      }
    ],
    "furtherStudy": [
      "Historical context: Aristotles physics vs Newtons revolutionary insights",
      "Spacecraft and satellites demonstrating the First Law"
    ]
  }'::jsonb
WHERE slug = 'newtons-first-law';

-- Lesson 1.5
UPDATE lessons SET
  content = '{
    "learningObjectives": [
      "State and apply Newtons Second Law in its vector form",
      "Understand the relationship between force, mass, and acceleration",
      "Solve problems involving multiple forces using F = ma",
      "Recognize that acceleration is in the direction of net force",
      "Apply the Second Law to various physical situations"
    ],
    "prerequisites": [
      "Newtons First Law",
      "Vector addition",
      "Acceleration concepts"
    ],
    "whyThisMatters": "Newtons Second Law (F = ma) lets us predict motion: given the forces on an object and its mass, we can calculate exactly how it will accelerate. This is the foundation for all of dynamics.",
    "parts": [
      {
        "title": "The Law",
        "content": "The acceleration of an object is directly proportional to the net force acting on it and inversely proportional to its mass. Mathematically: F_net = ma or ΣF = ma"
      },
      {
        "title": "Understanding the Equation",
        "content": "Larger force gives larger acceleration. Larger mass gives smaller acceleration (more resistance to acceleration). Acceleration is in the same direction as the net force."
      },
      {
        "title": "The Newton as a Unit",
        "content": "1 newton = 1 kg⋅m/s². This defines the SI unit of force based on mass and acceleration."
      }
    ],
    "workedExamples": [
      {
        "title": "Single Force",
        "problem": "A 5.0 kg block sits on a frictionless horizontal surface. You push it with a horizontal force of 15 N. What is its acceleration?",
        "solution": "Given: m = 5.0 kg, F = 15 N horizontal. F_net = F = 15 N. F_net = ma → 15 = (5.0)a → a = 3.0 m/s². The block accelerates at 3.0 m/s²."
      }
    ],
    "commonMisconceptions": [
      {
        "misconception": "Heavier objects accelerate more when pushed with the same force.",
        "reality": "F = ma means a = F/m. For the same force, larger mass gives smaller acceleration. Heavier objects are harder to accelerate."
      }
    ],
    "practiceProblems": [
      {
        "problem": "A 15 kg sled slides on frictionless ice. You pull it with a rope at an angle of 40° above horizontal with a tension of 50 N. What is the sleds acceleration?",
        "solution": "Horizontal component: F_x = 50 cos(40°) = 38.3 N. F_x = ma_x → 38.3 = 15a → a = 2.6 m/s² horizontal."
      }
    ],
    "furtherStudy": [
      "Historical development of F = ma from Newtons Principia",
      "Applications in vehicle dynamics and rocket propulsion"
    ]
  }'::jsonb
WHERE slug = 'newtons-second-law';

COMMIT;
