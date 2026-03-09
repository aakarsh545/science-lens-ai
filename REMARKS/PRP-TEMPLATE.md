# PRP-XXX: [FEATURE NAME]

**Status**: DRAFT | IN PROGRESS | REVIEW | COMPLETE
**Author**: [Author Name]
**Date**: YYYY-MM-DD
**Priority**: LOW | MEDIUM | HIGH | CRITICAL
**Estimated Effort**: [X] phases, ~[Y] tasks

---

## Executive Summary

[2-3 sentence summary of what this PRP delivers and why it matters. Should answer:
- What are we building?
- Why are we building it?
- What's the core value proposition?

Example:
"This PRP adds [feature] to [product], enabling users to [benefit]. Currently, [current limitation]. The new system will [solution approach], delivering [key benefit]."

---

## Problem Statement

### Current State

[Describe the current situation. What's broken, missing, or suboptimal?]

Key points:
1. **[Issue 1]**: [Description]
2. **[Issue 2]**: [Description]
3. **[Issue 3]**: [Description]

### Impact

| Issue | User Impact | Business Impact |
|-------|-------------|-----------------|
| [Issue 1] | [How users are affected] | [Revenue/CX impact] |
| [Issue 2] | [How users are affected] | [Revenue/CX impact] |
| [Issue 3] | [How users are affected] | [Revenue/CX impact] |

### Success Criteria

- [ ] [Criterion 1 - specific, measurable, achievable]
- [ ] [Criterion 2 - specific, measurable, achievable]
- [ ] [Criterion 3 - specific, measurable, achievable]
- [ ] [Criterion 4 - specific, measurable, achievable]
- [ ] [Criterion 5 - specific, measurable, achievable]

---

## Proposed Solution

### Overview

[High-level description of the solution approach. What are we building and how will it solve the problems?]

Include:
- Architecture diagram (if applicable)
- Key technical decisions
- Design principles

Example diagram format:
```
┌─────────────────────────────────────────────────────────────────────────────┐
│  SYSTEM OVERVIEW                                                            │
│                                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                  │
│  │ Component A  │    │ Component B  │    │ Component C  │                  │
│  │              │ +  │              │ +  │              │                  │
│  │              │    │              │    │              │                  │
│  └──────┬───────┘    └──────┬───────┘    └──────┬───────┘                  │
│         │                   │                   │                           │
│         └───────────────────┼───────────────────┘                           │
│                             ▼                                               │
│                   ┌──────────────────┐                                      │
│                   │ Core System      │                                      │
│                   │                  │                                      │
│                   └────────┬─────────┘                                      │
│                            ▼                                                │
│                   ┌──────────────────┐                                      │
│                   │ Final Output     │                                      │
│                   └──────────────────┘                                      │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Architecture / Design

[Detailed technical design. Break down into subsections as needed.]

#### 1. [Subsystem 1]

[Description, code examples, data structures]

```typescript
// Example: Type definitions
interface ExampleInterface {
  property: string;
  method(): void;
}

// Example: Implementation
export function exampleFunction() {
  // Implementation details
}
```

#### 2. [Subsystem 2]

[Description, code examples, data structures]

#### 3. [Subsystem 3]

[Description, code examples, data structures]

### Files to Modify

| File | Action | Description |
|------|--------|-------------|
| `path/to/file1.ts` | CREATE | New file for [purpose] |
| `path/to/file2.ts` | MODIFY | Update to [change description] |
| `path/to/file3.ts` | DELETE | Remove obsolete [component] |
| `path/to/file4.tsx` | REFACTOR | Restructure for [reason] |

---

## Documentation Requirements

### Documentation Checklist
- [ ] **D.1** [Specific documentation task]
- [ ] **D.2** [Specific documentation task]
- [ ] **D.3** [Specific documentation task]
- [ ] **D.4** [Specific documentation task]

### README / Docs Updates

| File | Action | Scope |
|------|--------|-------|
| `README.md` | [UPDATE/CREATE] | [What to document] |
| `docs/GUIDE.md` | [UPDATE/CREATE] | [What to document] |

---

## Pre-Flight Checks

> **MANDATORY**: These checks MUST pass before starting implementation.

- [ ] [Package manager] install succeeds
- [ ] [Package manager] build succeeds (baseline)
- [ ] [Package manager] [dev/test command] runs without errors
- [ ] [Any other environment checks]
- [ ] No TypeScript errors in codebase (if applicable)

---

## Implementation Tasks

### Phase 1: [Phase Name]

**Objective**: [What this phase achieves]

#### Tasks
- [ ] **1.1** [Task description]
- [ ] **1.2** [Task description]
- [ ] **1.3** [Task description]
- [ ] **1.4** [Task description]
- [ ] **1.5** [Task description]

#### Build Gate
```bash
[Command to verify phase completion]
[Command to run tests]
[Command to check changes]
```

#### Phase Completion
```
<promise>PRP-XXX PHASE 1 COMPLETE</promise>
```

---

### Phase 2: [Phase Name]

**Objective**: [What this phase achieves]

#### Tasks
- [ ] **2.1** [Task description]
- [ ] **2.2** [Task description]
- [ ] **2.3** [Task description]
- [ ] **2.4** [Task description]
- [ ] **2.5** [Task description]

#### Build Gate
```bash
[Command to verify phase completion]
[Command to run tests]
[Command to check changes]
```

#### Phase Completion
```
<promise>PRP-XXX PHASE 2 COMPLETE</promise>
```

---

### Phase 3: [Phase Name]

**Objective**: [What this phase achieves]

#### Tasks
- [ ] **3.1** [Task description]
- [ ] **3.2** [Task description]
- [ ] **3.3** [Task description]
- [ ] **3.4** [Task description]
- [ ] **3.5** [Task description]

#### Build Gate
```bash
[Command to verify phase completion]
[Command to run tests]
[Command to check changes]
```

#### Phase Completion
```
<promise>PRP-XXX PHASE 3 COMPLETE</promise>
```

---

### [Additional Phases as Needed]

[Copy Phase structure for as many phases as needed]

---

### Phase N: [Final Phase - e.g., Integration Testing]

**Objective**: [What this phase achieves]

#### Section A: [Testing Category 1]

- [ ] **N.A.1** [Test case description]
- [ ] **N.A.2** [Test case description]
- [ ] **N.A.3** [Test case description]

#### Section B: [Testing Category 2]

- [ ] **N.B.1** [Test case description]
- [ ] **N.B.2** [Test case description]
- [ ] **N.B.3** [Test case description]

#### Section C: [Testing Category 3]

- [ ] **N.C.1** [Test case description]
- [ ] **N.C.2** [Test case description]
- [ ] **N.C.3** [Test case description]

#### Build Gate
```bash
[All tests above must pass]
[No unhandled errors]
[Additional verification commands]
```

#### Phase Completion
```
<promise>PRP-XXX PHASE N COMPLETE</promise>
```

---

## Final Verification

- [ ] All phase promises output (Phases 1-N)
- [ ] `[build command]` passes
- [ ] `[test command]` passes
- [ ] Integration testing completed
- [ ] [Any specific verification steps]
- [ ] No TypeScript errors: `[typecheck command]` or `[build command]`
- [ ] No console errors in [environment]
- [ ] Code follows project patterns
- [ ] [Any project-specific verification]
- [ ] Changes committed with descriptive message

---

## Final Completion

When ALL of the above are complete:
```
<promise>PRP-XXX COMPLETE</promise>
```

---

## Rollback Plan

```bash
# If issues discovered after deployment:

# Option 1: Revert changes
git revert HEAD~N  # revert commits from this PRP

# Option 2: Feature flag disable
# [If feature flags are available]

# Option 3: Data migration
# [If user data needs migration/rollback]

# Option 4: Configuration fallback
# [If config changes need rollback]
```

---

## Open Questions & Decisions

### Q1: [Question title]

**Options:**
- A) [Option A description]
- B) [Option B description]
- C) [Option C description]

**Recommendation:** [Chosen option with rationale]

### Q2: [Question title]

**Options:**
- A) [Option A description]
- B) [Option B description]
- C) [Option C description]

**Recommendation:** [Chosen option with rationale]

### Q3: [Question title]

**Options:**
- A) [Option A description]
- B) [Option B description]
- C) [Option C description]

**Recommendation:** [Chosen option with rationale]

---

## Appendix A: [Reference Material]

[Include any reference data, sample outputs, lookup tables, etc.]

### Example Table

| Category | Item A | Item B | Item C |
|----------|--------|--------|--------|
| Type 1   | Value  | Value  | Value  |
| Type 2   | Value  | Value  | Value  |
| Type 3   | Value  | Value  | Value  |

---

## Appendix B: [Additional Reference]

[More reference material as needed]

---

## Appendix C: [More References]

[Additional appendices as needed]

---

## References

- [Reference 1]: [Link/Description]
- [Reference 2]: [Link/Description]
- [Reference 3]: [Link/Description]

---

## Changelog

| Date | Author | Changes |
|------|--------|---------|
| YYYY-MM-DD | [Author] | Initial draft |
| YYYY-MM-DD | [Author] | [Update description] |

---

<!--
WIGGUM EXECUTION COMMAND:
/ralph-loop "Execute PRP-XXX per [path-to-this-file]. Work through all unchecked tasks sequentially including pre-flight checks and integration testing. Mark each [x] when done. Run build gates after each phase. [Add any specific tool instructions if needed, e.g., 'use mcp__claude-in-chrome__* tools for browser tests']. Output phase promises after each phase. Output <promise>PRP-XXX COMPLETE</promise> when all tasks are done. Do NOT ask for confirmation between tasks." --completion-promise "PRP-XXX COMPLETE" --max-iterations [N]
-->
