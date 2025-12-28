import { useState, useEffect, useCallback } from "react";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { MessageSquare, Trash2, Edit2, Plus } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Input } from "@/components/ui/input";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";

interface Conversation {
  id: string;
  title: string;
  created_at: string;
  updated_at: string;
}

interface ConversationsListProps {
  userId: string;
  currentConversationId: string | null;
  onSelectConversation: (conversationId: string) => void;
  onNewConversation: () => void;
}

export function ConversationsList({
  userId,
  currentConversationId,
  onSelectConversation,
  onNewConversation,
}: ConversationsListProps) {
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editTitle, setEditTitle] = useState("");
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  const loadConversations = useCallback(async () => {
    setLoading(true);
    const { data } = await supabase
      .from("conversations")
      .select("*")
      .eq("user_id", userId)
      .order("updated_at", { ascending: false });

    if (data) {
      setConversations(data);
    }
    setLoading(false);
  }, [userId]);

  useEffect(() => {
    loadConversations();

    const channel = supabase
      .channel("conversations-changes")
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "conversations",
          filter: `user_id=eq.${userId}`,
        },
        () => {
          loadConversations();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [userId, loadConversations]);

  const handleRename = async (id: string) => {
    if (!editTitle.trim()) return;

    const { error } = await supabase
      .from("conversations")
      .update({ title: editTitle.trim() })
      .eq("id", id)
      .eq("user_id", userId);

    if (error) {
      toast({
        title: "Error",
        description: "Failed to rename conversation",
        variant: "destructive",
      });
    } else {
      toast({ title: "Conversation renamed" });
      setEditingId(null);
      setEditTitle("");
    }
  };

  const handleDelete = async () => {
    if (!deleteId) return;

    const { error } = await supabase
      .from("conversations")
      .delete()
      .eq("id", deleteId)
      .eq("user_id", userId);

    if (error) {
      toast({
        title: "Error",
        description: "Failed to delete conversation",
        variant: "destructive",
      });
    } else {
      toast({ title: "Conversation deleted" });
      if (currentConversationId === deleteId) {
        onNewConversation();
      }
    }
    setDeleteId(null);
  };

  const startEdit = (conv: Conversation) => {
    setEditingId(conv.id);
    setEditTitle(conv.title);
  };

  return (
    <div className="flex flex-col h-full">
      <div className="space-y-1 flex-1 overflow-y-auto p-2">
        <Button
          onClick={onNewConversation}
          className="w-full mb-2"
          variant="default"
          size="sm"
        >
          <Plus className="h-4 w-4 mr-2" />
          New Chat
        </Button>

        {loading ? (
          // Skeleton loader
          <>
            {[...Array(5)].map((_, i) => (
              <div
                key={`skeleton-${i}`}
                className="animate-pulse rounded-md border border-muted bg-muted/50 p-2 mb-2"
              >
                <div className="flex items-center gap-2">
                  <div className="h-3.5 w-3.5 bg-muted-foreground/20 rounded" />
                  <div className="flex-1 h-4 bg-muted-foreground/20 rounded" />
                </div>
              </div>
            ))}
          </>
        ) : (
          conversations.map((conv) => {
          const isActive = conv.id === currentConversationId;
          const isEditing = editingId === conv.id;

          return (
            <div
              key={conv.id}
              className={`group relative rounded-md transition-colors ${
                isActive
                  ? "bg-primary/10 border-primary"
                  : "hover:bg-muted border-transparent"
              } border`}
            >
              {isEditing ? (
                <div className="p-2 space-y-2">
                  <Input
                    value={editTitle}
                    onChange={(e) => setEditTitle(e.target.value)}
                    onKeyDown={(e) => {
                      if (e.key === "Enter") handleRename(conv.id);
                      if (e.key === "Escape") {
                        setEditingId(null);
                        setEditTitle("");
                      }
                    }}
                    autoFocus
                    className="text-sm h-7"
                  />
                  <div className="flex gap-1">
                    <Button
                      size="sm"
                      onClick={() => handleRename(conv.id)}
                      className="flex-1 h-7 text-xs"
                    >
                      Save
                    </Button>
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => {
                        setEditingId(null);
                        setEditTitle("");
                      }}
                      className="flex-1 h-7 text-xs"
                    >
                      Cancel
                    </Button>
                  </div>
                </div>
              ) : (
                <button
                  onClick={() => onSelectConversation(conv.id)}
                  className="w-full text-left p-2 flex items-center gap-2"
                >
                  <MessageSquare className="h-3.5 w-3.5 flex-shrink-0" />
                  <div className="flex-1 min-w-0">
                    <div className="font-medium text-sm truncate">
                      {conv.title || "New Chat"}
                    </div>
                  </div>
                  <div className="flex gap-0.5 opacity-0 group-hover:opacity-100 transition-opacity">
                    <Button
                      size="icon"
                      variant="ghost"
                      className="h-6 w-6"
                      onClick={(e) => {
                        e.stopPropagation();
                        startEdit(conv);
                      }}
                      aria-label="Rename conversation"
                    >
                      <Edit2 className="h-3 w-3" aria-hidden="true" />
                    </Button>
                    <Button
                      size="icon"
                      variant="ghost"
                      className="h-6 w-6 text-destructive hover:text-destructive"
                      onClick={(e) => {
                        e.stopPropagation();
                        setDeleteId(conv.id);
                      }}
                      aria-label="Delete conversation"
                    >
                      <Trash2 className="h-3 w-3" aria-hidden="true" />
                    </Button>
                  </div>
                </button>
              )}
            </div>
          );
        })
        )}

        {!loading && conversations.length === 0 && (
          <div className="text-center py-8 text-muted-foreground text-sm">
            No conversations yet
          </div>
        )}
      </div>

      <AlertDialog open={!!deleteId} onOpenChange={() => setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete Conversation</AlertDialogTitle>
            <AlertDialogDescription>
              Are you sure? This will permanently delete this conversation and all its messages.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
              Delete
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
