import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

/**
 * Learning Page Tests
 * Tests for the unified learning page and course/lesson pages
 */
test.describe('Learning Page', () => {
  test('should load learning page', async ({ page }) => {
    await setupAuth(page);
    await page.goto('/science-lens/learning');
    await page.waitForLoadState('networkidle');
    expect(page.url()).toContain('/learning');
  });

  test('should test all interactive elements', async ({ page }) => {
    await setupAuth(page);
    await page.goto('/science-lens/learning');
    await page.waitForLoadState('networkidle');

    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // Test buttons
    const buttons = page.locator('button');
    const buttonCount = await buttons.count();
    console.log(`Found ${buttonCount} buttons on learning page`);

    for (let i = 0; i < Math.min(buttonCount, 20); i++) {
      const button = buttons.nth(i);
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

    // Test links
    const links = page.locator('a[href]');
    const linkCount = await links.count();
    console.log(`Found ${linkCount} links on learning page`);

    for (let i = 0; i < Math.min(linkCount, 10); i++) {
      const link = links.nth(i);
      const href = await link.getAttribute('href');

      if (href && !href.startsWith('http') && !href.startsWith('mailto:')) {
        try {
          await link.click();
          await page.waitForTimeout(500);
          await page.goBack();
          await page.waitForLoadState('networkidle');
        } catch (error) {
          console.log(`Error with link ${href}:`, error);
        }
      }
    }

    if (errors.length > 0) {
      console.log('Console errors on learning page:', errors);
    }
  });

  test('should test course cards', async ({ page }) => {
    await setupAuth(page);
    await page.goto('/science-lens/learning');
    await page.waitForLoadState('networkidle');

    const courseCards = page.locator('[class*="course"], [class*="Course"], article').filter({ hasText: /.+/ });
    const count = await courseCards.count();
    console.log(`Found ${count} course cards`);

    for (let i = 0; i < Math.min(count, 5); i++) {
      const card = courseCards.nth(i);
      if (await card.isVisible()) {
        try {
          await card.scrollIntoViewIfNeeded();
          await card.click();
          await page.waitForTimeout(500);
          await page.goBack();
          await page.waitForLoadState('networkidle');
        } catch (error) {
          console.log(`Error clicking course card ${i}:`, error);
        }
      }
    }
  });

  test('should test topic selection', async ({ page }) => {
    await setupAuth(page);
    await page.goto('/science-lens/learning');
    await page.waitForLoadState('networkidle');

    const topicButtons = page.locator('button').filter({ hasText: /biology|chemistry|physics|math|science/i });
    const count = await topicButtons.count();

    console.log(`Found ${count} topic selection buttons`);

    for (let i = 0; i < count; i++) {
      const button = topicButtons.nth(i);
      if (await button.isVisible()) {
        try {
          await button.click();
          await page.waitForTimeout(1000);
        } catch (error) {
          console.log(`Error selecting topic ${i}:`, error);
        }
      }
    }
  });
});
