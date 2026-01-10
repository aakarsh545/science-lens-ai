# Edge Function Security Hardening - Deployment Guide

## Quick Start

### Step 1: Update Allowed Origins (CRITICAL)

Before deploying, you MUST update the allowed origins in the security utilities:

**File:** `supabase/functions/_shared/security.ts`

**Find this section (around line 18):**
```typescript
const ALLOWED_ORIGINS = [
  // Production domains - UPDATE THESE WITH YOUR ACTUAL DOMAINS
  "https://yourdomain.com",
  "https://www.yourdomain.com",

  // Local development
  "http://localhost:5173",
  "http://localhost:3000",
  "http://127.0.0.1:5173",
  "http://127.0.0.1:3000",
];
```

**Replace with your actual domains:**
```typescript
const ALLOWED_ORIGINS = [
  // Add your production domain
  "https://your-actual-domain.com",
  "https://www.your-actual-domain.com",

  // Keep localhost for development
  "http://localhost:5173",
  "http://localhost:3000",

  // Add preview domains if using Vercel/Netlify
  // "https://*.vercel.app",
  // "https://*.netlify.app",
];
```

### Step 2: Deploy Database Migration

Push the abuse_log table and related structures to your database:

```bash
cd /Users/akarsh545/Workspaces/science-lens-ai/science-lens-ai-code
npx supabase db push --include-all
```

**Expected output:**
```
Applying migration 20251229290000_add_abuse_logging.sql...
✅ Migration applied successfully
```

### Step 3: Deploy Edge Functions

Deploy all secured edge functions:

```bash
# Deploy all functions at once
npx supabase functions deploy

# Or deploy individually
npx supabase functions deploy ask
npx supabase functions deploy challenge-sessions
npx supabase functions deploy search-users
npx supabase functions deploy grant-admin
npx supabase functions deploy revoke-admin
```

**Expected output:**
```
Deployed ask:
  ✅ https://kljndbehjwfdyewgxgaw.supabase.co/functions/v1/ask
Deployed challenge-sessions:
  ✅ https://kljndbehjwfdyewgxgaw.supabase.co/functions/v1/challenge-sessions
...
```

---

## Verification

### Test 1: Verify CORS is Working

From your allowed origin (localhost or your domain):
```bash
curl -X OPTIONS https://your-project.supabase.co/functions/v1/ask \
  -H "Origin: http://localhost:5173" \
  -H "Access-Control-Request-Method: POST" \
  -v
```

**Should return:** `204 No Content` with proper CORS headers

From a disallowed origin:
```bash
curl -X OPTIONS https://your-project.supabase.co/functions/v1/ask \
  -H "Origin: https://malicious-site.com" \
  -H "Access-Control-Request-Method: POST" \
  -v
```

**Should return:** `403 Forbidden`

### Test 2: Verify Rate Limiting

Make rapid requests to trigger rate limit:
```bash
for i in {1..70}; do
  curl -X POST https://your-project.supabase.co/functions/v1/ask \
    -H "Authorization: Bearer YOUR_JWT_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"message":"test","conversationId":"test"}'
done
```

**Should return:** `429 Too Many Requests` after 60 requests

### Test 3: Verify Abuse Logging

Check the database for logged events:
```sql
-- View recent abuse events
SELECT * FROM recent_abuse_events;

-- Check for specific user
SELECT * FROM abuse_log WHERE user_id = 'your-user-id' ORDER BY created_at DESC;

-- View alerts
SELECT * FROM alert_abuse_events;
```

---

## Monitoring

### Daily Checks

Run these queries to monitor security:

```sql
-- 1. Recent abuse events (last 24 hours)
SELECT * FROM recent_abuse_events;

-- 2. Top offenders (users with most violations)
SELECT * FROM top_abuse_offenders;

-- 3. Critical/high severity events
SELECT * FROM alert_abuse_events;

-- 4. Rate limit violations by endpoint
SELECT * FROM abuse_by_endpoint;

-- 5. Failed authentication attempts
SELECT * FROM failed_auth_attempts;
```

