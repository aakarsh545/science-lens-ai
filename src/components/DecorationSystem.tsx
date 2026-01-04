/**
 * Advanced Decoration System
 * Provides sophisticated visual traits using shared, parameterized systems
 *
 * NO per-theme logic allowed.
 * All effects are generated from theme colors + preset configuration.
 */

import { useTheme } from "@/contexts/ThemeContext";
import { useEffect, useState } from "react";

/**
 * Decoration presets define the VISUAL BEHAVIOR
 * Colors come from the theme, preset defines the effect type
 */
interface DecorationPreset {
  // Corner decorations
  corners: {
    type: 'none' | 'leaves' | 'icicles' | 'flames' | 'crystals' | 'drops' | 'circuit' | 'stars';
    count: number;
    size: number;
  };

  // Edge effects
  edges: {
    type: 'none' | 'frost' | 'glow' | 'drip' | 'scanline' | 'gradient';
    intensity: number; // 0-1
  };

  // Background patterns
  background: {
    type: 'none' | 'grid' | 'dots' | 'hexagons' | 'organic' | 'noise' | 'waves';
    opacity: number; // 0-1
  };

  // Floating particles
  particles: {
    type: 'none' | 'leaves' | 'snowflakes' | 'embers' | 'bubbles' | 'stars' | 'data';
    count: number;
    speed: number; // 0-1
  };
}

/**
 * PRESET CONFIGURATIONS
 * Themes select a preset by name, system handles rendering
 */
const DECORATION_PRESETS: Record<string, DecorationPreset> = {
  // Organic preset (Forest, Nature)
  'organic': {
    corners: { type: 'leaves', count: 8, size: 24 },
    edges: { type: 'glow', intensity: 0.2 },
    background: { type: 'organic', opacity: 0.05 },
    particles: { type: 'leaves', count: 12, speed: 0.3 }
  },

  // Frost preset (Ice, Winter, Arctic)
  'frost': {
    corners: { type: 'icicles', count: 12, size: 20 },
    edges: { type: 'frost', intensity: 0.6 },
    background: { type: 'dots', opacity: 0.03 },
    particles: { type: 'snowflakes', count: 15, speed: 0.2 }
  },

  // Thermal preset (Fire, Lava, Volcanic)
  'thermal': {
    corners: { type: 'flames', count: 10, size: 28 },
    edges: { type: 'glow', intensity: 0.5 },
    background: { type: 'organic', opacity: 0.08 },
    particles: { type: 'embers', count: 20, speed: 0.6 }
  },

  // Cosmic preset (Space, Galaxy, Stars)
  'cosmic': {
    corners: { type: 'stars', count: 15, size: 16 },
    edges: { type: 'glow', intensity: 0.3 },
    background: { type: 'dots', opacity: 0.05 },
    particles: { type: 'stars', count: 20, speed: 0.2 }
  },

  // Aqua preset (Ocean, Water)
  'aqua': {
    corners: { type: 'drops', count: 10, size: 18 },
    edges: { type: 'gradient', intensity: 0.3 },
    background: { type: 'waves', opacity: 0.05 },
    particles: { type: 'bubbles', count: 10, speed: 0.4 }
  },

  // Electric preset (Cyber, Neon, Synthwave)
  'electric': {
    corners: { type: 'circuit', count: 8, size: 20 },
    edges: { type: 'glow', intensity: 0.6 },
    background: { type: 'grid', opacity: 0.04 },
    particles: { type: 'data', count: 12, speed: 0.5 }
  },

  // Crystal preset (Geodes, Minerals)
  'crystal': {
    corners: { type: 'crystals', count: 6, size: 24 },
    edges: { type: 'glow', intensity: 0.4 },
    background: { type: 'hexagons', opacity: 0.03 },
    particles: { type: 'stars', count: 8, speed: 0.2 }
  },

  // Geometric preset (Minimal, Tech)
  'geometric': {
    corners: { type: 'none', count: 0, size: 0 },
    edges: { type: 'gradient', intensity: 0.2 },
    background: { type: 'grid', opacity: 0.02 },
    particles: { type: 'none', count: 0, speed: 0 }
  }
};

/**
 * Extract color from theme
 */
