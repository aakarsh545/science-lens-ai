import { Navigate, Outlet } from "react-router-dom";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { HelixLoader } from "@/components/ui/helix-loader";
import { ThemeProvider } from "@/contexts/ThemeContext";

export default function CourseLayout() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [checkedAuth, setCheckedAuth] = useState(false);

  useEffect(() => {
    let mounted = true;

    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return;

      if (session) {
        setUser(session.user);
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
        setLoading(false);
      }
      setCheckedAuth(true);
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
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
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  // Full-width layout without sidebar
  return (
    <ThemeProvider userId={user.id}>
      <Outlet />
    </ThemeProvider>
  );
}
