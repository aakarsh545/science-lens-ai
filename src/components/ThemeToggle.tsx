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

  // Force apply theme to DOM
  const applyThemeToDOM = (themeValue: "dark" | "light") => {
    // Clear any existing theme classes first
    document.documentElement.classList.remove("light");
    // Apply the new theme
    if (themeValue === "light") {
      document.documentElement.classList.add("light");
    }
  };

  useEffect(() => {
    // Load theme for current user and force apply to DOM
    try {
      const themeKey = getThemeKey();
      const savedTheme = localStorage.getItem(themeKey) as "dark" | "light" | null;

      // Default to dark if no saved theme
      const themeToApply = savedTheme || "dark";

      setTheme(themeToApply);
      applyThemeToDOM(themeToApply);
    } catch (error) {
      console.warn('localStorage not available:', error);
      // Default to dark theme if localStorage fails
      setTheme("dark");
      applyThemeToDOM("dark");
    }
  }, [user]); // Re-run whenever user changes

  const toggleTheme = () => {
    const newTheme = theme === "dark" ? "light" : "dark";
    setTheme(newTheme);
    const themeKey = getThemeKey();
    try {
      localStorage.setItem(themeKey, newTheme);
    } catch (error) {
      console.warn('localStorage not available, theme will not persist:', error);
    }
    applyThemeToDOM(newTheme);
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