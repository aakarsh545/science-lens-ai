import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { User } from "@supabase/supabase-js";
import { useNavigate } from "react-router-dom";
import { Loader2, Check, X } from "lucide-react";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useToast } from "@/hooks/use-toast";

export default function TestPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [testing, setTesting] = useState(false);
  const [question, setQuestion] = useState("");
  const [expectedAnswer, setExpectedAnswer] = useState("");
  const [result, setResult] = useState<{ correct: boolean; aiAnswer: string } | null>(null);
  const navigate = useNavigate();
  const { toast } = useToast();

  useEffect(() => {
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const handleTest = async () => {
    if (!question.trim() || !expectedAnswer.trim()) {
      toast({
        title: "Missing fields",
        description: "Please fill in both question and expected answer",
        variant: "destructive",
      });
      return;
    }

    setTesting(true);
    setResult(null);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;

      if (!token) {
        toast({
          title: "Authentication Required",
          description: "Please sign in again",
          variant: "destructive",
        });
        return;
      }

      // Create a conversation for testing
      const { data: newConvo } = await supabase
        .from("conversations")
        .insert({
          user_id: user!.id,
          title: "Test Session",
        })
        .select()
        .single();

      if (!newConvo) {
        throw new Error("Failed to create test conversation");
      }

      const CHAT_URL = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/ask`;
      
      const resp = await fetch(CHAT_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${token}`,
        },
        body: JSON.stringify({
          message: question,
          conversationId: newConvo.id,
          panelContext: "test",
        }),
      });

      if (!resp.ok || !resp.body) {
        const errorText = await resp.text();
        throw new Error(`Failed to get response: ${resp.status} ${errorText}`);
      }

      const reader = resp.body.getReader();
      const decoder = new TextDecoder();
      let textBuffer = "";
      let streamDone = false;
      let aiAnswer = "";

      while (!streamDone) {
        const { done, value } = await reader.read();
        if (done) break;
        textBuffer += decoder.decode(value, { stream: true });

        let newlineIndex: number;
        while ((newlineIndex = textBuffer.indexOf("\n")) !== -1) {
          let line = textBuffer.slice(0, newlineIndex);
          textBuffer = textBuffer.slice(newlineIndex + 1);

          if (line.endsWith("\r")) line = line.slice(0, -1);
          if (line.startsWith(":") || line.trim() === "") continue;
          if (!line.startsWith("data: ")) continue;

          const jsonStr = line.slice(6).trim();
          if (jsonStr === "[DONE]") {
            streamDone = true;
            break;
          }

          try {
            const parsed = JSON.parse(jsonStr);
            const content = parsed.choices?.[0]?.delta?.content as string | undefined;
            if (content) {
              aiAnswer += content;
            }
          } catch {
            textBuffer = line + "\n" + textBuffer;
            break;
          }
        }
      }

      // Check if answer is correct
      const normalizedAI = aiAnswer.toLowerCase().trim();
      const normalizedExpected = expectedAnswer.toLowerCase().trim();
      const correct = normalizedAI.includes(normalizedExpected) || 
                     normalizedExpected.split(/\s+/).every(word => normalizedAI.includes(word));

      setResult({ correct, aiAnswer });

    } catch (error: any) {
      console.error("Test error:", error);
      toast({
        variant: "destructive",
        title: "Error",
        description: error.message || "Failed to run test",
      });
    } finally {
      setTesting(false);
    }
  };

  if (loading || !user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-4xl mx-auto space-y-6">
      <div>
        <h1 className="text-3xl font-bold mb-2">API Test Panel</h1>
        <p className="text-muted-foreground">
          Test the AI's responses against expected answers
        </p>
      </div>

      <Card className="p-6 space-y-4">
        <div className="space-y-2">
          <Label htmlFor="question">Question</Label>
          <Input
            id="question"
            placeholder="e.g., What is the speed of light?"
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
          />
        </div>

        <div className="space-y-2">
          <Label htmlFor="expected">Expected Answer (keywords)</Label>
          <Input
            id="expected"
            placeholder="e.g., 299792458 meters per second"
            value={expectedAnswer}
            onChange={(e) => setExpectedAnswer(e.target.value)}
          />
        </div>

        <Button 
          onClick={handleTest} 
          disabled={testing}
          className="w-full"
        >
          {testing ? (
            <>
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              Testing...
            </>
          ) : (
            "Run Test"
          )}
        </Button>
      </Card>

      {result && (
        <Card className={`p-6 ${result.correct ? "border-green-500 bg-green-50 dark:bg-green-950" : "border-red-500 bg-red-50 dark:bg-red-950"}`}>
          <div className="flex items-start gap-4">
            {result.correct ? (
              <Check className="h-8 w-8 text-green-600 dark:text-green-400 flex-shrink-0" />
            ) : (
              <X className="h-8 w-8 text-red-600 dark:text-red-400 flex-shrink-0" />
            )}
            <div className="flex-1 space-y-3">
              <h3 className="text-lg font-semibold">
                {result.correct ? "✅ Correct" : "❌ Incorrect"}
              </h3>
              <div className="space-y-2">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">Expected:</p>
                  <p className="text-sm">{expectedAnswer}</p>
                </div>
                <div>
                  <p className="text-sm font-medium text-muted-foreground">AI Response:</p>
                  <p className="text-sm whitespace-pre-wrap">{result.aiAnswer}</p>
                </div>
              </div>
            </div>
          </div>
        </Card>
      )}
    </div>
  );
}
