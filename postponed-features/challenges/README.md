# Challenge System — Postponed

Status: POSTPONED — not deleted. All code is intact and reusable.

## To re-enable:
1. Move src/ files back to their original locations
2. Re-add imports and routes to App.tsx (see below)
3. Re-add sidebar nav item to AppSidebar.tsx
4. Re-add ChallengePanel to DashboardMainPage.tsx
5. Redeploy edge functions: supabase/functions/challenges and supabase/functions/challenge-sessions
6. DB tables (challenges, challenge_sessions) are still live — no migration needed

## App.tsx imports to restore:
import ChallengesPage from "@/pages/ChallengesPage";
import ChallengeSession from "@/pages/ChallengeSession";

## App.tsx routes to restore:
<Route path="challenges" element={<ChallengesPage />} />
<Route path="challenges/session/:sessionId" element={<ChallengeSession />} />

## DashboardMainPage.tsx:
import ChallengePanel from "@/components/ChallengePanel";
// then render <ChallengePanel /> in the dashboard grid

## Files NOT moved (shared utilities — challenge logic is inside but not challenge-only):
- src/utils/achievements.ts (contains checkChallengeAchievements — leave in place)
- src/utils/activityLogging.ts (contains logChallengeCompleted — leave in place)
- src/utils/constants.ts (contains challenge edge function path — leave in place)
- src/components/profile/AchievementsGrid.tsx (references challenge achievement strings — leave in place)
- src/components/profile/RecentActivityTimeline.tsx (renders challenge_completed activity — leave in place)
- src/components/debug/DebugPanel.tsx (debug references — leave in place)
- supabase/migrations/* (already applied to DB — originals stay, copies saved above)

