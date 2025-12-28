import React from "react";

interface AnimeAvatarProps {
  avatarType: string;
  rarity: string;
  size?: number;
  className?: string;
}

export function AnimeAvatar({ avatarType, rarity, size = 120, className = "" }: AnimeAvatarProps) {
  const rarityColors = {
    common: { primary: "#9ca3af", secondary: "#6b7280", glow: "rgba(156, 163, 175, 0.3)" },
    uncommon: { primary: "#22c55e", secondary: "#16a34a", glow: "rgba(34, 197, 94, 0.3)" },
    rare: { primary: "#3b82f6", secondary: "#2563eb", glow: "rgba(59, 130, 246, 0.3)" },
    epic: { primary: "#a855f7", secondary: "#9333ea", glow: "rgba(168, 85, 247, 0.3)" },
    legendary: { primary: "#f97316", secondary: "#ea580c", glow: "rgba(249, 115, 22, 0.3)" },
    mythical: { primary: "#ec4899", secondary: "#db2777", glow: "rgba(236, 72, 153, 0.3)" },
    godly: { primary: "#fbbf24", secondary: "#f59e0b", glow: "rgba(251, 191, 36, 0.3)" },
  };

  const colors = rarityColors[rarity as keyof typeof rarityColors] || rarityColors.common;
  const lowerName = avatarType.toLowerCase();

  // NOVICE SCIENTIST - Young beginner with glasses and lab coat
  if (lowerName.includes('novice') || lowerName.includes('beginner')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
        <ellipse cx="60" cy="42" rx="32" ry="25" fill="#8B7355"/>
        <ellipse cx="60" cy="38" rx="28" ry="20" fill="#6B5344"/>
        <ellipse cx="48" cy="62" rx="6" ry="8" fill="white"/>
        <ellipse cx="72" cy="62" rx="6" ry="8" fill="white"/>
        <circle cx="48" cy="64" r="4" fill="#1a202c"/>
        <circle cx="72" cy="64" r="4" fill="#1a202c"/>
        <circle cx="48" cy="62" r="2" fill="white"/>
        <circle cx="72" cy="62" r="2" fill="white"/>
        <g stroke={colors.secondary} strokeWidth="2" fill="none">
          <circle cx="48" cy="62" r="10"/>
          <circle cx="72" cy="62" r="10"/>
          <line x1="58" y1="62" x2="62" y2="62"/>
        </g>
        <path d="M 50 75 Q 60 82 70 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <path d="M 25 110 L 25 120 L 95 120 L 95 110" fill="white" stroke={colors.primary} strokeWidth="2"/>
        <circle cx="60" cy="100" r="8" fill={colors.primary} opacity="0.5"/>
      </svg>
    );
  }

  // RESEARCHER - Determined with spiky hair
  if (lowerName.includes('researcher') || lowerName.includes('scholar')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
        <path d="M 30 35 L 35 15 L 45 25 L 50 10 L 55 25 L 60 12 L 65 25 L 70 10 L 75 25 L 85 15 L 90 35" fill="#2d3748"/>
        <ellipse cx="48" cy="62" rx="7" ry="6" fill="white"/>
        <ellipse cx="72" cy="62" rx="7" ry="6" fill="white"/>
        <circle cx="48" cy="62" r="5" fill={colors.primary}/>
        <circle cx="72" cy="62" r="5" fill={colors.primary}/>
        <circle cx="48" cy="60" r="2" fill="white"/>
        <circle cx="72" cy="60" r="2" fill="white"/>
        <line x1="42" y1="54" x2="38" y2="50" stroke="#2d3748" strokeWidth="2"/>
        <line x1="78" y1="54" x2="82" y2="50" stroke="#2d3748" strokeWidth="2"/>
        <path d="M 52 74 Q 60 78 68 74" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <path d="M 25 110 L 25 120 L 95 120 L 95 110" fill="white" stroke={colors.primary} strokeWidth="2"/>
        <rect x="55" y="112" width="10" height="12" fill={colors.primary} rx="2"/>
      </svg>
    );
  }

  // ASTRONOMER - Stargazer with telescope
  if (lowerName.includes('astronomer') || lowerName.includes('stargazer')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
        <ellipse cx="60" cy="40" rx="34" ry="26" fill="#5c4033"/>
        <path d="M 30 40 Q 25 55 35 60" fill="#5c4033"/>
        <path d="M 90 40 Q 95 55 85 60" fill="#5c4033"/>
        <ellipse cx="48" cy="62" rx="8" ry="8" fill="white"/>
        <ellipse cx="72" cy="62" rx="8" ry="8" fill="white"/>
        <circle cx="48" cy="62" r="5" fill={colors.primary}/>
        <circle cx="72" cy="62" r="5" fill={colors.primary}/>
        <path d="M 38 52 L 40 48 L 44 52 L 40 56 Z" fill={colors.secondary}/>
        <path d="M 76 52 L 78 48 L 82 52 L 78 56 Z" fill={colors.secondary}/>
        <circle cx="60" cy="78" r="3" fill="#2d3748"/>
        <rect x="45" y="95" width="30" height="8" fill={colors.secondary} rx="4"/>
        <circle cx="75" cy="99" r="6" fill={colors.primary}/>
        <circle cx="15" cy="30" r="2" fill="white" opacity="0.9"/>
        <circle cx="105" cy="25" r="1.5" fill="white" opacity="0.7"/>
        <circle cx="20" cy="50" r="1" fill="white" opacity="0.8"/>
      </svg>
    );
  }

  // PROFESSOR - Wise with gray hair and beard
  if (lowerName.includes('professor') || lowerName.includes('teacher') || lowerName.includes('mentor')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
        <ellipse cx="60" cy="42" rx="32" ry="22" fill="#9ca3af"/>
        <path d="M 28 42 Q 30 35 35 38" fill="#9ca3af"/>
        <path d="M 92 42 Q 90 35 85 38" fill="#9ca3af"/>
        <ellipse cx="48" cy="64" rx="9" ry="7" fill="white"/>
        <ellipse cx="72" cy="64" rx="9" ry="7" fill="white"/>
        <circle cx="48" cy="65" r="6" fill={colors.primary}/>
        <circle cx="72" cy="65" r="6" fill={colors.primary}/>
        <path d="M 40 55 Q 48 52 56 55" stroke="#9ca3af" strokeWidth="3" fill="none"/>
        <path d="M 64 55 Q 72 52 80 55" stroke="#9ca3af" strokeWidth="3" fill="none"/>
        <path d="M 45 76 Q 60 84 75 76" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <path d="M 40 88 Q 60 95 80 88" fill="#9ca3af"/>
        <rect x="30" y="25" width="60" height="20" fill={colors.secondary} rx="3"/>
        <rect x="55" y="45" width="10" height="5" fill={colors.secondary} rx="2"/>
        <circle cx="35" cy="35" r="3" fill="#fbbf24"/>
      </svg>
    );
  }

  // NOBEL WINNER - Proud with crown and medal
  if (lowerName.includes('nobel') || lowerName.includes('winner') || lowerName.includes('champion')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
        <ellipse cx="60" cy="40" rx="32" ry="24" fill="#8b7355"/>
        <path d="M 35 30 L 40 15 L 50 25 L 60 10 L 70 25 L 80 15 L 85 30" fill={colors.secondary} stroke={colors.primary} strokeWidth="2"/>
        <circle cx="45" cy="25" r="4" fill={colors.primary}/>
        <circle cx="60" cy="22" r="4" fill={colors.primary}/>
        <circle cx="75" cy="25" r="4" fill={colors.primary}/>
        <ellipse cx="48" cy="62" rx="8" ry="8" fill="white"/>
        <ellipse cx="72" cy="62" rx="8" ry="8" fill="white"/>
        <circle cx="48" cy="62" r="6" fill={colors.primary}/>
        <circle cx="72" cy="62" r="6" fill={colors.primary}/>
        <circle cx="48" cy="59" r="2" fill="white"/>
        <circle cx="72" cy="59" r="2" fill="white"/>
        <path d="M 45 74 Q 60 82 75 74" stroke="#2d3748" strokeWidth="3" fill="none"/>
        <circle cx="60" cy="105" r="12" fill={colors.primary} stroke={colors.secondary} strokeWidth="2"/>
        <text x="60" y="109" textAnchor="middle" fontSize="10" fill="white" fontWeight="bold">★</text>
        <path d="M 30 50 L 35 45 L 40 50 L 35 55 Z" fill={colors.primary} opacity="0.6"/>
        <path d="M 80 50 L 85 45 L 90 50 L 85 55 Z" fill={colors.primary} opacity="0.6"/>
      </svg>
    );
  }

  // DRAGON MASTER - Fierce with dragon elements
  if (lowerName.includes('dragon') || lowerName.includes('master') || lowerName.includes('warrior')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <path d="M 10 50 Q 30 30 60 40 Q 90 30 110 50" fill={colors.secondary} opacity="0.3"/>
        <ellipse cx="60" cy="65" rx="32" ry="35" fill="#ffe4c4"/>
        <path d="M 25 30 L 35 10 L 45 25 L 50 8 L 55 22 L 60 5 L 65 22 L 70 8 L 75 25 L 85 10 L 95 30" fill={colors.primary}/>
        <ellipse cx="48" cy="62" rx="9" ry="7" fill="white"/>
        <ellipse cx="72" cy="62" rx="9" ry="7" fill="white"/>
        <ellipse cx="48" cy="64" r="7" fill={colors.secondary}/>
        <ellipse cx="72" cy="64" r="7" fill={colors.secondary}/>
        <path d="M 35 52 L 40 58 M 85 52 L 80 58" stroke="#2d3748" strokeWidth="3"/>
        <path d="M 40 75 Q 60 85 80 75" stroke="#2d3748" strokeWidth="3" fill="none"/>
        <circle cx="30" cy="90" r="5" fill={colors.primary} opacity="0.5"/>
        <circle cx="45" cy="95" r="5" fill={colors.primary} opacity="0.5"/>
        <circle cx="75" cy="95" r="5" fill={colors.primary} opacity="0.5"/>
        <circle cx="90" cy="90" r="5" fill={colors.primary} opacity="0.5"/>
        <path d="M 20 35 L 25 30 L 30 35" stroke={colors.secondary} strokeWidth="2" fill="none"/>
        <path d="M 90 35 L 95 30 L 100 35" stroke={colors.secondary} strokeWidth="2" fill="none"/>
      </svg>
    );
  }

  // QUANTUM DEITY - Ethereal with third eye
  if (lowerName.includes('quantum') || lowerName.includes('deity') || lowerName.includes('mystic')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <defs>
          <radialGradient id="quantum-aura">
            <stop offset="0%" stopColor={colors.primary} stopOpacity="0.6"/>
            <stop offset="100%" stopColor={colors.primary} stopOpacity="0"/>
          </radialGradient>
        </defs>
        <circle cx="60" cy="60" r="55" fill="url(#quantum-aura)"/>
        <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
        <ellipse cx="60" cy="38" rx="35" ry="28" fill={colors.primary} opacity="0.8"/>
        <path d="M 30 35 Q 25 50 30 60" fill={colors.primary} opacity="0.5"/>
        <path d="M 90 35 Q 95 50 90 60" fill={colors.primary} opacity="0.5"/>
        <ellipse cx="48" cy="62" rx="10" ry="10" fill="white"/>
        <ellipse cx="72" cy="62" rx="10" ry="10" fill="white"/>
        <circle cx="48" cy="62" r="8" fill={colors.secondary}/>
        <circle cx="72" cy="62" r="8" fill={colors.secondary}/>
        <circle cx="48" cy="59" r="4" fill="white"/>
        <circle cx="72" cy="59" r="4" fill="white"/>
        <circle cx="60" cy="48" r="6" fill={colors.secondary} opacity="0.8"/>
        <circle cx="60" cy="48" r="3" fill={colors.accent || "#fbbf24"}/>
        <path d="M 48 75 Q 60 80 72 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <text x="20" y="40" fontSize="16" opacity="0.6">✨</text>
        <text x="95" y="35" fontSize="16" opacity="0.6">✨</text>
        <text x="15" y="90" fontSize="14" opacity="0.5">⚛</text>
        <text x="95" y="85" fontSize="14" opacity="0.5">🔮</text>
      </svg>
    );
  }

  // THE ABSOLUTE - Divine being with cosmic power
  if (lowerName.includes('absolute') || lowerName.includes('supreme') || lowerName.includes('ultimate')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <defs>
          <radialGradient id="cosmic-supreme">
            <stop offset="0%" stopColor={colors.primary} stopOpacity="0.8"/>
            <stop offset="50%" stopColor={colors.secondary} stopOpacity="0.4"/>
            <stop offset="100%" stopColor={colors.primary} stopOpacity="0"/>
          </radialGradient>
        </defs>
        <circle cx="60" cy="60" r="58" fill="url(#cosmic-supreme)"/>
        <ellipse cx="60" cy="65" rx="32" ry="36" fill="#ffe4c4"/>
        <ellipse cx="60" cy="35" rx="36" ry="30" fill={colors.primary}/>
        <path d="M 22 30 Q 20 50 25 70" fill={colors.secondary} opacity="0.7"/>
        <path d="M 98 30 Q 100 50 95 70" fill={colors.secondary} opacity="0.7"/>
        <ellipse cx="48" cy="62" rx="12" ry="10" fill="white"/>
        <ellipse cx="72" cy="62" rx="12" ry="10" fill="white"/>
        <circle cx="48" cy="62" r="10" fill={colors.primary}/>
        <circle cx="72" cy="62" r="10" fill={colors.primary}/>
        <circle cx="48" cy="60" r="5" fill={colors.secondary}/>
        <circle cx="72" cy="60" r="5" fill={colors.secondary}/>
        <path d="M 30 25 L 40 5 L 50 20 L 60 0 L 70 20 L 80 5 L 90 25" fill={colors.secondary}/>
        <circle cx="40" cy="20" r="5" fill={colors.primary}/>
        <circle cx="60" cy="18" r="6" fill={colors.primary}/>
        <circle cx="80" cy="20" r="5" fill={colors.primary}/>
        <path d="M 42 74 Q 60 86 78 74" stroke="#2d3748" strokeWidth="3" fill="none"/>
        <text x="18" y="38" fontSize="14">🌟</text>
        <text x="95" y="32" fontSize="14">⭐</text>
        <text x="12" y="82" fontSize="12">💫</text>
        <text x="100" y="80" fontSize="12">✨</text>
        <text x="30" y="105" fontSize="11">🌀</text>
        <text x="80" y="108" fontSize="11">🔱</text>
      </svg>
    );
  }

  // EXPLORER - Adventurer with compass and map
  if (lowerName.includes('explorer') || lowerName.includes('adventurer')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
        <path d="M 30 35 L 40 20 L 50 30 L 60 15 L 70 30 L 80 20 L 90 35" fill="#8B4513"/>
        <ellipse cx="48" cy="62" rx="8" ry="7" fill="white"/>
        <ellipse cx="72" cy="62" rx="8" ry="7" fill="white"/>
        <circle cx="48" cy="63" r="5" fill="#10b981"/>
        <circle cx="72" cy="63" r="5" fill="#10b981"/>
        <circle cx="48" cy="61" r="2" fill="white"/>
        <circle cx="72" cy="61" r="2" fill="white"/>
        <path d="M 50 76 Q 60 82 70 76" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <circle cx="100" cy="95" r="12" fill={colors.primary} stroke="#8B4513" strokeWidth="3"/>
        <line x1="100" y1="95" x2="100" y2="87" stroke="#ef4444" strokeWidth="2"/>
        <line x1="100" y1="95" x2="93" y2="100" stroke="#2d3748" strokeWidth="2"/>
        <circle cx="100" cy="95" r="3" fill={colors.secondary}/>
        <rect x="20" y="95" width="25" height="20" fill="#d4a574" rx="2"/>
        <path d="M 22 97 L 40 97 L 40 110 L 22 110 Z" stroke="#8B4513" strokeWidth="1" fill="none"/>
        <path d="M 25 100 Q 30 105 35 100" stroke={colors.primary} strokeWidth="1" fill="none"/>
        <path d="M 28 105 Q 33 108 38 105" stroke={colors.secondary} strokeWidth="1" fill="none"/>
      </svg>
    );
  }

  // INVENTOR - Creative with goggles and gears
  if (lowerName.includes('inventor') || lowerName.includes('engineer') || lowerName.includes('creator')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="34" ry="37" fill="#ffe4c4"/>
        <ellipse cx="60" cy="42" rx="30" ry="22" fill="#f59e0b"/>
        <ellipse cx="48" cy="62" rx="9" ry="7" fill="white"/>
        <ellipse cx="72" cy="62" rx="9" ry="7" fill="white"/>
        <circle cx="48" cy="63" r="6" fill="#3b82f6"/>
        <circle cx="72" cy="63" r="6" fill="#3b82f6"/>
        <circle cx="48" cy="61" r="2" fill="white"/>
        <circle cx="72" cy="61" r="2" fill="white"/>
        <g stroke="#6b7280" strokeWidth="3" fill="none">
          <circle cx="48" cy="62" r="12"/>
          <circle cx="72" cy="62" r="12"/>
          <line x1="60" y1="62" x2="60" y2="62"/>
        </g>
        <path d="M 52 74 Q 60 80 68 74" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <circle cx="30" cy="100" r="8" fill={colors.primary} stroke={colors.secondary} strokeWidth="2"/>
        <circle cx="30" cy="100" r="4" fill="#6b7280"/>
        <circle cx="90" cy="100" r="10" fill={colors.secondary} stroke={colors.primary} strokeWidth="2"/>
        <circle cx="90" cy="100" r="5" fill="#6b7280"/>
        <path d="M 38 100 L 50 95" stroke={colors.secondary} strokeWidth="2"/>
        <path d="M 80 100 L 70 95" stroke={colors.primary} strokeWidth="2"/>
        <rect x="55" y="15" width="10" height="8" fill="#6b7280" rx="1"/>
      </svg>
    );
  }

  // ALCHEMIST - Mystical with flask and symbols
  if (lowerName.includes('alchemist') || lowerName.includes('chemist') || lowerName.includes('potion')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="32" ry="35" fill="#ffe4c4"/>
        <ellipse cx="60" cy="40" rx="32" ry="24" fill="#9333ea"/>
        <path d="M 28 42 Q 25 55 32 60" fill="#9333ea" opacity="0.7"/>
        <path d="M 92 42 Q 95 55 88 60" fill="#9333ea" opacity="0.7"/>
        <ellipse cx="48" cy="62" rx="8" ry="8" fill="white"/>
        <ellipse cx="72" cy="62" rx="8" ry="8" fill="white"/>
        <circle cx="48" cy="62" r="5" fill="#a855f7"/>
        <circle cx="72" cy="62" r="5" fill="#a855f7"/>
        <circle cx="48" cy="60" r="2" fill="white"/>
        <circle cx="72" cy="60" r="2" fill="white"/>
        <path d="M 48 75 Q 60 82 72 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <path d="M 25 95 L 25 115 L 55 115" stroke={colors.secondary} strokeWidth="3" fill="none"/>
        <ellipse cx="40" cy="115" rx="15" ry="8" fill={colors.primary} opacity="0.7"/>
        <rect x="35" y="85" width="10" height="10" fill={colors.secondary} opacity="0.8"/>
        <circle cx="95" cy="90" r="6" fill={colors.accent || "#ec4899"}/>
        <text x="95" y="93" textAnchor="middle" fontSize="8" fill="white">☿</text>
        <circle cx="15" cy="45" r="3" fill={colors.primary} opacity="0.6"/>
        <circle cx="105" cy="50" r="2" fill={colors.secondary} opacity="0.5"/>
        <path d="M 100 35 L 105 30 L 110 35" stroke={colors.accent} strokeWidth="1" fill="none"/>
      </svg>
    );
  }

  // TIME TRAVELER - Futuristic with clock elements
  if (lowerName.includes('time') || lowerName.includes('chronos') || lowerName.includes('temporal')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
        <path d="M 28 35 L 38 18 L 50 28 L 60 12 L 70 28 L 82 18 L 92 35" fill="#06b6d4"/>
        <ellipse cx="48" cy="62" rx="9" ry="8" fill="white"/>
        <ellipse cx="72" cy="62" rx="9" ry="8" fill="white"/>
        <circle cx="48" cy="63" r="6" fill={colors.primary}/>
        <circle cx="72" cy="63" r="6" fill={colors.primary}/>
        <circle cx="48" cy="61" r="2" fill="white"/>
        <circle cx="72" cy="61" r="2" fill="white"/>
        <path d="M 50 75 Q 60 82 70 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <circle cx="95" cy="95" r="15" fill={colors.secondary} stroke={colors.primary} strokeWidth="3"/>
        <circle cx="95" cy="95" r="12" fill={colors.background} stroke="#6b7280" strokeWidth="1"/>
        <line x1="95" y1="95" x2="95" y2="87" stroke={colors.primary} strokeWidth="2"/>
        <line x1="95" y1="95" x2="102" y2="95" stroke={colors.secondary} strokeWidth="2"/>
        <circle cx="95" cy="95" r="2" fill={colors.accent || "#fbbf24"}/>
        <circle cx="25" cy="95" r="10" fill={colors.primary} opacity="0.6" stroke={colors.secondary} strokeWidth="2"/>
        <circle cx="25" cy="95" r="7" fill={colors.background} stroke="#6b7280" strokeWidth="1"/>
        <line x1="25" y1="95" x2="30" y2="90" stroke={colors.primary} strokeWidth="1.5"/>
        <path d="M 45 25 L 50 20 L 55 25" stroke={colors.accent} strokeWidth="2" fill="none"/>
      </svg>
    );
  }

  // ROBOTICS EXPERT - Tech-focused with robot companion
  if (lowerName.includes('robot') || lowerName.includes('cyborg') || lowerName.includes('mech')) {
    return (
      <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
        <circle cx="60" cy="60" r="55" fill={colors.glow}/>
        <ellipse cx="60" cy="65" rx="32" ry="35" fill="#ffe4c4"/>
        <ellipse cx="60" cy="42" rx="28" ry="20" fill="#1f2937"/>
        <ellipse cx="48" cy="62" rx="7" ry="6" fill="white"/>
        <ellipse cx="72" cy="62" rx="7" ry="6" fill="white"/>
        <circle cx="48" cy="62" r="5" fill={colors.primary}/>
        <circle cx="72" cy="62" r="5" fill={colors.primary}/>
        <circle cx="48" cy="60" r="2" fill="white"/>
        <circle cx="72" cy="60" r="2" fill="white"/>
        <path d="M 52 74 Q 60 80 68 74" stroke="#2d3748" strokeWidth="2" fill="none"/>
        <g opacity="0.9">
          <rect x="15" y="90" width="30" height="25" fill={colors.primary} rx="3"/>
          <rect x="18" y="95" width="8" height="8" fill={colors.accent || "#06b6d4"}/>
          <rect x="30" y="95" width="8" height="8" fill={colors.accent || "#06b6d4"}/>
          <path d="M 22 110 L 25 115 L 28 110" stroke={colors.secondary} strokeWidth="2" fill="none"/>
          <circle cx="75" cy="102" r="12" fill={colors.secondary} stroke={colors.primary} strokeWidth="2"/>
          <circle cx="75" cy="102" r="8" fill="#1f2937"/>
          <circle cx="73" cy="100" r="3" fill={colors.accent || "#06b6d4"}/>
          <circle cx="78" cy="104" r="2" fill={colors.accent || "#06b6d4"}/>
        </g>
        <path d="M 40 25 L 45 20 L 50 25" stroke={colors.secondary} strokeWidth="1.5" fill="none"/>
        <path d="M 70 25 L 75 20 L 80 25" stroke={colors.secondary} strokeWidth="1.5" fill="none"/>
      </svg>
    );
  }

  // Default character
  return (
    <svg viewBox="0 0 120 120" style={{ width: size, height: size }} className={className}>
      <circle cx="60" cy="60" r="55" fill={colors.glow}/>
      <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
      <ellipse cx="60" cy="42" rx="32" ry="25" fill="#4a5568"/>
      <ellipse cx="60" cy="38" rx="28" ry="20" fill="#2d3748"/>
      <ellipse cx="48" cy="62" rx="6" ry="8" fill="white"/>
      <ellipse cx="72" cy="62" rx="6" ry="8" fill="white"/>
      <circle cx="48" cy="64" r="4" fill="#1a202c"/>
      <circle cx="72" cy="64" r="4" fill="#1a202c"/>
      <circle cx="48" cy="62" r="2" fill="white"/>
      <circle cx="72" cy="62" r="2" fill="white"/>
      <path d="M 50 75 Q 60 82 70 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
      <path d="M 25 110 L 25 120 L 95 120 L 95 110" fill="white" stroke={colors.primary} strokeWidth="2"/>
      <circle cx="60" cy="100" r="8" fill={colors.primary} opacity="0.5"/>
    </svg>
  );
}
