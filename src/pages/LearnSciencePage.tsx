import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, BookOpen, Sparkles, Trophy, Lock, Star } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { calculateLevel, getXpForNextLevel, getXpRemainingToNextLevel, getProgressToNextLevel } from "@/utils/levelCalculations";

interface Topic {
  id: string;
  name: string;
  description: string;
  icon: string;
  difficulty_level: string;
}

interface UserProfile {
  level: number;
  xp_points: number;
  xp_total: number;
}

interface DifficultyRequirement {
  level: number;
  label: string;
}

export default function LearnSciencePage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [topics, setTopics] = useState<Topic[]>([]);
  const [progress, setProgress] = useState<any>({});
  const [userProfile, setUserProfile] = useState<UserProfile>({
    level: 1,
    xp_points: 0,
    xp_total: 0,
  });
  const navigate = useNavigate();

  // Difficulty level requirements
  const difficultyRequirements: Record<string, DifficultyRequirement> = {
    beginner: { level: 1, label: "Level 1" },
    intermediate: { level: 10, label: "Level 10" },
    advanced: { level: 20, label: "Level 20" },
  };

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadTopics();
      loadProgress(session.user.id);
      loadUserProfile(session.user.id);
      setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
      }
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const loadTopics = async () => {
    const { data } = await supabase
      .from("learning_topics")
      .select("*")
      .order("order_index");
    
    if (data) setTopics(data);
  };

  const loadProgress = async (userId: string) => {
    const { data } = await supabase
      .from("user_topic_progress")
      .select("*")
      .eq("user_id", userId);

    if (data) {
      const progressMap: any = {};
      data.forEach(p => {
        progressMap[p.topic_id] = p;
      });
      setProgress(progressMap);
    }
  };

  const loadUserProfile = async (userId: string) => {
    try {
      // Fetch from both user_stats and profiles
      const [userStatsResult, profileResult] = await Promise.all([
        supabase.from("user_stats").select("xp_total").eq("user_id", userId).single(),
        supabase.from("profiles").select("xp_points, level").eq("user_id", userId).single(),
      ]);

      const xp_total = userStatsResult.data?.xp_total || 0;
      const xp_points = profileResult.data?.xp_points || 0;
      const storedLevel = profileResult.data?.level || 1;

      // Calculate level from XP to ensure accuracy
      const calculatedLevel = calculateLevel(xp_points);

      setUserProfile({
        level: calculatedLevel,
        xp_points,
        xp_total,
      });
    } catch (error) {
      console.error("Error loading user profile:", error);
    }
  };

  const startLesson = (topic: Topic) => {
    // Check if user meets the level requirement
    const requirement = difficultyRequirements[topic.difficulty_level];
    if (userProfile.level < requirement.level) {
      return; // Don't navigate if locked
    }
    navigate("/science-lens/learning", { state: { topic } });
  };

  const isTopicLocked = (topic: Topic): boolean => {
    const requirement = difficultyRequirements[topic.difficulty_level];
    return userProfile.level < requirement.level;
  };

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* User Level Display */}
      <Card className="mb-6 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
        <CardContent className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center">
                <span className="text-xl font-bold">L{userProfile.level}</span>
              </div>
              <div>
                <p className="text-lg font-semibold">Level {userProfile.level}</p>
                <p className="text-sm text-muted-foreground">
                  {userProfile.xp_points} XP Total
                </p>
              </div>
            </div>
            <div className="flex gap-4 text-sm">
              <div className="flex items-center gap-2">
                <Star className="w-4 h-4 text-yellow-500" />
                <span className="font-medium">
                  {getXpRemainingToNextLevel(userProfile.xp_points)} XP to next level
                </span>
              </div>
            </div>
          </div>
          <Progress
            value={getProgressToNextLevel(userProfile.xp_points)}
            className="h-2 mt-3"
          />
        </CardContent>
      </Card>

      <div className="mb-8">
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          Learn Science
        </h1>
        <p className="text-muted-foreground">
          Master science topics with interactive lessons and quizzes. Unlock higher difficulty lessons by leveling up!
        </p>
      </div>

      <Tabs defaultValue="all" className="w-full">
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="all">All Topics</TabsTrigger>
          <TabsTrigger value="beginner">Beginner</TabsTrigger>
          <TabsTrigger value="intermediate">Intermediate</TabsTrigger>
          <TabsTrigger value="advanced">Advanced</TabsTrigger>
        </TabsList>

        {["all", "beginner", "intermediate", "advanced"].map(difficulty => (
          <TabsContent key={difficulty} value={difficulty} className="mt-6">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {topics
                .filter(t => difficulty === "all" || t.difficulty_level === difficulty)
                .map((topic) => {
                  const topicProgress = progress[topic.id];
                  const completionPercentage = topicProgress?.completion_percentage || 0;
                  const locked = isTopicLocked(topic);
                  const requirement = difficultyRequirements[topic.difficulty_level];

                  return (
                    <Card
                      key={topic.id}
                      className={`hover:shadow-cosmic transition-all duration-300 cursor-pointer group ${
                        locked ? "opacity-60 bg-muted/30" : ""
                      }`}
                      onClick={() => !locked && startLesson(topic)}
                    >
                      <CardHeader>
                        <div className="flex items-start justify-between">
                          <div className="flex items-center gap-2">
                            <span className="text-2xl">{topic.icon}</span>
                            <CardTitle className={`group-hover:text-primary transition-colors ${locked ? "text-muted-foreground" : ""}`}>
                              {topic.name}
                            </CardTitle>
                          </div>
                          <div className="flex items-center gap-2">
                            {locked && (
                              <Badge variant="outline" className="gap-1">
                                <Lock className="w-3 h-3" />
                                {requirement.label}
                              </Badge>
                            )}
                            <Badge
                              variant={
                                topic.difficulty_level === "beginner"
                                  ? "default"
                                  : topic.difficulty_level === "intermediate"
                                  ? "secondary"
                                  : "destructive"
                              }
                            >
                              {topic.difficulty_level}
                            </Badge>
                          </div>
                        </div>
                        <CardDescription className={locked ? "text-muted-foreground/70" : ""}>
                          {topic.description}
                        </CardDescription>
                      </CardHeader>

                      <CardContent>
                        <div className="space-y-4">
                          {locked ? (
                            <div className="space-y-2">
                              <div className="flex items-center gap-2 text-sm text-amber-600 dark:text-amber-400">
                                <Lock className="w-4 h-4" />
                                <span className="font-medium">
                                  Requires Level {requirement.level}
                                </span>
                              </div>
                              <p className="text-xs text-muted-foreground">
                                You need to reach Level {requirement.level} to unlock this {topic.difficulty_level} lesson.
                                Current level: {userProfile.level}
                              </p>
                              <div className="pt-2">
                                <Progress
                                  value={(userProfile.level / requirement.level) * 100}
                                  className="h-2"
                                />
                                <p className="text-xs text-muted-foreground mt-1">
                                  {requirement.level - userProfile.level} more levels to unlock
                                </p>
                              </div>
                            </div>
                          ) : (
                            <>
                              {topicProgress && (
                                <div className="space-y-2">
                                  <div className="flex justify-between text-sm">
                                    <span className="text-muted-foreground">Progress</span>
                                    <span className="text-primary font-medium">{completionPercentage}%</span>
                                  </div>
                                  <Progress value={completionPercentage} className="h-2" />

                                  <div className="flex gap-4 text-xs text-muted-foreground">
                                    <div className="flex items-center gap-1">
                                      <Trophy className="w-3 h-3" />
                                      {topicProgress.correct_answers || 0} correct
                                    </div>
                                    <div className="flex items-center gap-1">
                                      <Sparkles className="w-3 h-3" />
                                      {topicProgress.questions_answered || 0} answered
                                    </div>
                                  </div>
                                </div>
                              )}

                              <Button
                                onClick={(e) => {
                                  e.stopPropagation();
                                  startLesson(topic);
                                }}
                                variant={completionPercentage > 0 ? "outline" : "default"}
                                className="w-full"
                              >
                                {completionPercentage > 0 ? "Continue Learning" : "Start Lesson"}
                              </Button>
                            </>
                          )}
                        </div>
                      </CardContent>
                    </Card>
                  );
                })}
            </div>
          </TabsContent>
        ))}
      </Tabs>
    </div>
  );
}
