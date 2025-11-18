import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Coins, Zap } from "lucide-react";
import { Button } from "./ui/button";
import { useNavigate } from "react-router-dom";
import { SidebarTrigger } from "./ui/sidebar";

interface CreditsBarProps {
  userId: string;
}

export function CreditsBar({ userId }: CreditsBarProps) {
  const [credits, setCredits] = useState<number>(0);
  const [xp, setXp] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    loadStats();

    // Subscribe to real-time updates
    const channel = supabase
      .channel('user_stats_changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'user_stats',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          if (payload.new && typeof payload.new === 'object') {
            const newData = payload.new as { credits?: number; xp_total?: number };
            setCredits(newData.credits ?? 0);
            setXp(newData.xp_total ?? 0);
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [userId]);

  const loadStats = async () => {
    const { data, error } = await supabase
      .from('user_stats')
      .select('credits, xp_total')
      .eq('user_id', userId)
      .single();

    if (!error && data) {
      setCredits(data.credits ?? 0);
      setXp(data.xp_total ?? 0);
    }
    setLoading(false);
  };

  return (
    <div className="h-14 border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 flex items-center justify-between px-4">
      <SidebarTrigger />
      
      <div className="flex items-center gap-4">
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-primary/10">
          <Zap className="h-4 w-4 text-primary" />
          <span className="text-sm font-medium">{xp} XP</span>
        </div>
        
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-accent">
          <Coins className="h-4 w-4 text-accent-foreground" />
          <span className="text-sm font-medium">{credits} Credits</span>
        </div>

        {credits < 3 && (
          <Button 
            size="sm" 
            variant="default"
            onClick={() => navigate('/pricing')}
          >
            Buy Credits
          </Button>
        )}
      </div>
    </div>
  );
}