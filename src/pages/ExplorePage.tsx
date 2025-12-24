import { Telescope, Microscope, Atom, Dna, FlaskConical, Star, Cpu, Leaf, Globe, Zap, Brain, Heart, Rocket, Waves, Mountain, Beaker } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";

interface CourseProgress {
  courseId: string;
  totalLessons: number;
  completedLessons: number;
  percentage: number;
}

const scienceCategories = [
  {
    icon: Atom,
    title: "Physics",
    description: "Explore the fundamental laws of the universe",
    color: "text-blue-500",
    bgColor: "bg-blue-500/10",
    topics: ["Classical Mechanics", "Quantum Physics", "Thermodynamics", "Electromagnetism", "Optics", "Waves"]
  },
  {
    icon: FlaskConical,
    title: "Chemistry",
    description: "Discover the composition and properties of matter",
    color: "text-emerald-500",
    bgColor: "bg-emerald-500/10",
    topics: ["Organic Chemistry", "Inorganic Chemistry", "Physical Chemistry", "Biochemistry", "Polymers", "Acids & Bases"]
  },
  {
    icon: Dna,
    title: "Biology",
    description: "Understand life and living organisms",
    color: "text-green-500",
    bgColor: "bg-green-500/10",
    topics: ["Cell Biology", "Genetics", "Evolution", "Ecology", "Human Anatomy", "Microbiology"]
  },
  {
    icon: Star,
    title: "Astronomy",
    description: "Journey through space and celestial bodies",
    color: "text-purple-500",
    bgColor: "bg-purple-500/10",
    topics: ["Planetary Science", "Stellar Astronomy", "Cosmology", "Black Holes", "Solar System", "Galaxies"]
  },
  {
    icon: Globe,
    title: "Earth Science",
    description: "Study our planet and its systems",
    color: "text-amber-500",
    bgColor: "bg-amber-500/10",
    topics: ["Geology", "Meteorology", "Oceanography", "Volcanology", "Plate Tectonics", "Climate Science"]
  },
  {
    icon: Cpu,
    title: "Technology",
    description: "Cutting-edge science and engineering",
    color: "text-cyan-500",
    bgColor: "bg-cyan-500/10",
    topics: ["Robotics", "AI & Machine Learning", "Renewable Energy", "Nanotechnology", "Space Technology", "Biotechnology"]
  },
  {
    icon: Brain,
    title: "Neuroscience",
    description: "Explore the mysteries of the brain",
    color: "text-pink-500",
    bgColor: "bg-pink-500/10",
    topics: ["Neural Networks", "Cognitive Science", "Memory & Learning", "Sensory Systems", "Brain Disorders", "Neuroplasticity"]
  },
  {
    icon: Heart,
    title: "Human Body",
    description: "Understand how your body works",
    color: "text-red-500",
    bgColor: "bg-red-500/10",
    topics: ["Cardiovascular System", "Respiratory System", "Digestive System", "Immune System", "Muscular System", "Skeletal System"]
  },
  {
    icon: Leaf,
    title: "Environmental Science",
    description: "Learn about ecosystems and sustainability",
    color: "text-lime-500",
    bgColor: "bg-lime-500/10",
    topics: ["Biodiversity", "Conservation", "Pollution", "Renewable Resources", "Climate Change", "Sustainability"]
  },
  {
    icon: Beaker,
    title: "Materials Science",
    description: "Discover the science of materials",
    color: "text-slate-500",
    bgColor: "bg-slate-500/10",
    topics: ["Metals & Alloys", "Polymers", "Ceramics", "Composites", "Semiconductors", "Nanomaterials"]
  },
  {
    icon: Waves,
    title: "Oceanography",
    description: "Dive into the science of the oceans",
    color: "text-sky-500",
    bgColor: "bg-sky-500/10",
    topics: ["Marine Biology", "Ocean Currents", "Deep Sea", "Coral Reefs", "Marine Ecosystems", "Ocean Chemistry"]
  },
  {
    icon: Rocket,
    title: "Space Exploration",
    description: "The frontier of human exploration",
    color: "text-orange-500",
    bgColor: "bg-orange-500/10",
    topics: ["Rocket Science", "Space Missions", "Mars Exploration", "Satellites", "Space Stations", "Future of Space"]
  }
];

