import { useCallback, useEffect, useMemo, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { EditProfileDialog } from "@/components/EditProfileDialog";

type Profile = {
  username: string | null;
  full_name: string | null;
  bio: string | null;
  avatar_url: string | null;
  created_at: string | null;
};

export default function SettingsPage() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [email, setEmail] = useState<string | null>(null);
  const [userId, setUserId] = useState<string | null>(null);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const navigate = useNavigate();

  const memberSince = useMemo(() => {
    if (!profile?.created_at) return null;
    const date = new Date(profile.created_at);
    if (Number.isNaN(date.getTime())) return null;
    return new Intl.DateTimeFormat("en-US", { month: "long", year: "numeric" }).format(date);
  }, [profile?.created_at]);

  const avatarFallback = useMemo(() => {
    const base = (profile?.full_name || profile?.username || email || "").trim();
    if (!base) return "?";
    const parts = base.split(/\s+/).filter(Boolean);
    const initials =
      parts.length >= 2 ? `${parts[0][0] || ""}${parts[1][0] || ""}` : `${parts[0][0] || ""}`;
    return initials.toUpperCase();
  }, [profile?.full_name, profile?.username, email]);

  const loadAccountInfo = useCallback(async () => {
    setLoading(true);
    setError(null);

    const { data: { session } } = await supabase.auth.getSession();
    const sessionUser = session?.user;
    if (!sessionUser) {
      navigate("/");
      return;
    }

    setUserId(sessionUser.id);

    const [{ data: profileData, error: profileError }, { data: userData, error: userError }] = await Promise.all([
      supabase
        .from("profiles")
        .select("username, full_name, bio, avatar_url, created_at")
        .eq("user_id", sessionUser.id)
        .maybeSingle(),
      supabase.auth.getUser(),
    ]);

    if (userError) {
      setEmail(null);
    } else {
      setEmail(userData.user?.email ?? null);
    }

    if (profileError) {
      setProfile(null);
      setError("Failed to load account information.");
      setLoading(false);
      return;
    }

    setProfile((profileData as Profile | null) ?? null);
    setLoading(false);
  }, [navigate]);

  useEffect(() => {
    loadAccountInfo();
  }, [loadAccountInfo]);

  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-2xl font-semibold tracking-tight text-foreground">Settings</h1>
        <p className="text-sm text-muted-foreground mt-1">Manage your account and app preferences.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Account Information</CardTitle>
          <CardDescription>Read-only profile details.</CardDescription>
        </CardHeader>
        <CardContent className="space-y-5">
          {loading ? (
            <div className="space-y-5">
              <div className="flex items-center gap-4">
                <Skeleton className="h-12 w-12 rounded-full" />
                <div className="space-y-2">
                  <Skeleton className="h-4 w-40" />
                  <Skeleton className="h-4 w-56" />
                </div>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Skeleton className="h-3 w-24" />
                  <Skeleton className="h-4 w-48" />
                </div>
                <div className="space-y-2">
                  <Skeleton className="h-3 w-24" />
                  <Skeleton className="h-4 w-48" />
                </div>
                <div className="space-y-2">
                  <Skeleton className="h-3 w-24" />
                  <Skeleton className="h-4 w-72" />
                </div>
                <div className="space-y-2">
                  <Skeleton className="h-3 w-24" />
                  <Skeleton className="h-4 w-40" />
                </div>
              </div>
              <div className="space-y-2">
                <Skeleton className="h-3 w-24" />
                <Skeleton className="h-16 w-full" />
              </div>
            </div>
          ) : error ? (
            <div className="rounded-md border border-destructive/40 bg-destructive/10 p-4 text-sm text-destructive">
              {error}
              <div className="mt-3">
                <Button variant="outline" size="sm" onClick={loadAccountInfo}>
                  Retry
                </Button>
              </div>
            </div>
          ) : (
            <>
              <div className="flex items-center gap-4">
                <Avatar className="h-12 w-12">
                  <AvatarImage src={profile?.avatar_url || undefined} alt="Avatar" />
                  <AvatarFallback className="text-sm font-medium">{avatarFallback}</AvatarFallback>
                </Avatar>
                <div>
                  <div className="text-sm text-muted-foreground">Avatar</div>
                  <div className="text-sm text-foreground">Profile picture</div>
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <div className="text-sm text-muted-foreground">Username</div>
                  <div className="text-sm text-foreground">{profile?.username || "—"}</div>
                </div>
                <div>
                  <div className="text-sm text-muted-foreground">Full Name</div>
                  <div className="text-sm text-foreground">{profile?.full_name || "—"}</div>
                </div>
                <div>
                  <div className="text-sm text-muted-foreground">Email</div>
                  <div className="text-sm text-foreground">{email || "—"}</div>
                </div>
                <div>
                  <div className="text-sm text-muted-foreground">Member Since</div>
                  <div className="text-sm text-foreground">{memberSince || "—"}</div>
                </div>
              </div>

              <div>
                <div className="text-sm text-muted-foreground">Bio</div>
                <div className="text-sm text-foreground whitespace-pre-wrap">
                  {profile?.bio && profile.bio.trim() ? profile.bio : "No bio yet"}
                </div>
              </div>
            </>
          )}
        </CardContent>

        <CardFooter className="justify-end">
          <Button variant="link" className="px-0" onClick={() => setEditDialogOpen(true)} disabled={loading || !!error}>
            Edit Profile
          </Button>
        </CardFooter>
      </Card>

      {userId && (
        <EditProfileDialog
          open={editDialogOpen}
          onOpenChange={setEditDialogOpen}
          userId={userId}
          currentProfile={{
            username: profile?.username ?? undefined,
            full_name: profile?.full_name ?? undefined,
            bio: profile?.bio ?? undefined,
            avatar_url: profile?.avatar_url ?? undefined,
          }}
          onProfileUpdate={loadAccountInfo}
        />
      )}
    </div>
  );
}
