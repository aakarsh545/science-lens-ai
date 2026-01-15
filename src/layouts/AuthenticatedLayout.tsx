import { Outlet } from "react-router-dom";
import { SidebarProvider } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { CreditsBar } from "@/components/CreditsBar";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Loader2 } from "lucide-react";
import { ThemeProvider } from "@/contexts/ThemeContext";
import LandingPage from "@/components/LandingPage";
import { OnboardingCutscene } from "@/components/OnboardingCutscene";

export default function AuthenticatedLayout() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [showOnboarding, setShowOnboarding] = useState(false);

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        setUser(null);
        setLoading(false);
        return;
      }
      setUser(session.user);

      // Safely check if user has seen onboarding
      try {
        const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
        if (!hasSeenOnboarding) {
          setShowOnboarding(true);
        }
      } catch (error) {
        console.warn('localStorage not available:', error);
        setShowOnboarding(true);
      }

      setLoading(false);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        setUser(null);
        setLoading(false);
        return;
      }
      setUser(session.user);

      // Safely check if user has seen onboarding
      try {
        const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
        if (!hasSeenOnboarding) {
          setShowOnboarding(true);
        }
      } catch (error) {
        console.warn('localStorage not available:', error);
        setShowOnboarding(true);
      }

      setLoading(false);
    });

    return () => subscription.unsubscribe();
  }, []);

  const handleOnboardingComplete = () => {
    try {
      localStorage.setItem('hasSeenOnboarding', 'true');
    } catch (error) {
      console.warn('localStorage not available:', error);
    }
    setShowOnboarding(false);
  };

  const handleOnboardingClose = () => {
    try {
      localStorage.setItem('hasSeenOnboarding', 'true');
    } catch (error) {
      console.warn('localStorage not available:', error);
    }
    setShowOnboarding(false);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!user) {
    return <LandingPage />;
  }

  // Show onboarding for logged-in users who haven't seen it
  if (showOnboarding) {
    return (
      <ThemeProvider userId={user.id}>
        <OnboardingCutscene
          onComplete={handleOnboardingComplete}
          onClose={handleOnboardingClose}
        />
      </ThemeProvider>
    );
  }

  return (
    <ThemeProvider userId={user.id}>
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
              <Outlet />
            </main>
          </div>
        </div>
      </SidebarProvider>
    </ThemeProvider>
  );
}