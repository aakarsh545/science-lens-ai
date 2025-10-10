import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2 } from "lucide-react";
import { EnhancedChatView } from "@/components/EnhancedChatView";
import { InteractiveLearnView } from "@/components/InteractiveLearnView";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";

export default function LearnPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [selectedTopic, setSelectedTopic] = useState<any>(null);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const handleTopicSelect = (topic: any) => {
    setSelectedTopic(topic);
  };

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="h-full">
      <Tabs defaultValue="topics" className="h-full flex flex-col">
        <div className="border-b px-6 pt-4">
          <TabsList className="grid w-full max-w-md grid-cols-2">
            <TabsTrigger value="topics">Browse Topics</TabsTrigger>
            <TabsTrigger value="chat">Learn with AI</TabsTrigger>
          </TabsList>
        </div>
        
        <TabsContent value="topics" className="flex-1 overflow-auto mt-0">
          <InteractiveLearnView onSelectTopic={handleTopicSelect} />
        </TabsContent>
        
        <TabsContent value="chat" className="flex-1 overflow-auto mt-0">
          <EnhancedChatView 
            user={user} 
            selectedTopic={selectedTopic}
            conversationId={conversationId}
            onConversationChange={() => setConversationId(null)}
            panelContext="learn"
          />
        </TabsContent>
      </Tabs>
    </div>
  );
}
