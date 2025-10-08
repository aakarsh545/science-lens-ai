import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Trophy, Zap, Target } from "lucide-react";

interface GamificationBarProps {
  userId: string;
}

interface Stats {
  credits: number;
  xp_points: number;
  level: number;
  total_questions: number;
  achievementCount: number;
}

export function GamificationBar({ userId }: GamificationBarProps) {
  const [stats, setStats] = useState<Stats>({
    credits: 0,
    xp_points: 0,
    level: 1,
    total_questions: 0,
    achievementCount: 0,
  });

  useEffect(() => {
    loadStats();

    // Subscribe to real-time updates
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
      supabase.removeChannel(profileChannel);
      supabase.removeChannel(achievementChannel);
    };
  }, [userId]);

  const loadStats = async () => {
    const { data: profile } = await supabase
      .from("profiles")
      .select("credits, xp_points, level, total_questions")
      .eq("user_id", userId)
      .single();

    const { count } = await supabase
      .from("achievements")
      .select("*", { count: "exact", head: true })
      .eq("user_id", userId);

    if (profile) {
      setStats({
        credits: profile.credits || 0,
        xp_points: profile.xp_points || 0,
        level: profile.level || 1,
        total_questions: profile.total_questions || 0,
        achievementCount: count || 0,
      });
    }
  };

  const xpForNextLevel = stats.level * 100;
  const progressPercentage = (stats.xp_points % xpForNextLevel) / xpForNextLevel * 100;

  return (
    <Card className="p-4 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
              <span className="text-lg font-bold">L{stats.level}</span>
            </div>
            <div>
              <p className="text-sm font-medium">Level {stats.level}</p>
              <p className="text-xs text-muted-foreground">
                {stats.xp_points % xpForNextLevel} / {xpForNextLevel} XP
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
            {xpForNextLevel - (stats.xp_points % xpForNextLevel)} XP to next level
          </p>
        </div>
      </div>
    </Card>
  );
}
