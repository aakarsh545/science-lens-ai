import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { Loader2, CheckCircle, XCircle } from "lucide-react";
import { motion } from "framer-motion";

const Settings = () => {
  const [isTestingConnection, setIsTestingConnection] = useState(false);
  const [connectionStatus, setConnectionStatus] = useState<"idle" | "success" | "error">("idle");
  const { toast } = useToast();

  const testOpenAIConnection = async () => {
    setIsTestingConnection(true);
    setConnectionStatus("idle");

    try {
      // Add timeout for connection test
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 15000); // 15 second timeout

      const { data, error } = await supabase.functions.invoke("ask", {
        body: { message: "test", conversationId: "test" },
      });

      clearTimeout(timeoutId);

      if (error) throw error;

      if (data?.success) {
        setConnectionStatus("success");
        toast({
          title: "✅ OpenAI Connected Successfully",
          description: "Your OpenAI API key is working correctly.",
        });
      } else {
        throw new Error(data?.error || "Connection test failed");
      }
    } catch (error: any) {
      console.error("Connection test error:", error);

      if (error.name === 'AbortError') {
        setConnectionStatus("error");
        toast({
          variant: "destructive",
          title: "Connection Timeout",
          description: "The connection test took too long. Please try again.",
        });
      } else {
        setConnectionStatus("error");
        toast({
          variant: "destructive",
          title: "Connection Failed",
          description: error.message || "Failed to connect to OpenAI. Please check your API key.",
        });
      }
    } finally {
      setIsTestingConnection(false);
    }
  };

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-2xl mx-auto space-y-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <h1 className="text-3xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
            Settings
          </h1>
          <p className="text-muted-foreground">Configure your OpenAI integration</p>
        </motion.div>

        <Card className="card-cosmic p-6 space-y-6">
          <div>
            <h2 className="text-xl font-semibold mb-2">OpenAI Configuration</h2>
            <p className="text-sm text-muted-foreground mb-4">
              This app uses OpenAI GPT-4 for AI-powered science tutoring. Your API key is securely stored and never exposed.
            </p>
          </div>

          <div className="space-y-4">
            <div className="flex items-center gap-4">
              <Button
                onClick={testOpenAIConnection}
                disabled={isTestingConnection}
                className="w-full sm:w-auto"
              >
                {isTestingConnection ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Testing Connection...
                  </>
                ) : (
                  "Test OpenAI Connection"
                )}
              </Button>

              {connectionStatus === "success" && (
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  className="flex items-center gap-2 text-green-500"
                >
                  <CheckCircle className="h-5 w-5" />
                  <span className="text-sm font-medium">Connected</span>
                </motion.div>
              )}

              {connectionStatus === "error" && (
                <motion.div
                  initial={{ scale: 0 }}
                  animate={{ scale: 1 }}
                  className="flex items-center gap-2 text-destructive"
                >
                  <XCircle className="h-5 w-5" />
                  <span className="text-sm font-medium">Failed</span>
                </motion.div>
              )}
            </div>

            <div className="rounded-lg bg-muted p-4 space-y-2">
              <p className="text-sm font-medium">API Key Status</p>
              <p className="text-xs text-muted-foreground">
                Your OpenAI API key is stored securely in the backend. If you need to update it, please contact your administrator or check your Supabase secrets configuration.
              </p>
            </div>

            <div className="rounded-lg bg-blue-500/10 border border-blue-500/20 p-4 space-y-2">
              <p className="text-sm font-medium text-blue-500">Current AI Model</p>
              <p className="text-xs text-muted-foreground">
                GPT-4 Turbo Preview - Advanced reasoning and comprehensive science knowledge
              </p>
            </div>
          </div>
        </Card>

        <Card className="card-cosmic p-6 space-y-4">
          <h2 className="text-xl font-semibold">How It Works</h2>
          <ul className="space-y-2 text-sm text-muted-foreground">
            <li className="flex items-start gap-2">
              <span className="text-primary">🔐</span>
              <span>Your OpenAI API key is stored securely in Supabase secrets</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-primary">🚀</span>
              <span>All AI requests are processed through secure edge functions</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-primary">🎓</span>
              <span>GPT-4 provides accurate, engaging science explanations</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-primary">⚡</span>
              <span>Streaming responses for real-time interaction</span>
            </li>
          </ul>
        </Card>
      </div>
    </div>
  );
};

export default Settings;
