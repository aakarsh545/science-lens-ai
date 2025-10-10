import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2 } from "lucide-react";
import { EnhancedChatView } from "@/components/EnhancedChatView";

export default function ChatPage() {
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

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="h-full">
      <EnhancedChatView 
        user={user} 
        selectedTopic={selectedTopic}
        conversationId={conversationId}
        onConversationChange={() => setConversationId(null)}
        panelContext="dashboard"
      />
    </div>
  );
}
