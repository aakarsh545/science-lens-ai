import { useState, useEffect } from "react";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { Trophy, Clock, Zap, Loader2 } from "lucide-react";
import { motion } from "framer-motion";
import confetti from "canvas-confetti";

interface Challenge {
  id: string;
  title: string;
  description: string;
  difficulty: string;
  xp_reward: number;
  payload: {
    question?: string;
    options?: string[];
    correctAnswer?: string;
  };
}

interface ChallengePanelProps {
  userId: string;
}

export function ChallengePanel({ userId }: ChallengePanelProps) {
  const [challenge, setChallenge] = useState<Challenge | null>(null);
  const [loading, setLoading] = useState(false);
  const [answer, setAnswer] = useState("");
  const [selectedOption, setSelectedOption] = useState<string | null>(null);
  const [timeLeft, setTimeLeft] = useState(180); // 3 minutes
  const [isActive, setIsActive] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (isActive && timeLeft > 0 && !submitted) {
      interval = setInterval(() => {
        setTimeLeft((time) => time - 1);
      }, 1000);
    } else if (timeLeft === 0) {
      handleTimeout();
    }
    return () => clearInterval(interval);
  }, [isActive, timeLeft, submitted]);

  const handleTimeout = () => {
    setIsActive(false);
    toast({
      title: "Time's up!",
      description: "Try another challenge to earn XP.",
      variant: "destructive",
    });
  };

  const loadChallenge = async () => {
    setLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenges/next`,
        {
          headers: {
            Authorization: `Bearer ${session.access_token}`,
          },
        }
      );

      if (!response.ok) throw new Error("Failed to load challenge");

      const data = await response.json();
      setChallenge(data);
      setTimeLeft(180);
      setIsActive(true);
      setSubmitted(false);
      setAnswer("");
      setSelectedOption(null);
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async () => {
    if (!challenge) return;
    if (!answer && !selectedOption) {
      toast({
        title: "No answer",
        description: "Please select or enter an answer",
        variant: "destructive",
      });
      return;
    }

    setLoading(true);
    setIsActive(false);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/challenges/${challenge.id}/attempt`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${session.access_token}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ 
            answer: selectedOption || answer 
          }),
        }
      );

      if (!response.ok) throw new Error("Failed to submit");

      const result = await response.json();
      setSubmitted(true);

      if (result.isCorrect) {
        confetti({
          particleCount: 100,
          spread: 70,
          origin: { y: 0.6 },
        });

        toast({
          title: "Correct! 🎉",
          description: `You earned ${result.xpEarned} XP!`,
        });
      } else {
        toast({
          title: "Not quite right",
          description: "Try another challenge!",
          variant: "destructive",
        });
      }
    } catch (error: any) {
      toast({
        title: "Error",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, "0")}`;
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case "easy":
        return "text-green-500";
      case "medium":
        return "text-yellow-500";
      case "hard":
        return "text-red-500";
      default:
        return "text-primary";
    }
  };

  if (!challenge && !loading) {
    return (
      <Card className="border-primary/20">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Trophy className="h-5 w-5 text-primary" />
            Daily Challenge
          </CardTitle>
          <CardDescription>Test your knowledge and earn XP</CardDescription>
        </CardHeader>
        <CardContent className="flex flex-col items-center gap-4 py-8">
          <Trophy className="h-16 w-16 text-muted-foreground/20" />
          <p className="text-sm text-muted-foreground">
            Ready for a challenge?
          </p>
        </CardContent>
        <CardFooter>
          <Button onClick={loadChallenge} className="w-full" disabled={loading}>
            {loading ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              "Start Challenge"
            )}
          </Button>
        </CardFooter>
      </Card>
    );
  }

  return (
    <Card className="border-primary/20">
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          <span className="flex items-center gap-2">
            <Trophy className="h-5 w-5 text-primary" />
            {challenge?.title || "Loading..."}
          </span>
          <motion.div
            animate={timeLeft < 30 ? { scale: [1, 1.1, 1] } : {}}
            transition={{ repeat: timeLeft < 30 ? Infinity : 0, duration: 1 }}
            className="flex items-center gap-2"
          >
            <Clock className={`h-4 w-4 ${timeLeft < 30 ? "text-red-500" : "text-muted-foreground"}`} />
            <span className={`text-sm ${timeLeft < 30 ? "text-red-500 font-bold" : "text-muted-foreground"}`}>
              {formatTime(timeLeft)}
            </span>
          </motion.div>
        </CardTitle>
        {challenge && (
          <CardDescription className="flex items-center justify-between">
            <span>{challenge.description}</span>
            <span className={`flex items-center gap-1 text-xs font-medium ${getDifficultyColor(challenge.difficulty)}`}>
              <Zap className="h-3 w-3" />
              {challenge.xp_reward} XP
            </span>
          </CardDescription>
        )}
      </CardHeader>
      <CardContent className="space-y-4">
        {challenge?.payload?.question && (
          <div className="space-y-3">
            <p className="font-medium">{challenge.payload.question}</p>
            
            {challenge.payload.options ? (
              <div className="space-y-2">
                {challenge.payload.options.map((option, index) => (
                  <Button
                    key={index}
                    variant={selectedOption === option ? "default" : "outline"}
                    className="w-full justify-start"
                    onClick={() => !submitted && setSelectedOption(option)}
                    disabled={submitted || loading}
                  >
                    {option}
                  </Button>
                ))}
              </div>
            ) : (
              <Input
                placeholder="Enter your answer..."
                value={answer}
                onChange={(e) => setAnswer(e.target.value)}
                disabled={submitted || loading}
                onKeyDown={(e) => e.key === "Enter" && handleSubmit()}
              />
            )}
          </div>
        )}
      </CardContent>
      <CardFooter className="flex gap-2">
        {!submitted ? (
          <>
            <Button
              onClick={handleSubmit}
              disabled={loading || (!answer && !selectedOption)}
              className="flex-1"
            >
              {loading ? (
                <Loader2 className="h-4 w-4 animate-spin" />
              ) : (
                "Submit"
              )}
            </Button>
            <Button
              variant="outline"
              onClick={loadChallenge}
              disabled={loading}
            >
              Skip
            </Button>
          </>
        ) : (
          <Button onClick={loadChallenge} className="w-full">
            Next Challenge
          </Button>
        )}
      </CardFooter>
    </Card>
  );
}
