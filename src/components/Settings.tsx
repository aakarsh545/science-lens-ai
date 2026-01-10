import { motion } from "framer-motion";
import { Card } from "@/components/ui/card";
import { CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ChevronRight, User } from "lucide-react";
import { useNavigate } from "react-router-dom";

const Settings = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-2xl mx-auto space-y-6">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <h1 className="text-3xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
            Settings
          </h1>
          <p className="text-muted-foreground">Customize your learning experience</p>
        </motion.div>

        <Card>
          <CardContent className="p-0">
            <Button
              variant="ghost"
              className="w-full justify-start rounded-none px-6 py-4 hover:bg-muted/50"
              onClick={() => navigate("/settings/account")}
            >
              <User className="mr-3 h-5 w-5" />
              <div className="flex-1 text-left">
                <div className="font-medium">Account Information</div>
                <div className="text-sm text-muted-foreground">View your account details</div>
              </div>
              <ChevronRight className="h-5 w-5 text-muted-foreground" />
            </Button>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default Settings;
