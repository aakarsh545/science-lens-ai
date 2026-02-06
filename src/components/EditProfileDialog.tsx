import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { Loader2, User, Camera } from "lucide-react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";

interface EditProfileDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  userId: string;
  currentProfile: {
    username?: string;
    full_name?: string;
    bio?: string;
    avatar_url?: string;
  };
  onProfileUpdate?: () => void;
}

interface AvatarItem {
  id: string;
  name: string;
  type: string;
}

export function EditProfileDialog({
  open,
  onOpenChange,
  userId,
  currentProfile,
  onProfileUpdate
}: EditProfileDialogProps) {
  const [loading, setLoading] = useState(false);
  const [fullName, setFullName] = useState(currentProfile.full_name || "");
  const [bio, setBio] = useState(currentProfile.bio || "");
  const [username, setUsername] = useState(currentProfile.username || "");
  const [usernameError, setUsernameError] = useState<string>("");
  const [ownedAvatars, setOwnedAvatars] = useState<AvatarItem[]>([]);
  const [selectedAvatar, setSelectedAvatar] = useState(currentProfile.avatar_url || "");
  const { toast } = useToast();

  // Derived validation states
  const trimmedUsername = username.trim();
  const hasChanges = trimmedUsername !== currentProfile.username;
  const isLengthValid = trimmedUsername.length >= 3 && trimmedUsername.length <= 30;
  const isUsernameUnchanged = trimmedUsername === currentProfile.username;
  const hasUniquenessError = usernameError === "This username is already taken" || usernameError === "Username already taken";
  const isSaveDisabled = loading || !isLengthValid || isUsernameUnchanged || hasUniquenessError;

  // Validation function for username
  const validateUsername = (value: string): string => {
    if (!value || value.trim() === '') {
      return 'Username is required';
    }
    const trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (trimmed.length > 30) {
      return 'Username must be 30 characters or fewer';
    }
    return '';
  };

  useEffect(() => {
    if (open) {
      loadOwnedAvatars();
      setFullName(currentProfile.full_name || "");
      setBio(currentProfile.bio || "");
      setUsername(currentProfile.username || "");
      setSelectedAvatar(currentProfile.avatar_url || "");
      setUsernameError(""); // Clear any previous validation errors
    }
  }, [open, currentProfile]);

  const loadOwnedAvatars = async () => {
    // No shop_items/user_inventory tables exist - skip avatar loading
    setOwnedAvatars([]);
  };

  const handleSave = async () => {
    setLoading(true);
    try {
      // Convert empty string back to null for database
      const avatarValue = selectedAvatar === "" ? null : selectedAvatar;

      // Client-side validation (double-check)
      const validationError = validateUsername(username);
      if (validationError) {
        setUsernameError(validationError);
        setLoading(false);
        return;
      }

      const trimmedUsername = username.trim();

      // Update username using RPC (with validation)
      // Only call RPC if username actually changed
      if (trimmedUsername !== currentProfile.username) {
        console.log('[EditProfileDialog] Updating display_name to:', trimmedUsername);
        const { error: usernameError } = await supabase
          .from('profiles')
          .update({ display_name: trimmedUsername })
          .eq('user_id', userId);

        if (usernameError) {
          throw new Error(usernameError.message);
        }

        console.log('[EditProfileDialog] Display name updated successfully');
      }

      // Update other profile fields (avatar, full_name, bio)
      // Note: username is handled by the RPC above, not here
      const { error } = await supabase
        .from('profiles')
        .update({
          full_name: fullName,
          bio: bio,
          equipped_avatar: avatarValue,
        })
        .eq('user_id', userId);

      if (error) throw error;

      // Only show success toast if we actually got here
      toast({
        title: "Profile updated!",
        description: "Your changes have been saved.",
      });

      onOpenChange(false);

      // Trigger profile refresh callback
      if (onProfileUpdate) {
        onProfileUpdate();
      }

      // Dispatch custom event for global profile update
      window.dispatchEvent(new CustomEvent('profile-updated', { detail: { userId } }));
    } catch (error) {
      console.error('Error updating profile:', error);
      toast({
        title: "Update failed",
        description: error instanceof Error ? error.message : "Could not update profile",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[500px] max-h-[90vh]">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <User className="w-5 h-5" />
            Edit Profile
          </DialogTitle>
          <DialogDescription>
            Update your profile information and avatar
          </DialogDescription>
        </DialogHeader>

        <ScrollArea className="max-h-[calc(90vh-140px)] px-1">
          <div className="space-y-6 py-4">
            {/* Avatar Selection */}
            <div className="space-y-3">
              <Label className="flex items-center gap-2">
                <Camera className="w-4 h-4" />
                Profile Avatar
              </Label>
              <div className="grid grid-cols-5 gap-3">
                {/* Default avatar option */}
                <button
                  type="button"
                  onClick={() => setSelectedAvatar("")}
                  className={`relative aspect-square rounded-lg border-2 flex items-center justify-center text-2xl transition-all hover:border-primary/50 ${
                    selectedAvatar === "" ? "border-primary bg-primary/10" : "border-border"
                  }`}
                >
                  <User className="w-8 h-8 text-muted-foreground" />
                  {selectedAvatar === "" && (
                    <Badge className="absolute -top-2 -right-2 text-xs">Current</Badge>
                  )}
                </button>

                {/* Owned avatars */}
                {ownedAvatars.map((avatar) => (
                  <button
                    key={avatar.id}
                    type="button"
                    onClick={() => setSelectedAvatar(avatar.id)}
                    className={`relative aspect-square rounded-lg border-2 overflow-hidden transition-all hover:border-primary/50 ${
                      selectedAvatar === avatar.id ? "border-primary bg-primary/10" : "border-border"
                    }`}
                  >
                    <img
                      src={`/icons/avatars/avatar-${avatar.name.toLowerCase().replace(/\s+/g, '-')}.png`}
                      alt={avatar.name}
                      className="w-full h-full object-cover"
                    />
                    {selectedAvatar === avatar.id && (
                      <Badge className="absolute -top-2 -right-2 text-xs">Current</Badge>
                    )}
                  </button>
                ))}
              </div>
              {ownedAvatars.length === 0 && (
                <p className="text-sm text-muted-foreground">
                  No avatars owned. Visit the shop to purchase avatars!
                </p>
              )}
            </div>

            {/* Username */}
            <div className="space-y-2">
              <Label htmlFor="username">Username <span className="text-destructive">*</span></Label>
              <Input
                id="username"
                value={username}
                onChange={(e) => {
                  const value = e.target.value;
                  setUsername(value);
                  setUsernameError(validateUsername(value));
                }}
                placeholder="Enter your username"
                maxLength={30}
                className={usernameError ? "border-destructive" : ""}
              />
              {usernameError && (
                <p className="text-sm text-destructive font-medium">{usernameError}</p>
              )}
              {!usernameError && (
                <p className="text-xs text-muted-foreground">
                  3-30 characters
                </p>
              )}
            </div>

            {/* Full Name */}
            <div className="space-y-2">
              <Label htmlFor="fullName">Full Name</Label>
              <Input
                id="fullName"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                placeholder="Enter your full name"
                maxLength={50}
              />
            </div>

            {/* Bio */}
            <div className="space-y-2">
              <Label htmlFor="bio">Bio</Label>
              <Textarea
                id="bio"
                value={bio}
                onChange={(e) => setBio(e.target.value)}
                placeholder="Tell us about yourself..."
                maxLength={150}
                rows={3}
              />
              <p className="text-xs text-muted-foreground text-right">
                {bio.length}/150
              </p>
            </div>
          </div>
        </ScrollArea>

        <div className="flex flex-col gap-2 pt-4 border-t">
          <div className="flex gap-2">
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
              disabled={loading}
              className="flex-1"
            >
              Cancel
            </Button>
            <Button
              type="button"
              onClick={handleSave}
              disabled={isSaveDisabled}
              className="flex-1"
            >
              {loading ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Saving...
                </>
              ) : (
                "Save Changes"
              )}
            </Button>
          </div>

          {/* Validation message below the button */}
          {!loading && isSaveDisabled && (
            <p className="text-sm text-muted-foreground text-center">
              {!isLengthValid && trimmedUsername.length === 0
                ? "Username is required"
                : !isLengthValid && trimmedUsername.length < 3
                ? "Username must be at least 3 characters"
                : !isLengthValid && trimmedUsername.length > 30
                ? "Username must be 30 characters or fewer"
                : isUsernameUnchanged
                ? "Username has not changed"
                : hasUniquenessError
                ? "This username is already taken"
                : ""}
            </p>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
