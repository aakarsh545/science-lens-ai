# PRP-001: Premium Features & Coins System

**Status**: DRAFT
**Author**: Claude
**Date**: 2024-12-28
**Priority**: HIGH
**Estimated Effort**: 5 phases, ~35 tasks

---

## Executive Summary

This PRP implements a comprehensive premium monetization system for Science Lens, adding a dual-currency economy (XP + Coins), premium-locked lessons, and a virtual shop for themes and avatars. Currently, the platform has no monetization or premium features. The new system will create revenue potential through premium subscriptions while providing free users with coin-based customization options, delivering a sustainable business model and enhanced user engagement.

---

## Problem Statement

### Current State

The platform currently has:
1. **No monetization strategy** - All content is free, no revenue potential
2. **No premium tier** - Missing subscriber benefits and upgrade incentives
3. **Limited personalization** - Users cannot customize their experience
4. **No engagement incentives** - Beyond XP, no reward for consistent activity

Key points:
1. **No Premium Tier**: All lessons available to everyone, no upgrade path
2. **No Virtual Economy**: Single currency (XP) with no spending mechanism
3. **No Customization**: No themes, avatars, or personalization options
4. **No Revenue Model**: Platform cannot sustain or generate income

### Impact

| Issue | User Impact | Business Impact |
|-------|-------------|-----------------|
| No premium tier | No perceived value for paid subscription | $0 potential revenue |
| No virtual economy | Limited engagement retention | No microtransaction revenue |
| No customization | Generic user experience | Reduced user investment |
| Free-only content | Perceived as lower value | No upgrade incentives |

### Success Criteria

- [ ] Coins system fully integrated alongside XP (separate tracking)
- [ ] 50% of lessons locked behind premium tier
- [ ] Premium users receive 2x coin multiplier
- [ ] Virtual shop functional with 10+ themes and 15+ avatars
- [ ] Coin earning mechanics implemented (lessons, challenges, achievements)

---

## Proposed Solution

### Overview

Implement a dual-currency economy where:
- **XP**: Progression currency (levels, unlocks) - unchanged
- **Coins**: Premium currency for shop purchases - new system
- **Premium Tier**: Unlocks 50% of lessons + 2x coin multiplier
- **Virtual Shop**: Themes and avatars purchasable with coins

Architecture:
```
┌─────────────────────────────────────────────────────────────────────────────┐
│  PREMIUM SYSTEM ARCHITECTURE                                                  │
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │   XP System  │    │  Coin System │    │  Shop System │                   │
│  │              │    │              │    │              │                   │
│  │ Level prog.  │    │ Buy themes   │    │ Themes DB    │                   │
│  │ Unlocks      │    │ Buy avatars  │    │ Avatars DB   │                   │
│  └──────────────┘    └──────┬───────┘    └──────┬───────┘                   │
│                             │                    │                           │
│                             └────────┬───────────┘                           │
│                                      ▼                                       │
│                            ┌──────────────────┐                             │
│                            │  User Profiles   │                             │
│                            │                  │                             │
│                            │ is_premium: bool │                             │
│                            │ coins: integer   │                             │
│                            │ theme: string    │                             │
│                            │ avatar: string   │                             │
│                            └────────┬─────────┘                             │
│                                     ▼                                        │
│                            ┌──────────────────┐                             │
│                            │  Access Control  │                             │
│                            │                  │                             │
│                            │ Check premium    │                             │
│                            │ 2x multiplier    │                             │
│                            │ Lock lessons     │                             │
│                            └──────────────────┘                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Architecture / Design

#### 1. Coin System

**Database Schema:**
```sql
-- Add coins to user_profiles
ALTER TABLE user_profiles
  ADD COLUMN coins INTEGER DEFAULT 0,
  ADD COLUMN is_premium BOOLEAN DEFAULT false;

-- Track coin transactions
CREATE TABLE coin_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  amount INTEGER NOT NULL,
  source TEXT NOT NULL, -- 'lesson', 'challenge', 'achievement', 'purchase'
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast queries
CREATE INDEX idx_coin_transactions_user
  ON coin_transactions(user_id, created_at DESC);
