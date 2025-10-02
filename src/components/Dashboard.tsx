import { useEffect, useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { motion } from "framer-motion";
import { Flame, Trophy, Target, Zap, LogOut, MessageSquare } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import ChatInterface from "./ChatInterface";

interface DashboardProps {
  user: User;
}

interface Profile {
  display_name: string | null;
  streak_count: number;
  total_questions: number;
  level: number;
  xp_points: number;
}

interface Achievement {
  title: string;
  description: string | null;
  earned_at: string;
}

export default function Dashboard({ user }: DashboardProps) {
  const [profile, setProfile] = useState<Profile | null>(null);
  const [achievements, setAchievements] = useState<Achievement[]>([]);
  const [showChat, setShowChat] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    loadProfile();
    loadAchievements();
  }, [user]);

  const loadProfile = async () => {
    const { data, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("user_id", user.id)
      .single();

    if (error) {
      console.error("Error loading profile:", error);
    } else {
      setProfile(data);
    }
  };

  const loadAchievements = async () => {
    const { data, error } = await supabase
      .from("achievements")
      .select("*")
      .eq("user_id", user.id)
      .order("earned_at", { ascending: false });

    if (error) {
      console.error("Error loading achievements:", error);
    } else {
      setAchievements(data || []);
    }
  };

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    toast({
      title: "Signed out successfully",
      description: "See you next time! 👋",
    });
  };

  if (showChat) {
    return (
      <div className="min-h-screen bg-background">
        <div className="container mx-auto p-4">
          <div className="flex justify-between items-center mb-4">
            <Button variant="outline" onClick={() => setShowChat(false)}>
              ← Back to Dashboard
            </Button>
            <Button variant="ghost" onClick={handleSignOut}>
              <LogOut className="mr-2 h-4 w-4" />
              Sign Out
            </Button>
          </div>
          <Card className="h-[calc(100vh-120px)]">
            <ChatInterface userId={user.id} />
          </Card>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto p-4 space-y-6">
        {/* Header */}
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
              Welcome back, {profile?.display_name || "Scientist"}! 🌟
            </h1>
            <p className="text-muted-foreground mt-2">Level {profile?.level || 1} Explorer</p>
          </div>
          <Button variant="ghost" onClick={handleSignOut}>
            <LogOut className="mr-2 h-4 w-4" />
            Sign Out
          </Button>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }}>
            <Card className="card-cosmic">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">Streak</CardTitle>
                <Flame className="h-4 w-4 text-orange-500" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{profile?.streak_count || 0} days</div>
                <p className="text-xs text-muted-foreground">Keep it going! 🔥</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
            <Card className="card-cosmic">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">Questions</CardTitle>
                <Target className="h-4 w-4 text-blue-500" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{profile?.total_questions || 0}</div>
                <p className="text-xs text-muted-foreground">Total asked</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
            <Card className="card-cosmic">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">XP Points</CardTitle>
                <Zap className="h-4 w-4 text-yellow-500" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{profile?.xp_points || 0}</div>
                <p className="text-xs text-muted-foreground">Experience earned</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.4 }}>
            <Card className="card-cosmic">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">Achievements</CardTitle>
                <Trophy className="h-4 w-4 text-purple-500" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{achievements.length}</div>
                <p className="text-xs text-muted-foreground">Unlocked</p>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Start Chat Button */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.5 }}>
          <Card className="card-cosmic bg-gradient-to-r from-primary/10 to-secondary/10">
            <CardHeader>
              <CardTitle className="text-2xl">Ready to learn something new?</CardTitle>
              <CardDescription>Ask me anything about science and let's explore together!</CardDescription>
            </CardHeader>
            <CardContent>
              <Button size="lg" onClick={() => setShowChat(true)} className="w-full md:w-auto">
                <MessageSquare className="mr-2 h-5 w-5" />
                Start Chat
              </Button>
            </CardContent>
          </Card>
        </motion.div>

        {/* Achievements */}
        {achievements.length > 0 && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.6 }}>
            <Card className="card-cosmic">
              <CardHeader>
                <CardTitle>🏆 Your Achievements</CardTitle>
                <CardDescription>Badges you've earned on your learning journey</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {achievements.map((achievement, idx) => (
                    <motion.div
                      key={idx}
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      transition={{ delay: idx * 0.1 }}
                      className="p-4 rounded-lg bg-gradient-to-br from-achievement/20 to-achievement/5 border border-achievement/30"
                    >
                      <h4 className="font-bold text-lg mb-1">{achievement.title}</h4>
                      <p className="text-sm text-muted-foreground mb-2">{achievement.description}</p>
                      <Badge variant="secondary" className="text-xs">
                        {new Date(achievement.earned_at).toLocaleDateString()}
                      </Badge>
                    </motion.div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </motion.div>
        )}
      </div>
    </div>
  );
}
