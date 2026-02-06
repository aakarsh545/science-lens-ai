import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";

export interface AdminStatus {
  isAdmin: boolean;
  adminPurchasedAt: string | null;
  loading: boolean;
}

export function useAdmin(user: User | null): AdminStatus {
  const [adminStatus, setAdminStatus] = useState<AdminStatus>({
    isAdmin: false,
    adminPurchasedAt: null,
    loading: true,
  });

  useEffect(() => {
    if (!user) {
      setAdminStatus({
        isAdmin: false,
        adminPurchasedAt: null,
        loading: false,
      });
      return;
    }

    const checkAdminStatus = async () => {
      try {
        // Use the proper has_role RPC for server-side admin check
        const { data, error } = await supabase.rpc('has_role', {
          _user_id: user.id,
          _role: 'admin' as const
        });

        if (error) {
          console.error("Error checking admin status:", error);
          setAdminStatus({
            isAdmin: false,
            adminPurchasedAt: null,
            loading: false,
          });
          return;
        }

        setAdminStatus({
          isAdmin: data === true,
          adminPurchasedAt: null,
          loading: false,
        });
      } catch (err) {
        console.error("Error checking admin status:", err);
        setAdminStatus({
          isAdmin: false,
          adminPurchasedAt: null,
          loading: false,
        });
      }
    };

    checkAdminStatus();

    // Subscribe to changes in user_roles
    const subscription = supabase
      .channel('admin-status-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'user_roles',
          filter: `user_id=eq.${user.id}`
        },
        () => {
          // Re-check admin status when roles change
          checkAdminStatus();
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user]);

  return adminStatus;
}
