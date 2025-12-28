import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

/**
 * Dashboard Tests
 * Tests for the authenticated dashboard area
 */
test.describe('Dashboard', () => {
  test.beforeEach(async ({ page }) => {
    // Setup authentication before accessing protected route
    await setupAuth(page);
    await page.goto('/science-lens');
  });

  test('should load dashboard page', async ({ page }) => {
    await page.waitForLoadState('networkidle');
    expect(page.url()).toContain('/science-lens');
  });

  test('should display dashboard elements', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    // Check for common dashboard elements
    const cards = await page.locator('[class*="card"], [class*="Card"]').count();
    console.log(`Found ${cards} card elements`);

    const buttons = await page.locator('button').count();
    console.log(`Found ${buttons} buttons`);

    const inputs = await page.locator('input').count();
    console.log(`Found ${inputs} input fields`);
  });

  test('should interact with sidebar navigation', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    const sidebarButtons = page.locator('button').filter({ hasText: /learning|ask|topics|dashboard|achievements|settings/i });

    const count = await sidebarButtons.count();
    console.log(`Found ${count} sidebar navigation buttons`);

    for (let i = 0; i < Math.min(count, 5); i++) {
      const button = sidebarButtons.nth(i);
      if (await button.isVisible()) {
        try {
          const buttonText = await button.textContent();
          console.log(`Clicking sidebar button: ${buttonText}`);

          await button.click();
          await page.waitForTimeout(1000);

          // Check for console errors after navigation
          const errors: string[] = [];
          page.on('console', msg => {
            if (msg.type() === 'error') {
              errors.push(msg.text());
            }
          });

          if (errors.length > 0) {
            console.log(`Errors after clicking ${buttonText}:`, errors);
          }
        } catch (error) {
          console.log(`Error clicking sidebar button:`, error);
        }
      }
    }
  });

  test('should test all clickable buttons on dashboard', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    const allButtons = page.locator('button');
    const count = await allButtons.count();

    console.log(`Testing ${count} buttons on dashboard`);

    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    for (let i = 0; i < Math.min(count, 15); i++) {
      const button = allButtons.nth(i);
      const isVisible = await button.isVisible();

      if (isVisible) {
        try {
          await button.scrollIntoViewIfNeeded();
          await page.waitForTimeout(200);

          const buttonText = await button.textContent();
          console.log(`Clicking button ${i + 1}: ${buttonText?.trim() || 'unnamed'}`);

          await button.click({ timeout: 3000 });
          await page.waitForTimeout(500);

          // Log any errors
          if (errors.length > 0) {
            console.log(`Errors after clicking button ${i + 1}:`, errors);
            errors.length = 0; // Clear for next iteration
          }
        } catch (error) {
          console.log(`Error clicking button ${i + 1}:`, error);
        }
      }
    }
  });

  test('should test all input fields on dashboard', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    const inputs = page.locator('input, textarea');
    const count = await inputs.count();

    console.log(`Testing ${count} input fields on dashboard`);

    for (let i = 0; i < Math.min(count, 10); i++) {
      const input = inputs.nth(i);
      const isVisible = await input.isVisible();

      if (isVisible) {
        try {
          await input.scrollIntoViewIfNeeded();
          await page.waitForTimeout(200);

          const inputType = await input.getAttribute('type');
          console.log(`Testing input ${i + 1}: type=${inputType || 'text'}`);

          await input.click();
          await input.fill('Test input value');
          await page.waitForTimeout(300);

          // Check if input is editable
          const value = await input.inputValue();
          if (value !== 'Test input value') {
            console.log(`Input ${i + 1} might be read-only or has validation`);
          }
        } catch (error) {
          console.log(`Error with input ${i + 1}:`, error);
        }
      }
    }
  });

  test('should test dropdown menus', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    const dropdowns = page.locator('[role="combobox"], select, [data-testid*="dropdown"], [data-testid*="select"]');
    const count = await dropdowns.count();

    console.log(`Testing ${count} dropdowns on dashboard`);

    for (let i = 0; i < count; i++) {
      const dropdown = dropdowns.nth(i);
      const isVisible = await dropdown.isVisible();

      if (isVisible) {
        try {
          await dropdown.scrollIntoViewIfNeeded();
          await page.waitForTimeout(200);

          console.log(`Clicking dropdown ${i + 1}`);
          await dropdown.click();
          await page.waitForTimeout(500);

          // Try to select an option if available
          const options = page.locator('[role="option"], option');
          const optionCount = await options.count();

          if (optionCount > 0) {
            await options.first().click();
            await page.waitForTimeout(500);
          }
        } catch (error) {
          console.log(`Error with dropdown ${i + 1}:`, error);
        }
      }
    }
  });

  test('should test cards and panels', async ({ page }) => {
    await page.waitForLoadState('networkidle');

    const cards = page.locator('[class*="card"], [class*="Card"], [class*="panel"], [class*="Panel"]');
    const count = await cards.count();

    console.log(`Testing ${count} cards/panels on dashboard`);

    for (let i = 0; i < Math.min(count, 10); i++) {
      const card = cards.nth(i);
      const isVisible = await card.isVisible();

      if (isVisible) {
        try {
          await card.scrollIntoViewIfNeeded();
          await page.waitForTimeout(200);

          // Try clicking on the card
          await card.click();
          await page.waitForTimeout(300);
        } catch (error) {
          console.log(`Error clicking card ${i + 1}:`, error);
        }
      }
    }
  });
});
