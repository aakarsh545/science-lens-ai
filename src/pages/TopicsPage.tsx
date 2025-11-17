import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, BookOpen } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

interface Topic {
  id: string;
  name: string;
  description: string;
  category: string;
  difficulty_level: string;
}

export default function TopicsPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [topics, setTopics] = useState<Topic[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadTopics();
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
      .order("category, order_index");
    
    if (data) setTopics(data);
  };

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  const groupedTopics = topics.reduce((acc, topic) => {
    if (!acc[topic.category]) {
      acc[topic.category] = [];
    }
    acc[topic.category].push(topic);
    return acc;
  }, {} as Record<string, Topic[]>);

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          All Science Topics
        </h1>
        <p className="text-muted-foreground">
          Browse all available learning topics organized by category
        </p>
      </div>

      <div className="space-y-8">
        {Object.entries(groupedTopics).map(([category, categoryTopics]) => (
          <div key={category}>
            <h2 className="text-2xl font-bold mb-4 capitalize text-primary">{category}</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {categoryTopics.map((topic) => (
                <Card key={topic.id} className="hover:shadow-cosmic transition-all duration-300 cursor-pointer group">
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div className="flex items-center gap-2">
                        <BookOpen className="w-5 h-5 text-primary" />
                        <CardTitle className="text-lg group-hover:text-primary transition-colors">
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
                </Card>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
