# Profile Page Database Migration Guide

## Migration File

**Location:** `/supabase/migrations/20251228000001_activity_log.sql`

## How to Apply Migration

### Option 1: Using Supabase CLI (Recommended)

```bash
cd /Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code

# Push the migration to the remote database
npx supabase db push

# Verify the migration
npx supabase db remote commit
```

### Option 2: Using Supabase Dashboard

1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Copy the contents of `20251228000001_activity_log.sql`
4. Paste and run the SQL

## What the Migration Creates

### Table: activity_log

Stores all user learning activities for analytics and progress tracking.

**Columns:**
- `id` (UUID) - Primary key, auto-generated
- `user_id` (UUID) - Foreign key to auth.users
- `activity_type` (TEXT) - Type of activity (enumerated)
- `related_id` (UUID) - Optional ID of related entity (lesson, challenge, etc.)
- `xp_earned` (INTEGER) - XP earned from this activity
- `metadata` (JSONB) - Additional context (lesson title, quiz score, etc.)
- `created_at` (TIMESTAMP) - When the activity occurred

**Activity Types:**
- `lesson_completed` - When a user completes a lesson
- `quiz_taken` - When a user takes a quiz
- `challenge_completed` - When a user completes a challenge
- `level_up` - When a user levels up
- `streak_milestone` - When a user reaches a streak milestone
- `achievement_unlocked` - When a user unlocks an achievement
- `daily_goal_reached` - When a user reaches their daily goal
- `topic_mastered` - When a user masters a topic

**Indexes:**
- `idx_activity_log_user_id` - Fast user queries
- `idx_activity_log_created_at` - Time-based sorting
- `idx_activity_log_activity_type` - Type filtering
- `idx_activity_log_user_created` - Composite for common queries

**RLS Policies:**
- Users can view their own activity logs
- Users can insert their own activity logs

## Example Usage

### Logging a Lesson Completion

```typescript
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "lesson_completed",
  related_id: lessonId,
  xp_earned: 50,
  metadata: {
    lesson_title: "Introduction to Physics",
    course_title: "Physics Fundamentals"
  }
});
```

### Logging a Quiz Attempt

```typescript
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "quiz_taken",
  related_id: questionId,
  xp_earned: 10,
  metadata: {
    quiz_score: 85,
    topic: "Physics",
    difficulty_level: "Intermediate"
  }
});
```

### Logging a Level Up

```typescript
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "level_up",
  xp_earned: 0,
  metadata: {
    old_level: 5,
    new_level: 6,
    total_xp: 1250
  }
});
```

### Logging Achievement Unlock

```typescript
await supabase.from("activity_log").insert({
  user_id: userId,
  activity_type: "achievement_unlocked",
  related_id: achievementId,
  xp_earned: 100,
  metadata: {
    achievement_title: "First Lesson",
    achievement_type: "first_lesson",
    category: "Learning"
  }
});
```

## Querying Activity Data

### Get User's Recent Activity

```typescript
const { data } = await supabase
  .from("activity_log")
  .select("*")
  .eq("user_id", userId)
  .order("created_at", { ascending: false })
  .limit(20);
```

### Get XP Earned in Last 30 Days

```typescript
const thirtyDaysAgo = new Date();
thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

const { data } = await supabase
  .from("activity_log")
  .select("xp_earned, created_at")
  .eq("user_id", userId)
  .gte("created_at", thirtyDaysAgo.toISOString());
```

### Get Activity by Type

```typescript
const { data } = await supabase
  .from("activity_log")
  .select("*")
  .eq("user_id", userId)
  .eq("activity_type", "lesson_completed");
```

### Aggregate XP by Date (for graphs)

```typescript
const { data } = await supabase
  .from("activity_log")
  .select("created_at, xp_earned")
  .eq("user_id", userId)
  .gte("created_at", startDate.toISOString());

// Then aggregate in application code by date
```

## Performance Considerations

### Indexes
The migration creates indexes on frequently queried columns:
- `user_id` - Almost every query filters by user
- `created_at` - Sorting and date range queries
- `activity_type` - Filtering by activity type
- Composite `(user_id, created_at)` - Optimizes common queries

### RLS
Row Level Security ensures users can only access their own data:
- Read policy: Only own records
- Write policy: Only insert own records

### Cleanup Strategy
Consider implementing a cleanup strategy for old activity logs:
```sql
-- Delete activity logs older than 1 year (optional)
DELETE FROM activity_log
WHERE created_at < NOW() - INTERVAL '1 year';
```

## Monitoring

### Check Table Size

```sql
SELECT
  pg_size_pretty(pg_total_relation_size('activity_log')) AS size;
```

### Check Activity per User

```sql
SELECT
  user_id,
  COUNT(*) as total_activities,
  SUM(xp_earned) as total_xp
FROM activity_log
GROUP BY user_id
ORDER BY total_activities DESC
LIMIT 10;
```

### Most Common Activity Types

```sql
SELECT
  activity_type,
  COUNT(*) as count
FROM activity_log
GROUP BY activity_type
ORDER BY count DESC;
```

## Troubleshooting

### Migration Fails

If the migration fails:
1. Check if you have a database connection
2. Verify you have the necessary permissions
3. Check for conflicts with existing tables

### RLS Issues

If users can't see their activity:
```sql
-- Check RLS policies
SELECT * FROM pg_policies
WHERE tablename = 'activity_log';
```

### Performance Issues

If queries are slow:
1. Check if indexes exist: `\d activity_log` in psql
2. Run `ANALYZE activity_log;` to update statistics
3. Consider adding more specific indexes based on query patterns

## Rollback

If you need to rollback the migration:

```sql
DROP TABLE IF EXISTS activity_log CASCADE;
```

Then remove the migration file:
```bash
rm supabase/migrations/20251228000001_activity_log.sql
```

## Next Steps

1. Apply the migration using one of the methods above
2. Implement activity logging in your lesson completion logic
3. Implement activity logging in your quiz taking logic
4. Implement activity logging in your challenge completion logic
5. Verify data appears correctly in the Profile page

## Support

For issues with the migration:
1. Check Supabase logs
2. Verify table structure with `\d activity_log` in SQL Editor
3. Test queries manually in SQL Editor
4. Check RLS policies are working correctly
