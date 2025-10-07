import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate, useLocation } from "react-router-dom";
import { Loader2 } from "lucide-react";
import { AppSidebar } from "@/components/AppSidebar";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { DashboardView } from "@/components/DashboardView";
import { EnhancedChatView } from "@/components/EnhancedChatView";
import { InteractiveLearnView } from "@/components/InteractiveLearnView";
import { AchievementsView } from "@/components/AchievementsView";
import Settings from "@/components/Settings";

export default function EnhancedDashboardPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [selectedTopic, setSelectedTopic] = useState<any>(null);
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
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

  const getActiveView = () => {
    const path = location.pathname;
    if (path === "/chat") return "chat";
    if (path === "/learn") return "learn";
    if (path === "/achievements") return "achievements";
    if (path === "/settings") return "settings";
    return "dashboard";
  };

  const activeView = getActiveView();

  const handleTopicSelect = (topic: any) => {
    setSelectedTopic(topic);
    navigate("/chat");
  };

  return (
    <SidebarProvider>
      <div className="min-h-screen flex w-full">
        <AppSidebar />
        
        <div className="flex-1 flex flex-col">
          <header className="h-14 flex items-center border-b px-4 bg-background">
            <SidebarTrigger className="mr-4" />
            <h1 className="text-lg font-semibold">
              {activeView === "dashboard" && "Dashboard"}
              {activeView === "chat" && (selectedTopic ? `${selectedTopic.icon} ${selectedTopic.name}` : "AI Chat")}
              {activeView === "learn" && "Learn"}
              {activeView === "achievements" && "Achievements"}
              {activeView === "settings" && "Settings"}
            </h1>
          </header>

          <main className="flex-1 overflow-auto">
            {activeView === "dashboard" && <DashboardView user={user} />}
            {activeView === "chat" && <EnhancedChatView user={user} selectedTopic={selectedTopic} />}
            {activeView === "learn" && <InteractiveLearnView onSelectTopic={handleTopicSelect} />}
            {activeView === "achievements" && <AchievementsView user={user} />}
            {activeView === "settings" && (
              <div className="p-6">
                <Settings />
              </div>
            )}
          </main>
        </div>
      </div>
    </SidebarProvider>
  );
}