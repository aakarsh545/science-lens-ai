import { createContext, useContext, useEffect, ReactNode } from "react";

interface ThemeContextType {
  theme: string;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

// Default dark theme tokens
const DEFAULT_DARK_THEME = {
  '--color-primary': '#6366f1',
  '--color-secondary': '#8b5cf6',
  '--color-accent': '#ec4899',
  '--color-surface': '#1e293b',
  '--color-background': '#0f172a',
  '--color-text-primary': '#f1f5f9',
  '--color-text-secondary': '#cbd5e1',
  '--color-text-muted': '#94a3b8',
  '--color-primary-hover': '#818cf8',
  '--color-accent-hover': '#f472b6',
  '--color-border': '#334155',
  '--color-border-subtle': '#1e293b',
  '--color-card': '#1e293b',
  '--color-card-hover': '#334155',
  '--color-popover': '#1e293b',
  '--color-muted': '#1e293b',
  '--color-input': '#1e293b',
  '--glow-primary': 'rgba(99, 102, 241, 0.5)',
  '--glow-accent': 'rgba(236, 72, 153, 0.5)',
  '--gradient-primary': 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
  '--gradient-surface': 'linear-gradient(135deg, #1e293b 0%, #0f172a 100%)',
  '--decoration-type': 'cosmic',
  '--particle-intensity': 'subtle',
  '--animation-speed': 'gentle',
  '--bg-decoration': 'enabled',
};

/**
 * Apply default dark theme tokens to DOM
 */
function applyDefaultTheme() {
  const root = document.documentElement;

  Object.entries(DEFAULT_DARK_THEME).forEach(([key, value]) => {
    try {
      root.style.setProperty(key, value);
    } catch (error) {
      console.warn(`[ThemeContext] Failed to set CSS variable ${key}:`, error);
    }
  });

  console.log('[ThemeContext] Applied default dark theme');
}

export function ThemeProvider({ children, userId }: { children: ReactNode; userId: string }) {
  useEffect(() => {
    // Apply default dark theme on mount
    applyDefaultTheme();
  }, [userId]);

  return (
    <ThemeContext.Provider value={{ theme: 'dark' }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error("useTheme must be used within a ThemeProvider");
  }
  return context;
}
