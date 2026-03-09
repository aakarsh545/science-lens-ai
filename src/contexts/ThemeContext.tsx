import { createContext, useContext, useEffect, ReactNode } from "react";

interface ThemeContextType {
  theme: string;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

// Default dark theme tokens - variable names match what index.css expects
const DEFAULT_DARK_THEME = {
  '--primary': '212 100% 60%',
  '--secondary': '263 85% 70%',
  '--accent': '189 94% 43%',
  '--background': '225 39% 8%',
  '--surface': '225 39% 12%',
  '--text-primary': '210 40% 98%',
  '--text-secondary': '215 20.2% 65.1%',
  '--text-muted': '215 20.2% 65.1%',
  '--primary-hover': '212 100% 50%',
  '--accent-hover': '189 94% 33%',
  '--border': '225 39% 24%',
  '--card': '225 39% 12%',
  '--card-hover': '225 39% 16%',
  '--card-foreground': '210 40% 98%',
  '--popover': '225 39% 12%',
  '--popover-foreground': '210 40% 98%',
  '--muted': '225 39% 20%',
  '--muted-foreground': '215 20.2% 65.1%',
  '--input': '225 39% 16%',
  '--input-focus': '225 39% 20%',
  '--button-bg': '212 100% 60%',
  '--button-foreground': '0 0% 98%',
  '--button-secondary-bg': '189 94% 43%',
  '--button-secondary-foreground': '0 0% 98%',
  '--button-border': '255 255 255',
  '--button-border-hover': '229 229 229',
  '--secondary-hover': '263 85% 60%',
  '--hover-accent': '189 100% 70%',
  '--border-accent': '189 100% 70%',
  '--glow-primary': '0 0 20px hsla(212, 100%, 60%, 0.2)',
  '--glow-accent': '0 0 20px hsla(189, 100%, 70%, 0.2)',
  '--glow-strong': '0 0 30px hsla(189, 100%, 70%, 0.4)',
  '--gradient-primary': 'linear-gradient(135deg, hsla(212, 100%, 60%, 0.9), hsla(263, 85%, 70%, 0.9))',
  '--gradient-surface': 'linear-gradient(180deg, hsla(225, 39%, 8%, 1), hsla(225, 39%, 12%, 1))',
  '--shadow-sm': '0 1px 2px 0 hsla(0, 0%, 0%, 0.4)',
  '--shadow-md': '0 4px 6px -1px hsla(0, 0%, 0%, 0.4), 0 2px 4px -1px hsla(0, 0%, 0%, 0.3)',
  '--shadow-lg': '0 16px 16px -5px hsla(0, 0%, 0%, 0.4)',
  '--decoration-type': 'cosmic',
  '--particle-intensity': 'subtle',
  '--animation-speed': '3s',
  '--bg-decoration': 'none',
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
}

export function ThemeProvider({ children, userId }: { children: ReactNode; userId?: string }) {
  useEffect(() => {
    // Apply default dark theme on mount
    applyDefaultTheme();
  }, []);

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
