import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Search, Shield, ShieldOff, Loader2, User, Crown } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";

interface UserProfile {
  id: string;
  email: string;
  level: number;
  coins: number;
  is_admin: boolean;
  is_premium: boolean;
}

export function SearchPeople() {
  const [searchQuery, setSearchQuery] = useState("");
  const [users, setUsers] = useState<UserProfile[]>([]);
  const [loading, setLoading] = useState(false);
  const [searching, setSearching] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    checkAdminStatus();
  }, []);

  const checkAdminStatus = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const { data } = await supabase
      .from('profiles')
      .select('is_admin')
      .eq('user_id', user.id)
      .single();

    if (data && data.is_admin) {
      setIsAdmin(true);
    }
  };

  const searchUsers = async (query: string) => {
    if (!query.trim() || query.length < 2) {
      setUsers([]);
      return;
    }

    setSearching(true);
    try {
      const { data, error } = await supabase.functions.invoke('search-users');

      if (error) throw error;

      let allUsers = data?.users || [];

      // Filter by search query
      const filtered = allUsers.filter((user: UserProfile) =>
        user.email.toLowerCase().includes(query.toLowerCase()) ||
        user.id.toLowerCase().includes(query.toLowerCase())
      );

      setUsers(filtered);
    } catch (error) {
      console.error('Error searching users:', error);
      toast({
        title: "Search failed",
        description: "Could not search for users. Service role key may not be configured.",
        variant: "destructive",
      });
    } finally {
      setSearching(false);
    }
  };

  const grantAdminToUser = async (userId: string, userEmail: string) => {
    setLoading(true);
    try {
      // Save original state
      const { data: currentProfile } = await supabase
        .from('profiles')
        .select('level, xp_points, coins, is_premium')
        .eq('id', userId)
        .single();

      // Save to user_stats
      await supabase
        .from('user_stats')
        .update({
          is_admin: true,
          original_state: currentProfile || { level: 1, xp_points: 0, coins: 100, is_premium: false }
        })
        .eq('user_id', userId);

      // Grant admin
      await supabase
        .from('profiles')
        .update({
          is_admin: true,
          level: 1000,
          xp_points: 100000,
          coins: 999999999,
          is_premium: true
        })
        .eq('id', userId);

      // Add all shop items
      const { data: shopItems } = await supabase
        .from('shop_items')
        .select('id');

      if (shopItems) {
        for (const item of shopItems) {
          try {
            await supabase
              .from('user_inventory')
              .insert({ user_id: userId, item_id: item.id });
          } catch (err) {
            // Ignore duplicates
          }
        }
      }

      toast({
        title: "Admin Granted",
        description: `${userEmail} is now an admin`,
      });

      // Refresh search
      searchUsers(searchQuery);
    } catch (error) {
      toast({
        title: "Error granting admin",
        description: error instanceof Error ? error.message : "Unknown error",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const revokeAdminFromUser = async (userId: string, userEmail: string) => {
    setLoading(true);
    try {
      // Get original state
      const { data: userStats } = await supabase
        .from('user_stats')
        .select('original_state')
        .eq('user_id', userId)
        .single();

      const originalState = userStats?.original_state || { level: 1, xp_points: 0, coins: 100, is_premium: false };

      // Restore original state
      await supabase
        .from('profiles')
        .update({
          is_admin: false,
          level: originalState.level,
          xp_points: originalState.xp_points,
          coins: originalState.coins,
          is_premium: originalState.is_premium
        })
        .eq('id', userId);

      // Clear admin
      await supabase
        .from('user_stats')
        .update({
          is_admin: false,
          original_state: null
        })
        .eq('user_id', userId);

      toast({
        title: "Admin Revoked",
        description: `${userEmail} is no longer an admin`,
      });

      searchUsers(searchQuery);
    } catch (error) {
      toast({
        title: "Error revoking admin",
        description: error instanceof Error ? error.message : "Unknown error",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  // Don't render if not admin
  if (!isAdmin) {
    return null;
  }

  return (
    <Card className="border-purple-500/50 bg-gradient-to-br from-purple-50/50 to-pink-50/50 dark:from-purple-950/20 dark:to-pink-950/20">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-lg flex items-center gap-2">
              <Crown className="w-5 h-5 text-purple-600 dark:text-purple-400" />
              Search People
            </CardTitle>
            <CardDescription>Grant or revoke admin access to any user</CardDescription>
          </div>
        </div>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Search Input */}
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input
            placeholder="Search by email or user ID..."
            value={searchQuery}
            onChange={(e) => {
              setSearchQuery(e.target.value);
              searchUsers(e.target.value);
            }}
            className="pl-10"
          />
        </div>

        {/* Results */}
        {searching && (
          <div className="flex items-center justify-center py-8">
            <Loader2 className="w-6 h-6 animate-spin text-muted-foreground" />
          </div>
        )}

        {!searching && users.length > 0 && (
          <div className="space-y-2 max-h-96 overflow-y-auto">
            {users.map((user) => (
              <div
                key={user.id}
                className="flex items-center justify-between p-3 bg-background/50 rounded-lg hover:bg-background/80 transition-colors"
              >
                <div className="flex items-center gap-3 flex-1 min-w-0">
                  <div className="w-10 h-10 rounded-full bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center text-white font-semibold">
                    {user.email.charAt(0).toUpperCase()}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium truncate text-sm">{user.email}</p>
                    <div className="flex items-center gap-2 text-xs text-muted-foreground">
                      <span>Lvl {user.level}</span>
                      <span>•</span>
                      <span>{user.coins.toLocaleString()} coins</span>
                      {user.is_premium && (
                        <>
                          <span>•</span>
                          <Badge variant="secondary" className="text-xs">Premium</Badge>
                        </>
                      )}
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-2">
                  {user.is_admin ? (
                    <Badge className="bg-green-500">
                      <Shield className="w-3 h-3 mr-1" />
                      Admin
                    </Badge>
                  ) : (
                    <Badge variant="outline">
                      <User className="w-3 h-3 mr-1" />
                      User
                    </Badge>
                  )}

                  {user.is_admin ? (
                    <Button
                      size="sm"
                      variant="destructive"
                      onClick={() => revokeAdminFromUser(user.id, user.email)}
                      disabled={loading}
                    >
                      {loading ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <>
                          <ShieldOff className="w-3 h-3 mr-1" />
                          Revoke
                        </>
                      )}
                    </Button>
                  ) : (
                    <Button
                      size="sm"
                      className="bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600"
                      onClick={() => grantAdminToUser(user.id, user.email)}
                      disabled={loading}
                    >
                      {loading ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <>
                          <Shield className="w-3 h-3 mr-1" />
                          Grant
                        </>
                      )}
                    </Button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}

        {!searching && searchQuery && users.length === 0 && (
          <div className="text-center py-8 text-muted-foreground">
            No users found matching "{searchQuery}"
          </div>
        )}
      </CardContent>
    </Card>
  );
}
