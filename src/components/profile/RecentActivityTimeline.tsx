import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Clock, CheckCircle, Trophy, Flame, Target, BookOpen, Zap } from "lucide-react";
import { formatDistanceToNow } from "date-fns";

interface Activity {
  id: string;
  activity_type: string;
  xp_earned: number;
  created_at: string;
  metadata?: Record<string, unknown>;
}

interface RecentActivityTimelineProps {
  activities: Activity[];
}

export default function RecentActivityTimeline({ activities }: RecentActivityTimelineProps) {
  const getActivityIcon = (type: string) => {
    switch (type) {
      case "lesson_completed":
        return <BookOpen className="h-4 w-4 text-blue-500" />;
      case "quiz_taken":
        return <CheckCircle className="h-4 w-4 text-green-500" />;
      case "challenge_completed":
        return <Trophy className="h-4 w-4 text-yellow-500" />;
      case "level_up":
        return <Zap className="h-4 w-4 text-purple-500" />;
      case "streak_milestone":
        return <Flame className="h-4 w-4 text-orange-500" />;
      case "achievement_unlocked":
        return <Target className="h-4 w-4 text-pink-500" />;
      default:
        return <Clock className="h-4 w-4 text-muted-foreground" />;
    }
  };

  const getActivityTitle = (activity: Activity) => {
    switch (activity.activity_type) {
      case "lesson_completed":
        return `Completed lesson: ${activity.metadata?.lesson_title || "Lesson"}`;
      case "quiz_taken":
        return `Completed quiz: ${activity.metadata?.quiz_score ? `${activity.metadata.quiz_score}% score` : ""}`;
      case "challenge_completed":
        return `Completed challenge: ${activity.metadata?.challenge_title || "Challenge"}`;
      case "level_up":
        return `Reached Level ${activity.metadata?.new_level || "?"}`;
      case "streak_milestone":
        return `${activity.metadata?.streak_days || "?"} day streak!`;
      case "achievement_unlocked":
        return `Unlocked: ${activity.metadata?.achievement_title || "Achievement"}`;
      default:
        return "Activity logged";
    }
  };

  const [showAll, setShowAll] = useState(false);
  const displayedActivities = showAll ? activities : activities.slice(0, 10);

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Clock className="h-5 w-5 text-primary" />
          Recent Activity
        </CardTitle>
        <CardDescription>Your latest learning activities</CardDescription>
      </CardHeader>
      <CardContent>
        {activities.length === 0 ? (
          <div className="text-center py-8 text-muted-foreground">
            <Clock className="h-12 w-12 mx-auto mb-3 opacity-50" />
            <p>No activity yet. Start learning to see your timeline!</p>
          </div>
        ) : (
          <>
            <div className="space-y-4">
              {displayedActivities.map((activity, index) => (
                <div key={activity.id} className="flex gap-4">
                  <div className="flex flex-col items-center">
                    <div className="p-2 rounded-full bg-primary/10">
                      {getActivityIcon(activity.activity_type)}
                    </div>
                    {index < displayedActivities.length - 1 && (
                      <div className="w-0.5 h-full bg-border mt-2" />
                    )}
                  </div>
                  <div className="flex-1 pb-4">
                    <p className="font-medium">{getActivityTitle(activity)}</p>
                    <div className="flex items-center gap-3 mt-1 text-sm text-muted-foreground">
                      <span>
                        {formatDistanceToNow(new Date(activity.created_at), {
                          addSuffix: true,
                        })}
                      </span>
                      {activity.xp_earned > 0 && (
                        <span className="text-primary font-semibold">+{activity.xp_earned} XP</span>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>

            {activities.length > 10 && (
              <div className="mt-4 text-center">
                <Button
                  variant="outline"
                  onClick={() => setShowAll(!showAll)}
                >
                  {showAll ? "Show Less" : `Load More (${activities.length - 10} remaining)`}
                </Button>
              </div>
            )}
          </>
        )}
      </CardContent>
    </Card>
  );
}
