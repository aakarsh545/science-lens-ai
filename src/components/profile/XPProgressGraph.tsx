import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Area, AreaChart } from "recharts";
import { TrendingUp, Calendar } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";

interface XPProgressGraphProps {
  userId: string;
}

interface DailyXP {
  date: string;
  xp: number;
  levelUp?: boolean;
}

export default function XPProgressGraph({ userId }: XPProgressGraphProps) {
  const [data, setData] = useState<DailyXP[]>([]);
  const [loading, setLoading] = useState(true);
  const [timeRange, setTimeRange] = useState<"7d" | "30d" | "all">("30d");

  useEffect(() => {
    loadXPData();
  }, [userId, timeRange]);

  const loadXPData = async () => {
    try {
      setLoading(true);

      let startDate = new Date();
      if (timeRange === "7d") {
        startDate.setDate(startDate.getDate() - 7);
      } else if (timeRange === "30d") {
        startDate.setDate(startDate.getDate() - 30);
      } else {
        startDate.setFullYear(startDate.getFullYear() - 1);
      }

      const { data: activityData, error } = await supabase
        .from("study_sessions")
        .select("*")
        .eq("user_id", userId)
        .gte("started_at", startDate.toISOString())
        .order("started_at", { ascending: true });

      if (error) throw error;

      // Aggregate XP by date
      const xpByDate: { [key: string]: number } = {};
      const levelUpDates: Set<string> = new Set();

      activityData?.forEach((activity: any) => {
        const date = new Date(activity.started_at).toLocaleDateString("en-US", {
          month: "short",
          day: "numeric",
        });

        if (!xpByDate[date]) {
          xpByDate[date] = 0;
        }

        xpByDate[date] += activity.xp_earned || 0;
      });

      // Convert to array and sort
      const chartData: DailyXP[] = Object.entries(xpByDate).map(([date, xp]) => ({
        date,
        xp,
        levelUp: levelUpDates.has(date),
      }));

      setData(chartData);
      setLoading(false);
    } catch (error) {
      console.error("Error loading XP data:", error);
      setLoading(false);
    }
  };

  const totalXP = data.reduce((sum, day) => sum + day.xp, 0);
  const averageXP = data.length > 0 ? Math.round(totalXP / data.length) : 0;

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5 text-primary" />
              XP Progress
            </CardTitle>
            <CardDescription>Your learning activity over time</CardDescription>
          </div>
          <Select value={timeRange} onValueChange={(value) => setTimeRange(value as "7d" | "30d" | "all")}>
            <SelectTrigger className="w-[120px]">
              <Calendar className="h-4 w-4 mr-2" />
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="7d">Last 7 days</SelectItem>
              <SelectItem value="30d">Last 30 days</SelectItem>
              <SelectItem value="all">All time</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </CardHeader>
      <CardContent>
        {loading ? (
          <Skeleton className="h-[250px] w-full" />
        ) : data.length === 0 ? (
          <div className="h-[250px] flex items-center justify-center text-muted-foreground">
            <p>No activity data yet. Start learning to track your progress!</p>
          </div>
        ) : (
          <>
            <div className="flex gap-4 mb-4">
              <div>
                <p className="text-sm text-muted-foreground">Total XP</p>
                <p className="text-2xl font-bold">{totalXP}</p>
              </div>
              <div>
                <p className="text-sm text-muted-foreground">Average/Day</p>
                <p className="text-2xl font-bold">{averageXP}</p>
              </div>
            </div>
            <ResponsiveContainer width="100%" height={250}>
              <AreaChart data={data}>
                <defs>
                  <linearGradient id="xpGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="hsl(var(--primary))" stopOpacity={0.3}/>
                    <stop offset="95%" stopColor="hsl(var(--primary))" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                <XAxis
                  dataKey="date"
                  className="text-xs"
                  stroke="hsl(var(--muted-foreground))"
                />
                <YAxis
                  className="text-xs"
                  stroke="hsl(var(--muted-foreground))"
                />
                <Tooltip
                  contentStyle={{
                    backgroundColor: "hsl(var(--card))",
                    border: "1px solid hsl(var(--border))",
                    borderRadius: "8px",
                  }}
                  formatter={(value: number) => [`${value} XP`, "Earned"]}
                />
                <Area
                  type="monotone"
                  dataKey="xp"
                  stroke="hsl(var(--primary))"
                  strokeWidth={2}
                  fillOpacity={1}
                  fill="url(#xpGradient)"
                />
              </AreaChart>
            </ResponsiveContainer>
          </>
        )}
      </CardContent>
    </Card>
  );
}
