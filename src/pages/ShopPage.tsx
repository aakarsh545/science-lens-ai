import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Coins, ShoppingBag, Crown, Check, Palette, Smile, Sparkles, Lock, Star } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";

interface ShopItem {
  id: string;
  type: 'theme' | 'avatar';
  name: string;
  description: string;
  price: number;
  is_premium_exclusive: boolean;
  level_required: number;
  rarity: 'common' | 'uncommon' | 'rare' | 'epic' | 'legendary' | 'mythical' | 'godly';
  icon_emoji: string | null;
  metadata: {
    primary?: string;
    secondary?: string;
    background?: string;
    text?: string;
    accent?: string;
    gradientColors?: string[];
  };
}

interface UserInventory {
  item_id: string;
}

interface UserProfile {
  coins: number;
  is_premium: boolean;
  level: number;
  equipped_theme: string | null;
  equipped_avatar: string | null;
}

// Rarity configuration
const RARITY_CONFIG = {
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
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [shopItems, setShopItems] = useState<ShopItem[]>([]);
  const [userInventory, setUserInventory] = useState<Set<string>>(new Set());
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [purchasing, setPurchasing] = useState<Set<string>>(new Set());
  const [equipping, setEquipping] = useState<Set<string>>(new Set());

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
    await Promise.all([
      loadShopItems(),
      loadUserInventory(session.user.id),
      loadUserProfile(session.user.id)
    ]);
    setLoading(false);
  };

  const loadShopItems = async () => {
    const { data, error } = await supabase
      .from('shop_items')
      .select('*')
      .order('level_required', { ascending: true });

    if (!error && data) {
      setShopItems(data);
    }
  };

  const loadUserInventory = async (uid: string) => {
    const { data, error } = await supabase
      .from('user_inventory')
      .select('item_id')
      .eq('user_id', uid);

    if (!error && data) {
      const itemIds = new Set(data.map(item => item.item_id));
      setUserInventory(itemIds);
    }
  };

  const loadUserProfile = async (uid: string) => {
    const { data, error } = await supabase
      .from('profiles')
      .select('coins, is_premium, level, equipped_theme, equipped_avatar')
      .eq('user_id', uid)
      .single();

    if (!error && data) {
      setUserProfile(data);
    }
  };

  const handlePurchase = async (item: ShopItem) => {
    if (!userId || !userProfile) return;

    // Check level requirement
    if (userProfile.level < item.level_required) {
      toast({
        title: "Level requirement not met!",
        description: `You need to be Level ${item.level_required} to purchase this item. Current level: ${userProfile.level}`,
        variant: "destructive",
      });
      return;
    }

    // Check if user has enough coins
    if (userProfile.coins < item.price) {
      toast({
        title: "Not enough coins!",
        description: `You need ${item.price - userProfile.coins} more coins to purchase this item.`,
        variant: "destructive",
      });
      return;
    }

    // Check if premium exclusive and user is not premium
    if (item.is_premium_exclusive && !userProfile.is_premium) {
      toast({
        title: "Premium Exclusive!",
        description: "This item is only available to premium members.",
        variant: "destructive",
      });
      return;
    }

    setPurchasing(prev => new Set(prev).add(item.id));

    try {
      // Spend coins
      const { error: spendError } = await supabase.rpc('spend_coins', {
        user_id: userId,
        amount: item.price,
        item_id: item.id
      });

      if (spendError) {
        toast({
          title: "Purchase failed",
          description: spendError.message,
          variant: "destructive",
        });
        return;
      }

      // Add to inventory
      const { error: invError } = await supabase
        .from('user_inventory')
        .insert({
          user_id: userId,
          item_id: item.id
        });

      if (invError) throw invError;

      // Update local state
      setUserInventory(prev => new Set(prev).add(item.id));
      setUserProfile(prev => prev ? { ...prev, coins: prev.coins - item.price } : null);

      toast({
        title: "Purchase successful! 🎉",
        description: `You purchased ${item.name} for ${item.price} coins!`,
      });
    } catch (error: any) {
      toast({
        title: "Purchase failed",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setPurchasing(prev => {
        const newSet = new Set(prev);
        newSet.delete(item.id);
        return newSet;
      });
    }
  };

  const handleEquip = async (item: ShopItem) => {
    if (!userId) return;

    setEquipping(prev => new Set(prev).add(item.id));

    try {
      const column = item.type === 'theme' ? 'equipped_theme' : 'equipped_avatar';

      const { error } = await supabase
        .from('profiles')
        .update({ [column]: item.id })
        .eq('user_id', userId);

      if (error) throw error;

      // Update local state
      await loadUserProfile(userId);

      toast({
        title: "Item equipped! ✨",
        description: `You're now using ${item.name}`,
      });
    } catch (error: any) {
      toast({
        title: "Failed to equip",
        description: error.message,
        variant: "destructive",
      });
    } finally {
      setEquipping(prev => {
        const newSet = new Set(prev);
        newSet.delete(item.id);
        return newSet;
      });
    }
  };

  const isEquipped = (item: ShopItem) => {
    if (item.type === 'theme') {
      return userProfile?.equipped_theme === item.id;
    }
    return userProfile?.equipped_avatar === item.id;
  };

  // Group items by rarity and type
  const themesByRarity = shopItems.filter(item => item.type === 'theme').reduce((acc, item) => {
    if (!acc[item.rarity]) acc[item.rarity] = [];
    acc[item.rarity].push(item);
    return acc;
  }, {} as Record<string, ShopItem[]>);

  const avatarsByRarity = shopItems.filter(item => item.type === 'avatar').reduce((acc, item) => {
    if (!acc[item.rarity]) acc[item.rarity] = [];
    acc[item.rarity].push(item);
    return acc;
  }, {} as Record<string, ShopItem[]>);

  const renderShopCard = (item: ShopItem) => {
    const isOwned = userInventory.has(item.id);
    const equipped = isEquipped(item);
    const isPurchasing = purchasing.has(item.id);
    const isEquipping = equipping.has(item.id);
    const meetsLevelReq = userProfile ? userProfile.level >= item.level_required : false;
    const meetsPremiumReq = !item.is_premium_exclusive || userProfile?.is_premium;
    const canPurchase = meetsLevelReq && meetsPremiumReq;

    return (
      <motion.div
        key={item.id}
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
      >
        <Card className={`overflow-hidden transition-all ${
          equipped ? 'ring-2 ring-primary' : ''
        } ${!canPurchase ? 'opacity-60' : ''}`}>
          <CardHeader>
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <div className="flex items-center gap-2 mb-2">
                  {item.icon_emoji && <span className="text-2xl">{item.icon_emoji}</span>}
                  <CardTitle className="text-lg">{item.name}</CardTitle>
                  <Badge className={RARITY_CONFIG[item.rarity].color}>
                    <span className="mr-1">{RARITY_CONFIG[item.rarity].icon}</span>
                    {RARITY_CONFIG[item.rarity].label}
                  </Badge>
                  {item.is_premium_exclusive && (
                    <Badge variant="outline" className="gap-1 border-purple-500 text-purple-400">
                      <Crown className="w-3 h-3" />
                      Premium
                    </Badge>
                  )}
                </div>
                <CardDescription className="mt-2">{item.description}</CardDescription>
                <div className="flex items-center gap-2 mt-2">
                  <Badge variant="outline" className="text-xs">
                    Level {item.level_required}
                  </Badge>
                  {equipped && (
                    <Badge className="bg-primary">
                      <Check className="w-3 h-3 mr-1" />
                      Equipped
                    </Badge>
                  )}
                </div>
              </div>
            </div>
          </CardHeader>

          {/* Preview */}
          <CardContent className="space-y-4">
            {item.type === 'theme' ? (
              <div
                className="w-full h-24 rounded-lg border-2 flex items-center justify-center text-lg font-semibold"
                style={{
                  backgroundColor: item.metadata.background,
                  color: item.metadata.text,
                  borderColor: item.metadata.primary,
                }}
              >
                <span style={{ color: item.metadata.accent }}>Preview</span>
              </div>
            ) : (
              <div className="w-full h-24 rounded-lg bg-gradient-to-br from-primary/20 to-purple-500/20 border-2 border-primary/30 flex items-center justify-center text-5xl">
                {item.icon_emoji}
              </div>
            )}

            {/* Requirements */}
            {!meetsLevelReq && (
              <div className="flex items-center gap-2 text-sm text-amber-600 dark:text-amber-400">
                <Lock className="w-4 h-4" />
                <span>Requires Level {item.level_required}</span>
              </div>
            )}

            {!meetsPremiumReq && (
              <div className="flex items-center gap-2 text-sm text-purple-600 dark:text-purple-400">
                <Crown className="w-4 h-4" />
                <span>Premium Exclusive</span>
              </div>
            )}

            {/* Actions */}
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Coins className="w-4 h-4 text-amber-500" />
                <span className={`font-bold ${item.price === 0 ? 'text-green-500' : 'text-amber-600 dark:text-amber-400'}`}>
                  {item.price === 0 ? 'Free' : item.price}
                </span>
              </div>

              {!isOwned ? (
                <Button
                  onClick={() => handlePurchase(item)}
                  disabled={isPurchasing || !canPurchase || userProfile?.coins < item.price}
                  className={item.price === 0 ? 'bg-green-500 hover:bg-green-600' : ''}
                >
                  {isPurchasing ? 'Purchasing...' : item.price === 0 ? 'Claim Free' : 'Purchase'}
                </Button>
              ) : (
                <Button
                  onClick={() => handleEquip(item)}
                  disabled={equipped || isEquipping}
                  variant={equipped ? 'default' : 'outline'}
                >
                  {isEquipping ? 'Equipping...' : equipped ? 'Equipped' : 'Equip'}
                </Button>
              )}
            </div>
          </CardContent>
        </Card>
      </motion.div>
    );
  };

  const renderRaritySection = (rarity: string, title: string) => {
    const themes = themesByRarity[rarity] || [];
    const avatars = avatarsByRarity[rarity] || [];

    if (themes.length === 0 && avatars.length === 0) return null;

    return (
      <div key={rarity} className="space-y-6">
        <div className="flex items-center gap-3">
          <span className="text-3xl">{RARITY_CONFIG[rarity].icon}</span>
          <h2 className="text-3xl font-bold bg-gradient-to-r from-primary to-purple-500 bg-clip-text text-transparent">
            {title}
          </h2>
        </div>

        <Tabs defaultValue="themes" className="w-full">
          <TabsList className="grid w-full max-w-md grid-cols-2">
            <TabsTrigger value="themes" className="gap-2">
              <Palette className="w-4 h-4" />
              Themes ({themes.length})
            </TabsTrigger>
            <TabsTrigger value="avatars" className="gap-2">
              <Smile className="w-4 h-4" />
              Avatars ({avatars.length})
            </TabsTrigger>
          </TabsList>

          <TabsContent value="themes" className="mt-6">
            {themes.length > 0 ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {themes.map(renderShopCard)}
              </div>
            ) : (
              <p className="text-center text-muted-foreground py-12">No themes in this rarity tier</p>
            )}
          </TabsContent>

          <TabsContent value="avatars" className="mt-6">
            {avatars.length > 0 ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {avatars.map(renderShopCard)}
              </div>
            ) : (
              <p className="text-center text-muted-foreground py-12">No avatars in this rarity tier</p>
            )}
          </TabsContent>
        </Tabs>
      </div>
    );
  };

  if (loading) {
    return (
      <div className="p-6 max-w-7xl mx-auto">
        <div className="flex items-center justify-center min-h-[60vh]">
          <div className="text-center">
            <ShoppingBag className="w-16 h-16 mx-auto mb-4 text-primary animate-pulse" />
            <p className="text-muted-foreground">Loading shop...</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-8">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-4xl font-bold bg-gradient-to-r from-primary to-purple-500 bg-clip-text text-transparent flex items-center gap-3">
            <ShoppingBag className="w-10 h-10 text-primary" />
            Rarity Shop
          </h1>
          <p className="text-muted-foreground mt-2">
            Collect items across 7 rarity tiers! Higher rarities require higher levels.
          </p>
        </div>

        {/* User Stats */}
        {userProfile && (
          <div className="flex gap-4">
            <Card className="bg-gradient-to-br from-amber-500/10 to-yellow-500/10 border-amber-500/30">
              <CardContent className="p-4 flex items-center gap-3">
                <Coins className="w-6 h-6 text-amber-500" />
                <div>
                  <p className="text-sm text-muted-foreground">Coins</p>
                  <p className="text-2xl font-bold text-amber-600 dark:text-amber-400">
                    {userProfile.coins}
                  </p>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-gradient-to-br from-primary/10 to-purple-500/10 border-primary/30">
              <CardContent className="p-4 flex items-center gap-3">
                <Star className="w-6 h-6 text-primary" />
                <div>
                  <p className="text-sm text-muted-foreground">Level</p>
                  <p className="text-2xl font-bold text-primary">
                    {userProfile.level}
                  </p>
                </div>
              </CardContent>
            </Card>

            {userProfile.is_premium && (
              <Card className="bg-gradient-to-r from-purple-500/10 to-pink-500/10 border-purple-500/30">
                <CardContent className="p-4 flex items-center gap-3">
                  <Crown className="w-6 h-6 text-purple-500" />
                  <div>
                    <p className="font-semibold text-purple-600 dark:text-purple-400">Premium</p>
                    <p className="text-xs text-muted-foreground">2x coins</p>
                  </div>
                </CardContent>
              </Card>
            )}
          </div>
        )}
      </div>

      {/* Rarity Sections */}
      <div className="space-y-12">
        {renderRaritySection('common', '⚪ Common (Level 1)')}
        {renderRaritySection('uncommon', '🟢 Uncommon (Level 5)')}
        {renderRaritySection('rare', '🔵 Rare (Level 10)')}
        {renderRaritySection('epic', '🟣 Epic (Level 20)')}
        {renderRaritySection('legendary', '🟠 Legendary (Level 40)')}
        {renderRaritySection('mythical', '🌟 Mythical (Level 60) - 50% Premium')}
        {renderRaritySection('godly', '👑 Godly (Level 100) - 90% Premium')}
      </div>
    </div>
  );
}
