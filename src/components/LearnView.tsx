import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { BookOpen, Lightbulb, Microscope } from "lucide-react";

interface Topic {
  id: string;
  name: string;
  description: string;
  category: string;
  difficulty_level: string;
  icon: string;
}

const iconMap: { [key: string]: any } = {
  book: BookOpen,
  lightbulb: Lightbulb,
  microscope: Microscope,
};

export function LearnView() {
  const [topics, setTopics] = useState<Topic[]>([]);

  useEffect(() => {
    const loadTopics = async () => {
      const { data } = await supabase
        .from("learning_topics")
        .select("*")
        .order("order_index", { ascending: true });

      if (data) {
        setTopics(data);
      }
    };

    loadTopics();
  }, []);

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold mb-2">Learning Hub 📚</h1>
        <p className="text-muted-foreground">
          Explore science topics and expand your knowledge
        </p>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {topics.map((topic) => {
          const IconComponent = iconMap[topic.icon] || BookOpen;
          return (
            <Card key={topic.id} className="hover:shadow-lg transition-shadow cursor-pointer">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <IconComponent className="h-8 w-8 text-primary" />
                  <Badge variant={topic.difficulty_level === "beginner" ? "secondary" : "default"}>
                    {topic.difficulty_level}
                  </Badge>
                </div>
                <CardTitle className="mt-4">{topic.name}</CardTitle>
                <CardDescription>{topic.category}</CardDescription>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{topic.description}</p>
              </CardContent>
            </Card>
          );
        })}
      </div>

      {topics.length === 0 && (
        <div className="text-center text-muted-foreground py-12">
          <BookOpen className="h-16 w-16 mx-auto mb-4 opacity-50" />
          <h3 className="text-xl font-semibold mb-2">No topics yet</h3>
          <p>Learning content will appear here soon!</p>
        </div>
      )}
    </div>
  );
}