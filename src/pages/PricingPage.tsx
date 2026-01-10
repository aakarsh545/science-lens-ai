import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Crown, Zap, Coins, Sparkles, Check, Star, ArrowLeft } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

interface UserProfile {
  coins: number;
  is_premium: boolean;
  active_xp_boost: number;
}

export default function PricingPage() {
  const navigate = useNavigate();
  const { toast } = useToast();
  const [user, setUser] = useState<User | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);

  useEffect(() => {
    checkAuth();
  }, []);

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
      .select('coins, is_premium, active_xp_boost')
      .eq('user_id', userId)
      .single();

    if (profileData) {
      setUserProfile(profileData);
    }
  };

  const handlePurchase = (type: 'premium' | 'coins' | 'xp_boost', amount: number, description: string) => {
    // Navigate to billing page with purchase details
    navigate('/billing', {
      state: {
        purchase: { type, amount, description }
      }
    });
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-background to-primary/5 p-6">
      <div className="max-w-7xl mx-auto space-y-8">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <Button variant="ghost" onClick={() => navigate('/')} className="mb-4">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Dashboard
            </Button>
            <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-500 bg-clip-text text-transparent">
              Pricing
            </h1>
            <p className="text-muted-foreground mt-2">
              Get premium, buy coins, or boost your XP!
            </p>
          </div>

          {userProfile && (
            <Card className="bg-gradient-to-br from-amber-500/10 to-yellow-500/10 border-amber-500/30">
              <CardContent className="p-4 flex items-center gap-3">
                <Coins className="w-6 h-6 text-amber-500" />
                <div>
                  <p className="text-sm text-muted-foreground">Your Balance</p>
                  <p className="text-2xl font-bold text-amber-600 dark:text-amber-400">
                    {userProfile.coins.toLocaleString()} Coins
                  </p>
                </div>
              </CardContent>
            </Card>
          )}
        </div>

        <Tabs defaultValue="premium" className="w-full">
          <TabsList className="grid w-full max-w-md mx-auto grid-cols-3">
            <TabsTrigger value="premium" className="gap-2">
              <Crown className="w-4 h-4" />
              Premium
            </TabsTrigger>
            <TabsTrigger value="coins" className="gap-2">
              <Coins className="w-4 h-4" />
              Buy Coins
            </TabsTrigger>
            <TabsTrigger value="boosts" className="gap-2">
              <Zap className="w-4 h-4" />
              XP Boosts
            </TabsTrigger>
          </TabsList>

          {/* Premium Tab */}
          <TabsContent value="premium" className="mt-8">
            <div className="grid md:grid-cols-2 gap-6">
              <Card className="border-2 border-primary bg-gradient-to-br from-primary/10 to-purple-500/10">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-3 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full">
                        <Crown className="w-8 h-8 text-white" />
                      </div>
                      <div>
                        <CardTitle className="text-2xl">Premium</CardTitle>
                        <CardDescription>Unlock all premium features</CardDescription>
                      </div>
                    </div>
                    {userProfile?.is_premium && (
                      <Badge className="bg-green-500">Active</Badge>
                    )}
                  </div>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="space-y-3">
                    <div className="flex items-center gap-2">
                      <Check className="w-5 h-5 text-green-500" />
                      <span>2x coins on all activities</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Check className="w-5 h-5 text-green-500" />
                      <span>Access to premium-exclusive items</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Check className="w-5 h-5 text-green-500" />
                      <span>Priority support</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Check className="w-5 h-5 text-green-500" />
                      <span>Special badges and themes</span>
                    </div>
                  </div>

                  <div className="pt-4 border-t">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-3xl font-bold">$9.99</p>
                        <p className="text-sm text-muted-foreground">per month</p>
                      </div>
                      <Button
                        size="lg"
                        className="bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600"
                        onClick={() => handlePurchase('premium', 9.99, 'Premium Membership - Monthly')}
                        disabled={userProfile?.is_premium}
                      >
                        {userProfile?.is_premium ? 'Already Premium' : 'Get Premium'}
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Premium Benefits Visual */}
              <Card className="bg-gradient-to-br from-purple-500/10 to-pink-500/10">
                <CardHeader>
                  <CardTitle>Premium Benefits</CardTitle>
                  <CardDescription>What you get with Premium</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex items-start gap-3">
                      <Star className="w-5 h-5 text-yellow-500 mt-1" />
                      <div>
                        <p className="font-semibold">Earn 2x Coins</p>
                        <p className="text-sm text-muted-foreground">
                          All activities give double coins
                        </p>
                      </div>
                    </div>
                    <div className="flex items-start gap-3">
                      <Sparkles className="w-5 h-5 text-purple-500 mt-1" />
                      <div>
                        <p className="font-semibold">Exclusive Items</p>
                        <p className="text-sm text-muted-foreground">
                          Access to premium-only shop items
                        </p>
                      </div>
                    </div>
                    <div className="flex items-start gap-3">
                      <Crown className="w-5 h-5 text-orange-500 mt-1" />
                      <div>
                        <p className="font-semibold">Priority Access</p>
                        <p className="text-sm text-muted-foreground">
                          Get early access to new features
                        </p>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Coins Tab */}
          <TabsContent value="coins" className="mt-8">
            <div className="grid md:grid-cols-3 gap-6">
              {[
                { amount: 500, bonus: 0, price: 4.99, popular: false },
                { amount: 1200, bonus: 200, price: 9.99, popular: true },
                { amount: 2500, bonus: 500, price: 19.99, popular: false },
                { amount: 6500, bonus: 1500, price: 49.99, popular: false },
                { amount: 14000, bonus: 4000, price: 99.99, popular: false },
              ].map((pack) => (
                <Card key={pack.amount} className={`relative ${pack.popular ? 'border-2 border-primary' : ''}`}>
                  {pack.popular && (
                    <Badge className="absolute -top-2 left-1/2 -translate-x-1/2 bg-gradient-to-r from-primary to-purple-500">
                      Most Popular
                    </Badge>
                  )}
                  <CardHeader>
                    <CardTitle>Coins Pack</CardTitle>
                    <CardDescription>
                      {pack.amount.toLocaleString()} Coins
                      {pack.bonus > 0 && (
                        <span className="text-green-600 dark:text-green-400"> +{pack.bonus.toLocaleString()} Bonus</span>
                      )}
                    </CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex items-center justify-center py-6">
                      <Coins className="w-16 h-16 text-amber-500" />
                      <div className="ml-4">
                        <p className="text-4xl font-bold">{(pack.amount + pack.bonus).toLocaleString()}</p>
                        <p className="text-sm text-muted-foreground">Total Coins</p>
                      </div>
                    </div>
                    <div className="text-center">
                      <p className="text-2xl font-bold">${pack.price}</p>
                    </div>
                    <Button
                      className="w-full bg-gradient-to-r from-amber-500 to-yellow-500 hover:from-amber-600 hover:to-yellow-600"
                      onClick={() => handlePurchase('coins', pack.price, `${(pack.amount + pack.bonus).toLocaleString()} Coins Pack`)}
                    >
                      Purchase
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>

          {/* XP Boosts Tab */}
          <TabsContent value="boosts" className="mt-8">
            <div className="grid md:grid-cols-3 gap-6">
              {[
                { multiplier: 2, duration: '15 minutes', durationMinutes: 15, price: 2.99, popular: false },
                { multiplier: 2, duration: '1 hour', durationMinutes: 60, price: 4.99, popular: true },
                { multiplier: 3, duration: '1 hour', durationMinutes: 60, price: 9.99, popular: false },
                { multiplier: 2, duration: '6 hours', durationMinutes: 360, price: 19.99, popular: false },
                { multiplier: 3, duration: '6 hours', durationMinutes: 360, price: 39.99, popular: false },
              ].map((boost) => (
                <Card key={`${boost.multiplier}x-${boost.duration}`} className={`relative ${boost.popular ? 'border-2 border-primary' : ''}`}>
                  {boost.popular && (
                    <Badge className="absolute -top-2 left-1/2 -translate-x-1/2 bg-gradient-to-r from-primary to-purple-500">
                      Best Value
                    </Badge>
                  )}
                  <CardHeader>
                    <CardTitle>XP Boost</CardTitle>
                    <CardDescription>{boost.multiplier}x XP for {boost.duration}</CardDescription>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="flex items-center justify-center py-6">
                      <Zap className="w-16 h-16 text-purple-500" />
                      <div className="ml-4">
                        <p className="text-4xl font-bold">{boost.multiplier}x</p>
                        <p className="text-sm text-muted-foreground">XP Multiplier</p>
                      </div>
                    </div>
                    <div className="text-center">
                      <p className="text-2xl font-bold">${boost.price}</p>
                    </div>
                    <Button
                      className="w-full bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600"
                      onClick={() => handlePurchase('xp_boost', boost.price, `${boost.multiplier}x XP Boost - ${boost.duration}`)}
                    >
                      Activate Boost
                    </Button>
                  </CardContent>
                </Card>
              ))}
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
