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
  - `/science-lens/learn-science` - Browse learning topics
  - `/science-lens/ask` - Ask AI questions
  - `/science-lens/pricing` - Credit packages

## Development Commands
```bash
npm run dev      # Start dev server
npm run build    # Production build
npm run lint     # Run ESLint
```

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
