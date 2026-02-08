import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, ArrowLeft, Edit, ClipboardList } from "lucide-react";
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
  onboarding_completed?: boolean;
  onboarding_data?: Record<string, any> | null;
  daily_goal_minutes?: number;
}

interface TopicProgress {
  id: string;
  user_id: string;
  topic_id: string;
  questions_answered: number | null;
  correct_answers: number | null;
  completion_percentage: number | null;
  last_practiced_at: string | null;
  created_at: string;
  updated_at: string;
}

interface Achievement {
  id: string;
  user_id: string;
  achievement_type: string;
  title: string;
  description: string | null;
  icon: string | null;
  category: string | null;
  points: number | null;
  earned_at: string;
}

interface ActivityLog {
  id: string;
  activity_type: string;
  xp_earned: number;
  created_at: string;
  metadata?: Record<string, unknown>;
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
        topicProgress,
        achievements
      ] = await Promise.all([
        supabase.from("user_progress").select("*").eq("user_id", userId).eq("status", "completed"),
        supabase.from("user_topic_progress").select("*").eq("user_id", userId),
        supabase.from("achievements").select("*").eq("user_id", userId)
      ]);

      setStats({
        lessonsCompleted: lessonsCompleted.data?.length || 0,
        quizzesTaken: 0,
        challengesCompleted: 0,
        topicProgress: topicProgress.data || [],
        achievements: achievements.data || [],
        activityLogs: [],
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
          <TabsList className="grid w-full grid-cols-5 lg:w-[700px] lg:mx-auto">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="onboarding">Onboarding</TabsTrigger>
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

          <TabsContent value="onboarding" className="space-y-6 mt-6">
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="p-2 rounded-lg bg-primary/10">
                      <ClipboardList className="w-6 h-6 text-primary" />
                    </div>
                    <div>
                      <CardTitle>Your Onboarding Information</CardTitle>
                      <CardDescription>
                        {profile?.onboarding_completed
                          ? "You've completed the onboarding survey!"
                          : "You haven't completed the onboarding survey yet."}
                      </CardDescription>
                    </div>
                  </div>
                  {profile?.onboarding_completed && (
                    <Badge className="bg-green-500/20 text-green-500 border-green-500/30">
                      Completed
                    </Badge>
                  )}
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {profile?.onboarding_data && Object.keys(profile.onboarding_data).length > 0 ? (
                  <>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      {/* How did you hear about us */}
                      {profile.onboarding_data.how_hear_about && (
                        <div className="space-y-2">
                          <h4 className="text-sm font-semibold text-muted-foreground">How did you hear about us</h4>
                          <div className="flex items-center gap-2 p-3 rounded-lg bg-muted/50">
                            <span className="text-2xl">
                              {profile.onboarding_data.how_hear_about === 'youtube' && '📺'}
                              {profile.onboarding_data.how_hear_about === 'friends_family' && '👥'}
                              {profile.onboarding_data.how_hear_about === 'tiktok' && '🎵'}
                              {profile.onboarding_data.how_hear_about === 'google_search' && '🔍'}
                              {profile.onboarding_data.how_hear_about === 'tv' && '📺'}
                              {profile.onboarding_data.how_hear_about === 'news_article' && '📰'}
                              {profile.onboarding_data.how_hear_about === 'facebook_instagram' && '📱'}
                              {profile.onboarding_data.how_hear_about === 'other' && '💬'}
                            </span>
                            <span className="font-medium capitalize">
                              {profile.onboarding_data.how_hear_about === 'youtube' && 'YouTube'}
                              {profile.onboarding_data.how_hear_about === 'friends_family' && 'Friends/Family'}
                              {profile.onboarding_data.how_hear_about === 'google_search' && 'Google Search'}
                              {profile.onboarding_data.how_hear_about === 'news_article' && 'News Article'}
                              {profile.onboarding_data.how_hear_about === 'facebook_instagram' && 'Facebook/Instagram'}
                              {profile.onboarding_data.how_hear_about === 'other' && (profile.onboarding_data.how_hear_about_other || 'Other')}
                            </span>
                          </div>
                        </div>
                      )}

                      {/* Motivation */}
                      {profile.onboarding_data.motivation && (
                        <div className="space-y-2">
                          <h4 className="text-sm font-semibold text-muted-foreground">Your motivation</h4>
                          <div className="flex items-center gap-2 p-3 rounded-lg bg-muted/50">
                            <span className="text-2xl">
                              {profile.onboarding_data.motivation === 'school_exam' && '🎓'}
                              {profile.onboarding_data.motivation === 'career_boost' && '🚀'}
                              {profile.onboarding_data.motivation === 'personal_curiosity' && '💡'}
                              {profile.onboarding_data.motivation === 'support_education' && '🤝'}
                              {profile.onboarding_data.motivation === 'connect_others' && '👥'}
                              {profile.onboarding_data.motivation === 'just_fun' && '🎉'}
                              {profile.onboarding_data.motivation === 'other' && '💬'}
                            </span>
                            <span className="font-medium capitalize">
                              {profile.onboarding_data.motivation === 'school_exam' && 'School/Exam preparation'}
                              {profile.onboarding_data.motivation === 'career_boost' && 'Career boost'}
                              {profile.onboarding_data.motivation === 'personal_curiosity' && 'Personal curiosity'}
                              {profile.onboarding_data.motivation === 'support_education' && 'Support education'}
                              {profile.onboarding_data.motivation === 'connect_others' && 'Connect with others'}
                              {profile.onboarding_data.motivation === 'just_fun' && 'Just for fun'}
                              {profile.onboarding_data.motivation === 'other' && (profile.onboarding_data.motivation_other || 'Other')}
                            </span>
                          </div>
                        </div>
                      )}

                      {/* Knowledge Level */}
                      {profile.onboarding_data.knowledge_level && (
                        <div className="space-y-2">
                          <h4 className="text-sm font-semibold text-muted-foreground">Knowledge level</h4>
                          <div className="flex items-center gap-2 p-3 rounded-lg bg-muted/50">
                            <div className="flex items-center gap-2">
                              {Array.from({ length: 5 }).map((_, i) => (
                                <div
                                  key={i}
                                  className={`w-3 h-3 rounded-full ${
                                    i < (profile.onboarding_data.knowledge_level === 'new' ? 1
                                      : profile.onboarding_data.knowledge_level === 'basic' ? 2
                                      : profile.onboarding_data.knowledge_level === 'explain_simple' ? 3
                                      : profile.onboarding_data.knowledge_level === 'discuss_various' ? 4
                                      : 5)
                                      ? 'bg-primary'
                                      : 'bg-gray-700'
                                  }`}
                                />
                              ))}
                            </div>
                            <span className="font-medium ml-2">
                              {profile.onboarding_data.knowledge_level === 'new' && 'New to science'}
                              {profile.onboarding_data.knowledge_level === 'basic' && 'Basic concepts'}
                              {profile.onboarding_data.knowledge_level === 'explain_simple' && 'Can explain simple topics'}
                              {profile.onboarding_data.knowledge_level === 'discuss_various' && 'Can discuss various subjects'}
                              {profile.onboarding_data.knowledge_level === 'advanced_details' && 'Advanced knowledge'}
                            </span>
                          </div>
                        </div>
                      )}
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      {/* Daily Goal */}
                      {profile.daily_goal_minutes && (
                        <div className="space-y-2">
                          <h4 className="text-sm font-semibold text-muted-foreground">Daily learning goal</h4>
                          <div className="flex items-center gap-2 p-3 rounded-lg bg-muted/50">
                            <span className="text-2xl">⏱️</span>
                            <span className="font-semibold text-lg">{profile.daily_goal_minutes} minutes per day</span>
                          </div>
                        </div>
                      )}

                      {/* Starting Point */}
                      {profile.onboarding_data.starting_point && (
                        <div className="space-y-2">
                          <h4 className="text-sm font-semibold text-muted-foreground">Starting preference</h4>
                          <div className="flex items-center gap-2 p-3 rounded-lg bg-muted/50">
                            <span className="text-2xl">
                              {profile.onboarding_data.starting_point === 'basics' ? '📖' : '🎯'}
                            </span>
                            <span className="font-medium">
                              {profile.onboarding_data.starting_point === 'basics' ? 'Start from basics' : 'Find my level'}
                            </span>
                          </div>
                        </div>
                      )}
                    </div>
                  </>
                ) : (
                  <div className="text-center py-8">
                    <p className="text-muted-foreground">No onboarding data available yet.</p>
                  </div>
                )}
              </CardContent>
            </Card>
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
            avatar_url: profile?.avatar_url,
          }}
          onProfileUpdate={() => loadProfileData(user.id)}
        />
      </div>
    </div>
  );
}
