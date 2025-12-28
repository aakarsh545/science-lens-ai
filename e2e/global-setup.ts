import { FullConfig } from '@playwright/test';

async function globalSetup(config: FullConfig) {
  // Set environment variables for all projects
  process.env.VITE_PLAYWRIGHT_TEST = 'true';
}

export default globalSetup;
