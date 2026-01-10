import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { User } from "lucide-react";

interface UserAvatarProps {
  userId: string;
  className?: string;
}

export function UserAvatar({ userId, className = "" }: UserAvatarProps) {
  const [avatarImagePath, setAvatarImagePath] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const loadEquippedAvatar = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('equipped_avatar')
        .eq('user_id', userId)
        .single();

      if (error) throw error;

      if (data?.equipped_avatar) {
        // Fetch the avatar item from shop to get the name
        const { data: avatarData, error: avatarError } = await supabase
          .from('shop_items')
          .select('name')
          .eq('id', data.equipped_avatar)
          .eq('type', 'avatar')
          .single();

        if (!avatarError && avatarData?.name) {
          // Construct the image path exactly like ShopPage does
          const imagePath = `/icons/avatars/avatar-${avatarData.name.toLowerCase().replace(/\s+/g, '-')}.png`;
          setAvatarImagePath(imagePath);
        } else {
          // No avatar equipped or error
          setAvatarImagePath(null);
        }
      } else {
        // No avatar equipped
        setAvatarImagePath(null);
      }
    } catch (error) {
      console.error('[UserAvatar] Error loading avatar:', error);
      setAvatarImagePath(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadEquippedAvatar();
  }, [userId]);

  // Listen for profile update events and refresh avatar
  useEffect(() => {
    const handleProfileUpdate = (event: Event) => {
      const customEvent = event as CustomEvent;
      if (customEvent.detail?.userId === userId) {
        console.log('[UserAvatar] Profile update detected, refreshing avatar');
        loadEquippedAvatar();
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
      {avatarImagePath ? (
        <>
          <AvatarImage
            src={avatarImagePath}
            alt="Avatar"
            onError={(e) => {
              // Fallback if image doesn't load
              const target = e.target as HTMLImageElement;
              target.style.display = 'none';
            }}
          />
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
