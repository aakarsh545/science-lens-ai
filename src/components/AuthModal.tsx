import { useState } from "react";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { HelixLoader } from "@/components/ui/helix-loader";
import { getUserFriendlyMessage } from "@/utils/errorHandling";

interface AuthModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

export default function AuthModal({ open, onOpenChange }: AuthModalProps) {
  const [isLoading, setIsLoading] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [username, setUsername] = useState("");
  const [usernameError, setUsernameError] = useState("");
  const [checkingUsername, setCheckingUsername] = useState(false);
  const { toast } = useToast();

  const checkUsernameAvailability = async (name: string): Promise<boolean> => {
    if (!name || name.length < 3) return false;

    const { data, error } = await supabase
      .from('profiles')
      .select('display_name')
      .eq('display_name', name)
      .maybeSingle();

    return !!error || !data;
  };

  const handleUsernameChange = async (value: string) => {
    setUsername(value);

    // Validate username format
    if (value.length > 0 && value.length < 3) {
      setUsernameError("Username must be at least 3 characters");
      return;
    }

    if (!/^[a-zA-Z0-9_]+$/.test(value)) {
      setUsernameError("Only letters, numbers, and underscores allowed");
      return;
    }

    if (value.length >= 3) {
      setCheckingUsername(true);
      const available = await checkUsernameAvailability(value);
      setUsernameError(available ? "" : "Username already taken");
      setCheckingUsername(false);
    } else {
      setUsernameError("");
    }
  };

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault();

    // Validate username
    if (!username || username.length < 3) {
      toast({
        variant: "destructive",
        title: "Username required",
        description: "Please choose a username (min 3 characters)",
      });
      return;
    }

    if (usernameError) {
      toast({
        variant: "destructive",
        title: "Invalid username",
        description: usernameError,
      });
      return;
    }

    setIsLoading(true);

    try {
      // Final username check
      const available = await checkUsernameAvailability(username);
      if (!available) {
        toast({
          variant: "destructive",
          title: "Username taken",
          description: "Please choose a different username",
        });
        setIsLoading(false);
        return;
      }

      const { error, data } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            username: username.trim(),
          },
          emailRedirectTo: `${window.location.origin}/dashboard`,
        }
      });

      if (error) throw error;

      if (data.user && data.session) {
        const { error: profileError } = await supabase
          .from("profiles")
          .insert({
            user_id: data.user.id,
            username: username,
            display_name: username,
          });

        if (profileError) {
          // If username is duplicate, try with a unique suffix
          if (profileError.message.includes('duplicate') || profileError.message.includes('unique')) {
            const { error: retryError } = await supabase
              .from("profiles")
              .insert({
                user_id: data.user.id,
                username: `${username}_${data.user.id.slice(0, 4)}`,
                display_name: username,
              });

            if (retryError) throw retryError;
          } else {
            throw profileError;
          }
        }
      }

      toast({
        title: "Welcome to Science Lens! 🚀",
        description: "Your account has been created successfully.",
      });
      onOpenChange(false);
      // Don't force navigation - let parent component decide
    } catch (error: unknown) {
      console.error('Signup error:', error);

      let errorMessage = "An error occurred during signup";
      let errorTitle = "Signup failed";

      // Handle specific error cases
      if (error instanceof Error) {
        const message = error.message.toLowerCase();

        // Email already registered
        if (message.includes('already been registered') || message.includes('already registered')) {
          errorTitle = "Email already in use";
          errorMessage = "An account with this email already exists. Try signing in instead.";
        }
        // Weak password
        else if (message.includes('password') && (message.includes('weak') || message.includes('strength') || message.includes('valid'))) {
          errorTitle = "Password too weak";
          errorMessage = "Password must be at least 8 characters with letters and numbers.";
        }
        // Validation error (422)
        else if (message.includes('validation') || message.includes('422') || message.includes('invalid')) {
          errorTitle = "Invalid information";
          errorMessage = "Please check your email, username, and password format.";
        }
        // Rate limiting
        else if (message.includes('rate limit') || message.includes('too many requests')) {
          errorTitle = "Too many attempts";
          errorMessage = "Please wait a moment before trying again.";
        }
        // Network errors
        else if (message.includes('network') || message.includes('fetch') || message.includes('connection')) {
          errorTitle = "Connection error";
          errorMessage = "Please check your internet connection and try again.";
        }
        // Use the actual error message as fallback
        else {
          errorMessage = error.message;
        }
      }

      toast({
        variant: "destructive",
        title: errorTitle,
        description: errorMessage,
      });
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignIn = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    
    try {
      const { error, data } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) throw error;

      toast({
        title: "Welcome back! 🌟",
        description: "You've successfully signed in.",
      });
      onOpenChange(false);
      // Don't force navigation - let parent component decide
    } catch (error: unknown) {
      toast({
        variant: "destructive",
        title: "Sign in failed",
        description: error instanceof Error ? error.message : "An error occurred",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="text-2xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
            Welcome to Science Lens
          </DialogTitle>
          <DialogDescription>
            Start your journey of scientific discovery
          </DialogDescription>
        </DialogHeader>
        
        <Tabs defaultValue="signin" className="w-full">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="signin">Sign In</TabsTrigger>
            <TabsTrigger value="signup">Sign Up</TabsTrigger>
          </TabsList>
          
          <TabsContent value="signin">
            <form onSubmit={handleSignIn} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="signin-email">Email</Label>
                <Input
                  id="signin-email"
                  type="email"
                  placeholder="your@email.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="signin-password">Password</Label>
                <Input
                  id="signin-password"
                  type="password"
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                />
              </div>
              <Button type="submit" className="w-full" disabled={isLoading}>
                {isLoading ? (
                  <>
                    <HelixLoader className="mr-2" />
                    Signing in...
                  </>
                ) : (
                  "Sign In"
                )}
              </Button>
            </form>
          </TabsContent>
          
          <TabsContent value="signup">
            <form onSubmit={handleSignUp} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="signup-email">Email</Label>
                <Input
                  id="signup-email"
                  type="email"
                  placeholder="your@email.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="signup-username">Username</Label>
                <div className="relative">
                  <Input
                    id="signup-username"
                    type="text"
                    placeholder="Choose a unique username"
                    value={username}
                    onChange={(e) => handleUsernameChange(e.target.value)}
                    required
                    minLength={3}
                    maxLength={20}
                    pattern="[a-zA-Z0-9_]+"
                    className={usernameError ? "border-red-500" : ""}
                  />
                  {checkingUsername && (
                    <HelixLoader className="absolute right-3 top-1/2 transform -translate-y-1/2 text-muted-foreground" />
                  )}
                </div>
                {usernameError && (
                  <p className="text-sm text-red-500">{usernameError}</p>
                )}
                <p className="text-xs text-muted-foreground">
                  Only letters, numbers, and underscores. Min 3 characters.
                </p>
              </div>
              <div className="space-y-2">
                <Label htmlFor="signup-password">Password</Label>
                <Input
                  id="signup-password"
                  type="password"
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  minLength={8}
                />
                <p className="text-xs text-muted-foreground">
                  At least 8 characters. Use letters and numbers for better security.
                </p>
              </div>
              <Button type="submit" className="w-full" disabled={isLoading || !!usernameError || checkingUsername}>
                {isLoading ? (
                  <>
                    <HelixLoader className="mr-2" />
                    Creating account...
                  </>
                ) : (
                  "Sign Up"
                )}
              </Button>
            </form>
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
}
