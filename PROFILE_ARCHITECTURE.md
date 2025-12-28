# Profile Page Architecture & Data Flow

## Component Hierarchy

```
ProfilePage (Main Container)
├── ProfileHeader
│   ├── User Avatar
│   ├── Display Name & Level Badge
│   ├── XP & Streak Display
│   └── Edit Profile Button
│
├── StatsOverview
│   ├── Lessons Completed Card
│   ├── Quizzes Taken Card
│   ├── Challenges Completed Card
│   ├── Current Streak Card
│   ├── Questions Answered Card
│   ├── Total XP Card
│   └── Level Card
│
└── Tabs (4 Views)
    ├── Overview Tab
    │   ├── XPProgressGraph
    │   ├── TopicMasteryRadar
    │   ├── LearningStreakHeatMap
    │   └── PerformanceBySubject
    │
    ├── Progress Tab
    │   ├── XPProgressGraph
    │   ├── TopicMasteryRadar
    │   └── PerformanceBySubject
    │
    ├── Activity Tab
    │   ├── LearningStreakHeatMap
    │   └── RecentActivityTimeline
    │
    └── Achievements Tab
        └── AchievementsGrid
            ├── Category Filter
            ├── Achievement Cards (with Dialog)
            └── Detail Modal
```

## Data Sources

### Supabase Tables

```
Database Tables
├── profiles
│   └── ProfileHeader, StatsOverview
│       Fields: display_name, avatar_url, level, xp_points, streak_count, total_questions
│
├── user_progress
│   └── StatsOverview
│       Fields: lesson_id, status, xp_earned, created_at
│       Usage: Count completed lessons
│
├── questions
│   └── StatsOverview
│       Fields: question_text, is_correct, created_at
│       Usage: Count quiz attempts
│
├── study_sessions
│   └── StatsOverview
│       Fields: ended_at, xp_earned
│       Usage: Count completed challenges
│
├── user_topic_progress
│   ├── TopicMasteryRadar
│   └── PerformanceBySubject
│       Fields: topic_id, completion_percentage, correct_answers, questions_answered
│       Joins: learning_topics (name, category)
│
├── achievements
│   └── AchievementsGrid, StatsOverview
│       Fields: title, description, icon, category, points, earned_at
│
└── activity_log (NEW)
    ├── XPProgressGraph
    ├── LearningStreakHeatMap
    └── RecentActivityTimeline
        Fields: activity_type, xp_earned, created_at, metadata
        Usage: Track all learning activities over time
```

## Data Flow Diagram

```
User Action → Supabase → activity_log → Profile Components

Lesson Completed
    ↓
Log to activity_log
    ↓
Fetch in ProfilePage
    ↓
Display in:
    - XPProgressGraph (xp_earned)
    - LearningStreakHeatMap (activity count)
    - RecentActivityTimeline (timeline entry)

Quiz Taken
    ↓
Log to questions table
    ↓
Aggregate in ProfilePage
    ↓
Display in:
    - StatsOverview (quizzes taken)
    - PerformanceBySubject (accuracy)

Challenge Completed
    ↓
Log to study_sessions
    ↓
Aggregate in ProfilePage
    ↓
Display in:
    - StatsOverview (challenges completed)
    - XPProgressGraph (xp earned)
```

## Component Communication

```
ProfilePage (Parent)
    ↓ Loads data from Supabase
    ↓ Passes props to children

ProfileHeader ← { user, profile }
StatsOverview ← { stats }
XPProgressGraph ← { userId }
TopicMasteryRadar ← { userId }
LearningStreakHeatMap ← { userId }
RecentActivityTimeline ← { activities }
AchievementsGrid ← { achievements }
PerformanceBySubject ← { userId }
```

## State Management

### Parent Component (ProfilePage)
```typescript
- user: User | null           // Auth user
- profile: any                // Profile data
- stats: {                    // Aggregated statistics
    lessonsCompleted: number
    quizzesTaken: number
    challengesCompleted: number
    topicProgress: array
    achievements: array
    activityLogs: array
    streakCount: number
    totalQuestions: number
    xpPoints: number
    level: number
  }
```

### Child Component States

**XPProgressGraph:**
- `data: DailyXP[]` - Chart data points
- `loading: boolean` - Loading state
- `timeRange: "7d" | "30d" | "all"` - Time filter

**TopicMasteryRadar:**
- `data: TopicMastery[]` - Radar chart data
- `loading: boolean` - Loading state

**LearningStreakHeatMap:**
- `activityData: DayActivity[]` - 365 days of activity
- `loading: boolean` - Loading state

**AchievementsGrid:**
- `selectedCategory: string` - Filter category
- `selectedAchievement: Achievement | null` - Dialog selection

**RecentActivityTimeline:**
- `showAll: boolean` - Show more/less toggle

## API Queries

