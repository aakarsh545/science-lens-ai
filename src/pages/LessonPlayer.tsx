import { useEffect, useState, useRef } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import { Volume2 } from "lucide-react";
import { MathJax, MathJaxContext } from "better-react-mathjax";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import TopicVisual from "@/components/animations/TopicVisual";
import LessonOnboarding from "@/components/LessonOnboarding";
import { ThreeJSSimulation } from "@/components/ThreeJSSimulation";
import { PhETSimulation } from "@/components/lessons/PhETSimulation";
import {
  ArrowLeft,
  ArrowRight,
  Lightbulb,
  CheckCircle2,
  Award,
  BookOpen,
  Trophy
} from "lucide-react";
import { calculateLevel, didLevelUp } from "@/utils/levelCalculations";
import { HelixLoader } from "@/components/ui/helix-loader";
import { triggerLevelUpConfetti, triggerLessonCompleteConfetti } from "@/utils/confettiEffects";
import { logLessonCompleted, logLevelUp } from "@/utils/activityLogging";
import { checkLessonAchievements, checkLevelAchievements } from "@/utils/achievements";

interface LessonExample {
  title: string;
  description: string;
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
  const [userProgress, setUserProgress] = useState<Array<{ lesson_id: string; status: string }>>([]);

  // Onboarding state
  const [showOnboarding, setShowOnboarding] = useState(false);
  const [checkingOnboarding, setCheckingOnboarding] = useState(true);
  const [recommendedSection, setRecommendedSection] = useState<string | undefined>();

  // Chapter quiz state (multi-step quiz at end of chapter)
  const [showChapterQuiz, setShowChapterQuiz] = useState(false);
  const [chapterQuizCompleted, setChapterQuizCompleted] = useState<Set<string>>(new Set());
  const [currentChapterQuizQuestion, setCurrentChapterQuizQuestion] = useState(0);
  const [chapterQuizAnswers, setChapterQuizAnswers] = useState<Record<number, number>>({});
  const [chapterQuizResults, setChapterQuizResults] = useState<Record<number, boolean>>({});
  const [chapterQuizQuestions, setChapterQuizQuestions] = useState<QuizQuestion[]>([]);

  // AI hint state
  const [aiHint, setAiHint] = useState<string | null>(null);
  const [loadingHint, setLoadingHint] = useState(false);
  const [hintType, setHintType] = useState<'ai' | 'wolfram' | 'grok'>('ai');
  const [audioUrl, setAudioUrl] = useState<string | null>(null);
  const [loadingAudio, setLoadingAudio] = useState(false);
  const audioRef = useRef<HTMLAudioElement>(null);
  const [isMathJaxLoaded, setIsMathJaxLoaded] = useState(false);

  // Load MathJax script dynamically when needed
  useEffect(() => {
    if (lesson && lesson.content && (lesson.content.includes('math') || lesson.content.includes('formula'))) {
      const script = document.createElement('script');
      script.type = 'text/javascript';
      script.async = true;
      script.src = 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js';
      script.onload = () => setIsMathJaxLoaded(true);
      document.head.appendChild(script);
    }

    return () => {
      // Cleanup MathJax script when component unmounts
      const mathjaxScript = document.querySelector('script[src*="https://cdn.jsdelivr.net/npm/mathjax@3"]');
      if (mathjaxScript && mathjaxScript.parentNode) {
        mathjaxScript.parentNode.removeChild(mathjaxScript);
      }
      setIsMathJaxLoaded(false);
    };
  }, [lesson?.id, lesson?.content]);

  // Load chapter quiz questions when quiz is shown
  useEffect(() => {
    if (showChapterQuiz && lesson?.chapter && courseLessons.length > 0) {
      const loadChapterQuiz = async () => {
        const questions = await getChapterQuiz();
        setChapterQuizQuestions(questions);
        setCurrentChapterQuizQuestion(0);
        setChapterQuizAnswers({});
        setChapterQuizResults({});
      };
      loadChapterQuiz();
    }
  }, [showChapterQuiz, lesson?.chapter]);

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

          const { data: lessonData, error: lessonError } = await supabase.functions.invoke('lessons', {
            body: { id: foundLesson.id }
          });

          if (lessonError) {
            console.error('[LessonPlayer] Error loading lesson:', lessonError);
            toast.error('Failed to load lesson content');
            return;
          }

