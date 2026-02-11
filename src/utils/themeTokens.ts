/**
 * Theme Token Generator
 * Converts a theme configuration into a complete set of CSS variables
 *
 * This is the ONLY place that generates theme values.
 * All new themes should work through this without modification.
 */

export interface ThemeConfig {
  // Core color palette
  palette: {
    primary: string;      // Main brand color (hex)
    secondary: string;    // Supporting color (hex)
    accent: string;       // Highlight/emphasis (hex)
    surface: string;      // Cards/panels (hex)
    background: string;   // Page background (hex)
    text: {
      primary: string;    // Main text (hex)
      secondary: string;  // Secondary text (hex)
      muted: string;      // Muted text (hex)
    };
  };

  // Visual behavior
  appearance: {
    mode: 'dark' | 'light' | 'neon' | 'muted';
    contrast: 'low' | 'medium' | 'high' | 'extreme';
    glow: 'none' | 'subtle' | 'medium' | 'strong';
    blur: number;         // Backdrop blur 0-20
    rounding: number;     // Border radius scale 0-2
  };

  // Effect presets (shared systems)
  effects: {
    decoration: 'none' | 'organic' | 'geometric' | 'cosmic' | 'thermal' | 'electric' | 'frost' | 'aqua';
    particles: 'none' | 'subtle' | 'medium' | 'heavy';
    animation: 'static' | 'gentle' | 'active' | 'intense';
  };

  // Auto-generated from decoration + animation
  tags: string[];
}

/**
 * Convert hex to HSL object
 */
function hexToHSL(hex: string): { h: number; s: number; l: number } {
  hex = hex.replace('#', '');
  const r = parseInt(hex.substring(0, 2), 16) / 255;
  const g = parseInt(hex.substring(2, 4), 16) / 255;
  const b = parseInt(hex.substring(4, 6), 16) / 255;

  const max = Math.max(r, g, b);
  const min = Math.min(r, g, b);
  let h = 0;
  let s = 0;
  const l = (max + min) / 2;

  if (max !== min) {
    const d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    switch (max) {
      case r: h = ((g - b) / d + (g < b ? 6 : 0)) / 6; break;
      case g: h = ((b - r) / d + 2) / 6; break;
      case b: h = ((r - g) / d + 4) / 6; break;
    }
  }

  return { h: Math.round(h * 360), s: Math.round(s * 100), l: Math.round(l * 100) };
}

/**
 * Convert hex to RGB object (for lightness calculation)
 */
function hexToRgb(hex: string): { r: number; g: number; b: number } {
  hex = hex.replace('#', '');
  return {
    r: parseInt(hex.substring(0, 2), 16),
    g: parseInt(hex.substring(2, 4), 16),
    b: parseInt(hex.substring(4, 6), 16)
  };
}

/**
 * Get perceived lightness from hex color (0-1 range)
 * Uses W3C brightness formula: (r * 299 + g * 587 + b * 114) / 1000
 */
function getLightness(hexColor: string): number {
  const { r, g, b } = hexToRgb(hexColor);
  return (r * 299 + g * 587 + b * 114) / 1000 / 255;
}

/**
 * Lighten/darken HSL
 */
function adjustLightness(hsl: { h: number; s: number; l: number }, amount: number): { h: number; s: number; l: number } {
  return { h: hsl.h, s: hsl.s, l: Math.max(0, Math.min(100, hsl.l + amount)) };
}

/**
 * Calculate perceived brightness of a color (for contrast checks)
 * Returns 0-255, higher = brighter
 */
function getBrightness(hsl: { h: number; s: number; l: number }): number {
  // Convert HSL to RGB first for more accurate brightness calculation
  const l = hsl.l / 100;
  const s = hsl.s / 100;
  const h = hsl.h / 360;

  const c = (1 - Math.abs(2 * l - 1)) * s;
  const x = c * (1 - Math.abs((h * 6) % 2 - 1));
  const m = l - c / 2;

  let r, g, b;
  if (h < 1/6) { r = c; g = x; b = 0; }
  else if (h < 2/6) { r = x; g = c; b = 0; }
  else if (h < 3/6) { r = 0; g = c; b = x; }
  else if (h < 4/6) { r = 0; g = x; b = c; }
  else if (h < 5/6) { r = x; g = 0; b = c; }
  else { r = c; g = 0; b = x; }

  r = (r + m) * 255;
  g = (g + m) * 255;
  b = (b + m) * 255;

  // Perceived brightness formula (W3C)
  return Math.round(0.299 * r + 0.587 * g + 0.114 * b);
}

