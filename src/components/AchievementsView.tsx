import { useEffect, useState } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Trophy, Loader2, AlertCircle } from "lucide-react";
import { motion } from "framer-motion";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";

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
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;

    const loadAchievements = async () => {
      try {
        setLoading(true);
        setError(null);

        // Add timeout for achievements loading
        const timeoutPromise = new Promise((_, reject) => {
          setTimeout(() => reject(new Error("Achievements loading timed out")), 8000);
        });

        const fetchPromise = supabase
          .from("achievements")
          .select("*")
          .eq("user_id", user.id)
          .order("earned_at", { ascending: false });

        const { data, error } = await Promise.race([fetchPromise, timeoutPromise]) as any;

        if (error) throw error;

        if (mounted && data) {
          setAchievements(data);
          setLoading(false);
        }
      } catch (err: any) {
        console.error("Error loading achievements:", err);
        if (mounted) {
          setError(err?.message || "Failed to load achievements");
          setLoading(false);
        }
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
      mounted = false;
      supabase.removeChannel(channel);
    };
  }, [user.id]);

  const totalPoints = achievements.reduce((sum, a) => sum + (a.points || 0), 0);

  if (loading) {
    return (
      <div className="p-6 space-y-6">
        <div>
          <h1 className="text-3xl font-bold mb-2">Achievements 🏆</h1>
          <p className="text-muted-foreground">Your learning milestones and rewards</p>
        </div>

        <Card>
          <CardHeader>
            <Skeleton className="h-6 w-32" />
            <Skeleton className="h-4 w-48" />
          </CardHeader>
          <CardContent>
            <Skeleton className="h-12 w-24" />
            <Skeleton className="h-4 w-40 mt-2" />
          </CardContent>
        </Card>

        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {[1, 2, 3, 4, 5, 6].map((i) => (
            <Card key={i}>
              <CardHeader>
                <div className="flex items-start justify-between">
                  <Skeleton className="h-12 w-12 rounded" />
                  <Skeleton className="h-6 w-16" />
                </div>
                <Skeleton className="h-5 w-full mt-2" />
                <Skeleton className="h-4 w-full" />
              </CardHeader>
              <CardContent>
                <div className="flex justify-between">
                  <Skeleton className="h-4 w-20" />
                  <Skeleton className="h-4 w-24" />
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="p-6 space-y-6">
        <div>
          <h1 className="text-3xl font-bold mb-2">Achievements 🏆</h1>
          <p className="text-muted-foreground">Your learning milestones and rewards</p>
        </div>

        <Card className="p-12 text-center space-y-4">
          <AlertCircle className="h-12 w-12 text-destructive mx-auto" />
          <h2 className="text-xl font-semibold">Unable to load achievements</h2>
          <p className="text-muted-foreground">{error}</p>
          <Button onClick={() => window.location.reload()} variant="outline">
            Try Again
          </Button>
        </Card>
      </div>
    );
  }

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