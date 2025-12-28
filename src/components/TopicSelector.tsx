import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { motion } from "framer-motion";
import { Loader2, AlertCircle } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";
import { createTimeout } from "@/utils/timeout";

interface Topic {
  id: string;
  name: string;
  category: string;
  description: string;
  difficulty_level: string;
  icon: string;
  order_index: number;
}

interface TopicProgress {
  topic_id: string;
  questions_answered: number;
  correct_answers: number;
  completion_percentage: number;
}

interface TopicSelectorProps {
  onSelectTopic: (topic: Topic) => void;
  selectedTopicId?: string;
}

export default function TopicSelector({ onSelectTopic, selectedTopicId }: TopicSelectorProps) {
  const [topics, setTopics] = useState<Topic[]>([]);
  const [progress, setProgress] = useState<Record<string, TopicProgress>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;

    const loadTopics = async () => {
      try {
        setLoading(true);
        setError(null);

        // Add timeout for topics loading
        const timeoutPromise = createTimeout(8000, "Topics loading timed out");

        const fetchPromise = (async () => {
          const { data: topicsData, error: topicsError } = await supabase
            .from("learning_topics")
            .select("*")
            .order("order_index");

          if (topicsError) throw topicsError;

          const { data: progressData, error: progressError } = await supabase
            .from("user_topic_progress")
            .select("*");

          if (progressError) throw progressError;

          return { topicsData, progressData };
        })();

        const { topicsData, progressData } = await Promise.race([fetchPromise, timeoutPromise]) as any;

        if (mounted) {
          if (topicsData) setTopics(topicsData);

          if (progressData) {
            const progressMap = progressData.reduce((acc: Record<string, TopicProgress>, p: TopicProgress) => {
              acc[p.topic_id] = p;
              return acc;
            }, {} as Record<string, TopicProgress>);
            setProgress(progressMap);
          }

          setLoading(false);
        }
      } catch (err: any) {
        console.error("Error loading topics:", err);
        if (mounted) {
          setError(err?.message || "Failed to load topics");
          setLoading(false);
        }
      }
    };

    loadTopics();

    return () => {
      mounted = false;
    };
  }, []);

  const getDifficultyColor = (level: string) => {
    switch (level) {
      case "beginner": return "bg-success/20 text-success-foreground border-success";
      case "intermediate": return "bg-primary/20 text-primary-foreground border-primary";
      case "advanced": return "bg-achievement/20 text-achievement-foreground border-achievement";
      default: return "bg-muted";
    }
  };

  if (loading) {
    return (
      <div className="space-y-6 p-4">
        {[1, 2, 3].map((i) => (
          <div key={i} className="space-y-3">
            <Skeleton className="h-6 w-32" />
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
              {[1, 2, 3].map((j) => (
                <Card key={j} className="p-4">
                  <div className="flex items-start gap-3">
                    <Skeleton className="h-12 w-12 rounded" />
                    <div className="flex-1 space-y-2">
                      <div className="flex justify-between">
                        <Skeleton className="h-4 w-24" />
                        <Skeleton className="h-5 w-16 rounded-full" />
                      </div>
                      <Skeleton className="h-4 w-full" />
                      <Skeleton className="h-4 w-3/4" />
                    </div>
                  </div>
                </Card>
              ))}
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center p-8">
        <Card className="max-w-md p-6 text-center space-y-4">
          <AlertCircle className="h-12 w-12 text-destructive mx-auto" />
          <h2 className="text-xl font-semibold">Unable to load topics</h2>
          <p className="text-muted-foreground">{error}</p>
          <Button onClick={() => window.location.reload()} variant="outline">
            Try Again
          </Button>
        </Card>
      </div>
    );
  }

  const categories = [...new Set(topics.map(t => t.category))];

  return (
    <div className="space-y-6">
      {categories.map((category) => (
        <div key={category} className="space-y-3">
          <h3 className="text-lg font-semibold capitalize text-foreground">
            {category}
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
            {topics
              .filter((t) => t.category === category)
              .map((topic, idx) => {
                const topicProgress = progress[topic.id];
                const isSelected = selectedTopicId === topic.id;

                return (
                  <motion.div
                    key={topic.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: idx * 0.05 }}
                  >
                    <Card
                      className={`p-4 cursor-pointer transition-all hover:shadow-cosmic ${
                        isSelected ? "ring-2 ring-primary shadow-cosmic" : ""
                      }`}
                      onClick={() => onSelectTopic(topic)}
                    >
                      <div className="flex items-start gap-3">
                        <div className="text-3xl">{topic.icon}</div>
                        <div className="flex-1 space-y-2">
                          <div className="flex items-start justify-between gap-2">
                            <h4 className="font-semibold text-card-foreground">{topic.name}</h4>
                            <Badge className={getDifficultyColor(topic.difficulty_level)}>
                              {topic.difficulty_level}
                            </Badge>
                          </div>
                          <p className="text-sm text-muted-foreground line-clamp-2">
                            {topic.description}
                          </p>
                          {topicProgress && (
                            <div className="space-y-1">
                              <div className="flex justify-between text-xs text-muted-foreground">
                                <span>{topicProgress.questions_answered} questions</span>
                                <span>{topicProgress.completion_percentage}%</span>
                              </div>
                              <div className="h-1.5 bg-muted rounded-full overflow-hidden">
                                <div
                                  className="h-full bg-primary transition-all"
                                  style={{ width: `${topicProgress.completion_percentage}%` }}
                                />
                              </div>
                            </div>
                          )}
                        </div>
                      </div>
                    </Card>
                  </motion.div>
                );
              })}
          </div>
        </div>
      ))}
    </div>
  );
}