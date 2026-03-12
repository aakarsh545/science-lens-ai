import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Trophy, Lock, Star } from "lucide-react";

interface Achievement {
  id: string;
  title: string;
  description: string;
  achievement_type: string;
  icon: string;
  category: string;
  points: number;
  earned_at: string;
}

interface AchievementsGridProps {
  achievements: Achievement[];
}

// All possible achievements with their criteria
const ALL_ACHIEVEMENTS = [
  {
    id: "first_lesson",
    title: "First Lesson",
    description: "Complete your first lesson",
    icon: "📚",
    category: "Learning",
    points: 50,
    requirement: "Complete 1 lesson",
  },
  {
    id: "week_warrior",
    title: "Week Warrior",
    description: "Maintain a 7-day learning streak",
    icon: "🔥",
    category: "Streaks",
    points: 100,
    requirement: "7-day streak",
  },
  {
    id: "month_master",
    title: "Month Master",
    description: "Maintain a 30-day learning streak",
    icon: "⚡",
    category: "Streaks",
    points: 500,
    requirement: "30-day streak",
  },
  {
    id: "physics_master",
    title: "Physics Master",
    description: "Complete all Physics lessons",
    icon: "⚛️",
    category: "Learning",
    points: 200,
    requirement: "100% Physics completion",
  },
  {
    id: "chemistry_master",
    title: "Chemistry Master",
    description: "Complete all Chemistry lessons",
    icon: "🧪",
    category: "Learning",
    points: 200,
    requirement: "100% Chemistry completion",
  },
  {
    id: "biology_master",
    title: "Biology Master",
    description: "Complete all Biology lessons",
    icon: "🧬",
    category: "Learning",
    points: 200,
    requirement: "100% Biology completion",
  },
  {
    id: "challenge_champion",
    title: "Challenge Champion",
    description: "Complete 10 challenges",
    icon: "🏆",
    category: "Challenges",
    points: 300,
    requirement: "Complete 10 challenges",
  },
  {
    id: "perfect_score",
    title: "Perfect Score",
    description: "Score 100% on any quiz",
    icon: "💯",
    category: "Quizzes",
    points: 150,
    requirement: "100% quiz score",
  },
  {
    id: "quiz_master",
    title: "Quiz Master",
    description: "Complete 50 quizzes",
    icon: "📝",
    category: "Quizzes",
    points: 250,
    requirement: "Complete 50 quizzes",
  },
  {
    id: "knowledge_seeker",
    title: "Knowledge Seeker",
    description: "Answer 100 questions",
    icon: "🎯",
    category: "Learning",
    points: 200,
    requirement: "Answer 100 questions",
  },
  {
    id: "xp_collector",
    title: "XP Collector",
    description: "Earn 1000 total XP",
    icon: "⭐",
    category: "Learning",
    points: 100,
    requirement: "Earn 1000 XP",
  },
  {
    id: "xp_legend",
    title: "XP Legend",
    description: "Earn 10000 total XP",
    icon: "🌟",
    category: "Learning",
    points: 500,
    requirement: "Earn 10000 XP",
  },
];

