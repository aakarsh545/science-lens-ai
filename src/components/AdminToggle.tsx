import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Shield, ShieldOff, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";

const SUPER_ADMIN_EMAIL = 'aakarsh545@gmail.com';

export function AdminToggle() {
  const [loading, setLoading] = useState(false);
  const [currentStatus, setCurrentStatus] = useState<{ level: number; coins: number; is_admin: boolean } | null>(null);
  const [isSuperAdmin, setIsSuperAdmin] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    checkSuperAdmin();
    loadCurrentStatus();
  }, []);

  const checkSuperAdmin = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const userEmail = user.email;
    if (userEmail === SUPER_ADMIN_EMAIL) {
      setIsSuperAdmin(true);
    }
  };

  const loadCurrentStatus = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { data } = await supabase
      .from('profiles')
      .select('level, coins, is_admin')
      .eq('user_id', user.id)
      .single();

    if (data) {
      setCurrentStatus(data);
    }
  };

  const grantAdmin = async () => {
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not logged in');

      const userId = user.id;

      // 1. Save original state BEFORE granting admin
      const { data: currentProfile } = await supabase
        .from('profiles')
        .select('level, xp_points, coins, is_premium')
        .eq('user_id', userId)
        .single();

      // Save original state to user_stats metadata
      await supabase
        .from('user_stats')
        .update({
          is_admin: true,
          original_state: currentProfile || { level: 1, xp_points: 0, coins: 100, is_premium: false }
        })
        .eq('user_id', userId);

      // 2. Set admin flag and max privileges in profiles
      const { error: profileError } = await supabase
        .from('profiles')
        .update({
          is_admin: true,
          level: 1000,
          xp_points: 100000,
          coins: 999999999,
          is_premium: true
        })
        .eq('user_id', userId)
        .select();

      if (profileError) throw profileError;

      // 3. Get all shop items
      const { data: shopItems, error: itemsError } = await supabase
        .from('shop_items')
        .select('id');

      if (!itemsError && shopItems && shopItems.length > 0) {
        // Insert items one at a time to handle duplicates gracefully
        for (const item of shopItems) {
          try {
            await supabase
              .from('user_inventory')
              .insert({
                user_id: userId,
                item_id: item.id
              });
          } catch (err) {
            // Ignore duplicate errors
            if (!err.message?.includes('duplicate')) {
              console.warn('Failed to add item to inventory:', err);
            }
          }
        }
      }

      toast({
        title: "👑 Admin Mode Activated!",
        description: "You now have Level 1000, infinite coins, and all items unlocked!",
      });

      // Update local status before reload
      setCurrentStatus({ level: 1000, coins: 999999999, is_admin: true });

      // Force hard reload to clear all caches
      setTimeout(() => {
        window.location.href = window.location.href;
      }, 1000);
    } catch (error: any) {
      console.error('Error granting admin:', error);
      toast({
        title: "Error granting admin",
        description: error.message || "Unknown error occurred",
        variant: "destructive",
      });
      setLoading(false);
    }
  };

  const revokeAdmin = async () => {
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not logged in');

      const userId = user.id;

      // 1. Get original state from user_stats
      const { data: userStats } = await supabase
        .from('user_stats')
        .select('original_state')
        .eq('user_id', userId)
        .single();

      const originalState = userStats?.original_state || { level: 1, xp_points: 0, coins: 100, is_premium: false };

      // 2. Restore original state in profiles
      const { error: profileError } = await supabase
        .from('profiles')
        .update({
          is_admin: false,
          level: originalState.level,
          xp_points: originalState.xp_points,
          coins: originalState.coins,
          is_premium: originalState.is_premium
        })
        .eq('user_id', userId);

      if (profileError) throw profileError;

      // 3. Clear admin status and original_state in user_stats
      await supabase
        .from('user_stats')
        .update({
          is_admin: false,
          original_state: null
        })
        .eq('user_id', userId);

      toast({
        title: "Admin Mode Deactivated",
        description: "Your account has been restored to its original state.",
      });

      // Update local status
      if (currentStatus) {
        setCurrentStatus({
          ...currentStatus,
          is_admin: false,
          level: originalState.level,
          coins: originalState.coins
        });
      }

      // Force hard reload
      setTimeout(() => {
        window.location.href = window.location.href;
      }, 1000);
    } catch (error: any) {
      console.error('Error revoking admin:', error);
      toast({
        title: "Error revoking admin",
        description: error.message || "Unknown error occurred",
        variant: "destructive",
      });
      setLoading(false);
    }
  };

  // Don't render if not super admin
  if (!isSuperAdmin) {
    return null;
  }

  return (
    <Card className="border-yellow-500/50 bg-gradient-to-br from-yellow-50/50 to-orange-50/50 dark:from-yellow-950/20 dark:to-orange-950/20">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-lg">Admin Control Panel</CardTitle>
            <CardDescription>Toggle admin mode for testing</CardDescription>
          </div>
          {currentStatus?.is_admin ? (
            <Shield className="w-6 h-6 text-green-600 dark:text-green-400" />
          ) : (
            <ShieldOff className="w-6 h-6 text-gray-400" />
          )}
        </div>
      </CardHeader>
      <CardContent>
        {/* Current Status Display */}
        {currentStatus && (
          <div className="mb-4 p-3 bg-background/50 rounded-lg space-y-1">
            <div className="flex items-center justify-between text-sm">
              <span className="text-muted-foreground">Status:</span>
              <span className={`font-medium ${currentStatus.is_admin ? 'text-green-600 dark:text-green-400' : 'text-gray-500'}`}>
                {currentStatus.is_admin ? '👑 Admin Active' : '🔓 User Mode'}
              </span>
            </div>
            <div className="flex items-center justify-between text-sm">
              <span className="text-muted-foreground">Level:</span>
              <span className={`font-medium ${currentStatus.level >= 1000 ? 'text-yellow-600 dark:text-yellow-400' : ''}`}>
                {currentStatus.level}
              </span>
            </div>
            <div className="flex items-center justify-between text-sm">
              <span className="text-muted-foreground">Coins:</span>
              <span className="font-medium">
                {currentStatus.coins.toLocaleString()}
              </span>
            </div>
          </div>
        )}

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
          Admin: Level 1000, 999M coins, all items unlocked
        </p>
      </CardContent>
    </Card>
  );
}
