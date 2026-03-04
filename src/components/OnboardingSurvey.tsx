import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import {
  Sparkles,
  Monitor,
  Users,
  Youtube,
  Clock,
  GraduationCap,
  Heart,
  Rocket,
  Flame,
  BookOpen,
  Target,
  Zap,
  Atom,
  CheckCircle2
} from 'lucide-react';
import { supabase } from '@/integrations/supabase/client';
import { useNavigate } from 'react-router-dom';
import confetti from 'canvas-confetti';

interface OnboardingSurveyProps {
  userId: string;
  onComplete: () => void;
}

interface SurveyData {
  how_hear_about: string;
  how_hear_about_other?: string;
  motivation: string;
  motivation_other?: string;
  knowledge_level: string;
  daily_goal_minutes: number;
  starting_point: string;
}

const MASCOT_MESSAGES = [
  "Let's unlock science for you! 🔬",
  "Great choice! Tell us more 🎯",
  "Awesome! You're doing great! ⭐",
  "Almost there! Keep going! 💪",
  "Here's what awaits you! 🚀",
  "One last step! Let's set your goal! 🎯",
  "Perfect! Let's find your path! 🌟",
];

const HOW_HEAR_OPTIONS = [
  { value: 'youtube', label: 'YouTube', icon: Youtube },
  { value: 'friends_family', label: 'Friends/Family', icon: Users },
  { value: 'tiktok', label: 'TikTok', icon: Sparkles },
  { value: 'google_search', label: 'Google Search', icon: Rocket },
  { value: 'tv', label: 'TV', icon: Monitor },
  { value: 'news_article', label: 'News/Article/Blog', icon: BookOpen },
  { value: 'facebook_instagram', label: 'Facebook/Instagram', icon: Sparkles },
  { value: 'other', label: 'Other', icon: Sparkles },
];

const MOTIVATION_OPTIONS = [
  { value: 'school_exam', label: 'School/Exam preparation', icon: GraduationCap },
  { value: 'career_boost', label: 'Career boost', icon: Rocket },
  { value: 'personal_curiosity', label: 'Personal curiosity', icon: Sparkles },
  { value: 'support_education', label: 'Support education', icon: Heart },
  { value: 'connect_others', label: 'Connect with others', icon: Users },
  { value: 'just_fun', label: 'Just for fun', icon: Zap },
  { value: 'other', label: 'Other', icon: Sparkles },
];

const KNOWLEDGE_OPTIONS = [
  { value: 'new', label: "I'm new to science", level: 1 },
  { value: 'basic', label: "I know basic concepts", level: 2 },
  { value: 'explain_simple', label: "I can explain simple topics", level: 3 },
  { value: 'discuss_various', label: "I can discuss various subjects", level: 4 },
  { value: 'advanced_details', label: "I can dive into advanced details", level: 5 },
];

const DAILY_GOAL_OPTIONS = [
  { value: 5, label: '5 min/day', subtitle: 'Casual', icon: '🌱' },
  { value: 10, label: '10 min/day', subtitle: 'Regular', icon: '📚' },
  { value: 15, label: '15 min/day', subtitle: 'Serious', icon: '💪' },
  { value: 20, label: '20 min/day', subtitle: 'Intense', icon: '🔥' },
];

const STARTING_POINT_OPTIONS = [
  { value: 'basics', label: 'Start from basics', subtitle: 'Intro lessons', icon: '📖' },
];

const FEATURES = [
  { icon: '🎓', title: 'Master key concepts', description: 'through interactive lessons' },
  { icon: '🤖', title: 'Get AI-powered hints', description: 'and explanations' },
  { icon: '🔥', title: 'Build a daily learning habit', description: 'with streaks and XP' },
  { icon: '🏆', title: 'Unlock achievements', description: 'and compete on leaderboards' },
];

