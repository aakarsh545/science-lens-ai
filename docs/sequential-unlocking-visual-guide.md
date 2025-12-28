# Sequential Lesson Unlocking - Visual Guide

## UI Component Showcase

This document provides a comprehensive visual guide to the sequential lesson unlocking system.

---

## 1. Course Page - Lesson List

### Overall Layout

```
┌─────────────────────────────────────────────────────────────┐
│ ← Back to Courses                                           │
├─────────────────────────────────────────────────────────────┤
│ [PHYSICS] Introduction to Physics                           │
│                                                              │
│ Learn the fundamentals of physics...                         │
│                                                              │
│ 📚 10 lessons  🏆 100 XP total  ✓ 3/10 completed (30%)      │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ Lessons                                                      │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ ▼ Introduction          [Badge: 0/3]                        │
├─────────────────────────────────────────────────────────────┤
│   │                                                          │
│   ├─ Lesson Cards (indented, with left border)             │
│   │  ✓ Lesson 1.1  [✓ Completed]                           │
│   │  ✓ Lesson 1.2  [✓ Completed]                           │
│   │  📄 Lesson 1.3  (current - unlocked)                   │
│   │                                                          │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ ▶ Basics              [Badge: 0/4]                         │
├─────────────────────────────────────────────────────────────┤
│   │                                                          │
│   ├─ 🔒 Lesson 2.1  [🔒 Locked]                             │
│   │     Complete "Lesson 1.3" to unlock                     │
│   │                                                          │
│   ├─ 🔒 Lesson 2.2  [🔒 Locked]                             │
│   │     Complete "Lesson 2.1" to unlock                     │
│   │                                                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Lesson Card States

### State A: Completed Lesson

```
┌──────────────────────────────────────────────────────────────┐
│ ✓  What is Physics?         [✓ Completed]                   │
│    ~5 min  +10 XP                                              │
└──────────────────────────────────────────────────────────────┘

Visual Properties:
- Background: bg-success/5 (light green)
- Border: border-success/30 (green border, 30% opacity)
- Icon: CheckCircle2 (green, size 4)
- Badge: Green with checkmark
- Opacity: 100%
- Cursor: pointer
- Hover: shadow-lg
```

### State B: Unlocked Lesson (Current)

```
┌──────────────────────────────────────────────────────────────┐
│ 📄  Motion and Speed                                         │
│    ~5 min  +10 XP                                              │
└──────────────────────────────────────────────────────────────┘

Visual Properties:
- Background: default (transparent/card bg)
- Border: default (card border)
- Icon: FileText (primary color, blue/cyan)
- Badge: None
- Opacity: 100%
- Cursor: pointer
- Hover: shadow-lg, border-primary/50
- Icon Circle: bg-primary/20 (light primary)
```

### State C: Locked Lesson

```
┌──────────────────────────────────────────────────────────────┐
│ 🔒  Forces and Gravity        [🔒 Locked]                     │
│    ~5 min  +10 XP                                              │
│    Complete "Motion and Speed" to unlock                      │
└──────────────────────────────────────────────────────────────┘

Visual Properties:
- Background: bg-muted/30 (gray, 30% opacity)
- Border: default (card border)
- Icon: Lock (muted-foreground, gray)
- Badge: "🔒 Locked" with lock icon
- Opacity: 60%
- Cursor: not-allowed
- Hover: none (disabled)
- Icon Circle: bg-muted (gray)
- Additional Text: "Complete 'X' to unlock"
```

---

## 3. User Interaction Flow

### Scenario: Clicking a Locked Lesson

#### Step 1: User hovers over locked lesson
```
No hover effect (cursor: not-allowed)
Visual feedback: opacity stays at 60%
```

#### Step 2: User clicks locked lesson
```
Action: Click event fires
Result: Toast notification appears

┌─────────────────────────────────────────┐
│ 🔒 Error                                │
│ "Motion and Speed" must be completed    │
│ first to unlock this lesson.            │
│                              [×]        │
└─────────────────────────────────────────┘