function getThemeColors(theme: { config?: { palette?: { primary?: string; secondary?: string; accent?: string; background?: string } } }) {
  return {
    primary: theme?.config?.palette?.primary || '#3b82f6',
    secondary: theme?.config?.palette?.secondary || '#1e40af',
    accent: theme?.config?.palette?.accent || '#60a5fa',
    background: theme?.config?.palette?.background || '#0f172a',
  };
}

/**
 * CORNER DECORATIONS
 * Renders themed elements in corners using SVG
 */
function CornerDecorations({ preset, colors }: { preset: DecorationPreset; colors: Record<string, string> }) {
  if (preset.corners.type === 'none') return null;

  const corners = [
    { position: 'top-left', x: '0%', y: '0%' },
    { position: 'top-right', x: '100%', y: '0%' },
    { position: 'bottom-left', x: '0%', y: '100%' },
    { position: 'bottom-right', x: '100%', y: '100%' },
  ];

  const renderCornerSVG = (type: string, color: string) => {
    const opacity = 0.15;

    switch (type) {
      case 'leaves':
        return (
          <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
            <path d="M20 5C25 10 35 15 35 20C35 25 30 35 20 35C15 35 5 30 5 25C5 15 10 5 20 5Z"
                  fill={color} fillOpacity={opacity} stroke={color} strokeWidth="1"/>
          </svg>
        );

      case 'icicles':
        return (
          <svg width="30" height="50" viewBox="0 0 30 50" fill="none">
            <path d="M5 0L8 20L11 0M14 0L17 30L20 0M23 0L26 25L29 0"
                  stroke={color} strokeWidth="2" strokeLinecap="round" strokeOpacity={opacity + 0.2}/>
          </svg>
        );

      case 'flames':
        return (
          <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
            <path d="M20 5C15 15 10 20 10 25C10 35 25 35 30 35C35 35 40 30 35 25C40 15 35 10 30 5L20 5Z"
                  fill={color} fillOpacity={opacity}>
              <animate attributeName="d" dur="2s" repeatCount="indefinite"
                values="M20 5C15 15 10 20 10 25C10 35 25 35 30 35C35 35 40 30 35 25C40 15 35 10 30 5L20 5Z;
                        M20 5C12 18 8 22 8 28C8 38 28 38 32 38C38 38 42 32 42 25C42 15 35 8 28 2L20 5Z"/>
            </path>
          </svg>
        );

      case 'crystals':
        return (
          <svg width="35" height="35" viewBox="0 0 35 35" fill="none">
            <polygon points="17.5,0 35,17.5 17.5,35 0,17.5"
                     fill={color} fillOpacity={opacity} stroke={color} strokeWidth="1"/>
            <polygon points="17.5,8 27,17.5 17.5,27 8,17.5"
                     fill={color} fillOpacity={opacity * 0.5}/>
          </svg>
        );

      case 'drops':
        return (
          <svg width="25" height="35" viewBox="0 0 25 35" fill="none">
            <ellipse cx="12.5" cy="12.5" rx="8" ry="12"
                     fill={color} fillOpacity={opacity}/>
            <path d="M12.5 24.5V35" stroke={color} strokeWidth="2" strokeOpacity={opacity + 0.2}/>
          </svg>
        );

      case 'circuit':
        return (
          <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
            <circle cx="10" cy="10" r="3" fill={color} fillOpacity={opacity + 0.3}/>
            <circle cx="30" cy="30" r="3" fill={color} fillOpacity={opacity + 0.3}/>
            <path d="M10 10H20M20 10V20M30 30H20M20 30V20"
                  stroke={color} strokeWidth="1.5" strokeOpacity={opacity + 0.2}/>
            <circle cx="20" cy="20" r="4" fill={color} fillOpacity={opacity + 0.4}/>
          </svg>
        );

      case 'stars':
        return (
          <svg width="35" height="35" viewBox="0 0 35 35" fill="none">
            <path d="M17.5 0L20 13L33 17.5L20 22L17.5 35L15 22L2 17.5L15 13Z"
                  fill={color} fillOpacity={opacity} stroke={color} strokeWidth="0.5"/>
          </svg>
        );

      default:
        return null;
    }
  };

  return (
    <div className="fixed inset-0 pointer-events-none z-10">
      {corners.map((corner, i) => (
        <div
          key={i}
          className="absolute"
          style={{
            [corner.x === '0%' ? 'left' : 'right']: corner.x,
            [corner.y === '0%' ? 'top' : 'bottom']: corner.y,
            transform: corner.x === '100%' ? 'scaleX(-1)' :
                       corner.y === '100%' ? 'scaleY(-1)' :
                       'scale(1)',
          }}
        >
          {renderCornerSVG(preset.corners.type, colors.accent)}
        </div>
      ))}
    </div>
  );
}

