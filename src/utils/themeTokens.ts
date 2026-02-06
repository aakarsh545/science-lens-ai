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
 * Lighten/darken HSL
 */
function adjustLightness(hsl: { h: number; s: number; l: number }, amount: number): { h: number; s: number; l: number } {
  return { h: hsl.h, s: hsl.s, l: Math.max(0, Math.min(100, hsl.l + amount)) };
}

/**
 * Generate all CSS tokens from theme config
 */
export function generateThemeTokens(config: ThemeConfig): Record<string, string> {
  const tokens: Record<string, string> = {};

  // Convert all palette colors to HSL
  const primary = hexToHSL(config.palette.primary);
  const secondary = hexToHSL(config.palette.secondary);
  const accent = hexToHSL(config.palette.accent);
  const surface = hexToHSL(config.palette.surface);
  const background = hexToHSL(config.palette.background);
  const textPrimary = hexToHSL(config.palette.text.primary);
  const textSecondary = hexToHSL(config.palette.text.secondary);
  const textMuted = hexToHSL(config.palette.text.muted);

  // ========== COLOR TOKENS ==========
  // Main semantic colors
  tokens['--color-primary'] = `${primary.h} ${primary.s}% ${primary.l}%`;
  tokens['--color-secondary'] = `${secondary.h} ${secondary.s}% ${secondary.l}%`;
  tokens['--color-accent'] = `${accent.h} ${accent.s}% ${accent.l}%`;
  tokens['--color-surface'] = `${surface.h} ${surface.s}% ${surface.l}%`;
  tokens['--color-background'] = `${background.h} ${background.s}% ${background.l}%`;

  // Text colors
  tokens['--color-text-primary'] = `${textPrimary.h} ${textPrimary.s}% ${textPrimary.l}%`;
  tokens['--color-text-secondary'] = `${textSecondary.h} ${textSecondary.s}% ${textSecondary.l}%`;
  tokens['--color-text-muted'] = `${textMuted.h} ${textMuted.s}% ${textMuted.l}%`;

  // ========== DERIVED TOKENS ==========
  // Hover states (automatically lighter/darker based on mode)
  const hoverAdjust = config.appearance.mode === 'light' ? -10 : 10;
  const primaryHover = adjustLightness(primary, hoverAdjust);
  const accentHover = adjustLightness(accent, hoverAdjust);
  tokens['--color-primary-hover'] = `${primaryHover.h} ${primaryHover.s}% ${primaryHover.l}%`;
  tokens['--color-accent-hover'] = `${accentHover.h} ${accentHover.s}% ${accentHover.l}%`;

  // Border colors (based on surface, adjusted for contrast)
  const border = adjustLightness(surface, config.appearance.contrast === 'high' ? 15 : 8);
  tokens['--color-border'] = `${border.h} ${border.s}% ${border.l}%`;
  tokens['--color-border-subtle'] = `${border.h} ${border.s}% ${Math.max(0, border.l + 5)}%`;

  // ========== SURFACE VARIANTS ==========
  // Cards, panels, popover backgrounds
  tokens['--color-card'] = `${surface.h} ${surface.s}% ${surface.l}%`;
  tokens['--color-card-hover'] = `${surface.h} ${surface.s}% ${Math.min(100, surface.l + 3)}%`;
  tokens['--color-popover'] = `${surface.h} ${surface.s}% ${surface.l}%`;
  tokens['--color-muted'] = `${background.h} ${background.s}% ${Math.min(100, background.l + 8)}%`;

  // Input backgrounds
  tokens['--color-input'] = `${background.h} ${background.s}% ${Math.min(100, background.l + 4)}%`;

  // ========== GLOW & SHADOW TOKENS ==========
  // Glow intensity based on theme config
  const glowOpacity = {
    'none': '0',
    'subtle': '0.15',
    'medium': '0.3',
    'strong': '0.5'
  }[config.appearance.glow];

  tokens['--glow-primary'] = `0 0 20px hsla(${primary.h}, ${primary.s}%, ${primary.l}%, ${glowOpacity})`;
  tokens['--glow-accent'] = `0 0 20px hsla(${accent.h}, ${accent.s}%, ${accent.l}%, ${glowOpacity})`;

  // Shadow softness based on blur setting
  const shadowBlur = config.appearance.blur * 2;
  tokens['--shadow-sm'] = `0 1px 2px 0 hsla(0, 0%, 0%, 0.3)`;
  tokens['--shadow-md'] = `0 4px 6px -1px hsla(0, 0%, 0%, 0.3), 0 2px 4px -1px hsla(0, 0%, 0%, 0.2)`;
  tokens['--shadow-lg'] = `0 ${shadowBlur}px ${shadowBlur * 2}px -5px hsla(0, 0%, 0%, 0.3)`;

  // ========== GRADIENT TOKENS ==========
  tokens['--gradient-primary'] = `linear-gradient(135deg, hsla(${primary.h}, ${primary.s}%, ${primary.l}%, 0.8), hsla(${secondary.h}, ${secondary.s}%, ${secondary.l}%, 0.8))`;
  tokens['--gradient-surface'] = `linear-gradient(180deg, hsla(${background.h}, ${background.s}%, ${background.l}%, 1), hsla(${surface.h}, ${surface.s}%, ${surface.l}%, 1))`;

  // ========== EFFECT TOKENS ==========
  // Backdrop blur
  tokens['--blur-backdrop'] = `${config.appearance.blur}px`;

  // Border radius scale
  const baseRadius = 0.75; // rem
  tokens['--radius-sm'] = `${baseRadius * config.appearance.rounding * 0.5}rem`;
  tokens['--radius-md'] = `${baseRadius * config.appearance.rounding}rem`;
  tokens['--radius-lg'] = `${baseRadius * config.appearance.rounding * 1.5}rem`;

  // Decoration effects
  tokens['--decoration-type'] = config.effects.decoration;
  tokens['--particle-intensity'] = config.effects.particles;
  tokens['--animation-speed'] = {
    'static': '0s',
    'gentle': '3s',
    'active': '1.5s',
    'intense': '0.5s'
  }[config.effects.animation];

  // ========== BACKGROUND EFFECTS ==========
  // Generate background decoration based on preset
  tokens['--bg-decoration'] = getDecorationPreset(config.effects.decoration, primary, secondary, accent);

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
 * Converts legacy metadata to new ThemeConfig format
 */
export function parseThemeConfig(shopItem: Record<string, unknown>): ThemeConfig {
  const metadata = (shopItem.metadata || {}) as Record<string, unknown>;
  const primary = (metadata.primary as string) || '#3b82f6';
  const secondary = (metadata.secondary as string) || '#1e40af';
  const background = (metadata.background as string) || '#0f172a';
  const text = (metadata.text as string) || '#f1f5f9';
  const accent = (metadata.accent as string) || '#60a5fa';

  const name = ((shopItem.name as string) || '').toLowerCase();
  let decoration: ThemeConfig['effects']['decoration'] = 'geometric';
  let mode: ThemeConfig['appearance']['mode'] = 'dark';
  let glow: ThemeConfig['appearance']['glow'] = 'subtle';

  if (name.includes('forest') || name.includes('green') || name.includes('mint')) {
    decoration = 'organic';
  } else if (name.includes('galaxy') || name.includes('space') || name.includes('midnight')) {
    decoration = 'cosmic';
    glow = 'medium';
  } else if (name.includes('volcanic') || name.includes('fire') || name.includes('sunset') || name.includes('inferno')) {
    decoration = 'thermal';
    glow = 'strong';
  } else if (name.includes('arctic') || name.includes('ice') || name.includes('aurora')) {
    decoration = 'frost';
    glow = 'medium';
  } else if (name.includes('ocean') || name.includes('water') || name.includes('sea')) {
    decoration = 'aqua';
  } else if (name.includes('cyber') || name.includes('neon') || name.includes('synth')) {
    decoration = 'electric';
    mode = 'neon';
    glow = 'strong';
  } else if (name.includes('light') || name.includes('day')) {
    mode = 'light';
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
      particles: name.includes('galaxy') || name.includes('cosmic') ? 'medium' : 'subtle',
      animation: 'gentle'
    },
    tags: []
  };
}
