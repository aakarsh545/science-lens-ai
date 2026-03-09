# Authentication Fix for Courses/Lessons Endpoints

## Issue Summary
**Severity:** Info
**Issue:** Courses and lessons endpoints were accessible without authentication

## Problem Identified
The Edge Functions for courses and lessons were using `SUPABASE_SERVICE_ROLE_KEY` which bypasses RLS policies. This meant:
- Unauthenticated users could access all course/lesson data
- The RLS policies requiring `authenticated` role were being bypassed
- Anyone with the function URL could retrieve educational content without signing in

## Changes Made

### 1. Courses Edge Function (`/supabase/functions/courses/index.ts`)
**Added:**
- Authentication check at function entry point
- Authorization header validation
- JWT token verification with Supabase auth
- Returns 401 for missing/invalid auth tokens

**Before:**
```typescript
serve(async (req) => {
  // No authentication check
  const supabase = createClient(supabaseUrl, supabaseKey);
  // Directly queries database
  const { data: courses } = await supabase.from('courses').select('*');
```

**After:**
```typescript
serve(async (req) => {
  const authHeader = req.headers.get('Authorization');
  if (!authHeader) {
    return new Response(JSON.stringify({ error: 'Authentication required' }), {
      status: 401,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  const token = authHeader.replace('Bearer ', '');
  const { data: { user }, error: userError } = await supabase.auth.getUser(token);

  if (userError || !user) {
    return new Response(JSON.stringify({ error: 'Invalid authentication token' }), {
      status: 401,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
  // Now safe to query database
```

### 2. Lessons Edge Function (`/supabase/functions/lessons/index.ts`)
**Added:**
- Same authentication pattern as courses function
- Moved auth verification to function entry (was only in 'complete' action)
- All lesson endpoints now require authentication (GET, POST)

**Before:**
- Only `action === 'complete'` required authentication
- Regular lesson details (GET) were public
- Lesson retrieval via POST was public

**After:**
- All requests require authentication
- Consolidated auth check at entry point
- No public access to lesson data

### 3. Test Script (`test-auth.sh`)
**Created:** Test script to verify authentication enforcement

**Usage:**
```bash
./test-auth.sh https://your-project.supabase.co
```

**Tests:**
1. GET courses without auth → 401
2. POST lessons without auth → 401
3. GET courses with invalid token → 401
4. POST lessons with invalid token → 401

## Security Impact

### Before Fix
- ❌ Public access to course catalog
- ❌ Public access to lesson content
- ❌ Bypass of RLS policies
- ❌ No user tracking for content consumption

### After Fix
- ✅ All course/lesson data requires authentication
- ✅ Proper user context for all requests
- ✅ Aligns Edge Functions with RLS policies
- ✅ Enables tracking of user learning progress
- ✅ Prevents unauthorized content scraping

## Balancing Public vs Protected Content

### Current Approach (Authentication Required)
All educational content now requires authentication. This provides:
- User progress tracking
- Personalized recommendations
- Credit system integration
- Achievement tracking

### Alternative Approach (If Public Catalog Needed)
If you want to make course catalog public (for marketing/discovery):

**Option 1: Separate Functions**
- Create `courses-public` function (no auth required)
- Keep `courses` function for enrolled students (auth required)
- Public function returns limited data (title, description, preview)
- Authenticated function returns full content

**Option 2: Query Parameter Filter**
- Add `?public=true` parameter to bypass auth check
- Return limited dataset for public requests
- Return full data for authenticated requests

**Option 3: RLS Policy with Public Role**
- Create `anon` role in RLS policies
- Allow `anon` to read limited course fields
- Require `authenticated` for full lesson content

## Deployment Steps

1. **Deploy Edge Functions:**
   ```bash
   npx supabase functions deploy courses
   npx supabase functions deploy lessons
   ```

2. **Test Authentication:**
   ```bash
   ./test-auth.sh https://your-project.supabase.co
   ```

3. **Update Frontend:**
   - Ensure all API calls include Authorization header
   - Handle 401 responses gracefully (redirect to login)
   - Update error handling for auth failures

## Testing Checklist

- [ ] Unauthenticated request returns 401
- [ ] Invalid token returns 401
- [ ] Valid token allows access
- [ ] Frontend includes auth headers
- [ ] Frontend handles 401 responses
- [ ] User progress tracking still works
- [ ] Lesson completion still works

## Migration Guide

### For Frontend Developers

**Before:**
```typescript
// This now fails with 401
const { data } = await supabase.functions.invoke('courses', {
  body: { slug: 'physics-101' }
});
```

**After:**
```typescript
// Supabase client automatically includes auth
const { data, error } = await supabase.functions.invoke('courses', {
  body: { slug: 'physics-101' }
});

// Or manual auth header (if not using supabase client)
const response = await fetch(`${SUPABASE_URL}/functions/v1/courses`, {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ slug: 'physics-101' })
});
```

## Related Files

- `/supabase/functions/courses/index.ts` - Courses Edge Function
- `/supabase/functions/lessons/index.ts` - Lessons Edge Function
- `/test-auth.sh` - Authentication test script
- `/supabase/migrations/20251228200000_fix_critical_security.sql` - RLS policies
- `/supabase/functions/_shared/security.ts` - Security utilities

## Commit Details

**Commit:** `145c8969f738b0cc9684f98891c3876e5ad327b0`
**Message:** "fix: require authentication for courses/lessons endpoints"
**Files Changed:** 3 files, 104 insertions(+), 15 deletions(-)
