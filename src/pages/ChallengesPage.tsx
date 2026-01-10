import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, Trophy, Target, Flame, Star, Lock, BookOpen, AlertCircle, Coins } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useToast } from "@/hooks/use-toast";
import { Progress } from "@/components/ui/progress";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { getDifficultyColors } from "@/lib/utils";

interface Topic {
  id: string;
  name: string;
  category: string;
  difficulty_level: string;
  description: string;
  icon: string;
}

interface Course {
  id: string;
  title: string;
  slug: string;
  category: string;
}

export default function ChallengesPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [topics, setTopics] = useState<Topic[]>([]);
  const [courses, setCourses] = useState<Course[]>([]);
  const [completedLessonsCount, setCompletedLessonsCount] = useState(0);
  const [userLevel, setUserLevel] = useState(1);
  const navigate = useNavigate();
  const { toast } = useToast();

  useEffect(() => {
    const initializePage = async () => {
      try {
        const { data: { session } } = await supabase.auth.getSession();

        if (!session) {
          navigate("/");
          return;
        }

        setUser(session.user);
        await Promise.all([
          loadTopics(),
          loadCourses(),
          loadUserProgress(session.user.id),
          loadUserProfile(session.user.id)
        ]);
      } catch (error) {
        console.error("Error initializing page:", error);
      } finally {
        setLoading(false);
      }
    };

    initializePage();

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
      }
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const loadTopics = async () => {
    const { data, error } = await supabase
      .from("learning_topics")
      .select("*")
      .order("order_index", { ascending: true });

    if (error) {
      console.error("Error loading topics:", error);
      return;
    }

    setTopics(data || []);
  };

  const loadCourses = async () => {
    const { data, error } = await supabase
      .from("courses")
      .select("*")
      .order("title");

    if (error) {
      console.error("Error loading courses:", error);
      return;
    }

    setCourses(data || []);
  };

  const loadUserProgress = async (userId: string) => {
    const { data, error } = await supabase
      .from("user_progress")
      .select("id")
      .eq("user_id", userId)
      .eq("status", "completed");

    if (error) {
      console.error("Error loading user progress:", error);
      return;
    }

    setCompletedLessonsCount(data?.length || 0);
  };

  const loadUserProfile = async (userId: string) => {
    const { data: profileData, error } = await supabase
      .from('profiles')
      .select('level')
      .eq('user_id', userId)
      .single();

    if (error) {
      console.error("Error loading user profile:", error);
      return;
    }

    if (profileData) {
      setUserLevel(profileData.level || 1);
    }
  };

  const startChallenge = (topic: Topic, difficulty: 'beginner' | 'intermediate' | 'advanced' = 'beginner', courseId?: string) => {
    const questionCount = difficulty === 'beginner' ? 15 : difficulty === 'intermediate' ? 30 : 45;
    const xpReward = difficulty === 'beginner' ? 100 : difficulty === 'intermediate' ? 200 : 500;

    toast({
      title: "Starting Challenge!",
      description: `Get ready for a ${questionCount}-question ${difficulty} challenge on ${topic.name}`,
    });

    // Navigate to challenge session - will create a new session
    navigate(`/challenges/session/new`, {
      state: {
        topicId: courseId || topic.id,
        topicName: topic.name,
        difficulty: difficulty,
      },
    });
  };

  const startCourseChallenge = (course: Course) => {
    toast({
      title: "Starting Challenge!",
      description: `Get ready for a 15-question challenge on ${course.title}`,
    });

    navigate(`/challenges/session/new`, {
      state: {
        topicId: course.id,
        topicName: course.title,
      },
    });
  };

  const getDifficultyColor = (level: string) => {
    return getDifficultyColors(level);
  };

  const beginnerTopics = topics.filter(t => t.difficulty_level === "beginner");
  const intermediateTopics = topics.filter(t => t.difficulty_level === "intermediate");
  const advancedTopics = topics.filter(t => t.difficulty_level === "advanced");

  const TopicCard = ({ topic, courseId }: { topic: Topic; courseId?: string }) => {
    const difficulties: Array<'beginner' | 'intermediate' | 'advanced'> = ['beginner', 'intermediate', 'advanced'];
    const questionCounts = { beginner: 15, intermediate: 30, advanced: 45 };
    const xpRewards = { beginner: 100, intermediate: 200, advanced: 500 };
    const estimatedTimes = { beginner: '10 min', intermediate: '20 min', advanced: '30 min' };

    return (
      <Card className="border-primary/20">
        <CardHeader>
          <div className="flex items-start justify-between">
            <div className="flex items-center gap-3">
              <span className="text-3xl">{topic.icon || "📚"}</span>
              <div>
                <CardTitle>{topic.name}</CardTitle>
                <p className="text-xs text-muted-foreground capitalize mt-1">{topic.category}</p>
              </div>
            </div>
          </div>
          <CardDescription className="mt-3">{topic.description}</CardDescription>
        </CardHeader>

        <CardContent>
          <div className="space-y-3">
            {difficulties.map((difficulty) => {
              const questionCount = questionCounts[difficulty];
              const xpReward = xpRewards[difficulty];
              const estimatedTime = estimatedTimes[difficulty];

              return (
                <div
                  key={difficulty}
                  className="p-4 rounded-lg border-2 transition-all border-primary/20 hover:border-primary/40 bg-primary/5"
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <Badge className={getDifficultyColor(difficulty)}>
                        {difficulty === 'beginner' && '🔰 Beginner'}
                        {difficulty === 'intermediate' && '🔷 Intermediate'}
                        {difficulty === 'advanced' && '🔶 Advanced'}
                      </Badge>
                    </div>
                  </div>

                  <div className="flex items-center gap-4 text-sm text-muted-foreground mb-3">
                    <div className="flex items-center gap-1">
                      <Target className="w-4 h-4" />
                      <span>{questionCount} Questions</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Flame className="w-4 h-4" />
                      <span>3 Lives</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Trophy className="w-4 h-4" />
                      <span>{xpReward} XP</span>
                    </div>
                    <div className="flex items-center gap-1">
                      <Star className="w-4 h-4" />
                      <span>{estimatedTime}</span>
                    </div>
                  </div>

                  <Button
                    onClick={() => startChallenge(topic, difficulty, courseId)}
                    className="w-full"
                    size="sm"
                  >
                    <Star className="w-4 h-4 mr-2" />
                    Start {difficulty.charAt(0).toUpperCase() + difficulty.slice(1)} Challenge
                  </Button>
                </div>
              );
            })}
          </div>
        </CardContent>
      </Card>
    );
  };

  const CourseCard = ({ course }: { course: Course }) => (
    <Card className="hover:shadow-lg transition-all duration-300 cursor-pointer group border-primary/20">
      <CardHeader>
        <div className="flex items-start justify-between">
          <div>
            <CardTitle className="group-hover:text-primary transition-colors">
              {course.title}
            </CardTitle>
            <p className="text-xs text-muted-foreground capitalize mt-1">{course.category}</p>
          </div>
          <Badge variant="outline">Course</Badge>
        </div>
        <CardDescription className="mt-3">
          Test your knowledge with questions from all lessons in this course
        </CardDescription>
      </CardHeader>

      <CardContent>
        <Button
          onClick={() => startCourseChallenge(course)}
          className="w-full"
          variant="default"
        >
          <Star className="w-4 h-4 mr-2" />
          Start Challenge
        </Button>
      </CardContent>
    </Card>
  );

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  // Show locked state if no lessons completed
  if (completedLessonsCount === 0) {
    return (
      <div className="p-6 max-w-4xl mx-auto">
        <div className="flex flex-col items-center justify-center min-h-[70vh]">
          <Card className="w-full max-w-2xl text-center border-yellow-500/20 bg-gradient-to-br from-yellow-500/5 to-orange-500/5">
            <CardHeader className="space-y-6">
              <div className="flex justify-center">
                <div className="relative">
                  <div className="absolute inset-0 bg-yellow-500/20 blur-3xl rounded-full" />
                  <div className="relative bg-gradient-to-br from-yellow-500 to-orange-500 p-6 rounded-full">
                    <Lock className="h-16 w-16 text-white" />
                  </div>
                </div>
              </div>

              <div className="space-y-2">
                <CardTitle className="text-3xl font-bold bg-gradient-to-r from-yellow-500 to-orange-500 bg-clip-text text-transparent">
                  Challenges Locked
                </CardTitle>
                <CardDescription className="text-lg">
                  Complete at least 1 lesson to unlock challenges!
                </CardDescription>
              </div>

              <Alert className="border-yellow-500/20 bg-yellow-500/10">
                <AlertCircle className="h-4 w-4 text-yellow-600 dark:text-yellow-500" />
                <AlertDescription className="text-yellow-700 dark:text-yellow-400">
                  Challenges are designed to test your knowledge. Start learning to unlock them!
                </AlertDescription>
              </Alert>

              <div className="space-y-3 pt-4">
                <div className="flex items-center justify-between text-sm font-medium">
                  <span className="text-muted-foreground">Lessons Completed</span>
                  <span className="text-lg font-bold text-yellow-600 dark:text-yellow-400">
                    {completedLessonsCount} / 1
                  </span>
                </div>
                <Progress value={completedLessonsCount * 100} className="h-3" />
              </div>
            </CardHeader>

            <CardContent className="space-y-4">
              <div className="flex flex-col sm:flex-row gap-3 justify-center">
                <Button
                  onClick={() => navigate("/learning")}
                  size="lg"
                  className="bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600 text-white font-semibold"
                >
                  <BookOpen className="w-5 h-5 mr-2" />
                  Start Learning
                </Button>
                <Button
                  onClick={() => navigate("/")}
                  size="lg"
                  variant="outline"
                >
                  Go to Dashboard
                </Button>
              </div>

              <div className="pt-4 border-t">
                <p className="text-sm text-muted-foreground">
                  By completing lessons, you'll:
                </p>
                <ul className="mt-2 space-y-1 text-sm text-muted-foreground">
                  <li className="flex items-center justify-center gap-2">
                    <Star className="w-4 h-4 text-yellow-500" />
                    Earn XP and level up
                  </li>
                  <li className="flex items-center justify-center gap-2">
                    <Trophy className="w-4 h-4 text-yellow-500" />
                    Unlock challenge modes
                  </li>
                  <li className="flex items-center justify-center gap-2">
                    <Target className="w-4 h-4 text-yellow-500" />
                    Test your knowledge
                  </li>
                </ul>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-8">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-3">
            <Trophy className="h-8 w-8 text-primary" />
            <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-500 bg-clip-text text-transparent">
              Challenges
            </h1>
          </div>
          <Badge variant="outline" className="text-lg px-4 py-2">
            Level {userLevel}
          </Badge>
        </div>
        <p className="text-muted-foreground mb-4">
          Test your knowledge with our 3-tier challenge system. Each topic has Beginner (15 questions), Intermediate (30 questions), and Advanced (45 questions) levels.
        </p>
        <Alert className="border-blue-500/20 bg-blue-500/10">
          <AlertCircle className="h-4 w-4 text-blue-600 dark:text-blue-400" />
          <AlertDescription className="text-blue-700 dark:text-blue-300">
            <span className="font-medium">Level Requirements:</span> Intermediate challenges require Level 10, Advanced challenges require Level 20. Complete more lessons to level up!
          </AlertDescription>
        </Alert>
      </div>

      <Tabs defaultValue="topics" className="w-full">
        <TabsList className="grid w-full grid-cols-2 max-w-md">
          <TabsTrigger value="topics">By Topic</TabsTrigger>
          <TabsTrigger value="courses">By Course</TabsTrigger>
        </TabsList>

        <TabsContent value="topics" className="mt-6">
          <Tabs defaultValue="all" className="w-full">
            <TabsList className="grid w-full grid-cols-4 max-w-2xl">
              <TabsTrigger value="all">All</TabsTrigger>
              <TabsTrigger value="beginner">Beginner</TabsTrigger>
              <TabsTrigger value="intermediate">Intermediate</TabsTrigger>
              <TabsTrigger value="advanced">Advanced</TabsTrigger>
            </TabsList>

            <TabsContent value="all" className="mt-6">
              {topics.length === 0 ? (
                <div className="text-center py-12">
                  <Trophy className="h-16 w-16 text-muted-foreground/20 mx-auto mb-4" />
                  <p className="text-muted-foreground">No challenges available yet</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {topics.map((topic) => (
                    <TopicCard key={topic.id} topic={topic} />
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="beginner" className="mt-6">
              {beginnerTopics.length === 0 ? (
                <div className="text-center py-12">
                  <p className="text-muted-foreground">No beginner challenges available</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {beginnerTopics.map((topic) => (
                    <TopicCard key={topic.id} topic={topic} />
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="intermediate" className="mt-6">
              {intermediateTopics.length === 0 ? (
                <div className="text-center py-12">
                  <p className="text-muted-foreground">No intermediate challenges available</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {intermediateTopics.map((topic) => (
                    <TopicCard key={topic.id} topic={topic} />
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="advanced" className="mt-6">
              {advancedTopics.length === 0 ? (
                <div className="text-center py-12">
                  <p className="text-muted-foreground">No advanced challenges available</p>
                </div>
              ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                  {advancedTopics.map((topic) => (
                    <TopicCard key={topic.id} topic={topic} />
                  ))}
                </div>
              )}
            </TabsContent>
          </Tabs>
        </TabsContent>

        <TabsContent value="courses" className="mt-6">
          {courses.length === 0 ? (
            <div className="text-center py-12">
              <Trophy className="h-16 w-16 text-muted-foreground/20 mx-auto mb-4" />
              <p className="text-muted-foreground">No courses available</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {courses.map((course) => (
                <CourseCard key={course.id} course={course} />
              ))}
            </div>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
