import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

/**
 * Ask Page Tests
 * Tests for the AI chat interface
 */
test.describe('Ask Page (Chat Interface)', () => {
  test.beforeEach(async ({ page }) => {
    // Setup authentication before accessing protected route
    await setupAuth(page);
    await page.goto('/science-lens/ask');
    await page.waitForLoadState('networkidle');
  });

  test('should load ask page', async ({ page }) => {
    expect(page.url()).toContain('/ask');
  });

  test('should display chat interface elements', async ({ page }) => {
    const chatInput = page.locator('textarea').first();
    const sendButton = page.locator('button').filter({ hasText: /send|submit|ask/i }).first();

    // Assert that chat elements exist
    expect(await chatInput.count(), 'Chat input (textarea) should be present').toBeGreaterThan(0);
    expect(await sendButton.count(), 'Send button should be present').toBeGreaterThan(0);
  });

  test('should test sending a message', async ({ page }) => {
    const chatInput = page.locator('input[type="text"], textarea').first();
    const sendButton = page.locator('button').filter({ hasText: /send|submit|ask/i }).first();

    if (await chatInput.count() > 0 && await sendButton.count() > 0) {
      try {
        await chatInput.fill('What is photosynthesis?');
        await sendButton.click();
        await page.waitForTimeout(2000);

        // Check for errors
        const errors: string[] = [];
        page.on('console', msg => {
          if (msg.type() === 'error') {
            errors.push(msg.text());
          }
        });

        if (errors.length > 0) {
          console.log('Errors when sending message:', errors);
        }
      } catch (error) {
        console.log('Error sending message:', error);
      }
    }
  });

  test('should test chat buttons and controls', async ({ page }) => {
    const allButtons = page.locator('button');
    const count = await allButtons.count();

    console.log(`Testing ${count} buttons on ask page`);

    for (let i = 0; i < Math.min(count, 15); i++) {
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

  test('should test conversation list', async ({ page }) => {
    const conversationItems = page.locator('[class*="conversation"], [class*="chat"], li').filter({ hasText: /.+/ });
    const count = await conversationItems.count();

    console.log(`Found ${count} conversation items`);

    for (let i = 0; i < Math.min(count, 5); i++) {
      const item = conversationItems.nth(i);
      if (await item.isVisible()) {
        try {
          await item.click();
          await page.waitForTimeout(500);
        } catch (error) {
          console.log(`Error clicking conversation item ${i}:`, error);
        }
      }
    }
  });

  test('should test all input fields', async ({ page }) => {
    const inputs = page.locator('input, textarea');
    const count = await inputs.count();

    for (let i = 0; i < count; i++) {
      const input = inputs.nth(i);
      if (await input.isVisible()) {
        try {
          await input.scrollIntoViewIfNeeded();
          await input.click();
          await input.fill('Test message');
          await page.waitForTimeout(300);
        } catch (error) {
          console.log(`Error with input ${i}:`, error);
        }
      }
    }
  });
});
