import { Navigate, Outlet } from "react-router-dom";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Loader2 } from "lucide-react";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { OnboardingCutscene } from "@/components/OnboardingCutscene";

export default function CourseLayout() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [showOnboardingCutscene, setShowOnboardingCutscene] = useState(false);
  const [checkedAuth, setCheckedAuth] = useState(false);

  useEffect(() => {
    let mounted = true;

    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return;

      if (session) {
        setUser(session.user);

        // Safely check if user has seen visual onboarding cutscene
        try {
          const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
          if (!hasSeenOnboarding) {
            setShowOnboardingCutscene(true);
          }
        } catch (error) {
          console.warn('localStorage not available:', error);
        }
      }
      setCheckedAuth(true);
      setLoading(false);
    });

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (!mounted) return;

      if (event === 'SIGNED_OUT') {
        setUser(null);
        setCheckedAuth(true);
        setLoading(false);
        return;
      }

      if (session) {
        setUser(session.user);
        // Safely check if user has seen onboarding
        try {
          const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
          if (!hasSeenOnboarding) {
            setShowOnboardingCutscene(true);
          }
        } catch (error) {
          console.warn('localStorage not available:', error);
        }
        setLoading(false);
      }
      setCheckedAuth(true);
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  const handleOnboardingComplete = () => {
    try {
      localStorage.setItem('hasSeenOnboarding', 'true');
    } catch (error) {
      console.warn('localStorage not available:', error);
    }
    setShowOnboardingCutscene(false);
  };

  const handleOnboardingClose = () => {
    try {
      localStorage.setItem('hasSeenOnboarding', 'true');
    } catch (error) {
      console.warn('localStorage not available:', error);
    }
    setShowOnboardingCutscene(false);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!user && checkedAuth) {
    // User is not authenticated - redirect to landing
    return <Navigate to="/" replace />;
  }

  if (!user) {
    // Still checking auth or loading
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
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

  // Full-width layout without sidebar
  return (
    <ThemeProvider userId={user.id}>
      <Outlet />
    </ThemeProvider>
  );
}
