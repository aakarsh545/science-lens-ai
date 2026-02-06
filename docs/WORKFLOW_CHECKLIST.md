# Workflow Checklist

**Copy this checklist at the top of any task or PRP.** It ensures all critical context is considered before implementation.

**Linked from:** `SCIENCE_LENS_WORK_PROTOCOL.md`

---

## 🔴 GATING QUESTIONS (Must Complete Before Starting)

- [ ] **Have you read `SCIENCE_LENS_WORK_PROTOCOL.md`?**
  - If NO, read it now before continuing.

- [ ] **Which critical journey is affected?**
  - [ ] Auth → Dashboard → Learning
  - [ ] Ask AI → Response → Save
  - [ ] Challenge → Complete → XP → Level Up
  - [ ] Other (specify): ___________

- [ ] **Does this require a PRP?**
  - [ ] YES → Create PRP in `/docs/PRP-XXX.md` first
  - [ ] NO → Simple fix (<10 lines, single file)

---

## 📋 DEPENDENCY MATRIX (Check All That Apply)

### Data Changes
- [ ] New table or column → Create migration
- [ ] RLS policy change → Update security
- [ ] Type regeneration needed → Run `npx supabase gen types typescript --local`

### Frontend Changes
- [ ] New route/page → Add to router, check auth gating
- [ ] Core page update → Check dependency matrix (Section 3)
- [ ] Shared component → Check cascading impacts

### Backend Changes
- [ ] Edge function change → Update API contract
- [ ] Credits/payments → Ensure atomic transactions
- [ ] XP/levels change → Update calculations and UI

---

## 🎯 PRIORITY CHECK

**If priorities conflict, use this order:**

1. Security
2. Data Integrity
3. Performance
4. Feature Speed
5. UX Polish
6. Cost

**Current task priority rank: _____**

---

## 🚨 FRAGILE AREA CHECK

**Is this task touching any fragile area?**

- [ ] Authentication flow → Extra caution
- [ ] RLS policies → Must validate
- [ ] Sequential lesson unlocking → Test edge cases
- [ ] Challenge sessions → Verify scoring
- [ ] AI chat edge function → Test prompts

**If YES, what extra verification is needed?**
_______________________________________________________________
_______________________________________________________________

---

## 📝 FILES TO MODIFY

**Will touch:**
- [ ] `src/pages/_________.tsx`
- [ ] `src/components/_________.tsx`
- [ ] `supabase/migrations/_________.sql`
- [ ] `supabase/functions/_________/index.ts`

**Will avoid:**
- [ ] _________________________
- [ ] _________________________

---

## ✅ DEFINITION OF DONE

**Complete all that apply:**

- [ ] `npm run build` passes
- [ ] `npm run lint` passes
- [ ] `npm test` passes (if tests exist)
- [ ] Manual smoke flows:
  - [ ] Auth sign in/out works
  - [ ] Dashboard loads with user data
  - [ ] Learning page loads and saves progress
  - [ ] Ask AI returns response
  - [ ] Challenge session completes
- [ ] Responsive check (375px, 768px, 1024px)
- [ ] No console errors
- [ ] Migration applied (if data changed)
- [ ] Types regenerated (if data changed)
- [ ] RLS validated (if security changed)

---

## 🔒 SECURITY & CONSTRAINTS

### AI Constraints (if applicable)
- [ ] No hallucinated citations
- [ ] Age-appropriate language
- [ ] No medical/health advice
- [ ] Scientific accuracy

### Data Integrity
- [ ] Foreign key constraints maintained
- [ ] Atomic transactions for credits
- [ ] No duplicate progress records

### Performance
- [ ] Database queries optimized
- [ ] No N+1 queries
- [ ] Efficient re-renders

---

## 📊 LOGGING REQUIREMENTS

**Does this need audit logging?**

- [ ] Credit transactions → Log to `credit_transactions`
- [ ] AI queries → Log tokens and response time
- [ ] Challenge completions → Already in `challenge_sessions`
- [ ] Lesson completions → Already in `lesson_progress`
- [ ] Level changes → Log to `level_changes` (if exists)

---

## 📦 DELIVERABLES

- [ ] Code changes committed
- [ ] Migration pushed (if applicable)
- [ ] Edge function deployed (if applicable)
- [ ] Docs updated (if applicable)
- [ ] PRP marked complete (if applicable)

---

## 🚨 ROLLBACK PLAN

**If this breaks:**

1. Database changes: `git revert <commit>` or manual migration
2. Edge function: `npx supabase functions deploy --no-verify`
3. Frontend: `git revert <commit>`

**Rollback command:**
_______________________________________________________________

---

## 📝 NOTES

**Special considerations:**
_______________________________________________________________
_______________________________________________________________
_______________________________________________________________

**Open questions:**
_______________________________________________________________
_______________________________________________________________

---

## ✨ QUICK REFERENCE

**Key files:**
- Work Protocol: `docs/SCIENCE_LENS_WORK_PROTOCOL.md`
- PRP Framework: `PRP_FRAMEWORK.md`
- PRP Template: `proposals/PRP-TEMPLATE.md`
- Prompt Template: `docs/PROMPT_PACKET_TEMPLATE.md`

**Commands:**
```bash
# Database
npx supabase migration new <name>
npx supabase db push
npx supabase gen types typescript --local > src/integrations/supabase/types.ts

# Edge Functions
npx supabase functions deploy <name>

# Build & Test
npm run build
npm run lint
npm test
```

**Critical routes:**
- `/science-lens` - Dashboard
- `/science-lens/learning` - Learning page
- `/science-lens/ask` - AI chat
- `/challenges/session/:sessionId` - Challenges

---

**Template last updated:** 2025-01-06
