import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ThemeProvider } from "next-themes";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import AppLayout from "./layouts/AppLayout";
import AuthenticatedLayout from "./layouts/AuthenticatedLayout";
import TestPage from "./pages/TestPage";
import AchievementsPage from "./pages/AchievementsPage";
import SettingsPage from "./pages/SettingsPage";
import AskPage from "./pages/AskPage";
import TopicsPage from "./pages/TopicsPage";
import PricingPage from "./pages/PricingPage";
import LessonPlayer from "./pages/LessonPlayer";
import DashboardMainPage from "./pages/DashboardMainPage";
import SimulationsPage from "./pages/SimulationsPage";
import UnifiedLearningPage from "./pages/UnifiedLearningPage";
import CoursePage from "./pages/CoursePage";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <ThemeProvider attribute="class" defaultTheme="dark">
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Index />} />
            <Route path="/science-lens" element={<AuthenticatedLayout />}>
              <Route index element={<DashboardMainPage />} />
              <Route path="learning" element={<UnifiedLearningPage />} />
              <Route path="learn/:courseSlug" element={<CoursePage />} />
              <Route path="learn/:courseSlug/:lessonSlug" element={<LessonPlayer />} />
              <Route path="ask" element={<AskPage />} />
              <Route path="topics" element={<TopicsPage />} />
              <Route path="api-test" element={<TestPage />} />
              <Route path="pricing" element={<PricingPage />} />
              <Route path="achievements" element={<AchievementsPage />} />
              <Route path="simulations" element={<SimulationsPage />} />
              <Route path="settings" element={<SettingsPage />} />
            </Route>
            {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </ThemeProvider>
  </QueryClientProvider>
);

export default App;
