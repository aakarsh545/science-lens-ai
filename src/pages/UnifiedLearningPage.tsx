import { useEffect, useState, useMemo } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  BookOpen, Search, Filter, Loader2, Trophy, Sparkles,
  ChevronDown, ChevronRight, FolderOpen, FileText, Lock,
  CheckCircle2, Clock, Award, ArrowLeft, X
} from "lucide-react";

// Types
interface Topic {
  id: string;
  name: string;
  description: string;
  icon: string;
  difficulty_level: string;
  category: string;
}

interface TopicProgress {
  topic_id: string;
  questions_answered: number;
  correct_answers: number;
  completion_percentage: number;
}

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  lesson_count: number;
}

interface Lesson {
  id: string;
  slug: string;
  title: string;
  order_index: number;
  xp_reward: number;
}

interface CourseDetail {
  id: string;
  title: string;
  description: string;
  category: string;
  lessons: Lesson[];
}

interface CourseProgress {
  completed: number;
  total: number;
  percentage: number;
}

interface UserProgress {
  lesson_id: string;
  status: string;
}

interface LessonGroup {
  name: string;
  lessons: Lesson[];
}

export default function UnifiedLearningPage() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);

  // Topics state
  const [topics, setTopics] = useState<Topic[]>([]);
  const [topicProgress, setTopicProgress] = useState<Record<string, TopicProgress>>({});

  // Courses state
  const [courses, setCourses] = useState<Course[]>([]);
  const [courseProgress, setCourseProgress] = useState<Record<string, CourseProgress>>({});

  // Filter state
  const [difficultyTab, setDifficultyTab] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("all");

  // Expanded course state (for showing tree inline)
  const [expandedCourse, setExpandedCourse] = useState<CourseDetail | null>(null);
  const [expandedCourseProgress, setExpandedCourseProgress] = useState<UserProgress[]>([]);
  const [loadingCourse, setLoadingCourse] = useState(false);
  const [openGroups, setOpenGroups] = useState<Record<string, boolean>>({});

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
      loadTopics(),
      loadTopicProgress(session.user.id),
      loadCourses(),
      loadCourseProgress(session.user.id)
    ]);
    setLoading(false);
  };

  const loadTopics = async () => {
    const { data } = await supabase
      .from("learning_topics")
      .select("*")
      .order("order_index");
    if (data) setTopics(data);
  };

  const loadTopicProgress = async (uid: string) => {
    const { data } = await supabase
      .from("user_topic_progress")
      .select("*")
      .eq("user_id", uid);
    if (data) {
      const progressMap: Record<string, TopicProgress> = {};
      data.forEach(p => { progressMap[p.topic_id] = p; });
      setTopicProgress(progressMap);
    }
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

  // Load expanded course details with lessons
  const loadCourseDetails = async (courseSlug: string) => {
    setLoadingCourse(true);
    const { data, error } = await supabase.functions.invoke('courses', {
      body: { slug: courseSlug }
    });

    if (!error && data) {
      setExpandedCourse(data);

      // Load user progress for this course's lessons
      if (userId) {
        const { data: progressData } = await supabase
          .from('user_progress')
          .select('lesson_id, status')
          .eq('user_id', userId);
        if (progressData) setExpandedCourseProgress(progressData);
      }

      // Initialize all groups as open
      const groups = groupLessons(data.lessons);
      const initialOpen: Record<string, boolean> = {};
      groups.forEach(g => { initialOpen[g.name] = true; });
      setOpenGroups(initialOpen);
    }
    setLoadingCourse(false);
  };

  // Group lessons by detecting patterns
  const groupLessons = (lessons: Lesson[]): LessonGroup[] => {
    if (!lessons || lessons.length === 0) return [];

    const sortedLessons = [...lessons].sort((a, b) => a.order_index - b.order_index);
    const groups: LessonGroup[] = [];
    let currentGroup: LessonGroup | null = null;

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
      const numberMatch = lowerTitle.match(/^\d+\.\s*/);
      if (numberMatch) {
        const afterNumber = lowerTitle.slice(numberMatch[0].length);
        for (const keyword of sectionKeywords) {
          if (afterNumber.startsWith(keyword)) {
            return keyword.charAt(0).toUpperCase() + keyword.slice(1);
          }
        }
      }
      for (const keyword of sectionKeywords) {
        if (lowerTitle.includes(keyword)) {
          return keyword.charAt(0).toUpperCase() + keyword.slice(1);
        }
      }
      const colonIndex = title.indexOf(':');
      if (colonIndex > 0 && colonIndex < 30) {
        return title.slice(0, colonIndex).trim();
      }
      return null;
    };

    sortedLessons.forEach((lesson, idx) => {
      const sectionName = detectSection(lesson.title);
      if (sectionName && (!currentGroup || currentGroup.name !== sectionName)) {
        currentGroup = { name: sectionName, lessons: [lesson] };
        groups.push(currentGroup);
      } else if (currentGroup) {
        currentGroup.lessons.push(lesson);
      } else {
        if (idx < 3) {
          if (!groups.find(g => g.name === 'Getting Started')) {
            currentGroup = { name: 'Getting Started', lessons: [lesson] };
            groups.push(currentGroup);
          } else {
            groups.find(g => g.name === 'Getting Started')?.lessons.push(lesson);
          }
        } else {
          const miscGroup = groups.find(g => g.name === 'Other Topics');
          if (miscGroup) {
            miscGroup.lessons.push(lesson);
          } else {
            groups.push({ name: 'Other Topics', lessons: [lesson] });
          }
        }
      }
    });

    if (groups.length <= 1 || sortedLessons.length <= 5) {
      return [{ name: '', lessons: sortedLessons }];
    }
    return groups;
  };

  const groupedLessons = useMemo(() => {
    if (!expandedCourse?.lessons) return [];
    return groupLessons(expandedCourse.lessons);
  }, [expandedCourse?.lessons]);

  // Filter logic
  const categories = useMemo(() => {
    const topicCats = [...new Set(topics.map(t => t.category))];
    const courseCats = [...new Set(courses.map(c => c.category))];
    return ["all", ...new Set([...topicCats, ...courseCats])];
  }, [topics, courses]);

  const filteredTopics = useMemo(() => {
    return topics.filter(t => {
      const matchesDifficulty = difficultyTab === "all" || t.difficulty_level === difficultyTab;
      const matchesSearch = !searchQuery ||
        t.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        t.description.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesCategory = selectedCategory === "all" || t.category === selectedCategory;
      return matchesDifficulty && matchesSearch && matchesCategory;
    });
  }, [topics, difficultyTab, searchQuery, selectedCategory]);

  const filteredCourses = useMemo(() => {
    return courses.filter(c => {
      const matchesSearch = !searchQuery ||
        c.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
        c.description.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesCategory = selectedCategory === "all" || c.category === selectedCategory;
      return matchesSearch && matchesCategory;
    });
  }, [courses, searchQuery, selectedCategory]);

  // Group items by category
  const groupedByCategory = useMemo(() => {
    const groups: Record<string, { topics: Topic[], courses: Course[] }> = {};

    filteredTopics.forEach(t => {
      if (!groups[t.category]) groups[t.category] = { topics: [], courses: [] };
      groups[t.category].topics.push(t);
    });

    filteredCourses.forEach(c => {
      if (!groups[c.category]) groups[c.category] = { topics: [], courses: [] };
      groups[c.category].courses.push(c);
    });

    return groups;
  }, [filteredTopics, filteredCourses]);

  // Lesson helpers
  const getLessonStatus = (lessonId: string) => {
    const progress = expandedCourseProgress.find(p => p.lesson_id === lessonId);
    return progress?.status || 'not_started';
  };

  const isLessonUnlocked = (lesson: Lesson, allLessons: Lesson[]) => {
    const sorted = [...allLessons].sort((a, b) => a.order_index - b.order_index);
    const idx = sorted.findIndex(l => l.id === lesson.id);
    if (idx === 0) return true;
    if (!userId) return false;
    const prev = sorted[idx - 1];
    return prev ? getLessonStatus(prev.id) === 'completed' : false;
  };

  const getGroupProgress = (lessons: Lesson[]) => {
    const completed = lessons.filter(l => getLessonStatus(l.id) === 'completed').length;
    return { completed, total: lessons.length };
  };

  const getDifficultyBadgeClass = (level: string) => {
    switch (level) {
      case "beginner": return "bg-green-500/20 text-green-400 border-green-500/50";
      case "intermediate": return "bg-indigo-500/20 text-indigo-400 border-indigo-500/50";
      case "advanced": return "bg-orange-500/20 text-orange-400 border-orange-500/50";
      default: return "";
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  // If a course is expanded, show the course detail with tree
  if (expandedCourse) {
    const completedLessons = expandedCourse.lessons.filter(l => getLessonStatus(l.id) === 'completed').length;
    const progressPercentage = expandedCourse.lessons.length > 0
      ? Math.round((completedLessons / expandedCourse.lessons.length) * 100)
      : 0;

    return (
      <div className="p-6 max-w-4xl mx-auto space-y-6">
        <Button
          variant="ghost"
          onClick={() => setExpandedCourse(null)}
          className="mb-4"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to All Courses
        </Button>

        {/* Course Header */}
        <Card className="border-primary/20">
          <CardHeader>
            <div className="flex items-start justify-between">
              <div className="flex-1 space-y-2">
                <Badge variant="secondary">{expandedCourse.category}</Badge>
                <CardTitle className="text-3xl">{expandedCourse.title}</CardTitle>
                <CardDescription className="text-base">{expandedCourse.description}</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex items-center gap-6 text-sm">
              <div className="flex items-center gap-2">
                <BookOpen className="w-4 h-4 text-primary" />
                <span>{expandedCourse.lessons.length} lessons</span>
              </div>
              <div className="flex items-center gap-2">
                <Award className="w-4 h-4 text-yellow-500" />
                <span>{expandedCourse.lessons.reduce((sum, l) => sum + (l.xp_reward || 10), 0)} XP total</span>
              </div>
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-4 h-4 text-green-500" />
                <span>{completedLessons}/{expandedCourse.lessons.length} completed ({progressPercentage}%)</span>
              </div>
            </div>
            <Progress value={progressPercentage} className="h-2" />
          </CardContent>
        </Card>

        {/* Lessons Tree */}
        <div className="space-y-4">
          <h2 className="text-2xl font-semibold">Lessons</h2>
          <div className="space-y-2">
            {groupedLessons.map((group) => {
              const groupProgress = getGroupProgress(group.lessons);
              const isOpen = openGroups[group.name] ?? true;

              if (!group.name) {
                return (
                  <div key="flat" className="space-y-3">
                    {group.lessons.map((lesson) => (
                      <LessonCard
                        key={lesson.id}
                        lesson={lesson}
                        courseSlug={expandedCourse.id}
                        status={getLessonStatus(lesson.id)}
                        isUnlocked={isLessonUnlocked(lesson, expandedCourse.lessons)}
                        onClick={() => {
                          const course = courses.find(c => c.id === expandedCourse.id);
                          if (course) navigate(`/science-lens/learn/${course.slug}/${lesson.slug}`);
                        }}
                      />
                    ))}
                  </div>
                );
              }

              return (
                <Collapsible
                  key={group.name}
                  open={isOpen}
                  onOpenChange={() => setOpenGroups(prev => ({ ...prev, [group.name]: !prev[group.name] }))}
                >
                  <CollapsibleTrigger asChild>
                    <div className="flex items-center gap-3 p-3 rounded-lg bg-muted/30 hover:bg-muted/50 cursor-pointer transition-colors">
                      {isOpen ? <ChevronDown className="w-5 h-5 text-muted-foreground" /> : <ChevronRight className="w-5 h-5 text-muted-foreground" />}
                      <FolderOpen className="w-5 h-5 text-primary" />
                      <span className="font-semibold flex-1">{group.name}</span>
                      <Badge variant="outline" className="text-xs">{groupProgress.completed}/{groupProgress.total}</Badge>
                    </div>
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <div className="ml-4 mt-2 space-y-2 border-l-2 border-muted pl-4">
                      {group.lessons.map((lesson) => (
                        <LessonCard
                          key={lesson.id}
                          lesson={lesson}
                          courseSlug={expandedCourse.id}
                          status={getLessonStatus(lesson.id)}
                          isUnlocked={isLessonUnlocked(lesson, expandedCourse.lessons)}
                          onClick={() => {
                            const course = courses.find(c => c.id === expandedCourse.id);
                            if (course) navigate(`/science-lens/learn/${course.slug}/${lesson.slug}`);
                          }}
                          indented
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

      {/* Tabs + Search Row (Variation 1) */}
      <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4 mb-8">
        {/* Difficulty Tabs */}
        <Tabs value={difficultyTab} onValueChange={setDifficultyTab} className="w-full lg:w-auto">
          <TabsList className="grid grid-cols-4 w-full lg:w-auto">
            <TabsTrigger value="all">All Topics</TabsTrigger>
            <TabsTrigger value="beginner">Beginner</TabsTrigger>
            <TabsTrigger value="intermediate">Intermediate</TabsTrigger>
            <TabsTrigger value="advanced">Advanced</TabsTrigger>
          </TabsList>
        </Tabs>

        {/* Search + Category Filter */}
        <div className="flex gap-3 w-full lg:w-auto">
          <div className="relative flex-1 lg:w-64">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input
              placeholder="Search topics..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-10"
            />
          </div>
          <Select value={selectedCategory} onValueChange={setSelectedCategory}>
            <SelectTrigger className="w-full lg:w-[180px]">
              <Filter className="w-4 h-4 mr-2" />
              <SelectValue placeholder="All Categories" />
            </SelectTrigger>
            <SelectContent>
              {categories.map((cat) => (
                <SelectItem key={cat} value={cat}>
                  {cat === "all" ? "All Categories" : cat}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Content grouped by category */}
      {Object.entries(groupedByCategory).map(([category, items]) => (
        <div key={category} className="mb-8">
          <div className="flex items-center gap-2 mb-4">
            <h2 className="text-xl font-semibold capitalize">{category}</h2>
            <Badge variant="secondary">
              {items.topics.length + items.courses.length} items
            </Badge>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {/* Topics */}
            {items.topics.map((topic) => {
              const progress = topicProgress[topic.id];
              const completionPct = progress?.completion_percentage || 0;

              return (
                <Card key={topic.id} className="hover:border-primary/50 transition-all cursor-pointer group">
                  <CardContent className="p-4">
                    <div className="flex gap-3">
                      <span className="text-3xl">{topic.icon}</span>
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center justify-between">
                          <h4 className="font-semibold group-hover:text-primary transition-colors">
                            {topic.name}
                          </h4>
                          <Badge className={getDifficultyBadgeClass(topic.difficulty_level)}>
                            {topic.difficulty_level}
                          </Badge>
                        </div>
                        <p className="text-sm text-muted-foreground line-clamp-2">
                          {topic.description}
                        </p>

                        {progress && (
                          <div className="space-y-1">
                            <div className="flex justify-between text-xs text-muted-foreground">
                              <span>{progress.questions_answered} questions</span>
                              <span>{completionPct}%</span>
                            </div>
                            <Progress value={completionPct} className="h-1.5" />
                            <div className="flex gap-3 text-xs text-muted-foreground">
                              <span className="flex items-center gap-1">
                                <Trophy className="w-3 h-3" />
                                {progress.correct_answers} correct
                              </span>
                            </div>
                          </div>
                        )}

                        <Button
                          size="sm"
                          className="w-full mt-2"
                          variant={completionPct > 0 ? "outline" : "default"}
                          onClick={() => navigate("/science-lens/ask", { state: { topic } })}
                        >
                          {completionPct > 0 ? "Continue Learning" : "Start Learning"}
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}

            {/* Courses */}
            {items.courses.map((course) => {
              const progress = courseProgress[course.id] || { completed: 0, total: 0, percentage: 0 };
              const isStarted = progress.completed > 0;

              return (
                <Card
                  key={course.id}
                  className="hover:border-primary/50 transition-all cursor-pointer group"
                >
                  <CardContent className="p-4">
                    <div className="flex gap-3">
                      <div className="w-12 h-12 rounded-lg bg-primary/20 flex items-center justify-center flex-shrink-0">
                        <BookOpen className="w-6 h-6 text-primary" />
                      </div>
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center justify-between">
                          <h4 className="font-semibold group-hover:text-primary transition-colors">
                            {course.title}
                          </h4>
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
                          disabled={loadingCourse}
                          onClick={() => loadCourseDetails(course.slug)}
                        >
                          {loadingCourse ? (
                            <Loader2 className="w-4 h-4 animate-spin mr-2" />
                          ) : null}
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
        <Card className="p-12">
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
                setDifficultyTab("all");
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

// Lesson Card Component
interface LessonCardProps {
  lesson: Lesson;
  courseSlug: string;
  status: string;
  isUnlocked: boolean;
  onClick: () => void;
  indented?: boolean;
}

function LessonCard({ lesson, status, isUnlocked, onClick, indented }: LessonCardProps) {
  const isCompleted = status === 'completed';

  return (
    <Card
      className={`
        transition-all cursor-pointer
        ${isUnlocked ? 'hover:shadow-lg hover:border-primary/50' : 'opacity-60 cursor-not-allowed'}
        ${isCompleted ? 'border-green-500/30 bg-green-500/5' : ''}
      `}
      onClick={isUnlocked ? onClick : undefined}
    >
      <CardContent className={`p-4 ${indented ? 'py-3' : ''}`}>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3 flex-1">
            <div className={`
              w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold
              ${isCompleted
                ? 'bg-green-500/20 text-green-400'
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
            <Badge variant="outline" className="text-xs">Locked</Badge>
          )}
        </div>
      </CardContent>
    </Card>
  );
}
