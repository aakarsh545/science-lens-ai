import { useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Shield, ShieldOff, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";

export function AdminToggle() {
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  const checkCurrentStatus = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return null;

    const { data } = await supabase
      .from('profiles')
      .select('is_admin, level, coins')
      .eq('user_id', user.id)
      .single();

    return data;
  };

  const grantAdmin = async () => {
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not logged in');

      const userId = user.id;

      // 1. Set admin flag and max privileges
      const { error: profileError } = await supabase
        .from('profiles')
        .update({
          is_admin: true,
          level: 1000,
          xp_points: 100000,
          coins: 999999999,
          is_premium: true
        })
        .eq('user_id', userId);

      if (profileError) throw profileError;

      // 2. Set admin flag in user_stats
      await supabase
        .from('user_stats')
        .update({ is_admin: true })
        .eq('user_id', userId);

      // 3. Get all shop items
      const { data: shopItems } = await supabase
        .from('shop_items')
        .select('id');

      // 4. Add all items to inventory
      if (shopItems && shopItems.length > 0) {
        const inventoryItems = shopItems.map(item => ({
          user_id: userId,
          item_id: item.id
        }));

        await supabase
          .from('user_inventory')
          .insert(inventoryItems)
          .ignoreDuplicates();
      }

      toast({
        title: "👑 Admin Mode Activated!",
        description: "You now have Level 1000, infinite coins, and all items unlocked!",
      });

      // Reload page to show changes
      setTimeout(() => window.location.reload(), 1500);
    } catch (error: any) {
      toast({
        title: "Error granting admin",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const revokeAdmin = async () => {
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not logged in');

      await supabase
        .from('profiles')
        .update({ is_admin: false })
        .eq('user_id', user.id);

      await supabase
        .from('user_stats')
        .update({ is_admin: false })
        .eq('user_id', user.id);

      toast({
        title: "Admin Mode Deactivated",
        description: "Your admin privileges have been revoked.",
      });

      setTimeout(() => window.location.reload(), 1500);
    } catch (error: any) {
      toast({
        title: "Error revoking admin",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card className="border-yellow-500/50 bg-gradient-to-br from-yellow-50/50 to-orange-50/50 dark:from-yellow-950/20 dark:to-orange-950/20">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-lg">Admin Control Panel</CardTitle>
            <CardDescription>Toggle admin mode for testing</CardDescription>
          </div>
          <Shield className="w-6 h-6 text-yellow-600 dark:text-yellow-400" />
        </div>
      </CardHeader>
      <CardContent>
        <div className="flex gap-2">
          <Button
            onClick={grantAdmin}
            disabled={loading}
            className="bg-gradient-to-r from-yellow-500 to-orange-500 hover:from-yellow-600 hover:to-orange-600"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Processing...
              </>
            ) : (
              <>
                <Shield className="w-4 h-4 mr-2" />
                Grant Admin
              </>
            )}
          </Button>
          <Button
            onClick={revokeAdmin}
            disabled={loading}
            variant="outline"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Processing...
              </>
            ) : (
              <>
                <ShieldOff className="w-4 h-4 mr-2" />
                Revoke Admin
              </>
            )}
          </Button>
        </div>
        <p className="text-xs text-muted-foreground mt-3">
          Admin mode: Level 1000, 999M coins, all items unlocked
        </p>
      </CardContent>
    </Card>
  );
}
