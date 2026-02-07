

## Problem

The app shows a blank dark screen because the `.env` file is missing from the project. This file provides the critical environment variables (`VITE_SUPABASE_URL`, `VITE_SUPABASE_PUBLISHABLE_KEY`) that the Supabase client needs to initialize. Without them, the app crashes immediately with "supabaseUrl is required."

The `.env` file is auto-managed by Lovable Cloud, but previous edits accidentally created/deleted it, leaving it in a broken state.

## Fix

Recreate the `.env` file with the correct Lovable Cloud credentials:

```
VITE_SUPABASE_PROJECT_ID="pfrmkmlstzjexccmdkoc"
VITE_SUPABASE_PUBLISHABLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBmcm1rbWxzdHpqZXhjY21ka29jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNzE2MzksImV4cCI6MjA3NDc0NzYzOX0.b0mjj8CS604Y38Pf1iQefrBz59pV0yEl3sCewGe4DmA"
VITE_SUPABASE_URL="https://pfrmkmlstzjexccmdkoc.supabase.co"
```

This is a single-file fix that will restore the app immediately.

## Technical Details

- **File**: `.env` (recreate)
- **Root cause**: The file was lost during previous edit cycles that kept recreating it
- **No other code changes needed** -- the client code in `src/integrations/supabase/client.ts` is correct and reads these variables properly
