import { motion } from 'framer-motion';
import { Lock, CheckCircle2, Play, Star, BookOpen } from 'lucide-react';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

interface UnitCardProps {
  unit: {
    name: string;
    lessons: any[];
    progress: {
      completed: number;
      total: number;
    };
  };
  index: number;
  isCurrent: boolean;
  isLocked: boolean;
  isCompleted: boolean;
  onStart: () => void;
  totalXP?: number;
}

export function UnitCard({
  unit,
  index,
  isCurrent,
  isLocked,
  isCompleted,
  onStart,
  totalXP = 0
}: UnitCardProps) {
  const progressPercentage = unit.progress.total > 0
    ? Math.round((unit.progress.completed / unit.progress.total) * 100)
    : 0;

  const getUnitIcon = () => {
    if (isLocked) return <Lock className="w-8 h-8" />;
    if (isCompleted) return <CheckCircle2 className="w-8 h-8" />;
    return <BookOpen className="w-8 h-8" />;
  };

  const getUnitColor = () => {
    if (isLocked) return 'bg-muted/30 border-muted';
    if (isCompleted) return 'bg-success/10 border-success/50';
    if (isCurrent) return 'bg-primary/20 border-primary/50 shadow-lg shadow-primary/20';
    return 'bg-card hover:bg-card/80 border-border';
  };

  const getIconColor = () => {
    if (isLocked) return 'text-muted-foreground';
    if (isCompleted) return 'text-success';
    if (isCurrent) return 'text-primary';
    return 'text-primary';
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: index * 0.1, duration: 0.4 }}
      className="flex flex-col items-center"
    >
      {/* Connecting Line */}
      {index > 0 && (
        <motion.div
          initial={{ scaleY: 0 }}
          animate={{ scaleY: 1 }}
          transition={{ delay: index * 0.1, duration: 0.3 }}
          className="w-1 h-16 bg-gradient-to-b from-border via-border to-muted/30 -mb-4"
        />
      )}

      {/* Unit Circle */}
      <Card
        className={cn(
          'relative w-48 h-48 rounded-full flex flex-col items-center justify-center p-6 cursor-pointer transition-all hover:scale-105 border-4',
          getUnitColor(),
          isCurrent && 'animate-pulse-slow'
        )}
        onClick={!isLocked ? onStart : undefined}
      >
        {/* Unit Number Badge */}
        <div className="absolute -top-2 -left-2 w-10 h-10 rounded-full bg-gradient-to-br from-primary to-purple-600 flex items-center justify-center text-white font-bold text-lg shadow-lg">
          {index + 1}
        </div>

        {/* Icon */}
        <motion.div
          whileHover={{ scale: 1.1, rotate: 5 }}
          className={cn('mb-3', getIconColor())}
        >
          {getUnitIcon()}
        </motion.div>

        {/* Unit Name */}
        <h3 className="text-lg font-bold text-center mb-2 line-clamp-2">
          {unit.name}
        </h3>

        {/* Progress */}
        {!isLocked && (
          <div className="w-full space-y-2">
            <div className="flex items-center justify-between text-xs">
              <span className="text-muted-foreground">Progress</span>
              <span className={cn(
                'font-semibold',
                isCompleted ? 'text-success' : 'text-primary'
              )}>
                {unit.progress.completed}/{unit.progress.total}
              </span>
            </div>
            <div className="w-full h-2 bg-muted rounded-full overflow-hidden">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: `${progressPercentage}%` }}
                transition={{ duration: 0.6, delay: index * 0.1 }}
                className={cn(
                  'h-full rounded-full',
                  isCompleted ? 'bg-success' : 'bg-gradient-to-r from-primary to-purple-600'
                )}
              />
            </div>
          </div>
        )}

        {/* XP Badge */}
        {totalXP > 0 && !isLocked && (
          <div className="absolute -bottom-2 -right-2 flex items-center gap-1 px-2 py-1 rounded-full bg-gradient-to-r from-yellow-500 to-orange-500 text-white text-xs font-bold shadow-lg">
            <Star className="w-3 h-3 fill-white" />
            {totalXP} XP
          </div>
        )}

        {/* Lock Overlay */}
        {isLocked && (
          <div className="absolute inset-0 flex items-center justify-center bg-black/40 rounded-full">
            <Lock className="w-12 h-12 text-white/80" />
          </div>
        )}
      </Card>

      {/* START Button for Current Unit */}
      {isCurrent && !isLocked && (
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ delay: index * 0.1 + 0.2, type: 'spring', stiffness: 200 }}
        >
          <Button
            size="lg"
            onClick={onStart}
            className="mt-4 px-8 py-6 text-lg font-bold bg-gradient-to-r from-primary to-purple-600 hover:from-primary/90 hover:to-purple-600/90 shadow-lg shadow-primary/20"
          >
            <Play className="w-5 h-5 mr-2" />
            START
          </Button>
        </motion.div>
      )}

      {/* Locked Message */}
      {isLocked && (
        <p className="mt-3 text-sm text-muted-foreground text-center max-w-[200px]">
          Complete previous unit to unlock
        </p>
      )}

      {/* Completed Badge */}
      {isCompleted && (
        <Badge className="mt-3 bg-success/10 text-success border-success/50">
          <CheckCircle2 className="w-3 h-3 mr-1" />
          Completed
        </Badge>
      )}
    </motion.div>
  );
}
