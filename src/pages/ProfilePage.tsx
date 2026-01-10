import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, ArrowLeft, Edit } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Skeleton } from "@/components/ui/skeleton";
import { motion } from "framer-motion";
import ProfileHeader from "@/components/profile/ProfileHeader";
import StatsOverview from "@/components/profile/StatsOverview";
import XPProgressGraph from "@/components/profile/XPProgressGraph";
import TopicMasteryRadar from "@/components/profile/TopicMasteryRadar";
import LearningStreakHeatMap from "@/components/profile/LearningStreakHeatMap";
import RecentActivityTimeline from "@/components/profile/RecentActivityTimeline";
import AchievementsGrid from "@/components/profile/AchievementsGrid";
import PerformanceBySubject from "@/components/profile/PerformanceBySubject";
import { EditProfileDialog } from "@/components/EditProfileDialog";

interface UserProfile {
  id: string;
  username?: string;
  full_name?: string;
  avatar_url?: string;
  bio?: string;
  website?: string;
  location?: string;
  created_at: string;
  updated_at: string;
}

interface TopicProgress {
  id: string;
  user_id: string;
  topic_id: string;
  mastery_level: number;
  questions_correct: number;
  questions_total: number;
  last_practiced: string;
  created_at: string;
  updated_at: string;
}

interface Achievement {
  id: string;
  user_id: string;
  achievement_type: string;
  achieved_at: string;
  created_at: string;
}

interface ActivityLog {
  id: string;
  user_id: string;
  activity_type: string;
  description: string;
  created_at: string;
}

interface UserStats {
  lessonsCompleted: number;
  quizzesTaken: number;
  challengesCompleted: number;
  topicProgress: TopicProgress[];
  achievements: Achievement[];
  activityLogs: ActivityLog[];
  streakCount: number;
  totalQuestions: number;
  xpPoints: number;
  level: number;
}

export default function ProfilePage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [stats, setStats] = useState<UserStats | null>(null);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
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
      // Load profile
      const { data: profileData, error: profileError } = await supabase
        .from("profiles")
        .select("*")
        .eq("user_id", userId)
        .single();

      if (profileError) throw profileError;
      setProfile(profileData);

      // Load stats (we'll aggregate from various tables)
      const [
        lessonsCompleted,
        challengesCompleted,
        topicProgress,
        achievements,
        activityLogs
      ] = await Promise.all([
        supabase.from("user_progress").select("*").eq("user_id", userId).eq("status", "completed"),
        supabase.from("challenges").select("*").eq("user_id", userId).eq("status", "completed"),
        supabase.from("user_topic_progress").select("*").eq("user_id", userId),
        supabase.from("achievements").select("*").eq("user_id", userId),
        supabase.from("activity_log").select("*").eq("user_id", userId).order("created_at", { ascending: false }).limit(50)
      ]);

      setStats({
        lessonsCompleted: lessonsCompleted.data?.length || 0,
        quizzesTaken: 0, // Will be calculated from other data
        challengesCompleted: challengesCompleted.data?.length || 0,
        topicProgress: topicProgress.data || [],
        achievements: achievements.data || [],
        activityLogs: activityLogs.data || [],
        streakCount: profileData?.streak_count || 0,
        totalQuestions: profileData?.total_questions || 0,
        xpPoints: profileData?.xp_points || 0,
        level: profileData?.level || 1
      });

      setLoading(false);
    } catch (error) {
      console.error("Error loading profile data:", error);
      setLoading(false);
    }
  };

  if (loading || !user || !profile || !stats) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="text-center space-y-4">
          <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto" />
          <p className="text-muted-foreground">Loading profile...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6 space-y-6">
        {/* Back Button */}
        <Button
          variant="ghost"
          onClick={() => navigate("/")}
          className="mb-4"
        >
          <ArrowLeft className="mr-2 h-4 w-4" />
          Back to Dashboard
        </Button>

        {/* Profile Header */}
        <ProfileHeader
          user={user}
          profile={profile}
          onEdit={() => setEditDialogOpen(true)}
        />

        {/* Stats Overview Cards */}
        <StatsOverview stats={stats} />

        {/* Analytics Dashboard */}
        <Tabs defaultValue="overview" className="w-full">
          <TabsList className="grid w-full grid-cols-4 lg:w-[600px] lg:mx-auto">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="progress">Progress</TabsTrigger>
            <TabsTrigger value="activity">Activity</TabsTrigger>
            <TabsTrigger value="achievements">Achievements</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6 mt-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* XP Progress Graph */}
              <XPProgressGraph userId={user.id} />

              {/* Topic Mastery Radar */}
              <TopicMasteryRadar userId={user.id} />
            </div>

            {/* Learning Streak Heat Map */}
            <LearningStreakHeatMap userId={user.id} />

            {/* Performance by Subject */}
            <PerformanceBySubject userId={user.id} />
          </TabsContent>

          <TabsContent value="progress" className="space-y-6 mt-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <XPProgressGraph userId={user.id} />
              <TopicMasteryRadar userId={user.id} />
            </div>
            <PerformanceBySubject userId={user.id} />
          </TabsContent>

          <TabsContent value="activity" className="space-y-6 mt-6">
            <LearningStreakHeatMap userId={user.id} />
            <RecentActivityTimeline activities={stats.activityLogs} />
          </TabsContent>

          <TabsContent value="achievements" className="space-y-6 mt-6">
            <AchievementsGrid achievements={stats.achievements} />
          </TabsContent>
        </Tabs>

        {/* Edit Profile Dialog */}
        <EditProfileDialog
          open={editDialogOpen}
          onOpenChange={setEditDialogOpen}
          userId={user.id}
          currentProfile={{
            username: profile?.username,
            full_name: profile?.full_name,
            bio: profile?.bio,
            avatar_url: profile?.equipped_avatar, // Use equipped_avatar for shop avatars
          }}
          onProfileUpdate={() => loadProfileData(user.id)}
        />
      </div>
    </div>
  );
}
