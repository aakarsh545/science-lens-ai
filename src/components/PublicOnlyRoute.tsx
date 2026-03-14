import { ReactNode } from "react";
import { Navigate } from "react-router-dom";
import { HelixLoader } from "@/components/ui/helix-loader";
import { useAuth } from "@/contexts/AuthContext";

type Props = {
  children: ReactNode;
};

export default function PublicOnlyRoute({ children }: Props) {
  const { session, loading, hasUsername } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  if (session && hasUsername) return <Navigate to="/dashboard" replace />;

  return <>{children}</>;
}

