import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import LandingPage from "@/components/LandingPage";
import ExplorePage from "./ExplorePage";
import { Loader2 } from "lucide-react";
import { SidebarProvider } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { CreditsBar } from "@/components/CreditsBar";

const Index = () => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [conversationId, setConversationId] = useState<string | null>(null);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
      setLoading(false);
    });

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null);
    });

    return () => subscription.unsubscribe();
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!user) {
    return <LandingPage />;
  }

  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full">
        <AppSidebar 
          userId={user.id}
          conversationId={conversationId}
          onSelectConversation={setConversationId}
          onNewConversation={() => setConversationId(null)}
        />
        <div className="flex-1 flex flex-col">
          <CreditsBar userId={user.id} />
          <main className="flex-1 overflow-auto">
            <ExplorePage />
          </main>
        </div>
      </div>
    </SidebarProvider>
  );
};

export default Index;
