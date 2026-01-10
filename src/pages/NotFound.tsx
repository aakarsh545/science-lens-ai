import { useLocation, useNavigate } from "react-router-dom";
import { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Home, Compass } from "lucide-react";

const NotFound = () => {
  const location = useLocation();
  const navigate = useNavigate();

  useEffect(() => {
    console.error("404 Error: User attempted to access non-existent route:", location.pathname);
  }, [location.pathname]);

  return (
    <div className="flex min-h-screen items-center justify-center bg-gradient-cosmic">
      <div className="text-center px-4">
        <div className="mb-8 flex justify-center">
          <div className="relative">
            <div className="absolute inset-0 bg-primary/20 blur-3xl rounded-full" />
            <div className="relative bg-gradient-to-br from-primary to-purple-500 p-8 rounded-3xl">
              <h1 className="text-6xl font-bold text-white">404</h1>
            </div>
          </div>
        </div>
        <h2 className="mb-4 text-3xl font-bold bg-gradient-cosmic bg-clip-text text-transparent">
          Page Not Found
        </h2>
        <p className="mb-8 text-xl text-muted-foreground max-w-md mx-auto">
          Oops! The page you're looking for doesn't exist or has been moved.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <Button
            onClick={() => navigate("/")}
            size="lg"
            className="bg-primary hover:bg-primary/90"
          >
            <Home className="w-5 h-5 mr-2" />
            Go to Home
          </Button>
          <Button
            onClick={() => navigate("/")}
            size="lg"
            variant="outline"
          >
            <Compass className="w-5 h-5 mr-2" />
            Go to Dashboard
          </Button>
        </div>
      </div>
    </div>
  );
};

export default NotFound;
