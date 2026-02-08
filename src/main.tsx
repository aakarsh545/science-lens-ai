import { createRoot } from "react-dom/client";
import App from "./App.tsx";
import "./index.css";

// Debug: Log environment variables
console.log('[DEBUG] Environment Check:', {
  VITE_SUPABASE_URL: import.meta.env.VITE_SUPABASE_URL ? 'SET' : 'MISSING',
  VITE_SUPABASE_PUBLISHABLE_KEY: import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY ? 'SET' : 'MISSING',
  VITE_BASEPATH: import.meta.env.VITE_BASEPATH || 'undefined',
  NODE_ENV: import.meta.env.NODE_ENV,
  MODE: import.meta.env.MODE,
});

// Global error handlers
window.addEventListener('error', (e) => {
  console.error('[GLOBAL ERROR]', e.message, e.error);
});

window.addEventListener('unhandledrejection', (e) => {
  console.error('[UNHANDLED PROMISE REJECTION]', e.reason);
});

try {
  const root = createRoot(document.getElementById("root")!);
  root.render(<App />);
  console.log('[DEBUG] App rendered successfully');
} catch (error) {
  console.error('[CRITICAL] Failed to render app:', error);
  document.getElementById("root")!.innerHTML = `
    <div style="padding: 20px; color: white; font-family: sans-serif;">
      <h1>Application Error</h1>
      <pre>${error}</pre>
    </div>
  `;
}
