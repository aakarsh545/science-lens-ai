import { useEffect, useState } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Card } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import { MessageSquare } from "lucide-react";
import { motion } from "framer-motion";

interface ChatProgressProps {
  user: User;
  onViewChats: () => void;
}

interface Conversation {
  id: string;
  title: string;
  created_at: string;
  updated_at: string;
}

export function ChatProgress({ user, onViewChats }: ChatProgressProps) {
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadConversations();
  }, [user.id]);

  const loadConversations = async () => {
    const { data } = await supabase
      .from("conversations")
      .select("*")
      .eq("user_id", user.id)
      .order("updated_at", { ascending: false })
      .limit(4);

    if (data) {
      setConversations(data);
    }
    setLoading(false);
  };

  const progress = Math.min((conversations.length / 100) * 100, 100);

  return (
    <div className="py-8 px-6">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="max-w-4xl mx-auto space-y-6"
      >
        <div className="text-center space-y-2">
          <h2 className="text-2xl font-bold">Your Chat Journey</h2>
          <p className="text-muted-foreground">
            {conversations.length} / 100 conversations completed
          </p>
        </div>

        <div className="space-y-2">
          <Progress value={progress} className="h-3" />
          <div className="flex justify-between text-sm text-muted-foreground">
            <span>Getting Started</span>
            <span>Expert Level</span>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {conversations.map((conv) => (
            <Card key={conv.id} className="p-4 hover:bg-accent transition-colors cursor-pointer">
              <div className="flex items-start gap-3">
                <MessageSquare className="h-5 w-5 text-primary mt-0.5" />
                <div className="flex-1 min-w-0">
                  <h3 className="font-medium truncate">{conv.title}</h3>
                  <p className="text-xs text-muted-foreground">
                    {new Date(conv.updated_at).toLocaleDateString()}
                  </p>
                </div>
              </div>
            </Card>
          ))}
        </div>

        {conversations.length === 0 && !loading && (
          <div className="text-center py-12 text-muted-foreground">
            <MessageSquare className="h-12 w-12 mx-auto mb-3 opacity-50" />
            <p>No conversations yet. Start chatting to see your progress!</p>
          </div>
        )}

        <div className="text-center">
          <Button onClick={onViewChats} variant="outline">
            View All Chats
          </Button>
        </div>
      </motion.div>
    </div>
  );
}
