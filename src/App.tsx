import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import AppLayout from "./layouts/AppLayout";
import AuthenticatedLayout from "./layouts/AuthenticatedLayout";
import TestPage from "./pages/TestPage";
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
import ShopPage from "./pages/ShopPage";
import PricingPage from "./pages/PricingPage";
import BillingPage from "./pages/BillingPage";

const queryClient = new QueryClient();

const basename = '/';

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <ErrorBoundary>
        <BrowserRouter basename={basename}>
          <Routes>
            <Route path="/" element={<AuthenticatedLayout />}>
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
              <Route path="pricing" element={<PricingPage />} />
              <Route path="billing" element={<BillingPage />} />
              <Route path="achievements" element={<AchievementsPage />} />
              <Route path="profile" element={<ProfilePage />} />
              <Route path="settings" element={<SettingsPage />} />
              <Route path="settings/account" element={<AccountInformationPage />} />
            </Route>
            {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </ErrorBoundary>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
