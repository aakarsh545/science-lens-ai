import { useEffect, useState } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { TrendingUp, MessageSquare, Target, Award } from "lucide-react";
import { GamificationBar } from "./GamificationBar";

interface DashboardViewProps {
  user: User;
}

interface Stats {
  totalQuestions: number;
  streakCount: number;
  xpPoints: number;
  level: number;
  totalAchievements: number;
  recentActivity: number;
}

export function DashboardView({ user }: DashboardViewProps) {
  const [stats, setStats] = useState<Stats>({
    totalQuestions: 0,
    streakCount: 0,
    xpPoints: 0,
    level: 1,
    totalAchievements: 0,
    recentActivity: 0,
  });

  useEffect(() => {
    const loadStats = async () => {
      // Load profile stats
      const { data: profile } = await supabase
        .from("profiles")
        .select("*")
        .eq("user_id", user.id)
        .single();

      // Count achievements
      const { count: achievementCount } = await supabase
        .from("achievements")
        .select("*", { count: "exact", head: true })
        .eq("user_id", user.id);

      // Count recent messages (last 7 days)
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
      const { count: recentMessages } = await supabase
        .from("messages")
        .select("*", { count: "exact", head: true })
        .eq("user_id", user.id)
        .eq("role", "user")
        .gte("created_at", sevenDaysAgo.toISOString());

      setStats({
        totalQuestions: profile?.total_questions || 0,
        streakCount: profile?.streak_count || 0,
        xpPoints: profile?.xp_points || 0,
        level: profile?.level || 1,
        totalAchievements: achievementCount || 0,
        recentActivity: recentMessages || 0,
      });
    };

    loadStats();
  }, [user.id]);

  const levelProgress = ((stats.xpPoints % 100) / 100) * 100;

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold mb-2">Dashboard 📊</h1>
        <p className="text-muted-foreground">
          Track your learning progress and achievements
        </p>
      </div>

      <GamificationBar userId={user.id} />

      {/* Level Card */}
      <Card className="border-primary">
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Level {stats.level}</CardTitle>
              <CardDescription>{stats.xpPoints} XP Total</CardDescription>
            </div>
            <Badge variant="default" className="text-lg px-4 py-2">
              {stats.xpPoints % 100} / 100 XP
            </Badge>
          </div>
        </CardHeader>
        <CardContent>
          <Progress value={levelProgress} className="h-3" />
          <p className="text-sm text-muted-foreground mt-2">
            {100 - (stats.xpPoints % 100)} XP until next level
          </p>
        </CardContent>
      </Card>

      {/* Stats Grid */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Questions</CardTitle>
            <MessageSquare className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalQuestions}</div>
            <p className="text-xs text-muted-foreground">
              {stats.recentActivity} this week
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Current Streak</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.streakCount} days</div>
            <p className="text-xs text-muted-foreground">
              Keep it going! 🔥
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Achievements</CardTitle>
            <Award className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalAchievements}</div>
            <p className="text-xs text-muted-foreground">
              Unlocked milestones
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total XP</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.xpPoints}</div>
            <p className="text-xs text-muted-foreground">
              Experience points
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Quick Tips */}
      <Card>
        <CardHeader>
          <CardTitle>Quick Tips 💡</CardTitle>
        </CardHeader>
        <CardContent className="space-y-2">
          <p className="text-sm">• Ask questions daily to maintain your streak</p>
          <p className="text-sm">• Explore different topics in the Learn section</p>
          <p className="text-sm">• Unlock achievements by staying engaged</p>
          <p className="text-sm">• Level up by earning 100 XP per level</p>
        </CardContent>
      </Card>
    </div>
  );
}