### Set Up Alerts

Consider setting up alerts for:
- More than 10 rate limit violations per hour
- Any critical severity events
- Privilege escalation attempts (grant/revoke admin)
- More than 5 failed auth attempts from same IP

---

## Troubleshooting

### Issue: "Origin not allowed" Errors

**Cause:** Your domain is not in the ALLOWED_ORIGINS array

**Solution:**
1. Edit `supabase/functions/_shared/security.ts`
2. Add your domain to ALLOWED_ORIGINS
3. Redeploy the affected function

### Issue: Rate Limit Too Strict

**Cause:** Legitimate users being rate limited

**Solution:**
1. Review rate limit settings in each function
2. Adjust limits based on your usage patterns
3. Redeploy affected functions

**Example - Increase ask rate limit:**
```typescript
// In ask/index.ts, find:
await checkRateLimit(supabase, userId, "ask", 60, 60);

// Change to:
await checkRateLimit(supabase, userId, "ask", 120, 60); // 120/minute
```

### Issue: Migration Fails

**Cause:** Missing dependencies or table conflicts

**Solution:**
1. Ensure Sub-Agent B's migrations are applied first (rate_limit table)
2. Check for table name conflicts
3. Run with `--debug` flag for detailed error:
   ```bash
   npx supabase db push --include-all --debug
   ```

### Issue: Functions Not Logging

**Cause:** RLS policies blocking inserts

**Solution:**
1. Verify RLS policies are correctly applied
2. Check service role key is set in environment
3. Test abuse_log insert directly:
   ```sql
   INSERT INTO abuse_log (event_type, endpoint, details, severity)
   VALUES ('test', 'test-endpoint', '{}', 'low');
   ```

---

## Rollback Plan

If you need to rollback:

### Option 1: Restore Previous Function Versions

```bash
git checkout HEAD~1 supabase/functions/ask/index.ts
git checkout HEAD~1 supabase/functions/challenge-sessions/index.ts
# ... etc

npx supabase functions deploy
```

### Option 2: Disable Security Features Temporarily

Comment out security checks in individual functions:
```typescript
// // const optionsResponse = handleOptions(req);
// // if (optionsResponse) return optionsResponse;
```

---

## Configuration Reference

### Rate Limits by Function

| Function | Endpoint | Limit | Window | Purpose |
|----------|----------|-------|--------|---------|
| ask | / | 60 | 1 minute | AI chat requests |
| challenge-sessions | /start | 10 | 1 hour | Prevent abuse |
| challenge-sessions | /answer | 100 | 1 minute | Quiz flow |
| search-users | / | 30 | 1 minute | Admin search |
| grant-admin | / | 5 | 1 hour | Privilege escalation |
| revoke-admin | / | 5 | 1 hour | Privilege escalation |

### Abuse Event Types

- `auth_failure` - Authentication failed
- `rate_limit` - Rate limit exceeded
- `suspicious_activity` - Bot/crawler detected
- `admin_escalation` - Admin privileges granted
- `privilege_escalation_attempt` - Failed escalation attempt
- `perfect_score` - Perfect quiz score (potential cheating)
- `rapid_requests` - Abnormal request frequency
- `unusual_user_agent` - Suspicious user agent

### Severity Levels

- **low** - Informational events
- **medium** - Potential abuse (default)
- **high** - Likely abuse or attack
- **critical** - Severe attack or security breach

---

## Next Steps

1. ✅ Deploy changes to production
2. ✅ Monitor abuse logs for first week
3. ✅ Tune rate limits based on usage
4. ✅ Set up automated alerts
5. ✅ Document any additional allowed origins
6. ✅ Train team on monitoring dashboard

---

## Support

For issues or questions:
1. Check the main report: `EDGE_FUNCTION_SECURITY_HARDENING_REPORT.md`
2. Review the security utilities: `supabase/functions/_shared/security.ts`
3. Check Supabase logs for detailed error messages
4. Test in development environment first

---

**Deployment Guide Version:** 1.0
**Last Updated:** 2025-12-29
**Status:** Ready for Production
