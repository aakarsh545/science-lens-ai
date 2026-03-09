# Level Restrictions - Developer Quick Reference

## File Location
`/Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code/src/pages/LearnSciencePage.tsx`

## Key Functions

### `loadUserProfile(userId: string)`
Fetches user XP data and calculates level.
```typescript
const [userStatsResult, profileResult] = await Promise.all([
  supabase.from("user_stats").select("xp_total").eq("user_id", userId).single(),
  supabase.from("profiles").select("xp_points, level").eq("user_id", userId).single(),
]);
const calculatedLevel = calculateLevel(xp_points);
```

### `isTopicLocked(topic: Topic): boolean`
Returns true if user level < required level.
```typescript
const requirement = difficultyRequirements[topic.difficulty_level];
return userProfile.level < requirement.level;
```

### `startLesson(topic: Topic)`
Prevents navigation if lesson is locked.
```typescript
if (userProfile.level < requirement.level) {
  return; // Don't navigate
}
navigate("/science-lens/learning", { state: { topic } });
```

## Level Requirements

```typescript
const difficultyRequirements = {
  beginner: { level: 1, label: "Level 1" },
  intermediate: { level: 10, label: "Level 10" },
  advanced: { level: 20, label: "Level 20" },
};
```

## XP to Level Calculation

```typescript
// From @/utils/levelCalculations
level = Math.floor(xp / 100) + 1;

Examples:
0-99 XP    = Level 1
100-199 XP = Level 2
900-999 XP = Level 10  ← Unlocks Intermediate
1900+ XP   = Level 20  ← Unlocks Advanced
```

## Database Tables

### `user_stats`
- `xp_total` - Total XP earned

### `profiles`
- `xp_points` - XP points (used for level calc)
- `level` - Stored level (for reference)

### `learning_topics`
- `difficulty_level` - 'beginner' | 'intermediate' | 'advanced'

## UI States

### Accessible Lesson
```tsx
<Card className="hover:shadow-cosmic">
  {/* Full color, clickable, shows progress */}
</Card>
```

### Locked Lesson
```tsx
<Card className="opacity-60 bg-muted/30">
  <Badge><Lock /> Level 10</Badge>
  {/* Grayed out, not clickable, shows requirement */}
</Card>
```

## Adding New Difficulty Levels

1. Update `difficultyRequirements` object
2. Add new level threshold
3. UI automatically applies restrictions

```typescript
// Example: Add "Expert" level
expert: { level: 30, label: "Level 30" }
```

## Testing Level States

```typescript
// Set user to specific level for testing
// In browser console or by modifying DB:

// Level 1 (new user)
xp_points = 0

// Level 9 (almost intermediate)
xp_points = 850

// Level 10 (just unlocked intermediate)
xp_points = 900

// Level 20 (just unlocked advanced)
xp_points = 1900
```

## Common Issues

### Issue: Lessons not locked
**Check**: `difficulty_level` column in `learning_topics` table
**Fix**: Ensure values are 'beginner', 'intermediate', or 'advanced'

### Issue: Level not displaying
**Check**: `user_stats` and `profiles` tables have data
**Fix**: Ensure XP data exists for user

### Issue: Wrong level calculated
**Check**: `calculateLevel()` utility function
**Fix**: Formula should be `Math.floor(xp / 100) + 1`

## Performance Notes

- API calls run in parallel (`Promise.all`)
- Level calculation is O(1) - simple arithmetic
- No N+1 queries - all data fetched upfront
- Real-time updates via Supabase subscriptions

## Dependencies

```typescript
import { calculateLevel, getXpForNextLevel } from "@/utils/levelCalculations";
import { Lock, Star } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
```

## Related Files

- `/src/utils/levelCalculations.ts` - Level calculation utilities
- `/src/components/GamificationBar.tsx` - Similar level display component
- `/src/integrations/supabase/types.ts` - Database type definitions

## Future Enhancements

- [ ] Add toast notification on locked lesson click
- [ ] Add level-up celebration animation
- [ ] Make level requirements configurable via database
- [ ] Add achievement for unlocking new difficulty tier
- [ ] Show "X lessons locked" count per difficulty
