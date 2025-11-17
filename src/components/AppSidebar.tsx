import { 
  LayoutDashboard, 
  MessageSquare, 
  BookOpen, 
  Compass, 
  Library,
  TestTube, 
  CreditCard,
  GraduationCap,
  Trophy, 
  Settings as SettingsIcon, 
  LogOut 
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
  { title: "Dashboard", icon: LayoutDashboard, path: "/dashboard" },
  { title: "Learn Science", icon: GraduationCap, path: "/learn-science" },
  { title: "Ask Questions", icon: MessageSquare, path: "/ask" },
  { title: "Explore", icon: Compass, path: "/explore" },
  { title: "All Topics", icon: Library, path: "/topics" },
  { title: "API Test", icon: TestTube, path: "/api-test" },
  { title: "Pricing", icon: CreditCard, path: "/pricing" },
  { title: "Achievements", icon: Trophy, path: "/achievements" },
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
                      <button className="w-full flex items-center gap-3">
                        <item.icon className="h-5 w-5" />
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
            <SidebarMenuButton onClick={handleSignOut}>
              <LogOut className="h-5 w-5" />
              <span>Sign Out</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  );
}