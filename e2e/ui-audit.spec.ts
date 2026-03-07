import { test } from '@playwright/test';
import { setupAuth, gotoAuthenticatedPage } from './helpers/auth';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const routes = [
  '/',
  '/dashboard',
  '/learning',
  '/challenges',
  '/leaderboard',
  '/ask',
  '/shop',
  '/profile',
  '/achievements',
  '/settings',
  '/settings/account',
  '/billing',
] as const;

type RouteAudit = {
  route: string;
  url: string;
  consoleErrors: string[];
  requestFailures: string[];
  pageErrors: string[];
  layoutIssues: string[];
  emptyOrBlank: boolean;
  rootMissing: boolean;
  screenshotPath: string;
};

function ensureDir(dir: string) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const artifactsDir = path.resolve(__dirname, '..', 'test-results', 'ui-audit');
ensureDir(artifactsDir);

async function auditRoute(page: import('@playwright/test').Page, pageRoute: typeof routes[number], pageIndex: number): Promise<RouteAudit> {
  const consoleErrors: string[] = [];
  const requestFailures: string[] = [];
  const responseFailures: string[] = [];
  const pageErrors: string[] = [];
  const layoutIssues: string[] = [];

  page.on('console', (msg) => {
    if (msg.type() === 'error') {
      consoleErrors.push(msg.text());
    }
  });

  page.on('pageerror', (err) => {
    pageErrors.push(err.message);
  });

  page.on('requestfailed', (request) => {
    const failure = request.failure();
    const text = failure ? `${failure.errorText} ${request.url()}` : request.url();
    requestFailures.push(text);
  });

  page.on('response', (response) => {
    if (response.status() >= 400) {
      responseFailures.push(`${response.status()} ${response.url()}`);
    }
  });

  await setupAuth(page);
  const storageTest = await page.evaluate(() => localStorage.getItem('playwright_test_user'));
  console.log('auditRoute storage:', storageTest ? 'SET' : 'MISSING');
  if (pageRoute === '/') {
    await page.goto('/?playwright=1');
    await page.waitForLoadState('networkidle');
  } else {
    await gotoAuthenticatedPage(page, pageRoute);
  }

  // Wait for root and basic render
  const rootHandle = await page.$('#root');
  const rootMissing = !rootHandle;

  // Heuristic layout checks
  const layoutCheck = await page.evaluate(() => {
    const root = document.getElementById('root');
    const body = document.body;
    const html = document.documentElement;

    const scrollWidth = Math.max(body.scrollWidth, html.scrollWidth);
    const clientWidth = html.clientWidth;
    const horizontalOverflow = scrollWidth > clientWidth + 1;

    const scrollHeight = Math.max(body.scrollHeight, html.scrollHeight);
    const clientHeight = html.clientHeight;
    const verticalOverflow = scrollHeight > clientHeight + 1;

    const text = (root?.innerText || '').trim();
    const hasText = text.length > 0;

    const rootChildren = root ? root.children.length : 0;

    return {
      horizontalOverflow,
      verticalOverflow,
      hasText,
      rootChildren,
      bodyTextLength: (body.innerText || '').trim().length,
    };
  });

  if (layoutCheck.horizontalOverflow) {
    layoutIssues.push('Horizontal overflow detected (scrollWidth > clientWidth).');
  }

  const emptyOrBlank = (!layoutCheck.hasText && layoutCheck.rootChildren === 0) || layoutCheck.bodyTextLength === 0;

  const safeRouteName = pageRoute === '/' ? 'home' : pageRoute.replace(/\//g, '_').replace(/^_+/, '');
  const screenshotPath = path.join(artifactsDir, `${String(pageIndex).padStart(2, '0')}-${safeRouteName}.png`);
  await page.screenshot({ path: screenshotPath, fullPage: true });

  return {
    route: pageRoute,
    url: page.url(),
    consoleErrors,
    requestFailures,
    responseFailures,
    pageErrors,
    layoutIssues,
    emptyOrBlank,
    rootMissing,
    screenshotPath,
  };
}

test('UI audit screenshots and logs', async ({ page }) => {
  const results: RouteAudit[] = [];

  for (let i = 0; i < routes.length; i += 1) {
    const route = routes[i];
    const audit = await auditRoute(page, route, i + 1);
    results.push(audit);
  }

  const reportPath = path.join(artifactsDir, 'ui-audit-report.json');
  fs.writeFileSync(reportPath, JSON.stringify(results, null, 2));
  test.info().attachments.push({
    name: 'ui-audit-report',
    path: reportPath,
    contentType: 'application/json',
  });
});
