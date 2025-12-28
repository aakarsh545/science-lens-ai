import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { supabase } from "@/integrations/supabase/client";
import { toast } from "sonner";
import {
  Trophy,
  Target,
  Clock,
  CheckCircle2,
  XCircle,
  TrendingUp,
  Award,
  Home,
  RotateCcw,
  BookOpen,
  Share2,
  Star,
  Zap,
  ArrowLeft,
  ChevronRight,
  Brain,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import {
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart";
import {
  LineChart,
  Line,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  ResponsiveContainer,
  Cell,
  PieChart,
  Pie,
  RadarChart,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  Radar,
} from "recharts";
import { triggerLevelUpConfetti, triggerLessonCompleteConfetti } from "@/utils/confettiEffects";

interface AnswerRecord {
  question: string;
  userAnswer: string;
  correctAnswer: string;
  isCorrect: boolean;
  timeSpent?: number;
  explanation?: string;
}

interface QuizResultsData {
  id: string;
  quizType: "lesson" | "challenge";
  lessonId?: string;
  challengeSessionId?: string;
  totalQuestions: number;
  correctAnswers: number;
  incorrectAnswers: number;
  accuracyPercentage: number;
  timeTakenSeconds: number;
  averageTimePerQuestion: number;
  xpEarned: number;
  streakBonus: number;
  answers: AnswerRecord[];
  previousAttempt?: {
    id: string;
    accuracyPercentage: number;
    completedAt: string;
  };
  improvementPercentage?: number;
  difficultyLevel?: string;
  completedAt: string;
  questionsPerMinute: number;
  perfectStreaks: number;
  topicsToReview: string[];
  lessonTitle?: string;
  challengeTitle?: string;
}

interface QuizResultsProps {
  results: QuizResultsData;
  onReturn: () => void;
  onRetry?: () => void;
  onContinue?: () => void;
  showReviewButton?: boolean;
}

// Animated counter component
function AnimatedCounter({ value, duration = 1.5 }: { value: number; duration?: number }) {
  const [count, setCount] = useState(0);

  useEffect(() => {
    let startTime: number;
    let animationFrame: number;

    const animate = (currentTime: number) => {
      if (!startTime) startTime = currentTime;
      const progress = Math.min((currentTime - startTime) / (duration * 1000), 1);

      setCount(Math.floor(progress * value));

      if (progress < 1) {
        animationFrame = requestAnimationFrame(animate);
      }
    };

    animationFrame = requestAnimationFrame(animate);
    return () => cancelAnimationFrame(animationFrame);
  }, [value, duration]);

  return <span>{count}</span>;
}

export default function QuizResults({
  results,
  onReturn,
  onRetry,
  onContinue,
  showReviewButton = true,
}: QuizResultsProps) {
  const navigate = useNavigate();
  const [showReviewModal, setShowReviewModal] = useState(false);

  useEffect(() => {
    // Trigger confetti based on performance
    if (results.accuracyPercentage >= 90) {
      triggerLevelUpConfetti();
    } else if (results.accuracyPercentage >= 70) {
      triggerLessonCompleteConfetti();
    }
  }, [results.accuracyPercentage]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, "0")}`;
  };

  const accuracyColor =
    results.accuracyPercentage >= 80
      ? "text-green-500"
      : results.accuracyPercentage >= 60
      ? "text-yellow-500"
      : "text-red-500";

  const accuracyBg =
    results.accuracyPercentage >= 80
      ? "bg-green-500"
      : results.accuracyPercentage >= 60
      ? "bg-yellow-500"
      : "bg-red-500";

  // Prepare chart data
  const accuracyData = results.answers.map((answer, index) => ({
    question: `Q${index + 1}`,
    accuracy: answer.isCorrect ? 100 : 0,
  }));

  const performanceData = [
    { name: "Correct", value: results.correctAnswers, color: "#22c55e" },
    { name: "Incorrect", value: results.incorrectAnswers, color: "#ef4444" },
  ];

  // Generate radar chart data (simulated topics)
  const topicPerformance = [
    { topic: "Knowledge", value: Math.min(100, results.accuracyPercentage + Math.random() * 20 - 10) },
    { topic: "Speed", value: Math.min(100, (results.questionsPerMinute / 2) * 100) },
    { topic: "Accuracy", value: results.accuracyPercentage },
    { topic: "Consistency", value: Math.min(100, results.accuracyPercentage + (results.perfectStreaks * 5)) },
  ].map(item => ({ ...item, fullMark: 100 }));

  const handleShare = async () => {
    const shareText = `🎯 Just completed a ${results.quizType}!\n\n` +
      `Score: ${results.correctAnswers}/${results.totalQuestions}\n` +
      `Accuracy: ${results.accuracyPercentage}%\n` +
      `XP Earned: +${results.xpEarned}\n\n` +
      `Science Lens AI - Learning Science with AI!`;

    if (navigator.share) {
      try {
        await navigator.share({
          title: "Quiz Results - Science Lens AI",
          text: shareText,
        });
      } catch (error) {
        console.error("Error sharing:", error);
      }
    } else {
      // Fallback: copy to clipboard
      navigator.clipboard.writeText(shareText);
      toast.success("Results copied to clipboard!");
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-background to-primary/5 p-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="max-w-6xl mx-auto py-8"
      >
        {/* Header */}
        <div className="mb-6 flex items-center justify-between">
          <Button variant="ghost" onClick={onReturn}>
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Learning
          </Button>
          <Badge variant="outline" className="text-sm">
            {results.quizType === "lesson" ? "Lesson Quiz" : "Challenge Mode"}
          </Badge>
        </div>

        {/* Main Results Card */}
        <Card className="border-primary/20 mb-6">
          <CardHeader className="text-center pb-8">
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.2, type: "spring" }}
              className="mx-auto mb-4"
            >
              {results.accuracyPercentage >= 80 ? (
                <Trophy className="h-24 w-24 text-yellow-500" />
              ) : results.accuracyPercentage >= 60 ? (
                <Target className="h-24 w-24 text-blue-500" />
              ) : (
                <Brain className="h-24 w-24 text-purple-500" />
              )}
            </motion.div>
            <CardTitle className="text-4xl mb-2">
              {results.quizType === "lesson" ? results.lessonTitle : results.challengeTitle}
            </CardTitle>
            <p className="text-muted-foreground text-lg">
              {results.accuracyPercentage >= 80
                ? "Excellent work! You've mastered this topic!"
                : results.accuracyPercentage >= 60
                ? "Good job! Keep practicing to improve!"
                : "Keep learning! Review the topics below and try again."}
            </p>
          </CardHeader>

          <CardContent className="space-y-8">
            {/* Main Score Display */}
            <div className="text-center py-8 bg-gradient-to-r from-primary/10 to-primary/5 rounded-xl">
              <div className="flex items-center justify-center gap-4 mb-4">
                <AnimatedCounter value={results.correctAnswers} />
                <span className="text-4xl text-muted-foreground">/</span>
                <span className="text-4xl">{results.totalQuestions}</span>
              </div>
              <p className="text-muted-foreground mb-6">questions answered correctly</p>

              {/* Accuracy Percentage */}
              <div className="flex items-center justify-center gap-6">
                <div className="text-center">
                  <div className={`text-6xl font-bold ${accuracyColor}`}>
                    <AnimatedCounter value={results.accuracyPercentage} />
                    <span className="text-4xl">%</span>
                  </div>
                  <p className="text-sm text-muted-foreground mt-2">Accuracy</p>
                </div>
              </div>

              {/* Accuracy Progress Bar */}
              <div className="mt-6 px-8">
                <Progress value={results.accuracyPercentage} className="h-3" />
              </div>
            </div>

            {/* Performance Metrics Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              {/* XP Earned */}
              <Card className="bg-gradient-to-br from-yellow-500/10 to-orange-500/10 border-yellow-500/20">
                <CardContent className="pt-6 text-center">
                  <div className="flex justify-center mb-2">
                    <div className="p-2 bg-yellow-500/20 rounded-lg">
                      <Star className="h-6 w-6 text-yellow-500" />
                    </div>
                  </div>
                  <p className="text-3xl font-bold text-yellow-500">
                    +<AnimatedCounter value={results.xpEarned} />
                  </p>
                  <p className="text-sm text-muted-foreground mt-1">XP Earned</p>
                  {results.streakBonus > 0 && (
                    <Badge variant="outline" className="mt-2 text-xs">
                      +{results.streakBonus} streak bonus
                    </Badge>
                  )}
                </CardContent>
              </Card>

              {/* Time Taken */}
              <Card className="bg-gradient-to-br from-blue-500/10 to-cyan-500/10 border-blue-500/20">
                <CardContent className="pt-6 text-center">
                  <div className="flex justify-center mb-2">
                    <div className="p-2 bg-blue-500/20 rounded-lg">
                      <Clock className="h-6 w-6 text-blue-500" />
                    </div>
                  </div>
                  <p className="text-3xl font-bold text-blue-500">{formatTime(results.timeTakenSeconds)}</p>
                  <p className="text-sm text-muted-foreground mt-1">Time Taken</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Avg: {results.averageTimePerQuestion.toFixed(1)}s/question
                  </p>
                </CardContent>
              </Card>

              {/* Speed */}
              <Card className="bg-gradient-to-br from-green-500/10 to-emerald-500/10 border-green-500/20">
                <CardContent className="pt-6 text-center">
                  <div className="flex justify-center mb-2">
                    <div className="p-2 bg-green-500/20 rounded-lg">
                      <Zap className="h-6 w-6 text-green-500" />
                    </div>
                  </div>
                  <p className="text-3xl font-bold text-green-500">
                    {results.questionsPerMinute.toFixed(1)}
                  </p>
                  <p className="text-sm text-muted-foreground mt-1">Questions/Min</p>
                  <p className="text-xs text-muted-foreground mt-1">
                    {results.perfectStreaks} perfect streaks
                  </p>
                </CardContent>
              </Card>

              {/* Difficulty */}
              {results.difficultyLevel && (
                <Card className="bg-gradient-to-br from-purple-500/10 to-pink-500/10 border-purple-500/20">
                  <CardContent className="pt-6 text-center">
                    <div className="flex justify-center mb-2">
                      <div className="p-2 bg-purple-500/20 rounded-lg">
                        <Target className="h-6 w-6 text-purple-500" />
                      </div>
                    </div>
                    <p className="text-2xl font-bold text-purple-500 capitalize">
                      {results.difficultyLevel}
                    </p>
                    <p className="text-sm text-muted-foreground mt-1">Difficulty</p>
                  </CardContent>
                </Card>
              )}
            </div>

            {/* Comparison with Previous Attempt */}
            {results.previousAttempt && results.improvementPercentage !== undefined && (
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
              >
                <Card className={`border-2 ${
                  results.improvementPercentage > 0
                    ? "border-green-500 bg-green-500/5"
                    : results.improvementPercentage < 0
                    ? "border-red-500 bg-red-500/5"
                    : "border-gray-500"
                }`}>
                  <CardContent className="pt-6">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        {results.improvementPercentage > 0 ? (
                          <TrendingUp className="h-8 w-8 text-green-500" />
                        ) : results.improvementPercentage < 0 ? (
                          <TrendingUp className="h-8 w-8 text-red-500 rotate-180" />
                        ) : (
                          <Target className="h-8 w-8 text-gray-500" />
                        )}
                        <div>
                          <p className="font-semibold text-lg">
                            {results.improvementPercentage > 0
                              ? `${Math.abs(results.improvementPercentage)}% Better!`
                              : results.improvementPercentage < 0
                              ? `${Math.abs(results.improvementPercentage)}% Lower`
                              : "Same Performance"}
                          </p>
                          <p className="text-sm text-muted-foreground">
                            Compared to your previous attempt
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-2xl font-bold">
                          {results.previousAttempt.accuracyPercentage}%
                        </p>
                        <p className="text-xs text-muted-foreground">Previous Score</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            )}

            {/* Charts Section */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Performance Over Time - Line Chart */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Performance Over Quiz</CardTitle>
                </CardHeader>
                <CardContent>
                  <ChartContainer
                    config={{
                      accuracy: {
                        label: "Accuracy",
                        color: "hsl(var(--primary))",
                      },
                    }}
                    className="h-[200px]"
                  >
                    <ResponsiveContainer width="100%" height="100%">
                      <LineChart data={accuracyData}>
                        <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                        <XAxis
                          dataKey="question"
                          className="text-xs"
                          stroke="hsl(var(--muted-foreground))"
                        />
                        <YAxis
                          domain={[0, 100]}
                          className="text-xs"
                          stroke="hsl(var(--muted-foreground))"
                        />
                        <ChartTooltip content={<ChartTooltipContent />} />
                        <Line
                          type="monotone"
                          dataKey="accuracy"
                          stroke="hsl(var(--primary))"
                          strokeWidth={2}
                          dot={{ r: 4 }}
                        />
                      </LineChart>
                    </ResponsiveContainer>
                  </ChartContainer>
                </CardContent>
              </Card>

              {/* Correct vs Incorrect - Bar Chart */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Correct vs Incorrect</CardTitle>
                </CardHeader>
                <CardContent>
                  <ChartContainer
                    config={{
                      correct: { label: "Correct", color: "#22c55e" },
                      incorrect: { label: "Incorrect", color: "#ef4444" },
                    }}
                    className="h-[200px]"
                  >
                    <ResponsiveContainer width="100%" height="100%">
                      <BarChart data={performanceData}>
                        <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                        <XAxis
                          dataKey="name"
                          className="text-xs"
                          stroke="hsl(var(--muted-foreground))"
                        />
                        <YAxis className="text-xs" stroke="hsl(var(--muted-foreground))" />
                        <ChartTooltip content={<ChartTooltipContent />} />
                        <Bar dataKey="value" radius={[8, 8, 0, 0]}>
                          {performanceData.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={entry.color} />
                          ))}
                        </Bar>
                      </BarChart>
                    </ResponsiveContainer>
                  </ChartContainer>
                </CardContent>
              </Card>
            </div>

            {/* Topics to Review */}
            {results.topicsToReview.length > 0 && (
              <Card className="border-orange-500/20 bg-orange-500/5">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center gap-2">
                    <BookOpen className="h-5 w-5 text-orange-500" />
                    Topics to Review
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex flex-wrap gap-2">
                    {results.topicsToReview.map((topic, index) => (
                      <Badge key={index} variant="outline" className="text-sm py-2 px-3">
                        {topic}
                      </Badge>
                    ))}
                  </div>
                  <p className="text-sm text-muted-foreground mt-4">
                    Review these lessons to improve your score next time!
                  </p>
                </CardContent>
              </Card>
            )}

            {/* Action Buttons */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Button
                variant="outline"
                size="lg"
                className="w-full"
                onClick={onReturn}
              >
                <Home className="h-4 w-4 mr-2" />
                Return to Learning
              </Button>

              {showReviewButton && (
                <Button
                  variant="outline"
                  size="lg"
                  className="w-full"
                  onClick={() => setShowReviewModal(true)}
                >
                  <BookOpen className="h-4 w-4 mr-2" />
                  Review Answers
                </Button>
              )}

              {onRetry && (
                <Button size="lg" className="w-full" onClick={onRetry}>
                  <RotateCcw className="h-4 w-4 mr-2" />
                  Try Again
                </Button>
              )}

              {onContinue && (
                <Button size="lg" className="w-full" onClick={onContinue}>
                  Continue
                  <ChevronRight className="h-4 w-4 ml-2" />
                </Button>
              )}

              <Button
                variant="outline"
                size="lg"
                className="w-full"
                onClick={handleShare}
              >
                <Share2 className="h-4 w-4 mr-2" />
                Share Results
              </Button>
            </div>
          </CardContent>
        </Card>
      </motion.div>

      {/* Review Answers Modal */}
      <AnimatePresence>
        {showReviewModal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4"
            onClick={() => setShowReviewModal(false)}
          >
            <motion.div
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              exit={{ scale: 0.9, opacity: 0 }}
              className="bg-background rounded-lg max-w-3xl w-full max-h-[80vh] overflow-y-auto p-6"
              onClick={(e) => e.stopPropagation()}
            >
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-2xl font-bold">Review Answers</h2>
                <Button variant="ghost" onClick={() => setShowReviewModal(false)}>
                  Close
                </Button>
              </div>

              <div className="space-y-4">
                {results.answers.map((answer, index) => (
                  <Card
                    key={index}
                    className={`border-2 ${
                      answer.isCorrect ? "border-green-500" : "border-red-500"
                    }`}
                  >
                    <CardContent className="pt-6">
                      <div className="flex items-start gap-3">
                        {answer.isCorrect ? (
                          <CheckCircle2 className="h-6 w-6 text-green-500 flex-shrink-0 mt-1" />
                        ) : (
                          <XCircle className="h-6 w-6 text-red-500 flex-shrink-0 mt-1" />
                        )}
                        <div className="flex-1">
                          <p className="font-semibold mb-2">
                            Question {index + 1}: {answer.question}
                          </p>
                          <div className="space-y-2 text-sm">
                            <p className={answer.isCorrect ? "text-green-600" : "text-red-600"}>
                              Your answer: {answer.userAnswer}
                            </p>
                            {!answer.isCorrect && (
                              <p className="text-green-600">
                                Correct answer: {answer.correctAnswer}
                              </p>
                            )}
                            {answer.explanation && (
                              <p className="text-muted-foreground mt-2">
                                <strong>Explanation:</strong> {answer.explanation}
                              </p>
                            )}
                            {answer.timeSpent && (
                              <p className="text-xs text-muted-foreground">
                                Time spent: {answer.timeSpent.toFixed(1)}s
                              </p>
                            )}
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
