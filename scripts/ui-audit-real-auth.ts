import fs from 'fs';
import path from 'path';
import { chromium, type ConsoleMessage, type Request, type Response } from 'playwright';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

type RouteAudit = {
  route: string;
  url: string;
  screenshotPath: string;
  consoleErrors: string[];
  pageErrors: string[];
  requestFailures: string[];
  responseFailures: string[];
  layoutIssues: string[];
  emptyOrBlank: boolean;
  rootMissing: boolean;
  deadButtons: string[];
};

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

const baseUrl = process.env.PLAYWRIGHT_BASE_URL || 'http://127.0.0.1:8080';
const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseAnonKey = process.env.VITE_SUPABASE_PUBLISHABLE_KEY || process.env.SUPABASE_ANON_KEY;
const email = process.env.TEST_ACCOUNT_EMAIL;
const password = process.env.TEST_ACCOUNT_PASSWORD;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase env vars: VITE_SUPABASE_URL / VITE_SUPABASE_PUBLISHABLE_KEY (or SUPABASE_ANON_KEY).');
}
if (!email || !password) {
  throw new Error('Missing TEST_ACCOUNT_EMAIL or TEST_ACCOUNT_PASSWORD environment variables.');
}

const projectRef = new URL(supabaseUrl).hostname.split('.')[0];
const storageKey = `sb-${projectRef}-auth-token`;

const artifactsDir = path.resolve('test-results', 'ui-audit-live');
fs.mkdirSync(artifactsDir, { recursive: true });