```

**Coin Earning Rates:**
```typescript
// Base coin rewards (before premium multiplier)
const COIN_REWARDS = {
  lesson_complete: 10,
  challenge_beginner: 25,
  challenge_intermediate: 50,
  challenge_advanced: 100,
  achievement: 20,
  daily_streak: 15,
  quiz_perfect: 5
};

// Premium multiplier
function getCoinReward(baseAmount: number, isPremium: boolean): number {
  return isPremium ? baseAmount * 2 : baseAmount;
}
```

#### 2. Premium Lesson Locking

**Database Schema:**
```sql
-- Add premium flag to lessons
ALTER TABLE lessons
  ADD COLUMN is_premium BOOLEAN DEFAULT false;

-- Mark 50% of lessons as premium
-- Strategy: Every second lesson in each course, or alternate by difficulty
UPDATE lessons
SET is_premium = true
WHERE MOD(order_index, 2) = 0; -- Every second lesson
```

**Access Control Logic:**
```typescript
// Check lesson access
async function canAccessLesson(userId: string, lessonId: string): Promise<boolean> {
  const { data: lesson } = await supabase
    .from('lessons')
    .select('is_premium')
    .eq('id', lessonId)
    .single();

  if (!lesson?.is_premium) return true; // Free lesson

  const { data: profile } = await supabase
    .from('user_profiles')
    .select('is_premium')
    .eq('user_id', userId)
    .single();

  return profile?.is_premium || false;
}
```

#### 3. Virtual Shop System

**Database Schema:**
```sql
-- Shop items
CREATE TABLE shop_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL, -- 'theme' or 'avatar'
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  price INTEGER NOT NULL,
  is_premium_exclusive BOOLEAN DEFAULT false,
  icon_url TEXT,
  preview_url TEXT,
  metadata JSONB, -- theme colors, avatar config, etc.
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- User inventory
CREATE TABLE user_inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  item_id UUID REFERENCES shop_items(id) ON DELETE CASCADE,
  purchased_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, item_id)
);

-- User equipped items
ALTER TABLE user_profiles
  ADD COLUMN equipped_theme UUID REFERENCES shop_items(id),
  ADD COLUMN equipped_avatar UUID REFERENCES shop_items(id);