/**
 * Determine if a color is light (brightness > 128)
 */
function isLightColor(hsl: { h: number; s: number; l: number }): boolean {
  return getBrightness(hsl) > 128;
}

/**
 * Get contrast-safe foreground color (white or black)
 * AGGRESSIVE: Uses stricter threshold for better contrast
 */
function getContrastForeground(hsl: { h: number; s: number; l: number }): { h: number; s: number; l: number } {
  // Use stricter threshold (110 instead of 128) for better contrast
  return isLightColor(hsl) || hsl.l > 50
    ? { h: 0, s: 0, l: 5 }    // Very dark (near black) for light backgrounds
    : { h: 0, s: 0, l: 98 };  // Very light (near white) for dark backgrounds
}

/**
 * Get high-contrast accent variant for borders/glows
 * AGGRESSIVE: Makes even more visible
 */
function getHighContrastAccent(hsl: { h: number; s: number; l: number }): { h: number; s: number; l: number } {
  // For very dark colors (l < 30), make much brighter
  // For very light colors (l > 70), make much darker
  // For mid colors, push toward extremes
  if (hsl.l < 30) {
    return { h: hsl.h, s: Math.min(100, hsl.s + 30), l: Math.min(95, hsl.l + 60) };
  } else if (hsl.l > 70) {
    return { h: hsl.h, s: Math.min(100, hsl.s + 30), l: Math.max(10, hsl.l - 60) };
  } else {
    // Mid-range - push to extreme based on current lightness
    return hsl.l < 50
      ? { h: hsl.h, s: Math.min(100, hsl.s + 25), l: Math.min(90, hsl.l + 45) }
      : { h: hsl.h, s: Math.min(100, hsl.s + 25), l: Math.max(15, hsl.l - 45) };
  }
}

/**
 * Generate comprehensive theme tokens with contrast safety
 * Applies the full palette globally while ensuring text/buttons remain visible
 */
