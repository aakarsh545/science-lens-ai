import { User } from "@supabase/supabase-js";
import { GamificationBar } from "./GamificationBar";
import { ProgressDashboard } from "./ProgressDashboard";
import { CourseRecommendations } from "./CourseRecommendations";

interface DashboardViewProps {
  user: User;
}

export function DashboardView({ user }: DashboardViewProps) {
  return (
    <div className="p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold mb-2">Dashboard</h1>
        <p className="text-muted-foreground">
          Track your learning progress and discover new courses
        </p>
      </div>

      <GamificationBar userId={user.id} />

      <CourseRecommendations userId={user.id} />

      <ProgressDashboard userId={user.id} />
    </div>
  );
}