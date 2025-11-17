export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "13.0.5"
  }
  public: {
    Tables: {
      achievements: {
        Row: {
          achievement_type: string
          category: string | null
          description: string | null
          earned_at: string
          icon: string | null
          id: string
          points: number | null
          title: string
          user_id: string
        }
        Insert: {
          achievement_type: string
          category?: string | null
          description?: string | null
          earned_at?: string
          icon?: string | null
          id?: string
          points?: number | null
          title: string
          user_id: string
        }
        Update: {
          achievement_type?: string
          category?: string | null
          description?: string | null
          earned_at?: string
          icon?: string | null
          id?: string
          points?: number | null
          title?: string
          user_id?: string
        }
        Relationships: []
      }
      admin_credit_logs: {
        Row: {
          admin_user_id: string
          created_at: string | null
          credits_adjusted: number
          id: string
          reason: string | null
          target_user_id: string
        }
        Insert: {
          admin_user_id: string
          created_at?: string | null
          credits_adjusted: number
          id?: string
          reason?: string | null
          target_user_id: string
        }
        Update: {
          admin_user_id?: string
          created_at?: string | null
          credits_adjusted?: number
          id?: string
          reason?: string | null
          target_user_id?: string
        }
        Relationships: []
      }
      bookmarks: {
        Row: {
          created_at: string
          id: string
          notes: string | null
          question_id: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          notes?: string | null
          question_id: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          notes?: string | null
          question_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "bookmarks_question_id_fkey"
            columns: ["question_id"]
            isOneToOne: false
            referencedRelation: "questions"
            referencedColumns: ["id"]
          },
        ]
      }
      conversations: {
        Row: {
          created_at: string
          id: string
          title: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          title?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          title?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      daily_streaks: {
        Row: {
          created_at: string
          date: string
          id: string
          questions_answered: number | null
          streak_maintained: boolean | null
          user_id: string
        }
        Insert: {
          created_at?: string
          date?: string
          id?: string
          questions_answered?: number | null
          streak_maintained?: boolean | null
          user_id: string
        }
        Update: {
          created_at?: string
          date?: string
          id?: string
          questions_answered?: number | null
          streak_maintained?: boolean | null
          user_id?: string
        }
        Relationships: []
      }
      learning_topics: {
        Row: {
          category: string
          created_at: string
          description: string | null
          difficulty_level: string | null
          icon: string | null
          id: string
          name: string
          order_index: number | null
        }
        Insert: {
          category: string
          created_at?: string
          description?: string | null
          difficulty_level?: string | null
          icon?: string | null
          id?: string
          name: string
          order_index?: number | null
        }
        Update: {
          category?: string
          created_at?: string
          description?: string | null
          difficulty_level?: string | null
          icon?: string | null
          id?: string
          name?: string
          order_index?: number | null
        }
        Relationships: []
      }
      messages: {
        Row: {
          content: string
          conversation_id: string
          created_at: string
          id: string
          role: string
          user_id: string
        }
        Insert: {
          content: string
          conversation_id: string
          created_at?: string
          id?: string
          role: string
          user_id: string
        }
        Update: {
          content?: string
          conversation_id?: string
          created_at?: string
          id?: string
          role?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "messages_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          avatar_url: string | null
          bio: string | null
          created_at: string
          credits: number | null
          current_topic: string | null
          display_name: string | null
          id: string
          last_credit_purchase: string | null
          learning_progress: Json | null
          level: number | null
          streak_count: number | null
          total_credits_purchased: number | null
          total_questions: number | null
          updated_at: string
          user_id: string
          xp_points: number | null
        }
        Insert: {
          avatar_url?: string | null
          bio?: string | null
          created_at?: string
          credits?: number | null
          current_topic?: string | null
          display_name?: string | null
          id?: string
          last_credit_purchase?: string | null
          learning_progress?: Json | null
          level?: number | null
          streak_count?: number | null
          total_credits_purchased?: number | null
          total_questions?: number | null
          updated_at?: string
          user_id: string
          xp_points?: number | null
        }
        Update: {
          avatar_url?: string | null
          bio?: string | null
          created_at?: string
          credits?: number | null
          current_topic?: string | null
          display_name?: string | null
          id?: string
          last_credit_purchase?: string | null
          learning_progress?: Json | null
          level?: number | null
          streak_count?: number | null
          total_credits_purchased?: number | null
          total_questions?: number | null
          updated_at?: string
          user_id?: string
          xp_points?: number | null
        }
        Relationships: []
      }
      questions: {
        Row: {
          ai_response: string | null
          created_at: string
          difficulty_level: string | null
          id: string
          is_correct: boolean | null
          question_text: string
          topic: string
          user_id: string
        }
        Insert: {
          ai_response?: string | null
          created_at?: string
          difficulty_level?: string | null
          id?: string
          is_correct?: boolean | null
          question_text: string
          topic: string
          user_id: string
        }
        Update: {
          ai_response?: string | null
          created_at?: string
          difficulty_level?: string | null
          id?: string
          is_correct?: boolean | null
          question_text?: string
          topic?: string
          user_id?: string
        }
        Relationships: []
      }
      study_sessions: {
        Row: {
          duration_minutes: number | null
          ended_at: string | null
          id: string
          questions_answered: number | null
          started_at: string
          topic_id: string | null
          user_id: string
          xp_earned: number | null
        }
        Insert: {
          duration_minutes?: number | null
          ended_at?: string | null
          id?: string
          questions_answered?: number | null
          started_at?: string
          topic_id?: string | null
          user_id: string
          xp_earned?: number | null
        }
        Update: {
          duration_minutes?: number | null
          ended_at?: string | null
          id?: string
          questions_answered?: number | null
          started_at?: string
          topic_id?: string | null
          user_id?: string
          xp_earned?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "study_sessions_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "learning_topics"
            referencedColumns: ["id"]
          },
        ]
      }
      user_roles: {
        Row: {
          created_at: string
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
      user_topic_progress: {
        Row: {
          completion_percentage: number | null
          correct_answers: number | null
          created_at: string
          id: string
          last_practiced_at: string | null
          questions_answered: number | null
          topic_id: string
          updated_at: string
          user_id: string
        }
        Insert: {
          completion_percentage?: number | null
          correct_answers?: number | null
          created_at?: string
          id?: string
          last_practiced_at?: string | null
          questions_answered?: number | null
          topic_id: string
          updated_at?: string
          user_id: string
        }
        Update: {
          completion_percentage?: number | null
          correct_answers?: number | null
          created_at?: string
          id?: string
          last_practiced_at?: string | null
          questions_answered?: number | null
          topic_id?: string
          updated_at?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_topic_progress_topic_id_fkey"
            columns: ["topic_id"]
            isOneToOne: false
            referencedRelation: "learning_topics"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      add_credits: {
        Args: {
          p_admin_id?: string
          p_amount: number
          p_reason?: string
          p_user_id: string
        }
        Returns: undefined
      }
      deduct_credits: {
        Args: { p_amount: number; p_user_id: string }
        Returns: boolean
      }
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"]
          _user_id: string
        }
        Returns: boolean
      }
    }
    Enums: {
      app_role: "admin" | "moderator" | "user"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      app_role: ["admin", "moderator", "user"],
    },
  },
} as const