export function generateThemeTokens(config: ThemeConfig): Record<string, string> {
  const tokens: Record<string, string> = {};

  // ═══════════════════════════════════════════════════════════════
  // CONVERT PALETTE TO HSL
  // ═══════════════════════════════════════════════════════════════
  const primary = hexToHSL(config.palette.primary);
  const secondary = hexToHSL(config.palette.secondary);
  const accent = hexToHSL(config.palette.accent);
  const background = hexToHSL(config.palette.background);
  const surface = hexToHSL(config.palette.surface);

  // ═══════════════════════════════════════════════════════════════
  // DARK/LIGHT MODE DETECTION (based on background lightness)
  // ═══════════════════════════════════════════════════════════════
  const backgroundLightness = getLightness(config.palette.background);
  const isDarkMode = backgroundLightness < 0.40;

  console.log(`[Theme] ${config.palette.background} → ${(backgroundLightness * 100).toFixed(1)}% lightness → ${isDarkMode ? 'DARK' : 'LIGHT'} mode`);

  // ═══════════════════════════════════════════════════════════════
  // CONTRAST-SAFE TEXT COLORS (white on dark, black on light)
  // ═══════════════════════════════════════════════════════════════
  if (isDarkMode) {
    // Dark background → white text
    tokens['--text-primary'] = `255 255 255`;      // #ffffff
    tokens['--text-secondary'] = `235 235 235`;   // #ebebeb
    tokens['--text-muted'] = `180 180 180`;       // #b4b4b4
  } else {
    // Light background → black text
    tokens['--text-primary'] = `20 20 20`;        // #141414
    tokens['--text-secondary'] = `40 40 40`;      // #282828
    tokens['--text-muted'] = `100 100 100`;      // #646464
  }

  // ═══════════════════════════════════════════════════════════════
  // CORE PALETTE (applied globally)
  // ═══════════════════════════════════════════════════════════════
  tokens['--primary'] = `${primary.h} ${primary.s}% ${primary.l}%`;
  tokens['--secondary'] = `${secondary.h} ${secondary.s}% ${secondary.l}%`;
  tokens['--accent'] = `${accent.h} ${accent.s}% ${accent.l}%`;
  tokens['--background'] = `${background.h} ${background.s}% ${background.l}%`;
  tokens['--surface'] = `${surface.h} ${surface.s}% ${surface.l}%`;

  // ═══════════════════════════════════════════════════════════════
  // SURFACE VARIANTS (cards, panels, inputs)
  // ═══════════════════════════════════════════════════════════════
  // Card: slightly lighter/darker than background
  const cardLightness = isDarkMode ? Math.min(95, background.l + 8) : Math.max(5, background.l - 8);
  tokens['--card'] = `${background.h} ${Math.max(0, background.s - 5)}% ${cardLightness}%`;
  tokens['--card-foreground'] = tokens['--text-primary'];

  // Card hover: more pronounced
  const cardHoverLightness = isDarkMode ? Math.min(98, background.l + 12) : Math.max(2, background.l - 12);
  tokens['--card-hover'] = `${background.h} ${background.s}% ${cardHoverLightness}%`;

  // Popover
  tokens['--popover'] = tokens['--card'];
  tokens['--popover-foreground'] = tokens['--text-primary'];

  // Muted background (for disabled states, sidebar hover)
  const mutedLightness = isDarkMode ? Math.min(92, background.l + 4) : Math.max(8, background.l - 4);
  tokens['--muted'] = `${background.h} ${Math.max(0, background.s - 10)}% ${mutedLightness}%`;
  tokens['--muted-foreground'] = tokens['--text-muted'];

  // Input backgrounds
  tokens['--input'] = tokens['--card'];
  tokens['--input-focus'] = tokens['--card-hover'];

  // ═══════════════════════════════════════════════════════════════
  // BUTTON COLORS (with contrast-safe text)
  // ═══════════════════════════════════════════════════════════════
  tokens['--button-bg'] = `${primary.h} ${primary.s}% ${primary.l}%`;
  tokens['--button-foreground'] = isDarkMode ? `255 255 255` : `0 0 0`;

  tokens['--button-secondary-bg'] = `${secondary.h} ${secondary.s}% ${secondary.l}%`;
  tokens['--button-secondary-foreground'] = isDarkMode ? `255 255 255` : `0 0 0`;

  // Button borders (accent-based for visibility)
  const borderLightness = isDarkMode ? Math.min(95, accent.l + 40) : Math.max(15, accent.l - 30);
  tokens['--button-border'] = `${accent.h} ${Math.min(100, accent.s + 10)}% ${borderLightness}%`;
  tokens['--button-border-hover'] = `${accent.h} ${accent.s}% ${isDarkMode ? 98 : borderLightness - 10}%`;

  // ═══════════════════════════════════════════════════════════════
  // HOVER & ACTIVE STATES
  // ═══════════════════════════════════════════════════════════════
  const primaryHover = adjustLightness(primary, isDarkMode ? 10 : -10);
  tokens['--primary-hover'] = `${primaryHover.h} ${primaryHover.s}% ${primaryHover.l}%`;

  const secondaryHover = adjustLightness(secondary, isDarkMode ? 10 : -10);
  tokens['--secondary-hover'] = `${secondaryHover.h} ${secondaryHover.s}% ${secondaryHover.l}%`;

  const accentHover = adjustLightness(accent, isDarkMode ? 10 : -10);
  tokens['--accent-hover'] = `${accentHover.h} ${accentHover.s}% ${accentHover.l}%`;

  // Hover accent (for links, active states)
  tokens['--hover-accent'] = `${accent.h} ${accent.s}% ${isDarkMode ? Math.min(100, accent.l + 15) : Math.max(0, accent.l - 15)}%`;

  // ═══════════════════════════════════════════════════════════════
  // BORDER COLORS
  // ═══════════════════════════════════════════════════════════════
  const borderLight = isDarkMode ? Math.min(80, background.l + 20) : Math.max(20, background.l - 20);
  tokens['--border'] = `${background.h} ${background.s}% ${borderLight}%`;

  // High-contrast accent border (for focus rings, highlights)
  const accentBorder = getHighContrastAccent(accent);
  tokens['--border-accent'] = `${accentBorder.h} ${accentBorder.s}% ${accentBorder.l}%`;

  // ═══════════════════════════════════════════════════════════════
  // GLOW & SHADOW EFFECTS (mode-aware)
  // ═══════════════════════════════════════════════════════════════
  const glowOpacity = config.appearance.glow === 'none' ? '0' :
                      config.appearance.glow === 'subtle' ? '0.15' :
                      config.appearance.glow === 'medium' ? '0.3' : '0.5';

  tokens['--glow-primary'] = `0 0 20px hsla(${primary.h}, ${primary.s}%, ${primary.l}%, ${glowOpacity})`;
  tokens['--glow-accent'] = `0 0 20px hsla(${accent.h}, ${accent.s}%, ${accent.l}%, ${glowOpacity})`;
  tokens['--glow-strong'] = `0 0 30px hsla(${accent.h}, ${accent.s}%, ${accent.l}%, ${Math.min(1, parseFloat(glowOpacity) + 0.2)})`;

  // Shadow dark/light aware
  const shadowAlpha = isDarkMode ? '0.5' : '0.2';
  tokens['--shadow-sm'] = `0 1px 2px 0 hsla(0, 0%, 0%, ${shadowAlpha})`;
  tokens['--shadow-md'] = `0 4px 6px -1px hsla(0, 0%, 0%, ${shadowAlpha}), 0 2px 4px -1px hsla(0, 0%, 0%, ${parseFloat(shadowAlpha) * 0.6})`;
  tokens['--shadow-lg'] = `0 16px 16px -5px hsla(0, 0%, 0%, ${shadowAlpha})`;
  tokens['--shadow-glow'] = `0 0 20px hsla(${accent.h}, ${accent.s}%, ${accent.l}%, ${glowOpacity})`;

  // ═══════════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════════
  tokens['--gradient-primary'] = `linear-gradient(135deg, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.9), hsla(${secondary.h}, ${secondary.s}%, ${secondary.l}%, 0.9))`;
  tokens['--gradient-surface'] = `linear-gradient(180deg, hsla(${background.h}, ${background.s}%, ${background.l}%, 1), hsla(${surface.h}, ${surface.s}%, ${surface.l}%, 1))`;

  // ═══════════════════════════════════════════════════════════════
  // BACKGROUND DECORATION
  // ═══════════════════════════════════════════════════════════════
  tokens['--bg-decoration'] = getDecorationPreset(config.effects.decoration, primary, secondary, accent);

  // ═══════════════════════════════════════════════════════════════
  // SPACING & SIZING
  // ═══════════════════════════════════════════════════════════════
  tokens['--blur-backdrop'] = `${config.appearance.blur}px`;

  const baseRadius = 0.75; // rem
  tokens['--radius-sm'] = `${baseRadius * config.appearance.rounding * 0.5}rem`;
  tokens['--radius-md'] = `${baseRadius * config.appearance.rounding}rem`;
  tokens['--radius-lg'] = `${baseRadius * config.appearance.rounding * 1.5}rem`;

  // ═══════════════════════════════════════════════════════════════
  // RING (focus outline)
  // ═══════════════════════════════════════════════════════════════
  tokens['--ring'] = `${primary.h} ${primary.s}% ${primary.l}%`;

  // ═══════════════════════════════════════════════════════════════
  // EFFECT TOKENS
  // ═══════════════════════════════════════════════════════════════
  tokens['--decoration-type'] = config.effects.decoration;
  tokens['--particle-intensity'] = config.effects.particles;
  tokens['--animation-speed'] = {
    'static': '0s',
    'gentle': '3s',
    'active': '1.5s',
    'intense': '0.5s'
  }[config.effects.animation];

  return tokens;
}