```

**Initial Shop Inventory:**

**Themes (10 total):**
```typescript
const THEMES = [
  // Free themes (5)
  { id: 'cosmic-default', name: 'Cosmic Blue', price: 0, colors: { primary: '#3b82f6', bg: '#0f172a' } },
  { id: 'nebula-purple', name: 'Nebula Purple', price: 0, colors: { primary: '#8b5cf6', bg: '#1e1b4b' } },
  { id: 'aurora-green', name: 'Aurora Green', price: 0, colors: { primary: '#10b981', bg: '#064e3b' } },
  { id: 'solar-orange', name: 'Solar Orange', price: 0, colors: { primary: '#f97316', bg: '#431407' } },
  { id: 'ocean-teal', name: 'Ocean Teal', price: 0, colors: { primary: '#14b8a6', bg: '#134e4a' } },

  // Premium themes (5)
  { id: 'quantum-gold', name: 'Quantum Gold', price: 500, colors: { primary: '#fbbf24', bg: '#451a03' } },
  { id: 'dark-matter', name: 'Dark Matter', price: 500, colors: { primary: '#6366f1', bg: '#000000' } },
  { id: 'plasma-pink', name: 'Plasma Pink', price: 750, colors: { primary: '#ec4899', bg: '#831843' } },
  { id: 'crystalline', name: 'Crystalline', price: 1000, colors: { primary: '#06b6d4', bg: '#083344' } },
  { id: 'rainbow-quantum', name: 'Rainbow Quantum', price: 1500, colors: { primary: 'gradient', bg: '#1a1a2e' } }
];
```

**Avatars (15 total - Science-themed):**
```typescript
const AVATARS = [
  // Free avatars (8)
  { id: 'atom-blue', name: 'Atom Scientist', price: 0, emoji: '⚛️' },
  { id: 'rocket-explorer', name: 'Rocket Explorer', price: 0, emoji: '🚀' },
  { id: 'lab-researcher', name: 'Lab Researcher', price: 0, emoji: '🔬' },
  { id: 'planet-discoverer', name: 'Planet Discoverer', price: 0, emoji: '🪐' },
  { id: 'telescope-astronomer', name: 'Stargazer', price: 0, emoji: '🔭' },
  { id: 'magnet-physicist', name: 'Magnet Master', price: 0, emoji: '🧲' },
  { id: 'test-tube-chemist', name: 'Chemistry Whiz', price: 0, emoji: '🧪' },
  { id: 'microscope-biologist', name: 'Microscope Pro', price: 0, emoji: '🔍' },

  // Premium avatars (7)
  { id: 'einstein-legend', name: 'Einstein Legend', price: 300, emoji: '👨‍🔬' },
  { id: 'quantum-physicist', name: 'Quantum Genius', price: 400, emoji: '🎓' },
  { id: 'space-cosmonaut', name: 'Space Cosmonaut', price: 500, emoji: '👨‍🚀' },
  { id: 'robot-ai', name: 'AI Researcher', price: 600, emoji: '🤖' },
  { id: 'dna-geneticist', name: 'DNA Master', price: 700, emoji: '🧬' },
  { id: 'black-hole-expert', name: 'Black Hole Expert', price: 1000, emoji: '🌌' },
  { id: 'nuclear-scientist', name: 'Nuclear Genius', price: 1500, emoji: '☢️' }
];
```

#### 4. Shop UI Components

**ShopPage Component:**
```typescript
// Tabs: Themes | Avatars
// Grid of items with:
// - Icon/preview
// - Name
// - Price in coins
// - "Purchase" or "Owned" button
// - "Equip" button for owned items
// - Premium exclusive badge
```

**Premium Badge:**
```typescript
// Display on locked lessons
<PremiumBadge>
  <LockIcon />
  <span>Premium Lesson</span>
  <button>Upgrade to Unlock</button>
