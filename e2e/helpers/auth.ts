import { Page } from '@playwright/test';

/**
 * Test Authentication Helper
 *
 * This file provides utilities for handling authentication in Playwright tests.
 * The app uses Supabase authentication with localStorage for session storage.
 */

interface SupabaseSession {
  access_token: string;
  refresh_token: string;
  expires_at: number;
  user: {
    id: string;
    email: string;
    aud: string;
    role: string;
    email_confirmed_at?: string;
    created_at: string;
    updated_at: string;
  };
}

interface SupabaseAuthData {
  currentSession?: SupabaseSession;
  expiresAt?: number;
}

/**
 * Creates a mock authenticated session for testing
 */
function createMockSession(): SupabaseSession {
  const testUserId = '00000000-0000-0000-0000-000000000000';
  const now = Math.floor(Date.now() / 1000);
  const expiresAt = now + 3600; // 1 hour from now

  return {
    access_token: 'test-access-token-' + Date.now(),
    refresh_token: 'test-refresh-token-' + Date.now(),
    expires_at: expiresAt,
    user: {
      id: testUserId,
      email: 'test@example.com',
      aud: 'authenticated',
      role: 'authenticated',
      email_confirmed_at: new Date().toISOString(),
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    },
  };
}

/**
 * Sets up authenticated state by mocking Supabase session in localStorage
 *
 * This approach bypasses actual authentication by directly setting the session
 * in localStorage, which is where Supabase stores it in the browser.
 */
export async function authenticateTestUser(page: Page): Promise<void> {
  const mockSession = createMockSession();

  // Navigate to base URL first
  await page.goto('/');

  // Set the mock session in localStorage
  await page.evaluate((session) => {
    // Supabase stores session in localStorage with this key
    const authData: SupabaseAuthData = {
      currentSession: session,
      expiresAt: session.expires_at,
    };

    // Store session data
    localStorage.setItem('sb-' + window.location.hostname + '-auth-token', JSON.stringify(authData));

    // Also set alternative storage keys that Supabase might use
    localStorage.setItem('supabase.auth.token', JSON.stringify(session));

    // Set session in the format Supabase expects
    const supabaseAuth = {
      currentSession: session,
      expiresAt: session.expires_at,
    };

    // Try multiple possible storage keys
    const possibleKeys = [
      'supabase.auth.token',
      'sb-' + window.location.hostname + '-auth-token',
      'sb-' + 'localhost' + '-auth-token',
    ];

    possibleKeys.forEach(key => {
      localStorage.setItem(key, JSON.stringify(supabaseAuth));
    });

  }, mockSession);

  // Reload the page to apply the authentication state
  await page.reload();
  await page.waitForLoadState('networkidle');

  console.log('Test user authenticated successfully');
}

/**
 * Clears authentication state
 */
export async function clearAuthState(page: Page): Promise<void> {
  await page.evaluate(() => {
    // Clear all Supabase-related localStorage items
    const keysToRemove: string[] = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && (key.includes('supabase') || key.includes('sb-'))) {
        keysToRemove.push(key);
      }
    }
    keysToRemove.forEach(key => localStorage.removeItem(key));
  });
}

/**
 * Checks if user is authenticated
 */
export async function isAuthenticated(page: Page): Promise<boolean> {
  const result = await page.evaluate(() => {
    const token = localStorage.getItem('supabase.auth.token');
    return token !== null;
  });
  return result;
}

/**
 * Sets up authentication before navigating to protected routes
 * This is the main helper function to use in tests
 */
export async function setupAuth(page: Page): Promise<void> {
  // First, set up context-level routing BEFORE any navigation
  const context = page.context();

  // Mock the Supabase auth API endpoints at context level (applies to all pages)
  await context.route('**/auth/v1/user', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        id: '00000000-0000-0000-0000-000000000000',
        email: 'test@example.com',
        aud: 'authenticated',
        role: 'authenticated',
        email_confirmed_at: new Date().toISOString(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      }),
    });
  });

  await context.route('**/auth/v1/session', async route => {
    const mockSession = createMockSession();
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        data: { session: mockSession },
        error: null,
      }),
    });
  });

  await context.route('**/rest/v1/user_stats*', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify([
        {
          user_id: '00000000-0000-0000-0000-000000000000',
          credits: 100,
          streak_days: 5,
          total_questions: 10,
          last_login: new Date().toISOString(),
        },
      ]),
    });
  });

  await context.route('**/rpc/refresh_daily_credits', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify(null),
    });
  });

  // Navigate to base URL first to set localStorage
  await page.goto('/');

  // Set localStorage with the correct Supabase storage key format
  const mockSession = createMockSession();

  await page.evaluate((session) => {
    // Supabase uses this specific format in localStorage
    // Storage key format: sb-{hostname}-auth-token
    const hostname = window.location.hostname;
    const storageKey = `sb-${hostname}-auth-token`;
    const authData = {
      currentSession: session,
      expiresAt: session.expires_at,
    };

    // Clear any existing auth data first
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && (key.includes('supabase') || key.includes('sb-'))) {
        localStorage.removeItem(key);
      }
    }

    // Set the auth data with BOTH possible key formats
    localStorage.setItem(storageKey, JSON.stringify(authData));
    localStorage.setItem('supabase.auth.token', JSON.stringify(session));
    localStorage.setItem(`sb-${hostname}-auth-token`, JSON.stringify(authData));

    console.log('Set localStorage with keys:', storageKey, 'supabase.auth.token');
    console.log('LocalStorage value:', localStorage.getItem(storageKey));
  }, mockSession);

  console.log('Test user authenticated successfully with API mocking and localStorage');
}

/**
 * Authenticated page goto helper
 * Use this to navigate to authenticated routes
 */
export async function gotoAuthenticatedPage(page: Page, path: string): Promise<void> {
  // Ensure we're authenticated first
  const isAuth = await isAuthenticated(page);
  if (!isAuth) {
    await setupAuth(page);
  }

  // Navigate to the requested path
  await page.goto(path);
  await page.waitForLoadState('networkidle');

  // Verify we're not redirected to home (which would indicate auth failure)
  const currentUrl = page.url();
  if (currentUrl.endsWith('/') && path !== '/' && !currentUrl.includes(path)) {
    throw new Error(`Authentication failed - redirected to home instead of ${path}`);
  }
}
