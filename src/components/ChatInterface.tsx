import { useState, useRef, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Card } from "@/components/ui/card";
import { User } from "@supabase/supabase-js";
import { Send, Sparkles, Loader2, Bookmark, BookmarkCheck } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import confetti from "canvas-confetti";
import { TIMEOUT_VALUES, API_ENDPOINTS } from "@/utils/constants";

interface Topic {
  id: string;
  name: string;
  icon: string;
  description: string;
}

interface Message {
  role: "user" | "assistant";
  content: string;
  questionId?: string;
}

interface ChatInterfaceProps {
  user: User;
  topic?: Topic;
}

const ChatInterface = ({ user, topic }: ChatInterfaceProps) => {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [bookmarkedQuestions, setBookmarkedQuestions] = useState<Set<string>>(new Set());
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const isSendingRef = useRef(false); // Ref to prevent concurrent sends
  const { toast } = useToast();

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(scrollToBottom, [messages]);

  const triggerConfetti = () => {
    confetti({
      particleCount: 100,
      spread: 70,
      origin: { y: 0.6 },
      colors: ["#3b82f6", "#8b5cf6", "#ec4899"],
    });
  };

  const checkForAchievements = async (questionCount: number) => {
    const achievements = [
      { type: "first_question", title: "First Steps", description: "Asked your first question", threshold: 1 },
      { type: "curious_mind", title: "Curious Mind", description: "Asked 10 questions", threshold: 10 },
      { type: "knowledge_seeker", title: "Knowledge Seeker", description: "Asked 50 questions", threshold: 50 },
    ];

    for (const achievement of achievements) {
      if (questionCount === achievement.threshold) {
        const { error } = await supabase.from("achievements").insert({
          user_id: user.id,
          achievement_type: achievement.type,
          title: achievement.title,
          description: achievement.description,
        });

        if (!error) {
          triggerConfetti();
          toast({
            title: "🏆 Achievement Unlocked!",
            description: `${achievement.title}: ${achievement.description}`,
          });
        }
      }
    }
  };

  const toggleBookmark = async (questionId: string) => {
    if (bookmarkedQuestions.has(questionId)) {
      await supabase.from("bookmarks").delete().eq("question_id", questionId).eq("user_id", user.id);
      setBookmarkedQuestions((prev) => {
        const next = new Set(prev);
        next.delete(questionId);
        return next;
      });
      toast({ title: "Bookmark removed" });
    } else {
      await supabase.from("bookmarks").insert({ user_id: user.id, question_id: questionId });
      setBookmarkedQuestions((prev) => new Set(prev).add(questionId));
      toast({ title: "Bookmarked!" });
    }
  };

  const streamChat = async (userMessage: string) => {
    const CHAT_URL = `${import.meta.env.VITE_SUPABASE_URL}${API_ENDPOINTS.CHAT}`;

    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;

      if (!token) {
        toast({
          title: "Authentication Required",
          description: "Please sign in again",
          variant: "destructive",
        });
        throw new Error("No authentication token");
      }

      const { data: newConvo, error: convoError } = await supabase
        .from("conversations")
        .insert({ user_id: user.id, title: topic?.name || "New Chat" })
        .select()
        .single();

      if (convoError || !newConvo) {
        console.error('Failed to create conversation:', convoError);
        throw new Error("Failed to create conversation");
      }

      const body = {
        message: userMessage,
        conversationId: newConvo.id,
      };

      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), TIMEOUT_VALUES.INITIAL_REQUEST);

      const resp = await fetch(CHAT_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(body),
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (resp.status === 401) {
        toast({
          title: "Session Expired",
          description: "Please sign in again",
          variant: "destructive",
        });
        throw new Error("Unauthorized - please sign in again");
      }

      if (!resp.ok || !resp.body) {
        const errorText = await resp.text();
        throw new Error(`Failed to start stream: ${resp.status} — ${errorText}`);
      }

      const reader = resp.body.getReader();
      const decoder = new TextDecoder();
      let textBuffer = "";
      let streamDone = false;
      let assistantSoFar = "";
      let lastChunkTime = Date.now();
      let noDataTimeoutId: NodeJS.Timeout;
      let firstChunkReceived = false;

      // Add both user and assistant placeholder when stream successfully starts
      // Only after we confirm the connection is working
      const addMessagesWhenStreamStarts = () => {
        if (!firstChunkReceived) {
          firstChunkReceived = true;
          setMessages((prev) => [
            ...prev,
            { role: "user", content: userMessage },
            { role: "assistant", content: "" }
          ]);
        }
      };

      const resetNoDataTimeout = () => {
        if (noDataTimeoutId) clearTimeout(noDataTimeoutId);
        noDataTimeoutId = setTimeout(() => {
          if (!streamDone) {
            reader.cancel();
            toast({
              title: "Response Timeout",
              description: "The AI response took too long. Please try again.",
              variant: "destructive",
            });
            // Remove both user and assistant messages if timeout
            setMessages((prev) => prev.slice(0, -2));
            streamDone = true;
          }
        }, TIMEOUT_VALUES.NO_DATA_RECEIVED);
      };

      resetNoDataTimeout();

      while (!streamDone) {
        const { done, value } = await reader.read();
        if (done) break;

        lastChunkTime = Date.now();
        resetNoDataTimeout();

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
              // Add user and assistant messages on first chunk
              addMessagesWhenStreamStarts();

              assistantSoFar += content;
              setMessages((prev) => {
                const newMessages = [...prev];
                newMessages[newMessages.length - 1].content = assistantSoFar;
                return newMessages;
              });
            }
          } catch {
            textBuffer = line + "\n" + textBuffer;
            break;
          }
        }
      }

      if (noDataTimeoutId) clearTimeout(noDataTimeoutId);

      const { data: questionData } = await supabase
        .from("questions")
        .insert({
          user_id: user.id,
          question_text: userMessage,
          ai_response: assistantSoFar,
          topic: topic?.name || "general_science",
        })
        .select()
        .single();

      if (questionData) {
        setMessages((prev) => {
          const newMessages = [...prev];
          newMessages[newMessages.length - 2].questionId = questionData.id;
          return newMessages;
        });
      }

      const { data: profile } = await supabase
        .from("profiles")
        .select("total_questions")
        .eq("user_id", user.id)
        .single();

      if (profile) {
        await checkForAchievements(profile.total_questions);
      }
    } catch (error: unknown) {
      console.error("Chat error:", error);

      if (error instanceof Error && error.name === 'AbortError') {
        toast({
          variant: "destructive",
          title: "Request Timeout",
          description: "The request took too long to respond. Please try again.",
        });
      } else {
        toast({
          variant: "destructive",
          title: "Error",
          description: error instanceof Error ? error.message : "Failed to get response",
        });
      }

      // Remove both user and assistant messages if error occurred
      // If firstChunkReceived is true, both messages were added, so remove both
      // If firstChunkReceived is false, no messages were added, so nothing to remove
      setMessages((prev) => {
        // Check if we added the messages by seeing if we have at least 2 new messages
        // This is a simple check - in production we'd track this more carefully
        const hasNewMessages = prev.length >= 2 &&
          prev[prev.length - 2].role === "user" &&
          prev[prev.length - 2].content === userMessage &&
          prev[prev.length - 1].role === "assistant";
        return hasNewMessages ? prev.slice(0, -2) : prev;
      });
    }
  };

  const handleSend = async () => {
    if (!input.trim() || isLoading) return;

    // Prevent concurrent sends using ref (immediate check, not affected by React batching)
    if (isSendingRef.current) {
      console.warn('Already sending a message, please wait...');
      return;
    }

    const userMessage = input.trim();
    setInput("");
    setIsLoading(true);
    isSendingRef.current = true; // Set flag immediately

    try {
      // Don't add messages optimistically - wait for backend response
      // This prevents showing messages that fail to send
      await streamChat(userMessage);
    } catch (error) {
      // If streamChat fails entirely, user message was never added
      // Just show error, no rollback needed
      console.error('Failed to send message:', error);
    } finally {
      setIsLoading(false);
      isSendingRef.current = false; // Clear flag after completion
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  return (
    <div className="min-h-screen bg-background flex flex-col">
      <div className="flex-1 overflow-y-auto p-4 space-y-4" ref={messagesEndRef}>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="card-cosmic p-6 text-center"
        >
          <h2 className="text-2xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
            {topic ? `${topic.icon} ${topic.name}` : "Science Lens AI"}
          </h2>
          <p className="text-muted-foreground">
            {topic ? topic.description : "Ask me anything about science! Let's explore the wonders of the universe together."}
          </p>
        </motion.div>

        <AnimatePresence>
          {messages.map((message, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.05 }}
              className={message.role === "user" ? "flex justify-end" : "flex justify-start"}
            >
              <div className={`max-w-[80%] ${message.role === "user" ? "ml-auto" : "mr-auto"}`}>
                <Card
                  className={`p-4 ${
                    message.role === "user"
                      ? "bg-primary text-primary-foreground"
                      : "card-cosmic"
                  }`}
                >
                  <p className="whitespace-pre-wrap">{message.content}</p>
                </Card>
                {message.role === "user" && message.questionId && (
                  <div className="mt-2 flex justify-end">
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => toggleBookmark(message.questionId!)}
                    >
                      {bookmarkedQuestions.has(message.questionId) ? (
                        <BookmarkCheck className="h-4 w-4" />
                      ) : (
                        <Bookmark className="h-4 w-4" />
                      )}
                    </Button>
                  </div>
                )}
              </div>
            </motion.div>
          ))}
        </AnimatePresence>
      </div>

      <div className="border-t p-4 bg-background">
        <div className="max-w-4xl mx-auto flex gap-2">
          <Textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={handleKeyPress}
            placeholder="Type your science question..."
            className="resize-none"
            rows={2}
            disabled={isLoading}
          />
          <Button
            onClick={handleSend}
            disabled={isLoading || !input.trim()}
            size="icon"
            className="h-full aspect-square"
          >
            {isLoading ? <Loader2 className="h-5 w-5 animate-spin" /> : <Send className="h-5 w-5" />}
          </Button>
        </div>
      </div>
    </div>
  );
};

export default ChatInterface;