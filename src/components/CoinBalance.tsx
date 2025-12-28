import { useEffect, useState, useCallback } from "react";
import { Coins } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { motion, AnimatePresence } from "framer-motion";

interface CoinBalanceProps {
  userId: string;
}

export function CoinBalance({ userId }: CoinBalanceProps) {
  const [coins, setCoins] = useState<number>(0);
  const [loading, setLoading] = useState(true);

  const loadCoins = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('coins')
        .eq('user_id', userId)
        .single();

      if (!error && data) {
        setCoins(data.coins || 0);
      }
    } catch (error) {
      console.error('Error loading coins:', error);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useEffect(() => {
    loadCoins();

    // Subscribe to real-time updates
    const channel = supabase
      .channel('profile_coins_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'profiles',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          if (payload.new && typeof payload.new === 'object') {
            const newData = payload.new as { coins?: number };
            setCoins(newData.coins || 0);
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [userId, loadCoins]);

  return (
    <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-gradient-to-r from-amber-500/10 to-yellow-500/10 border border-amber-500/30">
      <Coins className="h-4 w-4 text-amber-500" />
      <AnimatePresence mode="wait">
        <motion.span
          key={coins}
          initial={{ scale: 1.5, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          exit={{ scale: 0.5, opacity: 0 }}
          transition={{ duration: 0.2 }}
          className="text-sm font-semibold text-amber-600 dark:text-amber-400"
        >
          {loading ? '...' : coins}
        </motion.span>
      </AnimatePresence>
      <span className="text-xs text-muted-foreground">Coins</span>
    </div>
  );
}
