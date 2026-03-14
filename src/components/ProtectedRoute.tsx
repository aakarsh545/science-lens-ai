import { ReactNode } from "react";
import { Navigate } from "react-router-dom";
import type { Session } from "@supabase/supabase-js";
import { HelixLoader } from "@/components/ui/helix-loader";

type Props = {
  loading: boolean;
  session: Session | null;
  username: string | null;
  children: ReactNode;
};

export default function ProtectedRoute({ loading, session, username, children }: Props) {
  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  if (!session) return <Navigate to="/" replace />;

  // Logged in but mid-onboarding (no username yet): force onboarding completion.
  if (!username || !username.trim()) return <Navigate to="/signup?step=5" replace />;

  return <>{children}</>;
}

