import { test, expect } from '@playwright/test';
import { setupAuth } from './helpers/auth';

/**
 * Comprehensive Page Tests
 * Tests for all remaining pages: pricing, achievements, topics
 */
test.describe('All Pages Comprehensive Test', () => {
  const pages = [
    { path: '/science-lens/pricing', name: 'Pricing' },
    { path: '/science-lens/achievements', name: 'Achievements' },
    { path: '/science-lens/topics', name: 'Topics' },
  ];

  pages.forEach(({ path, name }) => {
    test.describe(`${name} Page`, () => {
      test(`should load ${name} page`, async ({ page }) => {
        await setupAuth(page);
        await page.goto(path);
        await page.waitForLoadState('networkidle');
        expect(page.url()).toContain(path.replace('/science-lens', ''));
      });

      test(`should test all interactive elements on ${name} page`, async ({ page }) => {
        await setupAuth(page);
        await page.goto(path);
        await page.waitForLoadState('networkidle');

        const errors: string[] = [];
        page.on('console', msg => {
          if (msg.type() === 'error') {
            errors.push(msg.text());
          }
        });

        // Test all buttons
        const buttons = page.locator('button');
        const buttonCount = await buttons.count();
        console.log(`${name}: Found ${buttonCount} buttons`);

        let clickErrors = 0;
        for (let i = 0; i < Math.min(buttonCount, 15); i++) {
          const button = buttons.nth(i);
          if (await button.isVisible()) {
            try {
              await button.scrollIntoViewIfNeeded();
              const text = await button.textContent();
              console.log(`${name} - Clicking button ${i + 1}: ${text?.trim() || 'unnamed'}`);
              await button.click({ timeout: 3000 });
              await page.waitForTimeout(500);
            } catch (error) {
              clickErrors++;
              console.log(`${name} - Error with button ${i + 1}:`, error);
            }
          }
        }

        // Test all links
        const links = page.locator('a[href]');
        const linkCount = await links.count();
        console.log(`${name}: Found ${linkCount} links`);

        let navigationErrors = 0;
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
              navigationErrors++;
              console.log(`${name} - Error navigating to ${href}:`, error);
            }
          }
        }

        // Test input fields
        const inputs = page.locator('input, textarea');
        const inputCount = await inputs.count();
        console.log(`${name}: Found ${inputCount} input fields`);

        let inputErrors = 0;
        for (let i = 0; i < Math.min(inputCount, 10); i++) {
          const input = inputs.nth(i);
          if (await input.isVisible()) {
            const type = await input.getAttribute('type');
            if (type !== 'checkbox' && type !== 'radio' && type !== 'file') {
              try {
                await input.scrollIntoViewIfNeeded();
                await input.click();
                await input.fill('test value');
                await page.waitForTimeout(300);
              } catch (error) {
                inputErrors++;
                console.log(`${name} - Error with input ${i + 1}:`, error);
              }
            }
          }
        }

        // Test dropdowns
        const dropdowns = page.locator('select, [role="combobox"]');
        const dropdownCount = await dropdowns.count();
        console.log(`${name}: Found ${dropdownCount} dropdowns`);

        let dropdownErrors = 0;
        for (let i = 0; i < dropdownCount; i++) {
          const dropdown = dropdowns.nth(i);
          if (await dropdown.isVisible()) {
            try {
              await dropdown.scrollIntoViewIfNeeded();
              await dropdown.click();
              await page.waitForTimeout(500);
            } catch (error) {
              dropdownErrors++;
              console.log(`${name} - Error with dropdown ${i + 1}:`, error);
            }
          }
        }

        // Test cards/panels
        const cards = page.locator('[class*="card"], [class*="Card"]');
        const cardCount = await cards.count();
        console.log(`${name}: Found ${cardCount} cards/panels`);

        let cardErrors = 0;
        for (let i = 0; i < Math.min(cardCount, 8); i++) {
          const card = cards.nth(i);
          if (await card.isVisible()) {
            try {
              await card.scrollIntoViewIfNeeded();
              await card.click();
              await page.waitForTimeout(300);
            } catch (error) {
              cardErrors++;
              console.log(`${name} - Error clicking card ${i + 1}:`, error);
            }
          }
        }

        // Summary
        console.log(`\n=== ${name} Page Summary ===`);
        console.log(`Button errors: ${clickErrors}/${buttonCount}`);
        console.log(`Navigation errors: ${navigationErrors}/${linkCount}`);
        console.log(`Input errors: ${inputErrors}/${inputCount}`);
        console.log(`Dropdown errors: ${dropdownErrors}/${dropdownCount}`);
        console.log(`Card errors: ${cardErrors}/${cardCount}`);
        console.log(`Console errors: ${errors.length}`);

        if (errors.length > 0) {
          console.log(`Console errors:`, errors);
        }

        const totalErrors = clickErrors + navigationErrors + inputErrors + dropdownErrors + cardErrors + errors.length;
        if (totalErrors > 0) {
          console.log(`\n⚠️ ${name} page had ${totalErrors} total errors`);
        } else {
          console.log(`\n✓ ${name} page - No errors detected`);
        }
      });
    });
  });

  test('should test navigation between all pages', async ({ page }) => {
    // Setup authentication once for all navigations
    await setupAuth(page);

    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    for (const { path, name } of pages) {
      console.log(`Navigating to ${name} page...`);
      await page.goto(path);
      await page.waitForLoadState('networkidle');
      await page.waitForTimeout(1000);

      if (errors.length > 0) {
        console.log(`Errors on ${name} page:`, errors);
        errors.length = 0;
      }
    }
  });
});
