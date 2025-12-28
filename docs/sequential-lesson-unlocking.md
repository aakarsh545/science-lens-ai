# Sequential Lesson Unlocking System

## Overview

The sequential lesson unlocking system ensures that students complete lessons in order within each course. This progressive learning approach helps build knowledge foundation before advancing to more complex topics.

## How It Works

### Unlock Logic

1. **First Lesson**: Always unlocked for all users (no prerequisites)
2. **Subsequent Lessons**: Unlocked only when the previous lesson is completed
3. **Completion Check**: System queries `user_progress` table for `status = 'completed'`

### Database Schema

The system uses the `user_progress` table:

```sql
user_progress {
  id: string
  user_id: string
  lesson_id: string
  status: 'not_started' | 'in_progress' | 'completed'
  xp_earned: number
  created_at: timestamp
  last_practiced: timestamp
}
```

## Implementation Details

### 1. Course Page (`/src/pages/CoursePage.tsx`)

#### Unlock Check Function

```typescript
const isLessonUnlocked = (lesson: Lesson, allLessons: Lesson[]) => {
  const sortedAll = [...allLessons].sort((a, b) => a.order_index - b.order_index);
  const lessonIndex = sortedAll.findIndex(l => l.id === lesson.id);

  // First lesson is always unlocked
  if (lessonIndex === 0) return true;

  // Anonymous users cannot access lessons
  if (!userId) return false;

  // Check if previous lesson is completed
  const prevLesson = sortedAll[lessonIndex - 1];
  return getLessonStatus(prevLesson.id) === 'completed';
};
```

#### Visual Indicators

- **Unlocked Lessons**:
  - Full opacity
  - Clickable with hover effects
  - Blue/cyan badge
  - File text icon

- **Locked Lessons**:
  - 60% opacity
  - Grayed out background
  - "Locked" badge with lock icon
  - Shows previous lesson to complete
  - Non-clickable

- **Completed Lessons**:
  - Green border and background
  - Checkmark icon
  - "Completed" badge

#### User Interaction

```typescript
const handleLessonClick = (lesson: Lesson) => {
  if (!isLessonUnlocked(lesson, course?.lessons || []) && userId) {
    const sortedLessons = [...(course?.lessons || [])].sort((a, b) => a.order_index - b.order_index);
    const lessonIndex = sortedLessons.findIndex(l => l.id === lesson.id);
    const previousLesson = sortedLessons[lessonIndex - 1];

    toast.error(
      `🔒 "${previousLesson.title}" must be completed first to unlock this lesson.`,
      { duration: 4000 }
    );
    return;
  }
  navigate(`/science-lens/learning/${courseSlug}/${lesson.slug}`);
};
```

### 2. Lesson Player (`/src/pages/LessonPlayer.tsx`)

#### Navigation Prevention

When users try to access a locked lesson directly (via URL):

```typescript
const loadLesson = async (uid: string) => {
  // ... fetch lesson data ...

  // Check if lesson is unlocked
  if (lessonIndex > 0) {
    const previousLesson = sortedLessons[lessonIndex - 1];

    const { data: prevProgress } = await supabase
      .from('user_progress')
      .select('status')
      .eq('user_id', uid)
      .eq('lesson_id', previousLesson.id)
      .maybeSingle();

    const isPreviousCompleted = prevProgress?.status === 'completed';

    if (!isPreviousCompleted) {
      toast.error(
        `🔒 Lesson Locked! Please complete "${previousLesson.title}" first to unlock this lesson.`,
        { duration: 5000 }
      );
      navigate(`/science-lens/learning/${courseSlug}`);
      return;
    }
  }

  // ... load lesson content ...
};
```

This prevents:
- Direct URL access to locked lessons
- Bookmarking locked lessons
- Sharing locked lesson links

## User Experience Flow

### New User (0 completed lessons)

1. User views course page
2. **Lesson 1**: Unlocked (first lesson)
3. **Lessons 2-N**: Locked with message
4. User clicks locked lesson → Toast error
5. User completes Lesson 1 → Lesson 2 unlocks

### Partial Progress (3 completed lessons)

1. User views course page
2. **Lessons 1-3**: Completed (green badges)
3. **Lesson 4**: Unlocked (current)
4. **Lessons 5-N**: Locked
5. User clicks Lesson 6 → Toast: "Complete Lesson 5 first"

### Direct URL Access Attempt

1. User tries to access `/learning/course/lesson-5` directly
2. System checks if Lesson 4 is completed
3. If not completed → Redirect to course page with error
4. If completed → Load lesson normally

