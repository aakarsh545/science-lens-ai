import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

/**
 * Settings Page Tests
 * Tests for settings and configuration options
 */
test.describe('Settings Page', () => {
  test.beforeEach(async ({ page }) => {
    // Setup authentication before accessing protected route
    await setupAuth(page);
    await page.goto('/science-lens/settings');
    await page.waitForLoadState('networkidle');
  });

  test('should load settings page', async ({ page }) => {
    expect(page.url()).toContain('/settings');
  });

  test('should test all settings controls', async ({ page }) => {
    const allButtons = page.locator('button');
    const count = await allButtons.count();

    console.log(`Testing ${count} buttons on settings page`);

    for (let i = 0; i < Math.min(count, 20); i++) {
      const button = allButtons.nth(i);
      if (await button.isVisible()) {
        try {
          await button.scrollIntoViewIfNeeded();
          const text = await button.textContent();
          console.log(`Clicking button: ${text?.trim()}`);
          await button.click();
          await page.waitForTimeout(500);
        } catch (error) {
          console.log(`Error with button ${i}:`, error);
        }
      }
    }
  });

  test('should test toggles and switches', async ({ page }) => {
    const toggles = page.locator('[role="switch"], [type="checkbox"], [class*="switch"], [class*="toggle"]');
    const count = await toggles.count();

    console.log(`Testing ${count} toggles/switches`);

    for (let i = 0; i < count; i++) {
      const toggle = toggles.nth(i);
      if (await toggle.isVisible()) {
        try {
          await toggle.scrollIntoViewIfNeeded();
          await toggle.click();
          await page.waitForTimeout(300);
        } catch (error) {
          console.log(`Error with toggle ${i}:`, error);
        }
      }
    }
  });

  test('should test dropdowns and selects', async ({ page }) => {
    const dropdowns = page.locator('select, [role="combobox"]');
    const count = await dropdowns.count();

    console.log(`Testing ${count} dropdowns`);

    for (let i = 0; i < count; i++) {
      const dropdown = dropdowns.nth(i);
      if (await dropdown.isVisible()) {
        try {
          await dropdown.scrollIntoViewIfNeeded();
          await dropdown.click();
          await page.waitForTimeout(500);

          const options = page.locator('[role="option"], option');
          const optionCount = await options.count();

          if (optionCount > 0) {
            await options.first().click();
            await page.waitForTimeout(500);
          }
        } catch (error) {
          console.log(`Error with dropdown ${i}:`, error);
        }
      }
    }
  });

  test('should test sliders', async ({ page }) => {
    const sliders = page.locator('[type="range"], [role="slider"]');
    const count = await sliders.count();

    console.log(`Testing ${count} sliders`);

    for (let i = 0; i < count; i++) {
      const slider = sliders.nth(i);
      if (await slider.isVisible()) {
        try {
          await slider.scrollIntoViewIfNeeded();
          await slider.click();
          await page.waitForTimeout(300);
        } catch (error) {
          console.log(`Error with slider ${i}:`, error);
        }
      }
    }
  });

  test('should test all input fields', async ({ page }) => {
    const inputs = page.locator('input, textarea');
    const count = await inputs.count();

    console.log(`Testing ${count} input fields`);

    for (let i = 0; i < count; i++) {
      const input = inputs.nth(i);
      if (await input.isVisible()) {
        const type = await input.getAttribute('type');
        if (type !== 'checkbox' && type !== 'radio') {
          try {
            await input.scrollIntoViewIfNeeded();
            await input.fill('test value');
            await page.waitForTimeout(300);
          } catch (error) {
            console.log(`Error with input ${i}:`, error);
          }
        }
      }
    }
  });
});
