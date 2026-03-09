# Quick Start Guide - E2E Testing

## The Problem Fixed
Tests were redirecting from protected routes (`/science-lens/*`) to landing page (`/`) because authentication wasn't handled.

## The Solution
Use the `setupAuth()` helper from `./helpers/auth` before accessing protected routes.

## 3 Simple Steps

### 1. Import the helper
```typescript
import { setupAuth } from './helpers/auth';
```

### 2. Call setupAuth BEFORE navigation
```typescript
test.beforeEach(async ({ page }) => {
  await setupAuth(page);  // ← First!
  await page.goto('/science-lens/your-route');
});
```

### 3. Write your test normally
```typescript
test('should work', async ({ page }) => {
  expect(page.url()).toContain('/your-route');
  // ... rest of your test
});
```

## Complete Example

```typescript
import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

test.describe('My Feature', () => {
  test.beforeEach(async ({ page }) => {
    await setupAuth(page);
    await page.goto('/science-lens/my-feature');
    await page.waitForLoadState('networkidle');
  });

  test('should load correctly', async ({ page }) => {
    expect(page.url()).toContain('/my-feature');
    // Test your feature
  });
});
```

## What NOT to Do

❌ **Don't** navigate to protected routes without auth:
```typescript
test('bad test', async ({ page }) => {
  await page.goto('/science-lens/ask');  // Will redirect to /
  // This will fail!
});
```

✅ **Do** authenticate first:
```typescript
test('good test', async ({ page }) => {
  await setupAuth(page);  // Setup auth
  await page.goto('/science-lens/ask');  // Then navigate
  // This works!
});
```

## Run Tests

```bash
# All tests
npm test

# Specific file
npx playwright test dashboard.spec.ts

# Debug mode
npx playwright test --debug

# UI mode
npx playwright test --ui
```

## Need Help?

See full documentation: `/e2e/README.md`

---

**Remember**: Always call `await setupAuth(page)` before accessing any `/science-lens/*` route!
