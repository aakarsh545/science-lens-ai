import { useState, useEffect, useRef } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Send, Loader2, Bookmark, BookmarkCheck, Sparkles } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion, AnimatePresence } from "framer-motion";
import { Card } from "@/components/ui/card";
import confetti from "canvas-confetti";

interface Message {
  id: string;
  role: "user" | "assistant";
  content: string;
  created_at: string;
  questionId?: string;
}

interface EnhancedChatViewProps {
  user: User;
  selectedTopic?: {
    id: string;
    name: string;
    icon: string;
    description: string;
  } | null;
  conversationId: string | null;
  onConversationChange?: () => void;
}

export function EnhancedChatView({ user, selectedTopic, conversationId, onConversationChange }: EnhancedChatViewProps) {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [loading, setLoading] = useState(false);
  const [bookmarkedQuestions, setBookmarkedQuestions] = useState<Set<string>>(new Set());
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const { toast } = useToast();

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  // Load messages when conversation changes
  useEffect(() => {
    if (!conversationId) {
      setMessages([]);
      return;
    }

    const loadMessages = async () => {
      const { data: msgs } = await supabase
        .from("messages")
        .select("*")
        .eq("conversation_id", conversationId)
        .order("created_at", { ascending: true });

      if (msgs) {
        setMessages(msgs as Message[]);
      }
    };

    loadMessages();
  }, [conversationId]);

  // Subscribe to real-time messages
  useEffect(() => {
    if (!conversationId) return;

    const channel = supabase
      .channel("messages")
      .on(
        "postgres_changes",
        {
          event: "INSERT",
          schema: "public",
          table: "messages",
          filter: `conversation_id=eq.${conversationId}`,
        },
        (payload) => {
          const newMessage = payload.new as Message;
          setMessages((prev) => {
            if (prev.some((m) => m.id === newMessage.id)) return prev;
            return [...prev, newMessage];
          });
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [conversationId]);

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
      { type: "first_question", title: "First Steps", description: "Asked your first question", threshold: 1, icon: "🎯", category: "milestone", points: 10, credits: 1 },
      { type: "curious_mind", title: "Curious Mind", description: "Asked 10 questions", threshold: 10, icon: "🤔", category: "milestone", points: 50, credits: 5 },
      { type: "knowledge_seeker", title: "Knowledge Seeker", description: "Asked 50 questions", threshold: 50, icon: "🎓", category: "milestone", points: 100, credits: 10 },
    ];

    for (const achievement of achievements) {
      if (questionCount === achievement.threshold) {
        const { error } = await supabase.from("achievements").insert({
          user_id: user.id,
          achievement_type: achievement.type,
          title: achievement.title,
          description: achievement.description,
          icon: achievement.icon,
          category: achievement.category,
          points: achievement.points,
        });

        if (!error) {
          // Award credits - update profile directly
          const { data: profile } = await supabase
            .from("profiles")
            .select("credits")
            .eq("user_id", user.id)
            .single();

          if (profile) {
            await supabase
              .from("profiles")
              .update({ credits: (profile.credits || 0) + achievement.credits })
              .eq("user_id", user.id);
          }

          triggerConfetti();
          toast({
            title: "🏆 Achievement Unlocked!",
            description: `${achievement.title}: ${achievement.description} (+${achievement.credits} credits)`,
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
    const CHAT_URL = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/science-chat`;

    try {
      const session = await supabase.auth.getSession();
      const token = session.data.session?.access_token;

      if (!token) {
        throw new Error("No authentication token");
      }

      const resp = await fetch(CHAT_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${token}`,
        },
        body: JSON.stringify({
          question: userMessage,
          topic: selectedTopic?.name || "General Science",
        }),
      });

      if (!resp.ok || !resp.body) throw new Error("Failed to start stream");

      const reader = resp.body.getReader();
      const decoder = new TextDecoder();
      let textBuffer = "";
      let streamDone = false;
      let assistantSoFar = "";

      // Add empty assistant message
      const tempId = crypto.randomUUID();
      setMessages((prev) => [...prev, { 
        id: tempId, 
        role: "assistant", 
        content: "", 
        created_at: new Date().toISOString() 
      }]);

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

      // Save to questions table
      const { data: questionData } = await supabase
        .from("questions")
        .insert({
          user_id: user.id,
          question_text: userMessage,
          ai_response: assistantSoFar,
          topic: selectedTopic?.name || "general_science",
        })
        .select()
        .single();

      if (questionData) {
        setMessages((prev) => {
          const newMessages = [...prev];
          // Find the user message (second to last) and add questionId
          if (newMessages.length >= 2) {
            newMessages[newMessages.length - 2].questionId = questionData.id;
          }
          return newMessages;
        });
      }

      // Check achievements
      const { data: profile } = await supabase
        .from("profiles")
        .select("total_questions")
        .eq("user_id", user.id)
        .single();

      if (profile) {
        await checkForAchievements(profile.total_questions);
      }
    } catch (error: any) {
      console.error("Chat error:", error);
      toast({
        variant: "destructive",
        title: "Error",
        description: error.message || "Failed to get response",
      });
      setMessages((prev) => prev.slice(0, -1));
    }
  };

  const handleSend = async () => {
    const trimmedInput = input.trim();
    
    if (!trimmedInput || !conversationId || loading) return;
    
    if (trimmedInput.length > 2000) {
      toast({
        title: "Message too long",
        description: "Please keep your message under 2000 characters.",
        variant: "destructive",
      });
      return;
    }

    const userMessage: Message = {
      id: crypto.randomUUID(),
      role: "user",
      content: trimmedInput,
      created_at: new Date().toISOString(),
    };

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setLoading(true);

    await streamChat(trimmedInput);
    setLoading(false);
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  return (
    <div className="flex flex-col h-full">
      {/* Messages Area */}
      <div className="flex-1 overflow-y-auto p-6 space-y-4">
        {messages.length === 0 && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="text-center py-12"
          >
            <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 mb-4">
              <Sparkles className="w-8 h-8 text-primary" />
            </div>
            <h3 className="text-xl font-semibold mb-2">
              {selectedTopic ? `${selectedTopic.icon} ${selectedTopic.name}` : "Start a conversation! 💬"}
            </h3>
            <p className="text-muted-foreground max-w-md mx-auto">
              {selectedTopic ? selectedTopic.description : "Ask me anything about science and I'll help you learn."}
            </p>
          </motion.div>
        )}

        <AnimatePresence>
          {messages.map((message, index) => (
            <motion.div
              key={message.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3 }}
              className={`flex ${message.role === "user" ? "justify-end" : "justify-start"}`}
            >
              <div className={`max-w-[80%] ${message.role === "user" ? "ml-auto" : "mr-auto"}`}>
                <Card
                  className={`p-4 ${
                    message.role === "user"
                      ? "bg-primary text-primary-foreground"
                      : "bg-muted"
                  }`}
                >
                  <p className="whitespace-pre-wrap">{message.content}</p>
                  {message.role === "assistant" && message.content && (
                    <span className="text-xs opacity-70 mt-2 block">
                      {new Date(message.created_at).toLocaleTimeString()}
                    </span>
                  )}
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

        {loading && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="flex justify-start"
          >
            <div className="bg-muted rounded-lg p-4 flex items-center gap-2">
              <Loader2 className="h-4 w-4 animate-spin" />
              <span className="text-sm">Thinking...</span>
            </div>
          </motion.div>
        )}

        <div ref={messagesEndRef} />
      </div>

      {/* Input Area */}
      <div className="border-t bg-background p-4">
        <div className="flex gap-2 max-w-4xl mx-auto">
          <Textarea
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={handleKeyPress}
            placeholder={selectedTopic ? `Ask about ${selectedTopic.name}...` : "Ask a science question..."}
            className="resize-none"
            rows={2}
            disabled={loading}
          />
          <Button onClick={handleSend} disabled={loading || !input.trim()} size="icon">
            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <Send className="h-4 w-4" />}
          </Button>
        </div>
      </div>
    </div>
  );
}