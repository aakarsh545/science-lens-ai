import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Coins, ShoppingBag, Crown, Check, Palette, Smile, Sparkles, Lock, Star, Zap, Clock, DollarSign, TrendingUp } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";
import { useTheme } from "@/contexts/ThemeContext";
import { AdminToggle } from "@/components/AdminToggle";

interface ShopItem {
  id: string;
  type: 'avatar' | 'theme';
  name: string;
  description: string;
  price: number;
  is_premium_exclusive: boolean;
  level_required: number;
  rarity: 'common' | 'uncommon' | 'rare' | 'epic' | 'legendary' | 'mythical' | 'godly';
  icon_emoji: string | null;
  metadata: Record<string, unknown>;
}

interface UserProfile {
  credits: number;
  level: number;
}

const RARITY_CONFIG: Record<string, { color: string; icon: string; label: string }> = {
  common: { color: 'bg-gray-500/20 text-gray-400 border-gray-500/50', icon: '⚪', label: 'Common' },
  uncommon: { color: 'bg-green-500/20 text-green-400 border-green-500/50', icon: '🟢', label: 'Uncommon' },
  rare: { color: 'bg-blue-500/20 text-blue-400 border-blue-500/50', icon: '🔵', label: 'Rare' },
  epic: { color: 'bg-purple-500/20 text-purple-400 border-purple-500/50', icon: '🟣', label: 'Epic' },
  legendary: { color: 'bg-orange-500/20 text-orange-400 border-orange-500/50', icon: '🟠', label: 'Legendary' },
  mythical: { color: 'bg-pink-500/20 text-pink-400 border-pink-500/50', icon: '🌟', label: 'Mythical' },
  godly: { color: 'bg-gradient-to-r from-yellow-500/20 to-red-500/20 text-yellow-400 border-yellow-500/50', icon: '👑', label: 'Godly' },
};

export default function ShopPage() {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { refreshTheme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);

  useEffect(() => {
    initPage();
  }, []);

  const initPage = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      navigate("/");
      return;
    }
    setUserId(session.user.id);
    await loadUserProfile(session.user.id);
    setLoading(false);
  };

  const loadUserProfile = async (uid: string) => {
    const { data: profileData } = await supabase
      .from('profiles')
      .select('credits, level')
      .eq('user_id', uid)
      .single();

    if (profileData) {
      setUserProfile(profileData);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center space-y-4">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto"></div>
          <p className="text-muted-foreground">Loading shop...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 max-w-6xl space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Shop</h1>
          <p className="text-muted-foreground mt-1">
            The shop is currently being set up. Check back soon!
          </p>
        </div>

        {userProfile && (
          <Card className="bg-gradient-to-br from-amber-500/10 to-yellow-500/10 border-amber-500/30">
            <CardContent className="p-4 flex items-center gap-3">
              <Coins className="w-5 h-5 text-amber-500" />
              <div>
                <p className="text-xs text-muted-foreground">Your Balance</p>
                <p className="text-lg font-bold text-amber-600 dark:text-amber-400">
                  {userProfile.credits.toLocaleString()} Credits
                </p>
              </div>
            </CardContent>
          </Card>
        )}
      </div>

      <Card className="p-12">
        <div className="text-center space-y-4">
          <ShoppingBag className="w-16 h-16 mx-auto text-muted-foreground opacity-50" />
          <h3 className="text-xl font-semibold">Shop Coming Soon</h3>
          <p className="text-muted-foreground max-w-md mx-auto">
            The shop requires additional database tables to be set up. Themes, avatars, and other items will be available here once configured.
          </p>
          <Button variant="outline" onClick={() => navigate('/')}>
            Back to Dashboard
          </Button>
        </div>
      </Card>
    </div>
  );
}
