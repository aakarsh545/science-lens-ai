import { useEffect, useState } from "react";
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { DebugProvider, useDebug } from "@/contexts/DebugContext";
import { DebugErrorBoundary } from "@/components/debug/DebugErrorBoundary";
import { DebugPanel } from "@/components/debug/DebugPanel";
import { useDebugClickLogger } from "@/hooks/useDebugClickLogger";
import { supabase } from "@/integrations/supabase/client";
import type { Session } from "@supabase/supabase-js";
import { HelixLoader } from "@/components/ui/helix-loader";
import ProtectedRoute from "@/components/ProtectedRoute";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import SignupPage from "./pages/SignupPage";
import LoginPage from "./pages/LoginPage";
import AuthCallback from "./pages/AuthCallback";
import AuthenticatedLayout from "./layouts/AuthenticatedLayout";
import CourseLayout from "./layouts/CourseLayout";
import SettingsPage from "./pages/SettingsPage";
import AccountInformationPage from "./pages/AccountInformationPage";
import LessonPlayer from "./pages/LessonPlayer";
import DashboardMainPage from "./pages/DashboardMainPage";
import UnifiedLearningPage from "./pages/UnifiedLearningPage";
import CoursePage from "./pages/CoursePage";
import ProfilePage from "./pages/ProfilePage";

const queryClient = new QueryClient();

// Use basename from environment variable for production deployment
// Locally this will be undefined, in production it will be "/" (root)
const basename = import.meta.env.VITE_BASEPATH?.replace(/\/$/, '') || '/';

function AppContent() {
  const { debugMode } = useDebug();
  useDebugClickLogger();

  const [authLoading, setAuthLoading] = useState(true);
  const [session, setSession] = useState<Session | null>(null);
  const [username, setUsername] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;
    let sessionFromEvent: Session | null | undefined = undefined;

    const loadUsername = async (userId: string) => {
      const { data: profile } = await supabase
        .from("profiles")
        .select("username")
        .eq("user_id", userId)
        .maybeSingle();
      return profile?.username ?? null;
    };

    // Subscribe first to avoid missing any auth event between subscription and getSession().
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (!mounted) return;

      sessionFromEvent = session ?? null;
      setSession(session ?? null);

      if (session?.user) {
        const nextUsername = await loadUsername(session.user.id);
        if (!mounted) return;
        setUsername(nextUsername);
      } else {
        setUsername(null);
      }
    });

    // Hydrate initial session. Do not mark loading false until this resolves.
    (async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (!mounted) return;

      const hydratedSession = session ?? null;

      // Avoid overwriting a non-null session from an auth event with null from getSession().
      const effectiveSession =
        sessionFromEvent && hydratedSession === null ? sessionFromEvent : hydratedSession;

      setSession(effectiveSession);

      if (effectiveSession?.user) {
        const nextUsername = await loadUsername(effectiveSession.user.id);
        if (!mounted) return;
        setUsername(nextUsername);
      } else {
        setUsername(null);
      }

      setAuthLoading(false);
    })();

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  const isFullyOnboarded = !!(session?.user && username && username.trim());

  return (
    <>
      <Toaster />
      <Sonner />
      <DebugPanel enabled={debugMode} onClose={() => {}} />
      {authLoading ? (
        <div className="min-h-screen flex items-center justify-center">
          <HelixLoader className="text-primary" />
        </div>
      ) : (
        <BrowserRouter basename={basename}>
          <Routes>
            {/* Public routes */}
            <Route path="/" element={isFullyOnboarded ? <Navigate to="/dashboard" replace /> : <Index />} />
            <Route path="/signup" element={isFullyOnboarded ? <Navigate to="/dashboard" replace /> : <SignupPage />} />
            <Route path="/login" element={isFullyOnboarded ? <Navigate to="/dashboard" replace /> : <LoginPage />} />
            <Route path="/auth/callback" element={<AuthCallback />} />

            {/* Protected routes */}
            <Route
              path="/dashboard"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<DashboardMainPage />} />
            </Route>
            <Route
              path="learning"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<UnifiedLearningPage />} />
            </Route>
            <Route
              path="learning/:courseSlug"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <CourseLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<CoursePage />} />
            </Route>
            <Route
              path="learning/:courseSlug/:lessonSlug"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<LessonPlayer />} />
            </Route>
            <Route
              path="profile"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<ProfilePage />} />
            </Route>
            <Route
              path="settings"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<SettingsPage />} />
            </Route>
            <Route
              path="settings/account"
              element={
                <ProtectedRoute loading={authLoading} session={session} username={username}>
                  <AuthenticatedLayout />
                </ProtectedRoute>
              }
            >
              <Route index element={<AccountInformationPage />} />
            </Route>

            {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      )}
    </>
  );
}

const App = () => {
  console.log('[APP] App component rendering');

  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <DebugProvider>
          <DebugErrorBoundary>
            <AppContent />
          </DebugErrorBoundary>
        </DebugProvider>
      </TooltipProvider>
    </QueryClientProvider>
  );
};

export default App;
