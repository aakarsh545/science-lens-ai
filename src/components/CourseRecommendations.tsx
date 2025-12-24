import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Sparkles, ArrowRight, BookOpen, TrendingUp } from "lucide-react";

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  lessonCount: number;
}

interface Recommendation {
  course: Course;
  reason: string;
  score: number;
}

interface CourseRecommendationsProps {
  userId: string;
}

// Course relationship map - which courses are related/prerequisites
const courseRelationships: Record<string, string[]> = {
  "basic-physics": ["quantum-mechanics", "thermodynamics", "astrophysics"],
  "quantum-mechanics": ["astrophysics", "materials-science"],
  "thermodynamics": ["chemistry-basics", "environmental-science"],
  "chemistry-basics": ["organic-chemistry", "biochemistry", "materials-science"],
  "organic-chemistry": ["biochemistry", "cell-biology"],
  "biochemistry": ["cell-biology", "genetics", "neurobiology"],
  "cell-biology": ["genetics", "neurobiology", "ecology"],
  "genetics": ["cell-biology", "ecology", "neurobiology"],
  "ecology": ["environmental-science", "planetary-science"],
  "astronomy": ["astrophysics", "planetary-science"],
  "astrophysics": ["quantum-mechanics", "planetary-science"],
  "planetary-science": ["astronomy", "environmental-science"],
  "neurobiology": ["cell-biology", "genetics"],
  "robotics": ["basic-physics", "materials-science"],
  "materials-science": ["chemistry-basics", "basic-physics"],
  "environmental-science": ["ecology", "chemistry-basics"],
  "general-science": ["basic-physics", "chemistry-basics", "cell-biology"],
  "origins": ["astronomy", "cell-biology", "genetics"],
};

// Category learning paths
const categoryPaths: Record<string, string[]> = {
  Physics: ["basic-physics", "thermodynamics", "quantum-mechanics", "astrophysics"],
  Chemistry: ["chemistry-basics", "organic-chemistry", "biochemistry"],
  Biology: ["cell-biology", "genetics", "ecology", "neurobiology"],
  Astronomy: ["astronomy", "astrophysics", "planetary-science"],
  Technology: ["robotics", "materials-science"],
  "Earth Science": ["environmental-science"],
  General: ["general-science", "origins"],
};

