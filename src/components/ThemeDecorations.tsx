import { useTheme } from "@/contexts/ThemeContext";
import { useEffect, useState } from "react";

interface DecorationProps {
  type: 'leaf' | 'sparkle' | 'flame' | 'snowflake' | 'star' | 'bubble';
  style: React.CSSProperties;
}

function Decoration({ type, style }: DecorationProps) {
  const getEmoji = () => {
    switch (type) {
      case 'leaf': return '🌿';
      case 'sparkle': return '✨';
      case 'flame': return '🔥';
      case 'snowflake': return '❄️';
      case 'star': return '⭐';
      case 'bubble': return '🫧';
      default: return '✨';
    }
  };

  return (
    <div
      className="absolute pointer-events-none select-none z-0 opacity-20"
      style={{
        ...style,
        fontSize: Math.random() * 20 + 20 + 'px',
        animation: `float ${3 + Math.random() * 2}s ease-in-out infinite`,
        animationDelay: `${Math.random() * 2}s`,
      }}
    >
      {getEmoji()}
    </div>
  );
}

export function ThemeDecorations() {
  const { theme } = useTheme();
  const [decorations, setDecorations] = useState<React.ReactNode[]>([]);

  useEffect(() => {
    if (!theme) return;

    const decorationCount = 8;
    const newDecorations: React.ReactNode[] = [];
    const themeName = theme.name;

    // Determine decoration type based on theme name
    let decorationType: DecorationProps['type'] = 'sparkle';
    if (themeName.includes('Forest') || themeName.includes('Green') || themeName.includes('Mint')) {
      decorationType = 'leaf';
    } else if (themeName.includes('Galaxy') || themeName.includes('Space') || themeName.includes('Midnight')) {
      decorationType = 'star';
    } else if (themeName.includes('Volcanic') || themeName.includes('Fire') || themeName.includes('Sunset')) {
      decorationType = 'flame';
    } else if (themeName.includes('Arctic') || themeName.includes('Ice') || themeName.includes('Aurora')) {
      decorationType = 'snowflake';
    } else if (themeName.includes('Ocean') || themeName.includes('Water')) {
      decorationType = 'bubble';
    }

    // Generate random positions
    for (let i = 0; i < decorationCount; i++) {
      newDecorations.push(
        <Decoration
          key={i}
          type={decorationType}
          style={{
            left: `${Math.random() * 100}%`,
            top: `${Math.random() * 100}%`,
          }}
        />
      );
    }

    setDecorations(newDecorations);
  }, [theme]);

  if (!theme) return null;

  return <div className="fixed inset-0 overflow-hidden pointer-events-none">{decorations}</div>;
}
