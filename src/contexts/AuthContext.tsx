import { createContext, useContext, useEffect, useRef, useState } from "react";
import type { ReactNode } from "react";
import type { Session, User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";

type AuthContextValue = {
  session: Session | null;
  loading: boolean;
  hasUsername: boolean;
};

const AuthContext = createContext<AuthContextValue>({
  session: null,
  loading: true,
  hasUsername: false,
});

function getPlaywrightTestUser(): User | null {
  try {
    const params = new URLSearchParams(window.location.search);
    const forcePlaywright = params.has("playwright");
    if (forcePlaywright) {
      return {
        id: "00000000-0000-0000-0000-000000000000",
        email: "test@example.com",
        aud: "authenticated",
        role: "authenticated",
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      } as unknown as User;
    }

    const raw = localStorage.getItem("playwright_test_user");
    if (raw) return JSON.parse(raw) as User;
  } catch {
    // Ignore and fall back to real auth.
  }
  return null;
}

function clearThemeVarsOnSignOut() {
  // Clear only theme system variables (prefixed with --color-).
  const root = document.documentElement;
  const themeVars = [
    "--color-primary", "--color-secondary", "--color-accent", "--color-surface", "--color-background",
    "--color-text-primary", "--color-text-secondary", "--color-text-muted",
    "--color-primary-hover", "--color-accent-hover",
    "--color-border", "--color-border-subtle",
    "--color-card", "--color-card-hover", "--color-popover", "--color-muted", "--color-input",
    "--glow-primary", "--glow-accent",
    "--gradient-primary", "--gradient-surface",
    "--decoration-type", "--particle-intensity", "--animation-speed", "--bg-decoration",
  ];
  themeVars.forEach((varName) => root.style.removeProperty(varName));
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);
  const [hasUsername, setHasUsername] = useState(false);

  const settledRef = useRef(false);

  useEffect(() => {
    const mockUser = getPlaywrightTestUser();
    if (mockUser) {
      setSession({ user: mockUser } as unknown as Session);
      setHasUsername(true);
      setLoading(false);
      settledRef.current = true;
      return;
    }

    let mounted = true;
    const timeout = setTimeout(() => {
      if (!mounted || settledRef.current) return;
      setSession(null);
      setHasUsername(false);
      setLoading(false);
      settledRef.current = true;
    }, 5000);

    const loadHasUsername = async (s: Session | null) => {
      if (!s?.user) {
        setHasUsername(false);
        return;
      }

      const { data } = await supabase
        .from("profiles")
        .select("username")
        .eq("user_id", s.user.id)
        .maybeSingle();

      setHasUsername(!!data?.username && !!String(data.username).trim());
    };

    // Subscribe first so we don't miss any auth event between subscription and getSession().
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, nextSession) => {
      if (!mounted) return;

      setSession(nextSession ?? null);

      try {
        await loadHasUsername(nextSession ?? null);
      } catch {
        setHasUsername(false);
      } finally {
        if (!mounted) return;
        if (event === "SIGNED_OUT") clearThemeVarsOnSignOut();
        setLoading(false);
        settledRef.current = true;
      }
    });

    (async () => {
      try {
        const { data: { session } } = await supabase.auth.getSession();
        if (!mounted) return;

        setSession(session ?? null);
        await loadHasUsername(session ?? null);
      } catch (e) {
        console.error("Session check failed:", e);
        if (!mounted) return;
        setSession(null);
        setHasUsername(false);
      } finally {
        if (!mounted) return;
        setLoading(false);
        settledRef.current = true;
      }
    })();

    return () => {
      mounted = false;
      clearTimeout(timeout);
      subscription.unsubscribe();
    };
  }, []);

  return (
    <AuthContext.Provider value={{ session, loading, hasUsername }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}
