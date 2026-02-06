import { useState, useEffect, useRef } from "react";
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
import { logChallengeCompleted, logLevelUp } from "@/utils/activityLogging";
import { checkChallengeAchievements, checkLevelAchievements } from "@/utils/achievements";
import { TIMEOUT_VALUES } from "@/utils/constants";

interface QuizQuestion {
  question: string;
  options: string[];
  correct: number;
  explanation: string;
}

interface ChallengeAnswer {
  question: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  explanation: string;
}

interface LocationState {
  topicId?: string;
  topicName?: string;
  difficulty?: 'beginner' | 'intermediate' | 'advanced';
}

// QuizResultsData matching what QuizResults component expects
interface QuizResultsData {
  id: string;
  quizType: "lesson" | "challenge";
  totalQuestions: number;
  correctAnswers: number;
  incorrectAnswers: number;
  accuracyPercentage: number;
  timeTakenSeconds: number;
  averageTimePerQuestion: number;
  xpEarned: number;
  streakBonus: number;
  answers: ChallengeAnswer[];
  difficultyLevel: string;
  completedAt: string;
  questionsPerMinute: number;
  perfectStreaks: number;
  topicsToReview: string[];
  challengeTitle?: string;
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
  const [detailedResults, setDetailedResults] = useState<QuizResultsData | null>(null);
  const [answers, setAnswers] = useState<ChallengeAnswer[]>([]);
  const [sessionStartTime] = useState(Date.now());

