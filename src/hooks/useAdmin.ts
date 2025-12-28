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
        const { data, error } = await supabase
          .from("user_stats")
          .select("is_admin, admin_purchased_at")
          .eq("user_id", user.id)
          .single();

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
          isAdmin: data?.is_admin || false,
          adminPurchasedAt: data?.admin_purchased_at || null,
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

    // Subscribe to changes in user_stats
    const subscription = supabase
      .channel('admin-status-changes')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'user_stats',
          filter: `user_id=eq.${user.id}`
        },
        (payload) => {
          setAdminStatus({
            isAdmin: payload.new.is_admin || false,
            adminPurchasedAt: payload.new.admin_purchased_at || null,
            loading: false,
          });
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user]);

  return adminStatus;
}