function safeName(route: string): string {
  return route === '/' ? 'home' : route.replace(/\//g, '_').replace(/^_+/, '');
}

function parseConsoleError(msg: ConsoleMessage): string {
  const location = msg.location();
  const locationText = location.url ? ` @ ${location.url}:${location.lineNumber}:${location.columnNumber}` : '';
  return `${msg.text()}${locationText}`;
}

function parseRequestFailure(req: Request): string {
  const failure = req.failure();
  if (!failure) return req.url();
  return `${failure.errorText} ${req.method()} ${req.url()}`;
}

function parseResponseFailure(res: Response): string {
  return `${res.status()} ${res.request().method()} ${res.url()}`;
}

async function detectDeadButtons(page: import('playwright').Page): Promise<string[]> {
  return page.evaluate(() => {
    const issues: string[] = [];
    const buttons = Array.from(document.querySelectorAll('button, [role="button"], a')) as HTMLElement[];

    for (const el of buttons) {
      const text = (el.textContent || '').trim().slice(0, 80) || '<no text>';
      const hidden = el.offsetParent === null;
      if (hidden) continue;

      if (el.tagName === 'A') {
        const href = (el as HTMLAnchorElement).getAttribute('href');
        if (href === '#' || href === 'javascript:void(0)' || href === 'javascript:;') {
          issues.push(`Dead anchor href on visible link: ${text}`);
        }
      }
    }

    return issues;
  });
}

async function run() {
  const supabase = createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
      detectSessionInUrl: false,
    },
  });

  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error || !data.session) {
    throw new Error(`Supabase signInWithPassword failed: ${error?.message || 'No session returned'}`);
  }

  const session = data.session;
  const user = session.user;
  const userScopedOnboardingKey = `hasSeenOnboarding_${user.id}`;
  const userScopedIntroKey = `hasSeenIntro_${user.id}`;

  const browser = await chromium.launch({ headless: true });

  const jobs = routes.map(async (route, index) => {
    const context = await browser.newContext({
      baseURL: baseUrl,
      viewport: { width: 1440, height: 900 },
      storageState: {
        cookies: [],
        origins: [
          {
            origin: baseUrl,
            localStorage: [
              { name: storageKey, value: JSON.stringify(session) },
              { name: `${storageKey}-user`, value: JSON.stringify({ user }) },
              { name: 'hasSeenOnboarding', value: 'true' },
              { name: 'hasSeenIntro', value: 'true' },
              { name: userScopedOnboardingKey, value: 'true' },
              { name: userScopedIntroKey, value: 'true' },
            ],
          },
        ],
      },
    });

    const page = await context.newPage();
    const consoleErrors: string[] = [];
    const pageErrors: string[] = [];
    const requestFailures: string[] = [];
    const responseFailures: string[] = [];
    const layoutIssues: string[] = [];

    page.on('console', (msg) => {
      if (msg.type() === 'error') {
        consoleErrors.push(parseConsoleError(msg));
      }
    });

    page.on('pageerror', (err) => {
      pageErrors.push(err.message);
    });

    page.on('requestfailed', (req) => {
      requestFailures.push(parseRequestFailure(req));
    });

    page.on('response', (res) => {
      if (res.status() >= 400) {
        responseFailures.push(parseResponseFailure(res));
      }
    });

    const target = route;
    await page.goto(target, { waitUntil: 'networkidle', timeout: 90000 });

    await page.waitForTimeout(1200);

    const rootExists = await page.$('#root');
    const rootMissing = !rootExists;

    const layoutCheck = await page.evaluate(() => {
      const root = document.getElementById('root');
      const body = document.body;
      const html = document.documentElement;
      const scrollWidth = Math.max(body.scrollWidth, html.scrollWidth);
      const clientWidth = html.clientWidth;
      const horizontalOverflow = scrollWidth > clientWidth + 1;
      const text = (root?.innerText || '').trim();
      const hasText = text.length > 0;
      const rootChildren = root ? root.children.length : 0;
      const bodyTextLength = (body.innerText || '').trim().length;

      const loadingText = /loading|please wait/i.test(body.innerText || '');

      return {
        horizontalOverflow,
        hasText,
        rootChildren,
        bodyTextLength,
        loadingText,
      };
    });

    if (layoutCheck.horizontalOverflow) {
      layoutIssues.push('Horizontal overflow detected (scrollWidth > clientWidth).');
    }

    if (layoutCheck.loadingText) {
      layoutIssues.push('Page appears stuck in loading state.');
    }

    const deadButtons = await detectDeadButtons(page);
    const emptyOrBlank = (!layoutCheck.hasText && layoutCheck.rootChildren === 0) || layoutCheck.bodyTextLength === 0;

    const screenshotPath = path.join(
      artifactsDir,
      `${String(index + 1).padStart(2, '0')}-${safeName(route)}.png`,
    );

    await page.screenshot({ path: screenshotPath, fullPage: true });

    const report: RouteAudit = {
      route,
      url: page.url(),
      screenshotPath,
      consoleErrors,
      pageErrors,
      requestFailures,
      responseFailures,
      layoutIssues,
      emptyOrBlank,
      rootMissing,
      deadButtons,
    };

    await context.close();
    return report;
  });

  const results = await Promise.all(jobs);
  const reportPath = path.join(artifactsDir, 'ui-audit-live-report.json');
  fs.writeFileSync(reportPath, JSON.stringify(results, null, 2));

  const summary = {
    routeCount: results.length,
    routesWithConsoleErrors: results.filter((r) => r.consoleErrors.length > 0).length,
    routesWithRequestFailures: results.filter((r) => r.requestFailures.length > 0 || r.responseFailures.length > 0).length,
    routesWithPageErrors: results.filter((r) => r.pageErrors.length > 0).length,
    routesWithLayoutIssues: results.filter((r) => r.layoutIssues.length > 0 || r.emptyOrBlank || r.rootMissing).length,
    routesWithDeadButtons: results.filter((r) => r.deadButtons.length > 0).length,
    reportPath,
  };

  fs.writeFileSync(path.join(artifactsDir, 'ui-audit-live-summary.json'), JSON.stringify(summary, null, 2));

  await browser.close();
  await supabase.auth.signOut();

  console.log(JSON.stringify(summary, null, 2));
}

run().catch((error) => {
  console.error(error);
  process.exit(1);
});
