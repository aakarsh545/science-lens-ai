import { Navigate, Outlet } from "react-router-dom";
import { HelixLoader } from "@/components/ui/helix-loader";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { useAuth } from "@/contexts/AuthContext";

export default function CourseLayout() {
  const { session, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  if (!session?.user) return <Navigate to="/" replace />;

  // Full-width layout without sidebar
  return (
    <ThemeProvider>
      <Outlet />
    </ThemeProvider>
  );
}
