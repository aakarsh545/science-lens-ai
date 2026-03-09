# PRP-001: Cinematic Onboarding Cutscenes

## Executive Summary
Add animated, cinematic cutscenes for user onboarding and key milestones. These will be space/science themed animations with particles, glowing text, and smooth transitions that play when users first join, achieve milestones, or discover new features.

## Problem Statement
- **Current Issue**: No visual wow factor when users first join the platform
- **Impact**: Missed opportunity to create emotional connection and excitement
- **User Feedback**: Static onboarding feels generic and forgettable

## Success Criteria
1. ✅ 3 unique cutscene templates (First Launch, Level Up, Achievement Unlock)
2. ✅ Particle effects and space backgrounds
3. ✅ Animated text with cinematic timing
4. ✅ Skip functionality for returning users
5. ✅ Mobile responsive (60fps on all devices)
6. ✅ Matches existing cosmic design theme

## Proposed Solution

### Cutscene 1: "Journey Begins" - First Launch
**When**: New user completes sign-up
**Duration**: 8 seconds
**Elements**:
- Cosmic particle field (stars moving toward camera)
- Animated logo appearance with glow
- Text fades: "Welcome, [Name]"
- Subtitle: "Your journey through science starts now"
- "Begin Exploration" CTA button with pulse animation
- Background: Deep space nebula with slow rotation

**Technical Implementation**:
- CSS animations for text fade-in/slide-up
- Canvas-based particle system for starfield
- Framer Motion for smooth transitions
- Supabase tracking: Store `seen_intro` flag

### Cutscene 2: "Knowledge Ascended" - Level Up
**When**: User reaches levels 5, 10, 20, 40, 60, 100
**Duration**: 5 seconds
**Elements**:
- Level number grows from center with glow
- XP bar fills with liquid animation
- Particles explode outward in theme color
- Rarity-specific effects:
  - Common: Blue sparkles
  - Rare: Purple nebula
  - Legendary: Gold/fire particles
  - Godly: Rainbow cosmic burst
- Text: "Level [N] Unlocked"
- New unlocks preview below

**Technical Implementation**:
- Framer Motion scale/opacity animations
- Canvas particle explosion
- Color based on level rarity
- Sound effect placeholder (optional)

### Cutscene 3: "Discovery Made" - Achievement Unlock
**When**: User earns an achievement
**Duration**: 4 seconds
**Elements**:
- Achievement icon slides from right
- Lock icon shatters (CSS animation)
- Glow pulse behind icon
- Achievement name types out (letter by letter)
- XP reward counts up (0 → 100)
- "Continue" button appears after delay
- Confetti/particle burst in celebration colors

**Technical Implementation**:
- CSS keyframes for shatter effect
- JavaScript number counter animation
- Canvas confetti system
- Achievement data from Supabase

## Technical Architecture

### Component Structure
```
/src/components/cutscenes/
  ├── CutsceneWrapper.tsx       # Main container with skip logic
  ├── FirstLaunchCutscene.tsx   # "Journey Begins"
  ├── LevelUpCutscene.tsx       # "Knowledge Ascended"
  ├── AchievementCutscene.tsx   # "Discovery Made"
  └── ParticleField.tsx         # Reusable particle system
```

### State Management
```typescript
interface CutsceneState {
  showCutscene: boolean;
  cutsceneType: 'first-launch' | 'level-up' | 'achievement';
  data: any; // Level number, achievement ID, etc.
  hasSkipped: boolean;
}
```

### Database Changes
```sql
-- Add to user_profiles
ALTER TABLE profiles ADD COLUMN seen_intro BOOLEAN DEFAULT false;
ALTER TABLE profiles ADD COLUMN cutscene_settings JSONB DEFAULT '{"autoplay": true}';
```

## Animation Specifications

### Timing & Easing
- Fade-in: 600ms (ease-out)
- Slide-up: 800ms (cubic-bezier(0.16, 1, 0.3, 1))
- Scale: 500ms (ease-out-back)
- Particle lifetime: 2000-3000ms