export default function ExplorePage() {
  const navigate = useNavigate();
  const [courseProgress, setCourseProgress] = useState<Map<string, CourseProgress>>(new Map());
  const [userId, setUserId] = useState<string | null>(null);

  useEffect(() => {
    const loadUserProgress = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.user) return;
      
      setUserId(session.user.id);

      // Fetch courses and lessons
      const { data: courses } = await supabase.from('courses').select('id, slug, title, category');
      const { data: lessons } = await supabase.from('lessons').select('id, course_id');
      const { data: progress } = await supabase
        .from('user_progress')
        .select('lesson_id, status')
        .eq('user_id', session.user.id);

      if (courses && lessons) {
        const progressMap = new Map<string, CourseProgress>();
        
        courses.forEach(course => {
          const courseLessons = lessons.filter(l => l.course_id === course.id);
          const completedLessons = progress?.filter(p => 
            courseLessons.some(l => l.id === p.lesson_id) && p.status === 'completed'
          ).length || 0;
          
          progressMap.set(course.category || 'General', {
            courseId: course.id,
            totalLessons: courseLessons.length,
            completedLessons,
            percentage: courseLessons.length > 0 
              ? Math.round((completedLessons / courseLessons.length) * 100) 
              : 0
          });
        });
        
        setCourseProgress(progressMap);
      }
    };

    loadUserProgress();
  }, []);

  const getCategoryProgress = (categoryTitle: string): number => {
    const progress = courseProgress.get(categoryTitle);
    return progress?.percentage || 0;
  };

  const getCategoryLessons = (categoryTitle: string): { completed: number; total: number } => {
    const progress = courseProgress.get(categoryTitle);
    return {
      completed: progress?.completedLessons || 0,
      total: progress?.totalLessons || 0
    };
  };

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          Explore Science
        </h1>
        <p className="text-muted-foreground">
          Discover the vast world of scientific knowledge across {scienceCategories.length} categories
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        {scienceCategories.map((category) => {
          const progress = getCategoryProgress(category.title);
          const lessons = getCategoryLessons(category.title);
          const isStarted = progress > 0;
          const isCompleted = progress === 100;

          return (
            <Card 
              key={category.title} 
              className="hover:shadow-cosmic transition-all duration-300 group cursor-pointer relative overflow-hidden"
              onClick={() => navigate("/science-lens/learning")}
            >
              {/* Progress indicator strip */}
              {isStarted && (
                <div 
                  className="absolute top-0 left-0 h-1 bg-primary transition-all duration-500"
                  style={{ width: `${progress}%` }}
                />
              )}
              
              <CardHeader className="pb-3">
                <div className="flex items-center justify-between mb-2">
                  <div className={`p-2.5 rounded-xl ${category.bgColor} group-hover:scale-110 transition-transform`}>
                    <category.icon className={`w-6 h-6 ${category.color}`} />
                  </div>
                  {isCompleted ? (
                    <Badge variant="default" className="bg-green-500/20 text-green-600 border-green-500/30">
                      Completed
                    </Badge>
                  ) : isStarted ? (
                    <Badge variant="secondary" className="bg-primary/10 text-primary border-primary/20">
                      {progress}%
                    </Badge>
                  ) : null}
                </div>
                <CardTitle className="group-hover:text-primary transition-colors text-lg">
                  {category.title}
                </CardTitle>
                <CardDescription className="text-sm">{category.description}</CardDescription>
              </CardHeader>
              
              <CardContent className="pt-0">
                <div className="space-y-3">
                  {/* Topics preview */}
                  <div className="flex flex-wrap gap-1.5">
                    {category.topics.slice(0, 4).map((topic) => (
                      <span 
                        key={topic} 
                        className="text-xs px-2 py-0.5 rounded-full bg-muted/50 text-muted-foreground"
                      >
                        {topic}
                      </span>
                    ))}
                    {category.topics.length > 4 && (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-muted/50 text-muted-foreground">
                        +{category.topics.length - 4} more
                      </span>
                    )}
                  </div>
                  
                  {/* Progress bar */}
                  {userId && (
                    <div className="space-y-1.5">
                      <Progress value={progress} className="h-1.5" />
                      <div className="flex justify-between text-xs text-muted-foreground">
                        <span>{lessons.completed} / {lessons.total || '?'} lessons</span>
                        {isStarted && !isCompleted && <span>In Progress</span>}
                      </div>
                    </div>
                  )}
                  
                  <Button 
                    variant={isStarted ? "default" : "outline"}
                    className="w-full mt-2"
                    size="sm"
                  >
                    {isCompleted ? "Review" : isStarted ? "Continue" : "Start Learning"}
                  </Button>
                </div>
              </CardContent>
            </Card>
          );
        })}
      </div>

      {/* Quick Stats Section */}
      {userId && (
        <div className="mt-10 p-6 rounded-2xl bg-card border">
          <h2 className="text-xl font-semibold mb-4">Your Learning Journey</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="text-center p-4 rounded-xl bg-muted/30">
              <div className="text-3xl font-bold text-primary">
                {Array.from(courseProgress.values()).filter(p => p.percentage > 0).length}
              </div>
              <div className="text-sm text-muted-foreground">Categories Started</div>
            </div>
            <div className="text-center p-4 rounded-xl bg-muted/30">
              <div className="text-3xl font-bold text-green-500">
                {Array.from(courseProgress.values()).filter(p => p.percentage === 100).length}
              </div>
              <div className="text-sm text-muted-foreground">Completed</div>
            </div>
            <div className="text-center p-4 rounded-xl bg-muted/30">
              <div className="text-3xl font-bold text-amber-500">
                {Array.from(courseProgress.values()).reduce((sum, p) => sum + p.completedLessons, 0)}
              </div>
              <div className="text-sm text-muted-foreground">Lessons Done</div>
            </div>
            <div className="text-center p-4 rounded-xl bg-muted/30">
              <div className="text-3xl font-bold text-purple-500">
                {scienceCategories.length - Array.from(courseProgress.values()).filter(p => p.percentage > 0).length}
              </div>
              <div className="text-sm text-muted-foreground">To Explore</div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
