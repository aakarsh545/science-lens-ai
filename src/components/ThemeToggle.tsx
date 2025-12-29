import { Moon, Sun } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useEffect, useState } from "react";
import { User } from "@supabase/supabase-js";

interface ThemeToggleProps {
  user?: User | null;
}

export default function ThemeToggle({ user }: ThemeToggleProps) {
  const [theme, setTheme] = useState<"dark" | "light">("dark");

  // Get user-scoped localStorage key
  const getThemeKey = () => {
    return user ? `theme_${user.id}` : "theme";
  };

  useEffect(() => {
    // Load theme for current user
    const themeKey = getThemeKey();
    const savedTheme = localStorage.getItem(themeKey) as "dark" | "light" | null;
    if (savedTheme) {
      setTheme(savedTheme);
      document.documentElement.classList.toggle("light", savedTheme === "light");
    }
  }, [user]);

  const toggleTheme = () => {
    const newTheme = theme === "dark" ? "light" : "dark";
    setTheme(newTheme);
    const themeKey = getThemeKey();
    localStorage.setItem(themeKey, newTheme);
    document.documentElement.classList.toggle("light", newTheme === "light");
  };

  return (
    <Button
      variant="ghost"
      size="icon"
      onClick={toggleTheme}
      className="rounded-full"
    >
      {theme === "dark" ? (
        <Sun className="h-5 w-5" />
      ) : (
        <Moon className="h-5 w-5" />
      )}
    </Button>
  );
}