/**
 * EDGE EFFECTS
 * Creates themed borders, glows, frosts on screen edges
 */
function EdgeEffects({ preset, colors }: { preset: DecorationPreset; colors: Record<string, string> }) {
  if (preset.edges.type === 'none') return null;

  const edgeStyle: React.CSSProperties = {
    position: 'fixed',
    pointerEvents: 'none',
    zIndex: 5,
  };

  switch (preset.edges.type) {
    case 'frost':
      return (
        <>
          <div style={{ ...edgeStyle, top: 0, left: 0, right: 0, height: '3px',
            background: `linear-gradient(90deg, transparent, ${colors.accent}40, transparent)` }} />
          <div style={{ ...edgeStyle, bottom: 0, left: 0, right: 0, height: '3px',
            background: `linear-gradient(90deg, transparent, ${colors.accent}40, transparent)` }} />
          <div style={{ ...edgeStyle, top: 0, left: 0, bottom: 0, width: '3px',
            background: `linear-gradient(180deg, transparent, ${colors.accent}40, transparent)` }} />
          <div style={{ ...edgeStyle, top: 0, right: 0, bottom: 0, width: '3px',
            background: `linear-gradient(180deg, transparent, ${colors.accent}40, transparent)` }} />
        </>
      );

    case 'glow':
      return (
        <div style={{
          ...edgeStyle,
          inset: '0px',
          border: `2px solid ${colors.primary}33`,
          boxShadow: `inset 0 0 30px ${colors.primary}22`,
        }} />
      );

    case 'gradient':
      return (
        <>
          <div style={{ ...edgeStyle, top: 0, left: 0, right: 0, height: '4px',
            background: `linear-gradient(90deg, ${colors.primary}00, ${colors.primary}44, ${colors.primary}00)` }} />
          <div style={{ ...edgeStyle, bottom: 0, left: 0, right: 0, height: '4px',
            background: `linear-gradient(90deg, ${colors.secondary}00, ${colors.secondary}44, ${colors.secondary}00)` }} />
        </>
      );

    default:
      return null;
  }
}

/**
 * BACKGROUND PATTERNS
 * SVG-based patterns using theme colors
 */
function BackgroundPattern({ preset, colors }: { preset: DecorationPreset; colors: Record<string, string> }) {
  if (preset.background.type === 'none') return null;

  const patternId = `bg-pattern-${preset.background.type}`;
  const color1 = `${colors.primary}11`;
  const color2 = `${colors.secondary}11`;

  const renderPattern = () => {
    switch (preset.background.type) {
      case 'grid':
        return (
          <svg width="40" height="40">
            <pattern id={patternId} x="0" y="0" width="40" height="40" patternUnits="userSpaceOnUse">
              <path d="M 40 0 L 0 0 0 40" fill="none" stroke={colors.primary} strokeWidth="0.5" strokeOpacity={preset.background.opacity}/>
            </pattern>
            <rect width="100%" height="100%" fill={`url(#${patternId})`}/>
          </svg>
        );

      case 'dots':
        return (
          <svg width="20" height="20">
            <pattern id={patternId} x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse">
              <circle cx="10" cy="10" r="1" fill={colors.accent} fillOpacity={preset.background.opacity}/>
            </pattern>
            <rect width="100%" height="100%" fill={`url(#${patternId})`}/>
          </svg>
        );

      case 'hexagons':
        return (
          <svg width="60" height="60">
            <pattern id={patternId} x="0" y="0" width="60" height="60" patternUnits="userSpaceOnUse">
              <polygon points="30,0 60,17 60,52 30,69 0,52 0,17"
                       fill="none" stroke={colors.accent} strokeWidth="0.5" strokeOpacity={preset.background.opacity}/>
            </pattern>
            <rect width="100%" height="100%" fill={`url(#${patternId})`}/>
          </svg>
        );

      case 'organic':
        return (
          <svg width="100" height="100">
            <pattern id={patternId} x="0" y="0" width="100" height="100" patternUnits="userSpaceOnUse">
              <circle cx="20" cy="20" r="15" fill={colors.primary} fillOpacity={preset.background.opacity * 0.5}/>
              <circle cx="80" cy="70" r="20" fill={colors.secondary} fillOpacity={preset.background.opacity * 0.3}/>
            </pattern>
            <rect width="100%" height="100%" fill={`url(#${patternId})`}/>
          </svg>
        );

      case 'waves':
        return (
          <svg width="100" height="20">
            <pattern id={patternId} x="0" y="0" width="100" height="20" patternUnits="userSpaceOnUse">
              <path d="M0 10 Q25 0 50 10 T100 10" fill="none" stroke={colors.accent} strokeWidth="1" strokeOpacity={preset.background.opacity}/>
            </pattern>
            <rect width="100%" height="100%" fill={`url(#${patternId})`}/>
          </svg>
        );

      default:
        return null;
    }
  };

  return (
    <div className="fixed inset-0 pointer-events-none z-0" style={{ opacity: preset.background.opacity }}>
      {renderPattern()}
    </div>
  );
}

