import { createContext, useContext, useEffect, useState, useRef, ReactNode } from "react";
import { motion, AnimatePresence } from "framer-motion";
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

// Cosmic default theme (matches the DB Cosmic theme colors)
const COSMIC_THEME: Theme = {
  id: 'cosmic-default',
  name: 'Cosmic',
  config: {
    palette: {
      primary: '#1a2c3d',
      secondary: '#2b3e50',
      accent: '#3c4f61',
      surface: '#0d1f30',
      background: '#0d1f30',
      text: {
        primary: '#4e6172',
        secondary: '#4e6172',
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

  // Apply all tokens with error handling
  Object.entries(tokens).forEach(([key, value]) => {
    try {
      root.style.setProperty(key, value);
    } catch (error) {
      console.warn(`[ThemeContext] Failed to set CSS variable ${key}:`, error);
    }
  });

  console.log('[ThemeContext] Applied theme tokens:', Object.keys(tokens).length, 'variables');
}

export function ThemeProvider({ children, userId }: { children: ReactNode; userId: string }) {
  const [theme, setTheme] = useState<Theme>(COSMIC_THEME);
  const [loading, setLoading] = useState(true);
  const hasLoadedForUser = useRef<Record<string, boolean>>({});

  const loadTheme = async () => {
    if (!userId) {
      console.warn('[ThemeContext] No userId provided, using Cosmic fallback');
      setTheme(COSMIC_THEME);
      const tokens = generateThemeTokens(COSMIC_THEME.config);
      applyThemeTokens(tokens);
      setLoading(false);
      return;
    }

    // Skip if already loaded for this user
    if (hasLoadedForUser.current[userId]) {
      console.log('[ThemeContext] Theme already loaded for user:', userId, 'skipping reload');
      return;
    }

    try {
      console.log('[ThemeContext] Loading theme for user:', userId);

      // Load equipped theme with shop item details using foreign key join
      const { data, error, status, statusText } = await supabase
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

      // Log detailed error information
      if (error) {
        console.error('[ThemeContext] Database error:', {
          message: error.message,
          details: error.details,
          hint: error.hint,
          code: error.code,
          status,
          statusText
        });
        throw error;
      }

      console.log('[ThemeContext] Profile data loaded:', {
        equipped_theme: data?.equipped_theme,
        shop_items_found: !!data?.shop_items,
        shop_item_name: (data?.shop_items as any)?.name
      });

      // If user has equipped theme and shop_items data exists
      if (data?.equipped_theme && data.shop_items) {
        const shopItem = data.shop_items as any;

        if (!shopItem || !shopItem.metadata) {
          console.warn('[ThemeContext] Shop item or metadata missing, using Cosmic fallback');
          setTheme(COSMIC_THEME);
          const tokens = generateThemeTokens(COSMIC_THEME.config);
          applyThemeTokens(tokens);
          setLoading(false);
          return;
        }

        console.log('[ThemeContext] Loading equipped theme:', shopItem.name, shopItem.metadata);

        try {
          // Use parseThemeConfig to parse all metadata (colors + mode + glow + decoration)
          const config = parseThemeConfig(shopItem);

          const loadedTheme: Theme = {
            id: shopItem.id,
            name: shopItem.name,
            config
          };

          setTheme(loadedTheme);
          const tokens = generateThemeTokens(config);
          applyThemeTokens(tokens);

          console.log('[ThemeContext] Successfully applied theme:', shopItem.name);
        } catch (parseError) {
          console.error('[ThemeContext] Error parsing theme config:', parseError);
          console.log('[ThemeContext] Falling back to Cosmic theme');
          setTheme(COSMIC_THEME);
          const tokens = generateThemeTokens(COSMIC_THEME.config);
          applyThemeTokens(tokens);
        }
      } else {
        // No equipped theme, use Cosmic default
        console.log('[ThemeContext] No equipped theme, using Cosmic default');
        setTheme(COSMIC_THEME);
        const tokens = generateThemeTokens(COSMIC_THEME.config);
        applyThemeTokens(tokens);
      }
    } catch (error) {
      console.error('[ThemeContext] Error loading theme:', error);
      console.log('[ThemeContext] Using Cosmic fallback theme');

      setTheme(COSMIC_THEME);
      const tokens = generateThemeTokens(COSMIC_THEME.config);
      applyThemeTokens(tokens);
    } finally {
      setLoading(false);
    }
  };

  const equipTheme = async (themeId: string): Promise<boolean> => {
    if (!userId) {
      console.error('[ThemeContext] Cannot equip theme: no userId');
      return false;
    }

    try {
      console.log('[ThemeContext] Equipping theme:', themeId);

      const { error, status, statusText } = await supabase
        .from('profiles')
        .update({ equipped_theme: themeId })
        .eq('user_id', userId);

      if (error) {
        console.error('[ThemeContext] Error equipping theme:', {
          message: error.message,
          details: error.details,
          hint: error.hint,
          code: error.code,
          status,
          statusText
        });
        throw error;
      }

      console.log('[ThemeContext] Theme equipped successfully, reloading...');
      // Reload theme after equipping
      await loadTheme();
      return true;
    } catch (error) {
      console.error('[ThemeContext] Error equipping theme:', error);
      return false;
    }
  };

  const refreshTheme = async () => {
    console.log('[ThemeContext] Refreshing theme...');
    await loadTheme();
  };

  useEffect(() => {
    loadTheme();
  }, [userId]);

  return (
    <ThemeContext.Provider value={{ theme, loading, refreshTheme, equipTheme }}>
      <motion.div
        key={theme?.id || 'default'}
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        transition={{ duration: 0.3 }}
        style={{ minHeight: '100vh' }}
      >
        {children}
      </motion.div>
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
