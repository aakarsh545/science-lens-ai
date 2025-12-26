import { test, expect } from '@playwright/test';

/**
 * Dialog Overlay Tests
 * Tests to verify that dialog overlays properly manage pointer events
 * and don't block interactions when closed.
 */
test.describe('Dialog Overlay Pointer Events', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to a page that uses dialogs
    await page.goto('/science-lens');
    await page.waitForLoadState('networkidle');
  });

  test('should not block clicks when dialog is closed', async ({ page }) => {
    // Track console for pointer event warnings
    const consoleMessages: string[] = [];
    page.on('console', msg => {
      consoleMessages.push(msg.text());
    });

    // Try to interact with navigation elements (should work fine with no dialog open)
    const navButtons = page.locator('button, a').filter({ hasText: /home|learning|ask|settings/i });

    const count = await navButtons.count();
    if (count > 0) {
      for (let i = 0; i < Math.min(count, 3); i++) {
        const button = navButtons.nth(i);
        if (await button.isVisible()) {
          await button.scrollIntoViewIfNeeded();
          await button.click();
          await page.waitForTimeout(500);

          // Verify no pointer event blocking warnings
          const pointerWarnings = consoleMessages.filter(msg =>
            msg.includes('intercepts pointer events') ||
            msg.includes('pointer-events') ||
            msg.includes('DialogOverlay')
          );

          // Navigate back if we moved to a different page
          if (page.url() !== page.url()) {
            await page.goBack();
            await page.waitForLoadState('networkidle');
          }

          // Should not have warnings about blocking
          expect(pointerWarnings.filter(w => w.includes('intercepts pointer events'))).toHaveLength(0);
        }
      }
    }
  });

  test('should properly handle dialog open and close states', async ({ page }) => {
    // Open authentication dialog (if available on the page)
    const signInButton = page.getByRole('button', { name: /sign in|login/i }).first();

    if (await signInButton.isVisible()) {
      // Open dialog
      await signInButton.click();
      await page.waitForTimeout(500);

      // Dialog should be visible
      const dialog = page.locator('[role="dialog"]').first();
      await expect(dialog).toBeVisible();

      // Check for overlay
      const overlay = page.locator('[data-state="open"]').filter({ hasText: /^$/ });
      const overlayCount = await overlay.count();

      if (overlayCount > 0) {
        // Overlay should be present when dialog is open
        await expect(overlay.first()).toBeVisible();

        // Close dialog
        const closeButton = page.locator('[aria-label="Close"], button[data-state="open"]').first();
        if (await closeButton.isVisible()) {
          await closeButton.click();
          await page.waitForTimeout(500);

          // Dialog should be closed
          await expect(dialog).not.toBeVisible();

          // Verify we can click other elements after dialog closes
          const otherButton = page.locator('button').filter({ hasText: /home|learning/i }).first();
          if (await otherButton.isVisible()) {
            await otherButton.click();
            await page.waitForTimeout(300);
            // Should navigate without issues
            expect(page.url()).toContain('/science-lens');
          }
        }
      }
    }
  });

  test('should not have overlay elements blocking interactions', async ({ page }) => {
    // Check for any overlay elements that might be blocking
    const overlays = page.locator('[data-state="closed"]');

    const count = await overlays.count();

    for (let i = 0; i < count; i++) {
      const overlay = overlays.nth(i);

      // Get computed styles
      const pointerEvents = await overlay.evaluate(el =>
        window.getComputedStyle(el).pointerEvents
      );

      // Closed overlays should have pointer-events: none
      if (pointerEvents !== 'none') {
        console.log(`Warning: Overlay at index ${i} has pointer-events: ${pointerEvents} when data-state="closed"`);
      }

      // Ensure pointer-events is 'none' for closed state
      expect(pointerEvents).toBe('none');
    }
  });

  test('should handle rapid dialog open/close without blocking', async ({ page }) => {
    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // Find any trigger buttons
    const triggers = page.locator('button').filter({ hasText: /sign in|login|menu|settings/i });

    const triggerCount = await triggers.count();
    if (triggerCount > 0) {
      const trigger = triggers.first();

      // Rapidly open and close multiple times
      for (let i = 0; i < 3; i++) {
        if (await trigger.isVisible()) {
          await trigger.click();
          await page.waitForTimeout(200);

          // Try to close if dialog opened
          const closeButton = page.locator('[aria-label="Close"], [data-state="open"]').first();
          if (await closeButton.isVisible()) {
            await closeButton.click();
            await page.waitForTimeout(200);
          }
        }
      }

      // Should not have pointer event blocking errors
      const blockingErrors = errors.filter(e =>
        e.includes('intercepts pointer events') ||
        e.includes('pointer-events') && e.includes('block')
      );

      expect(blockingErrors).toHaveLength(0);
    }
  });

  test('should verify z-index hierarchy does not interfere', async ({ page }) => {
    // Get all closed overlays
    const closedOverlays = page.locator('[data-state="closed"]');
    const count = await closedOverlays.count();

    for (let i = 0; i < Math.min(count, 5); i++) {
      const overlay = closedOverlays.nth(i);

      // Check that closed overlays don't block clicks
      const isVisible = await overlay.isVisible();
      const pointerEvents = await overlay.evaluate(el =>
        window.getComputedStyle(el).pointerEvents
      );

      if (isVisible && pointerEvents !== 'none') {
        const zIndex = await overlay.evaluate(el =>
          window.getComputedStyle(el).zIndex
        );

        console.log(`Warning: Visible closed overlay at index ${i} has z-index: ${zIndex} and pointer-events: ${pointerEvents}`);

        // Even with high z-index, pointer-events: none should prevent blocking
        expect(pointerEvents).toBe('none');
      }
    }

    // Try clicking through where closed overlays would be
    const clickableElements = page.locator('button, a, input').filter({ isVisible: true });
    const elementCount = await clickableElements.count();

    let blockedClicks = 0;
    for (let i = 0; i < Math.min(elementCount, 5); i++) {
      const element = clickableElements.nth(i);
      try {
        await element.scrollIntoViewIfNeeded();
        await element.click({ timeout: 1000 });
        await page.waitForTimeout(200);

        // Go back if navigation occurred
        if (page.url().includes('/science-lens/') && !page.url().endsWith('/science-lens')) {
          await page.goto('/science-lens');
          await page.waitForLoadState('networkidle');
        }
      } catch (error) {
        blockedClicks++;
      }
    }

    // Should be able to click elements without being blocked
    expect(blockedClicks).toBe(0);
  });
});