export default function AchievementsGrid({ achievements }: AchievementsGridProps) {
  const [selectedCategory, setSelectedCategory] = useState<string>("all");
  const [selectedAchievement, setSelectedAchievement] = useState<typeof ALL_ACHIEVEMENTS[0] | null>(null);

  const categories = ["all", ...Array.from(new Set(ALL_ACHIEVEMENTS.map((a) => a.category)))];

  const unlockedIds = new Set(achievements.map((a) => a.achievement_type));

  const filteredAchievements = ALL_ACHIEVEMENTS.filter((achievement) => {
    if (selectedCategory === "all") return true;
    return achievement.category === selectedCategory;
  });

  const totalPoints = achievements.reduce((sum, a) => sum + (a.points || 0), 0);
  const unlockedCount = achievements.length;
  const totalAchievements = ALL_ACHIEVEMENTS.length;
  const completionPercentage = Math.round((unlockedCount / totalAchievements) * 100);

  return (
    <Card className="card-cosmic">
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="flex items-center gap-2">
              <Trophy className="h-5 w-5 text-yellow-500" />
              Achievements
            </CardTitle>
            <CardDescription>
              {unlockedCount} of {totalAchievements} unlocked ({completionPercentage}%)
            </CardDescription>
          </div>
          <div className="text-right">
            <p className="text-sm text-muted-foreground">Total Points</p>
            <p className="text-2xl font-bold text-primary">{totalPoints}</p>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        {/* Category Filter */}
        <div className="flex flex-wrap gap-2 mb-6">
          {categories.map((category) => (
            <Badge
              key={category}
              variant={selectedCategory === category ? "default" : "outline"}
              className="cursor-pointer capitalize"
              onClick={() => setSelectedCategory(category)}
            >
              {category}
            </Badge>
          ))}
        </div>

        {/* Achievements Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredAchievements.map((achievement) => {
            const isUnlocked = unlockedIds.has(achievement.id);

            return (
              <Dialog key={achievement.id}>
                <DialogTrigger asChild>
                  <Card
                    className={`cursor-pointer transition-all hover:scale-105 ${
                      isUnlocked
                        ? "bg-gradient-to-br from-yellow-500/10 to-orange-500/10 border-yellow-500/30"
                        : "bg-muted/30 border-muted opacity-60"
                    }`}
                    onClick={() => setSelectedAchievement(achievement)}
                  >
                    <CardContent className="p-4">
                      <div className="flex items-start gap-3">
                        <div className="text-4xl">{achievement.icon}</div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <h3 className="font-semibold truncate">{achievement.title}</h3>
                            {!isUnlocked && <Lock className="h-3 w-3 text-muted-foreground flex-shrink-0" />}
                          </div>
                          <p className="text-sm text-muted-foreground line-clamp-2">
                            {achievement.description}
                          </p>
                          <div className="flex items-center gap-2 mt-2">
                            <Badge variant="secondary" className="text-xs">
                              {achievement.category}
                            </Badge>
                            <Badge variant="outline" className="text-xs">
                              +{achievement.points} XP
                            </Badge>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </DialogTrigger>
                <DialogContent>
                  <DialogHeader>
                    <div className="flex items-center gap-4 mb-2">
                      <div className="text-6xl">{achievement.icon}</div>
                      <div>
                        <DialogTitle className="text-2xl">{achievement.title}</DialogTitle>
                        {!isUnlocked && (
                          <div className="flex items-center gap-2 mt-1">
                            <Lock className="h-4 w-4 text-muted-foreground" />
                            <span className="text-sm text-muted-foreground">Locked</span>
                          </div>
                        )}
                      </div>
                    </div>
                    <DialogDescription className="text-base">
                      {achievement.description}
                    </DialogDescription>
                  </DialogHeader>
                  <div className="space-y-4">
                    <div>
                      <p className="text-sm font-semibold mb-1">Requirement</p>
                      <p className="text-sm text-muted-foreground">{achievement.requirement}</p>
                    </div>
                    <div className="flex gap-4">
                      <div>
                        <p className="text-sm font-semibold mb-1">Category</p>
                        <Badge variant="secondary">{achievement.category}</Badge>
                      </div>
                      <div>
                        <p className="text-sm font-semibold mb-1">Reward</p>
                        <Badge variant="outline" className="text-primary">
                          +{achievement.points} XP
                        </Badge>
                      </div>
                    </div>
                    {isUnlocked && (
                      <div className="p-3 rounded-lg bg-green-500/10 border border-green-500/30">
                        <div className="flex items-center gap-2 text-green-600 dark:text-green-400">
                          <Star className="h-4 w-4" />
                          <span className="font-semibold">Unlocked!</span>
                        </div>
                      </div>
                    )}
                  </div>
                </DialogContent>
              </Dialog>
            );
          })}
        </div>

        {achievements.length === 0 && (
          <div className="text-center py-8 text-muted-foreground">
            <Trophy className="h-12 w-12 mx-auto mb-3 opacity-50" />
            <p>No achievements yet. Start learning to unlock them!</p>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
