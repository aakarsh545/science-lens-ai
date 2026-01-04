import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from "recharts";
import { BookOpen, TrendingUp } from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";
import { useNavigate } from "react-router-dom";

interface SubjectPerformance {
  category: string;
  completionPercentage: number;
  correctAnswers: number;
  questionsAnswered: number;
  accuracy: number;
  topicsCount: number;
}

interface PerformanceBySubjectProps {
  userId: string;
}

export default function PerformanceBySubject({ userId }: PerformanceBySubjectProps) {
  const [data, setData] = useState<SubjectPerformance[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    loadPerformanceData();
  }, [userId]);

  const loadPerformanceData = async () => {
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

      // Group by category and aggregate
      const performanceByCategory: { [key: string]: SubjectPerformance } = {};

      topicProgress?.forEach((item) => {
        const category = item.learning_topics?.category || "General";
        const completion = item.completion_percentage || 0;
        const correct = item.correct_answers || 0;
        const totalQuestions = item.questions_answered || 0;

        if (!performanceByCategory[category]) {
          performanceByCategory[category] = {
            category,
            completionPercentage: 0,
            correctAnswers: 0,
            questionsAnswered: 0,
            accuracy: 0,
            topicsCount: 0,
          };
        }

        performanceByCategory[category].completionPercentage += completion;
        performanceByCategory[category].correctAnswers += correct;
        performanceByCategory[category].questionsAnswered += totalQuestions;
        performanceByCategory[category].topicsCount += 1;
      });

      // Calculate averages
      const chartData: SubjectPerformance[] = Object.values(performanceByCategory).map((item) => ({
        ...item,
        completionPercentage: Math.round(item.completionPercentage / item.topicsCount),
        accuracy: item.questionsAnswered > 0
          ? Math.round((item.correctAnswers / item.questionsAnswered) * 100)
          : 0,
      }));

      setData(chartData);
      setLoading(false);
    } catch (error) {
      console.error("Error loading performance data:", error);
      setLoading(false);
    }
  };

  const getAccuracyColor = (accuracy: number) => {
    if (accuracy >= 80) return "text-green-500";
    if (accuracy >= 60) return "text-yellow-500";
    return "text-red-500";
  };

  const getBarColor = (completion: number) => {
    if (completion >= 80) return "#22c55e";
    if (completion >= 60) return "#eab308";
    if (completion >= 40) return "#f97316";
    return "#ef4444";
  };

  if (loading) {
    return (
      <Card className="card-cosmic">
        <CardHeader>
          <CardTitle>Performance by Subject</CardTitle>
          <CardDescription>Your progress across different subjects</CardDescription>
        </CardHeader>
        <CardContent>
          <Skeleton className="h-[200px] w-full" />
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <BookOpen className="h-5 w-5 text-primary" />
          Performance by Subject
        </CardTitle>
        <CardDescription>Your completion rate and accuracy by category</CardDescription>
      </CardHeader>
      <CardContent>
        {data.length === 0 ? (
          <div className="text-center py-8 text-muted-foreground">
            <BookOpen className="h-12 w-12 mx-auto mb-3 opacity-50" />
            <p>No performance data yet. Start learning to track your progress!</p>
          </div>
        ) : (
          <>
            {/* Bar Chart */}
            <div className="mb-6">
              <ResponsiveContainer width="100%" height={200}>
                <BarChart data={data}>
                  <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                  <XAxis
                    dataKey="category"
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
                    formatter={(value: number) => [`${value}%`, "Completion"]}
                  />
                  <Bar dataKey="completionPercentage" radius={[8, 8, 0, 0]}>
                    {data.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={getBarColor(entry.completionPercentage)} />
                    ))}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </div>

            {/* Progress Bars */}
            <div className="space-y-4">
              {data.map((subject) => (
                <div key={subject.category} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <span className="font-semibold">{subject.category}</span>
                      <span className="text-xs text-muted-foreground">
                        ({subject.topicsCount} topic{subject.topicsCount !== 1 ? "s" : ""})
                      </span>
                    </div>
                    <Button
                      variant="ghost"
                      size="sm"
                      className="h-6 text-xs"
                      onClick={() => navigate("/science-lens/learning")}
                    >
                      View
                    </Button>
                  </div>
                  <div className="space-y-1">
                    <div className="flex items-center justify-between text-xs">
                      <span className="text-muted-foreground">Completion</span>
                      <span className="font-semibold">{subject.completionPercentage}%</span>
                    </div>
                    <Progress value={subject.completionPercentage} className="h-2" />
                  </div>
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground">Accuracy</span>
                    <span className={`font-semibold ${getAccuracyColor(subject.accuracy)}`}>
                      {subject.accuracy}%
                    </span>
                  </div>
                  <div className="flex items-center justify-between text-xs text-muted-foreground">
                    <span>{subject.correctAnswers} correct</span>
                    <span>of {subject.questionsAnswered} questions</span>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </CardContent>
    </Card>
  );
}
