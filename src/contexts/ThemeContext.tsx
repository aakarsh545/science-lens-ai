import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { supabase } from "@/integrations/supabase/client";
import { generateThemeTokens, parseThemeConfig, ThemeConfig } from "@/utils/themeTokens";

interface Theme {
  id: string;
  name: string;
  config: ThemeConfig;
}

interface ThemeContextType {
  theme: Theme | null;
  loading: boolean;
  refreshTheme: () => Promise<void>;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

const DEFAULT_THEME: Theme = {
  id: 'default',
  name: 'Default',
  config: {
    palette: {
      primary: '#3b82f6',
      secondary: '#1e40af',
      accent: '#60a5fa',
      surface: '#0f172a',
      background: '#0f172a',
      text: {
        primary: '#f1f5f9',
        secondary: '#f1f5f9',
        muted: '#94a3b8',
      }
    },
    appearance: {
      mode: 'dark',
      contrast: 'medium',
      glow: 'subtle',
      blur: 8,
      rounding: 1
    },
    effects: {
      decoration: 'cosmic',
      particles: 'subtle',
      animation: 'gentle'
    },
    tags: []
  }
};

/**
 * Apply generated theme tokens to DOM
 * This is the ONLY place that applies theme values
 */
function applyThemeTokens(tokens: Record<string, string>) {
  const root = document.documentElement;

  // Clear any existing body styles
  document.body.style.cssText = '';

  // Apply all tokens
  Object.entries(tokens).forEach(([key, value]) => {
    root.style.setProperty(key, value);
  });
}

export function ThemeProvider({ children, userId }: { children: ReactNode; userId: string }) {
  const [theme, setTheme] = useState<Theme>(DEFAULT_THEME);
  const [loading, setLoading] = useState(true);

  const loadTheme = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('avatar_url')
        .eq('user_id', userId)
        .single();

      if (error) throw error;

      // No equipped_theme/shop_items - use default theme
      setTheme(DEFAULT_THEME);
      const tokens = generateThemeTokens(DEFAULT_THEME.config);
      applyThemeTokens(tokens);
    } catch (error) {
      console.error('[ThemeContext] Error loading theme:', error);
      setTheme(DEFAULT_THEME);
      const tokens = generateThemeTokens(DEFAULT_THEME.config);
      applyThemeTokens(tokens);
    } finally {
      setLoading(false);
    }
  };

  const refreshTheme = async () => {
    await loadTheme();
  };

  useEffect(() => {
    loadTheme();
  }, [userId]);

  return (
    <ThemeContext.Provider value={{ theme, loading, refreshTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
}
