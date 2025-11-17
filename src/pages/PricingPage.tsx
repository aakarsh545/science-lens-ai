import { useEffect, useState } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useNavigate } from "react-router-dom";
import { Loader2, Zap, Sparkles, Crown, Check } from "lucide-react";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useToast } from "@/hooks/use-toast";

const creditPacks = [
  {
    name: "Starter Pack",
    credits: 50,
    price: "$4.99",
    icon: Zap,
    color: "text-blue-500",
    features: ["50 AI interactions", "Basic topics", "7-day access", "Email support"]
  },
  {
    name: "Explorer Pack",
    credits: 150,
    price: "$12.99",
    icon: Sparkles,
    color: "text-purple-500",
    popular: true,
    features: ["150 AI interactions", "All topics", "30-day access", "Priority support", "Progress tracking"]
  },
  {
    name: "Master Pack",
    credits: 500,
    price: "$34.99",
    icon: Crown,
    color: "text-amber-500",
    features: ["500 AI interactions", "All topics + advanced", "90-day access", "VIP support", "Exclusive content", "Achievement badges"]
  }
];

export default function PricingPage() {
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState<any>(null);
  const navigate = useNavigate();
  const { toast } = useToast();

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        navigate("/");
        return;
      }
      setUser(session.user);
      setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        navigate("/");
      }
    });

    return () => subscription.unsubscribe();
  }, [navigate]);

  const handlePurchase = (pack: typeof creditPacks[0]) => {
    toast({
      title: "Coming Soon!",
      description: `Payment integration for ${pack.name} will be available shortly.`,
    });
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="text-center mb-12">
        <h1 className="text-4xl md:text-5xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-4">
          Choose Your Learning Pack
        </h1>
        <p className="text-muted-foreground text-lg">
          Get credits to continue your science learning journey
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {creditPacks.map((pack) => {
          const Icon = pack.icon;
          return (
            <Card 
              key={pack.name} 
              className={`relative hover:shadow-cosmic transition-all duration-300 ${
                pack.popular ? 'border-primary shadow-cosmic' : ''
              }`}
            >
              {pack.popular && (
                <Badge className="absolute -top-3 left-1/2 -translate-x-1/2 bg-primary">
                  Most Popular
                </Badge>
              )}
              
              <CardHeader className="text-center">
                <div className="flex justify-center mb-4">
                  <Icon className={`w-12 h-12 ${pack.color}`} />
                </div>
                <CardTitle className="text-2xl">{pack.name}</CardTitle>
                <CardDescription>
                  <span className="text-3xl font-bold text-foreground">{pack.price}</span>
                </CardDescription>
              </CardHeader>

              <CardContent>
                <div className="text-center mb-6">
                  <div className="text-4xl font-bold text-primary mb-1">{pack.credits}</div>
                  <div className="text-sm text-muted-foreground">Credits</div>
                </div>

                <ul className="space-y-3">
                  {pack.features.map((feature) => (
                    <li key={feature} className="flex items-start gap-2">
                      <Check className="w-5 h-5 text-success shrink-0 mt-0.5" />
                      <span className="text-sm">{feature}</span>
                    </li>
                  ))}
                </ul>
              </CardContent>

              <CardFooter>
                <Button 
                  onClick={() => handlePurchase(pack)}
                  variant={pack.popular ? "default" : "outline"}
                  className="w-full"
                >
                  Get Started
                </Button>
              </CardFooter>
            </Card>
          );
        })}
      </div>

      <div className="mt-12 text-center text-sm text-muted-foreground">
        <p>All prices are in USD. Credits never expire and can be used across all features.</p>
      </div>
    </div>
  );
}
