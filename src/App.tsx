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

  return (
    <>
      <Toaster />
      <Sonner />
      <DebugPanel enabled={debugMode} onClose={() => {}} />
      <BrowserRouter basename={basename}>
        <Routes>
          {/* Public landing page - always accessible */}
          <Route path="/" element={<Index />} />
          <Route path="/signup" element={<SignupPage />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/auth/callback" element={<AuthCallback />} />

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
