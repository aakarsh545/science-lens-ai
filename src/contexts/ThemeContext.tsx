import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { supabase } from "@/integrations/supabase/client";

interface ThemeColors {
  primary: string;
  secondary: string;
  background: string;
  text: string;
  accent: string;
  gradientColors?: string[];
}

interface Theme {
  id: string;
  name: string;
  colors: ThemeColors;
}

interface ThemeContextType {
  theme: Theme | null;
  loading: boolean;
  refreshTheme: () => Promise<void>;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

const DEFAULT_THEME: Theme = {
  id: 'default',
  name: 'Default Blue',
  colors: {
    primary: '#3b82f6',
    secondary: '#1e40af',
    background: '#0f172a',
    text: '#f1f5f9',
    accent: '#60a5fa',
  }
};

export function ThemeProvider({ children, userId }: { children: ReactNode; userId: string }) {
  const [theme, setTheme] = useState<Theme>(DEFAULT_THEME);
  const [loading, setLoading] = useState(true);

  const loadTheme = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('equipped_theme')
        .eq('user_id', userId)
        .single();

      if (error) throw error;

      if (data?.equipped_theme) {
        // Fetch the theme details from shop_items
        const { data: themeData, error: themeError } = await supabase
          .from('shop_items')
          .select('*')
          .eq('id', data.equipped_theme)
          .eq('type', 'theme')
          .single();

        if (!themeError && themeData) {
          const newTheme: Theme = {
            id: themeData.id,
            name: themeData.name,
            colors: {
              primary: themeData.metadata.primary || DEFAULT_THEME.colors.primary,
              secondary: themeData.metadata.secondary || DEFAULT_THEME.colors.secondary,
              background: themeData.metadata.background || DEFAULT_THEME.colors.background,
              text: themeData.metadata.text || DEFAULT_THEME.colors.text,
              accent: themeData.metadata.accent || DEFAULT_THEME.colors.accent,
              gradientColors: themeData.metadata.gradientColors,
            }
          };
          setTheme(newTheme);
          applyThemeToDOM(newTheme.colors);
        }
      } else {
        // No theme equipped, use default
        setTheme(DEFAULT_THEME);
        applyThemeToDOM(DEFAULT_THEME.colors);
      }
    } catch (error) {
      console.error('[ThemeContext] Error loading theme:', error);
      setTheme(DEFAULT_THEME);
      applyThemeToDOM(DEFAULT_THEME.colors);
    } finally {
      setLoading(false);
    }
  };

  const applyThemeToDOM = (colors: ThemeColors) => {
    const root = document.documentElement;

    // Set CSS custom properties
    root.style.setProperty('--theme-primary', colors.primary);
    root.style.setProperty('--theme-secondary', colors.secondary);
    root.style.setProperty('--theme-background', colors.background);
    root.style.setProperty('--theme-text', colors.text);
    root.style.setProperty('--theme-accent', colors.accent);

    // Apply background gradient if theme has gradient colors
    if (colors.gradientColors && colors.gradientColors.length > 0) {
      root.style.setProperty(
        '--theme-gradient',
        `linear-gradient(135deg, ${colors.gradientColors.join(', ')})`
      );
    } else {
      root.style.setProperty('--theme-gradient', colors.background);
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
