# Proposals Directory

This directory contains **PRP** (Project Requirement Plan) documents for major features and improvements.

## What is a PRP?

A PRP is a comprehensive planning document that:
- Defines the problem and success criteria
- Outlines the technical solution and architecture
- Breaks down implementation into phases with detailed tasks
- Includes verification steps and rollback plans
- Serves as a contract between planning and execution

## When to Create a PRP

Create a PRP for:
- **Major features** that affect multiple components
- **Architecture changes** that impact the system design
- **Multi-phase work** that requires careful coordination
- **Risky changes** that need rollback planning

**Skip PRPs for:**
- Simple bug fixes
- Single-file changes
- Trivial features
- Documentation updates

## Using the PRP Template

1. **Copy the template:**
   ```bash
   cp proposals/PRP-TEMPLATE.md proposals/PRP-XXX-feature-name.md
   ```

2. **Fill in the header:**
   - Replace `PRP-XXX` with next sequential number (check existing PRPs)
   - Replace `[FEATURE NAME]` with brief descriptive title
   - Set status to `DRAFT`
   - Fill in author, date, priority, estimated effort

3. **Complete each section:**
   - **Executive Summary**: 2-3 sentences, answer "what, why, value"
   - **Problem Statement**: Current state, impact table, success criteria
   - **Proposed Solution**: Overview, architecture, file changes
   - **Documentation**: What docs need updating
   - **Pre-Flight Checks**: Environment validation
   - **Implementation Tasks**: Break into 3-8 phases with 5-15 tasks each
   - **Final Verification**: Completion checklist
   - **Rollback Plan**: How to undo changes if needed
   - **Open Questions**: Decisions to be made

4. **Review and approve** before starting implementation

## PRP Numbering

- Use sequential numbers: PRP-001, PRP-002, PRP-003, etc.
- Check existing PRPs to determine next number
- Use descriptive filenames: `PRP-003-internationalized-lessons.md`

## PRP Status Values

| Status | Meaning |
|--------|---------|
| DRAFT | Initial writing, not yet reviewed |
| IN PROGRESS | Approved, implementation started |
| REVIEW | Implementation done, pending review |
| COMPLETE | Done, deployed, verified |

## Execution

When approved, use the Wiggum execution command at the bottom of the PRP:

```bash
/ralph-loop "Execute PRP-XXX per proposals/PRP-XXX-feature-name.md..."
```

This will:
- Work through all tasks sequentially
- Mark checkboxes as complete
- Run build gates after each phase
- Output phase completion promises
- Not ask for confirmation between tasks

## Example PRPs

See [PRP-TEMPLATE.md](./PRP-TEMPLATE.md) for a fully annotated example based on a real project (Type Quest internationalized lesson system).

## Quick Reference

### Phase Structure
Each phase should:
- Have a clear objective (1 sentence)
- Contain 5-15 specific, actionable tasks
- Include a build gate with verification commands
- End with a promise output

### Task Format
- Use `- [ ] **X.Y** [Description]` format
- Number by phase.task (e.g., 1.1, 1.2, 2.1, 2.2)
- Make tasks specific and testable
- Group related tasks together

### Build Gates
```bash
# Example build gate:
pnpm build
pnpm test
git diff --stat
```

Customize for your project's package manager and commands.

## Tips for Good PRPs

1. **Be specific**: "Add user auth" → "Add JWT auth with /login endpoint"
2. **Think in phases**: Group tasks by logical dependencies
3. **Define success**: Make criteria measurable and testable
4. **Plan for failure**: Include rollback and error handling
5. **Document as you go**: Update docs in the same PRP
6. **Keep tasks small**: Each task should be < 2 hours of work
