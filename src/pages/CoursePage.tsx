import { useEffect, useState, useMemo } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Loader2 } from "lucide-react";
import { TopBar } from "@/components/course/TopBar";
import { PathLayout } from "@/components/course/PathLayout";
import { UnitCard } from "@/components/course/UnitCard";
import { toast } from "sonner";
import { motion, AnimatePresence } from "framer-motion";
import { calculateLevel, getProgressToNextLevel, getXpRemainingToNextLevel } from "@/utils/levelCalculations";

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

interface UserProfile {
  level: number;
  xp_points: number;
  xp_total: number;
  streak?: number;
}

interface LessonGroup {
  name: string;
  lessons: Lesson[];
  progress: {
    completed: number;
    total: number;
  };
  totalXP: number;
}

export default function CoursePage() {
  const { courseSlug } = useParams();
  const navigate = useNavigate();
  const [course, setCourse] = useState<Course | null>(null);
  const [progress, setProgress] = useState<UserProgress[]>([]);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile>({
    level: 1,
    xp_points: 0,
    xp_total: 0,
    streak: 0
  });

  useEffect(() => {
    const init = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) {
        setUserId(session.user.id);
        await loadCourse();
        await loadProgress(session.user.id);
        await loadUserProfile(session.user.id);
      } else {
        await loadCourse();
      }
      setLoading(false);
    };
    init();
  }, [courseSlug]);

  const loadCourse = async () => {
    try {
      const { data, error } = await supabase.functions.invoke('courses', {
        body: { slug: courseSlug }
      });

      if (error) {
        console.error('Error loading course:', error);
        return;
      }

      if (!data || data.error) {
        console.error('Course not found or has error');
        return;
      }

      const courseWithLessons = {
        ...data,
        lessons: data.lessons || [],
      };

      setCourse(courseWithLessons);
    } catch (err) {
      console.error('Exception in loadCourse:', err);
    }
  };

  const loadProgress = async (uid: string) => {
    const { data } = await supabase
      .from('user_progress')
      .select('lesson_id, status')
      .eq('user_id', uid);

    if (data) {
      setProgress(data);
    }
  };

  const loadUserProfile = async (uid: string) => {
    try {
      const [userStatsResult, profileResult] = await Promise.all([
        supabase.from("user_stats").select("xp_total").eq("user_id", uid).single(),
        supabase.from("profiles").select("xp_points, level").eq("user_id", uid).single(),
      ]);

      const xp_total = userStatsResult.data?.xp_total || 0;
      const xp_points = profileResult.data?.xp_points || 0;
      const calculatedLevel = calculateLevel(xp_points);

      setUserProfile({
        level: calculatedLevel,
        xp_points,
        xp_total,
      });
    } catch (error) {
      console.error("Error loading user profile:", error);
    }
  };

  // Group lessons by chapter
  const groupedUnits = useMemo(() => {
    if (!course?.lessons) return [];

    const sortedLessons = [...course.lessons].sort((a, b) => a.order_index - b.order_index);
    const groupsMap = new Map<string, Lesson[]>();

    sortedLessons.forEach((lesson) => {
      const chapter = lesson.chapter || 'Introduction';
      if (!groupsMap.has(chapter)) {
        groupsMap.set(chapter, []);
      }
      groupsMap.get(chapter)!.push(lesson);
    });

    const chapterOrder = [
      'Introduction',
      'Basics',
      'You Might Know This',
      'Going Deeper',
      'Advanced Concepts',
      'Expert Level'
    ];

    const units: LessonGroup[] = Array.from(groupsMap.entries())
      .map(([name, lessons]) => {
        const completed = lessons.filter(l => {
          const lessonProgress = progress.find(p => p.lesson_id === l.id);
          return lessonProgress?.status === 'completed';
        }).length;

        const totalXP = lessons.reduce((sum, l) => sum + (l.xp_reward || 10), 0);

        return {
          name,
          lessons,
          progress: {
            completed,
            total: lessons.length
          },
          totalXP
        };
      })
      .sort((a, b) => {
        const aIndex = chapterOrder.indexOf(a.name);
        const bIndex = chapterOrder.indexOf(b.name);
        if (aIndex >= 0 && bIndex >= 0) return aIndex - bIndex;
        if (aIndex >= 0) return -1;
        if (bIndex >= 0) return 1;
        return a.name.localeCompare(b.name);
      });

    return units;
  }, [course?.lessons, progress]);

  // Determine which unit is current (first incomplete)
  const currentUnitIndex = useMemo(() => {
    return groupedUnits.findIndex(unit => unit.progress.completed < unit.progress.total);
  }, [groupedUnits]);

  const isUnitLocked = (index: number) => {
    if (index === 0) return false;
    const previousUnit = groupedUnits[index - 1];
    if (!previousUnit) return true;
    return previousUnit.progress.completed < previousUnit.progress.total;
  };

  const isUnitCompleted = (index: number) => {
    const unit = groupedUnits[index];
    if (!unit) return false;
    return unit.progress.completed >= unit.progress.total;
  };

  const handleUnitStart = (unit: LessonGroup, index: number) => {
    if (isUnitLocked(index) && userId) {
      toast.error('Complete the previous unit first to unlock this one.');
      return;
    }

    // Find first incomplete lesson in this unit
    const incompleteLesson = unit.lessons.find(l => {
      const lessonProgress = progress.find(p => p.lesson_id === l.id);
      return lessonProgress?.status !== 'completed';
    });

    if (incompleteLesson) {
      navigate(`/learning/${courseSlug}/${incompleteLesson.slug}`);
    } else {
      // All lessons completed, navigate to first lesson
      navigate(`/learning/${courseSlug}/${unit.lessons[0].slug}`);
    }
  };

  const getLessonStatus = (lessonId: string) => {
    const lessonProgress = progress.find(p => p.lesson_id === lessonId);
    return lessonProgress?.status || 'not_started';
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
        <div className="text-center py-12">
          <h2 className="text-2xl font-bold mb-2">Course Not Found</h2>
          <p className="text-muted-foreground mb-4">The course you're looking for doesn't exist.</p>
          <button
            onClick={() => navigate('/learning')}
            className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"
          >
            Back to Courses
          </button>
        </div>
      </div>
    );
  }

  const xpToNextLevel = getXpRemainingToNextLevel(userProfile.xp_points);
  const progressToNextLevel = getProgressToNextLevel(userProfile.xp_points);

  return (
    <div className="min-h-screen bg-background">
      {/* Top Bar */}
      <TopBar
        courseTitle={course.title}
        xp={userProfile.xp_points}
        xpToNextLevel={xpToNextLevel}
        progressToNextLevel={progressToNextLevel}
        level={userProfile.level}
        streak={userProfile.streak}
      />

      {/* Main Content */}
      <div className="container mx-auto px-4 py-6 max-w-4xl">
        {/* Course Description */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6 p-4 rounded-xl bg-gradient-to-r from-primary/10 to-purple-500/10 border border-primary/20"
        >
          <h2 className="text-xl font-bold mb-2">{course.title}</h2>
          <p className="text-muted-foreground">{course.description}</p>
        </motion.div>

        {/* Learning Path */}
        <PathLayout>
          <AnimatePresence mode="popLayout">
            {groupedUnits.map((unit, index) => {
              const isCurrent = index === currentUnitIndex;
              const isLocked = isUnitLocked(index);
              const isCompleted = isUnitCompleted(index);

              return (
                <UnitCard
                  key={unit.name}
                  unit={unit}
                  index={index}
                  isCurrent={isCurrent}
                  isLocked={isLocked}
                  isCompleted={isCompleted}
                  onStart={() => handleUnitStart(unit, index)}
                  totalXP={unit.totalXP}
                />
              );
            })}
          </AnimatePresence>
        </PathLayout>

        {/* Course Stats */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-4"
        >
          <div className="p-4 rounded-xl bg-gradient-to-br from-blue-500/10 to-blue-600/10 border border-blue-500/20">
            <div className="text-2xl font-bold text-blue-400">{course.lessons?.length || 0}</div>
            <div className="text-sm text-muted-foreground">Total Lessons</div>
          </div>
          <div className="p-4 rounded-xl bg-gradient-to-br from-purple-500/10 to-purple-600/10 border border-purple-500/20">
            <div className="text-2xl font-bold text-purple-400">
              {groupedUnits.reduce((sum, u) => sum + u.totalXP, 0)}
            </div>
            <div className="text-sm text-muted-foreground">Total XP Available</div>
          </div>
          <div className="p-4 rounded-xl bg-gradient-to-br from-green-500/10 to-green-600/10 border border-green-500/20">
            <div className="text-2xl font-bold text-green-400">
              {groupedUnits.reduce((sum, u) => sum + u.progress.completed, 0)}
            </div>
            <div className="text-sm text-muted-foreground">Lessons Completed</div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}
