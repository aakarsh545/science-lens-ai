import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { 
  ArrowLeft, 
  ArrowRight, 
  Lightbulb, 
  CheckCircle2, 
  Award, 
  Loader2,
  Sparkles,
  BookOpen
} from "lucide-react";
import { calculateLevel, didLevelUp } from "@/utils/levelCalculations";
import { triggerLevelUpConfetti, triggerLessonCompleteConfetti } from "@/utils/confettiEffects";

interface Lesson {
  id: string;
  title: string;
  content: string;
  animations: any;
  examples: any;
  quiz: any;
  xp_reward: number;
  order_index: number;
}

interface QuizQuestion {
  question: string;
  options: string[];
  correctAnswer: number;
  explanation: string;
}

export default function LessonPlayer() {
  const { courseSlug, lessonSlug } = useParams();
  const navigate = useNavigate();
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [isCompleted, setIsCompleted] = useState(false);
  const [completingLesson, setCompletingLesson] = useState(false);
  
  // Quiz state
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, number>>({});
  const [showResults, setShowResults] = useState<Record<number, boolean>>({});
  
  // AI hint state
  const [aiHint, setAiHint] = useState<string | null>(null);
  const [loadingHint, setLoadingHint] = useState(false);

  useEffect(() => {
    const init = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) {
        setUserId(session.user.id);
        await loadLesson(session.user.id);
      } else {
        navigate('/');
      }
    };
    init();
  }, [courseSlug, lessonSlug]);

  const loadLesson = async (uid: string) => {
    try {
      // Get course to find lesson by slug
      const { data: courseData } = await supabase.functions.invoke('courses', {
        body: { slug: courseSlug }
      });

      if (courseData?.lessons) {
        const foundLesson = courseData.lessons.find((l: any) => l.slug === lessonSlug);
        
        if (foundLesson) {
          const { data: lessonData } = await supabase.functions.invoke('lessons', {
            body: { id: foundLesson.id }
          });

          if (lessonData) {
            setLesson(lessonData);

            // Check if already completed
            const { data: progress } = await supabase
              .from('user_progress')
              .select('status')
              .eq('user_id', uid)
              .eq('lesson_id', lessonData.id)
              .maybeSingle();

            setIsCompleted(progress?.status === 'completed');
          }
        }
      }
    } catch (error) {
      console.error('Error loading lesson:', error);
      toast.error('Failed to load lesson');
    } finally {
      setLoading(false);
    }
  };

  const handleQuizSubmit = (questionIndex: number) => {
    setShowResults(prev => ({ ...prev, [questionIndex]: true }));
    
    const quiz = lesson?.quiz;
    if (quiz?.questions?.[questionIndex]) {
      const isCorrect = selectedAnswers[questionIndex] === quiz.questions[questionIndex].correctAnswer;
      
      if (isCorrect) {
        toast.success('Correct! Well done! 🎉');
      } else {
        toast.error('Not quite right. Review the explanation below.');
      }
    }
  };

  const handleMarkComplete = async () => {
    if (!userId || !lesson) return;

    setCompletingLesson(true);
    try {
      // Get current XP
      const { data: currentStats } = await supabase
        .from('user_stats')
        .select('xp_total')
        .eq('user_id', userId)
        .single();

      const oldXp = currentStats?.xp_total || 0;

      // Mark lesson complete
      const { data, error } = await supabase.functions.invoke('lessons', {
        body: { 
          id: lesson.id,
          action: 'complete'
        }
      });

      if (error) {
        if (error.message?.includes('credits')) {
          toast.error('Not enough credits');
          return;
        }
        throw error;
      }

      const newXp = data?.stats?.xp_total || oldXp;

      // Check for level up
      if (didLevelUp(oldXp, newXp)) {
        triggerLevelUpConfetti();
        const newLevel = calculateLevel(newXp);
        toast.success(`🎊 Level Up! You're now level ${newLevel}!`);
      } else {
        triggerLessonCompleteConfetti();
      }

      if (data?.alreadyCompleted) {
        toast.info('You already completed this lesson!');
      } else {
        toast.success(`Lesson complete! +${lesson.xp_reward || 10} XP earned! 🌟`);
      }

      setIsCompleted(true);
    } catch (error) {
      console.error('Error completing lesson:', error);
      toast.error('Failed to mark lesson as complete');
    } finally {
      setCompletingLesson(false);
    }
  };

  const handleGetHint = async () => {
    if (!userId || !lesson) return;

    setLoadingHint(true);
    try {
      const { data, error } = await supabase.functions.invoke('ai-hint', {
        body: {
          question: `I need help understanding: ${lesson.title}`,
          context: lesson.content?.substring(0, 500)
        }
      });

      if (error) {
        if (error.message?.includes('credits_exhausted')) {
          toast.error('Credits exhausted! Visit the Pricing page to get more.');
          navigate('/pricing');
          return;
        }
        throw error;
      }

      setAiHint(data.hint);
      toast.success('AI hint generated!');
    } catch (error) {
      console.error('Error getting hint:', error);
      toast.error('Failed to get AI hint');
    } finally {
      setLoadingHint(false);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!lesson) {
    return (
      <div className="container mx-auto p-6">
        <Card className="p-12">
          <div className="text-center space-y-2">
            <BookOpen className="w-12 h-12 mx-auto text-muted-foreground" />
            <h3 className="text-xl font-semibold">Lesson Not Found</h3>
            <Button onClick={() => navigate(`/learn/${courseSlug}`)} className="mt-4">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Course
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const quiz = lesson.quiz;
  const animations = Array.isArray(lesson.animations) ? lesson.animations : [];
  const examples = Array.isArray(lesson.examples) ? lesson.examples : [];

  return (
    <div className="container mx-auto p-6 max-w-4xl space-y-6">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Button 
          variant="ghost" 
          size="sm"
          onClick={() => navigate('/learning')}
        >
          Courses
        </Button>
        <span>/</span>
        <Button 
          variant="ghost" 
          size="sm"
          onClick={() => navigate(`/learn/${courseSlug}`)}
        >
          {courseSlug?.replace(/-/g, ' ')}
        </Button>
        <span>/</span>
        <span className="text-foreground">{lesson.title}</span>
      </div>

      {/* Lesson Header */}
      <Card className="card-cosmic">
        <CardHeader>
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <CardTitle className="text-3xl mb-2">{lesson.title}</CardTitle>
              <div className="flex items-center gap-4 text-sm">
                <Badge variant="secondary">
                  <Award className="w-3 h-3 mr-1" />
                  +{lesson.xp_reward || 10} XP
                </Badge>
                {isCompleted && (
                  <Badge variant="outline" className="border-success text-success">
                    <CheckCircle2 className="w-3 h-3 mr-1" />
                    Completed
                  </Badge>
                )}
              </div>
            </div>
          </div>
        </CardHeader>
      </Card>

      {/* Content */}
      <Card>
        <CardContent className="p-6 prose prose-invert max-w-none">
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {lesson.content || ''}
          </ReactMarkdown>
        </CardContent>
      </Card>

      {/* Animations */}
      {animations.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">Visual Concepts</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {animations.map((anim: any, idx: number) => (
              <div key={idx} className="p-4 border border-border rounded-lg bg-muted/20">
                <div className="flex items-center gap-3 mb-2">
                  <Sparkles className="w-5 h-5 text-primary" />
                  <h4 className="font-semibold">{anim.title || 'Animation'}</h4>
                </div>
                <div className="aspect-video bg-muted/40 rounded flex items-center justify-center text-muted-foreground">
                  <div className="text-center">
                    <BookOpen className="w-12 h-12 mx-auto mb-2 opacity-50" />
                    <p className="text-sm">Animation placeholder</p>
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Examples */}
      {examples.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">Real-World Examples</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {examples.map((example: any, idx: number) => (
              <div key={idx} className="p-4 border border-border rounded-lg bg-muted/20">
                <h4 className="font-semibold mb-2">{example.title}</h4>
                <p className="text-muted-foreground">{example.description}</p>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Quiz */}
      {quiz?.questions && quiz.questions.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">Test Your Knowledge</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            {quiz.questions.map((q: QuizQuestion, qIdx: number) => (
              <div key={qIdx} className="space-y-4">
                <h4 className="font-semibold text-lg">{q.question}</h4>
                
                <RadioGroup
                  value={selectedAnswers[qIdx]?.toString()}
                  onValueChange={(val) => setSelectedAnswers(prev => ({ ...prev, [qIdx]: parseInt(val) }))}
                  disabled={showResults[qIdx]}
                >
                  {q.options.map((option, optIdx) => {
                    const isSelected = selectedAnswers[qIdx] === optIdx;
                    const isCorrect = optIdx === q.correctAnswer;
                    const showFeedback = showResults[qIdx];

                    return (
                      <div 
                        key={optIdx}
                        className={`
                          flex items-center space-x-2 p-3 rounded-lg border transition-colors
                          ${showFeedback && isCorrect ? 'border-success bg-success/10' : ''}
                          ${showFeedback && isSelected && !isCorrect ? 'border-destructive bg-destructive/10' : ''}
                          ${!showFeedback ? 'hover:bg-muted/50' : ''}
                        `}
                      >
                        <RadioGroupItem value={optIdx.toString()} id={`q${qIdx}-opt${optIdx}`} />
                        <Label htmlFor={`q${qIdx}-opt${optIdx}`} className="flex-1 cursor-pointer">
                          {option}
                        </Label>
                        {showFeedback && isCorrect && (
                          <CheckCircle2 className="w-5 h-5 text-success" />
                        )}
                      </div>
                    );
                  })}
                </RadioGroup>

                {!showResults[qIdx] && selectedAnswers[qIdx] !== undefined && (
                  <Button onClick={() => handleQuizSubmit(qIdx)}>
                    Submit Answer
                  </Button>
                )}

                {showResults[qIdx] && (
                  <Card className="border-primary/20 bg-primary/5">
                    <CardContent className="p-4">
                      <p className="text-sm"><strong>Explanation:</strong> {q.explanation}</p>
                    </CardContent>
                  </Card>
                )}
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* AI Hint Section */}
      <Card className="border-primary/30">
        <CardHeader>
          <CardTitle className="text-xl flex items-center gap-2">
            <Lightbulb className="w-5 h-5 text-achievement" />
            Need Help?
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p className="text-muted-foreground text-sm">
            Get an AI-powered hint to better understand this lesson (costs 1 credit)
          </p>
          
          <Button 
            onClick={handleGetHint}
            disabled={loadingHint}
            variant="outline"
            className="border-primary/30"
          >
            {loadingHint ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Getting hint...
              </>
            ) : (
              <>
                <Lightbulb className="w-4 h-4 mr-2" />
                Get AI Hint
              </>
            )}
          </Button>

          {aiHint && (
            <Card className="border-achievement/30 bg-achievement/5">
              <CardContent className="p-4">
                <p className="text-sm whitespace-pre-wrap">{aiHint}</p>
              </CardContent>
            </Card>
          )}
        </CardContent>
      </Card>

      {/* Action Buttons */}
      <div className="flex items-center justify-between pt-6 border-t border-border">
        <Button 
          variant="outline"
          onClick={() => navigate(`/learn/${courseSlug}`)}
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Back to Course
        </Button>

        <Button
          onClick={handleMarkComplete}
          disabled={isCompleted || completingLesson}
          className="btn-achievement"
        >
          {completingLesson ? (
            <>
              <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              Completing...
            </>
          ) : isCompleted ? (
            <>
              <CheckCircle2 className="w-4 h-4 mr-2" />
              Completed
            </>
          ) : (
            <>
              <Award className="w-4 h-4 mr-2" />
              Mark Complete
            </>
          )}
        </Button>
      </div>
    </div>
  );
}
