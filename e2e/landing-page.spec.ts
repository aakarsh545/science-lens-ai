import { test, expect } from '@playwright/test';

/**
 * Landing Page Tests
 * Tests for the main landing page at /
 */
test.describe('Landing Page', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test('should load without errors', async ({ page }) => {
    await expect(page).toHaveTitle(/Science Lens/i);
  });

  test('should display main navigation elements', async ({ page }) => {
    // Check for common navigation elements
    const buttons = await page.locator('button').count();
    expect(buttons).toBeGreaterThan(0);

    const links = await page.locator('a').count();
    expect(links).toBeGreaterThan(0);
  });

  test('should handle theme toggle', async ({ page }) => {
    const themeButton = page.locator('[data-testid="theme-toggle"], button:has-text("theme"), button:has-text("dark"), button:has-text("light")').first();

    if (await themeButton.count() > 0) {
      await themeButton.click();
      await page.waitForTimeout(500);
      expect(await page.evaluate(() => document.documentElement.classList.contains('dark'))).toBeTruthy();
    }
  });

  test('should handle CTA buttons', async ({ page }) => {
    const ctaButtons = page.locator('button').filter({ hasText: /get started|sign up|learn more|start/i });

    const count = await ctaButtons.count();
    for (let i = 0; i < count; i++) {
      const button = ctaButtons.nth(i);
      if (await button.isVisible()) {
        await button.click();
        await page.waitForTimeout(1000);
        await page.goBack();
        await page.waitForLoadState('networkidle');
      }
    }
  });

  test('should handle navigation links', async ({ page }) => {
    const navLinks = page.locator('a[href]');

    const linkCount = await navLinks.count();
    const maxLinksToTest = Math.min(linkCount, 10);

    for (let i = 0; i < maxLinksToTest; i++) {
      const link = navLinks.nth(i);
      const href = await link.getAttribute('href');

      if (href && !href.startsWith('http') && !href.startsWith('mailto:')) {
        try {
          await Promise.all([
            page.waitForURL(/\//),
            link.click()
          ]);
          await page.waitForTimeout(500);

          // Check for console errors
          const errors: string[] = [];
          page.on('console', msg => {
            if (msg.type() === 'error') {
              errors.push(msg.text());
            }
          });

          await page.goBack();
          await page.waitForLoadState('networkidle');

          if (errors.length > 0) {
            console.log(`Navigation errors for ${href}:`, errors);
          }
        } catch (error) {
          console.log(`Error navigating to ${href}:`, error);
          await page.goBack();
        }
      }
    }
  });
});
