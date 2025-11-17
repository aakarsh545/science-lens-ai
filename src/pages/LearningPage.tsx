import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate, useLocation } from "react-router-dom";
import { Loader2, BookOpen, Check, X, Sparkles, Trophy } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";

interface Quiz {
  question: string;
  options: string[];
  correctAnswer: number;
  explanation: string;
}

const sampleQuizzes: Record<string, Quiz[]> = {
  default: [
    {
      question: "What is the speed of light in vacuum?",
      options: ["300,000 km/s", "150,000 km/s", "450,000 km/s", "600,000 km/s"],
      correctAnswer: 0,
      explanation: "The speed of light in vacuum is approximately 300,000 kilometers per second (299,792,458 m/s to be exact)."
    },
    {
      question: "Which element has the chemical symbol 'Au'?",
      options: ["Silver", "Gold", "Aluminum", "Argon"],
      correctAnswer: 1,
      explanation: "Au is the chemical symbol for Gold, derived from the Latin word 'aurum'."
    },
    {
      question: "What is the powerhouse of the cell?",
      options: ["Nucleus", "Ribosome", "Mitochondria", "Golgi Apparatus"],
      correctAnswer: 2,
      explanation: "Mitochondria are known as the powerhouse of the cell because they generate most of the cell's ATP energy."
    }
  ]
};

export default function LearningPage() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<any>(null);
  const [currentQuiz, setCurrentQuiz] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  const [xpEarned, setXpEarned] = useState(0);
  const navigate = useNavigate();
  const location = useLocation();
  const { toast } = useToast();
  
  const topic = location.state?.topic;
  const quizzes = sampleQuizzes.default;

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
      }
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const handleSubmitAnswer = async () => {
    if (selectedAnswer === null) return;
    
    const isCorrect = selectedAnswer === quizzes[currentQuiz].correctAnswer;
    setShowResult(true);
    
    if (isCorrect) {
      const xp = 10;
      setCorrectCount(prev => prev + 1);
      setXpEarned(prev => prev + xp);
      
      // Update user XP in database
      const { data: currentProfile } = await supabase
        .from("profiles")
        .select("xp_points")
        .eq("user_id", user.id)
        .single();
      
      if (currentProfile) {
        await supabase
          .from("profiles")
          .update({ xp_points: currentProfile.xp_points + xp })
          .eq("user_id", user.id);
      }
      
      toast({
        title: "Correct! 🎉",
        description: `You earned ${xp} XP!`,
      });
    }
  };

  const handleNextQuestion = () => {
    if (currentQuiz < quizzes.length - 1) {
      setCurrentQuiz(prev => prev + 1);
      setSelectedAnswer(null);
      setShowResult(false);
    } else {
      toast({
        title: "Quiz Complete!",
        description: `You got ${correctCount + (selectedAnswer === quizzes[currentQuiz].correctAnswer ? 1 : 0)}/${quizzes.length} correct and earned ${xpEarned} XP!`,
      });
      navigate("/learn-science");
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  const currentQuizData = quizzes[currentQuiz];
  const progress = ((currentQuiz + 1) / quizzes.length) * 100;

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <div className="mb-8">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-3xl font-bold">
            {topic?.name || "Science Quiz"}
          </h1>
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2 text-sm">
              <Trophy className="w-4 h-4 text-achievement" />
              <span>{correctCount} correct</span>
            </div>
            <div className="flex items-center gap-2 text-sm">
              <Sparkles className="w-4 h-4 text-primary" />
              <span>{xpEarned} XP</span>
            </div>
          </div>
        </div>
        
        <div className="space-y-2">
          <div className="flex justify-between text-sm text-muted-foreground">
            <span>Question {currentQuiz + 1} of {quizzes.length}</span>
            <span>{Math.round(progress)}% Complete</span>
          </div>
          <Progress value={progress} className="h-2" />
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-xl">{currentQuizData.question}</CardTitle>
        </CardHeader>
        
        <CardContent className="space-y-6">
          <RadioGroup 
            value={selectedAnswer?.toString()} 
            onValueChange={(value) => !showResult && setSelectedAnswer(parseInt(value))}
          >
            {currentQuizData.options.map((option, index) => {
              const isSelected = selectedAnswer === index;
              const isCorrect = index === currentQuizData.correctAnswer;
              const showCorrect = showResult && isCorrect;
              const showIncorrect = showResult && isSelected && !isCorrect;
              
              return (
                <div
                  key={index}
                  className={`flex items-center space-x-3 p-4 rounded-lg border-2 transition-all ${
                    showCorrect ? 'border-success bg-success/10' :
                    showIncorrect ? 'border-destructive bg-destructive/10' :
                    isSelected ? 'border-primary bg-primary/10' :
                    'border-border hover:border-primary/50'
                  }`}
                >
                  <RadioGroupItem value={index.toString()} id={`option-${index}`} disabled={showResult} />
                  <Label htmlFor={`option-${index}`} className="flex-1 cursor-pointer">
                    {option}
                  </Label>
                  {showCorrect && <Check className="w-5 h-5 text-success" />}
                  {showIncorrect && <X className="w-5 h-5 text-destructive" />}
                </div>
              );
            })}
          </RadioGroup>

          {showResult && (
            <Card className="bg-muted/50">
              <CardHeader>
                <CardTitle className="text-lg">Explanation</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm">{currentQuizData.explanation}</p>
              </CardContent>
            </Card>
          )}

          <div className="flex gap-3">
            {!showResult ? (
              <Button 
                onClick={handleSubmitAnswer}
                disabled={selectedAnswer === null}
                className="flex-1"
              >
                Submit Answer
              </Button>
            ) : (
              <Button 
                onClick={handleNextQuestion}
                className="flex-1"
              >
                {currentQuiz < quizzes.length - 1 ? "Next Question" : "Finish Quiz"}
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
