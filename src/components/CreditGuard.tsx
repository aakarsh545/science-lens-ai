import { useEffect, useState, useCallback } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate } from "react-router-dom";
import { AlertCircle, Zap, Crown } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

interface CreditGuardProps {
  userId: string;
  children: React.ReactNode;
  onCreditsLow?: () => void;
}

export default function CreditGuard({ userId, children, onCreditsLow }: CreditGuardProps) {
  const [credits, setCredits] = useState<number | null>(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const loadCredits = useCallback(async () => {
    try {
      // SERVER-SIDE admin verification using has_role RPC
      const { data: adminCheck } = await supabase.rpc('has_role', {
        _user_id: userId,
        _role: 'admin' as const
      });

      const isUserAdmin = adminCheck || false;
      setIsAdmin(isUserAdmin);

      // Skip credit check for admin users (verified server-side)
      if (isUserAdmin) {
        setLoading(false);
        return;
      }

      // Load user stats for non-admin users
      const { data } = await supabase
        .from("user_stats")
        .select("credits")
        .eq("user_id", userId)
        .single();

      if (data) {
        setCredits(data.credits);

        // Refresh daily credits for non-admin users
        await supabase.rpc('refresh_daily_credits', { p_user_id: userId });

        // Reload credits after refresh
        const { data: refreshedData } = await supabase
          .from("user_stats")
          .select("credits")
          .eq("user_id", userId)
          .single();

        if (refreshedData) {
          setCredits(refreshedData.credits);

          // Don't auto-redirect - let user choose via blocking UI
          if (refreshedData.credits <= 5 && onCreditsLow) {
            onCreditsLow();
          }
        }
      }
    } catch (error) {
      console.error('Error loading credits:', error);
    } finally {
      setLoading(false);
    }
  }, [userId, navigate, onCreditsLow]);

  useEffect(() => {
    loadCredits();

    // Subscribe to credit changes from user_stats
    const subscription = supabase
      .channel('credit-changes')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'user_stats',
          filter: `user_id=eq.${userId}`
        },
        async (payload) => {
          const newCredits = payload.new.credits;

          // SERVER-SIDE admin verification on every change
          const { data: adminCheck } = await supabase.rpc('has_role', {
            _user_id: userId,
            _role: 'admin' as const
          });

          const isUserAdmin = adminCheck || false;

          setCredits(newCredits);
          setIsAdmin(isUserAdmin);

          // Skip credit checks for admin users (verified server-side)
          if (isUserAdmin) return;

          // Don't auto-redirect - let user choose via blocking UI or warning
          if (newCredits <= 5 && onCreditsLow) {
            onCreditsLow();
          }
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [userId, navigate, onCreditsLow, loadCredits]);

  if (loading) {
    return <div className="flex items-center justify-center p-8">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
    </div>;
  }

  // Admin bypass - show admin badge and render children
  if (isAdmin) {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-center gap-2 py-2">
          <Badge variant="default" className="bg-gradient-to-r from-yellow-500 to-orange-500 text-white border-0">
            <Crown className="w-3 h-3 mr-1" />
            Admin Mode - All Restrictions Bypassed
          </Badge>
        </div>
        {children}
      </div>
    );
  }

  // If credits is 0, show blocking UI and redirect
  if (credits === null || credits === 0) {
    return (
      <div className="p-6 max-w-2xl mx-auto">
        <Card className="border-destructive">
          <CardContent className="pt-6">
            <div className="text-center space-y-4">
              <div className="flex justify-center">
                <AlertCircle className="w-16 h-16 text-destructive animate-pulse" />
              </div>

              <h2 className="text-2xl font-bold">Out of Learning Credits</h2>

              <p className="text-muted-foreground">
                You've run out of learning credits. Get more credits to continue asking questions.
                You'll receive 5 free credits daily!
              </p>

              <div className="flex flex-col sm:flex-row gap-3 justify-center pt-4">
                <Button
                  onClick={() => navigate("/pricing")}
                  className="flex items-center gap-2"
                >
                  <Zap className="w-4 h-4" />
                  Get Credits Now
                </Button>
                <Button
                  variant="outline"
                  onClick={() => navigate("/")}
                >
                  Go to Dashboard
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  // Show warning for low credits
  if (credits <= 3) {
    return (
      <div className="space-y-4">
        <Alert variant={credits <= 1 ? "destructive" : "default"}>
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Low Credits Warning</AlertTitle>
          <AlertDescription className="flex items-center justify-between">
            <span>You only have {credits} credit{credits !== 1 ? 's' : ''} remaining. Get more to keep learning!</span>
            <Button
              variant="outline"
              size="sm"
              onClick={() => navigate("/pricing")}
            >
              Get More
            </Button>
          </AlertDescription>
        </Alert>
        {children}
      </div>
    );
  }

  return <div>{children}</div>;
}