export default function OnboardingSurvey({ userId, onComplete }: OnboardingSurveyProps) {
  const [currentStep, setCurrentStep] = useState(0);
  const [surveyData, setSurveyData] = useState<SurveyData>({
    how_hear_about: '',
    motivation: '',
    knowledge_level: '',
    daily_goal_minutes: 10,
    starting_point: 'basics',
  });
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();

  const totalSteps = 6;
  const progress = ((currentStep + 1) / totalSteps) * 100;

  const handleNext = async () => {
    if (currentStep < totalSteps - 1) {
      setCurrentStep(currentStep + 1);
    } else {
      await handleSubmit();
    }
  };

  const handleBack = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const handleSubmit = async () => {
    setIsLoading(true);

    try {
      const { error } = await (supabase as any)
        .from('profiles')
        .update({
          onboarding_completed: true,
          onboarding_data: surveyData,
          daily_goal_minutes: surveyData.daily_goal_minutes,
        })
        .eq('user_id', userId);

      if (error) throw error;

      // Trigger confetti celebration
      confetti({
        particleCount: 150,
        spread: 70,
        origin: { y: 0.6 },
        colors: ['#3B82F6', '#8B5CF6', '#06B6D4', '#F59E0B'],
      });

      // Wait a moment for celebration, then complete
      setTimeout(() => {
        onComplete();
      }, 1500);
    } catch (error) {
      console.error('Error saving onboarding:', error);
      setIsLoading(false);
    }
  };

  const updateSurveyData = (key: keyof SurveyData, value: any) => {
    setSurveyData(prev => ({ ...prev, [key]: value }));
  };

  const renderStep = () => {
    switch (currentStep) {
      case 0:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">How did you hear about Science Lens AI?</h2>
            <RadioGroup
              value={surveyData.how_hear_about}
              onValueChange={(value) => updateSurveyData('how_hear_about', value)}
              className="grid grid-cols-2 gap-3"
            >
              {HOW_HEAR_OPTIONS.map((option) => {
                const Icon = option.icon;
                return (
                  <div key={option.value} className="relative">
                    <RadioGroupItem
                      value={option.value}
                      id={option.value}
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor={option.value}
                      className="flex flex-col items-center justify-center p-4 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                    >
                      <Icon className="w-8 h-8 mb-2 text-primary" />
                      <span className="text-sm font-medium text-center">{option.label}</span>
                    </Label>
                  </div>
                );
              })}
            </RadioGroup>
            {surveyData.how_hear_about === 'other' && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: 'auto' }}
                className="mt-4"
              >
                <Label htmlFor="hear-other">Please specify</Label>
                <Input
                  id="hear-other"
                  placeholder="How did you hear about us?"
                  value={surveyData.how_hear_about_other || ''}
                  onChange={(e) => updateSurveyData('how_hear_about_other', e.target.value)}
                  className="mt-2"
                />
              </motion.div>
            )}
          </div>
        );

      case 1:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">What's your main motivation for learning science?</h2>
            <RadioGroup
              value={surveyData.motivation}
              onValueChange={(value) => updateSurveyData('motivation', value)}
              className="grid grid-cols-2 gap-3"
            >
              {MOTIVATION_OPTIONS.map((option) => {
                const Icon = option.icon;
                return (
                  <div key={option.value} className="relative">
                    <RadioGroupItem
                      value={option.value}
                      id={`motivation-${option.value}`}
                      className="peer sr-only"
                    />
                    <Label
                      htmlFor={`motivation-${option.value}`}
                      className="flex flex-col items-center justify-center p-4 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                    >
                      <Icon className="w-8 h-8 mb-2 text-primary" />
                      <span className="text-sm font-medium text-center">{option.label}</span>
                    </Label>
                  </div>
                );
              })}
            </RadioGroup>
            {surveyData.motivation === 'other' && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: 'auto' }}
                className="mt-4"
              >
                <Label htmlFor="motivation-other">Please specify</Label>
                <Input
                  id="motivation-other"
                  placeholder="What motivates you?"
                  value={surveyData.motivation_other || ''}
                  onChange={(e) => updateSurveyData('motivation_other', e.target.value)}
                  className="mt-2"
                />
              </motion.div>
            )}
          </div>
        );

      case 2:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">What's your current science knowledge level?</h2>
            <RadioGroup
              value={surveyData.knowledge_level}
              onValueChange={(value) => updateSurveyData('knowledge_level', value)}
              className="space-y-3"
            >
              {KNOWLEDGE_OPTIONS.map((option, index) => (
                <div key={option.value} className="relative">
                  <RadioGroupItem
                    value={option.value}
                    id={`level-${option.value}`}
                    className="peer sr-only"
                  />
                  <Label
                    htmlFor={`level-${option.value}`}
                    className="flex items-center gap-4 p-4 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                  >
                    <div className="flex items-center gap-3 flex-1">
                      <div className="flex items-center justify-center w-10 h-10 rounded-full bg-primary/20 text-primary font-bold">
                        {index + 1}
                      </div>
                      <span className="font-medium">{option.label}</span>
                    </div>
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>
        );

      case 3:
        return (
          <div className="space-y-6">
            <h2 className="text-2xl font-bold text-center">Here's what you can achieve with Science Lens AI!</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {FEATURES.map((feature, index) => (
                <motion.div
                  key={index}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                  className="flex items-start gap-4 p-4 rounded-lg border border-primary/20 bg-gradient-to-br from-primary/5 to-secondary/5"
                >
                  <span className="text-4xl">{feature.icon}</span>
                  <div>
                    <h3 className="font-semibold text-primary">{feature.title}</h3>
                    <p className="text-sm text-muted-foreground">{feature.description}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        );

      case 4:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">What's your daily learning goal?</h2>
            <RadioGroup
              value={surveyData.daily_goal_minutes.toString()}
              onValueChange={(value) => updateSurveyData('daily_goal_minutes', parseInt(value))}
              className="grid grid-cols-2 gap-3"
            >
              {DAILY_GOAL_OPTIONS.map((option) => (
                <div key={option.value} className="relative">
                  <RadioGroupItem
                    value={option.value.toString()}
                    id={`goal-${option.value}`}
                    className="peer sr-only"
                  />
                  <Label
                    htmlFor={`goal-${option.value}`}
                    className="flex flex-col items-center justify-center p-6 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                  >
                    <span className="text-4xl mb-2">{option.icon}</span>
                    <span className="text-lg font-bold">{option.label}</span>
                    <span className="text-xs text-muted-foreground">{option.subtitle}</span>
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>
        );

      case 5:
        return (
          <div className="space-y-4">
            <h2 className="text-2xl font-bold text-center">Let's find the best starting point!</h2>
            <RadioGroup
              value={surveyData.starting_point}
              onValueChange={(value) => updateSurveyData('starting_point', value)}
              className="grid grid-cols-1 md:grid-cols-2 gap-3"
            >
              {STARTING_POINT_OPTIONS.map((option) => (
                <div key={option.value} className="relative">
                  <RadioGroupItem
                    value={option.value}
                    id={`start-${option.value}`}
                    className="peer sr-only"
                  />
                  <Label
                    htmlFor={`start-${option.value}`}
                    className="flex flex-col items-center justify-center p-6 rounded-lg border-2 border-border hover:border-primary/50 hover:bg-primary/5 transition-all cursor-pointer peer-data-[state=checked]:border-primary peer-data-[state=checked]:bg-primary/10"
                  >
                    <span className="text-4xl mb-2">{option.icon}</span>
                    <span className="text-lg font-bold">{option.label}</span>
                    <span className="text-xs text-muted-foreground">{option.subtitle}</span>
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>
        );

      default:
        return null;
    }
  };

  const canProceed = () => {
    switch (currentStep) {
      case 0:
        return surveyData.how_hear_about && (surveyData.how_hear_about !== 'other' || surveyData.how_hear_about_other);
      case 1:
        return surveyData.motivation && (surveyData.motivation !== 'other' || surveyData.motivation_other);
      case 2:
        return surveyData.knowledge_level;
      case 3:
        return true; // Info screen, no input
      case 4:
        return surveyData.daily_goal_minutes;
      case 5:
        return surveyData.starting_point;
      default:
        return false;
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/95 backdrop-blur-sm p-4">
      <Card className="w-full max-w-2xl max-h-[90vh] overflow-y-auto">
        <CardContent className="p-6">
          {/* Progress Bar */}
          <div className="mb-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium text-primary">Step {currentStep + 1} of {totalSteps}</span>
              <span className="text-sm font-medium text-primary">{Math.round(progress)}%</span>
            </div>
            <Progress value={progress} className="h-2" />
          </div>

          {/* Mascot Bubble */}
          <motion.div
            key={currentStep}
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex items-start gap-3 mb-6 p-4 rounded-xl bg-gradient-to-r from-primary/20 via-secondary/20 to-accent/20 border border-primary/30"
          >
            <div className="flex-shrink-0 w-12 h-12 rounded-full bg-gradient-to-br from-primary to-secondary flex items-center justify-center text-white text-2xl">
              🔬
            </div>
            <p className="text-sm font-medium flex-1">{MASCOT_MESSAGES[currentStep]}</p>
          </motion.div>

          {/* Step Content */}
          <AnimatePresence mode="wait">
            <motion.div
              key={currentStep}
              initial={{ opacity: 0, x: 50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -50 }}
              transition={{ duration: 0.3 }}
              className="min-h-[300px]"
            >
              {renderStep()}
            </motion.div>
          </AnimatePresence>

          {/* Navigation Buttons */}
          <div className="flex items-center justify-between mt-8 pt-4 border-t">
            <Button
              variant="ghost"
              onClick={handleBack}
              disabled={currentStep === 0 || isLoading}
              className="flex-1 mr-2"
            >
              Back
            </Button>
            <Button
              onClick={handleNext}
              disabled={!canProceed() || isLoading}
              className="flex-1 ml-2 bg-gradient-to-r from-primary to-secondary hover:opacity-90"
            >
              {isLoading ? (
                <span className="flex items-center gap-2">
                  <motion.div
                    animate={{ rotate: 360 }}
                    transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
                  >
                    ⚙️
                  </motion.div>
                  Saving...
                </span>
              ) : currentStep === totalSteps - 1 ? (
                <span className="flex items-center gap-2">
                  <CheckCircle2 className="w-4 h-4" />
                  Complete
                </span>
              ) : (
                'Continue'
              )}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
