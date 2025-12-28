import { useEffect, useState, useMemo } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Progress } from "@/components/ui/progress";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { BookOpen, Search, Filter, Loader2, CheckCircle2, Lock, Star } from "lucide-react";
import { calculateLevel, getXpForNextLevel, getXpRemainingToNextLevel, getProgressToNextLevel } from "@/utils/levelCalculations";

// Course emoji mapping
const getCourseEmoji = (slug: string): string => {
  const emojiMap: Record<string, string> = {
    'basic-physics': '⚡',
    'quantum-mechanics': '🔮',
    'thermodynamics': '🔥',
    'astronomy': '🌟',
    'astrophysics': '🌌',
    'planetary-science': '🪐',
    'chemistry-basics': '🧪',
    'organic-chemistry': '🧬',
    'biochemistry': '🔬',
    'cell-biology': '🦠',
    'genetics': '🧬',
    'ecology': '🌿',
    'neurobiology': '🧠',
    'robotics': '🤖',
    'materials-science': '⚙️',
    'environmental-science': '🌍',
    'general-science': '📚',
    'origins-how-we-were-created': '🌅',
  };
  return emojiMap[slug] || '📖';
};

// Types
interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  lesson_count: number;
  difficulty?: string;
}

interface CourseProgress {
  completed: number;
  total: number;
  percentage: number;
}

interface UserProfile {
  level: number;
  xp_points: number;
  xp_total: number;
}

interface DifficultyRequirement {
  level: number;
  label: string;
}

