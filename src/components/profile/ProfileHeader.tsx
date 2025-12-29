import { User } from "@supabase/supabase-js";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Edit, Award } from "lucide-react";

interface ProfileHeaderProps {
  user: User;
  profile: any;
  onEdit?: () => void;
}

export default function ProfileHeader({ user, profile, onEdit }: ProfileHeaderProps) {
  const displayName = profile?.username || profile?.display_name || profile?.full_name || user?.email?.split("@")[0] || "Explorer";
  const initials = displayName
    .split(" ")
    .map((n: string) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);

  const joinDate = new Date(user?.created_at || Date.now()).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
  });

  return (
    <>
      <Card className="card-cosmic border-2">
        <CardContent className="p-6">
          <div className="flex flex-col md:flex-row items-center gap-6">
            {/* Avatar */}
            <Avatar className="h-24 w-24 border-4 border-primary/20">
              <AvatarImage src={profile?.avatar_url || undefined} />
              <AvatarFallback className="text-2xl bg-gradient-to-br from-primary to-primary/60 text-white">
                {initials}
              </AvatarFallback>
            </Avatar>

            {/* User Info */}
            <div className="flex-1 text-center md:text-left">
              <div className="flex flex-col md:flex-row md:items-center gap-3 mb-2">
                <h1 className="text-3xl font-bold">{displayName}</h1>
                <Badge className="w-fit bg-gradient-to-r from-achievement to-achievement/80 text-white border-0">
                  <Award className="mr-1 h-3 w-3" />
                  Level {profile?.level || 1}
                </Badge>
              </div>
              <p className="text-muted-foreground mb-3">
                Member since {joinDate}
              </p>

              {/* XP Display */}
              <div className="flex items-center justify-center md:justify-start gap-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-primary">
                    {profile?.xp_points || 0}
                  </div>
                  <div className="text-xs text-muted-foreground">Total XP</div>
                </div>
                <div className="h-8 w-px bg-border" />
                <div className="text-center">
                  <div className="text-lg font-semibold">
                    {profile?.streak_count || 0}
                  </div>
                  <div className="text-xs text-muted-foreground">Day Streak</div>
                </div>
              </div>
            </div>

            {/* Edit Profile Button */}
            <Button variant="outline" className="gap-2" onClick={onEdit}>
              <Edit className="h-4 w-4" />
              Edit Profile
            </Button>
          </div>
        </CardContent>
      </Card>
    </>
  );
}
