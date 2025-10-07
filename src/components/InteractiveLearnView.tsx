import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";
import { Loader2, MessageSquare, BookOpen } from "lucide-react";

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

interface InteractiveLearnViewProps {
  onSelectTopic?: (topic: Topic) => void;
}

export function InteractiveLearnView({ onSelectTopic }: InteractiveLearnViewProps) {
  const [topics, setTopics] = useState<Topic[]>([]);
  const [progress, setProgress] = useState<Record<string, TopicProgress>>({});
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    loadTopics();
  }, []);

  const loadTopics = async () => {
    try {
      const { data: topicsData } = await supabase
        .from("learning_topics")
        .select("*")
        .order("order_index");

      const { data: progressData } = await supabase
        .from("user_topic_progress")
        .select("*");

      if (topicsData) setTopics(topicsData);
      if (progressData) {
        const progressMap = progressData.reduce((acc, p) => {
          acc[p.topic_id] = p;
          return acc;
        }, {} as Record<string, TopicProgress>);
        setProgress(progressMap);
      }
    } catch (error) {
      console.error("Error loading topics:", error);
    } finally {
      setLoading(false);
    }
  };

  const getDifficultyColor = (level: string) => {
    switch (level) {
      case "beginner": return "bg-success/20 text-success-foreground border-success";
      case "intermediate": return "bg-primary/20 text-primary-foreground border-primary";
      case "advanced": return "bg-achievement/20 text-achievement-foreground border-achievement";
      default: return "bg-muted";
    }
  };

  const handleTopicSelect = (topic: Topic) => {
    if (onSelectTopic) {
      onSelectTopic(topic);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center p-8">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  const categories = [...new Set(topics.map(t => t.category))];

  return (
    <div className="space-y-6 p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-3xl font-bold text-foreground mb-2">Learning Topics</h2>
          <p className="text-muted-foreground">Select a topic to start learning with AI assistance</p>
        </div>
      </div>

      {categories.map((category) => (
        <div key={category} className="space-y-3">
          <h3 className="text-lg font-semibold capitalize text-foreground flex items-center gap-2">
            <BookOpen className="h-5 w-5" />
            {category}
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
            {topics
              .filter((t) => t.category === category)
              .map((topic, idx) => {
                const topicProgress = progress[topic.id];

                return (
                  <motion.div
                    key={topic.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: idx * 0.05 }}
                  >
                    <Card
                      className="p-4 transition-all hover:shadow-lg border-2 hover:border-primary/50"
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
                          <Button
                            size="sm"
                            className="w-full mt-2"
                            onClick={() => handleTopicSelect(topic)}
                          >
                            <MessageSquare className="h-4 w-4 mr-2" />
                            Start Learning
                          </Button>
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