/**
 * Shared decoration presets (not per-theme!)
 * Themes select a preset, parameters are auto-generated from colors
 */
function getDecorationPreset(
  preset: string,
  primary: { h: number; s: number; l: number },
  secondary: { h: number; s: number; l: number },
  accent: { h: number; s: number; l: number }
): string {
  const presets: Record<string, string> = {
    'none': 'none',

    // Organic preset (forest, nature themes)
    'organic': `
      radial-gradient(circle at 15% 85%, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.1) 0%, transparent 50%),
      radial-gradient(circle at 85% 15%, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.05) 0%, transparent 50%)
    `,

    // Cosmic preset (space, galaxy themes)
    'cosmic': `
      radial-gradient(2px 2px at 20px 30px, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.3), transparent),
      radial-gradient(2px 2px at 40px 70px, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.2), transparent),
      radial-gradient(1px 1px at 90px 40px, hsla(${accent.h}, ${accent.s}%, ${accent.l}%, 0.4), transparent)
    `,

    // Thermal preset (fire, lava themes)
    'thermal': `
      radial-gradient(circle at 50% 100%, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.15) 0%, transparent 50%),
      radial-gradient(circle at 30% 80%, hsla(${secondary.h}, ${secondary.s}%, ${secondary.l}%, 0.1) 0%, transparent 40%)
    `,

    // Electric preset (cyber, neon themes)
    'electric': `
      linear-gradient(${primary.h}deg, transparent 49%, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.1) 50%, transparent 51%),
      linear-gradient(-${primary.h}deg, transparent 49%, hsla(${accent.h}, ${accent.s}%, ${accent.l}%, 0.1) 50%, transparent 51%)
    `,

    // Frost preset (ice, winter themes)
    'frost': `
      linear-gradient(135deg, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.05) 0%, transparent 50%),
      radial-gradient(circle at 70% 20%, hsla(${secondary.h}, ${secondary.s}%, ${secondary.l}%, 0.1) 0%, transparent 40%)
    `,

    // Aqua preset (ocean, water themes)
    'aqua': `
      radial-gradient(circle at 20% 80%, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.1) 0%, transparent 40%),
      radial-gradient(circle at 80% 20%, hsla(${secondary.h}, ${secondary.s}%, ${secondary.l}%, 0.1) 0%, transparent 40%)
    `,

    // Geometric preset (minimal, tech themes)
    'geometric': `
      linear-gradient(${primary.h}deg, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.02) 0%, transparent 20%),
      linear-gradient(${primary.h + 90}deg, hsla(${accent.h}, ${accent.s}%, ${accent.l}%, 0.02) 0%, transparent 20%)
    `
  };

  return presets[preset] || presets['none'];
}

