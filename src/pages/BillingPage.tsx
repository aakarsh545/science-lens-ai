import { useState, useEffect } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Coins, Crown as CrownIcon, Zap } from "lucide-react";
import { DummyPaymentCard } from "@/components/DummyPaymentCard";
import { useToast } from "@/hooks/use-toast";
import { Badge } from "@/components/ui/badge";

interface UserProfile {
  credits: number;
}

interface PurchaseState {
  type: 'premium' | 'coins' | 'xp_boost' | 'admin_pass';
  amount: number;
  usdPrice?: number;
  description: string;
  duration?: number;
  multiplier?: number;
}

export default function BillingPage() {
  const navigate = useNavigate();
  const location = useLocation();
  const { toast } = useToast();
  const [user, setUser] = useState<User | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [purchase, setPurchase] = useState<PurchaseState | null>(null);

  useEffect(() => {
    checkAuth();
    if (location.state?.purchase) {
      setPurchase(location.state.purchase);
    } else {
      navigate('/pricing');
    }
  }, [location.state]);

  const checkAuth = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      navigate('/');
      return;
    }
    setUser(session.user);
    await loadUserProfile(session.user.id);
  };

  const loadUserProfile = async (userId: string) => {
    const { data: profileData } = await supabase
      .from('profiles')
      .select('credits')
      .eq('user_id', userId)
      .single();

    if (profileData) {
      setUserProfile(profileData);
    }
  };

  const handlePaymentSuccess = async () => {
    if (!user || !purchase) return;

    toast({
      title: "💳 Demo Payment Complete",
      description: "This was a demonstration. The payment system is not yet implemented. No items were granted.",
      variant: "default",
    });

    setTimeout(() => {
      navigate('/pricing');
    }, 3000);
  };

  if (!purchase) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-background to-primary/5 p-6 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Loading billing details...</p>
        </div>
      </div>
    );
  }

  const getIcon = () => {
    switch (purchase.type) {
      case 'premium':
        return <CrownIcon className="w-6 h-6 text-yellow-500" />;
      case 'coins':
        return <Coins className="w-6 h-6 text-amber-500" />;
      case 'xp_boost':
        return <Zap className="w-6 h-6 text-purple-500" />;
      case 'admin_pass':
        return <CrownIcon className="w-6 h-6 text-yellow-500" />;
    }
  };

  const getBadgeColor = () => {
    switch (purchase.type) {
      case 'premium':
        return 'bg-gradient-to-r from-yellow-500 to-orange-500';
      case 'coins':
        return 'bg-gradient-to-r from-amber-500 to-yellow-500';
      case 'xp_boost':
        return 'bg-gradient-to-r from-purple-500 to-pink-500';
      case 'admin_pass':
        return 'bg-gradient-to-r from-yellow-500 to-red-500';
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-background to-primary/5 p-6">
      <div className="max-w-4xl mx-auto pt-6">
        <div className="mb-6">
          <Button
            variant="ghost"
            onClick={() => {
              if (purchase.type === 'admin_pass' || purchase.type === 'coins' || purchase.type === 'xp_boost') {
                navigate('/shop');
              } else {
                navigate('/pricing');
              }
            }}
            className="mb-4"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            {purchase.type === 'admin_pass' || purchase.type === 'coins' || purchase.type === 'xp_boost'
              ? 'Back to Shop'
              : 'Back to Pricing'}
          </Button>

          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold">Checkout</h1>
              <p className="text-muted-foreground mt-1">
                Complete your purchase securely
              </p>
            </div>

            {userProfile && (
              <Card className="bg-gradient-to-br from-amber-500/10 to-yellow-500/10 border-amber-500/30">
                <div className="p-4 flex items-center gap-3">
                  <Coins className="w-5 h-5 text-amber-500" />
                  <div>
                    <p className="text-xs text-muted-foreground">Your Balance</p>
                    <p className="text-lg font-bold text-amber-600 dark:text-amber-400">
                      {userProfile.credits.toLocaleString()} Credits
                    </p>
                  </div>
                </div>
              </Card>
            )}
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          <Card className="p-6">
            <h2 className="text-xl font-semibold mb-4">Order Summary</h2>

            <div className="bg-gradient-to-br from-primary/10 to-purple-500/10 rounded-lg p-6 mb-6">
              <div className="flex items-start gap-4">
                <div className="p-3 bg-background rounded-full">
                  {getIcon()}
                </div>
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-1">
                    <Badge className={getBadgeColor()}>
                      {purchase.type === 'premium' && 'Premium'}
                      {purchase.type === 'coins' && 'Credits'}
                      {purchase.type === 'xp_boost' && 'XP Boost'}
                      {purchase.type === 'admin_pass' && 'Admin Pass'}
                    </Badge>
                  </div>
                  <h3 className="font-semibold text-lg">{purchase.description}</h3>
                </div>
              </div>
            </div>

            <div className="space-y-3 border-t pt-4">
              <div className="flex justify-between">
                <span className="text-muted-foreground">Subtotal</span>
                <span className="font-semibold">${(purchase.usdPrice || purchase.amount).toFixed(2)}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-muted-foreground">Tax</span>
                <span className="font-semibold">$0.00</span>
              </div>
              <div className="flex justify-between text-lg font-bold border-t pt-3">
                <span>Total</span>
                <span className="text-primary">${(purchase.usdPrice || purchase.amount).toFixed(2)}</span>
              </div>
            </div>
          </Card>

          <div>
            <DummyPaymentCard
              amount={purchase.usdPrice || purchase.amount}
              description={purchase.description}
              onSuccess={handlePaymentSuccess}
            />
          </div>
        </div>
      </div>
    </div>
  );
}
