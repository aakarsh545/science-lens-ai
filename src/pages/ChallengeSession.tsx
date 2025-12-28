import { useState, useEffect } from "react";
import { useParams, useNavigate, useLocation } from "react-router-dom";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import QuizResults from "@/pages/QuizResults";
import {
  Heart,
  Trophy,
  Target,
  ArrowLeft,
  RotateCcw,
  Home,
  Loader2,
  CheckCircle2,
  XCircle,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { calculateLevel, didLevelUp } from "@/utils/levelCalculations";
import { triggerLevelUpConfetti, triggerSuccessConfetti } from "@/utils/confettiEffects";

interface QuizQuestion {
  question: string;
  options: string[];
  correct: number;
  explanation: string;
}

interface LocationState {
  topicId?: string;
  topicName?: string;
  difficulty?: 'beginner' | 'intermediate' | 'advanced';
}

export default function ChallengeSession() {
  const { sessionId } = useParams();
  const navigate = useNavigate();
  const location = useLocation();
  const state = location.state as LocationState;
  const { toast } = useToast();

  // Session state
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [sessionActive, setSessionActive] = useState(false);

  // Challenge state
  const [currentQuestion, setCurrentQuestion] = useState(1);
  const [totalQuestions, setTotalQuestions] = useState(15);
  const [xpReward, setXpReward] = useState(100);
  const [challengeDifficulty, setChallengeDifficulty] = useState<'beginner' | 'intermediate' | 'advanced'>('beginner');
  const [hearts, setHearts] = useState(3);
  const [correctAnswers, setCorrectAnswers] = useState(0);
  const [question, setQuestion] = useState<QuizQuestion | null>(null);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);

  // Feedback state
  const [showFeedback, setShowFeedback] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  const [explanation, setExplanation] = useState("");

  // Results state
  const [sessionEnded, setSessionEnded] = useState(false);
  const [finalResults, setFinalResults] = useState<{
    status: 'completed' | 'failed';
    correctAnswers: number;
    xpEarned: number;
    completionPercentage: number;
  } | null>(null);
  const [detailedResults, setDetailedResults] = useState<unknown>(null);
  const [answers, setAnswers] = useState<unknown[]>([]);
  const [sessionStartTime] = useState(Date.now());

  // Start session on mount
  useEffect(() => {
    if (sessionId === 'new' || !sessionId) {
      startNewSession();
    } else {
      loadExistingSession();
    }
  }, []);

  const startNewSession = async () => {
    setLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenge-sessions/start`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${session.access_token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            topicId: state?.topicId || null,
            topicName: state?.topicName || 'General Science',
            difficulty: state?.difficulty || 'beginner',
          }),
        }
      );

      if (!response.ok) throw new Error("Failed to start challenge");

      const data = await response.json();

      // Update URL to actual session ID
      navigate(`/science-lens/challenges/session/${data.session.id}`, { replace: true });

      setCurrentQuestion(data.session.currentQuestion);
      setTotalQuestions(data.session.totalQuestions);
      setXpReward(data.session.xpReward);
      setChallengeDifficulty(data.session.difficulty || 'beginner');
      setHearts(data.session.heartsRemaining);
      setQuestion(data.session.question);
      setSessionActive(true);
      setSessionEnded(false);
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to start challenge",
        variant: "destructive",
      });
      navigate("/science-lens/learning");
    } finally {
      setLoading(false);
    }
  };

  const loadExistingSession = async () => {
    setLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenge-sessions/${sessionId}`,
        {
          headers: {
            Authorization: `Bearer ${session.access_token}`,
          },
        }
      );

      if (!response.ok) throw new Error("Failed to load session");

      const data = await response.json();
      const sessionData = data.session;

      if (sessionData.status !== 'active') {
        // Session already ended
        setSessionEnded(true);
        setFinalResults({
          status: sessionData.status,
          correctAnswers: sessionData.correct_answers,
          xpEarned: sessionData.xp_earned,
          completionPercentage: sessionData.completion_percentage,
        });
        return;
      }

      setCurrentQuestion(sessionData.current_question);
      setTotalQuestions(sessionData.total_questions);
      setXpReward(sessionData.xp_reward || 100);
      setChallengeDifficulty(sessionData.challenge_difficulty || 'beginner');
      setHearts(sessionData.hearts_remaining);
      setCorrectAnswers(sessionData.correct_answers);
      const questions = sessionData.questions as QuizQuestion[];
      setQuestion(questions[sessionData.current_question - 1]);
      setSessionActive(true);
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to load session",
        variant: "destructive",
      });
      navigate("/science-lens/learning");
    } finally {
      setLoading(false);
    }
  };

  const handleAnswerSelect = (answerIndex: number) => {
    if (showFeedback) return;
    setSelectedAnswer(answerIndex);
  };

  const submitAnswer = async () => {
    if (selectedAnswer === null || !question) return;

    setSubmitting(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenge-sessions/${sessionId}/answer`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${session.access_token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            answerIndex: selectedAnswer,
          }),
        }
      );

      if (!response.ok) throw new Error("Failed to submit answer");

      const data = await response.json();
      const isCorrectAnswer = data.isCorrect;

      // Track this answer
      setAnswers(prev => [...prev, {
        question: question.question,
        userAnswer: question.options[selectedAnswer],
        correctAnswer: question.options[question.correct],
        isCorrect: isCorrectAnswer,
        explanation: data.explanation,
      }]);

      setIsCorrect(isCorrectAnswer);
      setExplanation(data.explanation);
      setHearts(data.heartsRemaining);
      setCorrectAnswers(data.correctAnswers);
      setShowFeedback(true);

      if (data.sessionEnded) {
        const timeTaken = Math.floor((Date.now() - sessionStartTime) / 1000);
        const totalQuestions = currentQuestion;
        const accuracyPercentage = Math.round((data.correctAnswers / totalQuestions) * 100);

        setSessionEnded(true);
        setFinalResults({
          status: data.status,
          correctAnswers: data.correctAnswers,
          xpEarned: data.xpEarned,
          completionPercentage: data.completionPercentage,
        });

        // Prepare detailed results
        const detailedResultsData = {
          quizType: 'challenge' as const,
          challengeSessionId: sessionId,
          totalQuestions,
          correctAnswers: data.correctAnswers,
          incorrectAnswers: totalQuestions - data.correctAnswers,
          accuracyPercentage,
          timeTakenSeconds: timeTaken,
          averageTimePerQuestion: timeTaken / totalQuestions,
          xpEarned: data.xpEarned,
          streakBonus: 0,
          answers: answers.concat([{
            question: question.question,
            userAnswer: question.options[selectedAnswer],
            correctAnswer: question.options[question.correct],
            isCorrect: isCorrectAnswer,
            explanation: data.explanation,
          }]),
          difficultyLevel: challengeDifficulty,
          completedAt: new Date().toISOString(),
          questionsPerMinute: totalQuestions > 0 ? (totalQuestions / timeTaken) * 60 : 0,
          perfectStreaks: 0,
          topicsToReview: [],
          challengeTitle: state?.topicName || 'General Science Challenge',
        };

        setDetailedResults(detailedResultsData);

        // Save to database
        try {
          const userId = (await supabase.auth.getUser()).data.user?.id;
          if (userId) {
            await supabase.from('quiz_results').insert({
              user_id: userId,
              challenge_session_id: sessionId,
              quiz_type: 'challenge',
              total_questions: totalQuestions,
              correct_answers: data.correctAnswers,
              incorrect_answers: totalQuestions - data.correctAnswers,
              accuracy_percentage: accuracyPercentage,
              time_taken_seconds: timeTaken,
              average_time_per_question: timeTaken / totalQuestions,
              xp_earned: data.xpEarned,
              streak_bonus: 0,
              answers: detailedResultsData.answers,
              difficulty_level: challengeDifficulty,
              questions_per_minute: detailedResultsData.questionsPerMinute,
              perfect_streaks: 0,
              topics_to_review: [],
            });
          }
        } catch (error) {
          console.error('Error saving quiz results:', error);
        }

        // Award XP and check for level up
        if (data.xpEarned > 0) {
          const { data: currentStats } = await supabase
            .from('user_stats')
            .select('xp_total')
            .eq('user_id', (await supabase.auth.getUser()).data.user?.id!)
            .single();

          const oldXp = currentStats?.xp_total || 0;
          const newXp = oldXp + data.xpEarned;

          if (didLevelUp(oldXp, newXp)) {
            const newLevel = calculateLevel(newXp);
            setTimeout(() => triggerLevelUpConfetti(), 500);
            toast({
              title: `Level Up! You're now Level ${newLevel}!`,
              description: `You earned ${data.xpEarned} XP from this challenge!`,
            });
          } else if (data.status === 'completed') {
            setTimeout(() => triggerSuccessConfetti(), 500);
            toast({
              title: "Challenge Complete! 🎉",
              description: `You earned ${data.xpEarned} XP!`,
            });
          }
        }
      } else {
        // Load next question after delay
        setTimeout(() => {
          setCurrentQuestion(data.currentQuestion);
          setQuestion(data.nextQuestion);
          setSelectedAnswer(null);
          setShowFeedback(false);
          setExplanation("");
        }, 2000);
      }
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message || "Failed to submit answer",
        variant: "destructive",
      });
    } finally {
      setSubmitting(false);
    }
  };

  const handleRetry = () => {
    setSessionEnded(false);
    setFinalResults(null);
    setDetailedResults(null);
    setAnswers([]);
    setCorrectAnswers(0);
    setHearts(3);
    setCurrentQuestion(1);
    setSelectedAnswer(null);
    setShowFeedback(false);
    startNewSession();
  };

  const handleReturnToChallenges = () => {
    navigate("/science-lens/learning");
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-background via-background to-primary/5">
        <Card className="w-full max-w-2xl mx-4">
          <CardContent className="flex flex-col items-center justify-center py-16">
            <Loader2 className="h-12 w-12 animate-spin text-primary mb-4" />
            <p className="text-muted-foreground">Loading challenge...</p>
          </CardContent>
        </Card>
      </div>
    );
  }

  if (sessionEnded && finalResults && detailedResults) {
    return <QuizResults results={detailedResults} onRetry={handleRetry} onReturn={handleReturnToChallenges} />;
  }

  if (!question || !sessionActive) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-background via-background to-primary/5">
        <Card className="w-full max-w-2xl mx-4">
          <CardContent className="flex flex-col items-center justify-center py-16">
            <p className="text-muted-foreground">Session not found</p>
            <Button onClick={handleReturnToChallenges} className="mt-4">
              Return to Challenges
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-background to-primary/5 p-4">
      <div className="max-w-3xl mx-auto pt-8">
        {/* Header */}
        <div className="mb-6">
          <Button
            variant="ghost"
            onClick={handleReturnToChallenges}
            className="mb-4"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Exit Challenge
          </Button>

          <Card className="border-primary/20">
            <CardHeader>
              <div className="flex items-center justify-between">
                <div>
                  <CardTitle className="flex items-center gap-2">
                    <Target className="h-5 w-5 text-primary" />
                    Challenge Session
                  </CardTitle>
                  <CardDescription>
                    {challengeDifficulty === 'beginner' && 'Beginner: 15 questions, 100 XP'}
                    {challengeDifficulty === 'intermediate' && 'Intermediate: 30 questions, 200 XP'}
                    {challengeDifficulty === 'advanced' && 'Advanced: 45 questions, 500 XP'}
                  </CardDescription>
                </div>

                {/* Hearts Display */}
                <div className="flex items-center gap-1">
                  {[0, 1, 2].map((i) => (
                    <motion.div
                      key={i}
                      initial={false}
                      animate={{
                        scale: i < hearts ? 1 : 0.8,
                        opacity: i < hearts ? 1 : 0.3,
                      }}
                      transition={{ duration: 0.2 }}
                    >
                      <Heart
                        className={`h-6 w-6 ${
                          i < hearts ? 'fill-red-500 text-red-500' : 'text-muted-foreground'
                        }`}
                      />
                    </motion.div>
                  ))}
                </div>
              </div>

              {/* Progress Bar */}
              <div className="space-y-2 mt-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">
                    Question {currentQuestion} of {totalQuestions}
                  </span>
                  <span className="font-medium">{correctAnswers} correct</span>
                </div>
                <Progress value={(currentQuestion / totalQuestions) * 100} />
              </div>
            </CardHeader>
          </Card>
        </div>

        {/* Question Card */}
        <AnimatePresence mode="wait">
          <motion.div
            key={currentQuestion}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            transition={{ duration: 0.3 }}
          >
            <Card className="border-primary/20">
              <CardHeader>
                <CardTitle className="text-xl">{question.question}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {question.options.map((option, index) => {
                  const isSelected = selectedAnswer === index;
                  const showCorrect = showFeedback && index === question.correct;
                  const showIncorrect = showFeedback && isSelected && !isCorrect;

                  return (
                    <motion.div
                      key={index}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: index * 0.05 }}
                    >
                      <Button
                        variant={isSelected ? 'default' : 'outline'}
                        className={`w-full justify-start text-left h-auto py-4 px-6 ${
                          showCorrect ? 'bg-green-500 hover:bg-green-600 text-white border-green-500' : ''
                        } ${
                          showIncorrect ? 'bg-red-500 hover:bg-red-600 text-white border-red-500' : ''
                        }`}
                        onClick={() => handleAnswerSelect(index)}
                        disabled={showFeedback || submitting}
                      >
                        <span className="flex items-center gap-3 w-full">
                          <span className="flex-shrink-0 w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center font-semibold">
                            {String.fromCharCode(65 + index)}
                          </span>
                          <span className="flex-1">{option}</span>
                          {showCorrect && <CheckCircle2 className="h-5 w-5" />}
                          {showIncorrect && <XCircle className="h-5 w-5" />}
                        </span>
                      </Button>
                    </motion.div>
                  );
                })}
              </CardContent>
            </Card>
          </motion.div>
        </AnimatePresence>

        {/* Feedback Section */}
        <AnimatePresence>
          {showFeedback && (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
              className="mt-4"
            >
              <Card className={`border-2 ${isCorrect ? 'border-green-500' : 'border-red-500'}`}>
                <CardContent className="pt-6">
                  <div className="flex items-start gap-3">
                    {isCorrect ? (
                      <CheckCircle2 className="h-6 w-6 text-green-500 flex-shrink-0 mt-1" />
                    ) : (
                      <XCircle className="h-6 w-6 text-red-500 flex-shrink-0 mt-1" />
                    )}
                    <div>
                      <p className={`font-semibold text-lg mb-1 ${isCorrect ? 'text-green-600' : 'text-red-600'}`}>
                        {isCorrect ? 'Correct!' : 'Incorrect!'}
                      </p>
                      <p className="text-muted-foreground">{explanation}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Submit Button */}
        {!showFeedback && selectedAnswer !== null && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mt-6"
          >
            <Button
              size="lg"
              className="w-full"
              onClick={submitAnswer}
              disabled={submitting}
            >
              {submitting ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Submitting...
                </>
              ) : (
                'Submit Answer'
              )}
            </Button>
          </motion.div>
        )}
      </div>
    </div>
  );
}
