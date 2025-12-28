import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Trophy, Zap, Target, Loader2 } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";
import { calculateLevel, getXpRemainingToNextLevel, getProgressToNextLevel, getTotalXpForLevel } from "@/utils/levelCalculations";
import { createTimeout } from "@/utils/timeout";

interface GamificationBarProps {
  userId: string;
}

interface Stats {
  credits: number;
  xp_points: number;
  level: number;
  total_questions: number;
  achievementCount: number;
  xp_total: number;
}

export function GamificationBar({ userId }: GamificationBarProps) {
  const [stats, setStats] = useState<Stats>({
    credits: 0,
    xp_points: 0,
    level: 1,
    total_questions: 0,
    achievementCount: 0,
    xp_total: 0,
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    let mounted = true;

    const loadStats = async () => {
      try {
        setError(false);

        // Add timeout for stats loading
        const timeoutPromise = createTimeout(5000, "Stats loading timed out");

        const fetchPromise = (async () => {
          // Load credits and xp_total from user_stats
          const { data: userStats, error: userStatsError } = await supabase
            .from("user_stats")
            .select("credits, xp_total")
            .eq("user_id", userId)
            .single();

          if (userStatsError && userStatsError.code !== 'PGRST116') {
            throw userStatsError;
          }

          // Load other fields from profiles
          const { data: profile, error: profileError } = await supabase
            .from("profiles")
            .select("xp_points, level, total_questions")
            .eq("user_id", userId)
            .single();

          if (profileError) throw profileError;

          const { count, error: countError } = await supabase
            .from("achievements")
            .select("*", { count: "exact", head: true })
            .eq("user_id", userId);

          if (countError) throw countError;

          return { userStats, profile, count };
        })();

        const { userStats, profile, count } = await Promise.race([fetchPromise, timeoutPromise]) as any;

        if (mounted && (userStats || profile)) {
          setStats({
            credits: userStats?.credits || 0,
            xp_total: userStats?.xp_total || 0,
            xp_points: profile?.xp_points || 0,
            level: profile?.level || 1,
            total_questions: profile?.total_questions || 0,
            achievementCount: count || 0,
          });
          setLoading(false);
        }
      } catch (err) {
        console.error("Error loading stats:", err);
        if (mounted) {
          setError(true);
          setLoading(false);
        }
      }
    };

    loadStats();

    // Subscribe to real-time updates from both tables
    const statsChannel = supabase
      .channel("stats-updates")
      .on(
        "postgres_changes",
        {
          event: "UPDATE",
          schema: "public",
          table: "user_stats",
          filter: `user_id=eq.${userId}`,
        },
        () => loadStats()
      )
      .subscribe();

    const profileChannel = supabase
      .channel("profile-updates")
      .on(
        "postgres_changes",
        {
          event: "UPDATE",
          schema: "public",
          table: "profiles",
          filter: `user_id=eq.${userId}`,
        },
        () => loadStats()
      )
      .subscribe();

    const achievementChannel = supabase
      .channel("achievement-updates")
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "achievements",
          filter: `user_id=eq.${userId}`,
        },
        () => loadStats()
      )
      .subscribe();

    return () => {
      mounted = false;
      supabase.removeChannel(statsChannel);
      supabase.removeChannel(profileChannel);
      supabase.removeChannel(achievementChannel);
    };
  }, [userId]);

  // Calculate level from xp_total using exponential progression
  const calculatedLevel = calculateLevel(stats.xp_total);
  const xpRemaining = getXpRemainingToNextLevel(stats.xp_total);
  const progressPercentage = getProgressToNextLevel(stats.xp_total);
  const xpForCurrentLevelTotal = getTotalXpForLevel(calculatedLevel);
  const xpForNextLevelTotal = getTotalXpForLevel(calculatedLevel + 1);
  const xpInCurrentLevel = stats.xp_total - xpForCurrentLevelTotal;

  if (loading) {
    return (
      <Card className="p-4 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
        <div className="space-y-3">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Skeleton className="w-10 h-10 rounded-full" />
              <div className="space-y-1">
                <Skeleton className="h-4 w-20" />
                <Skeleton className="h-3 w-16" />
              </div>
            </div>
            <div className="flex gap-4">
              <Skeleton className="h-4 w-16" />
              <Skeleton className="h-4 w-16" />
              <Skeleton className="h-4 w-16" />
            </div>
          </div>
          <Skeleton className="h-2 w-full" />
        </div>
      </Card>
    );
  }

  if (error) {
    return (
      <Card className="p-4 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
        <div className="flex items-center justify-center gap-2 text-sm text-muted-foreground">
          <Loader2 className="h-4 w-4 animate-spin" />
          <span>Loading stats...</span>
        </div>
      </Card>
    );
  }

  return (
    <Card className="p-4 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
              <span className="text-lg font-bold">L{calculatedLevel}</span>
            </div>
            <div>
              <p className="text-sm font-medium">Level {calculatedLevel}</p>
              <p className="text-xs text-muted-foreground">
                {xpInCurrentLevel} / {xpForNextLevelTotal - xpForCurrentLevelTotal} XP
              </p>
            </div>
          </div>

          <div className="flex gap-4">
            <div className="flex items-center gap-1.5">
              <Zap className="h-4 w-4 text-yellow-500" />
              <span className="text-sm font-semibold">{stats.credits}</span>
              <span className="text-xs text-muted-foreground">credits</span>
            </div>
            <div className="flex items-center gap-1.5">
              <Trophy className="h-4 w-4 text-amber-500" />
              <span className="text-sm font-semibold">{stats.achievementCount}</span>
              <span className="text-xs text-muted-foreground">badges</span>
            </div>
            <div className="flex items-center gap-1.5">
              <Target className="h-4 w-4 text-blue-500" />
              <span className="text-sm font-semibold">{stats.total_questions}</span>
              <span className="text-xs text-muted-foreground">questions</span>
            </div>
          </div>
        </div>

        <div className="space-y-1">
          <Progress value={progressPercentage} className="h-2" />
          <p className="text-xs text-muted-foreground text-right">
            {xpRemaining} XP to next level
          </p>
        </div>
      </div>
    </Card>
  );
}
