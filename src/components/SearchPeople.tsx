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
  credits: number;
  isAdmin: boolean;
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

    const { data } = await supabase.rpc('has_role', {
      _user_id: user.id,
      _role: 'admin' as const
    });

    if (data === true) {
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

      const filtered = allUsers.filter((user: UserProfile) =>
        user.email.toLowerCase().includes(query.toLowerCase()) ||
        user.id.toLowerCase().includes(query.toLowerCase())
      );

      setUsers(filtered);
    } catch (error) {
      console.error('Error searching users:', error);
      toast({
        title: "Search failed",
        description: "Could not search for users.",
        variant: "destructive",
      });
    } finally {
      setSearching(false);
    }
  };

  const grantAdminToUser = async (userId: string, userEmail: string) => {
    setLoading(true);
    try {
      const { error } = await supabase.functions.invoke('grant-admin', {
        body: { userId }
      });

      if (error) throw error;

      toast({
        title: "Admin Granted",
        description: `${userEmail} is now an admin`,
      });

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
      const { error } = await supabase.functions.invoke('revoke-admin', {
        body: { userId }
      });

      if (error) throw error;

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

  if (!isAdmin) {
    return null;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-lg flex items-center gap-2">
          <Search className="w-5 h-5" />
          User Management
        </CardTitle>
        <CardDescription>Search and manage user admin privileges</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex gap-2">
          <Input
            placeholder="Search by email or ID..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && searchUsers(searchQuery)}
          />
          <Button onClick={() => searchUsers(searchQuery)} disabled={searching}>
            {searching ? <Loader2 className="w-4 h-4 animate-spin" /> : <Search className="w-4 h-4" />}
          </Button>
        </div>

        {users.length > 0 && (
          <div className="space-y-2">
            {users.map((user) => (
              <div key={user.id} className="flex items-center justify-between p-3 border rounded-lg">
                <div className="flex items-center gap-2">
                  <User className="w-4 h-4 text-muted-foreground" />
                  <div>
                    <p className="text-sm font-medium">{user.email}</p>
                    <p className="text-xs text-muted-foreground">
                      Level: {user.level} | Credits: {user.credits}
                    </p>
                  </div>
                  {user.isAdmin && (
                    <Badge variant="default" className="ml-2">
                      <Crown className="w-3 h-3 mr-1" />
                      Admin
                    </Badge>
                  )}
                </div>
                <div className="flex gap-2">
                  {!user.isAdmin ? (
                    <Button
                      size="sm"
                      onClick={() => grantAdminToUser(user.id, user.email)}
                      disabled={loading}
                    >
                      <Shield className="w-3 h-3 mr-1" />
                      Grant
                    </Button>
                  ) : (
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => revokeAdminFromUser(user.id, user.email)}
                      disabled={loading}
                    >
                      <ShieldOff className="w-3 h-3 mr-1" />
                      Revoke
                    </Button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
