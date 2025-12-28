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
import { ConversationsList } from "./ConversationsList";
import { Separator } from "@/components/ui/separator";

const menuItems = [
  { title: "Home", icon: Compass, path: "/science-lens" },
  { title: "Learning", icon: GraduationCap, path: "/science-lens/learning" },
  { title: "Challenges", icon: Target, path: "/science-lens/challenges" },
  { title: "Leaderboard", icon: Award, path: "/science-lens/leaderboard" },
  { title: "Ask Questions", icon: MessageSquare, path: "/science-lens/ask" },
  { title: "Profile", icon: User, path: "/science-lens/profile" },
  { title: "Achievements", icon: Trophy, path: "/science-lens/achievements" },
  { title: "Settings", icon: SettingsIcon, path: "/science-lens/settings" },
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
          <SidebarGroupLabel className="text-lg font-bold">Science Lens</SidebarGroupLabel>
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

        <Separator className="my-2" />

        <SidebarGroup className="flex-1 overflow-hidden">
          <SidebarGroupLabel>Saved Chats</SidebarGroupLabel>
          <SidebarGroupContent className="h-full overflow-hidden">
            <ConversationsList 
              userId={userId}
              currentConversationId={conversationId}
              onSelectConversation={onSelectConversation}
              onNewConversation={onNewConversation}
            />
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