/**
 * FLOATING PARTICLES
 * Animated decorative elements using theme colors
 */
function FloatingParticles({ preset, colors }: { preset: DecorationPreset; colors: Record<string, string> }) {
  const [particles] = useState(() =>
    Array.from({ length: preset.particles.count }, (_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: 16 + Math.random() * 16,
      delay: Math.random() * 3,
      duration: 3 + Math.random() * 2,
    }))
  );

  if (preset.particles.type === 'none') return null;

  const getParticleEmoji = (type: string) => {
    const emojis: Record<string, string> = {
      'leaves': '🌿',
      'snowflakes': '❄️',
      'embers': '✨',
      'bubbles': '🫧',
      'stars': '⭐',
      'data': '💾',
    };
    return emojis[type] || '✨';
  };

  return (
    <div className="fixed inset-0 overflow-hidden pointer-events-none select-none z-10">
      {particles.map((p) => (
        <div
          key={p.id}
          className="absolute"
          style={{
            left: `${p.x}%`,
            top: `${p.y}%`,
            fontSize: `${p.size}px`,
            opacity: 0.2,
            animation: `float ${p.duration}s ease-in-out infinite`,
            animationDelay: `${p.delay}s`,
          }}
        >
          {getParticleEmoji(preset.particles.type)}
        </div>
      ))}
    </div>
  );
}

/**
 * MAIN DECORATION COMPONENT
 * Composes all decoration layers
 */
export function DecorationSystem() {
  const { theme } = useTheme();
  const [preset, setPreset] = useState<DecorationPreset>(DECORATION_PRESETS['geometric']);

  useEffect(() => {
    if (!theme) {
      setPreset(DECORATION_PRESETS['geometric']);
      return;
    }

    // Determine preset from theme name
    const name = (theme.name || '').toLowerCase();
    let presetKey = 'geometric';

    if (name.includes('forest') || name.includes('green') || name.includes('mint') || name.includes('nature')) {
      presetKey = 'organic';
    } else if (name.includes('ice') || name.includes('arctic') || name.includes('frost') || name.includes('winter')) {
      presetKey = 'frost';
    } else if (name.includes('fire') || name.includes('volcanic') || name.includes('volcano') || name.includes('inferno') || name.includes('lava') || name.includes('sunset')) {
      presetKey = 'thermal';
    } else if (name.includes('galaxy') || name.includes('space') || name.includes('midnight') || name.includes('cosmic') || name.includes('star')) {
      presetKey = 'cosmic';
    } else if (name.includes('ocean') || name.includes('water') || name.includes('sea') || name.includes('aqua')) {
      presetKey = 'aqua';
    } else if (name.includes('cyber') || name.includes('neon') || name.includes('synth') || name.includes('electric')) {
      presetKey = 'electric';
    } else if (name.includes('crystal') || name.includes('geode') || name.includes('gem')) {
      presetKey = 'crystal';
    }

    setPreset(DECORATION_PRESETS[presetKey] || DECORATION_PRESETS['geometric']);
  }, [theme]);

  if (!theme) return null;

  const colors = getThemeColors(theme);

  return (
    <>
      <CornerDecorations preset={preset} colors={colors} />
      <EdgeEffects preset={preset} colors={colors} />
      <BackgroundPattern preset={preset} colors={colors} />
      <FloatingParticles preset={preset} colors={colors} />
    </>
  );
}
