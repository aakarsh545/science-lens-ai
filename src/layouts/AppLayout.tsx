import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate, Outlet } from "react-router-dom";
import { Loader2 } from "lucide-react";
import { AppSidebar } from "@/components/AppSidebar";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { DecorationSystem } from "@/components/DecorationSystem";
import { UserAvatar } from "@/components/UserAvatar";
import { Button } from "@/components/ui/button";
import { clearUserData, migrateUserData } from "@/utils/userStorage";

export default function AppLayout() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const navigate = useNavigate();

  // Apply user's theme to DOM (called immediately when user loads)
  const applyUserTheme = (userId: string) => {
    try {
      const themeKey = `theme_${userId}`;
      const savedTheme = localStorage.getItem(themeKey) as "dark" | "light" | null;
      const themeToApply = savedTheme || "dark";

      // Clear and apply theme
      document.documentElement.classList.remove("light");
      if (themeToApply === "light") {
        document.documentElement.classList.add("light");
      }

      console.log(`[AppLayout] Applied theme ${themeToApply} for user ${userId}`);
    } catch (error) {
      console.warn('localStorage not available:', error);
      // Default to dark theme if localStorage fails
      document.documentElement.classList.remove("light");
    }
  };

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      // Migrate any old generic localStorage to user-scoped
      migrateUserData(session.user);
      // Apply user's theme immediately to DOM
      applyUserTheme(session.user.id);
      setLoading(false);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      // Migrate any old generic localStorage to user-scoped
      migrateUserData(session.user);
      // Apply user's theme immediately to DOM
      applyUserTheme(session.user.id);
      setLoading(false);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const handleSelectConversation = (convId: string) => {
    setConversationId(convId);
    navigate("/");
  };

  const handleNewConversation = async () => {
    if (!user) return;

    const { data: newConvo, error } = await supabase
      .from("conversations")
      .insert({ user_id: user.id, title: "New Chat" })
      .select()
      .single();

    if (!error && newConvo) {
      setConversationId(newConvo.id);
      navigate("/");
    }
  };

  const handleSignOut = async () => {
    // Clear user-specific localStorage before signing out
    clearUserData(user);
    await supabase.auth.signOut();
    navigate("/");
  };

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <ThemeProvider userId={user.id}>
      <SidebarProvider defaultOpen={true}>
        <div className="min-h-screen flex w-full">
          <DecorationSystem />
          <AppSidebar
            userId={user.id}
            conversationId={conversationId}
            onSelectConversation={handleSelectConversation}
            onNewConversation={handleNewConversation}
          />

          <div className="flex-1 flex flex-col">
            <header className="h-14 flex items-center justify-between border-b px-4 bg-background">
              <div className="flex items-center">
                <SidebarTrigger className="mr-4" />
              </div>
              <div className="flex items-center gap-3">
                <UserAvatar userId={user.id} className="h-9 w-9 cursor-pointer hover:ring-2 hover:ring-primary transition-all" />
                <Button variant="ghost" size="sm" onClick={handleSignOut}>
                  Sign Out
                </Button>
              </div>
            </header>

            <main className="flex-1 overflow-auto">
              <Outlet />
            </main>
          </div>
        </div>
      </SidebarProvider>
    </ThemeProvider>
  );
}
