import { useState, useEffect, useRef } from "react";
import { User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Send, Loader2, Bookmark, BookmarkCheck, Sparkles, Download } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion, AnimatePresence } from "framer-motion";
import { Card } from "@/components/ui/card";
import confetti from "canvas-confetti";
import { VoiceReader } from "./VoiceReader";
import { exportChatToPDF } from "@/utils/pdfExport";
import { ChatProgress } from "./ChatProgress";
import { AIService } from "@/services/aiService";
import CreditGuard from "./CreditGuard";

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
  panelContext?: "dashboard" | "learn" | "test";
}

export function EnhancedChatView({ user, selectedTopic, conversationId, onConversationChange, panelContext = "dashboard" }: EnhancedChatViewProps) {
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

  const streamChat = async (userMessage: string, currentConvoId: string) => {
    const CHAT_URL = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/ask`;
    console.log('Edge function URL ->', CHAT_URL);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      const token = session?.access_token;

      console.log('Token present:', !!token, 'Token length:', token?.length || 0);

      if (!token) {
        toast({
          title: "Authentication Required",
          description: "Please sign in again",
          variant: "destructive",
        });
        throw new Error("No authentication token");
      }

      const reqBody = {
        message: userMessage,
        conversationId: currentConvoId,
        panelContext,
      };
      console.log('Request body:', reqBody);

      const resp = await fetch(CHAT_URL, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${token}`,
        },
        body: JSON.stringify(reqBody),
      });

      console.log('Response status:', resp.status, resp.statusText);

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
        console.error('Edge function error:', resp.status, errorText);
        throw new Error(`Failed to start stream: ${resp.status} ${errorText}`);
      }

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
        console.log('Chunk received bytes:', value?.length || 0);
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
            console.warn('Partial/invalid JSON line, buffering more...', line);
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
    if (!trimmedInput || loading) return;

    // Client-side validation
    if (trimmedInput.length > 2000) {
      toast({
        title: "Message too long",
        description: "Please keep your message under 2000 characters.",
        variant: "destructive",
      });
      return;
    }

    // Initialize conversation if needed
    let currentConvoId = conversationId;
    if (!currentConvoId) {
      const { data: newConvo, error: convoError } = await supabase
        .from("conversations")
        .insert({
          user_id: user.id,
          title: selectedTopic?.name || "New Chat",
        })
        .select()
        .single();

      if (convoError || !newConvo) {
        toast({
          title: "Error",
          description: "Failed to create conversation",
          variant: "destructive",
        });
        return;
      }

      currentConvoId = newConvo.id;
      if (onConversationChange) {
        onConversationChange();
      }
    }

    setLoading(true);
    setInput("");

    const userMessage = {
      id: crypto.randomUUID(),
      role: "user" as const,
      content: trimmedInput,
      created_at: new Date().toISOString(),
    };

    setMessages((prev) => [...prev, userMessage]);

    try {
      await streamChat(trimmedInput, currentConvoId);
      
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
        title: "Error",
        description: error.message || "Failed to get response",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  const handleExportPDF = () => {
    if (messages.length === 0) {
      toast({
        title: "No messages to export",
        description: "Start a conversation first",
        variant: "destructive",
      });
      return;
    }

    exportChatToPDF(
      messages,
      selectedTopic?.name || "Science Chat",
      selectedTopic?.name
    );
    
    toast({
      title: "PDF Exported!",
      description: "Your chat has been saved as a PDF",
    });
  };

  const [showChatProgress, setShowChatProgress] = useState(false);

  return (
    <div className="flex flex-col h-full">
      {/* Export PDF Button */}
      {messages.length > 0 && !showChatProgress && (
        <div className="border-b p-2 flex justify-end bg-background">
          <Button onClick={handleExportPDF} variant="outline" size="sm">
            <Download className="h-4 w-4 mr-2" />
            Export PDF
          </Button>
        </div>
      )}

      {/* Messages Area */}
      <div className="flex-1 overflow-y-auto p-6 space-y-4" onScroll={(e) => {
        const target = e.target as HTMLDivElement;
        const scrolledToBottom = target.scrollHeight - target.scrollTop <= target.clientHeight + 100;
        if (scrolledToBottom && messages.length > 5) {
          setShowChatProgress(true);
        } else {
          setShowChatProgress(false);
        }
      }}>
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
                    <div className="flex items-center gap-2 mt-2">
                      <VoiceReader text={message.content} />
                      <span className="text-xs opacity-70">
                        {new Date(message.created_at).toLocaleTimeString()}
                      </span>
                    </div>
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

        {/* Chat Progress Section */}
        {showChatProgress && (
          <ChatProgress 
            user={user} 
            onViewChats={() => {
              // This will be handled by the sidebar
              toast({
                title: "View all chats",
                description: "Check the sidebar to see all your conversations",
              });
            }} 
          />
        )}
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