          if (lessonData) {
            setLesson(lessonData);

            // Load all user progress for this course
            await loadProgress(uid);

            // Check onboarding status
            const { data: progressData } = await (supabase as any)
              .from('user_progress')
              .select('status, onboarding_completed, recommended_starting_section')
              .eq('user_id', uid)
              .eq('lesson_id', lessonData.id)
              .maybeSingle();

            setIsCompleted(progressData?.status === 'completed');

            // Check if onboarding is needed
            if (progressData) {
              if (!progressData.onboarding_completed) {
                setShowOnboarding(true);
              }
              setRecommendedSection(progressData.recommended_starting_section || undefined);
            } else {
              // No progress record yet, create one and show onboarding
              await (supabase as any)
                .from('user_progress')
                .insert({
                  user_id: uid,
                  lesson_id: lessonData.id,
                  status: 'in_progress',
                  onboarding_completed: false,
                });
              setShowOnboarding(true);
            }
          }
        }
      }
    } catch (error) {
      console.error('Error loading lesson:', error);
      toast.error('Failed to load lesson');
    } finally {
      setLoading(false);
      setCheckingOnboarding(false);
    }
  };

  const loadProgress = async (uid: string) => {
    try {
      const { data: progressData } = await supabase
        .from('user_progress')
        .select('lesson_id, status')
        .eq('user_id', uid);

      if (progressData) {
        setUserProgress(progressData);
      }
    } catch (error) {
      console.error('[LessonPlayer] Error loading progress:', error);
    }
  };

  const getNextLesson = () => {
    if (!lesson || courseLessons.length === 0) return null;
    const currentIndex = courseLessons.findIndex(l => l.id === lesson.id);
    if (currentIndex === -1 || currentIndex === courseLessons.length - 1) return null;
    return courseLessons[currentIndex + 1];
  };

  const isLastLessonInChapter = () => {
    if (!lesson || !lesson.chapter) return false;

    const lessonsInChapter = courseLessons.filter(l => l.chapter === lesson.chapter);
    const currentIndex = lessonsInChapter.findIndex(l => l.id === lesson.id);

    return currentIndex === lessonsInChapter.length - 1;
  };

  const shouldShowChapterQuiz = () => {
    return isCompleted && lesson?.chapter && isLastLessonInChapter() && !chapterQuizCompleted.has(lesson.chapter);
  };

  const getChapterQuiz = async () => {
    if (!lesson?.chapter) return [];

    // Collect all quiz questions from all lessons in this chapter
    const lessonsInChapter = courseLessons.filter(l => l.chapter === lesson.chapter);
    const allQuestions: QuizQuestion[] = [];

    for (const chapterLesson of lessonsInChapter) {
      if (chapterLesson.quiz && Array.isArray(chapterLesson.quiz)) {
        // Add questions from this lesson
        allQuestions.push(...chapterLesson.quiz.map((q, idx) => ({
          ...q,
          explanation: q.explanation || `From: ${chapterLesson.title}`
        })));
      }
    }

    // If no questions found, create generic chapter review questions
    if (allQuestions.length === 0) {
      allQuestions.push(
        {
          question: `Chapter ${lesson.chapter} Review: What was the most interesting topic you learned?`,
          options: ['First Lesson Topic', 'Second Lesson Topic', 'Third Lesson Topic', 'All of them'],
          correctAnswer: 3,
          explanation: 'All topics contribute to your understanding of the chapter.'
        },
        {
          question: `Chapter ${lesson.chapter} Review: Are you ready to move to the next chapter?`,
          options: ['Yes, I understand everything', 'Need more review', 'Not sure yet', 'Skip for now'],
          correctAnswer: 0,
          explanation: 'Confidence in your understanding is key to progression.'
        }
      );
    }

    return allQuestions;
  };

  const handleChapterQuizAnswer = (questionIndex: number, answerIndex: number) => {
    setChapterQuizAnswers(prev => ({ ...prev, [questionIndex]: answerIndex }));
    setChapterQuizResults(prev => ({ ...prev, [questionIndex]: true }));

    const question = chapterQuizQuestions[questionIndex];
    const correctIdx = question.correct ?? question.correctAnswer ?? 0;
    const isCorrect = answerIndex === correctIdx;

    if (isCorrect) {
      toast.success('Correct! 🎉');
    } else {
      toast.error('Not quite. Review and try again!');
    }
  };

  const handleChapterQuizComplete = async () => {
    if (!lesson?.chapter) return;

    // Calculate score
    let correctCount = 0;
    Object.entries(chapterQuizAnswers).forEach(([qIdx, answerIdx]) => {
      const question = chapterQuizQuestions[parseInt(qIdx)];
      if (question) {
        const correctIdx = question.correct ?? question.correctAnswer ?? 0;
        if (answerIdx === correctIdx) {
          correctCount++;
        }
      }
    });

    const percentage = (correctCount / chapterQuizQuestions.length) * 100;

    // Require 70% to pass
    if (percentage >= 70) {
      // Mark chapter quiz as completed
      await (supabase as any)
        .from('user_progress')
        .update({
          chapter_quiz_completed: true,
          chapter_quiz_score: percentage,
          chapter_quiz_completed_at: new Date().toISOString()
        })
        .eq('user_id', userId)
        .eq('lesson_id', lesson.id);

      setChapterQuizCompleted(prev => new Set([...prev, lesson.chapter]));
      setShowChapterQuiz(false);
      setCurrentChapterQuizQuestion(0);
      setChapterQuizAnswers({});
      setChapterQuizResults({});
      toast.success(`Chapter ${lesson.chapter} completed! Score: ${Math.round(percentage)}%. Moving to next chapter...`);

      // Navigate to first lesson of next chapter
      const nextLesson = getNextLesson();
      if (nextLesson) {
        setTimeout(() => {
          navigate(`/learning/${courseSlug}/${nextLesson.slug}`);
        }, 2000);
      }
    } else {
      toast.error(`You need ${70 - Math.round(percentage)}% more to pass. Review the chapter and try again!`);
    }
  };

  const handleMarkComplete = async () => {
    if (!userId || !lesson) return;

    setCompletingLesson(true);
    try {
      const { data: currentStats } = await supabase
        .from('user_stats')
        .select('xp_total')
        .eq('user_id', userId)
        .single();

      const oldXp = currentStats?.xp_total || 0;

      const { data, error: completeError } = await supabase.functions.invoke('lessons', {
        body: {
          id: lesson.id,
          action: 'complete'
        }
      });

      if (completeError) {
        if (completeError.message?.includes('credits')) {
          toast.error('Not enough credits');
          return;
        }
        console.error('[LessonPlayer] Error completing lesson:', completeError);
        toast.error('Failed to mark lesson complete');
        throw completeError;
      }

      const newXp = data?.stats?.xp_total || oldXp;

      if (didLevelUp(oldXp, newXp)) {
        triggerLevelUpConfetti();
        const newLevel = calculateLevel(newXp);
        toast.success(`🎊 Level Up! You're now level ${newLevel}!`);
        await logLevelUp(userId, newLevel, newXp);
        await checkLevelAchievements(userId, newLevel);
      } else {
        triggerLessonCompleteConfetti();
      }

      if (!data?.alreadyCompleted) {
        await logLessonCompleted(
          userId,
          lesson.id,
          lesson.title,
          lesson.xp_reward || 10
        );

        const { data: completedLessons } = await supabase
          .from('user_progress')
          .select('id')
          .eq('user_id', userId)
          .eq('status', 'completed');

        const lessonCount = completedLessons?.length || 0;
        await checkLessonAchievements(userId, lessonCount);
      }

      if (data?.alreadyCompleted) {
        toast.info('You already completed this lesson!');
      } else {
        toast.success(`Lesson complete! +${lesson.xp_reward || 10} XP earned! 🌟`);
      }

      setIsCompleted(true);

      // Check if this is the last lesson in the chapter
      if (isLastLessonInChapter() && lesson?.chapter) {
        // Show chapter quiz prompt
        toast.info(`Chapter ${lesson.chapter} complete! Take the chapter quiz to continue.`);
      } else {
        // Navigate to next lesson
        const nextLesson = getNextLesson();
        if (nextLesson) {
          setTimeout(() => {
            navigate(`/learning/${courseSlug}/${nextLesson.slug}`);
          }, 2000);
        }
      }
    } catch (error) {
      console.error('Error completing lesson:', error);
      toast.error('Failed to mark lesson as complete');
    } finally {
      setCompletingLesson(false);
    }
  };

  const handleNextLesson = async () => {
    // Check database to confirm current lesson is completed
    const { data: currentProgress } = await supabase
      .from('user_progress')
      .select('status')
      .eq('user_id', userId)
      .eq('lesson_id', lesson.id)
      .maybeSingle();

    const isActuallyCompleted = currentProgress?.status === 'completed';

    // If not completed, auto-complete it
    if (!isActuallyCompleted && userId && lesson) {
      await handleMarkComplete();
      // Wait a moment for the completion to process
      await new Promise(resolve => setTimeout(resolve, 500));
    }

    const nextLesson = getNextLesson();
    if (!nextLesson) {
      toast.success('🎉 This is the last lesson! Course complete!');
      navigate(`/learning/${courseSlug}`);
      return;
    }

    // Navigate to next lesson
    navigate(`/learning/${courseSlug}/${nextLesson.slug}`);
  };

  const handleQuickNext = async () => {
    // Check database to confirm current lesson is completed
    const { data: currentProgress } = await supabase
      .from('user_progress')
      .select('status')
      .eq('user_id', userId)
      .eq('lesson_id', lesson?.id)
      .maybeSingle();

    const isActuallyCompleted = currentProgress?.status === 'completed';

    // If not completed, auto-complete it
    if (!isActuallyCompleted && userId && lesson) {
      await handleMarkComplete();
      // Wait a moment for the completion to process
      await new Promise(resolve => setTimeout(resolve, 500));
    }

    const nextLesson = getNextLesson();
    if (!nextLesson) {
      toast.success('🎉 This is the last lesson! Course complete!');
      navigate(`/learning/${courseSlug}`);
      return;
    }

    // Navigate to next lesson
    navigate(`/learning/${courseSlug}/${nextLesson.slug}`);
  };

  const handleGetHint = async () => {
    if (!userId || !lesson) return;

    setLoadingHint(true);
    try {
      let data, error;

      if (hintType === 'wolfram') {
        // Use Wolfram Alpha for computational hints
        const response = await supabase.functions.invoke('wolfram-hint', {
          body: {
            question: lesson.title,
            context: lesson.content?.substring(0, 300)
          }
        });
        data = response.data;
        error = response.error;
      } else {
        // Use OpenAI for general hints
        const response = await supabase.functions.invoke('ai-hint', {
          body: {
            question: `I need help understanding: ${lesson.title}`,
            context: lesson.content?.substring(0, 500)
          }
        });
        data = response.data;
        error = response.error;
      }

      if (error) {
        if (error.message?.includes('credits_exhausted')) {
          toast.error('Daily credits exhausted! Come back tomorrow for more free credits.');
          return;
        }
        throw error;
      }

      setAiHint(data.hint);
      toast.success(`${hintType === 'wolfram' ? 'Wolfram Alpha' : 'AI'} hint generated!`);
    } catch (error) {
      console.error('Error getting hint:', error);
      toast.error(`Failed to get ${hintType === 'wolfram' ? 'Wolfram Alpha' : 'AI'} hint`);
    } finally {
      setLoadingHint(false);
    }
  };

  const handleReadAloud = async () => {
    if (!lesson) return;

    // If audio is already playing, stop it
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
    }

    // If we already have the audio URL and it's loaded, just play it
    if (audioUrl && audioRef.current && audioRef.current.src) {
      audioRef.current.play();
      return;
    }

    setLoadingAudio(true);
    try {
      // Prepare text content for TTS
      const lessonText = `${lesson.title}. ${typeof lesson.content === 'string'
        ? lesson.content
        : JSON.stringify(lesson.content).substring(0, 2000)}`;

      const { data: audioBlob, error } = await supabase.functions.invoke('elevenlabs-tts', {
        body: {
          text: lessonText
        }
      });

      if (error) throw error;

      // Create blob URL from audio blob
      const url = URL.createObjectURL(audioBlob as Blob);
      setAudioUrl(url);

      toast.success('Audio generated successfully!');
    } catch (error) {
      console.error('Error generating audio:', error);
      toast.error('Failed to generate lesson audio');
    } finally {
      setLoadingAudio(false);
    }
  };

  const handleOnboardingComplete = (startingSection?: string) => {
    setShowOnboarding(false);
    setRecommendedSection(startingSection);

    if (startingSection) {
      toast.success(`Starting at ${startingSection} level based on your quiz results!`);
      // Scroll to the recommended section if needed
      setTimeout(() => {
        const element = document.getElementById(startingSection);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth' });
        }
      }, 500);
    }
  };

  if (loading || checkingOnboarding) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <HelixLoader className="text-primary" />
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
            <Button onClick={() => navigate(`/learning/${courseSlug}`)} className="mt-4">
              <ArrowLeft className="w-4 h-4 mr-2" />
              Back to Course
            </Button>
          </div>
        </Card>
      </div>
    );
  }

  const examples = Array.isArray(lesson.examples) ? lesson.examples : [];
  const processedContent = (lesson.content || '').replace(/\\n/g, '\n');

  // Parse lesson content for simulations
  const parseLessonContent = (content: string): Array<{
    type: 'phet' | 'spline' | 'rive' | 'lottie';
    url?: string;
    title?: string;
  }> => {
    if (!content) return [];

    // Try to parse as JSON first
    try {
      const parsed = JSON.parse(content);
      if (parsed.simulation) {
        return [{
          type: parsed.simulation.type || 'phet',
          url: parsed.simulation.url,
          title: parsed.simulation.title,
        }];
      }
      if (parsed.parts && Array.isArray(parsed.parts)) {
        return parsed.parts
          .filter((part: any) => {
            const partContent = typeof part.content === 'string' ? part.content : JSON.stringify(part.content);
            return partContent.includes('sim:') || partContent.includes('simulation');
          })
          .map((part: any, index: number) => {
            const partContent = typeof part.content === 'string' ? part.content : JSON.stringify(part.content);
            return {
              type: (part.simulation?.type || 'phet') as any,
              url: part.simulation?.url,
              title: part.title || `Simulation ${index + 1}`,
            };
          });
      }
    } catch {
      // If JSON parsing fails, look for simulation markers in plain text
      const simulationMarkers = [
        /\\sim\{([^}]+)\}/gi,
        /\[Simulator:([^\]]+)\]/gi,
        /(?:simulation|sim)\s*[:=]\s*([^\]]+)\}/gi
      ];

      const simulations: Array<{
        type: 'phet' | 'spline' | 'rive' | 'lottie';
        url?: string;
        title?: string;
      }> = [];
      let match: RegExpExecArray | null;

      for (const marker of simulationMarkers) {
        const regex = new RegExp(marker, 'gi');
        while ((match = regex.exec(content)) !== null) {
          const simType = match[1]?.toLowerCase() || 'phet';
          const simTitle = match[2]?.trim() || `Simulation ${simulations.length + 1}`;
          const simUrl = match[3]?.trim() || '';

          simulations.push({
            type: simType as any,
            title: simTitle,
            url: simUrl,
          });
        }
      }

      return simulations;
    }
    return [];
  };

  return (
    <>
    <div className="container mx-auto p-6 max-w-4xl space-y-6">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-sm text-muted-foreground">
        <Button variant="ghost" size="sm" onClick={() => navigate('/learning')}>
          Courses
        </Button>
        <span>/</span>
        <Button variant="ghost" size="sm" onClick={() => navigate(`/learning/${courseSlug}`)}>
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
          {isMathJaxLoaded ? (
            <MathJaxContext>
              <MathJax dynamic>{processedContent}</MathJax>
            </MathJaxContext>
          ) : (
            <ReactMarkdown remarkPlugins={[remarkGfm]}>
              {processedContent}
            </ReactMarkdown>
          )}
        </CardContent>
      </Card>

      {/* Interactive Simulations */}
      {lesson && lesson.content && parseLessonContent(lesson.content).map((sim, idx) => (
        <PhETSimulation
          key={idx}
          type={sim.type}
          url={sim.url}
          title={sim.title}
        />
      ))}

      {/* Visual Concepts */}
      <Card>
        <CardHeader>
          <CardTitle className="text-xl">Visual Concepts</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <TopicVisual topic={courseSlug || ''} title={lesson.title} />
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

      {/* Text-to-Speech Section */}
      <Card className="border-primary/30">
        <CardHeader>
          <CardTitle className="text-xl flex items-center gap-2">
            <Volume2 className="w-5 h-5 text-achievement" />
            Read Aloud
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p className="text-muted-foreground text-sm">
            Listen to the lesson content being read aloud (costs 1 credit)
          </p>

          <Button
            onClick={handleReadAloud}
            disabled={loadingAudio}
            variant="outline"
            className="border-primary/30"
          >
            {loadingAudio ? (
              <>
                <HelixLoader className="mr-2" />
                Generating audio...
              </>
            ) : (
              <>
                <Volume2 className="w-4 h-4 mr-2" />
                {audioUrl ? 'Play Audio' : 'Generate Audio'}
              </>
            )}
          </Button>

          {audioUrl && (
            <div className="mt-4">
              <audio
                ref={audioRef}
                src={audioUrl}
                controls
                className="w-full"
                onEnded={() => setAudioUrl(null)}
              />
            </div>
          )}
        </CardContent>
      </Card>

      {/* Chapter Quiz */}
      {shouldShowChapterQuiz() && (
        <Card className="border-purple-500/30 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-950/20 dark:to-pink-950/20">
          <CardHeader>
            <CardTitle className="text-2xl flex items-center gap-2">
              <Trophy className="w-6 h-6 text-purple-600" />
              Chapter {lesson.chapter} Complete! Take the Chapter Quiz
            </CardTitle>
            <p className="text-sm text-muted-foreground">
              Congratulations on completing all lessons in Chapter {lesson.chapter}!
              Test your knowledge with this chapter review quiz.
            </p>
          </CardHeader>
          <CardContent className="space-y-6">
            <Button
              onClick={() => setShowChapterQuiz(true)}
              size="lg"
              className="w-full bg-purple-600 hover:bg-purple-700"
            >
              <Trophy className="w-4 h-4 mr-2" />
              Start Chapter Quiz
            </Button>
          </CardContent>
        </Card>
      )}

      {showChapterQuiz && lesson?.chapter && chapterQuizQuestions.length > 0 && (
        <Card className="border-purple-500/30 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-950/20 dark:to-pink-950/20">
          <CardHeader>
            <div className="flex items-center justify-between mb-2">
              <CardTitle className="text-2xl flex items-center gap-2">
                <Trophy className="w-6 h-6 text-purple-600" />
                Chapter {lesson.chapter} Quiz
              </CardTitle>
              <Badge variant="secondary" className="text-sm">
                {currentChapterQuizQuestion + 1} / {chapterQuizQuestions.length}
              </Badge>
            </div>
            <p className="text-sm text-muted-foreground">
              Test your knowledge of all lessons in this chapter
            </p>
            {/* Progress Bar */}
            <div className="w-full h-2 bg-muted rounded-full overflow-hidden mt-3">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: `${((currentChapterQuizQuestion + 1) / chapterQuizQuestions.length) * 100}%` }}
                transition={{ duration: 0.5 }}
                className="h-full bg-gradient-to-r from-primary to-purple-600"
              />
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Current Question */}
            <motion.div
              key={currentChapterQuizQuestion}
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.3 }}
              className="space-y-4"
            >
              <div className="flex items-start gap-3">
                <span className="flex-shrink-0 w-8 h-8 rounded-full bg-purple-600/20 text-purple-600 text-sm flex items-center justify-center font-bold">
                  {currentChapterQuizQuestion + 1}
                </span>
                <h4 className="font-semibold text-lg flex-1 pt-1">
                  {chapterQuizQuestions[currentChapterQuizQuestion].question}
                </h4>
              </div>

              <RadioGroup
                value={chapterQuizAnswers[currentChapterQuizQuestion]?.toString() ?? ''}
                onValueChange={(value) => {
                  if (!chapterQuizResults[currentChapterQuizQuestion]) {
                    handleChapterQuizAnswer(currentChapterQuizQuestion, parseInt(value));
                  }
                }}
              >
                {chapterQuizQuestions[currentChapterQuizQuestion].options.map((option: string, optIdx: number) => (
                  <div key={optIdx} className="flex items-center space-x-2 p-3 border rounded-lg hover:bg-muted/50 transition-colors">
                    <RadioGroupItem value={optIdx.toString()} id={`chapter-q${currentChapterQuizQuestion}-opt${optIdx}`} />
                    <Label
                      htmlFor={`chapter-q${currentChapterQuizQuestion}-opt${optIdx}`}
                      className="flex-1 cursor-pointer"
                    >
                      {option}
                    </Label>
                  </div>
                ))}
              </RadioGroup>

              {chapterQuizResults[currentChapterQuizQuestion] && (
                <motion.div
                  initial={{ opacity: 0, y: -10 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="p-4 rounded-lg bg-purple-100 dark:bg-purple-950/30 border border-purple-200 dark:border-purple-800"
                >
                  <p className="text-sm">
                    <strong>Explanation:</strong> {chapterQuizQuestions[currentChapterQuizQuestion].explanation || 'Great job on this question!'}
                  </p>
                </motion.div>
              )}
            </motion.div>

            {/* Navigation Buttons */}
            <div className="flex items-center justify-between pt-4 border-t">
              <Button
                onClick={() => setCurrentChapterQuizQuestion(Math.max(0, currentChapterQuizQuestion - 1))}
                disabled={currentChapterQuizQuestion === 0}
                variant="outline"
              >
                Previous
              </Button>

              {currentChapterQuizQuestion === chapterQuizQuestions.length - 1 ? (
                <Button
                  onClick={() => handleChapterQuizComplete()}
                  disabled={Object.keys(chapterQuizAnswers).length < chapterQuizQuestions.length}
                  className="bg-gradient-to-r from-primary to-purple-600 hover:from-primary/90 hover:to-purple-600/90"
                >
                  <Trophy className="w-4 h-4 mr-2" />
                  Submit Chapter Quiz
                </Button>
              ) : (
                <Button
                  onClick={() => setCurrentChapterQuizQuestion(currentChapterQuizQuestion + 1)}
                  disabled={!chapterQuizResults[currentChapterQuizQuestion]}
                  className="bg-gradient-to-r from-primary to-purple-600 hover:from-primary/90 hover:to-purple-600/90"
                >
                  Next
                  <ArrowRight className="w-4 h-4 ml-2" />
                </Button>
              )}
            </div>

            {/* Question Indicators */}
            <div className="flex items-center justify-center gap-2 pt-4">
              {chapterQuizQuestions.map((_, idx) => (
                <button
                  key={idx}
                  onClick={() => {
                    // Only allow navigation to answered questions or the next unanswered one
                    if (idx < currentChapterQuizQuestion || (idx === currentChapterQuizQuestion + 1 && chapterQuizResults[currentChapterQuizQuestion])) {
                      setCurrentChapterQuizQuestion(idx);
                    }
                  }}
                  disabled={idx > currentChapterQuizQuestion + 1 || !chapterQuizResults[idx - 1]}
                  className={`w-3 h-3 rounded-full transition-all ${
                    idx === currentChapterQuizQuestion
                      ? 'bg-purple-600 scale-125'
                      : chapterQuizResults[idx]
                      ? 'bg-purple-400'
                      : 'bg-muted'
                  } ${idx > currentChapterQuizQuestion + 1 || !chapterQuizResults[idx - 1] ? 'cursor-not-allowed opacity-50' : 'cursor-pointer hover:bg-purple-300'}`}
                  aria-label={`Question ${idx + 1}`}
                />
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Action Buttons */}
      <Card className="border-primary/20">
        <CardContent className="p-6">
          <div className="space-y-4">
            {isCompleted && (
              <div className="flex items-center gap-2 p-4 bg-success/10 border border-success/30 rounded-lg">
                <CheckCircle2 className="w-5 h-5 text-success" />
                <p className="text-success font-semibold">You've already completed this lesson! Review mode active.</p>
              </div>
            )}

              <div className="flex items-center justify-between gap-4">
                <Button
                  variant="outline"
                  onClick={() => navigate(`/learning/${courseSlug}`)}
                  className="flex-1 sm:flex-none"
                >
                  <ArrowLeft className="w-4 h-4 mr-2" />
                  Back to Course
                </Button>

                <div className="flex items-center gap-3">
                  {isCompleted && getNextLesson() && (
                    <Button onClick={handleNextLesson} variant="default" className="btn-primary">
                      Next Lesson
                      <ArrowRight className="w-4 h-4 ml-2" />
                    </Button>
                  )}
                </div>
              </div>

              {isCompleted && !getNextLesson() && (
                <p className="text-center text-sm text-muted-foreground pt-2">
                  This is the final lesson in this course. Great work!
                </p>
              )}
            </div>
          </CardContent>
        </Card>

      {/* Next Lesson Button - Always visible */}
      {lesson && getNextLesson() && (
        <div className="fixed bottom-6 right-6 z-50 no-print">
          <Button
            onClick={handleQuickNext}
            size="lg"
            className="shadow-lg"
          >
            Next Lesson
            <ArrowRight className="w-5 h-5 ml-2" />
          </Button>
        </div>
      )}
    </div>

    {/* Lesson Onboarding Modal */}
    {showOnboarding && lesson && userId && (
      <LessonOnboarding
        userId={userId}
        lessonId={lesson.id}
        lessonTitle={lesson.title}
        onComplete={handleOnboardingComplete}
      />
    )}
    </>
  );
}
