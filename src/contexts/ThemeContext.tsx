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
  equipTheme: (themeId: string) => Promise<boolean>;
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
      // Load equipped theme with shop item details
      const { data, error } = await supabase
        .from('profiles')
        .select(`
          equipped_theme,
          shop_items!equipped_theme (
            id,
            name,
            metadata
          )
        `)
        .eq('user_id', userId)
        .single();

      if (error) throw error;

      // If user has equipped theme, load it
      if (data?.equipped_theme && data.shop_items) {
        const shopItem = data.shop_items as any;
        const metadata = shopItem.metadata as any;

        console.log('[ThemeContext] Loading equipped theme:', shopItem.name, metadata);

        // Use parseThemeConfig to get appropriate visual effects based on theme name
        const baseConfig = parseThemeConfig(shopItem);

        // Override with exact colors from metadata
        const config: ThemeConfig = {
          ...baseConfig,
          palette: {
            primary: metadata.primary || '#3b82f6',
            secondary: metadata.secondary || '#1e40af',
            accent: metadata.accent || '#60a5fa',
            surface: metadata.background || '#0f172a',
            background: metadata.background || '#0f172a',
            text: {
              primary: metadata.text || '#f1f5f9',
              secondary: metadata.text || '#f1f5f9',
              muted: '#94a3b8',
            }
          }
        };

        const loadedTheme: Theme = {
          id: shopItem.id,
          name: shopItem.name,
          config
        };

        setTheme(loadedTheme);
        const tokens = generateThemeTokens(config);
        applyThemeTokens(tokens);
      } else {
        // No equipped theme, use default
        setTheme(DEFAULT_THEME);
        const tokens = generateThemeTokens(DEFAULT_THEME.config);
        applyThemeTokens(tokens);
      }
    } catch (error) {
      console.error('[ThemeContext] Error loading theme:', error);
      setTheme(DEFAULT_THEME);
      const tokens = generateThemeTokens(DEFAULT_THEME.config);
      applyThemeTokens(tokens);
    } finally {
      setLoading(false);
    }
  };

  const equipTheme = async (themeId: string): Promise<boolean> => {
    try {
      const { error } = await supabase
        .from('profiles')
        .update({ equipped_theme: themeId })
        .eq('user_id', userId);

      if (error) throw error;

      // Reload theme after equipping
      await loadTheme();
      return true;
    } catch (error) {
      console.error('[ThemeContext] Error equipping theme:', error);
      return false;
    }
  };

  const refreshTheme = async () => {
    await loadTheme();
  };

  useEffect(() => {
    loadTheme();
  }, [userId]);

  return (
    <ThemeContext.Provider value={{ theme, loading, refreshTheme, equipTheme }}>
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