Duration: 4000ms (4 seconds)
Auto-dismiss: Yes
Icon: 🔒 (lock icon)
```

#### Step 3: No navigation occurs
```
User stays on course page
No redirect to lesson player
Lesson content not loaded
```

---

## 4. Toast Notification Styles

### Error Toast (Locked Lesson)

```
┌─────────────────────────────────────────────────────────────┐
│ 🔒                                                           │
│ "Motion and Speed" must be completed first to unlock        │
│ this lesson.                                     [Dismiss ×] │
└─────────────────────────────────────────────────────────────┘

Background:destructive (red tint)
Icon: 🔒 (Lock)
Duration: 4000ms
Position: bottom-right (default Sonner position)
Style: Error toast
```

### Success Toast (Lesson Completed)

```
┌─────────────────────────────────────────────────────────────┐
│ 🌟                                                           │
│ Lesson complete! +10 XP earned!                             │
│                                                  [Dismiss ×] │
└─────────────────────────────────────────────────────────────┘

Background: success (green tint)
Icon: 🌟 (Sparkles)
Duration: 4000ms
Position: bottom-right
Style: Success toast
```

### Info Toast (Already Completed)

```
┌─────────────────────────────────────────────────────────────┐
│ ℹ️                                                           │
│ You already completed this lesson!                          │
│                                                  [Dismiss ×] │
└─────────────────────────────────────────────────────────────┘

Background: info (blue tint)
Icon: ℹ️ (Info)
Duration: 4000ms
Position: bottom-right
Style: Info toast
```

---

## 5. Chapter Grouping UI

### Collapsed Chapter

```
┌─────────────────────────────────────────────────────────────┐
│ ▶ Basics                  [Badge: 0/4]                      │
└─────────────────────────────────────────────────────────────┘

Visual:
- Chevron pointing right (▶)
- Chapter name
- Progress badge (completed/total)
- Folder icon
- Hover: bg-muted/50
- Click: expands chapter
```

### Expanded Chapter

```
┌─────────────────────────────────────────────────────────────┐
│ ▼ Basics                  [Badge: 2/4]                      │
├─────────────────────────────────────────────────────────────┤
│ │                                                            │
│ ├─ ✓ Lesson 2.1: Newton's First Law        [✓ Completed]  │
│ │    ~5 min  +10 XP                                        │
│ │                                                            │
│ ├─ ✓ Lesson 2.2: Newton's Second Law       [✓ Completed]  │
│ │    ~5 min  +10 XP                                        │
│ │                                                            │
│ ├─ 📄 Lesson 2.3: Newton's Third Law                       │
│ │    ~5 min  +10 XP                                        │
│ │                                                            │
│ ├─ 🔒 Lesson 2.4: Applications of Newton's Laws [🔒 Locked] │
│ │    ~5 min  +10 XP                                        │
│ │    Complete "Lesson 2.3" to unlock                       │
│ │                                                            │
└─────────────────────────────────────────────────────────────┘

Visual:
- Chevron pointing down (▼)
- Chapter name
- Progress badge (2/4 completed)
- Left border line connecting lessons
- Lessons indented with left padding
```

---

## 6. Progress Indicators

### Course Header Progress

```
┌─────────────────────────────────────────────────────────────┐
│ Introduction to Physics                                     │
│                                                              │
│ 📚 10 lessons  🏆 100 XP total  ✓ 3/10 completed (30%)      │
│                                                              │
│ Progress Bar:                                                │
│ ████████░░░░░░░░░░░░░░░░░░░░                                │
│ 30% complete                                                 │
└─────────────────────────────────────────────────────────────┘

Elements:
- 📚 Book icon + lesson count
- 🏆 Trophy icon + total XP
- ✓ Check icon + completed/total + percentage
- Progress bar (visual)
```

### Chapter Progress Badge

```
States:
- [0/4] - No lessons completed (gray)
- [2/4] - Partial progress (blue)
- [4/4] - All completed (green)

Visual:
variant="outline"
Small size
Shows "completed/total"
```

---

## 7. Direct URL Access Prevention

### Scenario: User navigates to locked lesson URL

```
URL: /science-lens/learning/physics/forces