export function CourseRecommendations({ userId }: CourseRecommendationsProps) {
  const [recommendations, setRecommendations] = useState<Recommendation[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    loadRecommendations();
  }, [userId]);

  const loadRecommendations = async () => {
    try {
      // Get all courses
      const { data: courses } = await supabase
        .from("courses")
        .select("id, slug, title, description, category");

      // Get all lessons for lesson counts
      const { data: lessons } = await supabase
        .from("lessons")
        .select("id, course_id");

      // Get user progress
      const { data: progress } = await supabase
        .from("user_progress")
        .select("lesson_id, status")
        .eq("user_id", userId);

      if (!courses || !lessons) {
        setLoading(false);
        return;
      }

      // Create course map with lesson counts
      const courseMap = courses.reduce((acc, course) => {
        const lessonCount = lessons.filter((l) => l.course_id === course.id).length;
        acc[course.slug] = { ...course, lessonCount };
        return acc;
      }, {} as Record<string, Course>);

      // Calculate course completion
      const completedLessonIds = new Set(
        progress?.filter((p) => p.status === "completed").map((p) => p.lesson_id) || []
      );

      const courseProgress = courses.map((course) => {
        const courseLessons = lessons.filter((l) => l.course_id === course.id);
        const completed = courseLessons.filter((l) => completedLessonIds.has(l.id)).length;
        return {
          slug: course.slug,
          category: course.category,
          completed,
          total: courseLessons.length,
          isComplete: completed === courseLessons.length && courseLessons.length > 0,
          isStarted: completed > 0,
          percentage: courseLessons.length > 0 ? (completed / courseLessons.length) * 100 : 0,
        };
      });

      // Find completed courses
      const completedCourses = courseProgress.filter((c) => c.isComplete).map((c) => c.slug);
      const inProgressCourses = courseProgress.filter((c) => c.isStarted && !c.isComplete);
      const notStartedCourses = courseProgress.filter((c) => !c.isStarted);

      // Generate recommendations
      const recs: Recommendation[] = [];

      // 1. Continue in-progress courses (highest priority)
      inProgressCourses
        .sort((a, b) => b.percentage - a.percentage)
        .slice(0, 2)
        .forEach((course) => {
          if (courseMap[course.slug]) {
            recs.push({
              course: courseMap[course.slug],
              reason: `Continue where you left off (${Math.round(course.percentage)}% complete)`,
              score: 100 + course.percentage,
            });
          }
        });

      // 2. Related courses based on completed courses
      completedCourses.forEach((completedSlug) => {
        const related = courseRelationships[completedSlug] || [];
        related.forEach((relatedSlug) => {
          const courseData = courseMap[relatedSlug];
          const progressData = courseProgress.find((p) => p.slug === relatedSlug);
          
          if (courseData && progressData && !progressData.isComplete && !progressData.isStarted) {
            const existing = recs.find((r) => r.course.slug === relatedSlug);
            if (!existing) {
              recs.push({
                course: courseData,
                reason: `Recommended after completing ${courseMap[completedSlug]?.title}`,
                score: 80,
              });
            }
          }
        });
      });

      // 3. Category path recommendations
      if (completedCourses.length > 0) {
        // Find user's preferred categories
        const categoryCount: Record<string, number> = {};
        completedCourses.forEach((slug) => {
          const course = courseProgress.find((c) => c.slug === slug);
          if (course) {
            categoryCount[course.category] = (categoryCount[course.category] || 0) + 1;
          }
        });

        const preferredCategory = Object.entries(categoryCount)
          .sort(([, a], [, b]) => b - a)[0]?.[0];

        if (preferredCategory && categoryPaths[preferredCategory]) {
          categoryPaths[preferredCategory].forEach((slug) => {
            const courseData = courseMap[slug];
            const progressData = courseProgress.find((p) => p.slug === slug);
            
            if (courseData && progressData && !progressData.isComplete && !progressData.isStarted) {
              const existing = recs.find((r) => r.course.slug === slug);
              if (!existing) {
                recs.push({
                  course: courseData,
                  reason: `Part of your ${preferredCategory} learning path`,
                  score: 60,
                });
              }
            }
          });
        }
      }

      // 4. Beginner recommendations for new users
      if (completedCourses.length === 0 && inProgressCourses.length === 0) {
        const beginnerCourses = ["basic-physics", "chemistry-basics", "cell-biology", "general-science"];
        beginnerCourses.forEach((slug) => {
          if (courseMap[slug]) {
            recs.push({
              course: courseMap[slug],
              reason: "Great starting point for beginners",
              score: 50,
            });
          }
        });
      }

      // Sort by score and limit
      const sortedRecs = recs
        .sort((a, b) => b.score - a.score)
        .slice(0, 4);

      setRecommendations(sortedRecs);
    } catch (error) {
      console.error("Error loading recommendations:", error);
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
        <CardContent>
          <div className="grid gap-4 md:grid-cols-2">
            {[1, 2].map((i) => (
              <div key={i} className="h-32 bg-muted rounded" />
            ))}
          </div>
        </CardContent>
      </Card>
    );
  }

  if (recommendations.length === 0) {
    return null;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Sparkles className="h-5 w-5 text-primary" />
          Recommended For You
        </CardTitle>
        <CardDescription>
          Personalized course suggestions based on your learning journey
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div className="grid gap-4 md:grid-cols-2">
          {recommendations.map((rec) => (
            <Card
              key={rec.course.id}
              className="cursor-pointer hover:shadow-md transition-all group border-muted"
              onClick={() => navigate(`/science-lens/learn/${rec.course.slug}`)}
            >
              <CardHeader className="pb-2">
                <div className="flex items-start justify-between">
                  <Badge variant="outline" className="mb-2">
                    {rec.course.category}
                  </Badge>
                  {rec.score >= 100 && (
                    <TrendingUp className="h-4 w-4 text-primary" />
                  )}
                </div>
                <CardTitle className="text-lg group-hover:text-primary transition-colors">
                  {rec.course.title}
                </CardTitle>
              </CardHeader>
              <CardContent className="pt-0">
                <p className="text-sm text-muted-foreground mb-3 line-clamp-2">
                  {rec.course.description}
                </p>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-1 text-xs text-muted-foreground">
                    <BookOpen className="h-3 w-3" />
                    <span>{rec.course.lessonCount} lessons</span>
                  </div>
                  <Button size="sm" variant="ghost" className="gap-1">
                    Start
                    <ArrowRight className="h-3 w-3" />
                  </Button>
                </div>
                <p className="text-xs text-primary mt-2 font-medium">
                  {rec.reason}
                </p>
              </CardContent>
            </Card>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}
