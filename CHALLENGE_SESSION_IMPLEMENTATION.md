# Challenge Session Implementation

## Overview

A comprehensive 15-question quiz challenge system with 3 hearts (lives), XP rewards, and detailed progress tracking.

## Features

### Core Mechanics
- **15 Questions**: Each challenge session consists of exactly 15 quiz questions
- **3 Hearts/Lives**: Users start with 3 hearts
  - **Wrong answer = -1 heart**
  - **0 hearts = Challenge failed** (but still earn partial XP)
- **XP Rewards**:
  - Complete all 15 questions with hearts remaining = **100 XP bonus**
  - Partial completion (failed) = **(correct_answers / 15) * 100 = XP earned**

### Session Flow
1. User selects a topic/course from the Challenges page
2. New challenge session is created via edge function
3. Questions are fetched from database quizzes or generated via AI
4. User answers questions one at a time with immediate feedback
5. Session ends when:
   - All 15 questions answered (completed)
   - Hearts reach 0 (failed)
6. Results screen shows:
   - Score (X/15 correct)
   - XP earned
   - Pass/Fail status
   - Option to retry or return to challenges

## Files Created/Modified

### 1. Database Migration
**File**: `/supabase/migrations/20251228000000_challenge_sessions.sql`

Creates the `challenge_sessions` table with:
- User and topic tracking
- Progress (current question, hearts remaining, correct answers)
- Questions and answers storage (JSONB)
- XP calculation and completion tracking
- RLS policies for data security

**Key Fields**:
```sql
- user_id: User attempting the challenge
- topic_id: Selected topic/course ID
- status: 'active', 'completed', or 'failed'
- current_question: 1-15
- hearts_remaining: 0-3
- correct_answers: 0-15
- questions: JSONB array of 15 quiz questions
- answers: JSONB array of user answers
- xp_earned: Total XP awarded
- completion_percentage: Percentage correct
```

### 2. Edge Function
**File**: `/supabase/functions/challenge-sessions/index.ts`

Handles:
- **POST /start**: Creates new challenge session
  - Fetches quiz questions from database (lessons related to topic)
  - Falls back to AI-generated questions if needed
  - Shuffles and selects 15 questions
  - Returns first question

- **POST /:sessionId/answer**: Submits answer
  - Validates answer
  - Updates hearts and progress
  - Determines if session continues/ends
  - Calculates XP
  - Updates user_stats with earned XP

- **GET /:sessionId**: Loads existing session

**Question Sources**:
1. Database: Lesson quizzes from selected topic/course
2. AI: OpenAI GPT-4o-mini generates questions if database has < 15 questions
3. Fallback: Generic placeholder questions if AI unavailable

### 3. Challenge Session Page
**File**: `/src/pages/ChallengeSession.tsx`

**Features**:
- Real-time question display with progress tracking
- Visual hearts display (❤️❤️❤️)
- Immediate feedback on correct/incorrect answers
- Explanations shown after each answer
- Animated transitions between questions
- Results screen with detailed stats
- Level-up detection and confetti celebrations

**State Management**:
```typescript
- currentQuestion: 1-15
- hearts: 0-3
- correctAnswers: count
- question: Current question object
- selectedAnswer: User's choice
- showFeedback: Boolean for answer result display
- sessionEnded: Boolean for final results
```

### 4. Challenges Page (Updated)
**File**: `/src/pages/ChallengesPage.tsx`

**Features**:
- Browse challenges by topic or course
- Filter by difficulty (beginner, intermediate, advanced)
- Shows challenge details (15 questions, 3 lives, up to 100 XP)
- Navigate to challenge session via React Router state

### 5. App Routing (Updated)
**File**: `/src/App.tsx`

Added route:
```tsx
<Route path="challenges/session/:sessionId" element={<ChallengeSession />} />
```

Supports:
- `/science-lens/challenges/session/new` - Creates new session
- `/science-lens/challenges/session/:id` - Loads existing session

## XP Calculation Logic

### Completion (All 15 Questions, Hearts > 0)
```
XP Earned = 100 XP (bonus)
```