</PremiumBadge>
```

#### 5. Coin Integration Points

**Award Coins On:**
- Lesson completion: +10 coins (+20 for premium)
- Challenge completion: +25/50/100 (beginner/intermediate/advanced)
- Achievement unlock: +20 coins
- Daily streak: +15 coins per day
- Perfect quiz score: +5 coins bonus
- Profile completion: +50 coins (one-time)

**Display Coins:**
- Header navigation bar (always visible)
- User profile page
- Shop page
- After earning (toast notification)
- Lesson completion modal

### Files to Modify

| File | Action | Description |
|------|--------|-------------|
| `supabase/migrations/20251229000000_add_coins_system.sql` | CREATE | Add coins, is_premium to profiles, create transactions table |
| `supabase/migrations/20251229001000_add_premium_lessons.sql` | CREATE | Add is_premium flag to lessons, mark 50% as premium |
| `supabase/migrations/20251229002000_create_shop_tables.sql` | CREATE | Create shop_items, user_inventory tables |
| `supabase/migrations/20251229003000_populate_shop.sql` | CREATE | Insert initial themes and avatars |
| `supabase/migrations/20251229004000_add_lesson_access_policies.sql` | CREATE | RLS policies for premium lesson access |
| `src/pages/UnifiedLearningPage.tsx` | MODIFY | Show premium badges, lock premium lessons |
| `src/pages/LessonPlayer.tsx` | MODIFY | Add coin rewards, premium check |
| `src/pages/ChallengesPage.tsx` | MODIFY | Award coins on completion |
| `src/pages/ShopPage.tsx` | CREATE | New shop page with themes/avatars |
| `src/components/CoinBalance.tsx` | CREATE | Display coin balance in header |
| `src/components/PremiumBadge.tsx` | CREATE | Premium lesson indicator |
| `src/components/ShopCard.tsx` | CREATE | Shop item card component |
| `src/components/ThemeSelector.tsx` | CREATE | Theme preview and equip |
| `src/components/AvatarSelector.tsx` | CREATE | Avatar selector |
| `src/utils/coinService.ts` | CREATE | Coin earning and spending logic |
| `src/utils/premiumService.ts` | CREATE | Premium access checking |
| `src/hooks/useCoins.ts` | CREATE | Coin balance hook |
| `src/hooks/usePremium.ts` | CREATE | Premium status hook |
| `src/App.tsx` | MODIFY | Add theme provider, coin provider |
| `src/integrations/supabase/client.ts` | MODIFY | Add coin types |

---

## Documentation Requirements

### Documentation Checklist
- [ ] **D.1** Create shop-items.md listing all themes/avatars with prices
- [ ] **D.2** Document coin earning rates in economy.md
- [ ] **D.3** Create premium-features.md explaining tier benefits
- [ ] **D.4** Update CLAUDE.md with premium system architecture

### README / Docs Updates

| File | Action | Scope |
|------|--------|-------|
| `CLAUDE.md` | UPDATE | Add premium system section |
| `docs/economy.md` | CREATE | Coin earning and spending guide |
| `docs/premium-benefits.md` | CREATE | Premium tier benefits |

---

## Pre-Flight Checks

> **MANDATORY**: These checks MUST pass before starting implementation.

- [ ] npm install succeeds
- [ ] npm run build succeeds (baseline)
- [ ] npm run dev runs without errors
- [ ] No TypeScript errors in codebase
- [ ] Supabase CLI authenticated: `npx supabase status` shows running

---

## Implementation Tasks

### Phase 1: Database Schema & Migrations

**Objective**: Set up database tables for coins, premium flags, and shop

#### Tasks
- [ ] **1.1** Create migration: Add coins column and is_premium flag to user_profiles
- [ ] **1.2** Create migration: Add coin_transactions table with indexes
- [ ] **1.3** Create migration: Add is_premium column to lessons table
- [ ] **1.4** Create migration: Update 50% of lessons to is_premium = true
- [ ] **1.5** Create migration: Create shop_items table
- [ ] **1.6** Create migration: Create user_inventory table
- [ ] **1.7** Create migration: Add equipped_theme and equipped_avatar to user_profiles
- [ ] **1.8** Create migration: Insert 10 themes (5 free, 5 premium)
- [ ] **1.9** Create migration: Insert 15 avatars (8 free, 7 premium)
- [ ] **1.10** Create migration: Add RLS policies for premium lesson access
- [ ] **1.11** Create migration: Add RLS policies for shop and inventory
- [ ] **1.12** Push migrations to remote database

#### Build Gate
```bash
npx supabase db push
npx supabase db remote commits
```

#### Phase Completion
```
<promise>PRP-001 PHASE 1 COMPLETE</promise>
```

---

### Phase 2: Core Coin System

**Objective**: Implement coin earning and tracking logic

#### Tasks
- [ ] **2.1** Create `src/utils/coinService.ts` with coin earning functions
- [ ] **2.2** Create `src/hooks/useCoins.ts` hook for balance access
- [ ] **2.3** Update LessonPlayer.tsx to award coins on completion
- [ ] **2.4** Update ChallengeSession.tsx to award coins
- [ ] **2.5** Update achievement system to award coins
- [ ] **2.6** Create CoinBalance component for header
- [ ] **2.7** Add CoinBalance to AppLayout header
- [ ] **2.8** Add coin notification toast on earning
- [ ] **2.9** Test coin earning on lesson completion
- [ ] **2.10** Verify premium 2x multiplier works

#### Build Gate
```bash
npm run build
npm run lint
```

#### Phase Completion
```
<promise>PRP-001 PHASE 2 COMPLETE</promise>
```

---

### Phase 3: Premium Lesson Access

**Objective**: Implement lesson locking and premium checks

#### Tasks
- [ ] **3.1** Create `src/utils/premiumService.ts` with access checking
- [ ] **3.2** Create PremiumBadge component
- [ ] **3.3** Update UnifiedLearningPage to show premium badges
- [ ] **3.4** Update CoursePage to lock premium lessons
- [ ] **3.5** Update LessonPlayer to check premium access
- [ ] **3.6** Add "Upgrade to Premium" upsell modal
- [ ] **3.7** Redirect non-premium users from premium lessons
- [ ] **3.8** Test lesson access enforcement
- [ ] **3.9** Verify free users cannot access premium lessons
- [ ] **3.10** Test premium users can access all lessons

#### Build Gate
```bash
npm run build
npm run dev
```

#### Phase Completion
```
<promise>PRP-001 PHASE 3 COMPLETE</promise>
```

---

### Phase 4: Shop System

**Objective**: Build virtual shop for themes and avatars

#### Tasks
- [ ] **4.1** Create `src/pages/ShopPage.tsx` with tabbed interface
- [ ] **4.2** Create `src/components/ShopCard.tsx` for item display
- [ ] **4.3** Create `src/components/ThemeSelector.tsx` for theme preview
- [ ] **4.4** Create `src/components/AvatarSelector.tsx` for avatar selection
- [ ] **4.5** Implement purchase function in coinService
- [ ] **4.6** Add equip/equip functionality
- [ ] **4.7** Create inventory view in ShopPage
- [ ] **4.8** Add "Not enough coins" error handling
- [ ] **4.9** Add purchase confirmation dialog
- [ ] **4.10** Test theme purchase and application
- [ ] **4.11** Test avatar purchase and application
- [ ] **4.12** Verify premium exclusive items require premium

#### Build Gate
```bash
npm run build
npm run lint
```

#### Phase Completion
```
<promise>PRP-001 PHASE 4 COMPLETE</promise>
```

---

### Phase 5: Theme System Integration

**Objective**: Implement dynamic theme switching based on user selection

#### Tasks
- [ ] **5.1** Create theme configuration types
- [ ] **5.2** Create ThemeProvider wrapper component
- [ ] **5.3** Update App.tsx to use ThemeProvider
- [ ] **5.4** Fetch user's equipped theme on load
- [ ] **5.5** Apply theme CSS variables globally
- [ ] **5.6** Create theme preview modal
- [ ] **5.7** Add theme switching animation
- [ ] **5.8** Test theme persistence across sessions
- [ ] **5.9** Verify all components respect theme colors
- [ ] **5.10** Add theme to user profile display

#### Build Gate
```bash
npm run build
npm run dev
```

#### Phase Completion
```
<promise>PRP-001 PHASE 5 COMPLETE</promise>
```

---

### Phase 6: Integration Testing

**Objective**: Comprehensive testing of all premium features

#### Section A: Coin System Tests

- [ ] **6.A.1** Test coin earning on lesson completion (free user)
- [ ] **6.A.2** Test coin earning on lesson completion (premium user = 2x)
- [ ] **6.A.3** Test coin earning on challenge completion
- [ ] **6.A.4** Test coin deduction on purchase
- [ ] **6.A.5** Test coin transaction history recording

#### Section B: Premium Access Tests

- [ ] **6.B.1** Test free user cannot access premium lesson (direct URL)
- [ ] **6.B.2** Test free user sees premium badge on locked lessons
- [ ] **6.B.3** Test premium user can access all lessons
- [ ] **6.B.4** Test premium badge hidden for premium users
- [ ] **6.B.5** Test upsell modal displays for free users

#### Section C: Shop System Tests

- [ ] **6.C.1** Test user can purchase theme with sufficient coins
- [ ] **6.C.2** Test user cannot purchase theme with insufficient coins
- [ ] **6.C.3** Test purchased item appears in inventory
- [ ] **6.C.4** Test theme applies immediately after equipping
- [ ] **6.C.5** Test avatar updates in profile
- [ ] **6.C.6** Test premium exclusive items locked for free users
- [ ] **6.C.7** Test owned items persist across sessions

#### Section D: Theme System Tests

- [ ] **6.D.1** Test theme colors apply globally
- [ ] **6.D.2** Test theme persists on page reload
- [ ] **6.D.3** Test theme preview shows correct colors
- [ ] **6.D.4** Test default theme for new users
- [ ] **6.D.5** Test theme switching animation smooth

#### Section E: End-to-End Tests

- [ ] **6.E.1** Complete lesson → Earn coins → Buy theme → Apply
- [ ] **6.E.2** Free user flow: See premium lesson → Upgrade → Access
- [ ] **6.E.3** Premium user: Complete lesson → Earn 2x coins → Buy avatar
- [ ] **6.E.4** Daily streak: Complete multiple days → Earn streak coins
- [ ] **6.E.5** Challenge: Complete challenge → Earn coins → Spend

#### Build Gate
```bash
npm run build
npm run test
npm run lint
```

#### Phase Completion
```
<promise>PRP-001 PHASE 6 COMPLETE</promise>
```

---

## Final Verification

- [ ] All phase promises output (Phases 1-6)
- [ ] `npm run build` passes
- [ ] `npm run test` passes
- [ ] Integration testing completed
- [ ] All coin earning points functional
- [ ] Premium access correctly enforced
- [ ] Shop purchases working
- [ ] Theme switching working
- [ ] No TypeScript errors
- [ ] No console errors in dev environment
- [ ] Code follows project patterns
- [ ] All migrations pushed to Supabase
- [ ] Changes committed with descriptive message

---

## Final Completion

When ALL of the above are complete:
```
<promise>PRP-001 COMPLETE</promise>
```

---

## Rollback Plan

```bash
# If issues discovered after deployment:

# Option 1: Revert database migrations
npx supabase db revert <migration-file>

# Option 2: Disable premium features via feature flag
# UPDATE user_profiles SET is_premium = false WHERE true;

# Option 3: Data cleanup
DELETE FROM coin_transactions WHERE created_at > '2024-12-29';
DELETE FROM user_inventory WHERE purchased_at > '2024-12-29';
UPDATE user_profiles SET coins = 0 WHERE coins IS NOT NULL;

# Option 4: Code rollback
git revert HEAD~N  # revert commits from this PRP
```

---

## Open Questions & Decisions

### Q1: Which lessons should be premium?

**Options:**
- A) Every second lesson in sequential order
- B) All intermediate and advanced difficulty lessons
- C) Random 50% selection
- D) Last 50% of each course

**Recommendation:** A) Every second lesson in sequential order
This provides a balanced experience where free users get the foundation of each topic, but need premium for the complete curriculum. It creates natural upgrade points without blocking too much content.

### Q2: Should free users earn coins?

**Options:**
- A) Yes, but at 1x rate (premium gets 2x)
- B) No, only premium users earn coins
- C) Yes, same rate for all

**Recommendation:** A) Yes, but at 1x rate
This allows free users to experience the shop and buy some items, creating engagement. Premium users still get clear value with 2x multiplier.

### Q3: Coin prices for shop items?

**Options:**
- A) Low prices (50-200 coins) - easy to earn
- B) Medium prices (200-1000 coins) - balanced
- C) High prices (1000-5000 coins) - requires grinding

**Recommendation:** B) Medium prices (200-1000 coins)
Balanced approach where users can earn items in 5-20 lessons, keeping engagement without making it too easy or too grindy.

### Q4: Should there be coin packages for real money?

**Options:**
- A) Yes, sell coin packs ($5 = 500 coins, etc.)
- B) No, coins only earnable through activity
- C) Hybrid: Earn + buy option

**Recommendation:** C) Hybrid (future consideration)
For PRP-001, focus on earnable coins only. Future PRP can add real-money coin purchases as additional monetization.

---

## Appendix A: Coin Economy Balancing

### Earning Rates

| Activity | Base Coins | Premium (2x) | Time Required |
|----------|------------|--------------|---------------|
| Lesson completion | 10 | 20 | 5-10 min |
| Challenge - Beginner | 25 | 50 | 10-15 min |
| Challenge - Intermediate | 50 | 100 | 20-30 min |
| Challenge - Advanced | 100 | 200 | 30-45 min |
| Achievement unlock | 20 | 40 | Varies |
| Daily streak | 15 | 30 | Daily |
| Perfect quiz | 5 | 10 | Per lesson |

### Shop Prices

| Item Type | Free Items | Premium Items | Premium Exclusive |
|-----------|------------|---------------|-------------------|
| Themes | 0 coins | 500-1500 coins | N/A |
| Avatars | 0 coins | 300-1500 coins | Future feature |

### Time to Unlock

- **Free theme**: 0 lessons (free)
- **Premium theme (500 coins)**: 25 lessons (free) or 13 lessons (premium)
- **Premium avatar (300 coins)**: 15 lessons (free) or 8 lessons (premium)
- **Best items (1500 coins)**: 75 lessons (free) or 38 lessons (premium)

---

## Appendix B: Science Theme Adaptations

### Avatar Progression (Science Career Path)

**Tier 1 - Free (Beginner Scientists):**
- ⚛️ Atom Scientist - Starting avatar
- 🚀 Rocket Explorer - Space enthusiast
- 🔬 Lab Researcher - Biology starter
- 🪐 Planet Discoverer - Astronomy beginner
- 🔭 Stargazer - Observation focus
- 🧲 Magnet Master - Physics starter
- 🧪 Test Tube Chemist - Chemistry starter
- 🔍 Microscope Pro - Discovery focus

**Tier 2 - Premium (Advanced Scientists):**
- 👨‍🔬 Einstein Legend - Physics mastery (300 coins)
- 🎓 Quantum Genius - Advanced physicist (400 coins)
- 👨‍🚀 Space Cosmonaut - Space exploration (500 coins)
- 🤖 AI Researcher - Technology expert (600 coins)
- 🧬 DNA Master - Genetics expert (700 coins)
- 🌌 Black Hole Expert - Cosmology master (1000 coins)
- ☢️ Nuclear Genius - Nuclear physics (1500 coins)

### Theme Names (Science-Inspired)

**Free Themes:**
1. **Cosmic Blue** - Default space theme
2. **Nebula Purple** - Deep space nebula
3. **Aurora Green** - Northern lights inspired
4. **Solar Orange** - Solar energy theme
5. **Ocean Teal** - Marine biology focus

**Premium Themes:**
1. **Quantum Gold** - Advanced physics (500 coins)
2. **Dark Matter** - Dark mysterious theme (500 coins)
3. **Plasma Pink** - High energy physics (750 coins)
4. **Crystalline** - Mineralogy/crystallography (1000 coins)
5. **Rainbow Quantum** - Quantum superposition (1500 coins)

---

## Appendix C: Premium Upgrade Flow

```
User Flow:
1. Free user clicks premium lesson
2. Modal appears: "This lesson requires premium"
3. Benefits listed:
   - Unlock 50% more lessons
   - Earn 2x coins on all activities
   - Priority access to new features
   - Support science education
4. Button: "Upgrade to Premium"
5. Redirect to pricing page
6. After purchase: is_premium = true
7. User can now access premium lessons
8. Coin multiplier automatically applied
```

---

## References

- [Reference 1]: Supabase RLS policies documentation
- [Reference 2]: Virtual economy best practices
- [Reference 3]: Gaming monetization strategies

---

## Changelog

| Date | Author | Changes |
|------|--------|---------|
| 2024-12-28 | Claude | Initial draft |

---

<!--
WIGGUM EXECUTION COMMAND:
/ralph-loop "Execute PRP-001 per /Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code/docs/PRP-001-premium-features.md. Work through all unchecked tasks sequentially including pre-flight checks and integration testing. Mark each [x] when done. Run build gates after each phase. Output phase promises after each phase. Output <promise>PRP-001 COMPLETE</promise> when all tasks are done. Do NOT ask for confirmation between tasks." --completion-promise "PRP-001 COMPLETE" --max-iterations 50
-->