### Performance Optimization
- Canvas for particles (200+ elements)
- CSS for simple transforms (opacity, scale)
- `requestAnimationFrame` for smooth 60fps
- Lazy load cutscene components
- `will-change` property for animated elements

## Documentation Requirements
1. Component props documentation
2. Animation timing guide for designers
3. Customization guide (colors, text, duration)
4. Browser compatibility matrix

## Pre-Flight Checks
- [x] Framer Motion installed
- [x] React 18+ (concurrent rendering)
- [x] Modern browser support (Chrome 90+, Safari 14+, Firefox 88+)
- [x] Supabase client configured
- [x] Tailwind CSS available

## Implementation Plan

### Phase 1: Core Infrastructure
**Duration**: Foundation
**Tasks**:
1. Create `CutsceneWrapper` component
2. Build reusable `ParticleField` canvas component
3. Add database schema changes
4. Create cutscene routing logic

**Build Gate**: `npm run build` succeeds

**Completion Promise**: `<promise>PRP-001-PHASE1-COMPLETE</promise>`

### Phase 2: First Launch Cutscene
**Duration**: After Phase 1
**Tasks**:
1. Create `FirstLaunchCutscene` component
2. Implement starfield particle effect
3. Add logo animation with glow
4. Create text fade-in sequence
5. Add "Begin" CTA button
6. Implement skip functionality

**Build Gate**: All animations run at 60fps

**Completion Promise**: `<promise>PRP-001-PHASE2-COMPLETE</promise>`

### Phase 3: Level Up Cutscene
**Duration**: After Phase 2
**Tasks**:
1. Create `LevelUpCutscene` component
2. Implement level number animation
3. Add XP bar fill animation
4. Create rarity-based particle effects
5. Add unlock preview section
6. Test at different levels (5, 10, 20, etc.)

**Build Gate**: All rarity variants work correctly

**Completion Promise**: `<promise>PRP-001-PHASE3-COMPLETE</promise>`

### Phase 4: Achievement Cutscene
**Duration**: After Phase 3
**Tasks**:
1. Create `AchievementCutscene` component
2. Implement lock shatter animation
3. Add text typewriter effect
4. Create XP counter animation
5. Add celebration confetti
6. Test with different achievements

**Build Gate**: Confetti renders smoothly (100+ particles)

**Completion Promise**: `<promise>PRP-001-PHASE4-COMPLETE</promise>`

### Phase 5: Integration & Polish
**Duration**: After Phase 4
**Tasks**:
1. Integrate cutscenes into auth flow
2. Add to level-up logic in challenges
3. Connect to achievement system
4. Add mobile responsiveness
5. Performance optimization
6. Browser testing (Chrome, Safari, Firefox)
7. Add accessibility features (reduced motion, keyboard nav)

**Build Gate**: Lighthouse score >90 on all pages

**Completion Promise**: `<promise>PRP-001-PHASE5-COMPLETE</promise>`

## Final Verification Checklist
- [ ] All 3 cutscenes work on first load
- [ ] Skip button appears after 2 seconds
- [ ] Cutscenes respect `seen_intro` flag
- [ ] Level up triggers at correct milestones
- [ ] Achievement cutscene shows correct data
- [ ] Mobile responsive (375px - 1920px)
- [ ] 60fps on mid-range devices
- [ ] No layout shift after cutscene ends
- [ ] Keyboard accessible (Enter to skip)
- [ ] Reduced motion respect for accessibility

## Rollback Plan
If issues arise:
1. Cutscenes can be disabled via database flag
2. Feature flag in `user_profiles.cutscene_settings`
3. Revert commit: `git revert <commit-hash>`
4. No data loss - only visual changes

## Success Metrics
- **Engagement**: Users who watch intro vs skip (target: 70% watch rate)
- **Completion**: Users who return after seeing cutscene (target: +15% day-1 retention)
- **Performance**: Lighthouse Performance score >90
- **Accessibility**: WCAG 2.1 AA compliant

---

**Approval Required**: Start with Phase 1 (Infrastructure) after review
**Estimated Completion**: All 5 phases
**Priority**: High (User experience enhancement)
