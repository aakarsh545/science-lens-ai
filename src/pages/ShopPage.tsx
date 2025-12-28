import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Coins, ShoppingBag, Crown, Check, Palette, Smile, Sparkles } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";

interface ShopItem {
  id: string;
  type: 'theme' | 'avatar';
  name: string;
  description: string;
  price: number;
  is_premium_exclusive: boolean;
  icon_emoji: string;
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
  equipped_theme: string | null;
  equipped_avatar: string | null;
}

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
      .order('price', { ascending: true });

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
      .select('coins, is_premium, equipped_theme, equipped_avatar')
      .eq('user_id', uid)
      .single();

    if (!error && data) {
      setUserProfile(data);
    }
  };

  const handlePurchase = async (item: ShopItem) => {
    if (!userId || !userProfile) return;

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

  const themes = shopItems.filter(item => item.type === 'theme');
  const avatars = shopItems.filter(item => item.type === 'avatar');

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
            Shop
          </h1>
          <p className="text-muted-foreground mt-2">
            Customize your experience with themes and avatars!
          </p>
        </div>

        {/* Coin Balance */}
        {userProfile && (
          <Card className="bg-gradient-to-br from-amber-500/10 to-yellow-500/10 border-amber-500/30">
            <CardContent className="p-4 flex items-center gap-3">
              <Coins className="w-6 h-6 text-amber-500" />
              <div>
                <p className="text-sm text-muted-foreground">Your Coins</p>
                <p className="text-2xl font-bold text-amber-600 dark:text-amber-400">
                  {userProfile.coins}
                </p>
              </div>
            </CardContent>
          </Card>
        )}
      </div>

      {/* Premium Badge */}
      {userProfile?.is_premium && (
        <Card className="bg-gradient-to-r from-purple-500/10 to-pink-500/10 border-purple-500/30">
          <CardContent className="p-4 flex items-center gap-3">
            <Crown className="w-6 h-6 text-purple-500" />
            <div>
              <p className="font-semibold text-purple-600 dark:text-purple-400">Premium Member</p>
              <p className="text-sm text-muted-foreground">You earn 2x coins on all activities!</p>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Shop Tabs */}
      <Tabs defaultValue="themes" className="w-full">
        <TabsList className="grid w-full max-w-md mx-auto grid-cols-2">
          <TabsTrigger value="themes" className="gap-2">
            <Palette className="w-4 h-4" />
            Themes
          </TabsTrigger>
          <TabsTrigger value="avatars" className="gap-2">
            <Smile className="w-4 h-4" />
            Avatars
          </TabsTrigger>
        </TabsList>

        {/* Themes Tab */}
        <TabsContent value="themes" className="space-y-6 mt-8">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {themes.map((theme) => {
              const isOwned = userInventory.has(theme.id);
              const equipped = isEquipped(theme);
              const isPurchasing = purchasing.has(theme.id);
              const isEquipping = equipping.has(theme.id);

              return (
                <motion.div
                  key={theme.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.3 }}
                >
                  <Card className={`overflow-hidden transition-all ${
                    equipped ? 'ring-2 ring-primary' : ''
                  } ${theme.is_premium_exclusive && !userProfile?.is_premium ? 'opacity-60' : ''}`}>
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-2">
                            <CardTitle className="text-lg">{theme.name}</CardTitle>
                            {theme.is_premium_exclusive && (
                              <Badge variant="outline" className="gap-1">
                                <Crown className="w-3 h-3" />
                                Premium
                              </Badge>
                            )}
                          </div>
                          <CardDescription className="mt-2">{theme.description}</CardDescription>
                        </div>
                        {equipped && (
                          <Badge className="bg-primary">
                            <Check className="w-3 h-3 mr-1" />
                            Equipped
                          </Badge>
                        )}
                      </div>
                    </CardHeader>

                    {/* Theme Preview */}
                    <CardContent className="space-y-4">
                      <div
                        className="w-full h-24 rounded-lg border-2 flex items-center justify-center text-lg font-semibold"
                        style={{
                          backgroundColor: theme.metadata.background,
                          color: theme.metadata.text,
                          borderColor: theme.metadata.primary,
                        }}
                      >
                        <span style={{ color: theme.metadata.accent }}>Preview</span>
                      </div>

                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <Coins className="w-4 h-4 text-amber-500" />
                          <span className={`font-bold ${theme.price === 0 ? 'text-green-500' : 'text-amber-600 dark:text-amber-400'}`}>
                            {theme.price === 0 ? 'Free' : theme.price}
                          </span>
                        </div>

                        {!isOwned ? (
                          <Button
                            onClick={() => handlePurchase(theme)}
                            disabled={isPurchasing || userProfile?.coins < theme.price || (theme.is_premium_exclusive && !userProfile?.is_premium)}
                            className={theme.price === 0 ? 'bg-green-500 hover:bg-green-600' : ''}
                          >
                            {isPurchasing ? 'Purchasing...' : theme.price === 0 ? 'Get Free' : 'Purchase'}
                          </Button>
                        ) : (
                          <Button
                            onClick={() => handleEquip(theme)}
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
            })}
          </div>
        </TabsContent>

        {/* Avatars Tab */}
        <TabsContent value="avatars" className="space-y-6 mt-8">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {avatars.map((avatar) => {
              const isOwned = userInventory.has(avatar.id);
              const equipped = isEquipped(avatar);
              const isPurchasing = purchasing.has(avatar.id);
              const isEquipping = equipping.has(avatar.id);

              return (
                <motion.div
                  key={avatar.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.3 }}
                >
                  <Card className={`overflow-hidden transition-all ${
                    equipped ? 'ring-2 ring-primary' : ''
                  } ${avatar.is_premium_exclusive && !userProfile?.is_premium ? 'opacity-60' : ''}`}>
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-2">
                            <CardTitle className="text-lg">{avatar.name}</CardTitle>
                            {avatar.is_premium_exclusive && (
                              <Badge variant="outline" className="gap-1">
                                <Crown className="w-3 h-3" />
                                Premium
                              </Badge>
                            )}
                          </div>
                          <CardDescription className="mt-2">{avatar.description}</CardDescription>
                        </div>
                        {equipped && (
                          <Badge className="bg-primary">
                            <Check className="w-3 h-3 mr-1" />
                            Equipped
                          </Badge>
                        )}
                      </div>
                    </CardHeader>

                    {/* Avatar Preview */}
                    <CardContent className="space-y-4">
                      <div className="w-full h-24 rounded-lg bg-gradient-to-br from-primary/20 to-purple-500/20 border-2 border-primary/30 flex items-center justify-center text-5xl">
                        {avatar.icon_emoji}
                      </div>

                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <Coins className="w-4 h-4 text-amber-500" />
                          <span className={`font-bold ${avatar.price === 0 ? 'text-green-500' : 'text-amber-600 dark:text-amber-400'}`}>
                            {avatar.price === 0 ? 'Free' : avatar.price}
                          </span>
                        </div>

                        {!isOwned ? (
                          <Button
                            onClick={() => handlePurchase(avatar)}
                            disabled={isPurchasing || userProfile?.coins < avatar.price || (avatar.is_premium_exclusive && !userProfile?.is_premium)}
                            className={avatar.price === 0 ? 'bg-green-500 hover:bg-green-600' : ''}
                          >
                            {isPurchasing ? 'Purchasing...' : avatar.price === 0 ? 'Get Free' : 'Purchase'}
                          </Button>
                        ) : (
                          <Button
                            onClick={() => handleEquip(avatar)}
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
            })}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  );
}
