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
  const lowerName = themeName.toLowerCase();

  // DEEP SPACE - Planets and galaxies
  if (lowerName.includes('deep space') || lowerName.includes('cosmic void')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <radialGradient id="void-glow">
            <stop offset="0%" stopColor={colors.primary} stopOpacity="0.4"/>
            <stop offset="100%" stopColor={colors.background} stopOpacity="0"/>
          </radialGradient>
        </defs>
        <rect width="160" height="160" fill={colors.background}/>
        <circle cx="80" cy="80" r="70" fill="url(#void-glow)" opacity="0.5"/>
        {Array.from({ length: 40 }, (_, i) => (
          <circle
            key={i}
            cx={Math.random() * 160}
            cy={Math.random() * 160}
            r={Math.random() * 1.5 + 0.5}
            fill="white"
            opacity={Math.random() * 0.7 + 0.2}
          />
        ))}
        <g transform="translate(80, 80)">
          <path d="M -50 0 Q -30 -20 0 -30 Q 30 -20 50 0 Q 30 20 0 30 Q -30 20 -50 0"
            fill={colors.primary} opacity="0.3"/>
          <circle cx="0" cy="0" r="15" fill={colors.secondary} opacity="0.8"/>
          <circle cx="0" cy="0" r="8" fill={colors.accent} opacity="0.9"/>
        </g>
      </svg>
    );
  }

  // NEBULA - Colorful clouds
  if (lowerName.includes('nebula') || lowerName.includes('stardust')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <filter id="nebula-blur">
            <feGaussianBlur in="SourceGraphic" stdDeviation="8"/>
          </filter>
        </defs>
        <rect width="160" height="160" fill={colors.background}/>
        <ellipse cx="60" cy="70" rx="50" ry="40" fill={colors.primary} opacity="0.4" filter="url(#nebula-blur)"/>
        <ellipse cx="100" cy="90" rx="45" ry="35" fill={colors.secondary} opacity="0.3" filter="url(#nebula-blur)"/>
        <ellipse cx="80" cy="80" rx="35" ry="25" fill={colors.accent} opacity="0.3" filter="url(#nebula-blur)"/>
        {Array.from({ length: 25 }, (_, i) => (
          <circle
            key={i}
            cx={Math.random() * 160}
            cy={Math.random() * 160}
            r={Math.random() * 2 + 0.5}
            fill="white"
            opacity={Math.random() * 0.9 + 0.3}
          />
        ))}
      </svg>
    );
  }

  // FOREST - Dense woodland with wildlife
  if (lowerName.includes('forest') || lowerName.includes('woodland') || lowerName.includes('enchanted')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <linearGradient id="forest-sky" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={colors.background}/>
            <stop offset="100%" stopColor={colors.secondary} stopOpacity="0.5"/>
          </linearGradient>
        </defs>
        <rect width="160" height="160" fill="url(#forest-sky)"/>
        <circle cx="140" cy="30" r="15" fill={colors.accent} opacity="0.6"/>
        <polygon points="10,160 40,80 70,160" fill={colors.primary} opacity="0.9"/>
        <polygon points="25,130 40,90 55,130" fill={colors.secondary} opacity="0.8"/>
        <polygon points="30,100 40,70 50,100" fill={colors.accent} opacity="0.7"/>
        <polygon points="50,160 90,70 130,160" fill={colors.primary} opacity="0.85"/>
        <polygon points="70,130 90,85 110,130" fill={colors.secondary} opacity="0.75"/>
        <polygon points="80,100 90,65 100,100" fill={colors.accent} opacity="0.7"/>
        <polygon points="100,160 130,90 160,160" fill={colors.primary} opacity="0.9"/>
        <polygon points="115,130 130,100 145,130" fill={colors.secondary} opacity="0.8"/>
        <ellipse cx="40" cy="145" rx="20" ry="8" fill={colors.accent} opacity="0.3"/>
        <ellipse cx="90" cy="150" rx="25" ry="10" fill={colors.accent} opacity="0.3"/>
      </svg>
    );
  }

  // VOLCANO - Erupting volcano with lava
  if (lowerName.includes('volcano') || lowerName.includes('inferno') || lowerName.includes('magma')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <rect width="160" height="160" fill={colors.background}/>
        <path d="M 0 130 L 20 110 L 40 125 L 60 105 L 80 120 L 100 100 L 120 115 L 140 95 L 160 110 L 160 160 L 0 160 Z"
          fill={colors.secondary} opacity="0.3"/>
        <path d="M 30 160 L 50 110 L 70 160" fill={colors.primary} opacity="0.9"/>
        <path d="M 50 160 L 70 100 L 90 160" fill={colors.primary} opacity="0.85"/>
        <path d="M 70 160 L 90 100 L 110 160" fill={colors.primary} opacity="0.85"/>
        <path d="M 90 160 L 110 100 L 130 160" fill={colors.primary} opacity="0.85"/>
        <path d="M 110 160 L 130 110 L 150 160" fill={colors.primary} opacity="0.9"/>
        <ellipse cx="80" cy="100" rx="20" ry="8" fill={colors.accent} opacity="0.9"/>
        <path d="M 70 100 Q 65 80 70 60 Q 75 40 70 25 Q 65 45 70 60 Q 75 80 70 100" fill={colors.accent} opacity="0.95"/>
        <path d="M 75 100 Q 70 75 75 50 Q 80 25 75 15 Q 70 40 75 50 Q 80 75 75 100" fill={colors.secondary} opacity="0.9"/>
        <path d="M 80 100 Q 75 70 80 40 Q 85 10 80 5 Q 75 35 80 40 Q 85 70 80 100" fill={colors.primary} opacity="0.95"/>
        <path d="M 85 100 Q 80 75 85 50 Q 90 25 85 15 Q 80 40 85 50 Q 90 75 85 100" fill={colors.secondary} opacity="0.9"/>
        <path d="M 90 100 Q 85 80 90 60 Q 95 40 90 25 Q 85 45 90 60 Q 95 80 90 100" fill={colors.accent} opacity="0.95"/>
        {Array.from({ length: 12 }, (_, i) => (
          <circle
            key={i}
            cx={60 + Math.random() * 40}
            cy={20 + Math.random() * 40}
            r={Math.random() * 2 + 1}
            fill={colors.accent}
            opacity={Math.random() * 0.8 + 0.2}
          />
        ))}
      </svg>
    );
  }

  // UNDERWATER - Ocean depths with sea creatures
  if (lowerName.includes('ocean') || lowerName.includes('abyss') || lowerName.includes('deep sea')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <linearGradient id="ocean-depth" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={colors.background}/>
            <stop offset="100%" stopColor={colors.primary} stopOpacity="0.5"/>
          </linearGradient>
        </defs>
        <rect width="160" height="160" fill="url(#ocean-depth)"/>
        <circle cx="130" cy="25" r="8" fill={colors.accent} opacity="0.4"/>
        <path d="M 0 100 Q 40 90 80 100 Q 120 110 160 100 L 160 160 L 0 160 Z" fill={colors.primary} opacity="0.3"/>
        <path d="M 0 120 Q 40 110 80 120 Q 120 130 160 120 L 160 160 L 0 160 Z" fill={colors.secondary} opacity="0.25"/>
        <path d="M 0 140 Q 40 130 80 140 Q 120 150 160 140 L 160 160 L 0 160 Z" fill={colors.primary} opacity="0.2"/>
        <ellipse cx="40" cy="60" rx="6" ry="3" fill={colors.accent} opacity="0.5"/>
        <path d="M 46 60 L 52 58 L 52 62 Z" fill={colors.accent} opacity="0.5"/>
        <ellipse cx="100" cy="80" rx="8" ry="4" fill={colors.secondary} opacity="0.4"/>
        <path d="M 108 80 L 117 77 L 117 83 Z" fill={colors.secondary} opacity="0.4"/>
        <ellipse cx="70" cy="110" rx="5" ry="2.5" fill={colors.accent} opacity="0.3"/>
        <path d="M 75 110 L 81 108 L 81 112 Z" fill={colors.accent} opacity="0.3"/>
        <path d="M 20 50 Q 25 45 30 50" stroke={colors.accent} strokeWidth="1" fill="none" opacity="0.4"/>
        <path d="M 120 70 Q 127 65 134 70" stroke={colors.secondary} strokeWidth="1" fill="none" opacity="0.3"/>
      </svg>
    );
  }

  // GLACIER - Ice caves and formations
  if (lowerName.includes('glacier') || lowerName.includes('ice cave') || lowerName.includes('frost')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <linearGradient id="ice-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={colors.background}/>
            <stop offset="100%" stopColor={colors.primary} stopOpacity="0.4"/>
          </linearGradient>
        </defs>
        <rect width="160" height="160" fill="url(#ice-gradient)"/>
        <path d="M 0 80 Q 40 70 80 80 Q 120 90 160 80" stroke={colors.primary} strokeWidth="4" fill="none" opacity="0.5"/>
        <path d="M 0 90 Q 40 80 80 90 Q 120 100 160 90" stroke={colors.secondary} strokeWidth="3" fill="none" opacity="0.6"/>
        <path d="M 0 100 Q 40 90 80 100 Q 120 110 160 100" stroke={colors.accent} strokeWidth="2" fill="none" opacity="0.4"/>
        <polygon points="30,160 50,100 70,160" fill={colors.primary} opacity="0.7"/>
        <polygon points="40,130 50,110 60,130" fill={colors.secondary} opacity="0.6"/>
        <polygon points="70,160 100,90 130,160" fill={colors.primary} opacity="0.75"/>
        <polygon points="85,130 100,105 115,130" fill={colors.secondary} opacity="0.65"/>
        <polygon points="85,110 100,90 115,110" fill={colors.accent} opacity="0.6"/>
        <text x="25" y="35" fontSize="14" opacity="0.5">❄</text>
        <text x="135" y="50" fontSize="12" opacity="0.4">❄</text>
        <text x="70" y="30" fontSize="10" opacity="0.3">❄</text>
        <text x="110" y="40" fontSize="11" opacity="0.45">❄</text>
        <text x="50" y="55" fontSize="9" opacity="0.35">❄</text>
      </svg>
    );
  }

  // SANDSTORM - Desert with swirling sand
  if (lowerName.includes('sandstorm') || lowerName.includes('dune') || lowerName.includes('sahara')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <filter id="sand-blur">
            <feGaussianBlur in="SourceGraphic" stdDeviation="3"/>
          </filter>
        </defs>
        <rect width="160" height="160" fill={colors.background}/>
        <circle cx="140" cy="30" r="20" fill={colors.accent} opacity="0.8"/>
        <path d="M 0 90 Q 30 75 60 90 Q 90 100 120 85 Q 150 75 160 90 L 160 160 L 0 160 Z"
          fill={colors.primary} opacity="0.7" filter="url(#sand-blur)"/>
        <path d="M 0 110 Q 40 95 80 110 Q 120 125 160 105 L 160 160 L 0 160 Z"
          fill={colors.secondary} opacity="0.6" filter="url(#sand-blur)"/>
        <path d="M 0 130 Q 50 115 100 130 Q 140 140 160 130 L 160 160 L 0 160 Z"
          fill={colors.accent} opacity="0.5" filter="url(#sand-blur)"/>
        {Array.from({ length: 15 }, (_, i) => (
          <path
            key={i}
            d={`M ${i * 10 + 20} 80 Q ${i * 10 + 25} 75 ${i * 10 + 30} 80`}
            stroke={colors.accent}
            strokeWidth="1"
            fill="none"
            opacity="0.4"
          />
        ))}
      </svg>
    );
  }

  // SUNSET - Dramatic sunset with silhouette
  if (lowerName.includes('sunset') || lowerName.includes('dusk') || lowerName.includes('twilight')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <linearGradient id="sunset-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={colors.background}/>
            <stop offset="40%" stopColor={colors.primary} stopOpacity="0.6"/>
            <stop offset="70%" stopColor={colors.secondary} stopOpacity="0.8"/>
            <stop offset="100%" stopColor={colors.accent} stopOpacity="0.9"/>
          </linearGradient>
        </defs>
        <rect width="160" height="160" fill="url(#sunset-gradient)"/>
        <circle cx="80" cy="90" r="22" fill={colors.accent} opacity="0.9"/>
        <circle cx="80" cy="90" r="26" fill={colors.secondary} opacity="0.3"/>
        <path d="M 0 130 L 30 110 L 50 125 L 80 100 L 110 120 L 140 105 L 160 115 L 160 160 L 0 160 Z"
          fill={colors.background} opacity="0.9"/>
        <ellipse cx="20" cy="50" rx="12" ry="6" fill={colors.primary} opacity="0.3"/>
        <ellipse cx="30" cy="48" rx="8" ry="4" fill={colors.primary} opacity="0.3"/>
        <ellipse cx="130" cy="55" rx="14" ry="7" fill={colors.secondary} opacity="0.25"/>
        <ellipse cx="142" cy="53" rx="10" ry="5" fill={colors.secondary} opacity="0.25"/>
      </svg>
    );
  }

  // AURORA - Northern lights over mountains
  if (lowerName.includes('aurora') || lowerName.includes('borealis') || lowerName.includes('polar')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <rect width="160" height="160" fill={colors.background}/>
        <circle cx="20" cy="30" r="1" fill="white" opacity="0.8"/>
        <circle cx="140" cy="25" r="1.2" fill="white" opacity="0.7"/>
        <circle cx="100" cy="20" r="0.8" fill="white" opacity="0.6"/>
        <circle cx="40" cy="35" r="1" fill="white" opacity="0.7"/>
        <circle cx="120" cy="30" r="1.1" fill="white" opacity="0.8"/>
        <circle cx="70" cy="25" r="0.9" fill="white" opacity="0.6"/>
        <circle cx="150" cy="40" r="1" fill="white" opacity="0.7"/>
        <path d="M 0 50 Q 40 20 80 50 Q 120 80 160 50" stroke={colors.primary} strokeWidth="12" fill="none" opacity="0.4"/>
        <path d="M 0 60 Q 40 30 80 60 Q 120 90 160 60" stroke={colors.secondary} strokeWidth="10" fill="none" opacity="0.5"/>
        <path d="M 0 70 Q 40 40 80 70 Q 120 100 160 70" stroke={colors.accent} strokeWidth="7" fill="none" opacity="0.35"/>
        <polygon points="20,160 50,100 80,160" fill={colors.primary} opacity="0.5"/>
        <polygon points="35,130 50,110 65,130" fill={colors.secondary} opacity="0.45"/>
        <polygon points="60,160 100,90 140,160" fill={colors.primary} opacity="0.55"/>
        <polygon points="80,130 100,105 120,130" fill={colors.secondary} opacity="0.5"/>
        <polygon points="85,110 100,90 115,110" fill={colors.accent} opacity="0.45"/>
        <rect y="140" width="160" height="20" fill={colors.primary} opacity="0.3"/>
      </svg>
    );
  }

  // QUANTUM - Subatomic particles
  if (lowerName.includes('quantum') || lowerName.includes('atomic') || lowerName.includes('particle')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <radialGradient id="quantum-glow">
            <stop offset="0%" stopColor={colors.accent} stopOpacity="0.8"/>
            <stop offset="100%" stopColor={colors.accent} stopOpacity="0"/>
          </radialGradient>
        </defs>
        <rect width="160" height="160" fill={colors.background}/>
        <g transform="translate(80, 80)">
          <ellipse cx="0" cy="0" rx="60" ry="18" stroke={colors.secondary} strokeWidth="2.5" fill="none" opacity="0.6" transform="rotate(0)"/>
          <ellipse cx="0" cy="0" rx="60" ry="18" stroke={colors.secondary} strokeWidth="2.5" fill="none" opacity="0.6" transform="rotate(60)"/>
          <ellipse cx="0" cy="0" rx="60" ry="18" stroke={colors.secondary} strokeWidth="2.5" fill="none" opacity="0.6" transform="rotate(120)"/>
          <circle cx="0" cy="0" r="14" fill={colors.primary} opacity="0.95"/>
          <circle cx="0" cy="0" r="8" fill={colors.accent} opacity="1"/>
          <circle cx="60" cy="0" r="6" fill={colors.accent} opacity="0.9"/>
          <circle cx="-30" cy="52" r="6" fill={colors.accent} opacity="0.9"/>
          <circle cx="-30" cy="-52" r="6" fill={colors.accent} opacity="0.9"/>
        </g>
        <circle cx="80" cy="80" r="70" fill="url(#quantum-glow)" opacity="0.3"/>
        {Array.from({ length: 10 }, (_, i) => (
          <circle
            key={i}
            cx={20 + Math.random() * 120}
            cy={20 + Math.random() * 120}
            r={Math.random() * 2 + 1}
            fill={colors.secondary}
            opacity={Math.random() * 0.6 + 0.2}
          />
        ))}
      </svg>
    );
  }

  // CYBERPUNK - Futuristic cityscape
  if (lowerName.includes('cyber') || lowerName.includes('neon') || lowerName.includes('synthwave')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <rect width="160" height="160" fill={colors.background}/>
        <g opacity="0.25">
          <line x1="0" y1="130" x2="160" y2="130" stroke={colors.primary} strokeWidth="1"/>
          <line x1="0" y1="145" x2="160" y2="145" stroke={colors.primary} strokeWidth="1"/>
          <line x1="40" y1="130" x2="20" y2="160" stroke={colors.primary} strokeWidth="1"/>
          <line x1="80" y1="130" x2="80" y2="160" stroke={colors.primary} strokeWidth="1"/>
          <line x1="120" y1="130" x2="140" y2="160" stroke={colors.primary} strokeWidth="1"/>
        </g>
        <rect x="5" y="70" width="30" height="60" fill={colors.primary} opacity="0.7"/>
        <rect x="8" y="75" width="6" height="6" fill={colors.accent} opacity="0.95"/>
        <rect x="18" y="75" width="6" height="6" fill={colors.accent} opacity="0.85"/>
        <rect x="8" y="88" width="6" height="6" fill={colors.accent} opacity="0.9"/>
        <rect x="18" y="88" width="6" height="6" fill={colors.accent} opacity="0.8"/>
        <rect x="8" y="101" width="6" height="6" fill={colors.accent} opacity="0.88"/>
        <rect x="18" y="101" width="6" height="6" fill={colors.accent} opacity="0.78"/>
        <rect x="8" y="114" width="6" height="6" fill={colors.accent} opacity="0.92"/>
        <rect x="18" y="114" width="6" height="6" fill={colors.accent} opacity="0.82"/>
        <rect x="45" y="50" width="35" height="80" fill={colors.secondary} opacity="0.65"/>
        <rect x="50" y="55" width="8" height="8" fill={colors.accent} opacity="1"/>
        <rect x="63" y="55" width="8" height="8" fill={colors.accent} opacity="0.9"/>
        <rect x="50" y="70" width="8" height="8" fill={colors.accent} opacity="0.95"/>
        <rect x="63" y="70" width="8" height="8" fill={colors.accent} opacity="0.85"/>
        <rect x="50" y="85" width="8" height="8" fill={colors.accent} opacity="0.88"/>
        <rect x="63" y="85" width="8" height="8" fill={colors.accent} opacity="0.78"/>
        <rect x="50" y="100" width="8" height="8" fill={colors.accent} opacity="0.92"/>
        <rect x="63" y="100" width="8" height="8" fill={colors.accent} opacity="0.82"/>
        <rect x="50" y="115" width="8" height="8" fill={colors.accent} opacity="0.9"/>
        <rect x="63" y="115" width="8" height="8" fill={colors.accent} opacity="0.8"/>
        <rect x="95" y="65" width="40" height="65" fill={colors.primary} opacity="0.7"/>
        <rect x="100" y="70" width="7" height="7" fill={colors.accent} opacity="0.95"/>
        <rect x="113" y="70" width="7" height="7" fill={colors.accent} opacity="0.85"/>
        <rect x="126" y="70" width="7" height="7" fill={colors.accent} opacity="0.9"/>
        <rect x="100" y="83" width="7" height="7" fill={colors.accent} opacity="0.88"/>
        <rect x="113" y="83" width="7" height="7" fill={colors.accent} opacity="0.78"/>
        <rect x="126" y="83" width="7" height="7" fill={colors.accent} opacity="0.92"/>
        <rect x="100" y="96" width="7" height="7" fill={colors.accent} opacity="0.9"/>
        <rect x="113" y="96" width="7" height="7" fill={colors.accent} opacity="0.8"/>
        <rect x="126" y="96" width="7" height="7" fill={colors.accent} opacity="0.85"/>
        <rect x="100" y="109" width="7" height="7" fill={colors.accent} opacity="0.93"/>
        <rect x="113" y="109" width="7" height="7" fill={colors.accent} opacity="0.83"/>
        <rect x="126" y="109" width="7" height="7" fill={colors.accent} opacity="0.88"/>
        <rect x="100" y="122" width="7" height="7" fill={colors.accent} opacity="0.91"/>
        <rect x="113" y="122" width="7" height="7" fill={colors.accent} opacity="0.81"/>
        <rect x="126" y="122" width="7" height="7" fill={colors.accent} opacity="0.86"/>
      </svg>
    );
  }

  // CRYSTAL - Geometric crystal formations
  if (lowerName.includes('crystal') || lowerName.includes('gem') || lowerName.includes('diamond')) {
    return (
      <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
        <defs>
          <linearGradient id="crystal-shine" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stopColor={colors.accent} stopOpacity="0.8"/>
            <stop offset="50%" stopColor={colors.primary} stopOpacity="0.6"/>
            <stop offset="100%" stopColor={colors.secondary} stopOpacity="0.4"/>
          </linearGradient>
        </defs>
        <rect width="160" height="160" fill={colors.background}/>
        <polygon points="80,10 45,75 80,150 115,75" fill="url(#crystal-shine)" opacity="0.9"/>
        <polygon points="80,10 62,42 80,42" fill={colors.accent} opacity="0.95"/>
        <polygon points="80,10 98,42 80,42" fill={colors.secondary} opacity="0.85"/>
        <polygon points="45,75 62,42 80,42 80,75" fill={colors.primary} opacity="0.7"/>
        <polygon points="115,75 98,42 80,42 80,75" fill={colors.secondary} opacity="0.75"/>
        <polygon points="20,130 5,160 35,160" fill={colors.primary} opacity="0.75"/>
        <polygon points="20,130 12,145 20,145" fill={colors.accent} opacity="0.85"/>
        <polygon points="130,130 115,160 145,160" fill={colors.secondary} opacity="0.7"/>
        <polygon points="130,130 123,143 130,143" fill={colors.primary} opacity="0.8"/>
        <text x="55" y="35" fontSize="14" opacity="0.7">✦</text>
        <text x="105" y="45" fontSize="16" opacity="0.8">✦</text>
        <text x="65" y="95" fontSize="12" opacity="0.6">✦</text>
        <text x="100" y="100" fontSize="10" opacity="0.65">✦</text>
        <text x="40" y="115" fontSize="11" opacity="0.55">✦</text>
        <text x="115" y="110" fontSize="13" opacity="0.75">✦</text>
        <circle cx="80" cy="80" r="55" fill={colors.primary} opacity="0.1"/>
      </svg>
    );
  }

  // Default - Generic space scene
  return (
    <svg viewBox="0 0 160 160" style={{ width: size, height: size }}>
      <defs>
        <radialGradient id="default-glow">
          <stop offset="0%" stopColor={colors.primary} stopOpacity="0.5"/>
          <stop offset="100%" stopColor={colors.background} stopOpacity="0"/>
        </radialGradient>
      </defs>
      <rect width="160" height="160" fill={colors.background}/>
      <circle cx="80" cy="80" r="60" fill="url(#default-glow)" opacity="0.4"/>
      {Array.from({ length: 30 }, (_, i) => (
        <circle
          key={i}
          cx={Math.random() * 160}
          cy={Math.random() * 160}
          r={Math.random() * 1.5 + 0.5}
          fill="white"
          opacity={Math.random() * 0.8 + 0.2}
        />
      ))}
      <circle cx="80" cy="80" r="30" fill={colors.primary} opacity="0.7"/>
      <circle cx="80" cy="80" r="22" fill={colors.secondary} opacity="0.6"/>
      <ellipse cx="80" cy="80" rx="45" ry="7" fill="none" stroke={colors.accent} strokeWidth="2.5" opacity="0.7"/>
      <circle cx="130" cy="45" r="10" fill={colors.primary} opacity="0.6"/>
      <circle cx="130" cy="45" r="6" fill={colors.secondary} opacity="0.5"/>
    </svg>
  );
}
