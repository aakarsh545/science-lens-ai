# Achievements System — Postponed

Status: POSTPONED — not deleted. All code is intact and reusable.

## What was moved:
- src/pages/AchievementsPage.tsx
- src/utils/achievements.ts
- src/components/profile/AchievementsGrid.tsx
- supabase/functions/award-achievement/

## What was cleaned from shared files:
- App.tsx — route and import removed
- AppSidebar.tsx — nav link removed
- LessonPlayer.tsx — checkLessonAchievements and checkLevelAchievements calls removed
- EnhancedChatView.tsx — award-achievement edge function call and toast removed
- ChatInterface.tsx — achievements insert and toast removed
- GamificationBar.tsx — achievements count query removed
- Dashboard.tsx — achievements UI section removed
- ProfilePage.tsx — AchievementsGrid tab and achievements query removed
- RecentActivityTimeline.tsx — achievement_unlocked rendering removed

## To re-enable:
1. Move all files in src/ back to their original locations
2. Redeploy edge function: supabase/functions/award-achievement
3. Re-add imports and route to App.tsx
4. Re-add sidebar nav item to AppSidebar.tsx
5. Re-add achievement calls to LessonPlayer.tsx, EnhancedChatView.tsx, ChatInterface.tsx
6. Re-add achievements query to GamificationBar.tsx
7. Re-add achievements section to Dashboard.tsx
8. Re-add AchievementsGrid tab to ProfilePage.tsx
9. Re-add achievement_unlocked rendering to RecentActivityTimeline.tsx
10. DB table (achievements) is still live — no migration needed

## DB still active:
- public.achievements table — still exists, data preserved
- award-achievement edge function — needs redeployment when re-enabling