### Failure (Hearts = 0)
```
XP Earned = (correct_answers / 15) * 100

Examples:
- 5 correct: (5/15) * 100 = 33 XP
- 10 correct: (10/15) * 100 = 67 XP
- 14 correct: (14/15) * 100 = 93 XP
```

### Level-Up Detection
Uses existing utilities:
```typescript
import { calculateLevel, didLevelUp } from "@/utils/levelCalculations";
```

When XP is awarded:
1. Get current XP from user_stats
2. Calculate new XP = current + earned
3. Check if level increased
4. Trigger confetti celebration if level up

## Question Generation

### Database Questions
- Fetched from `lessons.quiz` field
- JSONB structure:
```json
{
  "questions": [
    {
      "question": "What is physics?",
      "options": ["A", "B", "C", "D"],
      "correct": 1,
      "explanation": "Physics is..."
    }
  ]
}
```

### AI-Generated Questions
Prompt to GPT-4o-mini:
```
Generate {count} multiple choice quiz questions about {topic}.

Each question should have:
- A clear question text
- 4 answer options (A, B, C, D)
- The correct answer index (0-3)
- A brief explanation

Return as JSON array.
```

**Fallback**: If AI unavailable, returns generic placeholder questions

## Database Schema

### challenge_sessions Table
```sql
CREATE TABLE challenge_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id),
  topic_id TEXT,
  topic_name TEXT,
  difficulty TEXT DEFAULT 'medium',
  status TEXT DEFAULT 'active',

  current_question INTEGER DEFAULT 1,
  total_questions INTEGER DEFAULT 15,
  hearts_remaining INTEGER DEFAULT 3,
  correct_answers INTEGER DEFAULT 0,

  questions JSONB DEFAULT '[]'::jsonb,
  answers JSONB DEFAULT '[]'::jsonb,

  xp_earned INTEGER DEFAULT 0,
  completion_percentage INTEGER DEFAULT 0,

  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ
);
```

**Constraints**:
- `valid_hearts`: CHECK (hearts_remaining >= 0 AND hearts_remaining <= 3)
- `valid_question`: CHECK (current_question >= 1 AND current_question <= 15)
- `valid_correct_answers`: CHECK (correct_answers >= 0 AND correct_answers <= 15)

**Indexes**:
- `user_id` - Fast lookup of user's sessions
- `status` - Filter active/completed/failed
- `topic_id` - Filter by topic
- `started_at` - Sort by recency

**RLS Policies**:
- Users can view their own sessions
- Users can insert their own sessions
- Users can update their own sessions

## User Journey

### Starting a Challenge
1. Navigate to `/science-lens/challenges`
2. Choose topic/course and difficulty
3. Click "Start Challenge"
4. System creates session with 15 questions
5. Redirect to `/science-lens/challenges/session/:id`

### During Challenge
1. See question X of 15
2. See remaining hearts (❤️❤️❤️)
3. Select answer from 4 options
4. Click "Submit Answer"
5. See immediate feedback (correct/incorrect + explanation)
6. Auto-advance after 2 seconds
7. Hearts decrease if wrong
8. Continue until hearts = 0 or all 15 answered

### Results Screen
1. Trophy icon (completed) or target icon (failed)
2. Score: X/15 correct
3. Status badge (Passed/Failed)
4. XP earned display
5. XP calculation explanation
6. "Return to Challenges" button
7. "Try Again" button (starts new session)

## UI/UX Features

### Visual Feedback
- **Hearts**: Animated scale when lost (0.8 opacity)
- **Progress Bar**: Shows completion percentage
- **Question Cards**: Fade in/out animations
- **Answer Feedback**:
  - Green border + checkmark for correct
  - Red border + X for incorrect
  - Explanation displayed below

### Confetti Celebrations
- **Level Up**: Gold/orange burst with side explosions
- **Success**: Simple celebration burst
- Uses `canvas-confetti` library

### Responsive Design
- Mobile-first approach
- Max-width containers for readability
- Touch-friendly buttons (min-height 44px)
- Stacked layout on small screens

## Deployment

### 1. Push Database Migration
```bash
npx supabase db push
```

### 2. Deploy Edge Function
```bash
npx supabase functions deploy challenge-sessions
```

### 3. Verify Environment Variables
Ensure `OPENAI_API_KEY` is set in Supabase for AI question generation.

