import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { 
  TrendingUp, 
  BookOpen, 
  Target, 
  Flame, 
  Award, 
  Clock,
  CheckCircle2,
  BarChart3
} from "lucide-react";

interface ProgressStats {
  totalLessonsCompleted: number;
  totalLessons: number;
  totalXpEarned: number;
  currentStreak: number;
  longestStreak: number;
  coursesStarted: number;
  coursesCompleted: number;
  totalCourses: number;
  recentLessons: { title: string; courseName: string; completedAt: string }[];
  categoryProgress: { category: string; completed: number; total: number }[];
}

interface ProgressDashboardProps {
  userId: string;
}

export function ProgressDashboard({ userId }: ProgressDashboardProps) {
  const [stats, setStats] = useState<ProgressStats | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadStats();
  }, [userId]);

  const loadStats = async () => {
    try {
      // Get user profile for streak and XP
      const { data: profile } = await supabase
        .from("profiles")
        .select("streak_count, xp_points, level")
        .eq("user_id", userId)
        .single();

      // Get all courses with categories
      const { data: courses } = await supabase
        .from("courses")
        .select("id, title, category");

      // Get all lessons
      const { data: lessons } = await supabase
        .from("lessons")
        .select("id, course_id, title");

      // Get user progress
      const { data: progress } = await supabase
        .from("user_progress")
        .select("lesson_id, status, xp_earned, last_practiced")
        .eq("user_id", userId)
        .order("last_practiced", { ascending: false });

      if (courses && lessons && progress) {
        const completedLessonIds = new Set(
          progress.filter((p) => p.status === "completed").map((p) => p.lesson_id)
        );

        // Calculate category progress
        const categoryMap: Record<string, { completed: number; total: number }> = {};
        
        courses.forEach((course) => {
          const courseLessons = lessons.filter((l) => l.course_id === course.id);
          const completedCount = courseLessons.filter((l) => 
            completedLessonIds.has(l.id)
          ).length;

          if (!categoryMap[course.category]) {
            categoryMap[course.category] = { completed: 0, total: 0 };
          }
          categoryMap[course.category].completed += completedCount;
          categoryMap[course.category].total += courseLessons.length;
        });

        // Calculate courses completed
        const coursesWithProgress = courses.map((course) => {
          const courseLessons = lessons.filter((l) => l.course_id === course.id);
          const completedCount = courseLessons.filter((l) =>
            completedLessonIds.has(l.id)
          ).length;
          return {
            ...course,
            completed: completedCount,
            total: courseLessons.length,
            isComplete: completedCount === courseLessons.length && courseLessons.length > 0,
            isStarted: completedCount > 0,
          };
        });

        // Get recent lessons with course names
        const recentProgress = progress
          .filter((p) => p.status === "completed" && p.last_practiced)
          .slice(0, 5);

        const recentLessons = recentProgress.map((p) => {
          const lesson = lessons.find((l) => l.id === p.lesson_id);
          const course = courses.find((c) => c.id === lesson?.course_id);
          return {
            title: lesson?.title || "Unknown Lesson",
            courseName: course?.title || "Unknown Course",
            completedAt: p.last_practiced || "",
          };
        });

        setStats({
          totalLessonsCompleted: completedLessonIds.size,
          totalLessons: lessons.length,
          totalXpEarned: profile?.xp_points || 0,
          currentStreak: profile?.streak_count || 0,
          longestStreak: profile?.streak_count || 0,
          coursesStarted: coursesWithProgress.filter((c) => c.isStarted).length,
          coursesCompleted: coursesWithProgress.filter((c) => c.isComplete).length,
          totalCourses: courses.length,
          recentLessons,
          categoryProgress: Object.entries(categoryMap).map(([category, data]) => ({
            category,
            ...data,
          })),
        });
      }
    } catch (error) {
      console.error("Error loading progress stats:", error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <Card className="animate-pulse">
        <CardHeader>
          <div className="h-6 bg-muted rounded w-1/3" />
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="h-24 bg-muted rounded" />
          <div className="h-24 bg-muted rounded" />
        </CardContent>
      </Card>
    );
  }

  if (!stats) return null;

  const overallProgress = stats.totalLessons > 0 
    ? Math.round((stats.totalLessonsCompleted / stats.totalLessons) * 100) 
    : 0;

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold">Learning Progress</h2>
        <p className="text-muted-foreground">Track your journey across all courses</p>
      </div>

      {/* Main Stats Grid */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Lessons Completed</CardTitle>
            <CheckCircle2 className="h-4 w-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalLessonsCompleted}</div>
            <p className="text-xs text-muted-foreground">
              of {stats.totalLessons} total lessons
            </p>
            <Progress value={overallProgress} className="mt-2 h-2" />
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total XP Earned</CardTitle>
            <Target className="h-4 w-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalXpEarned.toLocaleString()}</div>
            <p className="text-xs text-muted-foreground">
              Science points earned
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Current Streak</CardTitle>
            <Flame className="h-4 w-4 text-orange-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.currentStreak} days</div>
            <p className="text-xs text-muted-foreground">
              Keep learning daily!
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Courses Progress</CardTitle>
            <BookOpen className="h-4 w-4 text-primary" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {stats.coursesCompleted}/{stats.totalCourses}
            </div>
            <p className="text-xs text-muted-foreground">
              {stats.coursesStarted} courses in progress
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Category Progress */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <BarChart3 className="h-5 w-5" />
            Progress by Category
          </CardTitle>
          <CardDescription>Your completion rate across different science fields</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {stats.categoryProgress.map((cat) => {
              const percentage = cat.total > 0 
                ? Math.round((cat.completed / cat.total) * 100) 
                : 0;
              
              return (
                <div key={cat.category} className="space-y-2">
                  <div className="flex items-center justify-between text-sm">
                    <span className="font-medium">{cat.category}</span>
                    <span className="text-muted-foreground">
                      {cat.completed}/{cat.total} lessons ({percentage}%)
                    </span>
                  </div>
                  <Progress value={percentage} className="h-2" />
                </div>
              );
            })}
          </div>
        </CardContent>
      </Card>

      {/* Recent Activity */}
      {stats.recentLessons.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Clock className="h-5 w-5" />
              Recent Activity
            </CardTitle>
            <CardDescription>Your recently completed lessons</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {stats.recentLessons.map((lesson, index) => (
                <div
                  key={index}
                  className="flex items-center justify-between p-3 rounded-lg bg-muted/50"
                >
                  <div>
                    <p className="font-medium">{lesson.title}</p>
                    <p className="text-sm text-muted-foreground">{lesson.courseName}</p>
                  </div>
                  <Badge variant="secondary">
                    {new Date(lesson.completedAt).toLocaleDateString()}
                  </Badge>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
