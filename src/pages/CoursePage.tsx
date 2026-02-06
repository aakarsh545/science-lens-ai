import { useEffect, useState, useMemo } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import {
  BookOpen, Clock, Award, Loader2, Lock, CheckCircle2, ArrowLeft,
  ChevronDown, ChevronRight, FolderOpen, FileText
} from "lucide-react";
import { toast } from "sonner";

interface Lesson {
  id: string;
  slug: string;
  title: string;
  order_index: number;
  xp_reward: number;
  chapter?: string;
}

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  lessons: Lesson[];
  lesson_count?: number;
}

interface UserProgress {
  lesson_id: string;
  status: string;
}

interface LessonGroup {
  name: string;
  lessons: Lesson[];
}

export default function CoursePage() {
  const { courseSlug } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState<Course | null>(null);
  const [relatedCourses, setRelatedCourses] = useState<Course[]>([]);
  const [progress, setProgress] = useState<UserProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [openGroups, setOpenGroups] = useState<Record<string, boolean>>({});

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
      // If chapters are not included, fetch them directly from database
      if (data.lessons && data.lessons.length > 0 && !data.lessons[0].chapter) {
        const { data: lessonsWithChapters } = await supabase
          .from('lessons')
          .select('id, slug, title, order_index, xp_reward, chapter')
          .eq('course_id', data.id)
          .order('order_index', { ascending: true });

        if (lessonsWithChapters) {
          setCourse({ ...data, lessons: lessonsWithChapters });
          // Load related courses after setting course
          await loadRelatedCourses(data.category, data.id);
          return;
        }
      }
      setCourse(data);
      // Load related courses after setting course
      await loadRelatedCourses(data.category, data.id);
    }
  };

  const loadRelatedCourses = async (category: string, currentCourseId: string) => {
    const { data: coursesData, error } = await supabase
      .from('courses')
      .select('id, slug, title, description, category')
      .eq('category', category)
      .neq('id', currentCourseId)
      .order('title', { ascending: true });

    if (!error && coursesData) {
      // Get lesson count for each course
      const coursesWithCounts = await Promise.all(
        coursesData.map(async (course) => {
          const { count } = await supabase
            .from('lessons')
            .select('*', { count: 'exact', head: true })
            .eq('course_id', course.id);

          return {
            ...course,
            lessons: [],
            lesson_count: count || 0
          };
        })
      );
      setRelatedCourses(coursesWithCounts);
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

  // Group lessons by chapter from database
  const groupedLessons = useMemo(() => {
    if (!course?.lessons) return [];

    const sortedLessons = [...course.lessons].sort((a, b) => a.order_index - b.order_index);

    // Group by chapter field from database
    const groupsMap = new Map<string, Lesson[]>();

    sortedLessons.forEach((lesson) => {
      const chapter = lesson.chapter || 'Introduction';
      if (!groupsMap.has(chapter)) {
        groupsMap.set(chapter, []);
      }
      groupsMap.get(chapter)!.push(lesson);
    });

    // Convert map to array and sort by chapter order
    const chapterOrder = [
      'Introduction',
      'Basics',
      'You Might Know This',
      'Going Deeper',
      'Advanced Concepts',
      'Expert Level'
    ];

    const groups: LessonGroup[] = Array.from(groupsMap.entries())
      .map(([name, lessons]) => ({ name, lessons }))
      .sort((a, b) => {
        const aIndex = chapterOrder.indexOf(a.name);
        const bIndex = chapterOrder.indexOf(b.name);
        // If both chapters are in our ordered list, sort by that order
        if (aIndex >= 0 && bIndex >= 0) return aIndex - bIndex;
        // If only one is in the list, that one comes first
        if (aIndex >= 0) return -1;
        if (bIndex >= 0) return 1;
        // Otherwise, sort alphabetically
        return a.name.localeCompare(b.name);
      });

    return groups;
  }, [course?.lessons]);

  // Initialize open groups
  useEffect(() => {
    const initial: Record<string, boolean> = {};
    groupedLessons.forEach(g => { initial[g.name] = true; });
    setOpenGroups(initial);
  }, [groupedLessons]);

  const getLessonStatus = (lessonId: string) => {
    const lessonProgress = progress.find(p => p.lesson_id === lessonId);
    return lessonProgress?.status || 'not_started';
  };

  const isLessonUnlocked = (lesson: Lesson, allLessons: Lesson[]) => {
    const sortedAll = [...allLessons].sort((a, b) => a.order_index - b.order_index);
    const lessonIndex = sortedAll.findIndex(l => l.id === lesson.id);
    
    if (lessonIndex === 0) return true;
    if (!userId) return false;
    
    const prevLesson = sortedAll[lessonIndex - 1];
    if (!prevLesson) return false;
    
    return getLessonStatus(prevLesson.id) === 'completed';
  };

  const handleLessonClick = (lesson: Lesson) => {
    if (!isLessonUnlocked(lesson, course?.lessons || []) && userId) {
      // Find the previous lesson that needs to be completed
      const sortedLessons = [...(course?.lessons || [])].sort((a, b) => a.order_index - b.order_index);
      const lessonIndex = sortedLessons.findIndex(l => l.id === lesson.id);
      const previousLesson = sortedLessons[lessonIndex - 1];

      toast.error(
        `🔒 "${previousLesson.title}" must be completed first to unlock this lesson.`,
        { duration: 4000 }
      );
      return;
    }
    navigate(`/learning/${courseSlug}/${lesson.slug}`);
  };

  const toggleGroup = (groupName: string) => {
    setOpenGroups(prev => ({ ...prev, [groupName]: !prev[groupName] }));
  };

  const getGroupProgress = (lessons: Lesson[]) => {
    const completed = lessons.filter(l => getLessonStatus(l.id) === 'completed').length;
    return { completed, total: lessons.length };
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

  const hasGroups = groupedLessons.length > 1 || (groupedLessons[0]?.name !== '');

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

      {/* Lessons List - Tree Structure */}
      <div className="space-y-4">
        <h2 className="text-2xl font-semibold">Lessons</h2>
        
        <div className="space-y-2">
          {groupedLessons.map((group, groupIdx) => {
            const groupProgress = getGroupProgress(group.lessons);
            const isOpen = openGroups[group.name] ?? true;

            // If no grouping, render flat list
            if (!group.name) {
              return (
                <div key="flat" className="space-y-3">
                  {group.lessons.map((lesson, idx) => {
                    const sortedLessons = [...course.lessons].sort((a, b) => a.order_index - b.order_index);
                    const lessonIndex = sortedLessons.findIndex(l => l.id === lesson.id);
                    const prevLesson = lessonIndex > 0 ? sortedLessons[lessonIndex - 1] : undefined;

                    return (
                      <LessonCard
                        key={lesson.id}
                        lesson={lesson}
                        status={getLessonStatus(lesson.id)}
                        isUnlocked={isLessonUnlocked(lesson, course.lessons)}
                        onClick={() => handleLessonClick(lesson)}
                        indented={false}
                        previousLessonTitle={prevLesson?.title}
                      />
                    );
                  })}
                </div>
              );
            }

            return (
              <Collapsible 
                key={group.name} 
                open={isOpen}
                onOpenChange={() => toggleGroup(group.name)}
              >
                <CollapsibleTrigger asChild>
                  <div className="flex items-center gap-3 p-3 rounded-lg bg-muted/30 hover:bg-muted/50 cursor-pointer transition-colors">
                    {isOpen ? (
                      <ChevronDown className="w-5 h-5 text-muted-foreground" />
                    ) : (
                      <ChevronRight className="w-5 h-5 text-muted-foreground" />
                    )}
                    <FolderOpen className="w-5 h-5 text-primary" />
                    <span className="font-semibold flex-1">{group.name}</span>
                    <Badge variant="outline" className="text-xs">
                      {groupProgress.completed}/{groupProgress.total}
                    </Badge>
                  </div>
                </CollapsibleTrigger>
                <CollapsibleContent>
                  <div className="ml-4 mt-2 space-y-2 border-l-2 border-muted pl-4">
                    {group.lessons.map((lesson) => {
                      const sortedLessons = [...course.lessons].sort((a, b) => a.order_index - b.order_index);
                      const lessonIndex = sortedLessons.findIndex(l => l.id === lesson.id);
                      const prevLesson = lessonIndex > 0 ? sortedLessons[lessonIndex - 1] : undefined;

                      return (
                        <LessonCard
                          key={lesson.id}
                          lesson={lesson}
                          status={getLessonStatus(lesson.id)}
                          isUnlocked={isLessonUnlocked(lesson, course.lessons)}
                          onClick={() => handleLessonClick(lesson)}
                          indented={true}
                          previousLessonTitle={prevLesson?.title}
                        />
                      );
                    })}
                  </div>
                </CollapsibleContent>
              </Collapsible>
            );
          })}
        </div>
      </div>

      {/* Related Courses Section */}
      {relatedCourses.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-xl flex items-center gap-2">
              <BookOpen className="w-5 h-5" />
              More {course.category} Courses
            </CardTitle>
            <CardDescription>
              Explore other courses in {course.category}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid gap-4 md:grid-cols-2">
              {relatedCourses.map((relatedCourse) => (
                <Card
                  key={relatedCourse.id}
                  className="cursor-pointer hover:shadow-lg transition-all border-muted"
                  onClick={() => navigate(`/learning/${relatedCourse.slug}`)}
                >
                  <CardHeader className="pb-3">
                    <div className="flex items-start justify-between">
                      <div className="flex-1 space-y-1">
                        <CardTitle className="text-lg">{relatedCourse.title}</CardTitle>
                        <CardDescription className="text-sm line-clamp-2">
                          {relatedCourse.description}
                        </CardDescription>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-0">
                    <div className="flex items-center gap-2 text-sm text-muted-foreground">
                      <BookOpen className="w-3 h-3" />
                      <span>{relatedCourse.lesson_count || 0} lessons</span>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}

interface LessonCardProps {
  lesson: Lesson;
  status: string;
  isUnlocked: boolean;
  onClick: () => void;
  indented: boolean;
  previousLessonTitle?: string;
}

function LessonCard({ lesson, status, isUnlocked, onClick, indented, previousLessonTitle }: LessonCardProps) {
  const isCompleted = status === 'completed';

  return (
    <Card
      className={`
        transition-all cursor-pointer
        ${isUnlocked
          ? 'hover:shadow-lg hover:border-primary/50'
          : 'opacity-60 cursor-not-allowed bg-muted/30'
        }
        ${isCompleted ? 'border-success/30 bg-success/5' : ''}
      `}
      onClick={onClick}
    >
      <CardContent className={`p-4 ${indented ? 'py-3' : ''}`}>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3 flex-1">
            <div className={`
              w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold
              ${isCompleted
                ? 'bg-success/20 text-success'
                : isUnlocked
                  ? 'bg-primary/20 text-primary'
                  : 'bg-muted text-muted-foreground'
              }
            `}>
              {isCompleted ? (
                <CheckCircle2 className="w-4 h-4" />
              ) : isUnlocked ? (
                <FileText className="w-4 h-4" />
              ) : (
                <Lock className="w-4 h-4" />
              )}
            </div>

            <div className="flex-1">
              <h3 className={`font-medium ${indented ? 'text-sm' : ''}`}>{lesson.title}</h3>
              <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground">
                <div className="flex items-center gap-1">
                  <Clock className="w-3 h-3" />
                  <span>~5 min</span>
                </div>
                <div className="flex items-center gap-1">
                  <Award className="w-3 h-3" />
                  <span>+{lesson.xp_reward || 10} XP</span>
                </div>
                {!isUnlocked && previousLessonTitle && (
                  <div className="flex items-center gap-1 text-muted-foreground">
                    <span>Complete "{previousLessonTitle}" to unlock</span>
                  </div>
                )}
              </div>
            </div>
          </div>

          {!isUnlocked && (
            <Badge variant="outline" className="text-xs bg-muted/50">
              <Lock className="w-3 h-3 mr-1" />
              Locked
            </Badge>
          )}
          {isCompleted && (
            <Badge variant="outline" className="text-xs border-success text-success bg-success/5">
              <CheckCircle2 className="w-3 h-3 mr-1" />
              Completed
            </Badge>
          )}
        </div>
      </CardContent>
    </Card>
  );
}