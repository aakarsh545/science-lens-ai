# Level Restrictions - Visual Guide

## User Level Display

```
┌─────────────────────────────────────────────────────────────────┐
│  ┌────┐  Level 5                  ★ 95 XP to next level        │
│  │ L5 │  543 XP Total                                             │
│  └────┘                                                             │
│  ████████████░░░░░░░░░░░░░░░░░░░░ 43%                            │
└─────────────────────────────────────────────────────────────────┘
```

## Lesson Card States

### Accessible Lesson (User Level >= Requirement)

```
┌────────────────────────────────────────────┐
│ ⚛️  Basic Physics          [Beginner]     │
│                                            │
│ Fundamental concepts of motion, forces,    │
│ and energy                                 │
│                                            │
│ Progress: 45%                              │
│ ████████████████░░░░░░░░░░░░░░            │
│                                            │
│ 🏆 12 correct  ✨ 28 answered              │
│                                            │
│ [ Continue Learning ]                      │
└────────────────────────────────────────────┘
```

### Locked Lesson (User Level < Requirement)

```
┌────────────────────────────────────────────┐
│ 🔬  Quantum Mechanics    [🔒 Level 10]  [Advanced] │
│                                            │
│ Explore the quantum world and particle     │
│ behavior                                   │
│                                            │
│ 🔒 Requires Level 10                       │
│ You need to reach Level 10 to unlock this  │
│ advanced lesson. Current level: 5          │
│                                            │
│ ████████░░░░░░░░░░░░░░░░░░ 50%            │
│ 5 more levels to unlock                    │
└────────────────────────────────────────────┘
```

## Level Requirements

```
Level 1-9    →  Beginner lessons only  (10 lessons)
Level 10-19   →  + Intermediate lessons (4 lessons)
Level 20+     →  + Advanced lessons     (2 lessons)
```

## XP Requirements

```
Beginner      →  0 XP (Level 1)
Intermediate  →  900 XP (Level 10)
Advanced      →  1,900 XP (Level 20)
```

## Visual Hierarchy

1. **User Level Card** (Top, prominent)
   - Large circular badge
   - Current level & XP
   - Progress to next level

2. **Topic Cards** (Grid layout)
   - Accessible: Full color, clickable
   - Locked: Grayed out, non-clickable
   - Lock icon + requirement badge
   - Progress indicator toward unlock

3. **Difficulty Badges**
   - Beginner: Default (blue)
   - Intermediate: Secondary (gray)
   - Advanced: Destructive (red)
   - Lock badge: Outline with lock icon

## User Journey

```
Level 1 (0 XP)
    ↓
[Complete Beginner Lessons]
    ↓
Level 5 (400 XP) - Still locked for Intermediate
    ↓
[Keep learning...]
    ↓
Level 10 (900 XP) - UNLOCKS Intermediate!
    ↓
[Complete Intermediate Lessons]
    ↓
Level 15 (1400 XP) - Still locked for Advanced
    ↓
[Keep learning...]
    ↓
Level 20 (1900 XP) - UNLOCKS Advanced!
    ↓
[Master All Topics]
```

## Color Scheme

- **Locked Card**: `opacity-60 bg-muted/30`
- **Lock Badge**: `variant="outline"` with amber text
- **Level Progress**: Gradient from primary to purple
- **Difficulty Badges**: Default (blue), Secondary (gray), Destructive (red)
- **Progress Bars**: Primary color for level, lesson progress

## Responsive Design

```
Mobile (1 column):
┌─────────────────┐
│  Topic Card 1   │
├─────────────────┤
│  Topic Card 2   │
├─────────────────┤
│  Topic Card 3   │
└─────────────────┘

Tablet (2 columns):
┌─────────────┬─────────────┐
│  Topic 1    │  Topic 2    │
├─────────────┼─────────────┤
│  Topic 3    │  Topic 4    │
└─────────────┴─────────────┘

Desktop (3 columns):
┌──────────┬──────────┬──────────┐
│  Topic 1 │  Topic 2 │  Topic 3 │
├──────────┼──────────┼──────────┤
│  Topic 4 │  Topic 5 │  Topic 6 │
└──────────┴──────────┴──────────┘
```
