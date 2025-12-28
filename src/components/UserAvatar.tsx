import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

interface UserAvatarProps {
  userId: string;
  className?: string;
}

export function UserAvatar({ userId, className = "" }: UserAvatarProps) {
  const [avatarEmoji, setAvatarEmoji] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadEquippedAvatar();
  }, [userId]);

  const loadEquippedAvatar = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('equipped_avatar')
        .eq('user_id', userId)
        .single();

      if (error) throw error;

      if (data?.equipped_avatar) {
        // Fetch the avatar item from shop
        const { data: avatarData, error: avatarError } = await supabase
          .from('shop_items')
          .select('icon_emoji')
          .eq('id', data.equipped_avatar)
          .eq('type', 'avatar')
          .single();

        if (!avatarError && avatarData?.icon_emoji) {
          setAvatarEmoji(avatarData.icon_emoji);
        } else {
          // Default avatar if none equipped or error
          setAvatarEmoji('👤');
        }
      } else {
        // No avatar equipped, use default
        setAvatarEmoji('👤');
      }
    } catch (error) {
      console.error('[UserAvatar] Error loading avatar:', error);
      setAvatarEmoji('👤');
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <Avatar className={className}>
        <AvatarFallback className="animate-pulse">...</AvatarFallback>
      </Avatar>
    );
  }

  return (
    <Avatar className={className}>
      <AvatarFallback className="text-2xl bg-gradient-to-br from-primary/20 to-purple-500/20">
        {avatarEmoji || '👤'}
      </AvatarFallback>
    </Avatar>
  );
}
