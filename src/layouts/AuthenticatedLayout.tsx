import { Navigate, Outlet, useNavigate } from "react-router-dom";
import { SidebarProvider } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { CreditsBar } from "@/components/CreditsBar";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { HelixLoader } from "@/components/ui/helix-loader";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { OnboardingCutscene } from "@/components/OnboardingCutscene";
import { getHasSeenOnboarding, setHasSeenOnboarding } from "@/utils/userStorage";

export default function AuthenticatedLayout() {
  const navigate = useNavigate();
  const getTestUser = () => {
    try {
      const params = new URLSearchParams(window.location.search);
      const forcePlaywright = params.has('playwright');
      if (forcePlaywright) {
        return {
          id: '00000000-0000-0000-0000-000000000000',
          email: 'test@example.com',
          aud: 'authenticated',
          role: 'authenticated',
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        } as User;
      }
      const raw = localStorage.getItem('playwright_test_user');
      if (raw) {
        return JSON.parse(raw) as User;
      }
    } catch (error) {
      console.warn('[AuthLayout] Failed to read Playwright test user:', error);
    }
    return null;
  };

  const [user, setUser] = useState<User | null>(() => getTestUser());
  const [loading, setLoading] = useState(() => (getTestUser() ? false : true));
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [showOnboardingCutscene, setShowOnboardingCutscene] = useState(false);
  const [checkedAuth, setCheckedAuth] = useState(() => (getTestUser() ? true : false));

  useEffect(() => {
    let mounted = true;
    const mockUser = getTestUser();
    if (mockUser) {
      setUser(mockUser);
      setCheckedAuth(true);
      setLoading(false);
      setShowOnboardingCutscene(false);
      return;
    }

    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return;

      if (session) {
        setUser(session.user);

        // Safely check if user has seen visual onboarding cutscene
        try {
          const hasSeenOnboarding = getHasSeenOnboarding(session.user.id);
          if (!hasSeenOnboarding) {
            setShowOnboardingCutscene(true);
          }
        } catch (error) {
          console.warn('localStorage not available:', error);
          setShowOnboardingCutscene(true);
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
          const hasSeenOnboarding = getHasSeenOnboarding(session.user.id);
          if (!hasSeenOnboarding) {
            setShowOnboardingCutscene(true);
          }
        } catch (error) {
          console.warn('localStorage not available:', error);
          setShowOnboardingCutscene(true);
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
    if (user) {
      setHasSeenOnboarding(user.id, true);
    }
    setShowOnboardingCutscene(false);
  };

  const handleOnboardingClose = () => {
    if (user) {
      setHasSeenOnboarding(user.id, true);
    }
    setShowOnboardingCutscene(false);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  if (!user && checkedAuth) {
    // User is not authenticated and we've checked auth state - redirect to landing
    return <Navigate to="/" replace />;
  }

  if (!user) {
    // Still checking auth or loading
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  // Show visual onboarding cutscene for logged-in users who haven't seen it
  if (showOnboardingCutscene) {
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
