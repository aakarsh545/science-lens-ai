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
import TopicVisual from "@/components/animations/TopicVisual";
import RelatedConceptsDropdown from "@/components/lessons/RelatedConceptsDropdown";
import QuizResults from "@/pages/QuizResults";
import {
  ArrowLeft,
  ArrowRight,
  Lightbulb,
  CheckCircle2,
  Award,
  Loader2,
  BookOpen,
  Trophy
} from "lucide-react";
import { calculateLevel, didLevelUp } from "@/utils/levelCalculations";
import { triggerLevelUpConfetti, triggerLessonCompleteConfetti } from "@/utils/confettiEffects";
import { logLessonCompleted, logQuizCompleted, logLevelUp } from "@/utils/activityLogging";
import { checkLessonAchievements, checkQuizAchievements, checkLevelAchievements } from "@/utils/achievements";

interface LessonExample {
  title: string;
  description: string;
}

interface QuizAnswer {
  question: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  explanation?: string;
}

interface LessonQuizResults {
  id?: string;
  quizType: 'lesson';
  lessonId?: string;
  totalQuestions: number;
  correctAnswers: number;
  incorrectAnswers: number;
  accuracyPercentage: number;
  timeTakenSeconds: number;
  averageTimePerQuestion: number;
  xpEarned: number;
  streakBonus: number;
  answers: QuizAnswer[];
  previousAttempt?: {
    id: string;
    accuracyPercentage: number;
    completedAt: string;
  };
  improvementPercentage?: number;
  difficultyLevel: string;
  completedAt: string;
  questionsPerMinute: number;
  perfectStreaks: number;
  topicsToReview: string[];
  lessonTitle?: string;
}

interface Lesson {
  id: string;
  title: string;
  content: string;
  slug?: string;
  animations?: unknown[];
  examples?: LessonExample[];
  quiz?: QuizQuestion[];
  xp_reward: number;
  order_index: number;
  chapter?: string;
}

interface QuizQuestion {
  question: string;
  options: string[];
  correct?: number;
  correctAnswer?: number;
  explanation?: string;
}

