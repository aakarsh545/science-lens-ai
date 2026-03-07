import { test } from '@playwright/test';
import { setupAuth } from './helpers/auth';

test('auth debug', async ({ page }) => {
  await setupAuth(page);
  const storageKey = await page.evaluate(() => localStorage.getItem('playwright_test_user'));
  console.log('storageKey in test:', storageKey ? 'SET' : 'MISSING');
  await page.goto('/dashboard?playwright=1');
  await page.waitForLoadState('networkidle');
  const urlAfter = page.url();
  console.log('url after dashboard nav:', urlAfter);
  if (urlAfter === 'http://localhost:8080/') {
    await page.goto('/dashboard?playwright=1');
    await page.waitForLoadState('networkidle');
    console.log('url after second nav:', page.url());
  }
  const sessionCheck = await page.evaluate(async () => {
    try {
      // @ts-ignore
      return await window.__supabase?.auth?.getSession?.();
    } catch (e) {
      return { error: String(e) };
    }
  });
  console.log('sessionCheck', sessionCheck);
  const sessionStorage = await page.evaluate(() => {
    const keys = Object.keys(sessionStorage);
    const snapshot: Record<string, string | null> = {};
    keys.forEach(k => snapshot[k] = sessionStorage.getItem(k));
    return snapshot;
  });
  console.log('sessionStorage', sessionStorage);
  const rawAuthToken = await page.evaluate(() => {
    const keys = Object.keys(localStorage).filter(k => k.startsWith('sb-') || k.includes('supabase'));
    const snapshot: Record<string, string | null> = {};
    keys.forEach(k => snapshot[k] = localStorage.getItem(k));
    return snapshot;
  });
  console.log('auth storage keys', rawAuthToken);
  const supabaseInfo = await page.evaluate(() => {
    // @ts-ignore
    return {
      supabaseUrl: window.__supabase?.supabaseUrl || null,
      storageKey: window.__supabase?.auth?.storageKey || null,
    };
  });
  console.log('supabaseInfo', supabaseInfo);
  const hasSidebar = await page.$('[data-sidebar=sidebar]');
  console.log('hasSidebar', !!hasSidebar);
});
