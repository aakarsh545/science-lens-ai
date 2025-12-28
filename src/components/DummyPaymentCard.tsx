import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { CreditCard, Lock, Check, AlertTriangle } from "lucide-react";
import { toast } from "@/components/ui/use-toast";

interface DummyPaymentCardProps {
  onSuccess: () => void;
  amount?: number;
  description: string;
}

export function DummyPaymentCard({ onSuccess, amount, description }: DummyPaymentCardProps) {
  const [processing, setProcessing] = useState(false);
  const [cardNumber, setCardNumber] = useState("4242 4242 4242 4242");
  const [expiry, setExpiry] = useState("12/28");
  const [cvv, setCvv] = useState("123");
  const [name, setName] = useState("Test User");

  const handlePayment = async () => {
    setProcessing(true);

    // Simulate payment processing
    await new Promise(resolve => setTimeout(resolve, 2000));

    setProcessing(false);
    toast({
      title: "✅ Payment Successful!",
      description: "Test payment completed successfully.",
    });

    onSuccess();
  };

  return (
    <Card className="border-2 border-dashed border-primary/50 bg-gradient-to-br from-primary/5 to-purple-500/5">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <CreditCard className="w-6 h-6 text-primary" />
            <CardTitle>Test Payment Card</CardTitle>
          </div>
          <Badge variant="secondary" className="bg-yellow-500/20 text-yellow-700 dark:text-yellow-400 border-yellow-500/50">
            <AlertTriangle className="w-3 h-3 mr-1" />
            Demo Mode
          </Badge>
        </div>
        <CardDescription>
          Use this test card to simulate payments. No real money will be charged.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-6">
        {/* Test Card Visual */}
        <div className="relative w-full h-48 bg-gradient-to-br from-purple-600 to-blue-600 rounded-xl p-6 text-white shadow-2xl">
          <div className="absolute top-4 right-4">
            <Badge variant="secondary" className="bg-white/20 backdrop-blur text-white border-0">
              TEST
            </Badge>
          </div>
          <div className="mt-8">
            <p className="text-lg font-mono tracking-wider">{cardNumber}</p>
          </div>
          <div className="flex justify-between items-end mt-6">
            <div>
              <p className="text-xs text-white/70">Card Holder</p>
              <p className="font-medium">{name}</p>
            </div>
            <div className="text-right">
              <p className="text-xs text-white/70">Expires</p>
              <p className="font-medium">{expiry}</p>
            </div>
          </div>
          <div className="absolute bottom-4 right-4 opacity-20">
            <CreditCard className="w-16 h-16" />
          </div>
        </div>

        {/* Payment Details */}
        {amount !== undefined && (
          <div className="bg-white dark:bg-gray-800 rounded-lg p-4 space-y-2">
            <div className="flex justify-between items-center">
              <span className="text-sm text-muted-foreground">Amount</span>
              <span className="text-2xl font-bold">${amount.toLocaleString()}</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-sm text-muted-foreground">Description</span>
              <span className="text-sm font-medium text-right max-w-[200px]">{description}</span>
            </div>
          </div>
        )}

        {/* Card Details Form */}
        <div className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="card-name">Cardholder Name</Label>
            <Input
              id="card-name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="John Doe"
              className="bg-white dark:bg-gray-800"
            />
          </div>

          <div className="space-y-2">
            <Label htmlFor="card-number">Card Number</Label>
            <Input
              id="card-number"
              value={cardNumber}
              onChange={(e) => setCardNumber(e.target.value)}
              placeholder="4242 4242 4242 4242"
              className="bg-white dark:bg-gray-800 font-mono"
              maxLength={19}
            />
            <p className="text-xs text-muted-foreground">
              💡 Use any test card number (e.g., 4242 4242 4242 4242)
            </p>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="expiry">Expiry Date</Label>
              <Input
                id="expiry"
                value={expiry}
                onChange={(e) => setExpiry(e.target.value)}
                placeholder="MM/YY"
                className="bg-white dark:bg-gray-800"
                maxLength={5}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="cvv">CVV</Label>
              <Input
                id="cvv"
                type="password"
                value={cvv}
                onChange={(e) => setCvv(e.target.value)}
                placeholder="123"
                className="bg-white dark:bg-gray-800"
                maxLength={3}
              />
            </div>
          </div>
        </div>

        {/* Pay Button */}
        <Button
          onClick={handlePayment}
          disabled={processing}
          size="lg"
          className="w-full bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white"
        >
          {processing ? (
            <>
              <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2" />
              Processing...
            </>
          ) : (
            <>
              <Lock className="w-4 h-4 mr-2" />
              Pay ${amount !== undefined ? amount.toLocaleString() : "Now"}
            </>
          )}
        </Button>

        {/* Security Notice */}
        <div className="flex items-start gap-2 p-3 bg-blue-50 dark:bg-blue-950/20 rounded-lg border border-blue-200 dark:border-blue-800">
          <Check className="w-4 h-4 text-blue-600 dark:text-blue-400 mt-0.5 flex-shrink-0" />
          <div className="text-xs text-blue-700 dark:text-blue-300">
            <p className="font-semibold mb-1">Secure Test Payment</p>
            <p className="text-muted-foreground">
              This is a demo payment. No real money will be charged. The payment will be simulated for testing purposes only.
            </p>
          </div>
        </div>

        {/* Test Card Numbers */}
        <div className="p-3 bg-gray-50 dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-800">
          <p className="text-xs font-semibold mb-2">Test Card Numbers:</p>
          <div className="space-y-1 text-xs text-muted-foreground">
            <p>• 4242 4242 4242 4242 (Visa - Success)</p>
            <p>• 4000 0000 0000 0002 (Card Declined)</p>
            <p>• Any future expiry date (e.g., 12/28)</p>
            <p>• Any 3-digit CVV code</p>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
