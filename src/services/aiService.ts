import { supabase } from "@/integrations/supabase/client";
import { API_ENDPOINTS } from "@/utils/constants";

interface AIRequestOptions {
  userId: string;
  message: string;
  conversationId: string;
  panelContext: string;
  onStream?: (chunk: string) => void;
  onComplete?: () => void;
  onError?: (error: string) => void;
}

export class AIService {
  static async checkCredits(userId: string): Promise<number> {
    const { data } = await supabase
      .from("user_stats")
      .select("credits")
      .eq("user_id", userId)
      .single();

    return data?.credits || 0;
  }

  static async sendMessage(options: AIRequestOptions): Promise<void> {
    const { userId, message, conversationId, panelContext, onStream, onComplete, onError } = options;

    try {
      const credits = await this.checkCredits(userId);
      if (credits < 1) {
        onError?.("Insufficient credits. Please purchase more to continue.");
        return;
      }

      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        onError?.("Authentication required");
        return;
      }

      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}${API_ENDPOINTS.CHAT}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({
            message,
            conversationId,
            panelContext,
          }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        onError?.(errorData.error || "Failed to get AI response");
        return;
      }

      // Credit deduction is handled server-side in the edge function
      // Client never mutates credits - only reads for UX

      const reader = response.body?.getReader();
      const decoder = new TextDecoder();

      if (!reader) {
        onError?.("Failed to read response");
        return;
      }

      let buffer = "";
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });

        let newlineIndex;
        while ((newlineIndex = buffer.indexOf("\n")) !== -1) {
          const line = buffer.slice(0, newlineIndex);
          buffer = buffer.slice(newlineIndex + 1);

          if (line.startsWith("data: ")) {
            const data = line.slice(6);
            if (data === "[DONE]") {
              onComplete?.();
              return;
            }

            try {
              const parsed = JSON.parse(data);
              const content = parsed.choices?.[0]?.delta?.content;
              if (content) {
                onStream?.(content);
              }
            } catch (e) {
              // Ignore JSON parse errors for incomplete chunks
            }
          }
        }
      }

      onComplete?.();
    } catch (error: unknown) {
      console.error("AI Service Error:", error);
      onError?.(error instanceof Error ? error.message : "An unexpected error occurred");
    }
  }
}
