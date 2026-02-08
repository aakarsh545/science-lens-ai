import { ArrowLeft, Flame, Heart, Star } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';

interface TopBarProps {
  courseTitle: string;
  xp: number;
  xpToNextLevel: number;
  progressToNextLevel: number;
  level: number;
  streak?: number;
  hearts?: number;
}

export function TopBar({
  courseTitle,
  xp,
  xpToNextLevel,
  progressToNextLevel,
  level,
  streak = 0,
  hearts = 5
}: TopBarProps) {
  const navigate = useNavigate();

  return (
    <motion.div
      initial={{ y: -20, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
    >
      <div className="container mx-auto px-4 py-3">
        <div className="flex items-center justify-between gap-4">
          {/* Left: Back Button + Course Title */}
          <div className="flex items-center gap-3 flex-1 min-w-0">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => navigate('/learning')}
              className="flex-shrink-0"
            >
              <ArrowLeft className="w-5 h-5" />
            </Button>
            <div className="min-w-0 flex-1">
              <h1 className="text-lg font-bold truncate">{courseTitle}</h1>
            </div>
          </div>

          {/* Right: Stats */}
          <div className="flex items-center gap-3 flex-shrink-0">
            {/* Level & XP */}
            <div className="hidden md:flex flex-col items-end mr-4">
              <div className="flex items-center gap-2 text-sm font-semibold">
                <span className="text-primary">Level {level}</span>
                <span className="text-muted-foreground">|</span>
                <span className="text-primary">{xp} XP</span>
              </div>
              <div className="w-32">
                <Progress value={progressToNextLevel} className="h-1.5" />
              </div>
            </div>

            {/* Streak */}
            {streak > 0 && (
              <div className="flex items-center gap-1 px-2 py-1 rounded-full bg-gradient-to-r from-orange-500 to-red-500 text-white text-xs font-bold">
                <Flame className="w-4 h-4" />
                <span>{streak}</span>
              </div>
            )}

            {/* Hearts */}
            <div className="hidden sm:flex items-center gap-1 px-2 py-1 rounded-full bg-red-500/10 text-red-500 text-xs font-bold">
              <Heart className="w-4 h-4 fill-current" />
              <span>{hearts}</span>
            </div>

            {/* Level Badge (mobile) */}
            <div className="md:hidden w-8 h-8 rounded-full bg-gradient-to-br from-primary to-purple-600 flex items-center justify-center text-white text-sm font-bold">
              {level}
            </div>
          </div>
        </div>
      </div>
    </motion.div>
  );
}
