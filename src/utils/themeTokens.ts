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
 * Generate simplified theme tokens
 * ONLY sets text colors and button borders - does NOT change background
 */
export function generateThemeTokens(config: ThemeConfig): Record<string, string> {
  const tokens: Record<string, string> = {};

  // Convert palette colors for border calculation
  const accent = hexToHSL(config.palette.accent);
  const primary = hexToHSL(config.palette.primary);

  // ═══════════════════════════════════════════════════════════════
  // DARK/LIGHT MODE DETECTION (based on theme's background lightness)
  // ═══════════════════════════════════════════════════════════════
  const backgroundLightness = getLightness(config.palette.background);
  const isDarkMode = backgroundLightness < 0.40;

  // ═══════════════════════════════════════════════════════════════
  // TEXT COLORS (only these change - background stays the same)
  // ═══════════════════════════════════════════════════════════════
  if (isDarkMode) {
    // DARK MODE: white text, light muted
    tokens['--theme-text-primary'] = `255 255 255`;      // #ffffff
    tokens['--theme-text-secondary'] = `255 255 255`;   // #ffffff
    tokens['--theme-text-muted'] = `204 204 204`;       // #cccccc

    // Button borders: white/light for visibility
    tokens['--theme-button-border'] = `255 255 255`;    // white
    tokens['--theme-button-border-hover'] = `229 229 229`; // #e5e5e5 (lighter)

    console.log(`[Theme] Mode: DARK (white text, white borders)`);
  } else {
    // LIGHT MODE: black text, dark muted
    tokens['--theme-text-primary'] = `0 0 0`;            // #000000
    tokens['--theme-text-secondary'] = `0 0 0`;         // #000000
    tokens['--theme-text-muted'] = `68 68 68`;          // #444444

    // Button borders: black/dark for visibility
    tokens['--theme-button-border'] = `0 0 0`;          // black
    tokens['--theme-button-border-hover'] = `51 51 51`; // #333333 (darker)

    console.log(`[Theme] Mode: LIGHT (black text, black borders)`);
  }

  // Also store the theme's accent for optional use
  tokens['--theme-accent'] = `${accent.h} ${accent.s}% ${accent.l}%`;
  tokens['--theme-primary'] = `${primary.h} ${primary.s}% ${primary.l}%`;

  console.log(`[Theme] Background: ${config.palette.background}, Lightness: ${(backgroundLightness * 100).toFixed(1)}%`);

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
