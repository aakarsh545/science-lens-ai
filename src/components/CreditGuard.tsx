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
    
    // Subscribe to credit changes
    const subscription = supabase
      .channel('credit-changes')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'profiles',
          filter: `user_id=eq.${userId}`
        },
        (payload) => {
          setCredits(payload.new.credits);
          if (payload.new.credits <= 5 && onCreditsLow) {
            onCreditsLow();
          }
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [userId]);

  const loadCredits = async () => {
    const { data } = await supabase
      .from("profiles")
      .select("credits")
      .eq("user_id", userId)
      .single();

    if (data) {
      setCredits(data.credits);
      if (data.credits <= 5 && onCreditsLow) {
        onCreditsLow();
      }
    }
    setLoading(false);
  };

  if (loading) {
    return <div>{children}</div>;
  }

  if (credits === null || credits === 0) {
    return (
      <div className="p-6 max-w-2xl mx-auto">
        <Card className="border-destructive">
          <CardContent className="pt-6">
            <div className="text-center space-y-4">
              <div className="flex justify-center">
                <AlertCircle className="w-16 h-16 text-destructive" />
              </div>
              
              <h2 className="text-2xl font-bold">Out of Learning Credits</h2>
              
              <p className="text-muted-foreground">
                You've run out of learning credits. Recharge to continue exploring science.
              </p>
              
              <div className="flex flex-col sm:flex-row gap-3 justify-center pt-4">
                <Button 
                  onClick={() => navigate("/pricing")}
                  className="flex items-center gap-2"
                >
                  <Zap className="w-4 h-4" />
                  Buy Credits
                </Button>
                <Button 
                  variant="outline"
                  onClick={() => navigate("/dashboard")}
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

  if (credits <= 5) {
    return (
      <div className="space-y-4">
        <Alert variant="destructive">
          <AlertCircle className="h-4 w-4" />
          <AlertTitle>Low Credits Warning</AlertTitle>
          <AlertDescription className="flex items-center justify-between">
            <span>You only have {credits} credits remaining.</span>
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
