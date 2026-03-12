# Leaderboard System — Postponed

Status: POSTPONED — not deleted. All code is intact and reusable.

## To re-enable:
1. Move src/pages/LeaderboardPage.tsx back to src/pages/
2. In App.tsx, add: import LeaderboardPage from "@/pages/LeaderboardPage";
3. In App.tsx, add route: <Route path="leaderboard" element={<LeaderboardPage />} />
4. In AppSidebar.tsx, re-add the /leaderboard nav item
5. No edge functions to redeploy — page queries Supabase directly
6. DB materialized views are still live — no migration needed

## DB views still active (no action needed):
leaderboard_all_time, leaderboard_weekly, leaderboard_monthly,
leaderboard_streaks, leaderboard_challenges, leaderboard_physics,
leaderboard_chemistry, leaderboard_biology, leaderboard_astronomy

## DB functions still active:
refresh_leaderboards(), refresh_leaderboards_safely(),
get_user_rank(), reset_weekly_xp(), reset_monthly_xp()

## Note:
profiles table columns xp_earned_week, xp_earned_month, show_in_leaderboard,
previous_rank, challenges_completed, challenges_success_rate remain in the DB
and keep being updated — they are NOT removed.

