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
  coins: number;
  is_premium: boolean;
  active_xp_boost: number;
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
    // Get purchase details from navigation state
    if (location.state?.purchase) {
      setPurchase(location.state.purchase);
    } else {
      // No purchase details, redirect back to pricing
      navigate('/science-lens/pricing');
    }
  }, [location.state]);

  const checkAuth = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      navigate('/science-lens');
      return;
    }
    setUser(session.user);
    await loadUserProfile(session.user.id);
  };

  const loadUserProfile = async (userId: string) => {
    const { data: profileData } = await supabase
      .from('profiles')
      .select('coins, is_premium, active_xp_boost, level')
      .eq('user_id', userId)
      .single();

    if (profileData) {
      setUserProfile(profileData);
    }
  };

  const handlePaymentSuccess = async () => {
    if (!user || !purchase) return;

    try {
      if (purchase.type === 'premium') {
        // Grant premium status
        const { error } = await supabase
          .from('profiles')
          .update({ is_premium: true })
          .eq('user_id', user.id);

        if (error) throw error;

        toast({
          title: "🎉 Premium Activated!",
          description: "You now have 2x coins on all activities!",
        });
      } else if (purchase.type === 'coins') {
        // Add coins
        const { error } = await supabase
          .from('profiles')
          .update({ coins: (userProfile?.coins || 0) + purchase.amount })
          .eq('user_id', user.id);

        if (error) throw error;

        toast({
          title: "💰 Coins Purchased!",
          description: `You received ${purchase.amount.toLocaleString()} coins!`,
        });
      } else if (purchase.type === 'xp_boost') {
        // Activate XP boost with duration from purchase
        const duration = purchase.duration || 60;
        const multiplier = purchase.multiplier || 2;
        const expiresAt = new Date(Date.now() + duration * 60 * 1000).toISOString();
        const { error } = await supabase
          .from('profiles')
          .update({
            active_xp_boost: multiplier,
            xp_boost_expires_at: expiresAt
          })
          .eq('user_id', user.id);

        if (error) throw error;

        toast({
          title: "⚡ XP Boost Activated!",
          description: `${multiplier}x XP for ${duration} minutes!`,
        });
      } else if (purchase.type === 'admin_pass') {
        // Grant admin status in user_stats
        const { error: adminError } = await supabase
          .from('user_stats')
          .update({
            is_admin: true,
            admin_purchased_at: new Date().toISOString(),
            xp_total: 100000, // Max XP
          })
          .eq('user_id', user.id);

        if (adminError) throw adminError;

        // Also update profiles table to set level, coins, and premium status
        const { error: profileError } = await supabase
          .from('profiles')
          .update({
            level: 1000, // Max level
            xp_points: 100000, // Max XP to match user_stats
            coins: 999999999, // Essentially infinite coins
            is_premium: true, // Also grant premium
          })
          .eq('user_id', user.id);

        if (profileError) throw profileError;

        toast({
          title: "👑 Admin Pass Activated!",
          description: "You now have unlimited power! Level 1000, infinite coins, all restrictions bypassed.",
        });
      }

      await loadUserProfile(user.id);

      // Redirect back after successful purchase
      setTimeout(() => {
        // If it's admin pass or from shop, go to shop, otherwise pricing
        if (purchase.type === 'admin_pass' || purchase.type === 'coins' || purchase.type === 'xp_boost') {
          navigate('/science-lens/shop');
        } else {
          navigate('/science-lens/pricing');
        }
      }, 1500);
    } catch (error) {
      console.error('Payment processing error:', error);
      toast({
        title: "Payment Failed",
        description: error instanceof Error ? error.message : "Failed to process payment",
        variant: "destructive",
      });
    }
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
        {/* Header */}
        <div className="mb-6">
          <Button
            variant="ghost"
            onClick={() => {
              if (purchase.type === 'admin_pass' || purchase.type === 'coins' || purchase.type === 'xp_boost') {
                navigate('/science-lens/shop');
              } else {
                navigate('/science-lens/pricing');
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
                      {userProfile.coins.toLocaleString()} Coins
                    </p>
                  </div>
                </div>
              </Card>
            )}
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          {/* Order Summary */}
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
                      {purchase.type === 'coins' && 'Coins'}
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

          {/* Payment Form */}
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
