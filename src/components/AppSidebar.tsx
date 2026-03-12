import {
  MessageSquare,
  Compass,
  GraduationCap,
  Target,
  Trophy,
  Settings as SettingsIcon,
  LogOut,
  User,
  Award
} from "lucide-react";
import { useLocation, useNavigate } from "react-router-dom";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarFooter,
} from "@/components/ui/sidebar";
import { supabase } from "@/integrations/supabase/client";
import { useToast } from "@/hooks/use-toast";
import { clearUserDataById } from "@/utils/userStorage";

const menuItems = [
  { title: "Home", icon: Compass, path: "/dashboard" },
  { title: "Learning", icon: GraduationCap, path: "/learning" },
  { title: "Profile", icon: User, path: "/profile" },
  { title: "Settings", icon: SettingsIcon, path: "/settings" },
];

interface AppSidebarProps {
  userId: string;
  conversationId: string | null;
  onSelectConversation: (conversationId: string) => void;
  onNewConversation: () => void;
}

export function AppSidebar({ userId, conversationId, onSelectConversation, onNewConversation }: AppSidebarProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { toast } = useToast();

  const handleSignOut = async () => {
    // Clear user-specific localStorage before signing out
    clearUserDataById(userId);
    const { error } = await supabase.auth.signOut();
    if (error) {
      toast({
        title: "Error",
        description: "Failed to sign out",
        variant: "destructive",
      });
    } else {
      navigate("/");
    }
  };

  return (
    <Sidebar collapsible="icon">
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel className="text-lg font-bold">Scico</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {menuItems.map((item) => {
                const isActive = location.pathname === item.path;
                return (
                  <SidebarMenuItem key={item.title}>
                    <SidebarMenuButton
                      asChild
                      isActive={isActive}
                      onClick={() => navigate(item.path)}
                    >
                      <button className="w-full flex items-center gap-3" aria-label={`Navigate to ${item.title}`}>
                        <item.icon className="h-5 w-5" aria-hidden="true" />
                        <span>{item.title}</span>
                      </button>
                    </SidebarMenuButton>
                  </SidebarMenuItem>
                );
              })}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

      </SidebarContent>
      <SidebarFooter>
        <SidebarMenu>
          <SidebarMenuItem>
            <SidebarMenuButton onClick={handleSignOut} aria-label="Sign out of your account">
              <LogOut className="h-5 w-5" aria-hidden="true" />
              <span>Sign Out</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  );
}