export default function LessonPlayer() {
  const { courseSlug, lessonSlug } = useParams();
  const navigate = useNavigate();
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [courseLessons, setCourseLessons] = useState<Lesson[]>([]);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [isCompleted, setIsCompleted] = useState(false);
  const [completingLesson, setCompletingLesson] = useState(false);

  // Quiz state
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, number>>({});
  const [showResults, setShowResults] = useState<Record<number, boolean>>({});
  const [quizStartTime, setQuizStartTime] = useState<number | null>(null);
  const [showQuizResults, setShowQuizResults] = useState(false);
  const [quizResultsData, setQuizResultsData] = useState<LessonQuizResults | null>(null);

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
      const { data: courseData } = await supabase.functions.invoke('courses', {
        body: { slug: courseSlug }
      });

      if (courseData?.lessons && Array.isArray(courseData.lessons)) {
        const sortedLessons = [...courseData.lessons].sort((a: Lesson, b: Lesson) => a.order_index - b.order_index);
        setCourseLessons(sortedLessons);

        const foundLesson = courseData.lessons.find((l: Lesson) => l.slug === lessonSlug);

        if (foundLesson) {
          const lessonIndex = sortedLessons.findIndex((l: Lesson) => l.id === foundLesson.id);

          if (lessonIndex > 0) {
            const previousLesson = sortedLessons[lessonIndex - 1];

            if (previousLesson) {
              const { data: prevProgress } = await supabase
                .from('user_progress')
                .select('status')
                .eq('user_id', uid)
                .eq('lesson_id', previousLesson.id)
                .maybeSingle();

              const isPreviousCompleted = prevProgress?.status === 'completed';

              if (!isPreviousCompleted) {
                toast.error(
                  `🔒 Lesson Locked! Please complete "${previousLesson.title || 'the previous lesson'}" first to unlock this lesson.`,
                  { duration: 5000 }
                );
                navigate(`/science-lens/learning/${courseSlug}`);
                return;
              }
            }
          }

          const { data: lessonData } = await supabase.functions.invoke('lessons', {
            body: { id: foundLesson.id }
          });

          if (lessonData) {
            setLesson(lessonData);

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

  // Helper function to get next lesson
  const getNextLesson = () => {
    if (!lesson || courseLessons.length === 0) return null;

    const currentIndex = courseLessons.findIndex(l => l.id === lesson.id);
    if (currentIndex === -1 || currentIndex === courseLessons.length - 1) {
      return null; // This is the last lesson
    }

    return courseLessons[currentIndex + 1];
  };

  // Helper function to check if all quizzes are answered
  const allQuizzesAnswered = () => {
    const quiz = lesson?.quiz;
    if (!quiz?.questions || quiz.questions.length === 0) return true;

    // Require at least 2 quizzes, or all if less than 2
    const requiredQuizzes = Math.min(2, quiz.questions.length);
    const answeredQuizzes = Object.keys(showResults).length;

    return answeredQuizzes >= requiredQuizzes;
  };

  // Helper function to get quiz progress text
  const getQuizProgress = () => {
    const quiz = lesson?.quiz;
    if (!quiz?.questions || quiz.questions.length === 0) return null;

    const answeredQuizzes = Object.keys(showResults).length;
    const requiredQuizzes = Math.min(2, quiz.questions.length);

    return `${answeredQuizzes}/${requiredQuizzes} quizzes completed`;
  };

  const handleQuizSubmit = (questionIndex: number) => {
    // Start quiz timer on first answer
    if (!quizStartTime) {
      setQuizStartTime(Date.now());
    }

    setShowResults(prev => ({ ...prev, [questionIndex]: true }));

    const quiz = lesson?.quiz;
    if (quiz?.questions?.[questionIndex]) {
      const q = quiz.questions[questionIndex];
      const correctIdx = q.correct ?? q.correctAnswer ?? 0;
      const isCorrect = selectedAnswers[questionIndex] === correctIdx;

      if (isCorrect) {
        toast.success('Correct! Well done! 🎉');
      } else {
        toast.error('Not quite right. Review the explanation below.');
      }

      // Check if all required quizzes are now answered
      const answeredQuizzes = Object.keys({ ...showResults, [questionIndex]: true }).length;
      const requiredQuizzes = Math.min(2, quiz.questions.length);

      if (answeredQuizzes === requiredQuizzes) {
        toast.success(`Great! You've completed ${requiredQuizzes} quizzes. You can now mark this lesson complete! 🌟`);
      }
    }
  };

  const saveQuizResults = async () => {
    if (!userId || !lesson) return;

    const quiz = lesson?.quiz;
    if (!quiz?.questions) return;

    const totalQuestions = quiz.questions.length;
    let correctCount = 0;
    const answers: QuizAnswer[] = [];
    const topicsToReview: string[] = [];

    quiz.questions.forEach((q: QuizQuestion, idx: number) => {
      const correctIdx = q.correct ?? q.correctAnswer ?? 0;
      const isCorrect = selectedAnswers[idx] === correctIdx;

      if (isCorrect) {
        correctCount++;
      } else {
        topicsToReview.push(`Question ${idx + 1}: ${q.question.substring(0, 50)}...`);
      }

      answers.push({
        question: q.question,
        userAnswer: q.options[selectedAnswers[idx]] || 'Not answered',
        correctAnswer: q.options[correctIdx],
        isCorrect,
        explanation: q.explanation,
      });
    });

    const timeTaken = quizStartTime ? Math.floor((Date.now() - quizStartTime) / 1000) : 0;
    const accuracyPercentage = Math.round((correctCount / totalQuestions) * 100);
    const averageTimePerQuestion = totalQuestions > 0 ? timeTaken / totalQuestions : 0;
    const questionsPerMinute = timeTaken > 0 ? (totalQuestions / timeTaken) * 60 : 0;

    // Calculate perfect streaks
    let perfectStreaks = 0;
    let currentStreak = 0;
    answers.forEach((answer) => {
      if (answer.isCorrect) {
        currentStreak++;
        if (currentStreak >= 3) perfectStreaks++;
      } else {
        currentStreak = 0;
      }
    });

    // Fetch previous attempt for comparison
    const { data: previousAttempt } = await supabase
      .from('quiz_results')
      .select('*')
      .eq('user_id', userId)
      .eq('lesson_id', lesson.id)
      .order('completed_at', { ascending: false })
      .limit(1)
      .maybeSingle();

    const improvementPercentage = previousAttempt
      ? accuracyPercentage - previousAttempt.accuracy_percentage
      : undefined;

    // Save quiz results
    const { data: quizResult, error } = await supabase
      .from('quiz_results')
      .insert({
        user_id: userId,
        lesson_id: lesson.id,
        quiz_type: 'lesson',
        total_questions: totalQuestions,
        correct_answers: correctCount,
        incorrect_answers: totalQuestions - correctCount,
        accuracy_percentage: accuracyPercentage,
        time_taken_seconds: timeTaken,
        average_time_per_question: averageTimePerQuestion,
        xp_earned: 0, // XP is awarded separately on lesson completion
        streak_bonus: 0,
        answers,
        previous_attempt_id: previousAttempt?.id,
        improvement_percentage: improvementPercentage,
        difficulty_level: 'intermediate',
        questions_per_minute: questionsPerMinute,
        perfect_streaks: perfectStreaks,
        topics_to_review: topicsToReview,
      })
      .select()
      .single();

    if (error) {
      console.error('Error saving quiz results:', error);
    }

    // Log quiz activity
    await logQuizCompleted(
      userId,
      lesson.id,
      lesson.title,
      correctCount,
      totalQuestions,
      0 // XP is awarded separately on lesson completion
    );

    // Check quiz achievements
    await checkQuizAchievements(userId, accuracyPercentage);

    // Set quiz results data
    setQuizResultsData({
      id: quizResult?.id,
      quizType: 'lesson' as const,
      lessonId: lesson.id,
      totalQuestions,
      correctAnswers: correctCount,
      incorrectAnswers: totalQuestions - correctCount,
      accuracyPercentage,
      timeTakenSeconds: timeTaken,
      averageTimePerQuestion,
      xpEarned: 0,
      streakBonus: 0,
      answers,
      previousAttempt: previousAttempt ? {
        id: previousAttempt.id,
        accuracyPercentage: previousAttempt.accuracy_percentage,
        completedAt: previousAttempt.completed_at,
      } : undefined,
      improvementPercentage,
      difficultyLevel: 'intermediate',
      completedAt: new Date().toISOString(),
      questionsPerMinute,
      perfectStreaks,
      topicsToReview,
      lessonTitle: lesson.title,
    });

    setShowQuizResults(true);
  };

  const handleMarkComplete = async () => {
    if (!userId || !lesson) return;

    // Check if all required quizzes are answered
    if (!allQuizzesAnswered()) {
      const quiz = lesson?.quiz;
      const requiredQuizzes = Math.min(2, quiz?.questions?.length || 0);
      toast.error(
        `Please complete at least ${requiredQuizzes} quiz questions before marking this lesson complete.`
      );
      return;
    }

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

        // Log level up activity
        await logLevelUp(userId, newLevel, newXp);

        // Check level achievements
        await checkLevelAchievements(userId, newLevel);
      } else {
        triggerLessonCompleteConfetti();
      }

      // Log lesson completion (only if not already completed)
      if (!data?.alreadyCompleted) {
        await logLessonCompleted(
          userId,
          lesson.id,
          lesson.title,
          lesson.xp_reward || 10
        );

        // Check lesson completion achievements
        // Get total completed lessons count
        const { data: completedLessons } = await supabase
          .from('user_progress')
          .select('id')
          .eq('user_id', userId)
          .eq('completed', true);

        const lessonCount = completedLessons?.length || 0;
        await checkLessonAchievements(userId, lessonCount);
      }

      if (data?.alreadyCompleted) {
        toast.info('You already completed this lesson!');
      } else {
        toast.success(`Lesson complete! +${lesson.xp_reward || 10} XP earned! 🌟`);
      }

      setIsCompleted(true);

      // Auto-navigate to next lesson after a short delay
      const nextLesson = getNextLesson();
      if (nextLesson) {
        setTimeout(() => {
          toast.info(`Moving to next lesson: "${nextLesson.title}"...`);
          navigate(`/science-lens/learning/${courseSlug}/lesson/${nextLesson.slug}`);
        }, 2000);
      } else {
        // This was the last lesson
        setTimeout(() => {
          toast.success('🎉 Congratulations! You have completed all lessons in this course!');
          navigate(`/science-lens/learning/${courseSlug}`);
        }, 2000);
      }
    } catch (error) {
      console.error('Error completing lesson:', error);
      toast.error('Failed to mark lesson as complete');
    } finally {
      setCompletingLesson(false);
    }
  };

  const handleNextLesson = () => {
    const nextLesson = getNextLesson();
    if (nextLesson) {
      navigate(`/science-lens/learning/${courseSlug}/lesson/${nextLesson.slug}`);
    } else {
      toast.success('🎉 This is the last lesson! Course complete!');
      navigate(`/science-lens/learning/${courseSlug}`);
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
          navigate('/science-lens/pricing');
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
            <Button onClick={() => navigate(`/science-lens/learning/${courseSlug}`)} className="mt-4">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Course
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const quiz = lesson.quiz;
  const examples = Array.isArray(lesson.examples) ? lesson.examples : [];
  
  // Fix escaped newlines in content
  const processedContent = (lesson.content || '').replace(/\\n/g, '\n');

  return (
    <div className="container mx-auto p-6 max-w-4xl space-y-6">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Button 
          variant="ghost" 
          size="sm"
          onClick={() => navigate('/science-lens/learning')}
        >
          Courses
        </Button>
        <span>/</span>
        <Button 
          variant="ghost" 
          size="sm"
          onClick={() => navigate(`/science-lens/learning/${courseSlug}`)}
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
            {processedContent}
          </ReactMarkdown>
        </CardContent>
      </Card>

      {/* Related Concepts Dropdown */}
      <RelatedConceptsDropdown
        lessonTitle={lesson.title}
        courseSlug={courseSlug}
        chapter={lesson.chapter as string}
      />

      {/* Visual Concepts - Topic-specific images */}
      <Card>
        <CardHeader>
          <CardTitle className="text-xl">Visual Concepts</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <TopicVisual
            topic={courseSlug || ''}
            title={lesson.title}
          />
        </CardContent>
      </Card>

      {/* Examples */}
      {examples.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-xl">Real-World Examples</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {examples.map((example: LessonExample, idx: number) => (
              <div key={idx} className="p-4 border border-border rounded-lg bg-muted/20">
                <h4 className="font-semibold mb-2">{example.title}</h4>
                <p className="text-muted-foreground">{example.description}</p>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Quiz */}
      {quiz?.questions && quiz.questions.length > 0 && !showQuizResults && (
        <Card>
          <CardHeader>
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-xl">Test Your Knowledge</CardTitle>
                <p className="text-sm text-muted-foreground mt-1">
                  Complete at least 2 quizzes to finish this lesson
                </p>
              </div>
              <Badge variant={allQuizzesAnswered() ? "default" : "secondary"} className="text-sm">
                {getQuizProgress()}
              </Badge>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {quiz.questions.map((q: QuizQuestion, qIdx: number) => {
              const correctIdx = q.correct ?? q.correctAnswer ?? 0;

              return (
                <div key={qIdx} className="space-y-4">
                  <div className="flex items-start gap-2">
                    <span className="flex-shrink-0 w-6 h-6 rounded-full bg-primary/10 text-primary text-sm flex items-center justify-center font-semibold">
                      {qIdx + 1}
                    </span>
                    <h4 className="font-semibold text-lg flex-1">{q.question}</h4>
                    {showResults[qIdx] && (
                      <CheckCircle2 className="w-5 h-5 text-success flex-shrink-0" />
                    )}
                  </div>

                  <RadioGroup
                    value={selectedAnswers[qIdx]?.toString() ?? ''}
                    onValueChange={(val) => setSelectedAnswers(prev => ({ ...prev, [qIdx]: parseInt(val) }))}
                    disabled={showResults[qIdx]}
                  >
                    {q.options.map((option, optIdx) => {
                      const isSelected = selectedAnswers[qIdx] === optIdx;
                      const isCorrect = optIdx === correctIdx;
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
                    <Button onClick={() => handleQuizSubmit(qIdx)} size="sm">
                      Submit Answer
                    </Button>
                  )}

                  {showResults[qIdx] && (
                    <Card className="border-primary/20 bg-primary/5">
                      <CardContent className="p-4">
                        <p className="text-sm">
                          <strong>Explanation:</strong> {q.explanation || `The correct answer is "${q.options[correctIdx]}".`}
                        </p>
                      </CardContent>
                    </Card>
                  )}
                </div>
              );
            })}

            {/* Submit Quiz Button */}
            {Object.keys(showResults).length === quiz.questions.length && (
              <div className="pt-4 border-t">
                <Button
                  size="lg"
                  className="w-full"
                  onClick={saveQuizResults}
                  disabled={completingLesson}
                >
                  {completingLesson ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      Saving Results...
                    </>
                  ) : (
                    <>
                      <Trophy className="w-4 h-4 mr-2" />
                      View Quiz Results
                    </>
                  )}
                </Button>
              </div>
            )}
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

      {/* Quiz Results - Show after completing quiz */}
      {showQuizResults && quizResultsData && (
        <QuizResults
          results={quizResultsData}
          onReturn={() => {
            setShowQuizResults(false);
            setQuizResultsData(null);
          }}
          onRetry={() => {
            setShowQuizResults(false);
            setQuizResultsData(null);
            setSelectedAnswers({});
            setShowResults({});
            setQuizStartTime(null);
            window.scrollTo({ top: 0, behavior: 'smooth' });
          }}
          onContinue={async () => {
            await handleMarkComplete();
          }}
          showReviewButton={true}
        />
      )}

      {/* Action Buttons - Hide if showing quiz results */}
      {!showQuizResults && (
        <Card className="border-primary/20">
          <CardContent className="p-6">
            <div className="space-y-4">
              {/* Quiz requirement notice */}
              {quiz?.questions && quiz.questions.length > 0 && !allQuizzesAnswered() && (
                <div className="flex items-start gap-3 p-4 bg-amber-500/10 border border-amber-500/30 rounded-lg">
                  <Lightbulb className="w-5 h-5 text-amber-500 flex-shrink-0 mt-0.5" />
                  <div className="flex-1">
                    <p className="font-semibold text-amber-700 dark:text-amber-400">
                      Complete the quizzes first
                    </p>
                    <p className="text-sm text-amber-600 dark:text-amber-500 mt-1">
                      Answer at least {Math.min(2, quiz.questions.length)} quiz questions to unlock the Mark Complete button.
                    </p>
                  </div>
                </div>
              )}

              {/* Completion status for already completed lessons */}
              {isCompleted && (
                <div className="flex items-center gap-2 p-4 bg-success/10 border border-success/30 rounded-lg">
                  <CheckCircle2 className="w-5 h-5 text-success" />
                  <p className="text-success font-semibold">You've already completed this lesson! Review mode active.</p>
                </div>
              )}

              {/* Action buttons */}
              <div className="flex items-center justify-between gap-4">
                <Button
                  variant="outline"
                  onClick={() => navigate(`/science-lens/learning/${courseSlug}`)}
                  className="flex-1 sm:flex-none"
                >
                  <ArrowLeft className="w-4 h-4 mr-2" />
                  Back to Course
                </Button>

                <div className="flex items-center gap-3">
                  {/* Next Lesson Button - Only show after completing */}
                  {isCompleted && getNextLesson() && (
                    <Button
                      onClick={handleNextLesson}
                      variant="default"
                      className="btn-primary"
                    >
                      Next Lesson
                      <ArrowRight className="w-4 h-4 ml-2" />
                    </Button>
                  )}

                  {/* Mark Complete Button */}
                  <Button
                    onClick={handleMarkComplete}
                    disabled={completingLesson || (!allQuizzesAnswered() && !isCompleted)}
                    className="btn-achievement"
                    title={!allQuizzesAnswered() && !isCompleted ? "Complete the required quizzes first" : ""}
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

              {/* Last lesson notice */}
              {isCompleted && !getNextLesson() && (
                <p className="text-center text-sm text-muted-foreground pt-2">
                  This is the final lesson in this course. Great work!
                </p>
              )}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
