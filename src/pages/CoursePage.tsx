import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { BookOpen, Clock, Award, Loader2, Lock, CheckCircle2, ArrowLeft } from "lucide-react";

interface Lesson {
  id: string;
  slug: string;
  title: string;
  order_index: number;
  xp_reward: number;
}

interface Course {
  id: string;
  title: string;
  description: string;
  category: string;
  lessons: Lesson[];
}

interface UserProgress {
  lesson_id: string;
  status: string;
}

export default function CoursePage() {
  const { courseSlug } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState<Course | null>(null);
  const [progress, setProgress] = useState<UserProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);

  useEffect(() => {
    const init = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) {
        setUserId(session.user.id);
        await loadCourse();
        await loadProgress(session.user.id);
      } else {
        await loadCourse();
      }
      setLoading(false);
    };
    init();
  }, [courseSlug]);

  const loadCourse = async () => {
    const { data, error } = await supabase.functions.invoke('courses', {
      body: { slug: courseSlug }
    });
    
    if (!error && data) {
      setCourse(data);
    }
  };

  const loadProgress = async (uid: string) => {
    if (!course?.id) return;

    const { data } = await supabase
      .from('user_progress')
      .select('lesson_id, status')
      .eq('user_id', uid);

    if (data) {
      setProgress(data);
    }
  };

  const getLessonStatus = (lessonId: string) => {
    const lessonProgress = progress.find(p => p.lesson_id === lessonId);
    return lessonProgress?.status || 'not_started';
  };

  const isLessonUnlocked = (lessonIndex: number) => {
    if (lessonIndex === 0) return true; // First lesson always unlocked
    if (!userId) return false; // Must be logged in for other lessons
    
    // Check if previous lesson is completed
    const prevLesson = course?.lessons[lessonIndex - 1];
    if (!prevLesson) return false;
    
    return getLessonStatus(prevLesson.id) === 'completed';
  };

  const handleLessonClick = (lesson: Lesson, index: number) => {
    if (!isLessonUnlocked(index) && userId) {
      return; // Lesson locked
    }
    navigate(`/learn/${courseSlug}/${lesson.slug}`);
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!course) {
    return (
      <div className="container mx-auto p-6">
        <Card className="p-12">
          <div className="text-center space-y-2">
            <BookOpen className="w-12 h-12 mx-auto text-muted-foreground" />
            <h3 className="text-xl font-semibold">Course Not Found</h3>
            <p className="text-muted-foreground">The course you're looking for doesn't exist.</p>
            <Button onClick={() => navigate('/learning')} className="mt-4">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Courses
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const completedLessons = course.lessons.filter(l => getLessonStatus(l.id) === 'completed').length;
  const progressPercentage = course.lessons.length > 0 
    ? Math.round((completedLessons / course.lessons.length) * 100) 
    : 0;

  return (
    <div className="container mx-auto p-6 max-w-4xl space-y-6">
      <Button 
        variant="ghost" 
        onClick={() => navigate('/learning')}
        className="mb-4"
      >
        <ArrowLeft className="w-4 h-4 mr-2" />
        Back to Courses
      </Button>

      {/* Course Header */}
      <Card className="card-cosmic">
        <CardHeader>
          <div className="flex items-start justify-between">
            <div className="flex-1 space-y-2">
              <Badge variant="secondary" className="mb-2">{course.category}</Badge>
              <CardTitle className="text-3xl">{course.title}</CardTitle>
              <CardDescription className="text-base">
                {course.description}
              </CardDescription>
            </div>
          </div>
        </CardHeader>

        <CardContent className="space-y-4">
          <div className="flex items-center gap-6 text-sm">
            <div className="flex items-center gap-2">
              <BookOpen className="w-4 h-4 text-primary" />
              <span>{course.lessons.length} lessons</span>
            </div>
            <div className="flex items-center gap-2">
              <Award className="w-4 h-4 text-achievement" />
              <span>{course.lessons.reduce((sum, l) => sum + (l.xp_reward || 10), 0)} XP total</span>
            </div>
            {userId && (
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-success" />
                <span>{completedLessons}/{course.lessons.length} completed ({progressPercentage}%)</span>
              </div>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Lessons List */}
      <div className="space-y-4">
        <h2 className="text-2xl font-semibold">Lessons</h2>
        
        <div className="space-y-3">
          {course.lessons
            .sort((a, b) => a.order_index - b.order_index)
            .map((lesson, index) => {
              const status = getLessonStatus(lesson.id);
              const isUnlocked = isLessonUnlocked(index);
              const isCompleted = status === 'completed';

              return (
                <Card 
                  key={lesson.id}
                  className={`
                    transition-all cursor-pointer
                    ${isUnlocked 
                      ? 'hover:shadow-lg hover:border-primary/50' 
                      : 'opacity-60 cursor-not-allowed'
                    }
                    ${isCompleted ? 'border-success/30 bg-success/5' : ''}
                  `}
                  onClick={() => handleLessonClick(lesson, index)}
                >
                  <CardContent className="p-4">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-4 flex-1">
                        <div className={`
                          w-10 h-10 rounded-full flex items-center justify-center text-sm font-semibold
                          ${isCompleted 
                            ? 'bg-success/20 text-success' 
                            : isUnlocked 
                              ? 'bg-primary/20 text-primary' 
                              : 'bg-muted text-muted-foreground'
                          }
                        `}>
                          {isCompleted ? (
                            <CheckCircle2 className="w-5 h-5" />
                          ) : isUnlocked ? (
                            index + 1
                          ) : (
                            <Lock className="w-5 h-5" />
                          )}
                        </div>

                        <div className="flex-1">
                          <h3 className="font-semibold">{lesson.title}</h3>
                          <div className="flex items-center gap-4 mt-1 text-sm text-muted-foreground">
                            <div className="flex items-center gap-1">
                              <Clock className="w-3 h-3" />
                              <span>~5 min</span>
                            </div>
                            <div className="flex items-center gap-1">
                              <Award className="w-3 h-3" />
                              <span>+{lesson.xp_reward || 10} XP</span>
                            </div>
                          </div>
                        </div>
                      </div>

                      {!isUnlocked && (
                        <Badge variant="outline" className="text-xs">
                          Complete previous lesson
                        </Badge>
                      )}
                    </div>
                  </CardContent>
                </Card>
              );
            })}
        </div>
      </div>
    </div>
  );
}
