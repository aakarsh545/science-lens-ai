import { useEffect, useState, useCallback } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Coins, Zap, TrendingUp } from "lucide-react";
import { Button } from "./ui/button";
import { useNavigate } from "react-router-dom";
import { SidebarTrigger } from "./ui/sidebar";
import { Progress } from "./ui/progress";
import { motion, AnimatePresence } from "framer-motion";
import { calculateLevel, getXpForNextLevel, getProgressToNextLevel, getTotalXpForLevel } from "@/utils/levelCalculations";
import { triggerLevelUpConfetti } from "@/utils/confettiEffects";

interface CreditsBarProps {
  userId: string;
}

export function CreditsBar({ userId }: CreditsBarProps) {
  const [credits, setCredits] = useState<number>(0);
  const [xp, setXp] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const [level, setLevel] = useState<number>(1);
  const [prevLevel, setPrevLevel] = useState<number>(1);
  const navigate = useNavigate();

  const loadStats = useCallback(async () => {
    try {
      // First, refresh daily credits
      await supabase.rpc('refresh_daily_credits', { p_user_id: userId });
      
      // Then load stats
      const { data, error } = await supabase
        .from('user_stats')
        .select('credits, xp_total')
        .eq('user_id', userId)
        .single();

      if (!error && data) {
        const currentXp = data.xp_total ?? 0;
        setCredits(data.credits ?? 0);
        setXp(currentXp);
        setLevel(calculateLevel(currentXp));
        setPrevLevel(calculateLevel(currentXp));
      }
    } catch (error) {
      console.error('Error loading stats:', error);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useEffect(() => {
    loadStats();

    // Subscribe to real-time updates
    const channel = supabase
      .channel('user_stats_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'user_stats',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          if (payload.new && typeof payload.new === 'object') {
            const newData = payload.new as { credits?: number; xp_total?: number };
            const newXp = newData.xp_total ?? 0;
            const newLevel = calculateLevel(newXp);

            // Check for level up
            if (newLevel > level) {
              setPrevLevel(level);
              triggerLevelUpConfetti();
            }

            setCredits(newData.credits ?? 0);
            setXp(newXp);
            setLevel(newLevel);
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [userId, level, loadStats]);

  const progressToNext = getProgressToNextLevel(xp);
  const xpForNext = getXpForNextLevel(xp);
  const currentLevel = calculateLevel(xp);
  const totalXpForCurrentLevel = getTotalXpForLevel(currentLevel);
  const totalXpForNextLevel = getTotalXpForLevel(currentLevel + 1);
  const xpInCurrentLevel = xp - totalXpForCurrentLevel;

  return (
    <div className="h-14 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 flex items-center justify-between px-4">
      <SidebarTrigger />
      
      <div className="flex items-center gap-4">
        {/* Level Display */}
        <div className="flex items-center gap-2">
          <div className="relative">
            <div className="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary">
              <AnimatePresence mode="wait">
                <motion.span
                  key={level}
                  initial={{ scale: 1.5, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  exit={{ scale: 0.5, opacity: 0 }}
                  className="text-sm font-bold text-primary"
                >
                  {level}
                </motion.span>
              </AnimatePresence>
            </div>
          </div>
          
          {/* XP Progress */}
          <div className="flex flex-col gap-1 min-w-[120px]">
            <div className="flex items-center justify-between">
              <span className="text-xs font-medium text-muted-foreground">Level {level}</span>
              <span className="text-xs text-muted-foreground">{xpInCurrentLevel}/{totalXpForNextLevel - totalXpForCurrentLevel} XP</span>
            </div>
            <Progress value={progressToNext} className="h-1.5" />
          </div>
        </div>
        
        {/* Credits Display */}
        <div className={`flex items-center gap-2 px-3 py-1.5 rounded-lg ${credits === 0 ? 'bg-destructive/10 border border-destructive' : 'bg-accent'}`}>
          <Coins className={`h-4 w-4 ${credits === 0 ? 'text-destructive' : 'text-accent-foreground'}`} />
          <span className="text-sm font-medium">{credits} Credits</span>
        </div>

        {credits === 0 && (
          <Button 
            size="sm" 
            variant="destructive"
            onClick={() => navigate('/science-lens/pricing')}
            className="animate-pulse"
          >
            Get Credits
          </Button>
        )}
        
        {credits > 0 && credits < 3 && (
          <Button 
            size="sm" 
            variant="outline"
            onClick={() => navigate('/science-lens/pricing')}
          >
            Buy More
          </Button>
        )}
      </div>
    </div>
  );
}