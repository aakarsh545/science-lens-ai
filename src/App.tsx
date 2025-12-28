import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ThemeProvider } from "next-themes";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import AppLayout from "./layouts/AppLayout";
import AuthenticatedLayout from "./layouts/AuthenticatedLayout";
import TestPage from "./pages/TestPage";
import AchievementsPage from "./pages/AchievementsPage";
import SettingsPage from "./pages/SettingsPage";
import AskPage from "./pages/AskPage";
import LessonPlayer from "./pages/LessonPlayer";
import DashboardMainPage from "./pages/DashboardMainPage";
import UnifiedLearningPage from "./pages/UnifiedLearningPage";
import CoursePage from "./pages/CoursePage";
import ChallengesPage from "./pages/ChallengesPage";
import ChallengeSession from "./pages/ChallengeSession";
import ProfilePage from "./pages/ProfilePage";
import LeaderboardPage from "./pages/LeaderboardPage";
import ShopPage from "./pages/ShopPage";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <ThemeProvider attribute="class" defaultTheme="dark">
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <ErrorBoundary>
          <BrowserRouter>
            <Routes>
              <Route path="/" element={<Index />} />
              <Route path="/science-lens" element={<AuthenticatedLayout />}>
                <Route index element={<DashboardMainPage />} />
                <Route path="learning" element={<UnifiedLearningPage />} />
                <Route path="learning/:courseSlug" element={<CoursePage />} />
                <Route path="learning/:courseSlug/:lessonSlug" element={<LessonPlayer />} />
                <Route path="challenges" element={<ChallengesPage />} />
                <Route path="challenges/session/:sessionId" element={<ChallengeSession />} />
                <Route path="leaderboard" element={<LeaderboardPage />} />
                <Route path="ask" element={<AskPage />} />
                <Route path="api-test" element={<TestPage />} />
                <Route path="shop" element={<ShopPage />} />
                <Route path="achievements" element={<AchievementsPage />} />
                <Route path="profile" element={<ProfilePage />} />
                <Route path="settings" element={<SettingsPage />} />
              </Route>
              {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
              <Route path="*" element={<NotFound />} />
            </Routes>
          </BrowserRouter>
        </ErrorBoundary>
      </TooltipProvider>
    </ThemeProvider>
  </QueryClientProvider>
);

export default App;
