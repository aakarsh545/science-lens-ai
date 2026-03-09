# E2E Testing with Playwright

This directory contains end-to-end tests for the Science Lens AI application.

## Authentication Setup

All routes under `/science-lens/*` require authentication. Tests use a mock authentication system that simulates a Supabase session in localStorage.

### How It Works

1. **Supabase Auth Integration**: The app uses Supabase for authentication
2. **Session Storage**: Supabase stores sessions in `localStorage`
3. **Mock Authentication**: Tests create a mock session and store it directly in localStorage
4. **No Real Auth**: Tests bypass actual authentication for faster, more reliable testing

### Authentication Helper

The `helpers/auth.ts` file provides utilities for test authentication:

```typescript
import { setupAuth } from './helpers/auth';

// In your test
test.beforeEach(async ({ page }) => {
  await setupAuth(page);
  await page.goto('/science-lens/ask');
});
```

### Available Auth Functions

- `setupAuth(page)` - Sets up mock authentication (primary function to use)
- `authenticateTestUser(page)` - Creates and stores mock session
- `clearAuthState(page)` - Clears authentication from localStorage
- `isAuthenticated(page)` - Checks if user is authenticated
- `gotoAuthenticatedPage(page, path)` - Authenticated navigation helper

## Test Structure

```
e2e/
├── helpers/
│   └── auth.ts           # Authentication utilities
├── landing-page.spec.ts  # Public landing page tests
├── dashboard.spec.ts     # Dashboard tests (auth required)
├── ask-page.spec.ts      # AI chat interface tests (auth required)
├── learning-page.spec.ts # Learning page tests (auth required)
├── settings-page.spec.ts # Settings page tests (auth required)
└── comprehensive.spec.ts # All other pages (auth required)
```

## Writing New Tests

When creating tests for protected routes:

1. **Import the auth helper**:
   ```typescript
   import { setupAuth } from './helpers/auth';
   ```

2. **Setup authentication before navigation**:
   ```typescript
   test.beforeEach(async ({ page }) => {
     await setupAuth(page);
     await page.goto('/science-lens/your-route');
   });
   ```

3. **Or call setupAuth in individual tests**:
   ```typescript
   test('my test', async ({ page }) => {
     await setupAuth(page);
     await page.goto('/science-lens/your-route');
     // Your test code here
   });
   ```

## Running Tests

### Run all tests
```bash
npm run test:e2e
# or
npx playwright test
```

### Run specific test file
```bash
npx playwright test dashboard.spec.ts
```

### Run tests in UI mode
```bash
npx playwright test --ui
```

### Debug tests
```bash
npx playwright test --debug
```

### View test reports
```bash
npx playwright show-report
```

## Configuration

Playwright configuration is in `playwright.config.ts`:

- **Base URL**: `http://localhost:8080`
- **Test Server**: Auto-started with `npm run dev`
- **Workers**: 1 (to avoid auth conflicts)
- **Parallel**: Disabled (for better auth handling)
- **Screenshots**: On failure
- **Videos**: On failure
- **Traces**: On first retry

## Troubleshooting

### Tests redirect to landing page (/)
**Problem**: All `/science-lens/*` routes redirect to `/`

**Solution**: Ensure you're calling `await setupAuth(page)` before navigating to protected routes.

```typescript
// ✅ Correct
test('my test', async ({ page }) => {
  await setupAuth(page);  // Setup auth FIRST
  await page.goto('/science-lens/ask');
  // Now test works
});

// ❌ Wrong
test('my test', async ({ page }) => {
  await page.goto('/science-lens/ask');  // No auth, will redirect
  // Test fails
});
```

### "Failed to authenticate test user" error
**Problem**: Authentication helper threw an error

**Solution**:
1. Check browser console for detailed error
2. Verify localStorage is being set correctly
3. Try running test with `--debug` flag

### Test timeout
**Problem**: Tests are timing out

**Solution**:
1. Increase timeout in test:
   ```typescript
   test.setTimeout(60000); // 60 seconds
   ```
2. Check if dev server is running on correct port
3. Verify network requests are completing

### Auth state persists between tests
**Problem**: Tests are affecting each other's auth state

**Solution**: Use `test.beforeEach` to ensure clean state:
```typescript
test.beforeEach(async ({ page }) => {
  // Clear any existing auth
  await clearAuthState(page);
  // Setup fresh auth
  await setupAuth(page);
});
```

## CI/CD Integration

For CI environments:
1. Set `CI=true` environment variable
2. Tests will retry 2 times on failure
3. Single worker mode prevents auth conflicts
4. Dev server timeout is set to 120 seconds

## Best Practices

1. **Always authenticate** before accessing protected routes
2. **Use beforeEach** to ensure clean state for each test
3. **Wait for networkidle** after navigation to ensure page is loaded
4. **Use descriptive test names** to identify which route is being tested
5. **Check console errors** and log them for debugging
6. **Test one thing at a time** - keep tests focused and simple
7. **Use locators** instead of selectors for more stable tests

## Example Test

```typescript
import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

test.describe('My Feature', () => {
  test.beforeEach(async ({ page }) => {
    // Always authenticate first
    await setupAuth(page);
    await page.goto('/science-lens/my-feature');
    await page.waitForLoadState('networkidle');
  });

  test('should load correctly', async ({ page }) => {
    // Verify we're on the correct page
    expect(page.url()).toContain('/my-feature');

    // Test your feature
    const button = page.locator('button').first();
    await expect(button).toBeVisible();
  });
});
```