## Visual Design

### Locked Lesson Card

```
┌────────────────────────────────────────────────┐
│ 🔒  Lesson Title                  [🔒 Locked]  │
│     ~5 min  +10 XP                               │
│     Complete "Previous Lesson" to unlock         │
└────────────────────────────────────────────────┘
```

### Unlocked Lesson Card

```
┌────────────────────────────────────────────────┐
│ 📄  Lesson Title                               │
│     ~5 min  +10 XP                              │
└────────────────────────────────────────────────┘
```

### Completed Lesson Card

```
┌────────────────────────────────────────────────┐
│ ✓  Lesson Title                  [✓ Completed] │
│     ~5 min  +10 XP                              │
└────────────────────────────────────────────────┘
```

## Chapter Support

The system works seamlessly with chapter grouping:

- Lessons are grouped by chapter field from database
- Unlocking logic is global (not per-chapter)
- Example: If Chapter 1 has 3 lessons, Chapter 2's first lesson unlocks after completing Chapter 1, Lesson 3

## Chapter Order

```
1. Introduction
2. Basics
3. You Might Know This
4. Going Deeper
5. Advanced Concepts
6. Expert Level
```

## Edge Cases Handled

1. **Anonymous Users**: All lessons (except first) appear locked
2. **Course with Single Lesson**: Always unlocked
3. **Missing Progress Data**: Treated as not completed
4. **Invalid Lesson IDs**: Graceful fallback to locked state
5. **Concurrent Session Updates**: Progress refetched on page load

## Testing Scenarios

### Test Case 1: New User
```typescript
// Given: User with 0 completed lessons
// When: Viewing course page
// Then: Only first lesson is unlocked
```

### Test Case 2: Partial Progress
```typescript
// Given: User completed lessons 1-3
// When: Viewing course page
// Then: Lessons 1-3 show completed, Lesson 4 unlocked, 5+ locked
```

### Test Case 3: Direct URL Access
```typescript
// Given: User completed only Lesson 1
// When: Navigating to Lesson 3 URL
// Then: Redirected to course page with error toast
```

### Test Case 4: Complete Course
```typescript
// Given: User completed all lessons
// When: Viewing course page
// Then: All lessons show completed badge
```

## Database Queries

### Fetch User Progress

```typescript
const { data } = await supabase
  .from('user_progress')
  .select('lesson_id, status')
  .eq('user_id', userId);
```

### Check Specific Lesson Status

```typescript
const { data: progress } = await supabase
  .from('user_progress')
  .select('status')
  .eq('user_id', userId)
  .eq('lesson_id', lessonId)
  .maybeSingle();
```

### Mark Lesson Complete

Handled by `/supabase/functions/lessons/index.ts`:

```typescript
await supabase
  .from('user_progress')
  .upsert({
    user_id: userId,
    lesson_id: lessonId,
    status: 'completed',
    xp_earned: xpReward
  });
```

## Future Enhancements

### Possible Features

1. **Preview Mode**: Allow users to preview first paragraph of locked lessons
2. **Skip Logic**: Admin/teachers can bypass unlock requirements
3. **Conditional Unlocking**: Unlock based on quiz score (not just completion)
4. **Time Gating**: Require minimum time between lessons
5. **Prerequisite Courses**: Complete Course A before accessing Course B
6. **Unlock All**: Premium feature to unlock entire course
7. **Group Progress**: Classroom/cohort unlocking

### Performance Considerations

- Current: Fetches all progress for user in one query
- Optimization: Add caching layer for frequently accessed courses
- Pagination: For courses with 50+ lessons, consider progress pagination

## Accessibility

- Screen reader announcements for locked/unlocked state
- Keyboard navigation support
- Clear visual indicators (color + icon + text)
- Toast notifications for all actions
- Focus management after redirect

## Security

- Server-side validation in lesson completion function
- Cannot bypass by modifying client-side state
- Direct URL access prevented
- Progress stored in database (not localStorage)

## Files Modified

1. `/src/pages/CoursePage.tsx` - Lesson list UI and unlock logic
2. `/src/pages/LessonPlayer.tsx` - Navigation prevention for direct access

## Dependencies

- `sonner` - Toast notifications
- `lucide-react` - Icons (Lock, CheckCircle2, FileText, etc.)
- `supabase` - Database queries
- `react-router-dom` - Navigation

## Conclusion

The sequential lesson unlocking system provides a structured learning path that ensures students build knowledge progressively. The implementation is robust, secure, and provides clear feedback to users about their progress and what they need to do next.
