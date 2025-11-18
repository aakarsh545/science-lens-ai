import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, Zap, Trophy, Flame, Target, BookOpen, MessageSquare } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import ProgressRing from "@/components/ProgressRing";
import { GamificationBar } from "@/components/GamificationBar";
import { ChallengePanel } from "@/components/ChallengePanel";

interface Profile {
  display_name: string | null;
  streak_count: number;
  total_questions: number;
  level: number;
  xp_points: number;
  credits: number;
}

export default function DashboardMainPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<Profile | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadProfile(session.user.id);
      setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
      }
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const loadProfile = async (userId: string) => {
    const { data } = await supabase
      .from("profiles")
      .select("*")
      .eq("user_id", userId)
      .single();

    if (data) setProfile(data);
  };

  if (loading || !user || !profile) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  const xpForNextLevel = profile.level * 100;
  const xpProgress = (profile.xp_points % 100) / 100 * 100;

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6">
      {/* Welcome Header */}
      <div>
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          Welcome back, {profile.display_name || "Scientist"}!
        </h1>
        <p className="text-muted-foreground">
          Continue your learning journey
        </p>
      </div>

      {/* Gamification Bar */}
      <GamificationBar userId={user.id} />

      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card className="hover:shadow-cosmic transition-all duration-300">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Current Streak</CardTitle>
            <Flame className="w-4 h-4 text-orange-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{profile.streak_count} days</div>
            <p className="text-xs text-muted-foreground mt-1">Keep it up!</p>
          </CardContent>
        </Card>

        <Card className="hover:shadow-cosmic transition-all duration-300">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Questions Answered</CardTitle>
            <Target className="w-4 h-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{profile.total_questions}</div>
            <p className="text-xs text-muted-foreground mt-1">Total questions</p>
          </CardContent>
        </Card>

        <Card className="hover:shadow-cosmic transition-all duration-300">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Level Progress</CardTitle>
            <Trophy className="w-4 h-4 text-achievement" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">Level {profile.level}</div>
            <Progress value={xpProgress} className="h-2 mt-2" />
            <p className="text-xs text-muted-foreground mt-1">{profile.xp_points % 100}/{xpForNextLevel} XP</p>
          </CardContent>
        </Card>

        <Card className="hover:shadow-cosmic transition-all duration-300">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium">Credits</CardTitle>
            <Zap className="w-4 h-4 text-yellow-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{profile.credits}</div>
            <Button 
              variant="link" 
              className="p-0 h-auto text-xs text-primary mt-1"
              onClick={() => navigate("/pricing")}
            >
              Get more credits
            </Button>
          </CardContent>
        </Card>
      </div>

      {/* Quick Actions */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <Card className="hover:shadow-cosmic transition-all duration-300 cursor-pointer group" onClick={() => navigate("/learn-science")}>
          <CardHeader>
            <div className="flex items-center gap-3">
              <BookOpen className="w-8 h-8 text-primary group-hover:scale-110 transition-transform" />
              <div>
                <CardTitle>Continue Learning</CardTitle>
                <p className="text-sm text-muted-foreground">Pick up where you left off</p>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <Button variant="outline" className="w-full">Start Learning</Button>
          </CardContent>
        </Card>

        <Card className="hover:shadow-cosmic transition-all duration-300 cursor-pointer group" onClick={() => navigate("/ask")}>
          <CardHeader>
            <div className="flex items-center gap-3">
              <MessageSquare className="w-8 h-8 text-secondary group-hover:scale-110 transition-transform" />
              <div>
                <CardTitle>Ask Questions</CardTitle>
                <p className="text-sm text-muted-foreground">Get instant AI-powered answers</p>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <Button variant="outline" className="w-full">Ask Now</Button>
          </CardContent>
        </Card>

        <ChallengePanel userId={user.id} />
      </div>
    </div>
  );
}
