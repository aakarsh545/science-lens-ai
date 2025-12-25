# Science Lens - AI-Powered Science Learning Platform

## Project Overview
Science Lens is a React + TypeScript web application for AI-powered science education. It uses Supabase for authentication, database, and edge functions, with OpenAI for AI-powered features.

## Tech Stack
- **Frontend**: React 18, TypeScript, Vite
- **UI**: Tailwind CSS, shadcn/ui components
- **Backend**: Supabase (Auth, Database, Edge Functions)
- **AI**: OpenAI API via Supabase Edge Functions
- **Routing**: React Router v6

## Project Structure
```
/src
  /components    - Reusable UI components
  /pages         - Page components
  /layouts       - Layout components (AppLayout)
  /hooks         - Custom React hooks
  /integrations  - Supabase client config
/supabase
  /functions     - Edge functions (ai-hint, ask, challenges, courses, lessons)
  /migrations    - Database migrations
```

## Key Routes
- `/` - Landing page (public)
- `/science-lens/*` - Authenticated app routes
  - `/science-lens` - Home (Main dashboard)
  - `/science-lens/learning` - Unified learning page (topics + courses)
  - `/science-lens/ask` - Ask AI questions
  - `/science-lens/pricing` - Credit packages

## Development Commands
```bash
npm run dev      # Start dev server
npm run build    # Production build
npm run lint     # Run ESLint
```

## Supabase CLI Commands

**Always use Supabase CLI for database operations.** The project is linked to remote Supabase.

```bash
# Push migrations to remote database
npx supabase db push

# Deploy edge functions
npx supabase functions deploy <function-name>

# Deploy all edge functions
npx supabase functions deploy
```

### Setup (if not authenticated)
1. Get access token from: Supabase Dashboard → Account → Access Tokens
2. Add to `.env`: `SUPABASE_ACCESS_TOKEN=your_token_here`
3. Or run: `npx supabase login --token your_token_here`

---

## MANDATORY: Project Proposal (PRP) Template

**CRITICAL:** For ANY substantial feature, improvement, or multi-step task, you MUST create a Project Proposal (PRP) using the template before starting implementation.

### When to Use PRP
**MANDATORY for:**
- New features (any feature affecting user experience or core functionality)
- Major refactoring or architectural changes
- Database schema changes
- Multi-file changes (3+ files)
- Tasks requiring 2+ hours of work
- Bug fixes that require significant code changes

**NOT required for:**
- Simple typo fixes
- Minor styling tweaks (single component)
- Simple bug fixes (single function, <10 lines)
- Documentation updates

### PRP Template Location
```
/proposals/PRP-TEMPLATE.md
```

**ALL PRPs must be saved in:** `/docs/PRP-XXX.md`

### PRP Numbering
PRPs must use **sequential numbering**:
- First PRP: `/docs/PRP-001-name.md`
- Second PRP: `/docs/PRP-002-name.md`
- Third PRP: `/docs/PRP-003-name.md`
- And so on...

Check existing PRPs in `/docs/` to determine the next number.

### PRP Workflow
1. **Determine Next Number**: Check `/docs/` for existing PRPs, use next sequential number
2. **Create PRP**: Copy template to `/docs/PRP-XXX-name.md` (XXX = sequential number, name = kebab-case feature name)
3. **Fill Out**: Complete ALL sections of the template
   - Executive Summary (what & why)
   - Problem Statement (current issues + impact)
   - Success Criteria (measurable outcomes)
   - Proposed Solution (architecture + design)
   - Documentation Requirements
   - Pre-Flight Checks (MANDATORY - must pass before starting)
   - Implementation Tasks (broken into phases)
   - Final Verification checklist
4. **Review**: Get user approval if needed
5. **Execute**: Work through ALL tasks sequentially
6. **Build Gates**: Run build commands after EACH phase
7. **Complete**: Output `<promise>PRP-XXX COMPLETE</promise>` when done

### PRP Template Key Sections
- **Pre-Flight Checks**: MANDATORY environment/validation checks before implementation
- **Phased Approach**: Break work into logical phases (Phase 1, Phase 2, etc.)
- **Build Gates**: Commands to verify each phase (build, test, typecheck)
- **Completion Promises**: Output after each phase to track progress
- **Rollback Plan**: How to revert if issues arise
- **Success Criteria**: Measurable outcomes to validate completion

### Example PRP Usage
```bash
# User: "Add user achievement system"
# Claude: "I'll create a PRP for this feature."

# Step 1: Check /docs/ for existing PRPs (none yet, so start with 001)
# Step 2: Create /docs/PRP-001-user-achievements.md
# Step 3: Fill out all sections of the template
# Step 4: Work through all phases
# Step 5: Output completion promises after each phase
# Step 6: Commit after each phase

# Next feature would be: /docs/PRP-002-name.md
```

**NEVER start substantial work without a PRP. This ensures:**
- ✅ Clear requirements and success criteria
- ✅ Proper planning and architecture
- ✅ Phased, testable implementation
- ✅ Documentation is considered
- ✅ Rollback plan exists
- ✅ No scope creep

---

## IMPORTANT: Commit Policy

**After completing each improvement, feature, or bug fix, you MUST create a git commit.**

Follow this workflow:
1. Make the code changes
2. Test the changes work correctly
3. Stage and commit with a descriptive message
4. Then move on to the next task

Commit message format:
```
<type>: <short description>

<optional longer description>
```

Types: `feat`, `fix`, `refactor`, `style`, `docs`, `test`, `chore`

Example:
```
feat: add dark mode toggle to settings

- Added theme context provider
- Updated all components to use theme variables
- Persists preference to localStorage
```

**Do not batch multiple unrelated changes into a single commit. Each logical change gets its own commit.**
