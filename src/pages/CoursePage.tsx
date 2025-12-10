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

interface LessonGroup {
  name: string;
  lessons: Lesson[];
}

export default function CoursePage() {
  const { courseSlug } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState<Course | null>(null);
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

  // Group lessons by detecting patterns in titles
  const groupedLessons = useMemo(() => {
    if (!course?.lessons) return [];

    const sortedLessons = [...course.lessons].sort((a, b) => a.order_index - b.order_index);
    
    // Detect groups by common prefixes or section patterns
    const groups: LessonGroup[] = [];
    let currentGroup: LessonGroup | null = null;
    
    // Keywords that indicate a new section
    const sectionKeywords = [
      'introduction', 'basics', 'fundamentals', 'advanced', 
      'forces', 'motion', 'energy', 'waves', 'electricity', 'magnetism',
      'thermodynamics', 'quantum', 'relativity', 'optics',
      'organic', 'inorganic', 'biochemistry', 'reactions',
      'cells', 'genetics', 'evolution', 'ecology', 'anatomy',
      'stars', 'planets', 'galaxies', 'cosmology',
      'mechanics', 'kinematics', 'dynamics'
    ];

    const detectSection = (title: string): string | null => {
      const lowerTitle = title.toLowerCase();
      
      // Check if title starts with a number (like "1. Introduction")
      const numberMatch = lowerTitle.match(/^\d+\.\s*/);
      if (numberMatch) {
        const afterNumber = lowerTitle.slice(numberMatch[0].length);
        for (const keyword of sectionKeywords) {
          if (afterNumber.startsWith(keyword)) {
            return keyword.charAt(0).toUpperCase() + keyword.slice(1);
          }
        }
      }

      // Check for section keywords
      for (const keyword of sectionKeywords) {
        if (lowerTitle.includes(keyword)) {
          return keyword.charAt(0).toUpperCase() + keyword.slice(1);
        }
      }

      // Check for colon separator (e.g., "Forces: Newton's Laws")
      const colonIndex = title.indexOf(':');
      if (colonIndex > 0 && colonIndex < 30) {
        return title.slice(0, colonIndex).trim();
      }

      return null;
    };

    sortedLessons.forEach((lesson, idx) => {
      const sectionName = detectSection(lesson.title);
      
      if (sectionName && (!currentGroup || currentGroup.name !== sectionName)) {
        // Start a new group
        currentGroup = { name: sectionName, lessons: [lesson] };
        groups.push(currentGroup);
      } else if (currentGroup) {
        // Add to current group
        currentGroup.lessons.push(lesson);
      } else {
        // No group detected, create "Getting Started" for first few lessons
        if (idx < 3) {
          if (!groups.find(g => g.name === 'Getting Started')) {
            currentGroup = { name: 'Getting Started', lessons: [lesson] };
            groups.push(currentGroup);
          } else {
            groups.find(g => g.name === 'Getting Started')?.lessons.push(lesson);
          }
        } else {
          // Create a miscellaneous group
          const miscGroup = groups.find(g => g.name === 'Other Topics');
          if (miscGroup) {
            miscGroup.lessons.push(lesson);
          } else {
            groups.push({ name: 'Other Topics', lessons: [lesson] });
          }
        }
      }
    });

    // If only one group or few lessons, just return flat
    if (groups.length <= 1 || sortedLessons.length <= 5) {
      return [{ name: '', lessons: sortedLessons }];
    }

    // Initialize all groups as open
    const initialOpenState: Record<string, boolean> = {};
    groups.forEach(g => { initialOpenState[g.name] = true; });
    
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
      return;
    }
    navigate(`/learn/${courseSlug}/${lesson.slug}`);
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
                  {group.lessons.map((lesson) => (
                    <LessonCard
                      key={lesson.id}
                      lesson={lesson}
                      status={getLessonStatus(lesson.id)}
                      isUnlocked={isLessonUnlocked(lesson, course.lessons)}
                      onClick={() => handleLessonClick(lesson)}
                      indented={false}
                    />
                  ))}
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
                    {group.lessons.map((lesson) => (
                      <LessonCard
                        key={lesson.id}
                        lesson={lesson}
                        status={getLessonStatus(lesson.id)}
                        isUnlocked={isLessonUnlocked(lesson, course.lessons)}
                        onClick={() => handleLessonClick(lesson)}
                        indented={true}
                      />
                    ))}
                  </div>
                </CollapsibleContent>
              </Collapsible>
            );
          })}
        </div>
      </div>
    </div>
  );
}

interface LessonCardProps {
  lesson: Lesson;
  status: string;
  isUnlocked: boolean;
  onClick: () => void;
  indented: boolean;
}

function LessonCard({ lesson, status, isUnlocked, onClick, indented }: LessonCardProps) {
  const isCompleted = status === 'completed';

  return (
    <Card 
      className={`
        transition-all cursor-pointer
        ${isUnlocked 
          ? 'hover:shadow-lg hover:border-primary/50' 
          : 'opacity-60 cursor-not-allowed'
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
              </div>
            </div>
          </div>

          {!isUnlocked && (
            <Badge variant="outline" className="text-xs">
              Locked
            </Badge>
          )}
        </div>
      </CardContent>
    </Card>
  );
}