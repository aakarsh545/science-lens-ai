import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Shield, ShieldOff, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";

export function AdminToggle() {
  const [loading, setLoading] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    checkAdminStatus();
  }, []);

  const checkAdminStatus = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    // Use the proper has_role RPC to check admin status server-side
    const { data } = await supabase.rpc('has_role', {
      _user_id: user.id,
      _role: 'admin' as const
    });

    setIsAdmin(data === true);
  };

  const grantAdmin = async () => {
    setLoading(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not logged in');

      // Call the server-side grant-admin edge function
      const { data, error } = await supabase.functions.invoke('grant-admin', {
        body: { userId: user.id }
      });

      if (error) throw error;

      toast({
        title: "👑 Admin Mode Activated!",
        description: "Admin privileges granted via server-side verification.",
      });

      setTimeout(() => {
        window.location.href = window.location.href;
      }, 1000);
    } catch (error) {
      console.error('Error granting admin:', error);
      toast({
        title: "Error granting admin",
        description: error instanceof Error ? error.message : "Unknown error occurred",
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

      // Call the server-side revoke-admin edge function
      const { data, error } = await supabase.functions.invoke('revoke-admin', {
        body: { userId: user.id }
      });

      if (error) throw error;

      toast({
        title: "Admin Mode Deactivated",
        description: "Your account has been restored.",
      });

      setTimeout(() => {
        window.location.href = window.location.href;
      }, 1000);
    } catch (error) {
      console.error('Error revoking admin:', error);
      toast({
        title: "Error revoking admin",
        description: error instanceof Error ? error.message : "Unknown error occurred",
        variant: "destructive",
      });
      setLoading(false);
    }
  };

  if (!isAdmin) {
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
          <Shield className="w-6 h-6 text-green-600 dark:text-green-400" />
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
          Admin privileges are managed server-side via the user_roles table.
        </p>
      </CardContent>
    </Card>
  );
}
