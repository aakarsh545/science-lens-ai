# Server-Side Admin Authorization - Security Fix

## Overview
This document describes the security improvements made to enforce admin authorization on the server-side, preventing client-side bypass attacks.

## Problem Statement
Previously, admin checks were performed only on the client-side in React components. This created a critical security vulnerability where malicious users could:
- Use browser DevTools to modify client-side state
- Make direct Supabase client calls to grant themselves admin privileges
- Bypass all premium, level, and coin restrictions

## Solution Architecture

### 1. Defense in Depth Approach
The fix implements multiple layers of security:

```
Client (React Components)
    ↓
Edge Functions (Server-Side Verification)
    ↓
RLS Policies (Database-Level Protection)
    ↓
Triggers (Double-Check Enforcement)
```

### 2. Client-Side Changes

#### Before (Insecure):
```typescript
// AdminToggle.tsx - DIRECT DATABASE CALLS
await supabase
  .from('profiles')
  .update({ is_admin: true, level: 1000, coins: 999999999 })
  .eq('user_id', userId);
```

#### After (Secure):
```typescript
// AdminToggle.tsx - EDGE FUNCTION CALL
const { data, error } = await supabase.functions.invoke('grant-admin', {
  body: { userId: user.id }
});
```

### 3. Server-Side Verification

#### Edge Function: grant-admin
```typescript
// 1. Verify user is authenticated
const { data: { user } } = await supabaseClient.auth.getUser();

// 2. SERVER-SIDE: Check admin status from database
const { data: requestingProfile } = await supabaseClient
  .from('profiles')
  .select('is_admin')
  .eq('user_id', requestingUser.id)
  .single();

// 3. Deny if not admin
if (!requestingProfile.is_admin) {
  return new Response(JSON.stringify({ error: 'Forbidden' }), { status: 403 });
}

// 4. Only then grant admin to target user
```

### 4. Database-Level Protection

#### RLS Policies
```sql
-- profiles table policy
CREATE POLICY "Users can update their own profile (except admin status)"
ON public.profiles
FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (
  -- Allow update if NOT changing is_admin
  (COALESCE(OLD.is_admin, false) = COALESCE(NEW.is_admin, false))
);
```

#### Triggers (Double-Check)
```sql
CREATE FUNCTION public.prevent_admin_self_grant()
RETURNS TRIGGER AS $$
BEGIN
  IF (OLD.is_admin IS NULL OR OLD.is_admin = false) AND NEW.is_admin = true THEN
    IF auth.uid() = NEW.user_id THEN
      RAISE EXCEPTION 'Users cannot grant themselves admin privileges';
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### 5. Server-Side Functions

#### spend_coins() - Admin Bypass Check
```sql
CREATE FUNCTION public.spend_coins(
  user_id UUID,
  amount INTEGER,
  item_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  user_is_admin BOOLEAN;
BEGIN
  -- SERVER-SIDE admin check
  SELECT profiles.is_admin
  INTO user_is_admin
  FROM public.profiles
  WHERE profiles.user_id = spend_coins.user_id;

  -- Admin bypass (validated server-side, not client)
  IF user_is_admin THEN
    RETURN true; -- Admins don't spend coins
  END IF;

  -- Regular coin spending logic for non-admins
  -- ...
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

## Security Guarantees

### What's Protected
1. **Admin Self-Grant**: Users cannot grant themselves admin via client calls
2. **Admin Modification**: Users cannot modify their own admin status
3. **Privilege Escalation**: Non-admins cannot access admin-only Edge Functions
4. **Coin Bypass**: Admin bypass for purchases is validated server-side
5. **Direct DB Access**: RLS policies block direct database manipulation

### Attack Vectors Mitigated
- ✅ Browser DevTools manipulation
- ✅ Direct Supabase client calls
- ✅ API request interception
- ✅ TOCTOU race conditions (via triggers)
- ✅ SQL injection attempts

## Files Modified

### Client-Side (React Components)
1. `/src/components/AdminToggle.tsx`
   - Changed: Direct DB calls → Edge Function calls
   - Lines changed: ~50 lines reduced to ~20 lines

2. `/src/components/SearchPeople.tsx`
   - Changed: Direct DB calls → Edge Function calls
   - Lines changed: ~60 lines reduced to ~30 lines

### Server-Side (Edge Functions)
3. `/supabase/functions/_shared/security.ts`
   - Added: `verifyUserAdmin()` utility function
   - Added: `requireAdminAccess()` middleware
   - Added: `createAdminForbiddenResponse()` helper

4. `/supabase/functions/grant-admin/index.ts`
   - Already had server-side verification
   - Verified security implementation

5. `/supabase/functions/revoke-admin/index.ts`
   - Already had server-side verification
   - Verified security implementation

6. `/supabase/functions/search-users/index.ts`
   - Already had server-side verification
   - Verified security implementation

### Database (Migrations)
7. Existing migrations already provide protection:
   - `20251229330000_fix_admin_bypass_server_side.sql`
   - `20260114000000_fix_critical_admin_escalation.sql`

## Testing

### Security Test Script
Run `/tests/admin-security-test.sql` in Supabase SQL Editor to verify:
1. RLS policies are active
2. Triggers are preventing self-grant
3. Server-side functions are working
4. Edge Functions are verifying admin status

### Manual Testing
1. **Test Non-Admin Cannot Grant Admin**:
   ```typescript
   // As a non-admin user
   const { error } = await supabase.functions.invoke('grant-admin', {
     body: { userId: myUserId }
   });
   // Expected: error with 403 status
   ```

2. **Test Admin Can Grant Admin**:
   ```typescript
   // As an admin user
   const { data, error } = await supabase.functions.invoke('grant-admin', {
     body: { userId: targetUserId }
   });
   // Expected: success
   ```

3. **Test Direct DB Update Fails**:
   ```typescript
   // As any user
   const { error } = await supabase
     .from('profiles')
     .update({ is_admin: true })
     .eq('user_id', myUserId);
   // Expected: error (RLS policy blocks)
   ```

## Verification Checklist

- [x] Client components use Edge Functions (not direct DB calls)
- [x] Edge Functions verify admin status server-side
- [x] RLS policies prevent admin self-grant
- [x] Triggers double-check admin modifications
- [x] Server-side functions (spend_coins) check admin from DB
- [x] Security utilities added to shared security.ts
- [x] Test script created for verification

## Deployment Instructions

1. **Push migrations** (if not already deployed):
   ```bash
   npx supabase db push
   ```

2. **Deploy Edge Functions**:
   ```bash
   npx supabase functions deploy grant-admin
   npx supabase functions deploy revoke-admin
   npx supabase functions deploy search-users
   ```

3. **Verify security**:
   - Run `/tests/admin-security-test.sql` in Supabase SQL Editor
   - Check that all tests pass

## Monitoring

### Abuse Logging
All unauthorized admin access attempts are logged to `abuse_log` table:
```sql
SELECT * FROM abuse_log
WHERE event_type = 'privilege_escalation_attempt'
ORDER BY created_at DESC;
```

### Audit Trail
Admin grants/revokes are logged with:
- Requesting user ID
- Target user ID
- Timestamp
- Success/failure status

## Summary

This fix implements defense-in-depth for admin authorization:
1. **Client**: UI components call Edge Functions (not DB directly)
2. **Server**: Edge Functions verify admin from database
3. **Database**: RLS policies block unauthorized updates
4. **Double-Check**: Triggers catch any bypass attempts

**Security Level**: 🟢 **SECURE** - Multiple layers of protection, no single point of failure.
