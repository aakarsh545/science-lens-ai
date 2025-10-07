import { useEffect, useState } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Trophy } from "lucide-react";
import { motion } from "framer-motion";

interface Achievement {
  id: string;
  title: string;
  description: string;
  achievement_type: string;
  icon: string;
  category: string;
  points: number;
  earned_at: string;
}

interface AchievementsViewProps {
  user: User;
}

export function AchievementsView({ user }: AchievementsViewProps) {
  const [achievements, setAchievements] = useState<Achievement[]>([]);

  useEffect(() => {
    const loadAchievements = async () => {
      const { data } = await supabase
        .from("achievements")
        .select("*")
        .eq("user_id", user.id)
        .order("earned_at", { ascending: false });

      if (data) {
        setAchievements(data);
      }
    };

    loadAchievements();

    // Subscribe to new achievements
    const channel = supabase
      .channel("achievements")
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "achievements",
          filter: `user_id=eq.${user.id}`,
        },
        (payload) => {
          const newAchievement = payload.new as Achievement;
          setAchievements((prev) => [newAchievement, ...prev]);
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user.id]);

  const totalPoints = achievements.reduce((sum, a) => sum + (a.points || 0), 0);

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold mb-2">Achievements 🏆</h1>
        <p className="text-muted-foreground">Your learning milestones and rewards</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Total Points</CardTitle>
          <CardDescription>Your overall achievement score</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="text-4xl font-bold text-primary">{totalPoints} XP</div>
          <p className="text-sm text-muted-foreground mt-2">
            {achievements.length} achievement{achievements.length !== 1 ? "s" : ""} unlocked
          </p>
        </CardContent>
      </Card>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {achievements.map((achievement, index) => (
          <motion.div
            key={achievement.id}
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.3, delay: index * 0.05 }}
          >
            <Card className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <span className="text-4xl">{achievement.icon}</span>
                  <Badge variant="secondary">+{achievement.points} XP</Badge>
                </div>
                <CardTitle className="mt-2">{achievement.title}</CardTitle>
                <CardDescription>{achievement.description}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground capitalize">{achievement.category}</span>
                  <span className="text-muted-foreground">
                    {new Date(achievement.earned_at).toLocaleDateString()}
                  </span>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      {achievements.length === 0 && (
        <div className="text-center text-muted-foreground py-12">
          <Trophy className="h-16 w-16 mx-auto mb-4 opacity-50" />
          <h3 className="text-xl font-semibold mb-2">No achievements yet</h3>
          <p>Start learning to unlock achievements!</p>
        </div>
      )}
    </div>
  );
}