### ProfilePage Data Fetching
```typescript
// Profile
from("profiles").select("*").eq("user_id", userId).single()

// Lessons Completed
from("user_progress").select("*").eq("user_id", userId).eq("status", "completed")

// Quizzes Taken
from("questions").select("*").eq("user_id", userId)

// Challenges Completed
from("study_sessions").select("*").eq("user_id", userId).not("ended_at", "null")

// Topic Progress
from("user_topic_progress").select("*, learning_topics(*)").eq("user_id", userId)

// Achievements
from("achievements").select("*").eq("user_id", userId)

// Activity Logs
from("activity_log").select("*").eq("user_id", userId).order("created_at", { ascending: false })
```

### Component-Level Queries

**XPProgressGraph:**
```typescript
from("activity_log")
  .select("*")
  .eq("user_id", userId)
  .gte("created_at", startDate)
  .order("created_at", { ascending: true })
```

**TopicMasteryRadar:**
```typescript
from("user_topic_progress")
  .select("*, learning_topics(*)")
  .eq("user_id", userId)
```

**LearningStreakHeatMap:**
```typescript
from("activity_log")
  .select("*")
  .eq("user_id", userId)
  .gte("created_at", oneYearAgo)
  .order("created_at", { ascending: true })
```

**PerformanceBySubject:**
```typescript
from("user_topic_progress")
  .select("*, learning_topics(*)")
  .eq("user_id", userId)
```

## Styling Architecture

### Theme Classes
```
card-cosmic          // Main card styling with gradient
hover:shadow-cosmic  // Hover effect for cards
btn-cosmic           // Button styling
bg-primary           // Primary color backgrounds
text-primary         // Primary text colors
text-muted-foreground // Secondary text colors
border               // Border styling
```

### Tailwind Utilities
```
Layout:
- grid, grid-cols-1, md:grid-cols-2, lg:grid-cols-4
- flex, flex-col, items-center, gap-*
- p-6, space-y-6, container, mx-auto

Responsive:
- sm:*, md:*, lg:* breakpoints
- hover:*, focus:* states

Colors:
- bg-gradient-to-r from-* to-*
- text-*, bg-* variants
- opacity-* for transparency
```

## Recharts Configuration

### AreaChart (XP Progress)
```typescript
<AreaChart data={data}>
  <defs>
    <linearGradient id="xpGradient" />  // Gradient fill
  </defs>
  <CartesianGrid strokeDasharray="3 3" />
  <XAxis dataKey="date" />
  <YAxis />
  <Tooltip />
  <Area type="monotone" dataKey="xp" fill="url(#xpGradient)" />
</AreaChart>
```

### RadarChart (Topic Mastery)
```typescript
<RadarChart data={data}>
  <PolarGrid />
  <PolarAngleAxis dataKey="subject" />
  <PolarRadiusAxis domain={[0, 100]} />
  <Radar name="Mastery" dataKey="mastery" fill="hsl(var(--primary))" />
</RadarChart>
```

### BarChart (Performance by Subject)
```typescript
<BarChart data={data}>
  <CartesianGrid strokeDasharray="3 3" />
  <XAxis dataKey="category" />
  <YAxis />
  <Tooltip />
  <Bar dataKey="completionPercentage" radius={[8, 8, 0, 0]}>
    <Cell fill={getBarColor(completion)} />  // Dynamic colors
  </Bar>
</BarChart>
```

## Performance Optimization

### Data Fetching
- Parallel queries with `Promise.all()`
- Component-level data fetching for better code splitting
- Efficient indexes on database tables

### Rendering
- Skeleton screens for loading states
- Lazy loading of chart data
- Pagination for activity timeline

### Caching
- React Query for automatic caching (if implemented)
- Component-level memoization for expensive computations

## Accessibility Features

### Keyboard Navigation
- Tab order follows visual layout
- Enter/Space activates interactive elements
- Escape closes dialogs

### Screen Reader Support
- Semantic HTML elements
- ARIA labels on interactive elements
- Alt text for icons

### Visual Accessibility
- High contrast colors
- Readable font sizes
- Clear visual hierarchy

## Future Enhancement Points

### Edit Profile
```typescript
// Location: ProfileHeader.tsx
// Button already exists, needs:
- Dialog for editing
- Form validation
- Supabase update mutation
```

### Weekly Goals
```typescript
// New component: WeeklyGoals
- Set weekly XP goal
- Track progress
- Celebrate achievements
```

### Activity Auto-Logging
```typescript
// Add to lesson completion:
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "lesson_completed",
  related_id: lessonId,
  xp_earned: lesson.xp_reward,
  metadata: { lesson_title: lesson.title }
});

// Add to quiz taking:
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "quiz_taken",
  related_id: quizId,
  xp_earned: xpEarned,
  metadata: { score: quizScore }
});
```

## Testing Strategy

### Unit Tests
- Component rendering
- Data aggregation logic
- Chart data transformation

### Integration Tests
- Supabase queries
- Data flow between components
- Navigation and routing

### E2E Tests
- Complete user journey
- Profile viewing
- Tab navigation
- Achievement interactions

## Summary

The Profile Page is a modular, performant analytics dashboard that:
1. Fetches data from multiple Supabase tables
2. Displays comprehensive statistics and visualizations
3. Uses Recharts for beautiful, responsive graphs
4. Handles empty states gracefully
5. Supports tab-based navigation
6. Works with existing user data
7. Extensible for future enhancements

All components are independent and can be reused or modified individually.
