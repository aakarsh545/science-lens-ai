import React from "react";

interface ThemeIllustrationProps {
  themeName: string;
  colors: {
    primary: string;
    secondary: string;
    background: string;
    accent: string;
  };
  size?: number;
  className?: string;
}

export function ThemeIllustration({ themeName, colors, size = 160, className = "" }: ThemeIllustrationProps) {
  // Determine illustration type based on theme name and colors
  const getIllustrationType = (name: string, primary: string) => {
    const lowerName = name.toLowerCase();

    // Space/Cosmic themes
    if (lowerName.includes('cosmic') || lowerName.includes('space') || lowerName.includes('galaxy') || lowerName.includes('nebula')) {
      return 'space';
    }

    // Nature/Forest themes
    if (lowerName.includes('forest') || lowerName.includes('nature') || lowerName.includes('jungle') || lowerName.includes('green')) {
      return 'nature';
    }

    // Fire/Volcano themes
    if (lowerName.includes('fire') || lowerName.includes('volcano') || lowerName.includes('flame') || lowerName.includes('inferno')) {
      return 'fire';
    }

    // Ocean/Water themes
    if (lowerName.includes('ocean') || lowerName.includes('water') || lowerName.includes('sea') || lowerName.includes('aquatic')) {
      return 'ocean';
    }

    // Arctic/Ice themes
    if (lowerName.includes('arctic') || lowerName.includes('ice') || lowerName.includes('frost') || lowerName.includes('glacier')) {
      return 'arctic';
    }

    // Desert themes
    if (lowerName.includes('desert') || lowerName.includes('sand') || lowerName.includes('dune')) {
      return 'desert';
    }

    // Sunset themes
    if (lowerName.includes('sunset') || lowerName.includes('dawn') || lowerName.includes('dusk')) {
      return 'sunset';
    }

    // Aurora themes
    if (lowerName.includes('aurora') || lowerName.includes('borealis') || lowerName.includes('northern')) {
      return 'aurora';
    }

    // Quantum themes
    if (lowerName.includes('quantum') || lowerName.includes('atomic') || lowerName.includes('molecular')) {
      return 'quantum';
    }

    // Cyberpunk themes
    if (lowerName.includes('cyber') || lowerName.includes('neon') || lowerName.includes('synthwave')) {
      return 'cyberpunk';
    }

    // Crystal themes
    if (lowerName.includes('crystal') || lowerName.includes('gem') || lowerName.includes('diamond')) {
      return 'crystal';
    }

    // Default to space
    return 'space';
  };

  const illustrationType = getIllustrationType(themeName, colors.primary);

  // Space illustration
  const SpaceScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      <defs>
        <radialGradient id="space-glow">
          <stop offset="0%" stopColor={colors.primary} stopOpacity="0.6"/>
          <stop offset="100%" stopColor={colors.background} stopOpacity="0"/>
        </radialGradient>
      </defs>

      {/* Background */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Stars */}
      <circle cx="20" cy="30" r="1.5" fill="white" opacity="0.8"/>
      <circle cx="45" cy="15" r="1" fill="white" opacity="0.6"/>
      <circle cx="120" cy="25" r="2" fill="white" opacity="0.9"/>
      <circle cx="140" cy="50" r="1" fill="white" opacity="0.5"/>
      <circle cx="30" cy="100" r="1.5" fill="white" opacity="0.7"/>
      <circle cx="130" cy="120" r="1" fill="white" opacity="0.6"/>
      <circle cx="80" cy="10" r="1" fill="white" opacity="0.5"/>
      <circle cx="150" cy="90" r="1.5" fill="white" opacity="0.8"/>

      {/* Planet */}
      <circle cx="80" cy="80" r="35" fill={colors.primary} opacity="0.8"/>
      <circle cx="80" cy="80" r="30" fill={colors.secondary} opacity="0.6"/>

      {/* Planet ring */}
      <ellipse cx="80" cy="80" rx="50" ry="8" fill="none" stroke={colors.accent} strokeWidth="3" opacity="0.7"/>

      {/* Small moons */}
      <circle cx="130" cy="40" r="8" fill={colors.primary} opacity="0.7"/>
      <circle cx="130" cy="40" r="5" fill={colors.secondary} opacity="0.5"/>

      {/* Shooting star */}
      <path d="M 30 50 L 50 35" stroke={colors.accent} strokeWidth="2" opacity="0.8"/>
      <path d="M 32 48 L 35 45" stroke="white" strokeWidth="1" opacity="0.9"/>

      {/* Nebula glow */}
      <circle cx="120" cy="130" r="25" fill="url(#space-glow)" opacity="0.4"/>
    </svg>
  );

  // Nature illustration
  const NatureScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Sky background */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Sun */}
      <circle cx="130" cy="30" r="15" fill={colors.primary} opacity="0.8"/>

      {/* Mountains */}
      <path d="M 0 100 L 40 60 L 80 100" fill={colors.secondary} opacity="0.6"/>
      <path d="M 60 100 L 100 50 L 140 100" fill={colors.secondary} opacity="0.5"/>
      <path d="M 30 100 L 60 70 L 90 100" fill={colors.primary} opacity="0.4"/>

      {/* Trees */}
      <rect x="25" y="100" width="8" height="30" fill="#5D4037"/>
      <polygon points="29,100 15,70 43,70" fill={colors.primary} opacity="0.8"/>
      <polygon points="29,80 18,55 40,55" fill={colors.primary} opacity="0.7"/>
      <polygon points="29,65 22,45 36,45" fill={colors.primary} opacity="0.6"/>

      <rect x="75" y="105" width="10" height="35" fill="#5D4037"/>
      <polygon points="80,105 60,70 100,70" fill={colors.secondary} opacity="0.8"/>
      <polygon points="80,85 65,55 95,55" fill={colors.secondary} opacity="0.7"/>
      <polygon points="80,70 68,45 92,45" fill={colors.secondary} opacity="0.6"/>

      <rect x="125" y="100" width="6" height="25" fill="#5D4037"/>
      <polygon points="128,100 118,75 138,75" fill={colors.accent} opacity="0.8"/>
      <polygon points="128,85 120,65 136,65" fill={colors.accent} opacity="0.7"/>

      {/* Grass */}
      <rect x="0" y="130" width="160" height="30" fill={colors.primary} opacity="0.5"/>

      {/* Leaves */}
      <ellipse cx="40" cy="120" rx="8" ry="4" fill={colors.accent} opacity="0.7"/>
      <ellipse cx="90" cy="125" rx="10" ry="5" fill={colors.accent} opacity="0.7"/>
    </svg>
  );

  // Fire illustration
  const FireScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Background */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Ground/mountains */}
      <path d="M 0 130 L 30 110 L 60 125 L 90 105 L 120 115 L 160 100 L 160 160 L 0 160 Z" fill={colors.secondary} opacity="0.5"/>

      {/* Volcano */}
      <path d="M 40 160 L 50 120 L 60 160" fill={colors.primary} opacity="0.8"/>
      <path d="M 30 160 L 55 90 L 80 160" fill={colors.primary} opacity="0.7"/>
      <path d="M 55 160 L 80 90 L 105 160" fill={colors.primary} opacity="0.7"/>
      <path d="M 80 160 L 105 90 L 130 160" fill={colors.primary} opacity="0.8"/>
      <path d="M 100 160 L 110 120 L 120 160" fill={colors.primary} opacity="0.8"/>

      {/* Lava glow */}
      <ellipse cx="80" cy="95" rx="15" ry="8" fill={colors.accent} opacity="0.9"/>

      {/* Flames */}
      <path d="M 75 95 Q 70 80 75 65 Q 80 50 75 40 Q 70 55 75 65 Q 80 80 75 95" fill={colors.accent} opacity="0.9"/>
      <path d="M 80 95 Q 75 75 80 55 Q 85 35 80 25 Q 75 40 80 55 Q 85 75 80 95" fill={colors.secondary} opacity="0.8"/>
      <path d="M 85 95 Q 80 80 85 65 Q 90 50 85 40 Q 80 55 85 65 Q 90 80 85 95" fill={colors.primary} opacity="0.9"/>

      {/* Ember particles */}
      <circle cx="70" cy="50" r="2" fill={colors.accent} opacity="0.8"/>
      <circle cx="90" cy="45" r="1.5" fill={colors.accent} opacity="0.7"/>
      <circle cx="75" cy="35" r="1" fill={colors.secondary} opacity="0.6"/>
      <circle cx="85" cy="30" r="1.5" fill={colors.primary} opacity="0.7"/>

      {/* Smoke */}
      <ellipse cx="65" cy="20" rx="8" ry="5" fill={colors.secondary} opacity="0.3"/>
      <ellipse cx="95" cy="15" rx="6" ry="4" fill={colors.secondary} opacity="0.3"/>
    </svg>
  );

  // Ocean illustration
  const OceanScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Sky */}
      <rect width="160" height="80" fill={colors.background}/>

      {/* Sun reflection */}
      <circle cx="130" cy="25" r="12" fill={colors.primary} opacity="0.7"/>

      {/* Water */}
      <rect y="80" width="160" height="80" fill={colors.secondary} opacity="0.4"/>

      {/* Waves */}
      <path d="M 0 80 Q 20 70 40 80 Q 60 90 80 80 Q 100 70 120 80 Q 140 90 160 80 L 160 160 L 0 160 Z" fill={colors.primary} opacity="0.6"/>
      <path d="M 0 100 Q 30 90 60 100 Q 90 110 120 100 Q 150 90 160 100 L 160 160 L 0 160 Z" fill={colors.secondary} opacity="0.5"/>
      <path d="M 0 120 Q 40 110 80 120 Q 120 130 160 120 L 160 160 L 0 160 Z" fill={colors.primary} opacity="0.4"/>

      {/* Bubbles */}
      <circle cx="30" cy="60" r="4" fill={colors.accent} opacity="0.5"/>
      <circle cx="45" cy="50" r="3" fill={colors.accent} opacity="0.4"/>
      <circle cx="120" cy="65" r="5" fill={colors.accent} opacity="0.5"/>
      <circle cx="135" cy="55" r="3" fill={colors.accent} opacity="0.4"/>

      {/* Small fish */}
      <ellipse cx="70" cy="140" rx="8" ry="4" fill={colors.accent} opacity="0.7"/>
      <polygon points="78,140 85,137 85,143" fill={colors.accent} opacity="0.7"/>

      <ellipse cx="110" cy="130" rx="6" ry="3" fill={colors.primary} opacity="0.6"/>
      <polygon points="116,130 121,128 121,132" fill={colors.primary} opacity="0.6"/>
    </svg>
  );

  // Arctic illustration
  const ArcticScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Sky */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Aurora */}
      <path d="M 0 40 Q 40 20 80 40 Q 120 60 160 40" stroke={colors.primary} strokeWidth="8" fill="none" opacity="0.4"/>
      <path d="M 0 50 Q 40 30 80 50 Q 120 70 160 50" stroke={colors.secondary} strokeWidth="6" fill="none" opacity="0.5"/>
      <path d="M 0 60 Q 40 40 80 60 Q 120 80 160 60" stroke={colors.accent} strokeWidth="4" fill="none" opacity="0.3"/>

      {/* Snow mountains */}
      <path d="M 0 160 L 30 100 L 60 160" fill={colors.primary} opacity="0.7"/>
      <path d="M 40 160 L 80 80 L 120 160" fill={colors.secondary} opacity="0.6"/>
      <path d="M 100 160 L 130 110 L 160 160" fill={colors.primary} opacity="0.7"/>

      {/* Snow caps */}
      <path d="M 70 85 L 80 80 L 90 85" fill="white" opacity="0.9"/>
      <path d="M 25 105 L 30 100 L 35 105" fill="white" opacity="0.8"/>
      <path d="M 125 115 L 130 110 L 135 115" fill="white" opacity="0.8"/>

      {/* Snowflakes */}
      <text x="20" y="30" fontSize="12" opacity="0.6">❄</text>
      <text x="140" y="50" fontSize="10" opacity="0.5">❄</text>
      <text x="60" y="25" fontSize="8" opacity="0.4">❄</text>
      <text x="100" y="35" fontSize="11" opacity="0.5">❄</text>
    </svg>
  );

  // Desert illustration
  const DesertScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Sky */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Sun */}
      <circle cx="130" cy="30" r="18" fill={colors.primary} opacity="0.9"/>

      {/* Sand dunes */}
      <path d="M 0 100 Q 40 80 80 100 Q 120 110 160 95 L 160 160 L 0 160 Z" fill={colors.primary} opacity="0.6"/>
      <path d="M 0 120 Q 50 105 100 120 Q 130 130 160 115 L 160 160 L 0 160 Z" fill={colors.secondary} opacity="0.5"/>
      <path d="M 0 140 Q 60 125 120 140 Q 150 145 160 140 L 160 160 L 0 160 Z" fill={colors.accent} opacity="0.4"/>

      {/* Cactus */}
      <rect x="35" y="110" width="8" height="35" fill={colors.secondary} opacity="0.7" rx="4"/>
      <rect x="25" y="120" width="8" height="15" fill={colors.secondary} opacity="0.7" rx="4"/>
      <rect x="45" y="115" width="8" height="20" fill={colors.secondary} opacity="0.7" rx="4"/>

      <rect x="120" y="105" width="6" height="25" fill={colors.secondary} opacity="0.6" rx="3"/>
      <rect x="112" y="112" width="6" height="12" fill={colors.secondary} opacity="0.6" rx="3"/>

      {/* Heat waves */}
      <path d="M 50 80 Q 55 75 50 70" stroke={colors.accent} strokeWidth="1" fill="none" opacity="0.3"/>
      <path d="M 70 85 Q 75 80 70 75" stroke={colors.accent} strokeWidth="1" fill="none" opacity="0.3"/>
    </svg>
  );

  // Sunset illustration
  const SunsetScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Sky gradient */}
      <defs>
        <linearGradient id="sunset-sky" x1="0%" y1="0%" x2="0%" y2="100%">
          <stop offset="0%" stopColor={colors.background}/>
          <stop offset="50%" stopColor={colors.primary}/>
          <stop offset="100%" stopColor={colors.secondary}/>
        </linearGradient>
      </defs>
      <rect width="160" height="160" fill="url(#sunset-sky)"/>

      {/* Sun */}
      <circle cx="80" cy="90" r="25" fill={colors.accent} opacity="0.9"/>

      {/* Sun reflection on water */}
      <rect y="120" width="160" height="40" fill={colors.secondary} opacity="0.4"/>
      <path d="M 60 120 L 65 140 L 70 120" fill={colors.accent} opacity="0.6"/>
      <path d="M 75 120 L 80 145 L 85 120" fill={colors.accent} opacity="0.7"/>
      <path d="M 90 120 L 95 140 L 100 120" fill={colors.accent} opacity="0.6"/>

      {/* Clouds */}
      <ellipse cx="30" cy="40" rx="15" ry="8" fill={colors.primary} opacity="0.5"/>
      <ellipse cx="40" cy="38" rx="12" ry="6" fill={colors.primary} opacity="0.5"/>
      <ellipse cx="130" cy="50" rx="18" ry="9" fill={colors.secondary} opacity="0.4"/>
      <ellipse cx="142" cy="48" rx="14" ry="7" fill={colors.secondary} opacity="0.4"/>

      {/* Birds */}
      <path d="M 50 70 Q 53 67 56 70" stroke={colors.background} strokeWidth="1.5" fill="none"/>
      <path d="M 58 65 Q 61 62 64 65" stroke={colors.background} strokeWidth="1.5" fill="none"/>
    </svg>
  );

  // Aurora illustration
  const AuroraScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Night sky */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Stars */}
      <circle cx="20" cy="30" r="1" fill="white" opacity="0.8"/>
      <circle cx="140" cy="25" r="1.5" fill="white" opacity="0.7"/>
      <circle cx="100" cy="40" r="1" fill="white" opacity="0.6"/>
      <circle cx="40" cy="20" r="1.5" fill="white" opacity="0.7"/>
      <circle cx="120" cy="50" r="1" fill="white" opacity="0.5"/>

      {/* Aurora waves */}
      <path d="M 0 60 Q 40 30 80 60 Q 120 90 160 60" stroke={colors.primary} strokeWidth="15" fill="none" opacity="0.5"/>
      <path d="M 0 70 Q 40 40 80 70 Q 120 100 160 70" stroke={colors.secondary} strokeWidth="12" fill="none" opacity="0.6"/>
      <path d="M 0 80 Q 40 50 80 80 Q 120 110 160 80" stroke={colors.accent} strokeWidth="8" fill="none" opacity="0.4"/>

      {/* Snowy ground */}
      <rect y="130" width="160" height="30" fill={colors.primary} opacity="0.3"/>

      {/* Pine trees silhouette */}
      <polygon points="30,130 40,100 50,130" fill={colors.secondary} opacity="0.6"/>
      <polygon points="35,110 40,95 45,110" fill={colors.secondary} opacity="0.6"/>
      <polygon points="70,130 85,90 100,130" fill={colors.secondary} opacity="0.6"/>
      <polygon points="78,105 85,85 92,105" fill={colors.secondary} opacity="0.6"/>
      <polygon points="120,130 132,100 144,130" fill={colors.secondary} opacity="0.6"/>
    </svg>
  );

  // Quantum illustration
  const QuantumScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Background */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Atom nucleus */}
      <circle cx="80" cy="80" r="12" fill={colors.primary} opacity="0.9"/>

      {/* Electron orbits */}
      <ellipse cx="80" cy="80" rx="50" ry="15" stroke={colors.secondary} strokeWidth="2" fill="none" opacity="0.7" transform="rotate(0 80 80)"/>
      <ellipse cx="80" cy="80" rx="50" ry="15" stroke={colors.secondary} strokeWidth="2" fill="none" opacity="0.7" transform="rotate(60 80 80)"/>
      <ellipse cx="80" cy="80" rx="50" ry="15" stroke={colors.secondary} strokeWidth="2" fill="none" opacity="0.7" transform="rotate(120 80 80)"/>

      {/* Electrons */}
      <circle cx="130" cy="80" r="5" fill={colors.accent} opacity="0.9"/>
      <circle cx="55" cy="125" r="5" fill={colors.accent} opacity="0.9"/>
      <circle cx="55" cy="35" r="5" fill={colors.accent} opacity="0.9"/>

      {/* Glow effect */}
      <circle cx="80" cy="80" r="60" fill={colors.primary} opacity="0.1"/>

      {/* Quantum particles */}
      <circle cx="30" cy="50" r="2" fill={colors.accent} opacity="0.6"/>
      <circle cx="130" cy="120" r="2" fill={colors.accent} opacity="0.6"/>
      <circle cx="120" cy="40" r="1.5" fill={colors.secondary} opacity="0.5"/>
      <circle cx="40" cy="110" r="1.5" fill={colors.secondary} opacity="0.5"/>
    </svg>
  );

  // Cyberpunk illustration
  const CyberpunkScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Night sky */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Grid/floor */}
      <g opacity="0.3">
        <line x1="0" y1="120" x2="160" y2="120" stroke={colors.primary} strokeWidth="1"/>
        <line x1="0" y1="140" x2="160" y2="140" stroke={colors.primary} strokeWidth="1"/>
        <line x1="40" y1="120" x2="20" y2="160" stroke={colors.primary} strokeWidth="1"/>
        <line x1="80" y1="120" x2="80" y2="160" stroke={colors.primary} strokeWidth="1"/>
        <line x1="120" y1="120" x2="140" y2="160" stroke={colors.primary} strokeWidth="1"/>
      </g>

      {/* Buildings */}
      <rect x="10" y="60" width="30" height="60" fill={colors.primary} opacity="0.6"/>
      <rect x="15" y="65" width="8" height="8" fill={colors.accent} opacity="0.9"/>
      <rect x="27" y="65" width="8" height="8" fill={colors.accent} opacity="0.7"/>
      <rect x="15" y="80" width="8" height="8" fill={colors.accent} opacity="0.8"/>
      <rect x="27" y="80" width="8" height="8" fill={colors.accent} opacity="0.6"/>

      <rect x="50" y="40" width="35" height="80" fill={colors.secondary} opacity="0.5"/>
      <rect x="55" y="45" width="10" height="10" fill={colors.accent} opacity="0.9"/>
      <rect x="70" y="45" width="10" height="10" fill={colors.accent} opacity="0.8"/>
      <rect x="55" y="60" width="10" height="10" fill={colors.accent} opacity="0.7"/>
      <rect x="70" y="60" width="10" height="10" fill={colors.accent} opacity="0.9"/>
      <rect x="55" y="75" width="10" height="10" fill={colors.accent} opacity="0.6"/>
      <rect x="70" y="75" width="10" height="10" fill={colors.accent} opacity="0.8"/>

      <rect x="100" y="70" width="40" height="50" fill={colors.primary} opacity="0.6"/>
      <rect x="105" y="75" width="10" height="8" fill={colors.accent} opacity="0.9"/>
      <rect x="120" y="75" width="10" height="8" fill={colors.accent} opacity="0.7"/>
      <rect x="105" y="88" width="10" height="8" fill={colors.accent} opacity="0.8"/>
      <rect x="120" y="88" width="10" height="8" fill={colors.accent} opacity="0.9"/>

      {/* Neon signs */}
      <text x="25" y="55" fontSize="8" fill={colors.accent} opacity="0.9">NEON</text>
      <text x="55" y="35" fontSize="10" fill={colors.primary} opacity="0.9">CYBER</text>

      {/* Glowing effects */}
      <circle cx="20" cy="100" r="3" fill={colors.accent} opacity="0.8"/>
      <circle cx="140" cy="90" r="3" fill={colors.accent} opacity="0.8"/>
    </svg>
  );

  // Crystal illustration
  const CrystalScene = () => (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      {/* Background */}
      <rect width="160" height="160" fill={colors.background}/>

      {/* Large crystal */}
      <polygon points="80,20 50,80 80,140 110,80" fill={colors.primary} opacity="0.8"/>
      <polygon points="80,20 65,50 80,50" fill={colors.accent} opacity="0.9"/>
      <polygon points="80,20 95,50 80,50" fill={colors.secondary} opacity="0.7"/>

      {/* Medium crystal */}
      <polygon points="30,80 15,120 45,120" fill={colors.secondary} opacity="0.7"/>
      <polygon points="30,80 22,95 30,95" fill={colors.accent} opacity="0.8"/>

      {/* Small crystal */}
      <polygon points="130,90 120,120 140,120" fill={colors.primary} opacity="0.6"/>
      <polygon points="130,90 125,100 130,100" fill={colors.secondary} opacity="0.7"/>

      {/* Sparkles */}
      <text x="50" y="40" fontSize="10" opacity="0.7">✦</text>
      <text x="110" y="50" fontSize="12" opacity="0.8">✦</text>
      <text x="70" y="100" fontSize="8" opacity="0.6">✦</text>
      <text x="120" y="70" fontSize="9" opacity="0.7">✦</text>

      {/* Glow */}
      <circle cx="80" cy="80" r="50" fill={colors.primary} opacity="0.1"/>
    </svg>
  );

  // Render appropriate scene
  const scenes = {
    space: SpaceScene,
    nature: NatureScene,
    fire: FireScene,
    ocean: OceanScene,
    arctic: ArcticScene,
    desert: DesertScene,
    sunset: SunsetScene,
    aurora: AuroraScene,
    quantum: QuantumScene,
    cyberpunk: CyberpunkScene,
    crystal: CrystalScene,
  };

  const SceneComponent = scenes[illustrationType as keyof typeof scenes] || SpaceScene;

  return (
    <div className={`theme-illustration ${className}`} style={{ display: 'inline-block' }}>
      <SceneComponent />
    </div>
  );
}