export default function UnifiedLearningPage() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);

  // Courses state
  const [courses, setCourses] = useState<Course[]>([]);
  const [courseProgress, setCourseProgress] = useState<Record<string, CourseProgress>>({});
  const [userProfile, setUserProfile] = useState<UserProfile>({
    level: 1,
    xp_points: 0,
    xp_total: 0,
  });

  // Filter state
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("all");
  const [selectedDifficulty, setSelectedDifficulty] = useState("all");

  // Difficulty level requirements
  const difficultyRequirements: Record<string, DifficultyRequirement> = {
    beginner: { level: 1, label: "Level 1" },
    intermediate: { level: 10, label: "Level 10" },
    advanced: { level: 20, label: "Level 20" },
  };

  useEffect(() => {
    initPage();
  }, []);

  const initPage = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      navigate("/");
      return;
    }

    setUserId(session.user.id);
    await Promise.all([
      loadCourses(),
      loadCourseProgress(session.user.id),
      loadUserProfile(session.user.id)
    ]);
    setLoading(false);
  };

  const loadCourses = async () => {
    const { data, error } = await supabase.functions.invoke('courses');
    if (!error && data) setCourses(data);
  };

  const loadCourseProgress = async (uid: string) => {
    const { data: progressData } = await supabase
      .from('user_progress')
      .select('lesson_id, status')
      .eq('user_id', uid);

    const { data: lessonsData } = await supabase
      .from('lessons')
      .select('id, course_id');

    if (lessonsData && progressData) {
      const progressMap: Record<string, CourseProgress> = {};
      const lessonsByCourse = lessonsData.reduce((acc, lesson) => {
        if (!acc[lesson.course_id]) acc[lesson.course_id] = [];
        acc[lesson.course_id].push(lesson.id);
        return acc;
      }, {} as Record<string, string[]>);

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
      setCourseProgress(progressMap);
    }
  };

  const loadUserProfile = async (userId: string) => {
    try {
      // Fetch from both user_stats and profiles
      const [userStatsResult, profileResult] = await Promise.all([
        supabase.from("user_stats").select("xp_total").eq("user_id", userId).single(),
        supabase.from("profiles").select("xp_points, level").eq("user_id", userId).single(),
      ]);

      const xp_total = userStatsResult.data?.xp_total || 0;
      const xp_points = profileResult.data?.xp_points || 0;
      const storedLevel = profileResult.data?.level || 1;

      // Calculate level from XP to ensure accuracy
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

  const isCourseLocked = (course: Course): boolean => {
    if (!course.difficulty) return false;
    const requirement = difficultyRequirements[course.difficulty];
    return requirement ? userProfile.level < requirement.level : false;
  };

  // Helper to normalize category names (capitalize first letter)
  const normalizeCategory = (cat: string) => {
    if (!cat) return cat;
    return cat.charAt(0).toUpperCase() + cat.slice(1).toLowerCase();
  };

  // Filter logic
  const categories = useMemo(() => {
    const courseCats = courses.map(c => normalizeCategory(c.category));
    const uniqueCats = [...new Set(courseCats)].filter(Boolean).sort();
    return ["all", ...uniqueCats];
  }, [courses]);

  const filteredCourses = useMemo(() => {
    return courses.filter(c => {
      const matchesSearch = !searchQuery ||
        c.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        c.description.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesCategory = selectedCategory === "all" ||
        normalizeCategory(c.category) === selectedCategory;
      const matchesDifficulty = selectedDifficulty === "all" ||
        c.difficulty === selectedDifficulty;
      return matchesSearch && matchesCategory && matchesDifficulty;
    });
  }, [courses, searchQuery, selectedCategory, selectedDifficulty]);

  // Group courses by category (normalized)
  const groupedByCategory = useMemo(() => {
    const groups: Record<string, { courses: Course[] }> = {};

    filteredCourses.forEach(c => {
      const cat = normalizeCategory(c.category);
      if (!groups[cat]) groups[cat] = { courses: [] };
      groups[cat].courses.push(c);
    });

    return groups;
  }, [filteredCourses]);

  const getDifficultyBadgeClass = (level: string) => {
    switch (level) {
      case "beginner": return "bg-green-500/20 text-green-400 border-green-500/50";
      case "intermediate": return "bg-indigo-500/20 text-indigo-400 border-indigo-500/50";
      case "advanced": return "bg-orange-500/20 text-orange-400 border-orange-500/50";
      default: return "bg-muted text-muted-foreground";
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  // Main learning page view
  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* User Level Display */}
      <Card className="mb-6 bg-gradient-to-r from-primary/10 to-purple-500/10 border-primary/20">
        <CardContent className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center">
                <span className="text-xl font-bold">L{userProfile.level}</span>
              </div>
              <div>
                <p className="text-lg font-semibold">Level {userProfile.level}</p>
                <p className="text-sm text-muted-foreground">
                  {userProfile.xp_points} XP Total
                </p>
              </div>
            </div>
            <div className="flex gap-4 text-sm">
              <div className="flex items-center gap-2">
                <Star className="w-4 h-4 text-yellow-500" />
                <span className="font-medium">
                  {getXpRemainingToNextLevel(userProfile.xp_points)} XP to next level
                </span>
              </div>
            </div>
          </div>
          <Progress
            value={getProgressToNextLevel(userProfile.xp_points)}
            className="h-2 mt-3"
          />
        </CardContent>
      </Card>

      {/* Header */}
      <div className="mb-6">
        <h1 className="text-4xl font-bold bg-gradient-to-r from-indigo-400 to-purple-400 bg-clip-text text-transparent mb-2">
          Learn Science
        </h1>
        <p className="text-muted-foreground">
          Master science topics with interactive lessons, quizzes, and AI assistance. Unlock higher difficulty courses by leveling up!
        </p>
      </div>

      {/* Filters Row */}
      <div className="flex flex-col lg:flex-row gap-3 mb-8">
        {/* Difficulty Tabs */}
        <div className="flex gap-1 rounded-lg bg-muted/30 p-1">
          {["all", "beginner", "intermediate", "advanced"].map((level) => (
            <button
              key={level}
              onClick={() => setSelectedDifficulty(level)}
              className={`px-3 py-1.5 rounded-md text-xs font-medium transition-all ${
                selectedDifficulty === level
                  ? "bg-primary text-primary-foreground shadow-sm"
                  : level === "beginner"
                  ? "text-green-400 hover:bg-green-500/20"
                  : level === "intermediate"
                  ? "text-indigo-400 hover:bg-indigo-500/20"
                  : level === "advanced"
                  ? "text-orange-400 hover:bg-orange-500/20"
                  : "text-muted-foreground hover:bg-muted"
              }`}
            >
              {level === "all" ? "All" : level.charAt(0).toUpperCase() + level.slice(1)}
            </button>
          ))}
        </div>

        {/* Search */}
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input
            placeholder="Search courses..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10"
          />
        </div>

        {/* Category Filter */}
        <Select value={selectedCategory} onValueChange={setSelectedCategory}>
          <SelectTrigger className="w-full lg:w-[160px]">
            <Filter className="w-4 h-4 mr-2" />
            <SelectValue placeholder="All Categories" />
          </SelectTrigger>
          <SelectContent className="bg-popover">
            {categories.map((cat) => (
              <SelectItem key={cat} value={cat}>
                {cat === "all" ? "All Categories" : cat}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      {/* Content grouped by category */}
      {Object.entries(groupedByCategory).map(([category, items]) => (
        <div key={category} className="mb-8">
          <div className="flex items-center gap-2 mb-4">
            <h2 className="text-xl font-semibold capitalize">{category}</h2>
            <Badge variant="secondary">
              {items.courses.length} {items.courses.length === 1 ? 'course' : 'courses'}
            </Badge>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {/* Courses */}
            {items.courses.map((course) => {
              const progress = courseProgress[course.id] || { completed: 0, total: 0, percentage: 0 };
              const isStarted = progress.completed > 0;
              const locked = isCourseLocked(course);
              const requirement = course.difficulty ? difficultyRequirements[course.difficulty] : null;

              return (
                <Card
                  key={course.id}
                  className={`bg-card hover:border-primary/50 transition-all cursor-pointer group overflow-hidden ${
                    locked ? "opacity-60 bg-muted/30" : ""
                  }`}
                  onClick={() => !locked && navigate(`/science-lens/learning/${course.slug}`)}
                >
                  <CardContent className="p-4">
                    <div className="flex gap-3">
                      <div className="w-12 h-12 rounded-lg bg-primary/20 flex items-center justify-center flex-shrink-0 text-2xl">
                        {getCourseEmoji(course.slug)}
                      </div>
                      <div className="flex-1 min-w-0 space-y-2">
                        <div className="flex items-center justify-between gap-2">
                          <h4 className={`font-semibold group-hover:text-primary transition-colors min-w-0 truncate ${
                            locked ? "text-muted-foreground" : ""
                          }`}>
                            {course.title}
                          </h4>
                          <div className="flex items-center gap-2 flex-shrink-0">
                            {locked && requirement && (
                              <Badge variant="outline" className="gap-1">
                                <Lock className="w-3 h-3" />
                                {requirement.label}
                              </Badge>
                            )}
                            {course.difficulty && (
                              <Badge className={`text-xs ${getDifficultyBadgeClass(course.difficulty)}`}>
                                {course.difficulty}
                              </Badge>
                            )}
                          </div>
                        </div>
                        <p className={`text-sm line-clamp-2 ${
                          locked ? "text-muted-foreground/70" : "text-muted-foreground"
                        }`}>
                          {course.description}
                        </p>

                        {locked && requirement ? (
                          <div className="space-y-2">
                            <div className="flex items-center gap-2 text-sm text-amber-600 dark:text-amber-400">
                              <Lock className="w-4 h-4" />
                              <span className="font-medium">
                                Requires Level {requirement.level}
                              </span>
                            </div>
                            <p className="text-xs text-muted-foreground">
                              You need to reach Level {requirement.level} to unlock this {course.difficulty} course.
                              Current level: {userProfile.level}
                            </p>
                            <div className="pt-2">
                              <Progress
                                value={(userProfile.level / requirement.level) * 100}
                                className="h-2"
                              />
                              <p className="text-xs text-muted-foreground mt-1">
                                {requirement.level - userProfile.level} more levels to unlock
                              </p>
                            </div>
                          </div>
                        ) : (
                          <>
                            <div className="flex items-center gap-3 text-xs text-muted-foreground">
                              <span className="flex items-center gap-1">
                                <BookOpen className="w-3 h-3" />
                                {course.lesson_count || 0} {(course.lesson_count || 0) === 1 ? 'lesson' : 'lessons'}
                              </span>
                              {isStarted && (
                                <span className="flex items-center gap-1">
                                  <CheckCircle2 className="w-3 h-3" />
                                  {progress.completed}/{progress.total}
                                </span>
                              )}
                            </div>

                            {isStarted && (
                              <Progress value={progress.percentage} className="h-1.5" />
                            )}

                            <Button
                              size="sm"
                              className="w-full mt-2"
                              variant={isStarted ? "outline" : "default"}
                              onClick={(e) => {
                                e.stopPropagation();
                                navigate(`/science-lens/learning/${course.slug}`);
                              }}
                            >
                              {isStarted ? "Continue Learning" : "Start Course"}
                            </Button>
                          </>
                        )}
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </div>
      ))}

      {/* Empty state */}
      {Object.keys(groupedByCategory).length === 0 && (
        <Card className="bg-card p-12">
          <div className="text-center space-y-2">
            <Search className="w-12 h-12 mx-auto text-muted-foreground" />
            <h3 className="text-xl font-semibold">No Results Found</h3>
            <p className="text-muted-foreground">
              Try adjusting your search or filter criteria
            </p>
            <Button
              variant="outline"
              onClick={() => {
                setSearchQuery("");
                setSelectedCategory("all");
                setSelectedDifficulty("all");
              }}
            >
              Clear Filters
            </Button>
          </div>
        </Card>
      )}
    </div>
  );
}
