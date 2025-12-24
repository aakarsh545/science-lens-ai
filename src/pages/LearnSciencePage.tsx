import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, BookOpen, Sparkles, Trophy } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";

interface Topic {
  id: string;
  name: string;
  description: string;
  icon: string;
  difficulty_level: string;
}

export default function LearnSciencePage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [topics, setTopics] = useState<Topic[]>([]);
  const [progress, setProgress] = useState<any>({});
  const navigate = useNavigate();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadTopics();
      loadProgress(session.user.id);
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

  const startLesson = (topic: Topic) => {
    navigate("/science-lens/learning", { state: { topic } });
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
      <div className="mb-8">
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          Learn Science
        </h1>
        <p className="text-muted-foreground">
          Master science topics with interactive lessons and quizzes
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
                  
                  return (
                    <Card key={topic.id} className="hover:shadow-cosmic transition-all duration-300 cursor-pointer group">
                      <CardHeader>
                        <div className="flex items-start justify-between">
                          <div className="flex items-center gap-2">
                            <BookOpen className="w-5 h-5 text-primary" />
                            <CardTitle className="group-hover:text-primary transition-colors">
                              {topic.name}
                            </CardTitle>
                          </div>
                          <Badge variant={
                            topic.difficulty_level === "beginner" ? "default" :
                            topic.difficulty_level === "intermediate" ? "secondary" :
                            "destructive"
                          }>
                            {topic.difficulty_level}
                          </Badge>
                        </div>
                        <CardDescription>{topic.description}</CardDescription>
                      </CardHeader>
                      
                      <CardContent>
                        <div className="space-y-4">
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
                            onClick={() => startLesson(topic)}
                            variant={completionPercentage > 0 ? "outline" : "default"}
                            className="w-full"
                          >
                            {completionPercentage > 0 ? "Continue Learning" : "Start Lesson"}
                          </Button>
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
