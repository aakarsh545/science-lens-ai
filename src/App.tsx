import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { DebugProvider, useDebug } from "@/contexts/DebugContext";
import { DebugErrorBoundary } from "@/components/debug/DebugErrorBoundary";
import { DebugPanel } from "@/components/debug/DebugPanel";
import { useDebugClickLogger } from "@/hooks/useDebugClickLogger";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import SignupPage from "./pages/SignupPage";
import AuthenticatedLayout from "./layouts/AuthenticatedLayout";
import CourseLayout from "./layouts/CourseLayout";
import AchievementsPage from "./pages/AchievementsPage";
import SettingsPage from "./pages/SettingsPage";
import AccountInformationPage from "./pages/AccountInformationPage";
import AskPage from "./pages/AskPage";
import LessonPlayer from "./pages/LessonPlayer";
import DashboardMainPage from "./pages/DashboardMainPage";
import UnifiedLearningPage from "./pages/UnifiedLearningPage";
import CoursePage from "./pages/CoursePage";
import ChallengesPage from "./pages/ChallengesPage";
import ChallengeSession from "./pages/ChallengeSession";
import ProfilePage from "./pages/ProfilePage";
import LeaderboardPage from "./pages/LeaderboardPage";

const queryClient = new QueryClient();

// Use basename from environment variable for production deployment
// Locally this will be undefined, in production it will be "/" (root)
const basename = import.meta.env.VITE_BASEPATH?.replace(/\/$/, '') || '/';

function AppContent() {
  const { debugMode } = useDebug();
  useDebugClickLogger();

  return (
    <>
      <Toaster />
      <Sonner />
      <DebugPanel enabled={debugMode} onClose={() => {}} />
      <BrowserRouter basename={basename} future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
        <Routes>
          {/* Public landing page - always accessible */}
          <Route path="/" element={<Index />} />
          <Route path="/signup" element={<SignupPage />} />

          {/* Authenticated app routes - all under AuthenticatedLayout */}
          <Route path="/dashboard" element={<AuthenticatedLayout />}>
            <Route index element={<DashboardMainPage />} />
          </Route>
          <Route path="learning" element={<AuthenticatedLayout />}>
            <Route index element={<UnifiedLearningPage />} />
          </Route>
          <Route path="learning/:courseSlug" element={<CourseLayout />}>
            <Route index element={<CoursePage />} />
          </Route>
          <Route path="learning/:courseSlug/:lessonSlug" element={<AuthenticatedLayout />}>
            <Route index element={<LessonPlayer />} />
          </Route>
          <Route path="challenges" element={<AuthenticatedLayout />}>
            <Route index element={<ChallengesPage />} />
          </Route>
          <Route path="challenges/session/:sessionId" element={<AuthenticatedLayout />}>
            <Route index element={<ChallengeSession />} />
          </Route>
          <Route path="leaderboard" element={<AuthenticatedLayout />}>
            <Route index element={<LeaderboardPage />} />
          </Route>
          <Route path="ask" element={<AuthenticatedLayout />}>
            <Route index element={<AskPage />} />
          </Route>
          <Route path="achievements" element={<AuthenticatedLayout />}>
            <Route index element={<AchievementsPage />} />
          </Route>
          <Route path="profile" element={<AuthenticatedLayout />}>
            <Route index element={<ProfilePage />} />
          </Route>
          <Route path="settings" element={<AuthenticatedLayout />}>
            <Route index element={<SettingsPage />} />
          </Route>
          <Route path="settings/account" element={<AuthenticatedLayout />}>
            <Route index element={<AccountInformationPage />} />
          </Route>
          {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
          <Route path="*" element={<NotFound />} />
        </Routes>
      </BrowserRouter>
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
