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
  const subscriptionRef = useRef(null);

  useEffect(() => {
    let mounted = true

    // Step 1: get session first, THEN subscribe to changes
    supabase.auth.getSession().then(async ({ data: { session } }) => {
      if (!mounted) return
      setSession(session)

      if (session) {
        const { data } = await supabase
          .from('profiles')
          .select('username')
          .eq('user_id', session.user.id)
          .maybeSingle()
        if (mounted) setHasUsername(!!data?.username)
      }

      if (mounted) setLoading(false)

      // Step 2: ONLY subscribe to future changes AFTER initial session is set
      const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
        if (!mounted) return
        setSession(session)
        if (!session) {
          setHasUsername(false)
          setLoading(false)
        }
      })

      // Store subscription ref for cleanup
      subscriptionRef.current = subscription

    }).catch(() => {
      if (mounted) {
        setSession(null)
        setLoading(false)
      }
    })

    const timeout = setTimeout(() => {
      if (mounted) setLoading(false)
    }, 5000)

    return () => {
      mounted = false
      clearTimeout(timeout)
      subscriptionRef.current?.unsubscribe()
    }
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
