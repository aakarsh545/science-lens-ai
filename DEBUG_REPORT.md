# Science Lens AI - Comprehensive Bug Report

Generated: 2025-12-29
Status: DRAFT
Priority Classification: CRITICAL | HIGH | MEDIUM | LOW

---

## Executive Summary

This report documents all undeveloped features, broken buttons, error-causing elements, and potential issues found in the Science Lens AI application through comprehensive code analysis.

**Total Issues Found**: 23
- **CRITICAL**: 4 (Will cause app crashes or errors)
- **HIGH**: 7 (Major functionality broken)
- **MEDIUM**: 8 (Feature partially broken)
- **LOW**: 4 (Minor issues)

---

## Table of Contents

1. [Critical Bugs](#critical-bugs)
2. [High Priority Issues](#high-priority-issues)
3. [Medium Priority Issues](#medium-priority-issues)
4. [Low Priority Issues](#low-priority-issues)
5. [Edge Functions Status](#edge-functions-status)
6. [Database Dependencies](#database-dependencies)
7. [Recommendations](#recommendations)

---

## Critical Bugs

### 1. Undefined Variable: `userLevel` in ChallengesPage
**File**: `src/pages/ChallengesPage.tsx:374`
**Priority**: CRITICAL
**Status**: WILL CAUSE RUNTIME ERROR

```tsx
<Badge variant="outline" className="text-lg px-4 py-2">
  Level {userLevel}  {/* ❌ userLevel is never defined */}
</Badge>
```

**Impact**: The challenges page will crash with a ReferenceError when loaded.
**Fix**: Add `userLevel` state variable and load it from the user profile:
```tsx
const [userLevel, setUserLevel] = useState(1);
// Load from profiles table
const { data } = await supabase.from('profiles').select('level').eq('user_id', userId).single();
if (data) setUserLevel(data.level);
```

---

### 2. Type Mismatch in ProfilePage - Missing Properties
**File**: `src/pages/ProfilePage.tsx:105-116`
**Priority**: CRITICAL
**Status**: TYPE ERROR - RUNTIME BREAKAGE

```tsx
// UserStats interface defines:
interface UserStats {
  total_xp: number;
  level: number;
  lessons_completed: number;
  challenges_completed: number;
  current_streak: number;
  longest_streak: number;
  accuracy_percentage: number;
  total_questions_answered: number;
}

// But code tries to access non-existent properties:
setStats({
  lessonsCompleted: lessonsCompleted.data?.length || 0,
  quizzesTaken: quizzesTaken.data?.length || 0,  // ❌ Not in interface
  challengesCompleted: challengesCompleted.data?.length || 0,
  topicProgress: topicProgress.data || [],  // ❌ Not in interface
  achievements: achievements.data || [],  // ❌ Not in interface
  activityLogs: activityLogs.data || [],  // ❌ Not in interface
  // ...
});
```

**Impact**: Profile page will either crash or fail to display stats properly.
**Fix**: Update `UserStats` interface to match actual usage, or fix the assignment.

---

### 3. Non-Existent Database Table: `study_sessions`
**File**: `src/pages/ProfilePage.tsx:99`
**Priority**: CRITICAL
**Status**: DATABASE QUERY WILL FAIL

```tsx
supabase.from("study_sessions").select("*").eq("user_id", userId).not("ended_at", "null"),
```

**Impact**: Profile page will fail to load due to database query error.
**Fix**: Either create the `study_sessions` table or remove this query.

---

### 4. Edge Function Dependency: `challenge-sessions`
**File**: `src/pages/ChallengeSession.tsx:102-116`
**Priority**: CRITICAL
**Status**: EDGE FUNCTION MAY NOT BE DEPLOYED

```tsx
const response = await fetch(
  `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenge-sessions/start`,
  // ...
);
```

**Impact**: Starting a challenge will fail if the edge function isn't deployed.
**Verification Needed**: Check if `/supabase/functions/challenge-sessions/index.ts` is deployed.

---

## High Priority Issues

### 5. Payment System Not Fully Implemented
**File**: `src/pages/BillingPage.tsx`, `src/components/DummyPaymentCard.tsx`
**Priority**: HIGH
**Status**: DUMMY IMPLEMENTATION

The billing page uses a `DummyPaymentCard` component - no real payment processing is integrated.

**Impact**: Users cannot actually make purchases.
**Current Behavior**: Clicking "Pay" on the billing page will trigger `handlePaymentSuccess` which grants the item without any payment verification.

**Fix Required**: Integrate Stripe, PayPal, or another payment processor.

---

### 6. Asset References May Not Exist
**File**: `src/pages/ShopPage.tsx:513-521, 549-556`
**Priority**: HIGH
**Status**: 404 ERRORS ON IMAGES

```tsx
<img
  src={`/icons/themes/theme-${item.name.toLowerCase().replace(/\s+/g, '-')}.png`}
  onError={(e) => {
    const target = e.target as HTMLImageElement;
    target.style.display = 'none';  // Hides broken images
  }}
/>
```

**Impact**: Theme and avatar preview images will show as broken if files don't exist in `/public/icons/themes/` and `/public/icons/avatars/`.

**Fix**: Either ensure all image files exist, or create placeholder images.

---

### 7. Ask Page Credit Guard Redirect Loop
**File**: `src/pages/AskPage.tsx:45-57`, `src/components/CreditGuard.tsx:55-56`
**Priority**: HIGH
**Status**: POTENTIAL INFINITE REDIRECT LOOP

When `CreditGuard` detects 0 credits, it redirects to `/science-lens/pricing`. However:
1. If pricing page also uses credit checks, it could cause a redirect loop
2. The user is forced away with no option to continue

**Fix**: Consider showing a modal instead of forced navigation, or ensure pricing page doesn't have credit guard.

---

### 8. Challenges Locked - May Confuse Users
**File**: `src/pages/ChallengesPage.tsx:276-361`
**Priority**: HIGH
**Status**: USER EXPERIENCE ISSUE

Challenges are locked until at least 1 lesson is completed. However:
- No clear indication this is the requirement until visiting the page
- No "Start Learning" call-to-action on the locked screen (there is, but it could be more prominent)

**Current UX**: Shows locked state with helpful message
**Improvement**: Consider showing "Complete 1 lesson to unlock challenges" notification elsewhere in the app.

---

### 9. Lesson Navigation URL Mismatch
**File**: `src/pages/LessonPlayer.tsx:481`
**Priority**: HIGH
**Status**: BROKEN NAVIGATION

```tsx
navigate(`/science-lens/learning/${courseSlug}/lesson/${nextLesson.slug}`);
```

But the route in `App.tsx` is:
```tsx
<Route path="learning/:courseSlug/:lessonSlug" element={<LessonPlayer />} />
```

**Impact**: Auto-navigation to next lesson will navigate to wrong URL, causing 404.

**Fix**: Change to `/science-lens/learning/${courseSlug}/${nextLesson.slug}` (remove `/lesson/`)

---

### 10. Missing RPC Function: `spend_coins`
**File**: `src/pages/ShopPage.tsx:264`
**Priority**: HIGH
**Status**: DATABASE FUNCTION MAY NOT EXIST

```tsx
const { error: spendError } = await supabase.rpc('spend_coins', {
  user_id: userId,
  amount: item.price,
  item_id: item.id
});
```

**Verification Needed**: Check if `spend_coins` RPC function exists in database migrations.

---

### 11. XP Boost Active But No Expiry Handler
**File**: `src/pages/ShopPage.tsx:94-98`
**Priority**: HIGH
**Status**: INCOMPLETE FEATURE

```tsx
if (remaining === 0) {
  // Boost expired, refresh profile
  loadUserProfile(userId!);
}
```

This only refreshes the profile when boost expires. The actual boost multiplier should be reset to 1 in the database.

**Fix**: When boost expires, also update `active_xp_boost` back to 1 and clear `xp_boost_expires_at`.

---

## Medium Priority Issues

### 12. Settings Page Only Tests Connection
**File**: `src/components/Settings.tsx`
**Priority**: MEDIUM
**Status**: FEATURE INCOMPLETE

Settings page only allows testing OpenAI connection. No other settings are configurable:
- No way to change API key
- No user preferences
- No account settings
- No notification settings

**Current State**: Minimal settings page

---

### 13. Profile Page Components May Be Missing
**File**: `src/pages/ProfilePage.tsx:12-20`
**Priority**: MEDIUM
**Status**: UNVERIFIED COMPONENTS

```tsx
import ProfileHeader from "@/components/profile/ProfileHeader";
import StatsOverview from "@/components/profile/StatsOverview";
import XPProgressGraph from "@/components/profile/XPProgressGraph";
import TopicMasteryRadar from "@/components/profile/TopicMasteryRadar";
import LearningStreakHeatMap from "@/components/profile/LearningStreakHeatMap";
import RecentActivityTimeline from "@/components/profile/RecentActivityTimeline";
import AchievementsGrid from "@/components/profile/AchievementsGrid";
import PerformanceBySubject from "@/components/profile/PerformanceBySubject";
```

**Verification Needed**: Check if these components exist in `/src/components/profile/` directory.

---

### 14. Leaderboard May Show Incorrect Data
**File**: `src/pages/LeaderboardPage.tsx:114-120`
**Priority**: MEDIUM
**Status**: INCORRECT DATE FILTERING

```tsx
if (tab === "weekly" || tab === "monthly") {
  query = query.gte(
    tab === "weekly" ? "week_start_date" : "month_start_date",
    new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString()
  );
}
```

This uses the same date for both weekly and monthly. Weekly should use start of current week, not start of current month.

**Fix**: Use proper week calculation for weekly tab.

---

### 15. Course Related Courses May Be Empty
**File**: `src/pages/CoursePage.tsx:94-120`
**Priority**: MEDIUM
**Status**: FEATURE MAY NOT DISPLAY

The "Related Courses" section queries by category and excludes current course. If there are no other courses in the same category, nothing shows.

**Current Behavior**: Correct, but could show "No related courses available" message.

---

### 16. Challenge Session Resume May Not Work
**File**: `src/pages/ChallengeSession.tsx:145-196`
**Priority**: MEDIUM
**Status**: UNTESTED FEATURE

Resuming an existing challenge session loads from the edge function. This path is less tested than starting a new session.

**Testing Needed**: Verify that resuming challenges works correctly.

---

### 17. AI Hint Cost Not Clear to User
**File**: `src/pages/LessonPlayer.tsx:777-811`
**Priority**: MEDIUM
**Status**: USER EXPERIENCE

The AI hint button mentions "costs 1 credit" in small text, but:
- No confirmation before spending credit
- No warning if user has low credits
- Credit amount not shown nearby

**Improvement**: Show current credits and add confirmation dialog.

---

### 18. Quiz Results Page - Review Button May Not Work
**File**: `src/pages/LessonPlayer.tsx:814-834`
**Priority**: MEDIUM
**Status**: UNVERIFIED FEATURE

The quiz results page shows a "Review" button via `showReviewButton={true}`. Need to verify the QuizResults component properly handles the review functionality.

---

## Low Priority Issues

### 19. Onboarding Cutscene Status
**File**: `src/components/LandingPage.tsx:18`
**Priority**: LOW
**Status:** FEATURE EXISTS BUT NEEDS VERIFICATION

```tsx
import { OnboardingCutscene } from "./OnboardingCutscene";
```

**Verification Needed**: Check if OnboardingCutscene component exists and is functional.

---

### 20. Admin Toggle on Shop Page
**File**: `src/pages/ShopPage.tsx:843`
**Priority**: LOW
**Status**: DEVELOPMENT/TESTING FEATURE

```tsx
<AdminToggle />
```

This appears to be a testing feature for toggling admin mode. Should be hidden in production or only visible to actual admins.

---

### 21. Landing Page Intro Cannot Be Disabled
**File**: `src/components/LandingPage.tsx:136-144`
**Priority**: LOW
**Status**: MINOR UX ISSUE

The starfield intro animation plays for 4 seconds every time. While there's a "Skip Intro" button, users who've seen it before shouldn't have to skip it manually each visit.

**Improvement**: Store preference in localStorage and auto-skip after first visit.

---

### 22. Lesson Locked Toast May Spam
**File**: `src/pages/CoursePage.tsx:204-217`
**Priority**: LOW
**Status**: MINOR UX ISSUE

When clicking a locked lesson, a toast error is shown. If user clicks multiple times, multiple toasts appear.

**Fix**: Toast library typically handles deduplication, but verify.

---

### 23. Missing Skeleton Loading States
**File**: Multiple pages
**Priority**: LOW
**Status**: MINOR UX IMPROVEMENT

Some pages use `<Loader2 />` spinners, others use nothing. Consider using skeleton loaders for better perceived performance.

---

## Edge Functions Status

Based on file structure, the following edge functions exist:

| Function | File | Status | Notes |
|----------|------|--------|-------|
| `ai-hint` | `/supabase/functions/ai-hint/index.ts` | ✅ Exists | Used in LessonPlayer |
| `ask` | `/supabase/functions/ask/index.ts` | ✅ Exists | Used in AskPage, Settings |
| `challenges` | `/supabase/functions/challenges/index.ts` | ✅ Exists | Unknown usage |
| `challenge-sessions` | `/supabase/functions/challenge-sessions/index.ts` | ✅ Exists | Used in ChallengeSession |
| `courses` | `/supabase/functions/courses/index.ts` | ✅ Exists | Used in CoursePage, LessonPlayer |
| `lessons` | `/supabase/functions/lessons/index.ts` | ✅ Exists | Used in LessonPlayer |
| `search-users` | `/supabase/functions/search-users/index.ts` | ✅ Exists | Admin feature |
| `grant-admin` | `/supabase/functions/grant-admin/index.ts` | ✅ Exists | Admin feature |
| `revoke-admin` | `/supabase/functions/revoke-admin/index.ts` | ✅ Exists | Admin feature |

**Action Required**: Verify all edge functions are deployed to remote Supabase.

---

## Database Dependencies

### Tables Referenced (Verification Needed)

1. `profiles` - User profiles
2. `user_progress` - Lesson progress tracking
3. `user_stats` - XP, credits, admin status
4. `courses` - Course data
5. `lessons` - Lesson data
6. `learning_topics` - Challenge topics
7. `shop_items` - Shop items
8. `user_inventory` - User's purchased items
9. `quiz_results` - Quiz/challenge results
10. `challenge_sessions` - Active challenge sessions
11. `activity_log` - User activity tracking
12. `achievements` - User achievements
13. `user_topic_progress` - Progress by topic
14. `study_sessions` - ⚠️ MAY NOT EXIST (ProfilePage line 99)
15. `questions` - ⚠️ MAY NOT EXIST (ProfilePage line 98)

### RPC Functions Referenced

1. `refresh_daily_credits` - Used in CreditGuard
2. `spend_coins` - Used in ShopPage
3. `get_user_rank` - Used in LeaderboardPage

**Action Required**: Verify all tables and RPC functions exist in remote database.

---

## Recommendations

### Immediate Actions (Critical)

1. **Fix `userLevel` undefined in ChallengesPage** - This will cause crashes
2. **Fix ProfilePage type mismatches** - Will cause errors or missing data
3. **Fix lesson navigation URL** - Auto-navigation broken
4. **Verify edge functions deployed** - Core features depend on them

### High Priority Actions

1. **Implement actual payment processing** - Currently dummy implementation
2. **Create or remove asset files** - Ensure theme/avatar images exist
3. **Fix XP boost expiry handler** - Doesn't reset multiplier in database
4. **Verify RPC functions exist** - spend_coins, refresh_daily_credits, get_user_rank

### Medium Priority Actions

1. **Create missing profile components** - If they don't exist
2. **Fix weekly leaderboard date filter** - Uses wrong date
3. **Improve low credits UX** - Show warning before running out
4. **Add lesson completion requirements** - Currently only 2 quizzes required

### Testing Checklist

- [ ] Landing page loads and animations play
- [ ] Sign in/sign up flow works
- [ ] Dashboard displays correctly
- [ ] All courses load and display
- [ ] Individual lessons load and can be completed
- [ ] Quizzes submit and show results
- [ ] Challenges start and complete correctly
- [ ] Leaderboard loads and displays data
- [ ] Shop items can be purchased (with coins)
- [ ] Pricing page navigation works
- [ ] Ask AI chat works
- [ ] Settings page tests OpenAI connection
- [ ] Profile page loads all stats

---

## Summary by Page

| Page | Status | Critical Issues | Total Issues |
|------|--------|-----------------|--------------|
| LandingPage | ✅ Good | 0 | 1 |
| Dashboard | ✅ Good | 0 | 0 |
| Learning | ✅ Good | 0 | 0 |
| CoursePage | ⚠️ Minor | 0 | 1 |
| LessonPlayer | ⚠️ Minor | 1 (URL) | 3 |
| ChallengesPage | ❌ Broken | 1 (userLevel) | 2 |
| ChallengeSession | ⚠️ Minor | 0 | 2 |
| AskPage | ✅ Good | 0 | 1 |
| LeaderboardPage | ⚠️ Minor | 0 | 2 |
| ShopPage | ⚠️ Minor | 0 | 4 |
| PricingPage | ⚠️ Minor | 0 | 1 |
| BillingPage | ❌ Dummy | 0 | 1 |
| SettingsPage | ✅ Good | 0 | 1 |
| ProfilePage | ❌ Broken | 2 (types, table) | 4 |
| AchievementsPage | ✅ Good | 0 | 0 |

---

## Appendix: Quick Fix Code Snippets

### Fix 1: ChallengesPage userLevel

```tsx
// In ChallengesPage.tsx, add to state:
const [userLevel, setUserLevel] = useState(1);

// In initializePage function, after loading user:
const { data: profileData } = await supabase
  .from('profiles')
  .select('level')
  .eq('user_id', session.user.id)
  .single();

if (profileData) {
  setUserLevel(profileData.level);
}
```

### Fix 2: Lesson Navigation URL

```tsx
// In LessonPlayer.tsx line 481, change:
navigate(`/science-lens/learning/${courseSlug}/lesson/${nextLesson.slug}`);
// To:
navigate(`/science-lens/learning/${courseSlug}/${nextLesson.slug}`);
```

### Fix 3: ProfilePage Type Fix

```tsx
// Update UserStats interface to match actual usage:
interface UserStats {
  lessonsCompleted: number;
  quizzesTaken: number;
  challengesCompleted: number;
  topicProgress: any[];
  achievements: any[];
  activityLogs: any[];
  streakCount: number;
  totalQuestions: number;
  xpPoints: number;
  level: number;
}
```

---

**Report End**

For questions or clarifications about any issue, please refer to the specific line numbers and files mentioned above.
