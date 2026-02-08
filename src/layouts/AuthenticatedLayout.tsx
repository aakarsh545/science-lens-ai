import { Outlet, useNavigate } from "react-router-dom";
import { SidebarProvider } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { CreditsBar } from "@/components/CreditsBar";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Loader2 } from "lucide-react";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { OnboardingCutscene } from "@/components/OnboardingCutscene";

export default function AuthenticatedLayout() {
  const navigate = useNavigate();
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [showOnboarding, setShowOnboarding] = useState(false);
  const [checkedAuth, setCheckedAuth] = useState(false);

  useEffect(() => {
    let mounted = true;

    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return;

      if (session) {
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
      }
      setCheckedAuth(true);
      setLoading(false);
    });

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (!mounted) return;

      if (event === 'SIGNED_OUT') {
        // User explicitly signed out - clear theme and redirect to landing
        setUser(null);
        setCheckedAuth(true);
        setLoading(false);

        // Clear only theme system variables (prefixed with --color-)
        // Don't remove Tailwind's base variables
        const root = document.documentElement;
        const themeVars = [
          '--color-primary', '--color-secondary', '--color-accent', '--color-surface', '--color-background',
          '--color-text-primary', '--color-text-secondary', '--color-text-muted',
          '--color-primary-hover', '--color-accent-hover',
          '--color-border', '--color-border-subtle',
          '--color-card', '--color-card-hover', '--color-popover', '--color-muted', '--color-input',
          '--glow-primary', '--glow-accent',
          '--gradient-primary', '--gradient-surface',
          '--decoration-type', '--particle-intensity', '--animation-speed', '--bg-decoration'
        ];
        themeVars.forEach(varName => root.style.removeProperty(varName));

        navigate('/', { replace: true });
        return;
      }

      if (session) {
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
      }
      setCheckedAuth(true);
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, [navigate]);

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

  if (!user && checkedAuth) {
    // User is not authenticated and we've checked auth state - redirect to landing
    navigate('/', { replace: true });
    return null;
  }

  if (!user) {
    // Still checking auth or loading
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
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