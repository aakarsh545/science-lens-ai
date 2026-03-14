import { Navigate, Outlet } from "react-router-dom";
import { SidebarProvider } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { HelixLoader } from "@/components/ui/helix-loader";
import { ThemeProvider } from "@/contexts/ThemeContext";
import { useAuth } from "@/contexts/AuthContext";
import { useState } from "react";

export default function AuthenticatedLayout() {
  const { session, loading } = useAuth();
  const user = session?.user ?? null;
  const [conversationId, setConversationId] = useState<string | null>(null);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/" replace />;
  }

  return (
    <ThemeProvider>
      <SidebarProvider>
        <div className="min-h-screen flex w-full">
          <AppSidebar
            userId={user.id}
            conversationId={conversationId}
            onSelectConversation={setConversationId}
            onNewConversation={() => setConversationId(null)}
          />
          <div className="flex-1 flex flex-col">
            <main className="flex-1 overflow-auto">
              <Outlet />
            </main>
          </div>
        </div>
      </SidebarProvider>
    </ThemeProvider>
  );
}
