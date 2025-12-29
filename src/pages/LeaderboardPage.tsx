import { useEffect, useState, useCallback } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, Trophy, Medal, TrendingUp, TrendingDown, Award, Flame, Target, Atom, Beaker, Leaf, Star } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { SearchPeople } from "@/components/SearchPeople";

interface LeaderboardEntry {
  user_id: string;
  username?: string | null;
  display_name: string | null;
  full_name?: string | null;
  avatar_url: string | null;
  rank_num: number;
  xp_points?: number;
  level?: number;
  streak_count?: number;
  challenges_completed?: number;
  xp_earned_week?: number;
  xp_earned_month?: number;
  correct_answers?: number;
  questions_answered?: number;
  challenges_success_rate?: number;
}

interface UserProfile {
  username?: string | null;
  display_name: string | null;
  full_name?: string | null;
  avatar_url: string | null;
  show_in_leaderboard: boolean;
}

export default function LeaderboardPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [userRank, setUserRank] = useState<number | null>(null);
  const [activeTab, setActiveTab] = useState("all_time");
  const [searchQuery, setSearchQuery] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadUserProfile(session.user.id);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      loadUserProfile(session.user.id);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const loadUserProfile = async (userId: string) => {
    const { data } = await supabase
      .from("profiles")
      .select("username, display_name, full_name, avatar_url, show_in_leaderboard")
      .eq("user_id", userId)
      .single();

    if (data) {
      setUserProfile(data);
    }
  };

  // Helper function to get display name with priority
  const getDisplayName = (entry: LeaderboardEntry | UserProfile | null, userEmail?: string) => {
    if (!entry) return "Anonymous";
    return entry.username || entry.display_name || entry.full_name || userEmail?.split("@")[0] || "Anonymous";
  };

  const loadLeaderboard = useCallback(async (tab: string) => {
    setLoading(true);

    // Map tab names to view names
    const viewMap: Record<string, string> = {
      all_time: "leaderboard_all_time",
      weekly: "leaderboard_weekly",
      monthly: "leaderboard_monthly",
      streaks: "leaderboard_streaks",
      challenges: "leaderboard_challenges",
      physics: "leaderboard_physics",
      chemistry: "leaderboard_chemistry",
      biology: "leaderboard_biology",
      astronomy: "leaderboard_astronomy",
    };

    const viewName = viewMap[tab];

    let query = supabase
      .from(viewName)
      .select("*")
      .limit(100);

    if (tab === "weekly" || tab === "monthly") {
      // For time-based leaderboards, only show current period
      query = query.gte(
        tab === "weekly" ? "week_start_date" : "month_start_date",
        new Date(new Date().getFullYear(), new Date().getMonth(), 1).toISOString()
      );
    }

    const { data, error } = await query;

    if (error) {
      console.error("Error loading leaderboard:", error);
    } else if (data) {
      // Transform data to include rank_num
      const entries = data.map((entry: LeaderboardEntry, index: number) => ({
        ...entry,
        rank_num: index + 1,
      }));
      setLeaderboard(entries);
    }

    setLoading(false);
  }, []);

  const loadUserRank = useCallback(async (tab: string) => {
    if (!user) return;

    const { data, error } = await supabase.rpc("get_user_rank", {
      p_user_id: user.id,
      p_leaderboard: tab,
    });

    if (!error && data !== null) {
      setUserRank(data);
    }
  }, [user]);

  useEffect(() => {
    if (user) {
      loadLeaderboard(activeTab);
      loadUserRank(activeTab);
    }
  }, [user, activeTab, loadLeaderboard, loadUserRank]);

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Medal className="h-6 w-6 text-yellow-500" />;
    if (rank === 2) return <Medal className="h-6 w-6 text-gray-400" />;
    if (rank === 3) return <Medal className="h-6 w-6 text-amber-700" />;
    return <span className="text-lg font-bold text-muted-foreground">#{rank}</span>;
  };

  const getSubjectIcon = (tab: string) => {
    switch (tab) {
      case "physics": return <Atom className="h-5 w-5" />;
      case "chemistry": return <Beaker className="h-5 w-5" />;
      case "biology": return <Leaf className="h-5 w-5" />;
      case "astronomy": return <Star className="h-5 w-5" />;
      case "streaks": return <Flame className="h-5 w-5" />;
      case "challenges": return <Target className="h-5 w-5" />;
      default: return <Trophy className="h-5 w-5" />;
    }
  };

  const getInitials = (entry: LeaderboardEntry | UserProfile | null, userEmail?: string) => {
    const name = getDisplayName(entry, userEmail);
    if (!name || name === "Anonymous") return "U";
    return name
      .split(" ")
      .map((n) => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
  };

  const filteredLeaderboard = leaderboard.filter((entry) =>
    getDisplayName(entry)?.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const isUserInTop100 = userRank !== null && userRank <= 100;

  if (loading && leaderboard.length === 0) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="container mx-auto py-6 px-4 max-w-6xl">
      <div className="mb-6">
        <h1 className="text-4xl font-bold mb-2">Leaderboard</h1>
        <p className="text-muted-foreground">See how you stack up against other learners</p>
      </div>

      {/* Search People - Only visible to super admin */}
      <SearchPeople />

      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
        <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
          <div className="w-full overflow-x-auto pb-2 sm:pb-0">
            <TabsList className="grid grid-cols-3 lg:grid-cols-5 gap-2 h-auto min-w-max">
              <TabsTrigger value="all_time">All-Time</TabsTrigger>
              <TabsTrigger value="weekly">This Week</TabsTrigger>
              <TabsTrigger value="monthly">This Month</TabsTrigger>
              <TabsTrigger value="streaks">Streaks</TabsTrigger>
              <TabsTrigger value="challenges">Challenges</TabsTrigger>
              <TabsTrigger value="physics">Physics</TabsTrigger>
              <TabsTrigger value="chemistry">Chemistry</TabsTrigger>
              <TabsTrigger value="biology">Biology</TabsTrigger>
              <TabsTrigger value="astronomy">Astronomy</TabsTrigger>
            </TabsList>
          </div>

          <div className="flex items-center gap-2">
            <Input
              placeholder="Search users..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-64"
            />
            <Button
              variant="outline"
              size="icon"
              onClick={() => {
                loadLeaderboard(activeTab);
                loadUserRank(activeTab);
              }}
            >
              <Loader2 className={`h-4 w-4 ${loading ? "animate-spin" : ""}`} />
            </Button>
          </div>
        </div>

        {/* User's Rank Card */}
        {userProfile && userProfile.show_in_leaderboard && userRank && (
          <Card className="border-primary bg-primary/5">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Award className="h-5 w-5" />
                Your Position
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-3">
                  <div className="text-3xl font-bold text-primary">#{userRank}</div>
                  {user && (
                    <Avatar className="h-12 w-12">
                      <AvatarFallback className="bg-primary text-primary-foreground">
                        {getInitials(userProfile, user.email)}
                      </AvatarFallback>
                    </Avatar>
                  )}
                  <div>
                    <div className="font-semibold">{getDisplayName(userProfile, user.email)}</div>
                    <div className="text-sm text-muted-foreground">
                      {activeTab === "all_time" && `${getDisplayName(userProfile, user.email)}'s total XP`}
                      {activeTab === "weekly" && "XP earned this week"}
                      {activeTab === "monthly" && "XP earned this month"}
                      {activeTab === "streaks" && "Day streak"}
                      {activeTab === "challenges" && "Challenges completed"}
                      {(activeTab === "physics" || activeTab === "chemistry" ||
                        activeTab === "biology" || activeTab === "astronomy") &&
                        "Subject progress"}
                    </div>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        )}

        {/* Leaderboard Table */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2 capitalize">
              {getSubjectIcon(activeTab)}
              {activeTab.replace("_", " ")} Leaderboard
            </CardTitle>
            <CardDescription>
              {activeTab === "all_time" && "Top learners by total XP earned"}
              {activeTab === "weekly" && "Most XP earned this week"}
              {activeTab === "monthly" && "Most XP earned this month"}
              {activeTab === "streaks" && "Longest learning streaks"}
              {activeTab === "challenges" && "Most challenges completed"}
              {(activeTab === "physics" || activeTab === "chemistry" ||
                activeTab === "biology" || activeTab === "astronomy") &&
                `Top ${activeTab} learners`}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <ScrollArea className="h-[600px]">
              <div className="space-y-2 pr-4">
                {filteredLeaderboard.length === 0 ? (
                  <div className="text-center py-12 text-muted-foreground">
                    No learners yet. Be the first!
                  </div>
                ) : (
                  filteredLeaderboard.map((entry) => {
                    const isCurrentUser = user && entry.user_id === user.id;
                    return (
                      <div
                        key={entry.user_id}
                        className={`flex items-center gap-4 p-4 rounded-lg transition-colors ${
                          isCurrentUser
                            ? "bg-primary/10 border-2 border-primary"
                            : "hover:bg-muted/50"
                        }`}
                      >
                        <div className="flex items-center justify-center w-12">
                          {getRankIcon(entry.rank_num)}
                        </div>

                        <Avatar className="h-12 w-12">
                          <AvatarFallback
                            className={isCurrentUser ? "bg-primary text-primary-foreground" : ""}
                          >
                            {getInitials(entry)}
                          </AvatarFallback>
                        </Avatar>

                        <div className="flex-1 min-w-0">
                          <div className="font-semibold truncate">
                            {getDisplayName(entry)}
                            {isCurrentUser && (
                              <Badge variant="default" className="ml-2">
                                You
                              </Badge>
                            )}
                          </div>
                          <div className="text-sm text-muted-foreground">
                            {entry.level !== undefined && `Level ${entry.level}`}
                            {entry.streak_count !== undefined && entry.streak_count > 0 && (
                              <span className="ml-2 flex items-center gap-1">
                                <Flame className="h-3 w-3" />
                                {entry.streak_count} day streak
                              </span>
                            )}
                          </div>
                        </div>

                        <div className="text-right">
                          <div className="text-2xl font-bold">
                            {activeTab === "all_time" && entry.xp_points}
                            {activeTab === "weekly" && entry.xp_earned_week}
                            {activeTab === "monthly" && entry.xp_earned_month}
                            {activeTab === "streaks" && `${entry.streak_count} 🔥`}
                            {activeTab === "challenges" && entry.challenges_completed}
                            {(activeTab === "physics" || activeTab === "chemistry" ||
                              activeTab === "biology" || activeTab === "astronomy") &&
                              entry.correct_answers}
                          </div>
                          <div className="text-sm text-muted-foreground">
                            {activeTab === "all_time" && "XP"}
                            {activeTab === "weekly" && "XP this week"}
                            {activeTab === "monthly" && "XP this month"}
                            {activeTab === "challenges" &&
                              entry.challenges_success_rate &&
                              `${entry.challenges_success_rate}% success rate`}
                            {(activeTab === "physics" || activeTab === "chemistry" ||
                              activeTab === "biology" || activeTab === "astronomy") &&
                              "correct answers"}
                          </div>
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            </ScrollArea>
          </CardContent>
        </Card>

        {/* User's position at bottom if not in top 100 */}
        {user && userRank && userRank > 100 && userProfile && userProfile.show_in_leaderboard && (
          <Card className="border-yellow-500 bg-yellow-500/5">
            <CardHeader>
              <CardTitle className="text-sm">Your Rank</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex items-center gap-4">
                <div className="text-2xl font-bold">#{userRank}</div>
                <Avatar className="h-10 w-10">
                  <AvatarFallback>{getInitials(userProfile, user?.email)}</AvatarFallback>
                </Avatar>
                <div className="flex-1">
                  <div className="font-semibold">{getDisplayName(userProfile, user?.email)}</div>
                </div>
              </div>
            </CardContent>
          </Card>
        )}
      </Tabs>
    </div>
  );
}
