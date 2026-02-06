import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { User } from "lucide-react";

interface UserAvatarProps {
  userId: string;
  className?: string;
}

export function UserAvatar({ userId, className = "" }: UserAvatarProps) {
  const [avatarUrl, setAvatarUrl] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const loadAvatar = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('avatar_url')
        .eq('user_id', userId)
        .single();

      if (!error && data?.avatar_url) {
        setAvatarUrl(data.avatar_url);
      } else {
        setAvatarUrl(null);
      }
    } catch (error) {
      console.error('[UserAvatar] Error loading avatar:', error);
      setAvatarUrl(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadAvatar();
  }, [userId]);

  useEffect(() => {
    const handleProfileUpdate = (event: Event) => {
      const customEvent = event as CustomEvent;
      if (customEvent.detail?.userId === userId) {
        loadAvatar();
      }
    };

    window.addEventListener('profile-updated', handleProfileUpdate);
    return () => {
      window.removeEventListener('profile-updated', handleProfileUpdate);
    };
  }, [userId]);

  if (loading) {
    return (
      <Avatar className={className}>
        <AvatarFallback className="animate-pulse">...</AvatarFallback>
      </Avatar>
    );
  }

  return (
    <Avatar className={className}>
      {avatarUrl ? (
        <>
          <AvatarImage src={avatarUrl} alt="Avatar" />
          <AvatarFallback className="bg-gradient-to-br from-primary/20 to-purple-500/20">
            <User className="h-4 w-4" />
          </AvatarFallback>
        </>
      ) : (
        <AvatarFallback className="bg-gradient-to-br from-primary/20 to-purple-500/20">
          <User className="h-4 w-4" />
        </AvatarFallback>
      )}
    </Avatar>
  );
}
