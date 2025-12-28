import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Sparkles, ArrowRight, BookOpen, TrendingUp } from "lucide-react";

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  category: string;
  difficulty: string;
  lessonCount: number;
}

interface Recommendation {
  course: Course;
  reason: string;
  score: number;
}

interface CourseRecommendationsProps {
  userId: string;
}

// Topic to course mapping based on course content and categories
const topicCourseMapping: Record<string, string[]> = {
  // Physics topics
  "physics": ["basic-physics", "thermodynamics", "quantum-mechanics", "astrophysics"],
  "forces": ["basic-physics"],
  "motion": ["basic-physics"],
  "energy": ["basic-physics", "thermodynamics"],
  "thermodynamics": ["thermodynamics", "basic-physics"],
  "heat": ["thermodynamics", "basic-physics"],
  "quantum": ["quantum-mechanics", "basic-physics"],
  "quantum mechanics": ["quantum-mechanics", "basic-physics"],
  "astrophysics": ["astrophysics", "astronomy"],
  "space": ["astrophysics", "astronomy", "planetary-science"],
  "stars": ["astrophysics", "astronomy"],

  // Chemistry topics
  "chemistry": ["chemistry-basics", "organic-chemistry", "biochemistry"],
  "atoms": ["chemistry-basics", "basic-physics"],
  "elements": ["chemistry-basics"],
  "reactions": ["chemistry-basics", "organic-chemistry"],
  "organic": ["organic-chemistry", "chemistry-basics"],
  "molecules": ["chemistry-basics", "organic-chemistry", "biochemistry"],
  "biochemistry": ["biochemistry", "chemistry-basics", "organic-chemistry"],

  // Biology topics
  "biology": ["cell-biology", "genetics", "ecology", "neurobiology", "biochemistry"],
  "cell": ["cell-biology", "biochemistry"],
  "cells": ["cell-biology", "biochemistry"],
  "genetics": ["genetics", "cell-biology"],
  "dna": ["genetics", "cell-biology", "biochemistry"],
  "ecology": ["ecology", "environmental-science"],
  "environment": ["environmental-science", "ecology"],
  "neurobiology": ["neurobiology", "cell-biology"],
  "brain": ["neurobiology", "cell-biology"],

  // Astronomy topics
  "astronomy": ["astronomy", "astrophysics", "planetary-science"],
  "universe": ["astrophysics", "astronomy"],
  "planets": ["planetary-science", "astronomy"],
  "solar": ["astronomy", "planetary-science"],

  // General science
  "science": ["general-science", "basic-physics", "chemistry-basics", "cell-biology"],
  "evolution": ["origins", "cell-biology", "genetics"],
  "origin": ["origins", "astronomy", "cell-biology"],
};

