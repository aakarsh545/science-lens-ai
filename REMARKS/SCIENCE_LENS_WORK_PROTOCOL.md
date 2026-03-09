# Science Lens AI - Work Protocol

This document is mandatory. Read it before any implementation or PRP creation. It defines the custom PRP rules, gating checklist, and dependency matrix for this codebase.

---

## 1. Canonical Repo

Authoritative repo for active product work is:

- `science-lens-ai-code`

Do not use `science-lens` or `science-lens-ai` as sources of truth.

---

## 2. Critical User Journeys

These must never break. Any change touching related areas must include explicit verification.

1. Authentication → Dashboard → Learning Flow
   Sign in → `/science-lens` → `/science-lens/learning` → lessons load → progress saves.
2. Ask AI → Response → Save to History
   `/science-lens/ask` → submit question → AI response → interaction saved.
3. Challenge Session → Complete → Earn XP → Level Up
   `/challenges/session/:sessionId` → complete → XP saved → level badge updated.

Required dependencies:
- Supabase auth session persistence.
- `user_stats.xp_total` and `profiles.level` accuracy.
- Real-time subscription updates for progress.
- Edge function responsiveness for AI features.

---

## 3. Core Routes and Coupled Files

If you change any related UI, update these dependencies as needed.

| Route | Primary File | Coupled Dependencies |
| --- | --- | --- |
| `/science-lens` | `src/pages/DashboardMainPage.tsx` | user stats, achievements, streaks |
| `/science-lens/learning` | `src/pages/UnifiedLearningPage.tsx` | topics, courses, lessons, progress |
| `/science-lens/learning/:courseSlug/:lessonSlug` | `src/pages/LessonPlayer.tsx` | lesson content, quiz, XP rewards |
| `/science-lens/ask` | `src/components/ChatInterface.tsx` | OpenAI edge function, chat history |
| `/challenges/session/:sessionId` | `src/pages/ChallengeSessionPage.tsx` | quiz questions, timer, scoring |
| `/science-lens/profile` | `src/pages/ProfilePage.tsx` | user data, achievements, stats |
| `/science-lens/shop` | `src/pages/ShopPage.tsx` | credits, premium features |

Shared components with cascading impact:
- `src/components/Dashboard.tsx`
- `src/components/LevelBadge.tsx`
- `src/components/AchievementsView.tsx`

---

## 4. Dependency Matrix (If X, Then Y)

This section is mandatory. If any condition applies, you must complete all required follow-ups.

1. UI change that reads or writes data
   - Update data model or API contract if needed.
   - Update server validation.
   - Update client calls to match edge functions.
   - Update tests or add coverage.
2. New route or page
   - Add to navigation and routing.
   - Ensure auth gating is correct.
   - Add basic analytics event if analytics exist.
3. Data model change
   - Create migration in `supabase/migrations`.
   - Update RLS policies.
   - Run `npx supabase db push`.
   - Regenerate types: `npx supabase gen types typescript --local > src/integrations/supabase/types.ts`.
   - Commit migration and types together.
4. Edge function change
   - Update request and response contracts in client.
   - Update validation logic and rate limiting if applicable.
   - Update security checks and prompt injection defense as needed.
5. Credits or payments change
   - Ensure atomic updates and server-side validation.
   - Add or update audit logging for transactions.
6. Authentication change
   - Verify RLS policies.
   - Verify client-side gating and session persistence.
7. XP, levels, achievements change
   - Update calculation utilities.
   - Update visual components and summary stats.
   - Add or update tests for edge cases.

---

## 5. Priority Order for Decisions

If priorities conflict, resolve in this order:

1. Security
2. Data Integrity
3. Performance
4. Feature Speed
5. UX Polish
6. Cost

---

## 6. Non-Negotiable AI Constraints

All AI outputs must follow:

1. No hallucinated citations.
2. Age-appropriate language.
3. No medical or health advice.
4. Scientific accuracy and clarity.
5. No guidance for harmful activities.

---

## 7. Work Gating Checklist

This checklist must be explicitly completed before any implementation.

1. Identify which critical journey is affected.
2. List files to touch and files to avoid.
3. Confirm data model impact and migration needs.
4. Confirm edge function and API contract impact.
5. Confirm tests and verification steps.
6. Confirm docs to update.

---

## 8. Definition of Done

Complete all that apply.

1. `npm run build`
2. `npm run lint`
3. `npm test` if Playwright or tests are relevant.
4. Manual smoke flows:
   - Auth sign in and sign out.
   - Dashboard loads with user data.
   - Learning page loads and persists progress.
   - Ask AI returns a response.
   - Challenge session completes and saves results.
5. Responsive check at 375px, 768px, 1024px.
6. No console errors.
7. If data model changed:
   - Migration applied.
   - RLS validated.
   - Types regenerated.

---

## 9. Fragile Areas

These areas require extra caution and targeted verification:

- Authentication flow.
- RLS policies.
- Sequential lesson unlocking.
- Challenge sessions.
- AI chat edge function and client integration.

---

## 10. Required Logging and Audit Trails

If you add or change these areas, ensure logging is defined.

1. Credits transactions.
2. AI queries and responses.
3. Challenge completions.
4. Lesson completions.
5. Level changes.

---

## 11. Prompt Packet Template

Required when adding or modifying AI prompts.

1. System prompt template.
2. Constraints.
3. Input format.
4. Output format.
5. Edge cases.
6. Testing checklist.

---

## 12. Custom PRP Rules

In addition to `PRP_FRAMEWORK.md`, use this custom protocol:

1. Every PRP must explicitly list which critical journeys are impacted.
2. Every PRP must include a Dependency Matrix section with the applicable items checked off.
3. Every PRP must include the Definition of Done checks relevant to the change.
4. Every PRP must include a “Files to Avoid” section to prevent accidental changes.
