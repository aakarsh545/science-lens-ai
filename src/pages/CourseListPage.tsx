import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { BookOpen, Users, ArrowRight, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  lesson_count: number;
}

interface CourseProgress {
  completed: number;
  total: number;
  percentage: number;
}

export default function CourseListPage() {
  const [courses, setCourses] = useState<Course[]>([]);
  const [progress, setProgress] = useState<Record<string, CourseProgress>>({});
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const initPage = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) {
        setUserId(session.user.id);
        await Promise.all([loadCourses(), loadProgress(session.user.id)]);
      }
      setLoading(false);
    };
    initPage();
  }, []);

  const loadCourses = async () => {
    const { data, error } = await supabase.functions.invoke('courses');
    if (!error && data) {
      setCourses(data);
    }
  };

  const loadProgress = async (uid: string) => {
    // Get all user progress
    const { data: progressData } = await supabase
      .from('user_progress')
      .select('lesson_id, status')
      .eq('user_id', uid);

    // Get all lessons grouped by course
    const { data: lessonsData } = await supabase
      .from('lessons')
      .select('id, course_id');

    if (lessonsData && progressData) {
      const progressMap: Record<string, CourseProgress> = {};
      
      // Group lessons by course
      const lessonsByCourse = lessonsData.reduce((acc, lesson) => {
        if (!acc[lesson.course_id]) acc[lesson.course_id] = [];
        acc[lesson.course_id].push(lesson.id);
        return acc;
      }, {} as Record<string, string[]>);

      // Calculate progress for each course
      Object.entries(lessonsByCourse).forEach(([courseId, lessonIds]) => {
        const completed = lessonIds.filter(lid => 
          progressData.some(p => p.lesson_id === lid && p.status === 'completed')
        ).length;
        
        progressMap[courseId] = {
          completed,
          total: lessonIds.length,
          percentage: lessonIds.length > 0 ? Math.round((completed / lessonIds.length) * 100) : 0
        };
      });

      setProgress(progressMap);
    }
  };

  const groupedCourses = courses.reduce((acc, course) => {
    if (!acc[course.category]) acc[course.category] = [];
    acc[course.category].push(course);
    return acc;
  }, {} as Record<string, Course[]>);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 space-y-8">
      <div className="space-y-2">
        <h1 className="text-4xl font-bold">Science Courses</h1>
        <p className="text-muted-foreground">
          Explore our comprehensive collection of science courses and start learning today
        </p>
      </div>

      {Object.entries(groupedCourses).map(([category, categoryCourses]) => (
        <div key={category} className="space-y-4">
          <div className="flex items-center gap-2">
            <h2 className="text-2xl font-semibold capitalize">{category}</h2>
            <Badge variant="secondary">{categoryCourses.length} courses</Badge>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {categoryCourses.map((course) => {
              const courseProgress = progress[course.id] || { completed: 0, total: 0, percentage: 0 };
              const isStarted = courseProgress.completed > 0;

              return (
                <Card 
                  key={course.id} 
                  className="hover:shadow-lg transition-all cursor-pointer group"
                  onClick={() => navigate(`/learn/${course.slug}`)}
                >
                  <CardHeader>
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <CardTitle className="group-hover:text-primary transition-colors">
                          {course.title}
                        </CardTitle>
                        <CardDescription className="mt-2">
                          {course.description}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  
                  <CardContent className="space-y-4">
                    <div className="flex items-center gap-4 text-sm text-muted-foreground">
                      <div className="flex items-center gap-1">
                        <BookOpen className="w-4 h-4" />
                        <span>{course.lesson_count} lessons</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Users className="w-4 h-4" />
                        <span>
                          {isStarted 
                            ? `${courseProgress.completed}/${courseProgress.total} completed` 
                            : 'Not started'}
                        </span>
                      </div>
                    </div>

                    {isStarted && (
                      <div className="space-y-2">
                        <div className="flex items-center justify-between text-xs">
                          <span className="text-muted-foreground">Progress</span>
                          <span className="font-medium">{courseProgress.percentage}%</span>
                        </div>
                        <Progress value={courseProgress.percentage} className="h-2" />
                      </div>
                    )}

                    <Button 
                      className="w-full group-hover:bg-primary group-hover:text-primary-foreground transition-colors"
                      variant={isStarted ? "default" : "outline"}
                    >
                      {isStarted ? "Continue Learning" : "Start Course"}
                      <ArrowRight className="w-4 h-4 ml-2" />
                    </Button>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </div>
      ))}

      {courses.length === 0 && (
        <Card className="p-12">
          <div className="text-center space-y-2">
            <BookOpen className="w-12 h-12 mx-auto text-muted-foreground" />
            <h3 className="text-xl font-semibold">No Courses Available</h3>
            <p className="text-muted-foreground">
              Check back soon for new courses!
            </p>
          </div>
        </Card>
      )}
    </div>
  );
}
