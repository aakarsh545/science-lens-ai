import { useEffect, useState, useCallback } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { LogOut, MessageSquare, Trophy, Flame, Target, Zap, BookOpen, ArrowLeft, Settings as SettingsIcon, Loader2, AlertCircle } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";
import ChatInterface from "./ChatInterface";
import TopicSelector from "./TopicSelector";
import ProgressRing from "./ProgressRing";
import ThemeToggle from "./ThemeToggle";
import Settings from "./Settings";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Skeleton } from "@/components/ui/skeleton";
import { createTimeout } from "@/utils/timeout";

interface DashboardProps {
  user: User;
}

interface Topic {
  id: string;
  name: string;
  icon: string;
  description: string;
}

interface Profile {
  username?: string | null;
  display_name: string | null;
  full_name?: string | null;
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

const Dashboard = ({ user }: DashboardProps) => {
  const [profile, setProfile] = useState<Profile | null>(null);
  const [achievements, setAchievements] = useState<Achievement[]>([]);
  const [showChat, setShowChat] = useState(false);
  const [selectedTopic, setSelectedTopic] = useState<Topic | null>(null);
  const [showTopicSelector, setShowTopicSelector] = useState(false);
  const [showSettings, setShowSettings] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { toast } = useToast();

  useEffect(() => {
    let mounted = true;

    const loadData = async () => {
      try {
        setLoading(true);
        setError(null);

        // Add timeout for data fetching
        const timeoutPromise = createTimeout(10000, "Data loading timed out");

        const dataPromise = Promise.all([
          loadProfile(),
          loadAchievements()
        ]);

        await Promise.race([dataPromise, timeoutPromise]);

        if (mounted) {
          setLoading(false);
        }
      } catch (err: unknown) {
        console.error("Error loading dashboard data:", err);
        if (mounted) {
          setError(err instanceof Error ? err.message : "Failed to load dashboard data");
          setLoading(false);
        }
      }
    };

    loadData();

    return () => {
      mounted = false;
    };
  }, [user, loadProfile, loadAchievements]);

  const loadProfile = useCallback(async () => {
    const { data, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("user_id", user.id)
      .single();

    if (error) throw error;
    if (data) setProfile(data);
  }, [user.id]);

  const loadAchievements = useCallback(async () => {
    const { data, error } = await supabase
      .from("achievements")
      .select("*")
      .eq("user_id", user.id)
      .order("earned_at", { ascending: false });

    if (error) throw error;
    if (data) setAchievements(data);
  }, [user.id]);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    toast({
      title: "Signed out successfully",
      description: "See you next time!",
    });
  };

  if (showChat && selectedTopic) {
    return (
      <div className="min-h-screen bg-background">
        <div className="container mx-auto p-4">
          <div className="flex items-center justify-between mb-4">
            <Button
              variant="ghost"
              onClick={() => {
                setShowChat(false);
                setSelectedTopic(null);
              }}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
            <ThemeToggle />
          </div>
          <ChatInterface user={user} topic={selectedTopic} />
        </div>
      </div>
    );
  }

  if (showSettings) {
    return (
      <div className="min-h-screen bg-background">
        <div className="container mx-auto p-6">
          <div className="flex items-center justify-between mb-6">
            <Button
              variant="ghost"
              onClick={() => setShowSettings(false)}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
            <ThemeToggle />
          </div>
          <Settings />
        </div>
      </div>
    );
  }

  if (showTopicSelector) {
    return (
      <div className="min-h-screen bg-background">
        <div className="container mx-auto p-6">
          <div className="flex items-center justify-between mb-6">
            <Button
              variant="ghost"
              onClick={() => setShowTopicSelector(false)}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back to Dashboard
            </Button>
            <ThemeToggle />
          </div>
          <div className="mb-6">
            <h2 className="text-3xl font-bold text-foreground mb-2">Choose a Topic</h2>
            <p className="text-muted-foreground">Select a topic to start your learning journey</p>
          </div>
          <TopicSelector
            onSelectTopic={(topic) => {
              setSelectedTopic(topic);
              setShowChat(true);
              setShowTopicSelector(false);
            }}
            selectedTopicId={selectedTopic?.id}
          />
        </div>
      </div>
    );
  }

  // Show loading state while fetching data
  if (loading) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-7xl mx-auto space-y-6">
          <div className="space-y-2">
            <Skeleton className="h-10 w-64" />
            <Skeleton className="h-5 w-48" />
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {[1, 2, 3, 4].map((i) => (
              <Card key={i} className="p-6">
                <div className="flex flex-col items-center space-y-4">
                  <Skeleton className="h-24 w-24 rounded-full" />
                  <div className="space-y-2 w-full">
                    <Skeleton className="h-4 w-24 mx-auto" />
                    <Skeleton className="h-3 w-16 mx-auto" />
                  </div>
                </div>
              </Card>
            ))}
          </div>
          <Card className="p-6">
            <Skeleton className="h-32 w-full" />
          </Card>
        </div>
      </div>
    );
  }

  // Show error state
  if (error) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center p-6">
        <Card className="max-w-md p-6 text-center space-y-4">
          <AlertCircle className="h-12 w-12 text-destructive mx-auto" />
          <h2 className="text-xl font-semibold">Unable to load dashboard</h2>
          <p className="text-muted-foreground">{error}</p>
          <Button onClick={() => window.location.reload()} variant="outline">
            Try Again
          </Button>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center justify-between"
        >
          <div>
            <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent">
              Welcome back, {profile?.username || profile?.display_name || profile?.full_name || user?.email?.split("@")[0] || "Explorer"}!
            </h1>
            <p className="text-muted-foreground mt-2">
              Level {profile?.level || 1}
            </p>
          </div>
          <div className="flex items-center gap-2">
            <ThemeToggle />
            <Button variant="ghost" onClick={() => setShowSettings(true)}>
              <SettingsIcon className="mr-2 h-4 w-4" />
              Settings
            </Button>
            <Button variant="ghost" onClick={handleSignOut}>
              <LogOut className="mr-2 h-4 w-4" />
              Sign Out
            </Button>
          </div>
        </motion.div>

        {/* Stats with Progress Rings */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="card-cosmic hover:shadow-cosmic transition-shadow p-6">
              <div className="flex flex-col items-center space-y-4">
                <ProgressRing
                  progress={Math.min(((profile?.streak_count || 0) / 30) * 100, 100)}
                  value={profile?.streak_count || 0}
                  label="days"
                  size={100}
                />
                <div className="text-center">
                  <h3 className="font-semibold flex items-center gap-2 justify-center">
                    <Flame className="h-4 w-4 text-achievement" />
                    Streak
                  </h3>
                  <p className="text-xs text-muted-foreground">Keep learning daily!</p>
                </div>
              </div>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="card-cosmic hover:shadow-cosmic transition-shadow p-6">
              <div className="flex flex-col items-center space-y-4">
                <ProgressRing
                  progress={Math.min(((profile?.total_questions || 0) / 100) * 100, 100)}
                  value={profile?.total_questions || 0}
                  label="questions"
                  size={100}
                />
                <div className="text-center">
                  <h3 className="font-semibold flex items-center gap-2 justify-center">
                    <Target className="h-4 w-4 text-primary" />
                    Questions
                  </h3>
                  <p className="text-xs text-muted-foreground">Knowledge acquired</p>
                </div>
              </div>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="card-cosmic hover:shadow-cosmic transition-shadow p-6">
              <div className="flex flex-col items-center space-y-4">
                <ProgressRing
                  progress={Math.min(((profile?.xp_points || 0) / 1000) * 100, 100)}
                  value={profile?.xp_points || 0}
                  label="XP"
                  size={100}
                />
                <div className="text-center">
                  <h3 className="font-semibold flex items-center gap-2 justify-center">
                    <Zap className="h-4 w-4 text-success" />
                    Experience
                  </h3>
                  <p className="text-xs text-muted-foreground">Level {profile?.level || 1}</p>
                </div>
              </div>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.4 }}
          >
            <Card className="card-cosmic hover:shadow-cosmic transition-shadow p-6">
              <div className="flex flex-col items-center space-y-4">
                <ProgressRing
                  progress={Math.min(((achievements.length || 0) / 20) * 100, 100)}
                  value={achievements.length}
                  label="badges"
                  size={100}
                />
                <div className="text-center">
                  <h3 className="font-semibold flex items-center gap-2 justify-center">
                    <Trophy className="h-4 w-4 text-achievement" />
                    Achievements
                  </h3>
                  <p className="text-xs text-muted-foreground">Unlocked badges</p>
                </div>
              </div>
            </Card>
          </motion.div>
        </div>

        {/* Learning Actions */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
        >
          <Tabs defaultValue="learn" className="w-full">
            <TabsList className="grid w-full grid-cols-2 max-w-md mx-auto">
              <TabsTrigger value="learn">Start Learning</TabsTrigger>
              <TabsTrigger value="topics">Browse Topics</TabsTrigger>
            </TabsList>
            <TabsContent value="learn" className="text-center mt-6">
              <Button
                size="lg"
                onClick={() => setShowTopicSelector(true)}
                className="btn-cosmic text-lg px-8 py-6"
              >
                <MessageSquare className="mr-2 h-5 w-5" />
                Choose Topic & Start
              </Button>
            </TabsContent>
            <TabsContent value="topics" className="mt-6">
              <div className="text-center">
                <Button
                  size="lg"
                  variant="outline"
                  onClick={() => setShowTopicSelector(true)}
                  className="text-lg px-8 py-6"
                >
                  <BookOpen className="mr-2 h-5 w-5" />
                  Explore All Topics
                </Button>
              </div>
            </TabsContent>
          </Tabs>
        </motion.div>

        {/* Achievements */}
        {achievements.length > 0 && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.6 }}
          >
            <Card className="card-cosmic">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Trophy className="h-5 w-5 text-achievement" />
                  Your Achievements
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {achievements.slice(0, 6).map((achievement, idx) => (
                    <motion.div
                      key={idx}
                      initial={{ opacity: 0, scale: 0.9 }}
                      animate={{ opacity: 1, scale: 1 }}
                      transition={{ delay: idx * 0.1 }}
                      className="p-4 rounded-lg bg-gradient-achievement border border-achievement/30"
                    >
                      <h4 className="font-bold mb-1">{achievement.title}</h4>
                      <p className="text-sm text-muted-foreground">{achievement.description}</p>
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
};

export default Dashboard;