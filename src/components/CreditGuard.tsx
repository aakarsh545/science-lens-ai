import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate } from "react-router-dom";
import { AlertCircle, Zap } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";

interface CreditGuardProps {
  userId: string;
  children: React.ReactNode;
  onCreditsLow?: () => void;
}

export default function CreditGuard({ userId, children, onCreditsLow }: CreditGuardProps) {
  const [credits, setCredits] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

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
        (payload) => {
          const newCredits = payload.new.credits;
          setCredits(newCredits);
          
          // Auto-redirect to pricing if credits hit 0
          if (newCredits === 0) {
            navigate('/science-lens/pricing');
          } else if (newCredits <= 5 && onCreditsLow) {
            onCreditsLow();
          }
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [userId, navigate]);

  const loadCredits = async () => {
    try {
      // Refresh daily credits first
      await supabase.rpc('refresh_daily_credits', { p_user_id: userId });
      
      // Then load current credits
      const { data } = await supabase
        .from("user_stats")
        .select("credits")
        .eq("user_id", userId)
        .single();

      if (data) {
        setCredits(data.credits);
        
        // Redirect immediately if no credits
        if (data.credits === 0) {
          navigate('/science-lens/pricing');
        } else if (data.credits <= 5 && onCreditsLow) {
          onCreditsLow();
        }
      }
    } catch (error) {
      console.error('Error loading credits:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div className="flex items-center justify-center p-8">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
    </div>;
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
                  onClick={() => navigate("/science-lens/pricing")}
                  className="flex items-center gap-2"
                >
                  <Zap className="w-4 h-4" />
                  Get Credits Now
                </Button>
                <Button 
                  variant="outline"
                  onClick={() => navigate("/science-lens")}
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
              onClick={() => navigate("/science-lens/pricing")}
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
