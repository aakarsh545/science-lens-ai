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
import { BookOpen, Search, Filter, Loader2, CheckCircle2 } from "lucide-react";

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

export default function UnifiedLearningPage() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);

  // Courses state
  const [courses, setCourses] = useState<Course[]>([]);
  const [courseProgress, setCourseProgress] = useState<Record<string, CourseProgress>>({});

  // Filter state
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("all");

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
      loadCourseProgress(session.user.id)
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
      return matchesSearch && matchesCategory;
    });
  }, [courses, searchQuery, selectedCategory]);

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
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-4xl font-bold bg-gradient-to-r from-indigo-400 to-purple-400 bg-clip-text text-transparent mb-2">
          Learn Science
        </h1>
        <p className="text-muted-foreground">
          Master science topics with interactive lessons, quizzes, and AI assistance
        </p>
      </div>

      {/* Search + Category Filter */}
      <div className="flex flex-col sm:flex-row gap-3 mb-8">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
          <Input
            placeholder="Search courses..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10"
          />
        </div>
        <Select value={selectedCategory} onValueChange={setSelectedCategory}>
          <SelectTrigger className="w-full sm:w-[180px]">
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

              return (
                <Card
                  key={course.id}
                  className="bg-card hover:border-primary/50 transition-all cursor-pointer group"
                >
                  <CardContent className="p-4">
                    <div className="flex gap-3">
                      <div className="w-12 h-12 rounded-lg bg-primary/20 flex items-center justify-center flex-shrink-0">
                        <BookOpen className="w-6 h-6 text-primary" />
                      </div>
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center justify-between gap-2">
                          <h4 className="font-semibold group-hover:text-primary transition-colors min-w-0 truncate">
                            {course.title}
                          </h4>
                          {course.difficulty && (
                            <Badge className={`flex-shrink-0 ${getDifficultyBadgeClass(course.difficulty)}`}>
                              {course.difficulty}
                            </Badge>
                          )}
                        </div>
                        <p className="text-sm text-muted-foreground line-clamp-2">
                          {course.description}
                        </p>

                        <div className="flex items-center gap-3 text-xs text-muted-foreground">
                          <span className="flex items-center gap-1">
                            <BookOpen className="w-3 h-3" />
                            {course.lesson_count} lessons
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
                          onClick={() => navigate(`/science-lens/learn/${course.slug}`)}
                        >
                          {isStarted ? "Continue Learning" : "Start Course"}
                        </Button>
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
