import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Label } from '@/components/ui/label';
import { Sparkles, CheckCircle2 } from 'lucide-react';
import { HelixLoader } from "@/components/ui/helix-loader";
import { supabase } from '@/integrations/supabase/client';
import confetti from 'canvas-confetti';

interface LessonOnboardingProps {
  userId: string;
  lessonId: string;
  lessonTitle: string;
  onComplete: (startingSection?: string) => void;
}

interface OnboardingData {
  knowledge_level: string;
  starting_preference: string;
}

const KNOWLEDGE_OPTIONS = [
  { value: 'new', label: `I'm new to this topic`, level: 1 },
  { value: 'basic', label: `I know basic concepts`, level: 2 },
  { value: 'explain_simple', label: `I can explain simple topics`, level: 3 },
  { value: 'discuss_various', label: `I can discuss various aspects`, level: 4 },
  { value: 'advanced_details', label: `I can dive into advanced details`, level: 5 },
];

const STARTING_POINT_OPTIONS = [
  { value: 'basics', label: 'Start from basics', subtitle: 'Begin at lesson intro', icon: '📖' },
  { value: 'find_my_level', label: 'Find my level', subtitle: 'Take a quick quiz', icon: '🎯' },
];

// Function to get mascot messages based on lesson title
const getMascotMessages = (lessonTitle: string) => [
  `Let's personalize your ${lessonTitle} experience! 🔬`,
  "Great! Let's find the perfect starting point! 🌟",
];

