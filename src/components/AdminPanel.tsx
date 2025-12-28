import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { Crown, Shield, Infinity, Zap, Key } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { toast } from "@/components/ui/use-toast";

interface AdminPanelProps {
  user: User;
  isAdmin: boolean;
  onPurchaseSuccess?: () => void;
}

export function AdminPanel({ user, isAdmin, onPurchaseSuccess }: AdminPanelProps) {
  const [purchasing, setPurchasing] = useState(false);
  const [coins, setCoins] = useState<number>(0);
  const [hasPass, setHasPass] = useState(false);

  useEffect(() => {
    loadUserData();
  }, [user]);

  const loadUserData = async () => {
    // Load coins
    const { data: stats } = await supabase
      .from("user_stats")
      .select("credits")
      .eq("user_id", user.id)
      .single();

    if (stats) {
      setCoins(stats.credits);
    }

    // Check if already has admin pass
    const { data: inventory } = await supabase
      .from("user_inventory")
      .select("item_id")
      .eq("user_id", user.id)
      .in("item_id",
        (await supabase.from("shop_items").select("id").eq("type", "admin_pass").single()).data?.id
          ? [(await supabase.from("shop_items").select("id").eq("type", "admin_pass").single()).data!.id]
          : []
      );

    if (inventory && inventory.length > 0) {
      setHasPass(true);
    }
  };

  const purchaseAdminPass = async () => {
    if (coins < 10000) {
      toast({
        title: "Insufficient Coins",
        description: "You need 10,000 coins to purchase the Admin Pass.",
        variant: "destructive",
      });
      return;
    }

    setPurchasing(true);

    try {
      // Get admin pass item
      const { data: adminPass } = await supabase
        .from("shop_items")
        .select("id, price")
        .eq("type", "admin_pass")
        .single();

      if (!adminPass) {
        throw new Error("Admin Pass not found");
      }

      // Deduct coins
      const { error: deductError } = await supabase
        .from("user_stats")
        .update({ credits: coins - adminPass.price })
        .eq("user_id", user.id);

      if (deductError) throw deductError;

      // Add to inventory
      const { error: inventoryError } = await supabase
        .from("user_inventory")
        .insert({
          user_id: user.id,
          item_id: adminPass.id,
        });

      if (inventoryError) throw inventoryError;

      // Grant admin status
      const { error: adminError } = await supabase
        .from("user_stats")
        .update({
          is_admin: true,
          admin_purchased_at: new Date().toISOString(),
          xp_total: 100000, // Max XP
        })
        .eq("user_id", user.id);

      if (adminError) throw adminError;

      setHasPass(true);
      toast({
        title: "🎉 Admin Pass Activated!",
        description: "You now have unlimited power! All restrictions are bypassed.",
      });

      onPurchaseSuccess?.();
    } catch (error) {
      console.error("Error purchasing admin pass:", error);
      toast({
        title: "Purchase Failed",
        description: error instanceof Error ? error.message : "Failed to purchase Admin Pass",
        variant: "destructive",
      });
    } finally {
      setPurchasing(false);
    }
  };

  if (isAdmin) {
    return (
      <Card className="border-yellow-500 bg-gradient-to-br from-yellow-50 to-orange-50 dark:from-yellow-950/20 dark:to-orange-950/20">
        <CardHeader>
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="p-3 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-full">
                <Crown className="w-8 h-8 text-white" />
              </div>
              <div>
                <CardTitle className="text-2xl bg-gradient-to-r from-yellow-600 to-orange-600 bg-clip-text text-transparent">
                  Admin Mode Active
                </CardTitle>
                <CardDescription>You have unlimited power</CardDescription>
              </div>
            </div>
            <Badge variant="default" className="bg-gradient-to-r from-yellow-500 to-orange-500 text-white border-0">
              <Shield className="w-3 h-3 mr-1" />
              GOD MODE
            </Badge>
          </div>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="flex items-center gap-2 p-3 bg-white dark:bg-gray-800 rounded-lg">
              <Infinity className="w-5 h-5 text-purple-500" />
              <div>
                <p className="text-sm text-muted-foreground">Coins</p>
                <p className="font-bold text-lg">∞</p>
              </div>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white dark:bg-gray-800 rounded-lg">
              <Zap className="w-5 h-5 text-yellow-500" />
              <div>
                <p className="text-sm text-muted-foreground">Level</p>
                <p className="font-bold text-lg">1000</p>
              </div>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white dark:bg-gray-800 rounded-lg">
              <Key className="w-5 h-5 text-green-500" />
              <div>
                <p className="text-sm text-muted-foreground">Premium</p>
                <p className="font-bold text-lg">Unlocked</p>
              </div>
            </div>
            <div className="flex items-center gap-2 p-3 bg-white dark:bg-gray-800 rounded-lg">
              <Shield className="w-5 h-5 text-blue-500" />
              <div>
                <p className="text-sm text-muted-foreground">Restrictions</p>
                <p className="font-bold text-lg">None</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="border-2 border-dashed">
      <CardHeader>
        <div className="flex items-center gap-3">
          <div className="p-3 bg-gradient-to-br from-gray-400 to-gray-600 rounded-full">
            <Crown className="w-8 h-8 text-white" />
          </div>
          <div>
            <CardTitle>Admin Pass</CardTitle>
            <CardDescription>Unlock unlimited power</CardDescription>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div className="flex items-center gap-2">
              <Infinity className="w-4 h-4 text-purple-500" />
              <span className="text-sm">Infinite Coins</span>
            </div>
            <div className="flex items-center gap-2">
              <Zap className="w-4 h-4 text-yellow-500" />
              <span className="text-sm">Max Level (1000)</span>
            </div>
            <div className="flex items-center gap-2">
              <Key className="w-4 h-4 text-green-500" />
              <span className="text-sm">All Premium Features</span>
            </div>
            <div className="flex items-center gap-2">
              <Shield className="w-4 h-4 text-blue-500" />
              <span className="text-sm">No Restrictions</span>
            </div>
          </div>

          <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
            <div>
              <p className="font-semibold text-lg">$10,000</p>
              <p className="text-sm text-muted-foreground">One-time purchase</p>
            </div>
            <Button
              onClick={purchaseAdminPass}
              disabled={purchasing || coins < 10000 || hasPass}
              size="lg"
              className="bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600"
            >
              {purchasing ? (
                "Purchasing..."
              ) : hasPass ? (
                "Purchased"
              ) : coins < 10000 ? (
                `Need ${10000 - coins} more coins`
              ) : (
                "Purchase Admin Pass"
              )}
            </Button>
          </div>

          {hasPass && (
            <div className="text-center text-sm text-muted-foreground">
              ✅ Admin Pass owned! Reloading privileges...
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}
