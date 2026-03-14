import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { ArrowLeft } from "lucide-react";
import { HelixLoader } from "@/components/ui/helix-loader";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { User as UserIcon } from "lucide-react";

interface UserProfile {
  username?: string;
  full_name?: string;
  bio?: string;
  avatar_url?: string | null;
  created_at: string;
}

export default function AccountInformationPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadProfileData(session.user.id);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadProfileData(session.user.id);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const loadProfileData = async (userId: string) => {
    try {
      const { data: profileData, error: profileError } = await supabase
        .from("profiles")
        .select("username, full_name, bio, avatar_url, created_at")
        .eq("user_id", userId)
        .maybeSingle();

      if (profileError) throw profileError;

      setProfile({
        username: profileData?.username,
        full_name: profileData?.full_name,
        bio: profileData?.bio,
        avatar_url: profileData?.avatar_url,
        created_at: profileData?.created_at,
      });
    } catch (error) {
      console.error("Error loading profile data:", error);
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (dateString: string): string => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  if (loading || !user || !profile) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center space-y-4">
          <HelixLoader className="text-primary mx-auto" />
          <p className="text-muted-foreground">Loading account information...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6 space-y-6">
        <Button
          variant="ghost"
          onClick={() => navigate("/settings")}
          className="mb-4"
        >
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Settings
        </Button>

        <div className="max-w-2xl mx-auto">
          <h1 className="text-3xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
            Account Information
          </h1>
          <p className="text-muted-foreground mb-6">Your account details</p>

          <Card>
            <CardContent className="p-6">
              <div className="space-y-6">
                {/* Avatar */}
                <div className="flex items-center justify-between py-3 border-b">
                  <span className="text-sm font-medium text-muted-foreground">Current Avatar</span>
                  <Avatar className="h-16 w-16">
                    {profile.avatar_url ? (
                      <>
                        <AvatarImage
                          src={profile.avatar_url}
                          alt="Avatar"
                          onError={(e) => {
                            const target = e.target as HTMLImageElement;
                            target.style.display = 'none';
                          }}
                        />
                        <AvatarFallback className="bg-gradient-to-br from-primary/20 to-purple-500/20">
                          <UserIcon className="h-8 w-8" />
                        </AvatarFallback>
                      </>
                    ) : (
                      <AvatarFallback className="bg-gradient-to-br from-primary/20 to-purple-500/20">
                        <UserIcon className="h-8 w-8" />
                      </AvatarFallback>
                    )}
                  </Avatar>
                </div>

                {/* Username */}
                <div className="flex items-center justify-between py-3 border-b">
                  <span className="text-sm font-medium text-muted-foreground">Username</span>
                  <span className="text-sm font-medium">
                    {profile.username || <span className="text-muted-foreground">Not set</span>}
                  </span>
                </div>

                {/* Full Name */}
                <div className="flex items-center justify-between py-3 border-b">
                  <span className="text-sm font-medium text-muted-foreground">Full Name</span>
                  <span className="text-sm font-medium">
                    {profile.full_name || <span className="text-muted-foreground">Not set</span>}
                  </span>
                </div>

                {/* Bio */}
                <div className="flex items-start justify-between py-3 border-b gap-4">
                  <span className="text-sm font-medium text-muted-foreground">Bio</span>
                  <div className="text-sm text-right max-w-xs">
                    {profile.bio || <span className="text-muted-foreground">Not set</span>}
                  </div>
                </div>

                {/* Member Since */}
                <div className="flex items-center justify-between py-3">
                  <span className="text-sm font-medium text-muted-foreground">Member Since</span>
                  <span className="text-sm font-medium">{formatDate(profile.created_at)}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}
