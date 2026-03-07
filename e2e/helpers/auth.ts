import { Page } from '@playwright/test';
import fs from 'fs';
import path from 'path';

function readEnvFileValue(key: string): string | null {
  try {
    const envPath = path.resolve(__dirname, '..', '..', '.env');
    const contents = fs.readFileSync(envPath, 'utf8');
    const lines = contents.split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith('#')) continue;
      const [k, ...rest] = trimmed.split('=');
      if (k === key) {
        return rest.join('=').trim();
      }
    }
  } catch {
    return null;
  }
  return null;
}

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
  const header = { alg: 'HS256', typ: 'JWT' };
  const payload = {
    sub: testUserId,
    email: 'test@example.com',
    aud: 'authenticated',
    role: 'authenticated',
    iat: now,
    exp: expiresAt,
  };
  const base64url = (obj: object) =>
    Buffer.from(JSON.stringify(obj)).toString('base64url');
  const fakeJwt = `${base64url(header)}.${base64url(payload)}.signature`;

  return {
    access_token: fakeJwt,
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
    const authData = session;

    // Store session data
    localStorage.setItem('sb-' + window.location.hostname + '-auth-token', JSON.stringify(authData));

    // Also set alternative storage keys that Supabase might use
    localStorage.setItem('supabase.auth.token', JSON.stringify(session));

    // Set session in the format Supabase expects
    const supabaseAuth = session;

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
  const supabaseUrl =
    process.env.VITE_SUPABASE_URL ||
    readEnvFileValue('VITE_SUPABASE_URL') ||
    'https://pfrmkmlstzjexccmdkoc.supabase.co';
  const projectRef = (() => {
    try {
      return new URL(supabaseUrl).hostname.split('.')[0];
    } catch {
      return null;
    }
  })();
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

  await context.route('**/auth/v1/token*', async route => {
    const mockSession = createMockSession();
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        access_token: mockSession.access_token,
        refresh_token: mockSession.refresh_token,
        expires_in: 3600,
        token_type: 'bearer',
        user: mockSession.user,
      }),
    });
  });

  await context.route('**/auth/v1/token?grant_type=refresh_token', async route => {
    const mockSession = createMockSession();
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({
        access_token: mockSession.access_token,
        refresh_token: mockSession.refresh_token,
        expires_in: 3600,
        token_type: 'bearer',
        user: mockSession.user,
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

  await context.route('**/rest/v1/profiles*', async route => {
    const url = route.request().url();
    if (url.includes('select=credits') || url.includes('select=credits%2Clevel')) {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ credits: 2500, level: 3 }),
      });
      return;
    }
    if (url.includes('select=equipped_theme')) {
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ equipped_theme: null, shop_items: null }),
      });
      return;
    }
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({ credits: 2500, level: 3 }),
    });
  });

  await context.route('**/rest/v1/conversations*', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify([]),
    });
  });

  await context.route('**/rest/v1/shop_items*', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify([
        {
          id: 'theme-cosmic',
          type: 'theme',
          name: 'Cosmic Default',
          description: 'Deep space blues and subtle glows.',
          price: 0,
          icon_emoji: '🌌',
          metadata: {
            primary: '#3b82f6',
            secondary: '#1e40af',
            description: 'Deep space blues and subtle glows.',
          },
          rarity: 'common',
          thumbnail_url: null,
        },
      ]),
    });
  });

  await context.route('**/rest/v1/user_inventory*', async route => {
    await route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify([]),
    });
  });

  // Set localStorage before any page loads
  const mockSession = createMockSession();
  await context.addInitScript(({ session, supabaseUrl, projectRef }) => {
    // Supabase uses this specific format in localStorage
    // Storage key format: sb-{hostname}-auth-token
    const hostname = window.location.hostname;
    const resolvedProjectRef = projectRef || (() => {
      try {
        const url = new URL(supabaseUrl);
        return url.hostname.split('.')[0];
      } catch {
        return null;
      }
    })();
    const fallbackRef = 'kljndbehjwfdyewgxgaw';
    const storageKey = resolvedProjectRef ? `sb-${resolvedProjectRef}-auth-token` : `sb-${hostname}-auth-token`;
    const authData = session;

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
    localStorage.setItem('supabase.auth.expires_at', String(session.expires_at));
    localStorage.setItem('supabase.auth.refresh_token', session.refresh_token);
    localStorage.setItem('supabase.auth.user', JSON.stringify(session.user));
    localStorage.setItem(`sb-${hostname}-auth-token`, JSON.stringify(authData));
    if (resolvedProjectRef) {
      localStorage.setItem(`sb-${resolvedProjectRef}-auth-token`, JSON.stringify(authData));
      localStorage.setItem(`sb-${resolvedProjectRef}-auth-token-user`, JSON.stringify({ user: session.user }));
    }
    localStorage.setItem(`sb-${fallbackRef}-auth-token`, JSON.stringify(authData));
    localStorage.setItem(`sb-${fallbackRef}-auth-token-user`, JSON.stringify({ user: session.user }));

    // Store a test user marker for Playwright test mode
    localStorage.setItem('playwright_test_user', JSON.stringify(session.user));

    // Mark onboarding and intro as seen for test user to avoid blocking overlays
    const userScopedOnboardingKey = `hasSeenOnboarding_${session.user.id}`;
    const userScopedIntroKey = `hasSeenIntro_${session.user.id}`;
    localStorage.setItem(userScopedOnboardingKey, 'true');
    localStorage.setItem(userScopedIntroKey, 'true');
    localStorage.setItem('hasSeenOnboarding', 'true');
    localStorage.setItem('hasSeenIntro', 'true');

    console.log('Set localStorage with keys:', storageKey, 'supabase.auth.token', resolvedProjectRef ? `sb-${resolvedProjectRef}-auth-token` : 'n/a');
    console.log('LocalStorage value:', localStorage.getItem(storageKey));
  }, { session: mockSession, supabaseUrl, projectRef });

  // Navigate to base URL to initialize app with stored session
  await page.goto('/');
  await page.waitForLoadState('networkidle');
  const storedTestUser = await page.evaluate(() => localStorage.getItem('playwright_test_user'));
  console.log('Playwright test user in storage:', storedTestUser ? 'SET' : 'MISSING');

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

  const target = path === '/' ? path : (path.includes('?') ? `${path}&playwright=1` : `${path}?playwright=1`);

  // Navigate to the requested path
  await page.goto(target);
  await page.waitForLoadState('networkidle');

  // Verify we're not redirected to home (which would indicate auth failure)
  const currentUrl = page.url();
  if (currentUrl.endsWith('/') && path !== '/' && !currentUrl.includes(path)) {
    throw new Error(`Authentication failed - redirected to home instead of ${path}`);
  }
}