Step 1: LessonPlayer component mounts
Step 2: loadLesson() function called
Step 3: System checks if previous lesson completed
Step 4: Previous lesson NOT completed
Step 5: Toast error shown
Step 6: Redirect to course page
Step 7: URL changes to: /science-lens/learning/physics

Toast shown:
┌─────────────────────────────────────────────────────────────┐
│ 🔒                                                           │
│ Lesson Locked! Please complete "Motion and Speed" first     │
│ to unlock this lesson.                                      │
│                                                  [Dismiss ×] │
└─────────────────────────────────────────────────────────────┘

Duration: 5000ms (5 seconds)
Longer duration to ensure user sees the message
```

---

## 8. Responsive Design

### Desktop (> 768px)

```
Full-width cards
Chapter grouping expanded
All badges visible
Progress bar visible
Hover effects enabled
```

### Tablet (768px - 1024px)

```
Full-width cards
Chapter grouping may collapse vertically
All badges visible
Progress bar visible
Hover effects enabled
```

### Mobile (< 768px)

```
Full-width cards
Chapter grouping vertical
Smaller badges
Progress bar visible
Touch-optimized (larger tap targets)
No hover (touch-only)
```

---

## 9. Icon Reference

| Icon | Usage | Color | Meaning |
|------|-------|-------|---------|
| ✓ CheckCircle2 | Completed lesson | Green (text-success) | Lesson finished |
| 📄 FileText | Unlocked lesson | Blue/Cyan (text-primary) | Available to start |
| 🔒 Lock | Locked lesson | Gray (text-muted-foreground) | Not yet available |
| ▼ ChevronDown | Expanded chapter | Gray | Chapter is open |
| ▶ ChevronRight | Collapsed chapter | Gray | Chapter is closed |
| 📚 BookOpen | Course/lessons | Primary | Course content |
| 🏆 Award | XP reward | Achievement | Points to earn |
| ⏰ Clock | Duration | Muted | Time estimate |

---

## 10. Color Palette

### Status Colors

```
Completed (Success):
- Background: bg-success/5 (5% opacity)
- Border: border-success/30 (30% opacity)
- Text: text-success
- Icon: text-success
- Badge: bg-success/5 border-success text-success

Unlocked (Primary):
- Background: transparent (default)
- Border: default card border
- Text: default
- Icon: text-primary
- Icon Circle: bg-primary/20 text-primary
- Hover: border-primary/50

Locked (Muted):
- Background: bg-muted/30 (30% opacity)
- Border: default card border
- Text: text-muted-foreground
- Icon: text-muted-foreground
- Icon Circle: bg-muted text-muted-foreground
- Badge: bg-muted/50
- Opacity: 60%
```

---

## 11. Accessibility Features

### Screen Reader Announcements

```
Unlocked lesson:
"Motion and Speed, lesson, 5 minutes, 10 XP points, click to start"

Locked lesson:
"Forces and Gravity, lesson, locked, complete Motion and Speed to unlock"

Completed lesson:
"What is Physics, lesson, completed, 5 minutes, 10 XP points"
```

### Keyboard Navigation

```
Tab - Navigate between lessons
Enter/Space - Click selected lesson
Escape - Close toast notifications
Arrow keys - Navigate within chapter groups
```

### Focus Indicators

```
All interactive elements show visible focus ring:
- outline: 2px solid primary color
- outline-offset: 2px
- High contrast for visibility
```

---

## 12. Animation Timings

```css
/* Transitions */
transition-all: 200ms ease-in-out

/* Hover effects */
hover:shadow-lg: 150ms ease-in-out

/* Toast notifications */
enter: 300ms ease-out
exit: 250ms ease-in
duration: 4000ms

/* Page transitions */
navigate: instant (React Router)
```

---

## Conclusion

This visual guide demonstrates the complete UI/UX for the sequential lesson unlocking system. The design prioritizes clarity, accessibility, and user feedback at every interaction point.

All visual states are clearly distinguishable through color, iconography, and text, ensuring users understand their progress and what actions are available to them.
