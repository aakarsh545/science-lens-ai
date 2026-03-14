import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { DebugProvider, useDebug } from "@/contexts/DebugContext";
import { DebugErrorBoundary } from "@/components/debug/DebugErrorBoundary";
import { DebugPanel } from "@/components/debug/DebugPanel";
import { useDebugClickLogger } from "@/hooks/useDebugClickLogger";
import ProtectedRoute from "@/components/ProtectedRoute";
import PublicOnlyRoute from "@/components/PublicOnlyRoute";
import { AuthProvider } from "@/contexts/AuthContext";
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
          {/* Public routes (redirect away when already onboarded) */}
          <Route path="/" element={<PublicOnlyRoute><Index /></PublicOnlyRoute>} />
          <Route path="/signup" element={<PublicOnlyRoute><SignupPage /></PublicOnlyRoute>} />
          <Route path="/login" element={<PublicOnlyRoute><LoginPage /></PublicOnlyRoute>} />
          <Route path="/auth/callback" element={<AuthCallback />} />

          {/* Protected routes */}
          <Route path="/dashboard" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
            <Route index element={<DashboardMainPage />} />
          </Route>
          <Route path="learning" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
            <Route index element={<UnifiedLearningPage />} />
          </Route>
          <Route path="learning/:courseSlug" element={<ProtectedRoute><CourseLayout /></ProtectedRoute>}>
            <Route index element={<CoursePage />} />
          </Route>
          <Route path="learning/:courseSlug/:lessonSlug" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
            <Route index element={<LessonPlayer />} />
          </Route>
          <Route path="profile" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
            <Route index element={<ProfilePage />} />
          </Route>
          <Route path="settings" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
            <Route index element={<SettingsPage />} />
          </Route>
          <Route path="settings/account" element={<ProtectedRoute><AuthenticatedLayout /></ProtectedRoute>}>
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
            <AuthProvider>
              <AppContent />
            </AuthProvider>
          </DebugErrorBoundary>
        </DebugProvider>
      </TooltipProvider>
    </QueryClientProvider>
  );
};

export default App;
