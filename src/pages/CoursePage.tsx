import { useEffect, useState, useMemo } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { HelixLoader } from "@/components/ui/helix-loader";
import { TopBar } from "@/components/course/TopBar";
import { PathLayout } from "@/components/course/PathLayout";
import { UnitCard } from "@/components/course/UnitCard";
import { toast } from "sonner";
import { motion, AnimatePresence } from "framer-motion";
import { Play, Lock, CheckCircle2, BookOpen } from "lucide-react";
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
  chapter_quiz_completed?: boolean;
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
      .select('lesson_id, status, chapter_quiz_completed')
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

  // Check if a chapter is locked
  const isChapterLocked = (chapterIndex: number) => {
    if (chapterIndex === 0) return false; // First chapter never locked

    // Check if all lessons in all previous chapters are completed AND chapter quiz is passed
    for (let i = 0; i < chapterIndex; i++) {
      const chapter = groupedUnits[i];
      if (!chapter) return true;

      // Check if all lessons in previous chapter are completed
      if (chapter.progress.completed < chapter.progress.total) {
        return true; // Lock if previous chapter not fully complete
      }

      // Check if chapter quiz was completed (for the last lesson in the chapter)
      const lastLessonInChapter = chapter.lessons[chapter.lessons.length - 1];
      if (lastLessonInChapter) {
        const lastLessonProgress = progress.find(p => p.lesson_id === lastLessonInChapter.id);

        // Check if chapter quiz was completed
        const chapterQuizCompleted = lastLessonProgress?.chapter_quiz_completed;

        if (!chapterQuizCompleted) {
          return true; // Lock if previous chapter quiz not passed
        }
      }
    }
    return false;
  };

  // Check if an individual lesson is locked
  const isLessonLocked = (lesson: Lesson, chapterIndex: number) => {
    // First check if chapter is locked
    if (isChapterLocked(chapterIndex)) return true;

    // Within an unlocked chapter, check if previous lesson is completed
    const chapter = groupedUnits[chapterIndex];
    if (!chapter) return false;

    const lessonIndex = chapter.lessons.findIndex(l => l.id === lesson.id);
    if (lessonIndex === 0) return false; // First lesson in chapter never locked

    // Check if previous lesson is completed
    const previousLesson = chapter.lessons[lessonIndex - 1];
    if (!previousLesson) return false;

    const previousProgress = progress.find(p => p.lesson_id === previousLesson.id);
    return previousProgress?.status !== 'completed';
  };

  const handleLessonClick = async (lesson: Lesson) => {
    // Always check server-side if previous lesson is completed before navigating
    const lessonIndex = course.lessons.findIndex(l => l.id === lesson.id);

    // Only check previous lesson if this isn't the first lesson
    if (lessonIndex > 0) {
      const previousLesson = course.lessons[lessonIndex - 1];

      // Check if previous lesson is completed in the database
      const { data: previousProgress } = await supabase
        .from('user_progress')
        .select('status')
        .eq('user_id', userId)
        .eq('lesson_id', previousLesson.id)
        .maybeSingle();

      const isPreviousCompleted = previousProgress?.status === 'completed';

      if (!isPreviousCompleted) {
        toast.error(
          `Please complete "${previousLesson.title}" before starting this lesson.`
        );
        return;
      }
    }

    // Previous lesson is completed, navigate to this lesson
    // Also create an in_progress record if one doesn't exist
    const { data: existingProgress } = await supabase
      .from('user_progress')
      .select('status')
      .eq('user_id', userId)
      .eq('lesson_id', lesson.id)
      .maybeSingle();

    if (!existingProgress) {
      await supabase
        .from('user_progress')
        .insert({
          user_id: userId,
          lesson_id: lesson.id,
          status: 'in_progress',
        });
    }

    navigate(`/learning/${courseSlug}/${lesson.slug}`);
  };

  const isUnitCompleted = (index: number) => {
    const unit = groupedUnits[index];
    if (!unit) return false;
    return unit.progress.completed >= unit.progress.total;
  };

  const getLessonStatus = (lessonId: string) => {
    const lessonProgress = progress.find(p => p.lesson_id === lessonId);
    return lessonProgress?.status || 'not_started';
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
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
            {groupedUnits.map((unit, unitIndex) => {
              const chapterLocked = isChapterLocked(unitIndex);
              const chapterCompleted = isUnitCompleted(unitIndex);

              return (
                <div key={unit.name} className="mb-8">
                  {/* Chapter Header */}
                  <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="mb-6"
                  >
                    <div className={`p-4 rounded-xl border-2 ${
                      chapterLocked
                        ? 'bg-muted/30 border-muted opacity-50'
                        : chapterCompleted
                        ? 'bg-success/10 border-success/50'
                        : 'bg-primary/10 border-primary/50'
                    }`}>
                      <div className="flex items-center justify-between">
                        <div>
                          <h3 className="text-lg font-bold flex items-center gap-2">
                            {chapterLocked && <Lock className="w-5 h-5" />}
                            {unit.name}
                          </h3>
                          <p className="text-sm text-muted-foreground">
                            {unit.progress.completed} / {unit.progress.total} lessons completed
                          </p>
                        </div>
                        {chapterCompleted && (
                          <CheckCircle2 className="w-8 h-8 text-success" />
                        )}
                      </div>
                      {!chapterLocked && (
                        <div className="mt-2">
                          <div className="w-full h-2 bg-muted rounded-full overflow-hidden">
                            <motion.div
                              initial={{ width: 0 }}
                              animate={{ width: `${(unit.progress.completed / unit.progress.total) * 100}%` }}
                              transition={{ duration: 0.6 }}
                              className={chapterCompleted ? 'h-full bg-success' : 'h-full bg-gradient-to-r from-primary to-purple-600'}
                            />
                          </div>
                        </div>
                      )}
                    </div>
                  </motion.div>

                  {/* Lessons in this chapter */}
                  <div className="flex flex-col gap-3">
                    {unit.lessons.map((lesson, lessonIndex) => {
                      const lessonLocked = isLessonLocked(lesson, unitIndex);
                      const lessonStatus = getLessonStatus(lesson.id);
                      const isLessonCompleted = lessonStatus === 'completed';
                      const isLessonCurrent = lessonStatus === 'in_progress';

                      // Generate lesson title - if it's the chapter name or empty, create a better one
                      const getLessonTitle = () => {
                        // If lesson title exists and is different from chapter name, use it
                        if (lesson.title && lesson.title !== unit.name) {
                          return lesson.title;
                        }
                        // Otherwise, generate a sequential title
                        return `${unit.name} - Lesson ${lessonIndex + 1}`;
                      };

                      const displayTitle = getLessonTitle();

                      return (
                        <motion.div
                          key={lesson.id}
                          initial={{ opacity: 0, x: -20 }}
                          animate={{ opacity: 1, x: 0 }}
                          transition={{ delay: lessonIndex * 0.1 }}
                        >
                          <div
                            onClick={() => !lessonLocked && handleLessonClick(lesson)}
                            className={`p-4 rounded-lg border-2 transition-all cursor-pointer ${
                              lessonLocked
                                ? 'bg-muted/30 border-muted opacity-50 cursor-not-allowed'
                                : isLessonCompleted
                                ? 'bg-success/10 border-success/50 hover:border-success'
                                : isLessonCurrent
                                ? 'bg-primary/20 border-primary shadow-lg shadow-primary/20'
                                : 'bg-card hover:border-primary/50 hover:bg-primary/5'
                            }`}
                          >
                            <div className="flex items-center gap-4">
                              {/* Lesson icon/bubble */}
                              <div className={`w-12 h-12 rounded-full flex items-center justify-center text-lg font-bold flex-shrink-0 ${
                                lessonLocked
                                  ? 'bg-muted text-muted-foreground'
                                  : isLessonCompleted
                                  ? 'bg-success text-white'
                                  : isLessonCurrent
                                  ? 'bg-gradient-to-br from-primary to-purple-600 text-white'
                                  : 'bg-primary/20 text-primary'
                              }`}>
                                {lessonLocked ? (
                                  <Lock className="w-5 h-5" />
                                ) : isLessonCompleted ? (
                                  <CheckCircle2 className="w-6 h-6" />
                                ) : (
                                  lessonIndex + 1
                                )}
                              </div>

                              {/* Lesson info */}
                              <div className="flex-1 min-w-0">
                                <h4 className={`font-semibold ${isLessonCurrent ? 'text-primary' : ''}`}>
                                  {displayTitle}
                                </h4>
                                <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground">
                                  <span className="flex items-center gap-1">
                                    <BookOpen className="w-3 h-3" />
                                    {lesson.xp_reward || 10} XP
                                  </span>
                                  {isLessonCompleted && (
                                    <span className="text-success">Completed</span>
                                  )}
                                  {isLessonCurrent && (
                                    <span className="text-primary">In Progress</span>
                                  )}
                                  {lessonLocked && (
                                    <span className="text-muted-foreground">Locked</span>
                                  )}
                                </div>
                              </div>

                              {/* Action icon */}
                              {!lessonLocked && (
                                <div className="flex-shrink-0">
                                  {isLessonCompleted ? (
                                    <CheckCircle2 className="w-6 h-6 text-success" />
                                  ) : (
                                    <Play className="w-6 h-6 text-primary" />
                                  )}
                                </div>
                              )}
                            </div>
                          </div>
                        </motion.div>
                      );
                    })}
                  </div>
                </div>
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