## API Endpoints

### Start Challenge Session
```http
POST /functions/v1/challenge-sessions/start
Authorization: Bearer <token>
Content-Type: application/json

{
  "topicId": "optional-course-or-topic-id",
  "topicName": "General Science",
  "difficulty": "medium"
}

Response:
{
  "success": true,
  "session": {
    "id": "uuid",
    "currentQuestion": 1,
    "totalQuestions": 15,
    "heartsRemaining": 3,
    "question": { ... }
  }
}
```

### Submit Answer
```http
POST /functions/v1/challenge-sessions/:sessionId/answer
Authorization: Bearer <token>
Content-Type: application/json

{
  "answerIndex": 2
}

Response (session active):
{
  "success": true,
  "isCorrect": true,
  "explanation": "Explanation text",
  "heartsRemaining": 3,
  "correctAnswers": 1,
  "status": "active",
  "nextQuestion": { ... },
  "currentQuestion": 2
}

Response (session ended):
{
  "success": true,
  "isCorrect": false,
  "explanation": "Explanation text",
  "heartsRemaining": 0,
  "correctAnswers": 7,
  "status": "failed",
  "sessionEnded": true,
  "xpEarned": 47,
  "completionPercentage": 47
}
```

### Get Session
```http
GET /functions/v1/challenge-sessions/:sessionId
Authorization: Bearer <token>

Response:
{
  "success": true,
  "session": { ...full session object... }
}
```

## Testing Scenarios

### 1. Complete Challenge
- Answer 15 questions with 0-2 wrong answers
- Expected: 100 XP, "Challenge Complete!" message

### 2. Fail Challenge
- Answer 3 questions incorrectly (hearts = 0)
- Expected: Partial XP based on correct answers, "Challenge Failed" message

### 3. Resume Session
- Start challenge, answer some questions, refresh page
- Expected: Resume at current question with progress intact

### 4. Level Up
- User has 90 XP, earns 50 XP from challenge
- Expected: New total 140 XP, Level 2, confetti celebration

## Future Enhancements

### Potential Features
1. **Time limits**: Add timer per question or entire session
2. **Streak bonuses**: Extra XP for consecutive correct answers
3. **Difficulty scaling**: Harder questions as you progress
4. **Leaderboards**: Compare scores with other users
5. **Review mode**: See all questions and answers after completion
6. **Hint system**: Spend credits to reveal hints
7. **Daily challenges**: Special challenges with bonus rewards
8. **Challenge history**: View past attempts and improvements

### Database Considerations
- Add indexes for performance if user base grows
- Archive old sessions (e.g., > 6 months) to separate table
- Add analytics tracking (completion rates, average scores)

## Troubleshooting

### Common Issues

**Issue**: Questions not loading
- **Solution**: Check that lessons have quiz data in database
- **Fallback**: AI generation should activate automatically

**Issue**: XP not awarded
- **Solution**: Verify `user_stats` table has row for user
- **Check**: Edge function logs for upsert errors

**Issue**: Session not resuming
- **Solution**: Ensure sessionId is correctly stored in URL
- **Check**: Database for session with matching ID and status='active'

**Issue**: Hearts not decreasing
- **Solution**: Check answer validation logic in edge function
- **Verify**: Frontend is sending correct answerIndex

## Performance Notes

- Database queries are optimized with indexes
- Edge functions have 15s timeout for AI calls
- Fallback questions prevent session failure if AI is slow
- JSONB storage for questions/answers is efficient for 15-item arrays
- RLS policies ensure users only access their own data

## Security Considerations

- All API calls require valid JWT token
- RLS policies enforce user isolation
- Answer validation happens server-side
- XP calculation is server-side (can't be manipulated)
- SQL injection prevented via parameterized queries
- Prompt injection checked in AI question generation

## Summary

The challenge session system provides a complete, gamified quiz experience with:
- ✅ 15-question format
- ✅ 3-hearts/lives system
- ✅ XP rewards with partial completion
- ✅ Database + AI question generation
- ✅ Real-time progress tracking
- ✅ Level-up celebrations
- ✅ Detailed results screen
- ✅ Retry functionality
- ✅ Mobile-responsive design
- ✅ Secure, scalable architecture
