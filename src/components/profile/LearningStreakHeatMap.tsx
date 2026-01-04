import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Flame } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";

interface LearningStreakHeatMapProps {
  userId: string;
}

interface DayActivity {
  date: string;
  count: number;
  level: number;
}

export default function LearningStreakHeatMap({ userId }: LearningStreakHeatMapProps) {
  const [activityData, setActivityData] = useState<DayActivity[]>([]);
  const [loading, setLoading] = useState(true);
  const [tooltipContent, setTooltipContent] = useState<string>("");

  useEffect(() => {
    loadActivityData();
  }, [userId]);

  const loadActivityData = async () => {
    try {
      setLoading(true);

      // Get activity from last 365 days
      const startDate = new Date();
      startDate.setFullYear(startDate.getFullYear() - 1);

      const { data: activities, error } = await supabase
        .from("activity_log")
        .select("*")
        .eq("user_id", userId)
        .gte("created_at", startDate.toISOString())
        .order("created_at", { ascending: true });

      if (error) throw error;

      // Aggregate by date
      const activityByDate: { [key: string]: number } = {};
      activities?.forEach((activity) => {
        const date = new Date(activity.created_at).toISOString().split("T")[0];
        if (!activityByDate[date]) {
          activityByDate[date] = 0;
        }
        activityByDate[date]++;
      });

      // Generate last 52 weeks of data
      const data: DayActivity[] = [];
      const today = new Date();

      for (let i = 364; i >= 0; i--) {
        const date = new Date(today);
        date.setDate(date.getDate() - i);
        const dateStr = date.toISOString().split("T")[0];
        const count = activityByDate[dateStr] || 0;

        // Calculate activity level (0-4)
        let level = 0;
        if (count >= 1) level = 1;
        if (count >= 2) level = 2;
        if (count >= 4) level = 3;
        if (count >= 6) level = 4;

        data.push({
          date: dateStr,
          count,
          level,
        });
      }

      setActivityData(data);
      setLoading(false);
    } catch (error) {
      console.error("Error loading activity data:", error);
      setLoading(false);
    }
  };

  const getLevelColor = (level: number) => {
    switch (level) {
      case 0:
        return "bg-muted/30";
      case 1:
        return "bg-green-500/30";
      case 2:
        return "bg-green-500/60";
      case 3:
        return "bg-green-500/80";
      case 4:
        return "bg-green-500";
      default:
        return "bg-muted/30";
    }
  };

  const getWeeks = () => {
    const weeks: DayActivity[][] = [];
    for (let i = 0; i < activityData.length; i += 7) {
      weeks.push(activityData.slice(i, i + 7));
    }
    return weeks;
  };

  const totalActivityDays = activityData.filter((d) => d.count > 0).length;
  const mostActiveDay = activityData.reduce((max, day) => (day.count > max.count ? day : max), { count: 0, date: "", level: 0 });

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Flame className="h-5 w-5 text-orange-500" />
          Learning Activity
        </CardTitle>
        <CardDescription>Your learning activity over the last year</CardDescription>
      </CardHeader>
      <CardContent>
        {loading ? (
          <Skeleton className="h-[150px] w-full" />
        ) : (
          <>
            <div className="flex gap-6 mb-4">
              <div>
                <p className="text-sm text-muted-foreground">Active Days</p>
                <p className="text-2xl font-bold">{totalActivityDays}</p>
              </div>
              <div>
                <p className="text-sm text-muted-foreground">Most Active</p>
                <p className="text-2xl font-bold">{mostActiveDay.count} activities</p>
              </div>
            </div>

            <TooltipProvider>
              <div className="overflow-x-auto">
                <div className="flex gap-1 min-w-max">
                  {getWeeks().map((week, weekIndex) => (
                    <div key={weekIndex} className="flex flex-col gap-1">
                      {week.map((day) => (
                        <Tooltip key={day.date}>
                          <TooltipTrigger>
                            <div
                              className={`w-3 h-3 rounded-sm ${getLevelColor(day.level)} hover:ring-2 hover:ring-primary transition-all cursor-pointer`}
                              onMouseEnter={() => {
                                const date = new Date(day.date);
                                setTooltipContent(
                                  `${day.count} ${day.count === 1 ? "activity" : "activities"} on ${date.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}`
                                );
                              }}
                            />
                          </TooltipTrigger>
                          <TooltipContent>
                            <p>{tooltipContent}</p>
                          </TooltipContent>
                        </Tooltip>
                      ))}
                    </div>
                  ))}
                </div>
              </div>
            </TooltipProvider>

            <div className="flex items-center gap-2 mt-4 text-xs text-muted-foreground">
              <span>Less</span>
              <div className="flex gap-1">
                {[0, 1, 2, 3, 4].map((level) => (
                  <div key={level} className={`w-3 h-3 rounded-sm ${getLevelColor(level)}`} />
                ))}
              </div>
              <span>More</span>
            </div>
          </>
        )}
      </CardContent>
    </Card>
  );
}