/**
 * Parse theme from database shop_item
 * Converts metadata to ThemeConfig format
 * Metadata includes: primary, secondary, accent, background, text, mode, glow, decoration
 */
export function parseThemeConfig(shopItem: Record<string, unknown>): ThemeConfig {
  const metadata = (shopItem.metadata || {}) as Record<string, unknown>;

  // Read colors from metadata (these are the authoritative source)
  const primary = (metadata.primary as string) || '#3b82f6';
  const secondary = (metadata.secondary as string) || '#1e40af';
  const accent = (metadata.accent as string) || '#60a5fa';
  const background = (metadata.background as string) || '#0f172a';
  const text = (metadata.text as string) || '#f1f5f9';

  // Read appearance settings from metadata, with fallbacks
  let mode: ThemeConfig['appearance']['mode'] =
    (metadata.mode as ThemeConfig['appearance']['mode']) || 'dark';

  let glow: ThemeConfig['appearance']['glow'] =
    (metadata.glow as ThemeConfig['appearance']['glow']) || 'subtle';

  let decoration: ThemeConfig['effects']['decoration'] =
    (metadata.decoration as ThemeConfig['effects']['decoration']) || 'cosmic';

  // Validate mode values
  if (!['dark', 'light', 'neon', 'muted'].includes(mode)) {
    mode = 'dark';
  }

  // Validate glow values
  if (!['none', 'subtle', 'medium', 'strong'].includes(glow)) {
    glow = 'subtle';
  }

  // Validate decoration values
  const validDecorations = ['none', 'organic', 'geometric', 'cosmic', 'thermal', 'electric', 'frost', 'aqua'];
  if (!validDecorations.includes(decoration)) {
    decoration = 'cosmic';
  }

  return {
    palette: {
      primary,
      secondary,
      accent,
      surface: background,
      background,
      text: {
        primary: text,
        secondary: text,
        muted: text,
      }
    },
    appearance: {
      mode,
      contrast: 'medium',
      glow,
      blur: 8,
      rounding: 1
    },
    effects: {
      decoration,
      particles: decoration === 'cosmic' ? 'medium' : 'subtle',
      animation: 'gentle'
    },
    tags: []
  };
}
