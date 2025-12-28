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

  // Anime-style character SVG illustrations based on avatar type
  const getAvatarSVG = (type: string) => {
    const commonStyles = {
      width: size,
      height: size,
      filter: `drop-shadow(0 0 20px ${colors.glow})`,
    };

    // Different anime character designs based on type
    const designs: Record<string, React.ReactNode> = {
      // COMMON - Novice Characters
      "Novice Scientist": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          {/* Background circle */}
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
          {/* Hair */}
          <ellipse cx="60" cy="42" rx="32" ry="25" fill="#4a5568"/>
          <ellipse cx="60" cy="38" rx="28" ry="20" fill="#2d3748"/>
          {/* Eyes */}
          <ellipse cx="48" cy="62" rx="6" ry="8" fill="white"/>
          <ellipse cx="72" cy="62" rx="6" ry="8" fill="white"/>
          <circle cx="48" cy="64" r="4" fill="#1a202c"/>
          <circle cx="72" cy="64" r="4" fill="#1a202c"/>
          <circle cx="48" cy="62" r="2" fill="white"/>
          <circle cx="72" cy="62" r="2" fill="white"/>
          {/* Glasses */}
          <g stroke={colors.secondary} strokeWidth="2" fill="none">
            <circle cx="48" cy="62" r="10"/>
            <circle cx="72" cy="62" r="10"/>
            <line x1="58" y1="62" x2="62" y2="62"/>
          </g>
          {/* Smile */}
          <path d="M 50 75 Q 60 82 70 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
          {/* Lab coat */}
          <path d="M 25 110 L 25 120 L 95 120 L 95 110" fill="white" stroke={colors.primary} strokeWidth="2"/>
          {/* Flask icon */}
          <circle cx="60" cy="100" r="8" fill={colors.primary} opacity="0.5"/>
        </svg>
      ),

      "Researcher": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
          {/* Spiky hair */}
          <path d="M 30 35 L 35 15 L 45 25 L 50 10 L 55 25 L 60 12 L 65 25 L 70 10 L 75 25 L 85 15 L 90 35" fill="#2d3748"/>
          {/* Determined eyes */}
          <ellipse cx="48" cy="62" rx="7" ry="6" fill="white"/>
          <ellipse cx="72" cy="62" rx="7" ry="6" fill="white"/>
          <circle cx="48" cy="62" r="5" fill={colors.primary}/>
          <circle cx="72" cy="62" r="5" fill={colors.primary}/>
          <circle cx="48" cy="60" r="2" fill="white"/>
          <circle cx="72" cy="60" r="2" fill="white"/>
          {/* Focused expression */}
          <line x1="42" y1="54" x2="38" y2="50" stroke="#2d3748" strokeWidth="2"/>
          <line x1="78" y1="54" x2="82" y2="50" stroke="#2d3748" strokeWidth="2"/>
          {/* Small smile */}
          <path d="M 52 74 Q 60 78 68 74" stroke="#2d3748" strokeWidth="2" fill="none"/>
          {/* Lab coat with badge */}
          <path d="M 25 110 L 25 120 L 95 120 L 95 110" fill="white" stroke={colors.primary} strokeWidth="2"/>
          <rect x="55" y="112" width="10" height="12" fill={colors.primary} rx="2"/>
        </svg>
      ),

      // UNCOMMON - Junior Characters
      "Astronomer": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
          {/* Wavy hair */}
          <ellipse cx="60" cy="40" rx="34" ry="26" fill="#5c4033"/>
          <path d="M 30 40 Q 25 55 35 60" fill="#5c4033"/>
          <path d="M 90 40 Q 95 55 85 60" fill="#5c4033"/>
          {/* Starry eyes */}
          <ellipse cx="48" cy="62" rx="8" ry="8" fill="white"/>
          <ellipse cx="72" cy="62" rx="8" ry="8" fill="white"/>
          <circle cx="48" cy="62" r="5" fill={colors.primary}/>
          <circle cx="72" cy="62" r="5" fill={colors.primary}/>
          {/* Star sparkles */}
          <path d="M 38 52 L 40 48 L 44 52 L 40 56 Z" fill={colors.secondary}/>
          <path d="M 76 52 L 78 48 L 82 52 L 78 56 Z" fill={colors.secondary}/>
          {/* Wonder expression */}
          <circle cx="60" cy="78" r="3" fill="#2d3748"/>
          {/* Telescope */}
          <rect x="45" y="95" width="30" height="8" fill={colors.secondary} rx="4"/>
          <circle cx="75" cy="99" r="6" fill={colors.primary}/>
        </svg>
      ),

      // RARE - Expert Characters
      "Professor": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="35" ry="38" fill="#ffe4c4"/>
          {/* Gray slicked hair */}
          <ellipse cx="60" cy="42" rx="32" ry="22" fill="#4a5568"/>
          <path d="M 28 42 Q 30 35 35 38" fill="#4a5568"/>
          <path d="M 92 42 Q 90 35 85 38" fill="#4a5568"/>
          {/* Wise eyes */}
          <ellipse cx="48" cy="64" rx="9" ry="7" fill="white"/>
          <ellipse cx="72" cy="64" rx="9" ry="7" fill="white"/>
          <circle cx="48" cy="65" r="6" fill={colors.primary}/>
          <circle cx="72" cy="65" r="6" fill={colors.primary}/>
          {/* Bushy eyebrows */}
          <path d="M 40 55 Q 48 52 56 55" stroke="#4a5568" strokeWidth="3" fill="none"/>
          <path d="M 64 55 Q 72 52 80 55" stroke="#4a5568" strokeWidth="3" fill="none"/>
          {/* Wise smile */}
          <path d="M 45 76 Q 60 84 75 76" stroke="#2d3748" strokeWidth="2" fill="none"/>
          {/* Beard */}
          <path d="M 40 88 Q 60 95 80 88" fill="#9ca3af"/>
          {/* Graduation cap */}
          <rect x="30" y="25" width="60" height="20" fill={colors.secondary} rx="3"/>
          <rect x="55" y="45" width="10" height="5" fill={colors.secondary} rx="2"/>
        </svg>
      ),

      // EPIC - Master Characters
      "Nobel Winner": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
          {/* Elegant hair */}
          <ellipse cx="60" cy="40" rx="32" ry="24" fill="#8b7355"/>
          {/* Crown */}
          <path d="M 35 30 L 40 15 L 50 25 L 60 10 L 70 25 L 80 15 L 85 30" fill={colors.secondary} stroke={colors.primary} strokeWidth="2"/>
          <circle cx="45" cy="25" r="4" fill={colors.primary}/>
          <circle cx="60" cy="22" r="4" fill={colors.primary}/>
          <circle cx="75" cy="25" r="4" fill={colors.primary}/>
          {/* Proud eyes */}
          <ellipse cx="48" cy="62" rx="8" ry="8" fill="white"/>
          <ellipse cx="72" cy="62" rx="8" ry="8" fill="white"/>
          <circle cx="48" cy="62" r="6" fill={colors.primary}/>
          <circle cx="72" cy="62" r="6" fill={colors.primary}/>
          <circle cx="48" cy="59" r="2" fill="white"/>
          <circle cx="72" cy="59" r="2" fill="white"/>
          {/* Confident smile */}
          <path d="M 45 74 Q 60 82 75 74" stroke="#2d3748" strokeWidth="3" fill="none"/>
          {/* Medal */}
          <circle cx="60" cy="105" r="12" fill={colors.primary} stroke={colors.secondary} strokeWidth="2"/>
          <text x="60" y="109" textAnchor="middle" fontSize="10" fill="white" fontWeight="bold">🏆</text>
        </svg>
      ),

      // LEGENDARY - Legendary Characters
      "Dragon Master": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
          {/* Dragon wings background */}
          <path d="M 10 50 Q 30 30 60 40 Q 90 30 110 50" fill={colors.secondary} opacity="0.3"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="32" ry="35" fill="#ffe4c4"/>
          {/* Wild spiky hair */}
          <path d="M 25 30 L 35 10 L 45 25 L 50 8 L 55 22 L 60 5 L 65 22 L 70 8 L 75 25 L 85 10 L 95 30" fill={colors.primary}/>
          {/* Fierce eyes */}
          <ellipse cx="48" cy="62" rx="9" ry="7" fill="white"/>
          <ellipse cx="72" cy="62" rx="9" ry="7" fill="white"/>
          <ellipse cx="48" cy="64" r="7" fill={colors.secondary}/>
          <ellipse cx="72" cy="64" r="7" fill={colors.secondary}/>
          {/* Sharp expression */}
          <path d="M 35 52 L 40 58 M 85 52 L 80 58" stroke="#2d3748" strokeWidth="3"/>
          {/* Confident grin */}
          <path d="M 40 75 Q 60 85 80 75" stroke="#2d3748" strokeWidth="3" fill="none"/>
          {/* Dragon scales */}
          <circle cx="30" cy="90" r="5" fill={colors.primary} opacity="0.5"/>
          <circle cx="45" cy="95" r="5" fill={colors.primary} opacity="0.5"/>
          <circle cx="75" cy="95" r="5" fill={colors.primary} opacity="0.5"/>
          <circle cx="90" cy="90" r="5" fill={colors.primary} opacity="0.5"/>
        </svg>
      ),

      // MYTHICAL - Divine Characters
      "Quantum Deity": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          {/* Glowing aura */}
          <defs>
            <radialGradient id="aura">
              <stop offset="0%" stopColor={colors.primary} stopOpacity="0.6"/>
              <stop offset="100%" stopColor={colors.primary} stopOpacity="0"/>
            </radialGradient>
          </defs>
          <circle cx="60" cy="60" r="55" fill="url(#aura)"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="33" ry="36" fill="#ffe4c4"/>
          {/* Ethereal hair */}
          <ellipse cx="60" cy="38" rx="35" ry="28" fill={colors.primary} opacity="0.8"/>
          <path d="M 30 35 Q 25 50 30 60" fill={colors.primary} opacity="0.5"/>
          <path d="M 90 35 Q 95 50 90 60" fill={colors.primary} opacity="0.5"/>
          {/* Glowing eyes */}
          <ellipse cx="48" cy="62" rx="10" ry="10" fill="white"/>
          <ellipse cx="72" cy="62" rx="10" ry="10" fill="white"/>
          <circle cx="48" cy="62" r="8" fill={colors.secondary}/>
          <circle cx="72" cy="62" r="8" fill={colors.secondary}/>
          <circle cx="48" cy="59" r="4" fill="white"/>
          <circle cx="72" cy="59" r="4" fill="white"/>
          {/* Third eye */}
          <circle cx="60" cy="48" r="6" fill={colors.secondary} opacity="0.8"/>
          {/* Serene expression */}
          <path d="M 48 75 Q 60 80 72 75" stroke="#2d3748" strokeWidth="2" fill="none"/>
          {/* Floating symbols */}
          <text x="20" y="40" fontSize="16" opacity="0.6">✨</text>
          <text x="95" y="35" fontSize="16" opacity="0.6">✨</text>
          <text x="15" y="90" fontSize="14" opacity="0.5">⚛️</text>
          <text x="95" y="85" fontSize="14" opacity="0.5">🔮</text>
        </svg>
      ),

      // GODLY - Ultimate Characters
      "The Absolute": (
        <svg viewBox="0 0 120 120" style={commonStyles}>
          {/* Cosmic aura */}
          <defs>
            <radialGradient id="cosmic">
              <stop offset="0%" stopColor={colors.primary} stopOpacity="0.8"/>
              <stop offset="50%" stopColor={colors.secondary} stopOpacity="0.4"/>
              <stop offset="100%" stopColor={colors.primary} stopOpacity="0"/>
            </radialGradient>
          </defs>
          <circle cx="60" cy="60" r="58" fill="url(#cosmic)"/>
          {/* Face */}
          <ellipse cx="60" cy="65" rx="32" ry="36" fill="#ffe4c4"/>
          {/* Divine hair */}
          <ellipse cx="60" cy="35" rx="36" ry="30" fill={colors.primary}/>
          <path d="M 22 30 Q 20 50 25 70" fill={colors.secondary} opacity="0.7"/>
          <path d="M 98 30 Q 100 50 95 70" fill={colors.secondary} opacity="0.7"/>
          {/* All-seeing eyes */}
          <ellipse cx="48" cy="62" rx="12" ry="10" fill="white"/>
          <ellipse cx="72" cy="62" rx="12" ry="10" fill="white"/>
          <circle cx="48" cy="62" r="10" fill={colors.primary}/>
          <circle cx="72" cy="62" r="10" fill={colors.primary}/>
          <circle cx="48" cy="60" r="5" fill={colors.secondary}/>
          <circle cx="72" cy="60" r="5" fill={colors.secondary}/>
          {/* Crown of light */}
          <path d="M 30 25 L 40 5 L 50 20 L 60 0 L 70 20 L 80 5 L 90 25" fill={colors.secondary}/>
          <circle cx="40" cy="20" r="5" fill={colors.primary}/>
          <circle cx="60" cy="18" r="6" fill={colors.primary}/>
          <circle cx="80" cy="20" r="5" fill={colors.primary}/>
          {/* Divine smile */}
          <path d="M 42 74 Q 60 86 78 74" stroke="#2d3748" strokeWidth="3" fill="none"/>
          {/* Cosmic symbols */}
          <text x="18" y="38" fontSize="14">🌟</text>
          <text x="95" y="32" fontSize="14">⭐</text>
          <text x="12" y="82" fontSize="12">💫</text>
          <text x="100" y="80" fontSize="12">✨</text>
          <text x="30" y="105" fontSize="11">🌀</text>
          <text x="80" y="108" fontSize="11">🔱</text>
        </svg>
      ),
    };

    // Return matching design or default based on type
    return (
      <div className={`anime-avatar ${className}`} style={{ display: 'inline-block' }}>
        {designs[avatarType] || (
          // Default anime character
          <svg viewBox="0 0 120 120" style={commonStyles}>
            <circle cx="60" cy="60" r="55" fill={colors.primary} opacity="0.2"/>
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
          </svg>
        )}
      </div>
    );
  };
}