export function CourseRecommendations({ userId }: CourseRecommendationsProps) {
  const [recommendations, setRecommendations] = useState<Recommendation[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const loadRecommendations = useCallback(async () => {
    try {
      // Fetch all data in parallel for better performance
      const [coursesResult, lessonsResult, progressResult, questionsResult, messagesResult, profileResult] = await Promise.all([
        supabase.from("courses").select("id, slug, title, description, category, difficulty"),
        supabase.from("lessons").select("id, course_id"),
        supabase.from("user_progress").select("lesson_id, status").eq("user_id", userId),
        supabase.from("questions").select("question_text, topic, difficulty_level, created_at").eq("user_id", userId).order("created_at", { ascending: false }).limit(20),
        supabase.from("messages").select("content, role, created_at").eq("user_id", userId).order("created_at", { ascending: false }).limit(10),
        supabase.from("profiles").select("current_topic").eq("user_id", userId).single(),
      ]);

      const courses = coursesResult.data;
      const lessons = lessonsResult.data;
      const progress = progressResult.data;
      const questions = questionsResult.data || [];
      const messages = messagesResult.data || [];
      const profile = profileResult.data;

      if (!courses || !lessons) {
        setLoading(false);
        return;
      }

      // Create course map with lesson counts and difficulty
      const courseMap = courses.reduce((acc, course) => {
        const lessonCount = lessons.filter((l) => l.course_id === course.id).length;
        acc[course.slug] = { ...course, lessonCount, difficulty: course.difficulty || 'beginner' };
        return acc;
      }, {} as Record<string, Course>);

      // Calculate course completion status
      const completedLessonIds = new Set(
        progress?.filter((p) => p.status === "completed").map((p) => p.lesson_id) || []
      );

      const courseProgress = courses.map((course) => {
        const courseLessons = lessons.filter((l) => l.course_id === course.id);
        const completed = courseLessons.filter((l) => completedLessonIds.has(l.id)).length;
        return {
          slug: course.slug,
          category: course.category,
          difficulty: course.difficulty || 'beginner',
          completed,
          total: courseLessons.length,
          isComplete: completed === courseLessons.length && courseLessons.length > 0,
          isStarted: completed > 0,
          percentage: courseLessons.length > 0 ? (completed / courseLessons.length) * 100 : 0,
        };
      });

      // Analyze user's question topics and interests
      const topicFrequency: Record<string, number> = {};
      const recentUserMessages = messages.filter(m => m.role === 'user').map(m => m.content.toLowerCase());

      // Count topics from questions
      questions.forEach((q) => {
        const topic = q.topic?.toLowerCase() || '';
        if (topic) {
          topicFrequency[topic] = (topicFrequency[topic] || 0) + 2; // Higher weight for explicit topics
        }

        // Also analyze question text for keywords
        const questionText = q.question_text?.toLowerCase() || '';
        Object.keys(topicCourseMapping).forEach((keyword) => {
          if (questionText.includes(keyword)) {
            topicFrequency[keyword] = (topicFrequency[keyword] || 0) + 1;
          }
        });
      });

      // Analyze recent conversation messages for topics
      recentUserMessages.forEach((msg) => {
        Object.keys(topicCourseMapping).forEach((keyword) => {
          if (msg.includes(keyword)) {
            topicFrequency[keyword] = (topicFrequency[keyword] || 0) + 1;
          }
        });
      });

      // Add current topic from profile
      if (profile?.current_topic) {
        topicFrequency[profile.current_topic] = (topicFrequency[profile.current_topic] || 0) + 3;
      }

      // Find most interested topics
      const topTopics = Object.entries(topicFrequency)
        .sort(([, a], [, b]) => b - a)
        .slice(0, 5)
        .map(([topic]) => topic);

      // Find completed and in-progress courses
      const completedCourses = courseProgress.filter((c) => c.isComplete).map((c) => c.slug);
      const inProgressCourses = courseProgress.filter((c) => c.isStarted && !c.isComplete);
      const notStartedCourses = courseProgress.filter((c) => !c.isStarted);

      // Generate recommendations based on data
      const recs: Recommendation[] = [];
      const recommendedSlugs = new Set<string>();

      // 1. Continue in-progress courses (highest priority)
      inProgressCourses
        .sort((a, b) => b.percentage - a.percentage)
        .slice(0, 2)
        .forEach((course) => {
          if (courseMap[course.slug] && !recommendedSlugs.has(course.slug)) {
            recs.push({
              course: courseMap[course.slug],
              reason: `Continue where you left off (${Math.round(course.percentage)}% complete)`,
              score: 100 + course.percentage,
            });
            recommendedSlugs.add(course.slug);
          }
        });

      // 2. Recommend courses based on user's question topics
      topTopics.forEach((topic) => {
        const relatedCourses = topicCourseMapping[topic] || [];
        relatedCourses.forEach((courseSlug) => {
          const courseData = courseMap[courseSlug];
          const progressData = courseProgress.find((p) => p.slug === courseSlug);

          if (courseData && !recommendedSlugs.has(courseSlug) && progressData && !progressData.isComplete) {
            recs.push({
              course: courseData,
              reason: `Based on your interest in ${topic}`,
              score: 85,
            });
            recommendedSlugs.add(courseSlug);
          }
        });
      });

      // 3. Recommend courses in the same category as completed courses
      const completedCategories = new Set(
        completedCourses.map((slug) => courseProgress.find((c) => c.slug === slug)?.category)
      );

      completedCategories.forEach((category) => {
        if (!category) return;

        const categoryCourses = courseProgress.filter(
          (c) => c.category === category && !c.isComplete && !c.isStarted && !recommendedSlugs.has(c.slug)
        );

        categoryCourses.slice(0, 2).forEach((course) => {
          if (courseMap[course.slug]) {
            recs.push({
              course: courseMap[course.slug],
              reason: `Continue learning ${category}`,
              score: 70,
            });
            recommendedSlugs.add(course.slug);
          }
        });
      });

      // 4. For users with completed courses, recommend courses in the same difficulty level or next level
      if (completedCourses.length > 0) {
        const difficultyLevels = ['beginner', 'intermediate', 'advanced'];
        const completedDifficulty = courseProgress
          .filter((c) => c.isComplete)
          .map((c) => difficultyLevels.indexOf(c.difficulty || 'beginner'));

        const avgDifficulty = completedDifficulty.length > 0
          ? Math.round(completedDifficulty.reduce((a, b) => a + b, 0) / completedDifficulty.length)
          : 0;

        // Recommend courses at the same or next difficulty level
        const targetDifficulty = difficultyLevels[Math.min(avgDifficulty + 1, difficultyLevels.length - 1)];

        courseProgress
          .filter((c) => !c.isComplete && !c.isStarted && !recommendedSlugs.has(c.slug) && c.difficulty === targetDifficulty)
          .slice(0, 2)
          .forEach((course) => {
            if (courseMap[course.slug]) {
              recs.push({
                course: courseMap[course.slug],
                reason: `Next level: ${targetDifficulty}`,
                score: 60,
              });
              recommendedSlugs.add(course.slug);
            }
          });
      }

      // 5. Beginner recommendations for new users with no activity
      if (completedCourses.length === 0 && inProgressCourses.length === 0 && topTopics.length === 0) {
        const beginnerCourses = ["basic-physics", "chemistry-basics", "cell-biology", "general-science"];
        beginnerCourses.forEach((slug) => {
          if (courseMap[slug] && !recommendedSlugs.has(slug)) {
            recs.push({
              course: courseMap[slug],
              reason: "Great starting point for beginners",
              score: 50,
            });
            recommendedSlugs.add(slug);
          }
        });
      }

      // 6. If still have space, fill with popular beginner courses
      if (recs.length < 4) {
        courses
          .filter((c) => !recommendedSlugs.has(c.slug) && (c.difficulty || 'beginner') === 'beginner')
          .slice(0, 4 - recs.length)
          .forEach((course) => {
            if (!recommendedSlugs.has(course.slug)) {
              recs.push({
                course: courseMap[course.slug],
                reason: "Popular beginner course",
                score: 40,
              });
              recommendedSlugs.add(course.slug);
            }
          });
      }

      // Sort by score and limit to top 4
      const sortedRecs = recs
        .sort((a, b) => b.score - a.score)
        .slice(0, 4);

      setRecommendations(sortedRecs);
    } catch (error) {
      console.error("Error loading recommendations:", error);
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useEffect(() => {
    loadRecommendations();
  }, [loadRecommendations]);

  if (loading) {
    return (
      <Card className="animate-pulse">
        <CardHeader>
          <div className="h-6 bg-muted rounded w-1/3" />
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-2">
            {[1, 2].map((i) => (
              <div key={i} className="h-32 bg-muted rounded" />
            ))}
          </div>
        </CardContent>
      </Card>
    );
  }

  if (recommendations.length === 0) {
    return null;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Sparkles className="h-5 w-5 text-primary" />
          Recommended For You
        </CardTitle>
        <CardDescription>
          Personalized course suggestions based on your learning journey
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div className="grid gap-4 md:grid-cols-2">
          {recommendations.map((rec) => (
            <Card
              key={rec.course.id}
              className="cursor-pointer hover:shadow-md transition-all group border-muted"
              onClick={() => navigate(`/science-lens/learning/${rec.course.slug}`)}
            >
              <CardHeader className="pb-2">
                <div className="flex items-start justify-between">
                  <Badge variant="outline" className="mb-2">
                    {rec.course.category}
                  </Badge>
                  {rec.score >= 100 && (
                    <TrendingUp className="h-4 w-4 text-primary" />
                  )}
                </div>
                <CardTitle className="text-lg group-hover:text-primary transition-colors">
                  {rec.course.title}
                </CardTitle>
              </CardHeader>
              <CardContent className="pt-0">
                <p className="text-sm text-muted-foreground mb-3 line-clamp-2">
                  {rec.course.description}
                </p>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-1 text-xs text-muted-foreground">
                    <BookOpen className="h-3 w-3" />
                    <span>{rec.course.lessonCount} lessons</span>
                  </div>
                  <Button size="sm" variant="ghost" className="gap-1">
                    Start
                    <ArrowRight className="h-3 w-3" />
                  </Button>
                </div>
                <p className="text-xs text-primary mt-2 font-medium">
                  {rec.reason}
                </p>
              </CardContent>
            </Card>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}