export default function LessonOnboarding({
  userId,
  lessonId,
  lessonTitle,
  onComplete
}: LessonOnboardingProps) {
  // EMERGENCY FIX: Prevent crash if called without lesson context
  if (!userId || !lessonId || !lessonTitle) {
    console.warn('LessonOnboarding: Missing required props (userId, lessonId, lessonTitle), skipping render');
    return null;
  }
  const [currentStep, setCurrentStep] = useState(0);
  const [onboardingData, setOnboardingData] = useState<OnboardingData>({
    knowledge_level: '',
    starting_preference: 'basics',
  });
  const [isLoading, setIsLoading] = useState(false);
  const [showQuiz, setShowQuiz] = useState(false);

  const totalSteps = 2;
  const progress = ((currentStep + 1) / totalSteps) * 100;

  const handleNext = async () => {
    if (currentStep < totalSteps - 1) {
      setCurrentStep(currentStep + 1);
    } else {
      await handleSubmit();
    }
  };

  const handleBack = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const handleSubmit = async () => {
    setIsLoading(true);

    try {
      const { error } = await supabase
        .from('user_progress')
        .upsert({
          user_id: userId,
          lesson_id: lessonId,
          onboarding_completed: true,
          onboarding_data: onboardingData,
          status: 'in_progress',
        }, {
          onConflict: 'user_id,lesson_id'
        });

      if (error) throw error;

      // Trigger confetti celebration
      confetti({
        particleCount: 100,
        spread: 70,
        origin: { y: 0.6 },
        colors: ['#3B82F6', '#8B5CF6', '#06B6D4'],
      });

      // If user wants to find their level, show quiz
      if (onboardingData.starting_preference === 'find_my_level') {
        setShowQuiz(true);
      } else {
        setTimeout(() => {
          onComplete(); // Start from beginning
        }, 1000);
      }
    } catch (error) {
      console.error('Error saving onboarding:', error);
      setIsLoading(false);
    }
  };

  const canProceed = () => {
    switch (currentStep) {
      case 0:
        return !!onboardingData.knowledge_level;
      case 1:
        return !!onboardingData.starting_preference;
      default:
        return false;
    }
  };

  if (showQuiz) {
    return <LessonQuiz userId={userId} lessonId={lessonId} lessonTitle={lessonTitle} onComplete={onComplete} />;
  }

  const renderStep = () => {
    switch (currentStep) {
      case 0:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">
              What's your current knowledge of {lessonTitle}?
            </h2>
            <RadioGroup
              value={onboardingData.knowledge_level}
              onValueChange={(value) => setOnboardingData(prev => ({ ...prev, knowledge_level: value }))}
              className="space-y-3"
            >
              {KNOWLEDGE_OPTIONS.map((option, index) => (
                <div key={option.value} className="relative">
                  <RadioGroupItem
                    value={option.value}
                    id={`level-${option.value}`}
                    className="peer sr-only"
                  />
                  <Label
                    htmlFor={`level-${option.value}`}
                    className="flex items-center gap-4 p-4 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                  >
                    <div className="flex items-center gap-3 flex-1">
                      <div className="flex items-center justify-center w-10 h-10 rounded-full bg-primary/20 text-primary font-bold">
                        {index + 1}
                      </div>
                      <span className="font-medium">{option.label.replace('this topic', lessonTitle)}</span>
                    </div>
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>
        );

      case 1:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">Let's find the best starting point!</h2>
            <RadioGroup
              value={onboardingData.starting_preference}
              onValueChange={(value) => setOnboardingData(prev => ({ ...prev, starting_preference: value }))}
              className="grid grid-cols-1 md:grid-cols-2 gap-3"
            >
              {STARTING_POINT_OPTIONS.map((option) => (
                <div key={option.value} className="relative">
                  <RadioGroupItem
                    value={option.value}
                    id={`start-${option.value}`}
                    className="peer sr-only"
                  />
                  <Label
                    htmlFor={`start-${option.value}`}
                    className="flex flex-col items-center justify-center p-6 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                  >
                    <span className="text-4xl mb-2">{option.icon}</span>
                    <span className="text-lg font-bold">{option.label}</span>
                    <span className="text-xs text-muted-foreground">{option.subtitle}</span>
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>
        );

      default:
        return null;
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/95 backdrop-blur-sm p-4">
      <Card className="w-full max-w-2xl max-h-[90vh] overflow-y-auto">
        <CardContent className="p-6">
          {/* Progress Bar */}
          <div className="mb-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium text-primary">Step {currentStep + 1} of {totalSteps}</span>
              <span className="text-sm font-medium text-primary">{Math.round(progress)}%</span>
            </div>
            <Progress value={progress} className="h-2" />
          </div>

          {/* Mascot Bubble */}
          <motion.div
            key={currentStep}
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex items-start gap-3 mb-6 p-4 rounded-xl bg-gradient-to-r from-primary/20 via-secondary/20 to-accent/20 border border-primary/30"
          >
            <div className="flex-shrink-0 w-12 h-12 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white text-2xl">
              🔬
            </div>
            <p className="text-sm font-medium flex-1">{getMascotMessages(lessonTitle)[currentStep]}</p>
          </motion.div>

          {/* Step Content */}
          <AnimatePresence mode="wait">
            <motion.div
              key={currentStep}
              initial={{ opacity: 0, x: 50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -50 }}
              transition={{ duration: 0.3 }}
              className="min-h-[300px]"
            >
              {renderStep()}
            </motion.div>
          </AnimatePresence>

          {/* Navigation Buttons */}
          <div className="flex items-center justify-between mt-8 pt-4 border-t">
            <Button
              variant="ghost"
              onClick={handleBack}
              disabled={currentStep === 0 || isLoading}
              className="flex-1 mr-2"
            >
              Back
            </Button>
            <Button
              onClick={handleNext}
              disabled={!canProceed() || isLoading}
              className="flex-1 ml-2 bg-gradient-to-r from-primary to-secondary hover:opacity-90"
            >
              {isLoading ? (
                <span className="flex items-center gap-2">
                  <motion.div
                    animate={{ rotate: 360 }}
                    transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
                  >
                    ⚙️
                  </motion.div>
                  Saving...
                </span>
              ) : currentStep === totalSteps - 1 ? (
                <span className="flex items-center gap-2">
                  <CheckCircle2 className="w-4 h-4" />
                  Complete
                </span>
              ) : (
                'Continue'
              )}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

// Lesson Quiz Component for "Find my level"
interface LessonQuizProps {
  userId: string;
  lessonId: string;
  lessonTitle: string;
  onComplete: (startingSection?: string) => void;
}

interface QuizQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: number;
  difficulty: 'easy' | 'medium' | 'hard';
}

function LessonQuiz({ userId, lessonId, lessonTitle, onComplete }: LessonQuizProps) {
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [score, setScore] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    try {
      // Fetch pre-generated quiz from database
      const { data, error } = await (supabase as any)
        .from('course_quizzes')
        .select('questions')
        .eq('course_id', lessonId)
        .single();

      if (error) {
        // If no quiz found, that's okay - show error UI
        console.warn('No pre-generated quiz found for course:', lessonId);
        setQuestions([]);
        setLoading(false);
        return;
      }

      if (data?.questions && Array.isArray(data.questions)) {
        setQuestions(data.questions);
      } else {
        setQuestions([]);
      }
    } catch (error) {
      console.error('Error loading quiz:', error);
      setQuestions([]);
    } finally {
      setLoading(false);
    }
  };

  const handleAnswerSubmit = () => {
    if (selectedAnswer === null) return;

    const isCorrect = selectedAnswer === questions[currentQuestion].correctAnswer;
    if (isCorrect) setScore(prev => prev + 1);

    setShowResult(true);
  };

  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
      setSelectedAnswer(null);
      setShowResult(false);
    } else {
      finishQuiz();
    }
  };

  const finishQuiz = async () => {
    const percentage = Math.round((score / questions.length) * 100);

    let recommendedSection: string | undefined;
    if (percentage >= 80) {
      recommendedSection = 'advanced';
    } else if (percentage >= 50) {
      recommendedSection = 'intermediate';
    }
    // Below 50% starts from beginning (no section specified)

    // Save quiz results
    await (supabase as any)
      .from('user_progress')
      .update({
        quiz_score: score,
        quiz_total_questions: questions.length,
        quiz_percentage: percentage,
        recommended_starting_section: recommendedSection,
        quiz_completed_at: new Date().toISOString(),
      })
      .eq('user_id', userId)
      .eq('lesson_id', lessonId);

    confetti({
      particleCount: 150,
      spread: 70,
      origin: { y: 0.6 },
    });

    setTimeout(() => {
      onComplete(recommendedSection);
    }, 1500);
  };

  if (loading) {
    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/95 backdrop-blur-sm">
        <Card className="w-full max-w-md p-8 text-center">
          <HelixLoader className="mx-auto mb-6" />
          <h2 className="text-xl font-bold mb-2">Loading Quiz</h2>
          <p className="text-muted-foreground">
            Preparing your placement quiz...
          </p>
        </Card>
      </div>
    );
  }

  if (questions.length === 0) {
    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/95 backdrop-blur-sm p-4">
        <Card className="w-full max-w-md">
          <CardContent className="p-8 text-center space-y-4">
            <div className="text-4xl">📚</div>
            <h2 className="text-xl font-bold">Quiz Not Available</h2>
            <p className="text-muted-foreground">
              The placement quiz for this course isn't ready yet. You can start from the beginning and we'll adjust as you learn.
            </p>
            <Button onClick={() => onComplete()} className="w-full">
              Start from Basics
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  const q = questions[currentQuestion];
  const progress = ((currentQuestion + 1) / questions.length) * 100;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/95 backdrop-blur-sm p-4">
      <Card className="w-full max-w-2xl">
        <CardContent className="p-6">
          {/* Progress */}
          <div className="mb-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium">Question {currentQuestion + 1} of {questions.length}</span>
              <span className="text-sm text-muted-foreground">Score: {score}/{currentQuestion + (showResult ? 1 : 0)}</span>
            </div>
            <Progress value={progress} className="h-2" />
          </div>

          {/* Question */}
          <div className="space-y-4">
            <div className="flex items-center gap-2 mb-4">
              <span className={`px-2 py-1 rounded text-xs font-medium ${
                q.difficulty === 'easy' ? 'bg-green-500/20 text-green-400' :
                q.difficulty === 'medium' ? 'bg-yellow-500/20 text-yellow-400' :
                'bg-red-500/20 text-red-400'
              }`}>
                {q.difficulty}
              </span>
            </div>

            <h3 className="text-xl font-bold">{q.question}</h3>

            <RadioGroup value={selectedAnswer?.toString()} onValueChange={(val) => !showResult && setSelectedAnswer(parseInt(val))}>
              {q.options.map((option, idx) => {
                const isCorrect = idx === q.correctAnswer;
                const isSelected = selectedAnswer === idx;

                return (
                  <div
                    key={idx}
                    className={`flex items-center p-4 rounded-lg border-2 transition-colors ${
                      showResult && isCorrect ? 'border-success bg-success/10' :
                      showResult && isSelected && !isCorrect ? 'border-destructive bg-destructive/10' :
                      'border-border hover:border-primary/50 hover:bg-muted/50'
                    }`}
                  >
                    <RadioGroupItem value={idx.toString()} id={`q-${idx}`} disabled={showResult} />
                    <Label htmlFor={`q-${idx}`} className="flex-1 cursor-pointer ml-3">
                      {option}
                    </Label>
                    {showResult && isCorrect && <CheckCircle2 className="w-5 h-5 text-success" />}
                  </div>
                );
              })}
            </RadioGroup>
          </div>

          {/* Navigation */}
          <div className="flex justify-between mt-6">
            <Button variant="outline" disabled={currentQuestion === 0}>
              Previous
            </Button>
            {!showResult ? (
              <Button onClick={handleAnswerSubmit} disabled={selectedAnswer === null}>
                Submit Answer
              </Button>
            ) : (
              <Button onClick={handleNext}>
                {currentQuestion === questions.length - 1 ? 'See Results' : 'Next Question'}
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
