# Level Restrictions - Testing Checklist

## Pre-Deployment Testing

### User Level Display
- [ ] Level badge shows current level (L{number})
- [ ] XP total displays correctly
- [ ] Progress bar shows accurate percentage to next level
- [ ] "XP to next level" calculates correctly
- [ ] Visual styling matches other components (gradient background)

### Beginner Lessons (Level 1+)
- [ ] Accessible to all users (even new users at Level 1)
- [ ] No lock icon appears
- [ ] Cards have full opacity
- [ ] Clickable and navigable
- [ ] "Start Lesson" button appears for new topics
- [ ] "Continue Learning" appears for topics with progress
- [ ] Progress data displays (completion %, correct answers, questions answered)

### Intermediate Lessons (Level 10 Required)
**Test with Level 1-9 user:**
- [ ] Lock icon visible on card
- [ ] "Level 10" badge appears
- [ ] Card appears grayed out (60% opacity)
- [ ] Not clickable/navigable
- [ ] "Requires Level 10" message shows in amber
- [ ] Current level displays correctly
- [ ] Progress bar shows level advancement (e.g., Level 5 = 50%)
- [ ] "X more levels to unlock" calculates correctly

**Test with Level 10+ user:**
- [ ] No lock icon
- [ ] Full card appearance
- [ ] Clickable and navigable
- [ ] All progress features work

### Advanced Lessons (Level 20 Required)
**Test with Level 1-19 user:**
- [ ] Lock icon visible
- [ ] "Level 20" badge appears
- [ ] Card appears grayed out
- [ ] Not clickable/navigable
- [ ] "Requires Level 20" message shows
- [ ] Progress bar shows correct advancement
- [ ] "X more levels to unlock" accurate

**Test with Level 20+ user:**
- [ ] No lock icon
- [ ] Full card appearance
- [ ] Clickable and navigable

### Tab Navigation
- [ ] "All Topics" tab shows all lessons with mixed locked/unlocked states
- [ ] "Beginner" tab shows all unlocked
- [ ] "Intermediate" tab shows locked state for low-level users
- [ ] "Advanced" tab shows locked state for users below Level 20

### Level Calculation
- [ ] Level 1: 0-99 XP
- [ ] Level 10: 900-999 XP (unlocks Intermediate)
- [ ] Level 20: 1900-1999 XP (unlocks Advanced)
- [ ] Level updates correctly when XP increases

### Edge Cases
- [ ] User with exactly 900 XP (Level 10) can access Intermediate
- [ ] User with exactly 1900 XP (Level 20) can access Advanced
- [ ] User with 899 XP (Level 9) cannot access Intermediate
- [ ] User with 1899 XP (Level 19) cannot access Advanced
- [ ] Progress displays correctly when no user_progress data exists
- [ ] Error handling if profile/user_stats data missing

### Performance
- [ ] Page loads without significant delay
- [ ] Level calculation doesn't cause lag
- [ ] Multiple API calls (user_stats + profiles) complete efficiently
- [ ] No console errors

### Responsive Design
- [ ] Layout works on mobile (1 column)
- [ ] Layout works on tablet (2 columns)
- [ ] Layout works on desktop (3 columns)
- [ ] Level card doesn't overflow on small screens
- [ ] Lock badges don't break layout

### Visual Design
- [ ] Consistent with app's color scheme
- [ ] Lock icon clearly visible
- [ ] Progress bars visually clear
- [ ] Difficulty badges use correct colors
- [ ] Hover effects work on accessible cards
- [ ] No hover effects on locked cards
- [ ] Text remains readable on locked cards (even with reduced opacity)

### Database Integration
- [ ] Fetches from user_stats.xp_total correctly
- [ ] Fetches from profiles.xp_points correctly
- [ ] Fetches from profiles.level correctly (for reference)
- [ ] Calculates level from XP accurately
- [ ] Uses existing difficulty_level column from learning_topics

### Browser Compatibility
- [ ] Works in Chrome
- [ ] Works in Firefox
- [ ] Works in Safari
- [ ] Works in Edge

### Accessibility
- [ ] Lock icon has appropriate aria-label (if needed)
- [ ] Keyboard navigation works (Tab through cards)
- [ ] Locked cards are not focusable
- [ ] Accessible cards are focusable
- [ ] Color contrast meets WCAG standards
- [ ] Screen reader announces locked state

## Manual Testing Steps

### Test Scenario 1: New User (Level 1)
1. Create new user or set XP to 0
2. Navigate to Learn Science page
3. Verify Level 1 badge shows
4. Verify Beginner lessons accessible
5. Verify Intermediate/Advanced lessons locked
6. Click on locked lesson → should not navigate
7. Click on beginner lesson → should navigate

### Test Scenario 2: Leveling User (Level 10)
1. Set user XP to 900+ (Level 10)
2. Navigate to Learn Science page
3. Verify Level 10 badge shows
4. Verify Beginner + Intermediate lessons accessible
5. Verify Advanced lessons still locked
6. Try accessing Intermediate lesson → should work

### Test Scenario 3: Advanced User (Level 20)
1. Set user XP to 1900+ (Level 20)
2. Navigate to Learn Science page
3. Verify Level 20 badge shows
4. Verify all lessons accessible
5. No lock icons visible

### Test Scenario 4: Progress Tracking
1. Start a beginner lesson
2. Answer some questions
3. Return to Learn Science page
4. Verify progress displays (completion %, correct answers)
5. Verify "Continue Learning" button appears

## Automated Tests (Future)
- [ ] Unit test for calculateLevel function
- [ ] Unit test for isTopicLocked function
- [ ] Integration test for loadUserProfile
- [ ] Component test for locked card rendering
- [ ] Component test for accessible card rendering
- [ ] E2E test for full user journey

## Sign-Off

- [ ] Developer testing completed
- [ ] QA testing completed
- [ ] Product owner review completed
- [ ] Ready for deployment
