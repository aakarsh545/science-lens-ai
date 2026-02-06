import { useEffect, useState, useCallback } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, Trophy, Medal, Award, Flame, Target, Atom, Beaker, Leaf, Star } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { ScrollArea } from "@/components/ui/scroll-area";
import { SearchPeople } from "@/components/SearchPeople";

interface LeaderboardEntry {
  user_id: string;
  display_name: string | null;
  avatar_url: string | null;
  rank_num: number;
  xp_points?: number;
  level?: number;
  streak_count?: number;
}

export default function LeaderboardPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
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
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const getDisplayName = (entry: LeaderboardEntry | null, userEmail?: string) => {
    if (!entry) return "Anonymous";
    return entry.display_name || userEmail?.split("@")[0] || "Anonymous";
  };

  const loadLeaderboard = useCallback(async () => {
    setLoading(true);

    // Use profiles table directly since leaderboard views don't exist
    const { data, error } = await supabase
      .from('profiles')
      .select('user_id, display_name, avatar_url, xp_points, level, streak_count')
      .order('xp_points', { ascending: false })
      .limit(100);

    if (error) {
      console.error("Error loading leaderboard:", error);
    } else if (data) {
      const entries: LeaderboardEntry[] = data.map((entry, index) => ({
        user_id: entry.user_id,
        display_name: entry.display_name,
        avatar_url: entry.avatar_url,
        xp_points: entry.xp_points ?? 0,
        level: entry.level ?? 1,
        streak_count: entry.streak_count ?? 0,
        rank_num: index + 1,
      }));
      setLeaderboard(entries);
    }

    setLoading(false);
  }, []);

  useEffect(() => {
    if (user) {
      loadLeaderboard();
    }
  }, [user, activeTab, loadLeaderboard]);

  const getRankIcon = (rank: number) => {
    if (rank === 1) return <Medal className="h-6 w-6 text-yellow-500" />;
    if (rank === 2) return <Medal className="h-6 w-6 text-gray-400" />;
    if (rank === 3) return <Medal className="h-6 w-6 text-amber-700" />;
    return <span className="text-lg font-bold text-muted-foreground">#{rank}</span>;
  };

  const getInitials = (entry: LeaderboardEntry | null, userEmail?: string) => {
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

      <SearchPeople />

      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
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
              onClick={() => loadLeaderboard()}
            >
              <Loader2 className={`h-4 w-4 ${loading ? "animate-spin" : ""}`} />
            </Button>
          </div>
        </div>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Trophy className="h-5 w-5" />
              All-Time Leaderboard
            </CardTitle>
            <CardDescription>Top learners by total XP earned</CardDescription>
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
                          <div className="text-sm text-muted-foreground flex items-center gap-2">
                            {entry.level !== undefined && `Level ${entry.level}`}
                            {entry.streak_count !== undefined && entry.streak_count > 0 && (
                              <span className="flex items-center gap-1">
                                <Flame className="h-3 w-3" />
                                {entry.streak_count} day streak
                              </span>
                            )}
                          </div>
                        </div>

                        <div className="text-right">
                          <div className="text-2xl font-bold">
                            {entry.xp_points}
                          </div>
                          <div className="text-sm text-muted-foreground">XP</div>
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            </ScrollArea>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
