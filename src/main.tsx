import { createRoot } from "react-dom/client";
import App from "./App.tsx";
import "./index.css";
import { StrictMode } from "react";

// Debug: Log that main.tsx is executing
console.log('[MAIN] main.tsx loaded successfully');

// Debug: Log ALL environment variables
console.log('[MAIN] All import.meta.env keys:', Object.keys(import.meta.env));
console.log('[MAIN] Environment Check:', {
  VITE_SUPABASE_URL: import.meta.env.VITE_SUPABASE_URL ? 'SET' : 'MISSING',
  VITE_SUPABASE_PUBLISHABLE_KEY: import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY ? 'SET' : 'MISSING',
  VITE_BASEPATH: import.meta.env.VITE_BASEPATH || 'undefined',
  MODE: import.meta.env.MODE,
  DEV: import.meta.env.DEV,
  PROD: import.meta.env.PROD,
});

// Test if root element exists
const rootElement = document.getElementById("root");
console.log('[MAIN] Root element:', rootElement);
if (!rootElement) {
  console.error('[MAIN] CRITICAL: #root element not found!');
  document.body.innerHTML = '<div style="color:white;padding:20px;">ERROR: #root element not found</div>';
} else {
  console.log('[MAIN] Root element found, dimensions:', rootElement.clientWidth, 'x', rootElement.clientHeight);
}

// Global error handlers (in addition to early listeners)
window.addEventListener('error', (e) => {
  console.error('[MAIN ERROR]', e.message, e.error, e.filename);
});

window.addEventListener('unhandledrejection', (e) => {
  console.error('[MAIN UNHANDLED]', e.reason);
});

if (rootElement) {
  try {
    console.log('[MAIN] About to create React root...');
    const root = createRoot(rootElement);
    console.log('[MAIN] React root created, about to render App...');
    root.render(
      <StrictMode>
        <App />
      </StrictMode>
    );
    console.log('[MAIN] App rendered successfully!');
  } catch (error) {
    console.error('[MAIN CRITICAL] Failed to render app:', error);
    rootElement.innerHTML = `
      <div style="padding: 40px; color: white; font-family: sans-serif; background: #1a1a1a;">
        <h1 style="color: #ff6b6b;">Application Error</h1>
        <details>
          <summary style="cursor: pointer; padding: 10px; background: #333; margin: 10px 0;">
            Click to view error details
          </summary>
          <pre style="padding: 20px; background: #2a2a2a; overflow: auto; white-space: pre-wrap;">
${JSON.stringify(error, null, 2)}
          </pre>
        </details>
        <p style="margin-top: 20px;">Check browser console for more details.</p>
      </div>
    `;
  }
}