  const nextQuestionTimeoutRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    return () => {
      if (nextQuestionTimeoutRef.current) {
        clearTimeout(nextQuestionTimeoutRef.current);
      }
    };
  }, []);

  useEffect(() => {
    if (sessionId === 'new' || !sessionId) {
      startNewSession();
    } else {
      loadExistingSession();
    }
  }, []);

  const startNewSession = async () => {
    setLoading(true);
    let timeoutId: NodeJS.Timeout;

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const controller = new AbortController();
      timeoutId = setTimeout(() => controller.abort(), TIMEOUT_VALUES.INITIAL_REQUEST);

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
          signal: controller.signal,
        }
      );

      clearTimeout(timeoutId);

      if (!response.ok) throw new Error("Failed to start challenge");

      const data = await response.json();

      navigate(`/challenges/session/${data.session.id}`, { replace: true });

      setCurrentQuestion(data.session.currentQuestion);
      setTotalQuestions(data.session.totalQuestions);
      setXpReward(data.session.xpReward);
      setChallengeDifficulty(data.session.difficulty || 'beginner');
      setHearts(data.session.heartsRemaining);
      setQuestion(data.session.question);
      setSessionActive(true);
      setSessionEnded(false);
    } catch (error: unknown) {
      if (error instanceof Error && error.name === 'AbortError') {
        toast({
          title: "Request Timeout",
          description: "Starting the challenge took too long. Please try again.",
          variant: "destructive",
        });
      } else {
        toast({
          title: "Error",
          description: error instanceof Error ? error.message : "Failed to start challenge",
          variant: "destructive",
        });
      }
      navigate("/learning");
    } finally {
      if (timeoutId!) clearTimeout(timeoutId!);
      setLoading(false);
    }
  };

  const loadExistingSession = async () => {
    setLoading(true);
    let timeoutId: NodeJS.Timeout;

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const controller = new AbortController();
      timeoutId = setTimeout(() => controller.abort(), TIMEOUT_VALUES.INITIAL_REQUEST);

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenge-sessions/${sessionId}`,
        {
          headers: {
            Authorization: `Bearer ${session.access_token}`,
          },
          signal: controller.signal,
        }
      );

      clearTimeout(timeoutId);

      if (!response.ok) throw new Error("Failed to load session");

      const data = await response.json();
      const sessionData = data.session;

      if (sessionData.status !== 'active') {
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
    } catch (error: unknown) {
      if (error instanceof Error && error.name === 'AbortError') {
        toast({
          title: "Request Timeout",
          description: "Loading the challenge took too long. Please try again.",
          variant: "destructive",
        });
      } else {
        toast({
          title: "Error",
          description: error instanceof Error ? error.message : "Failed to load session",
          variant: "destructive",
        });
      }
      navigate("/learning");
    } finally {
      if (timeoutId!) clearTimeout(timeoutId!);
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
    let timeoutId: NodeJS.Timeout;

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const controller = new AbortController();
      timeoutId = setTimeout(() => controller.abort(), TIMEOUT_VALUES.INITIAL_REQUEST);

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
          signal: controller.signal,
        }
      );

      clearTimeout(timeoutId);

      if (!response.ok) throw new Error("Failed to submit answer");

      const data = await response.json();
      const isCorrectAnswer = data.isCorrect;

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
        const qCount = currentQuestion;
        const accuracyPercentage = Math.round((data.correctAnswers / qCount) * 100);

        setSessionEnded(true);
        setFinalResults({
          status: data.status,
          correctAnswers: data.correctAnswers,
          xpEarned: data.xpEarned,
          completionPercentage: data.completionPercentage,
        });

        const detailedResultsData: QuizResultsData = {
          id: sessionId || crypto.randomUUID(),
          quizType: 'challenge',
          totalQuestions: qCount,
          correctAnswers: data.correctAnswers,
          incorrectAnswers: qCount - data.correctAnswers,
          accuracyPercentage,
          timeTakenSeconds: timeTaken,
          averageTimePerQuestion: timeTaken / qCount,
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
          questionsPerMinute: qCount > 0 ? (qCount / timeTaken) * 60 : 0,
          perfectStreaks: 0,
          topicsToReview: [],
          challengeTitle: state?.topicName || 'General Science Challenge',
        };

        setDetailedResults(detailedResultsData);

        // Award XP and check for level up
        if (data.xpEarned > 0) {
          const userId = (await supabase.auth.getUser()).data.user?.id;
          if (userId) {
            const { data: currentStats } = await supabase
              .from('user_stats')
              .select('xp_total')
              .eq('user_id', userId)
              .single();

            const oldXp = currentStats?.xp_total || 0;
            const newXp = oldXp + data.xpEarned;

            await logChallengeCompleted(
              userId,
              sessionId!,
              state?.topicName || 'General Science Challenge',
              data.correctAnswers,
              qCount,
              challengeDifficulty,
              data.xpEarned
            );

            if (didLevelUp(oldXp, newXp)) {
              const newLevel = calculateLevel(newXp);
              setTimeout(() => triggerLevelUpConfetti(), 500);
              toast({
                title: `Level Up! You're now Level ${newLevel}!`,
                description: `You earned ${data.xpEarned} XP from this challenge!`,
              });

              await logLevelUp(userId, newLevel, newXp);
              await checkLevelAchievements(userId, newLevel);
            } else if (data.status === 'completed') {
              setTimeout(() => triggerSuccessConfetti(), 500);
              toast({
                title: "Challenge Complete! 🎉",
                description: `You earned ${data.xpEarned} XP!`,
              });

              // Check challenge achievements using study_sessions as proxy
              const { data: completedSessions } = await supabase
                .from('study_sessions')
                .select('id')
                .eq('user_id', userId);

              const challengeCount = completedSessions?.length || 0;
              await checkChallengeAchievements(userId, challengeCount);
            }
          }
        }
      } else {
        if (nextQuestionTimeoutRef.current) {
          clearTimeout(nextQuestionTimeoutRef.current);
        }

        nextQuestionTimeoutRef.current = setTimeout(() => {
          setCurrentQuestion(data.currentQuestion);
          setQuestion(data.nextQuestion);
          setSelectedAnswer(null);
          setShowFeedback(false);
          setExplanation("");
          nextQuestionTimeoutRef.current = null;
        }, 2000);
      }
    } catch (error: unknown) {
      if (error instanceof Error && error.name === 'AbortError') {
        toast({
          title: "Request Timeout",
          description: "Submitting your answer took too long. Please try again.",
          variant: "destructive",
        });
      } else {
        toast({
          title: "Error",
          description: error instanceof Error ? error.message : "Failed to submit answer",
          variant: "destructive",
        });
      }
    } finally {
      if (timeoutId!) clearTimeout(timeoutId!);
      setSubmitting(false);
    }
  };

  const handleRetry = () => {
    if (nextQuestionTimeoutRef.current) {
      clearTimeout(nextQuestionTimeoutRef.current);
      nextQuestionTimeoutRef.current = null;
    }

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
    navigate("/learning");
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
            <p className="text-muted-foreground">No active challenge session</p>
            <Button onClick={() => navigate("/learning")} className="mt-4">
              <Home className="w-4 h-4 mr-2" />
              Return to Learning
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  const progressPercentage = (currentQuestion / totalQuestions) * 100;

  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-background to-primary/5 p-4">
      <div className="max-w-3xl mx-auto">
        {/* Header */}
        <div className="flex items-center justify-between mb-6">
          <Button variant="ghost" onClick={() => navigate("/learning")}>
            <ArrowLeft className="w-4 h-4 mr-2" />
            Exit
          </Button>
          <div className="flex items-center gap-2">
            <Badge variant="outline">{challengeDifficulty}</Badge>
            <Badge variant="secondary">
              <Trophy className="w-3 h-3 mr-1" />
              {xpReward} XP
            </Badge>
          </div>
        </div>

        {/* Progress */}
        <div className="mb-6 space-y-2">
          <div className="flex items-center justify-between text-sm">
            <span className="text-muted-foreground">
              Question {currentQuestion} of {totalQuestions}
            </span>
            <div className="flex items-center gap-1">
              {Array.from({ length: 3 }).map((_, i) => (
                <Heart
                  key={i}
                  className={`w-5 h-5 ${i < hearts ? "text-red-500 fill-red-500" : "text-muted"}`}
                />
              ))}
            </div>
          </div>
          <Progress value={progressPercentage} className="h-2" />
        </div>

        {/* Question */}
        <AnimatePresence mode="wait">
          <motion.div
            key={currentQuestion}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
          >
            <Card className="mb-6">
              <CardHeader>
                <CardTitle className="text-xl">{question.question}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {question.options.map((option, idx) => {
                  const isSelected = selectedAnswer === idx;
                  const isCorrectOption = idx === question.correct;
                  const showCorrect = showFeedback && isCorrectOption;
                  const showWrong = showFeedback && isSelected && !isCorrectOption;

                  return (
                    <Button
                      key={idx}
                      variant="outline"
                      className={`w-full justify-start text-left h-auto py-4 px-4 ${
                        isSelected && !showFeedback ? "border-primary bg-primary/10" : ""
                      } ${showCorrect ? "border-green-500 bg-green-500/10" : ""} ${
                        showWrong ? "border-red-500 bg-red-500/10" : ""
                      }`}
                      onClick={() => handleAnswerSelect(idx)}
                      disabled={showFeedback}
                    >
                      <div className="flex items-center gap-3 w-full">
                        <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold ${
                          showCorrect ? "bg-green-500 text-white" :
                          showWrong ? "bg-red-500 text-white" :
                          isSelected ? "bg-primary text-primary-foreground" :
                          "bg-muted"
                        }`}>
                          {showCorrect ? <CheckCircle2 className="w-4 h-4" /> :
                           showWrong ? <XCircle className="w-4 h-4" /> :
                           String.fromCharCode(65 + idx)}
                        </div>
                        <span className="flex-1">{option}</span>
                      </div>
                    </Button>
                  );
                })}
              </CardContent>
            </Card>
          </motion.div>
        </AnimatePresence>

        {/* Feedback */}
        {showFeedback && (
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <Card className={`mb-6 ${isCorrect ? "border-green-500/50" : "border-red-500/50"}`}>
              <CardContent className="p-4">
                <div className="flex items-center gap-2 mb-2">
                  {isCorrect ? (
                    <CheckCircle2 className="w-5 h-5 text-green-500" />
                  ) : (
                    <XCircle className="w-5 h-5 text-red-500" />
                  )}
                  <span className={`font-semibold ${isCorrect ? "text-green-500" : "text-red-500"}`}>
                    {isCorrect ? "Correct!" : "Incorrect"}
                  </span>
                </div>
                <p className="text-sm text-muted-foreground">{explanation}</p>
              </CardContent>
            </Card>
          </motion.div>
        )}

        {/* Submit Button */}
        {!showFeedback && (
          <Button
            className="w-full"
            size="lg"
            onClick={submitAnswer}
            disabled={selectedAnswer === null || submitting}
          >
            {submitting ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Checking...
              </>
            ) : (
              <>
                <Target className="w-4 h-4 mr-2" />
                Submit Answer
              </>
            )}
          </Button>
        )}

        {/* Score */}
        <div className="mt-4 text-center text-sm text-muted-foreground">
          Score: {correctAnswers}/{currentQuestion - (showFeedback ? 0 : 1)} correct
        </div>
      </div>
    </div>
  );
}
