import { defineConfig, devices } from '@playwright/test';

/**
 * Playwright configuration for Science Lens AI testing
 *
 * Authentication:
 * All tests under /science-lens/* require authentication.
 * Use the auth helper: `await setupAuth(page)` from './e2e/helpers/auth'
 *
 * Test Organization:
 * - helpers/auth.ts - Authentication utilities for testing
 * - *.spec.ts - Individual test files
 */
export default defineConfig({
  testDir: './e2e',
  fullyParallel: false, // Disable parallel execution for better auth handling
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: 1, // Use single worker to avoid auth conflicts
  reporter: [['html'], ['list', { printSteps: true }]],
  use: {
    baseURL: 'http://localhost:8080',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
    // Ignore HTTPS errors for development
    ignoreHTTPSErrors: true,
    // Set environment variables for testing
    extraHTTPHeaders: {
      'X-Test-Mode': 'true',
    },
  },
  // Set environment variables for all tests
  globalSetup: './e2e/global-setup.ts',
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:8080',
    reuseExistingServer: !process.env.CI,
    timeout: 120000,
  },
});
