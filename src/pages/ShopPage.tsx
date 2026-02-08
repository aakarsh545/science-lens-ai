import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Coins, ShoppingBag, Check, Palette, Sparkles } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { motion } from "framer-motion";
import { useTheme } from "@/contexts/ThemeContext";

interface ShopItem {
  id: string;
  type: 'avatar' | 'theme';
  name: string;
  description: string;
  price: number;
  icon_emoji: string | null;
  metadata: Record<string, unknown>;
}

interface UserProfile {
  credits: number;
  level: number;
}

export default function ShopPage() {
  const navigate = useNavigate();
  const { toast } = useToast();
  const { equipTheme, theme: currentTheme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [shopItems, setShopItems] = useState<ShopItem[]>([]);
  const [purchasedItemIds, setPurchasedItemIds] = useState<Set<string>>(new Set());
  const [purchasedThemes, setPurchasedThemes] = useState<ShopItem[]>([]);
  const [processingId, setProcessingId] = useState<string | null>(null);

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
      loadUserProfile(session.user.id),
      loadShopItems(),
      loadPurchasedItems(session.user.id)
    ]);
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

  const loadShopItems = async () => {
    const { data, error } = await supabase
      .from('shop_items')
      .select('*')
      .eq('type', 'theme')
      .order('price', { ascending: true });

    if (!error && data) {
      setShopItems(data);
    }
  };

  const loadPurchasedItems = async (uid: string) => {
    const { data, error } = await supabase
      .from('user_inventory')
      .select('item_id, shop_items(*)')
      .eq('user_id', uid);

    if (!error && data) {
      const purchasedIds = new Set(data.map((item: any) => item.item_id));
      setPurchasedItemIds(purchasedIds);

      // Get purchased themes
      const themes = data
        .filter((item: any) => item.shop_items?.type === 'theme')
        .map((item: any) => item.shop_items);
      setPurchasedThemes(themes);
    }
  };

  const handleBuyTheme = async (item: ShopItem) => {
    if (!userId || !userProfile) return;

    if (userProfile.credits < item.price) {
      toast({
        title: "Not enough credits",
        description: `You need ${item.price - userProfile.credits} more credits to buy this theme.`,
        variant: "destructive",
      });
      return;
    }

    setProcessingId(item.id);

    try {
      // Deduct credits
      const { error: creditError } = await supabase
        .from('profiles')
        .update({ credits: userProfile.credits - item.price })
        .eq('user_id', userId);

      if (creditError) throw creditError;

      // Add to inventory
      const { error: inventoryError } = await supabase
        .from('user_inventory')
        .insert({ user_id: userId, item_id: item.id });

      if (inventoryError) throw inventoryError;

      // Update local state
      setUserProfile({ ...userProfile, credits: userProfile.credits - item.price });
      setPurchasedItemIds(new Set([...purchasedItemIds, item.id]));
      setPurchasedThemes([...purchasedThemes, item]);

      toast({
        title: "Theme purchased!",
        description: `You bought ${item.name} for ${item.price} credits.`,
      });
    } catch (error) {
      console.error('[ShopPage] Error buying theme:', error);
      toast({
        title: "Purchase failed",
        description: "There was an error purchasing this theme. Please try again.",
        variant: "destructive",
      });
    } finally {
      setProcessingId(null);
    }
  };

  const handleEquipTheme = async (item: ShopItem) => {
    setProcessingId(item.id);

    const success = await equipTheme(item.id);

    if (success) {
      toast({
        title: "Theme equipped!",
        description: `${item.name} is now your active theme.`,
      });
    } else {
      toast({
        title: "Failed to equip",
        description: "There was an error equipping this theme.",
        variant: "destructive",
      });
    }

    setProcessingId(null);
  };

  const getThemePreview = (metadata: Record<string, unknown>) => {
    const primary = metadata.primary as string || '#3b82f6';
    const secondary = metadata.secondary as string || '#1e40af';
    const background = metadata.background as string || '#0f172a';

    return {
      background: `linear-gradient(135deg, ${primary}20 0%, ${secondary}40 100%)`,
      borderColor: primary,
    };
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

  const freeThemes = shopItems.filter(item => item.price === 0);
  const premiumThemes = shopItems.filter(item => item.price > 0);

  return (
    <div className="container mx-auto p-6 max-w-7xl space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold bg-gradient-cosmic bg-clip-text text-transparent">
            Theme Shop
          </h1>
          <p className="text-muted-foreground mt-1">
            Customize your learning experience with beautiful themes
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

      <Tabs defaultValue="purchased" className="w-full">
        <TabsList className="grid w-full max-w-md grid-cols-3">
          <TabsTrigger value="purchased">
            My Themes ({purchasedThemes.length})
          </TabsTrigger>
          <TabsTrigger value="free">
            Free Themes ({freeThemes.length})
          </TabsTrigger>
          <TabsTrigger value="premium">
            Premium ({premiumThemes.length})
          </TabsTrigger>
        </TabsList>

        <TabsContent value="purchased" className="space-y-4">
          {purchasedThemes.length === 0 ? (
            <Card className="p-12">
              <div className="text-center space-y-4">
                <Palette className="w-16 h-16 mx-auto text-muted-foreground opacity-50" />
                <h3 className="text-xl font-semibold">No themes yet</h3>
                <p className="text-muted-foreground">
                  Get free themes from the Free Themes tab or purchase premium ones!
                </p>
              </div>
            </Card>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {purchasedThemes.map((item) => {
                const isEquipped = currentTheme?.id === item.id;
                const preview = getThemePreview(item.metadata);

                return (
                  <motion.div
                    key={item.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                  >
                    <Card
                      className="overflow-hidden hover:shadow-cosmic transition-all duration-300"
                      style={{ background: preview.background }}
                    >
                      <CardHeader>
                        <div className="flex items-start justify-between">
                          <div className="flex items-center gap-3">
                            <div className="text-4xl">{item.icon_emoji || '🎨'}</div>
                            <div>
                              <CardTitle className="text-lg">{item.name}</CardTitle>
                              <CardDescription className="text-xs">
                                {item.description}
                              </CardDescription>
                            </div>
                          </div>
                          {isEquipped && (
                            <Badge className="bg-success/20 text-success border-success/50">
                              <Check className="w-3 h-3 mr-1" />
                              Equipped
                            </Badge>
                          )}
                        </div>
                      </CardHeader>
                      <CardContent>
                        <Button
                          onClick={() => handleEquipTheme(item)}
                          disabled={processingId === item.id || isEquipped}
                          className="w-full"
                          variant={isEquipped ? "outline" : "default"}
                        >
                          {isEquipped ? "Currently Equipped" : "Equip Theme"}
                        </Button>
                      </CardContent>
                    </Card>
                  </motion.div>
                );
              })}
            </div>
          )}
        </TabsContent>

        <TabsContent value="free" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {freeThemes.map((item) => {
              const isPurchased = purchasedItemIds.has(item.id);
              const isEquipped = currentTheme?.id === item.id;
              const preview = getThemePreview(item.metadata);

              return (
                <motion.div
                  key={item.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                >
                  <Card
                    className="overflow-hidden hover:shadow-cosmic transition-all duration-300"
                    style={{ background: preview.background }}
                  >
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div className="flex items-center gap-3">
                          <div className="text-4xl">{item.icon_emoji || '🎨'}</div>
                          <div>
                            <CardTitle className="text-lg">{item.name}</CardTitle>
                            <CardDescription className="text-xs">
                              {item.description}
                            </CardDescription>
                          </div>
                        </div>
                        <Badge className="bg-success/20 text-success border-success/50">
                          Free
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent>
                      {isPurchased ? (
                        <Button
                          onClick={() => handleEquipTheme(item)}
                          disabled={processingId === item.id || isEquipped}
                          className="w-full"
                          variant={isEquipped ? "outline" : "default"}
                        >
                          {isEquipped ? "Currently Equipped" : "Equip Theme"}
                        </Button>
                      ) : (
                        <Button
                          onClick={() => handleBuyTheme(item)}
                          disabled={processingId === item.id}
                          className="w-full"
                        >
                          <Sparkles className="w-4 h-4 mr-2" />
                          Get Free
                        </Button>
                      )}
                    </CardContent>
                  </Card>
                </motion.div>
              );
            })}
          </div>
        </TabsContent>

        <TabsContent value="premium" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {premiumThemes.map((item) => {
              const isPurchased = purchasedItemIds.has(item.id);
              const isEquipped = currentTheme?.id === item.id;
              const preview = getThemePreview(item.metadata);

              return (
                <motion.div
                  key={item.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                >
                  <Card
                    className="overflow-hidden hover:shadow-cosmic transition-all duration-300"
                    style={{ background: preview.background }}
                  >
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div className="flex items-center gap-3">
                          <div className="text-4xl">{item.icon_emoji || '⭐'}</div>
                          <div>
                            <CardTitle className="text-lg">{item.name}</CardTitle>
                            <CardDescription className="text-xs">
                              {item.description}
                            </CardDescription>
                          </div>
                        </div>
                        <Badge className="bg-gradient-to-r from-amber-500 to-yellow-500 text-white border-0">
                          {item.price} Credits
                        </Badge>
                      </div>
                    </CardHeader>
                    <CardContent>
                      {isPurchased ? (
                        <Button
                          onClick={() => handleEquipTheme(item)}
                          disabled={processingId === item.id || isEquipped}
                          className="w-full"
                          variant={isEquipped ? "outline" : "default"}
                        >
                          {isEquipped ? "Currently Equipped" : "Equip Theme"}
                        </Button>
                      ) : (
                        <Button
                          onClick={() => handleBuyTheme(item)}
                          disabled={processingId === item.id || !userProfile || userProfile.credits < item.price}
                          className="w-full"
                        >
                          <Coins className="w-4 h-4 mr-2" />
                          {userProfile && userProfile.credits < item.price
                            ? `Need ${item.price - userProfile.credits} more`
                            : `Buy for ${item.price}`}
                        </Button>
                      )}
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
