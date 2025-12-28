import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar, ResponsiveContainer, Legend } from "recharts";
import { Target } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";

interface TopicMasteryRadarProps {
  userId: string;
}

interface TopicMastery {
  subject: string;
  mastery: number;
  fullMark: number;
}

export default function TopicMasteryRadar({ userId }: TopicMasteryRadarProps) {
  const [data, setData] = useState<TopicMastery[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadTopicMastery();
  }, [userId]);

  const loadTopicMastery = async () => {
    try {
      setLoading(true);

      const { data: topicProgress, error } = await supabase
        .from("user_topic_progress")
        .select(`
          *,
          learning_topics (
            name,
            category
          )
        `)
        .eq("user_id", userId);

      if (error) throw error;

      // Group by category and calculate mastery
      const masteryByCategory: { [key: string]: { total: number; count: number } } = {};

      topicProgress?.forEach((item: any) => {
        const category = item.learning_topics?.category || "General";
        const completion = item.completion_percentage || 0;

        if (!masteryByCategory[category]) {
          masteryByCategory[category] = { total: 0, count: 0 };
        }

        masteryByCategory[category].total += completion;
        masteryByCategory[category].count += 1;
      });

      // Convert to radar chart format
      const chartData: TopicMastery[] = Object.entries(masteryByCategory).map(([category, stats]) => ({
        subject: category,
        mastery: Math.round(stats.total / stats.count),
        fullMark: 100,
      }));

      // Add default categories if none exist
      if (chartData.length === 0) {
        chartData.push(
          { subject: "Physics", mastery: 0, fullMark: 100 },
          { subject: "Chemistry", mastery: 0, fullMark: 100 },
          { subject: "Biology", mastery: 0, fullMark: 100 },
          { subject: "Astronomy", mastery: 0, fullMark: 100 }
        );
      }

      setData(chartData);
      setLoading(false);
    } catch (error) {
      console.error("Error loading topic mastery:", error);
      setLoading(false);
    }
  };

  const averageMastery = data.length > 0
    ? Math.round(data.reduce((sum, item) => sum + item.mastery, 0) / data.length)
    : 0;

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Target className="h-5 w-5 text-primary" />
          Topic Mastery
        </CardTitle>
        <CardDescription>
          Your strengths across different subjects
        </CardDescription>
      </CardHeader>
      <CardContent>
        {loading ? (
          <Skeleton className="h-[300px] w-full" />
        ) : (
          <>
            <div className="mb-4">
              <p className="text-sm text-muted-foreground">Average Mastery</p>
              <p className="text-2xl font-bold">{averageMastery}%</p>
            </div>
            <ResponsiveContainer width="100%" height={300}>
              <RadarChart data={data}>
                <PolarGrid stroke="hsl(var(--border))" />
                <PolarAngleAxis
                  dataKey="subject"
                  className="text-xs"
                  stroke="hsl(var(--muted-foreground))"
                />
                <PolarRadiusAxis
                  angle={90}
                  domain={[0, 100]}
                  className="text-xs"
                  stroke="hsl(var(--muted-foreground))"
                />
                <Radar
                  name="Mastery"
                  dataKey="mastery"
                  stroke="hsl(var(--primary))"
                  fill="hsl(var(--primary))"
                  fillOpacity={0.3}
                  strokeWidth={2}
                />
              </RadarChart>
            </ResponsiveContainer>
          </>
        )}
      </CardContent>
    </Card>
  );
}
