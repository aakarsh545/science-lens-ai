import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ChevronRight, ChevronLeft, Sparkles, Atom, BookOpen, Target, Clock } from "lucide-react";

interface OnboardingData {
  role: string;
  interests: string[];
  goal: string;
  timeCommitment: string;
}

interface OnboardingCutsceneProps {
  onComplete: (data: OnboardingData) => void;
  onClose: () => void;
}

const questions = [
  {
    id: 'role',
    title: "What describes you best?",
    subtitle: "Help us personalize your science journey",
    icon: <Sparkles className="w-12 h-12" />,
    options: [
      { value: 'student', label: 'Student', emoji: '📚', desc: 'Learning is my passion' },
      { value: 'teacher', label: 'Educator', emoji: '👨‍🏫', desc: 'Inspiring young minds' },
      { value: 'researcher', label: 'Researcher', emoji: '🔬', desc: 'Pushing boundaries' },
      { value: 'curious', label: 'Curious Mind', emoji: '🌟', desc: 'Just love learning' },
    ]
  },
  {
    id: 'interests',
    title: "What sparks your curiosity?",
    subtitle: "Choose your favorite science topics",
    icon: <Atom className="w-12 h-12" />,
    multiSelect: true,
    options: [
      { value: 'physics', label: 'Physics', emoji: '⚛️', desc: 'Matter & Energy' },
      { value: 'chemistry', label: 'Chemistry', emoji: '🧪', desc: 'Elements & Reactions' },
      { value: 'biology', label: 'Biology', emoji: '🧬', desc: 'Life & Evolution' },
      { value: 'space', label: 'Space', emoji: '🚀', desc: 'Cosmos & Beyond' },
      { value: 'earth', label: 'Earth Science', emoji: '🌍', desc: 'Our Planet' },
    ]
  },
  {
    id: 'goal',
    title: "What's your main goal?",
    subtitle: "We'll tailor your experience accordingly",
    icon: <Target className="w-12 h-12" />,
    options: [
      { value: 'learn', label: 'Learn Basics', emoji: '🎯', desc: 'Start from fundamentals' },
      { value: 'exams', label: 'Exam Prep', emoji: '📝', desc: 'Ace those tests' },
      { value: 'research', label: 'Research', emoji: '🔍', desc: 'Deep dive into topics' },
      { value: 'stay_updated', label: 'Stay Updated', emoji: '📰', desc: 'Latest discoveries' },
    ]
  },
  {
    id: 'timeCommitment',
    title: "How much time can you dedicate?",
    subtitle: "Set a pace that works for you",
    icon: <Clock className="w-12 h-12" />,
    options: [
      { value: 'casual', label: 'Casual', emoji: '☕', desc: '5-10 min/day' },
      { value: 'moderate', label: 'Moderate', emoji: '📖', desc: '15-30 min/day' },
      { value: 'intensive', label: 'Intensive', emoji: '🔥', desc: '45+ min/day' },
    ]
  }
];

export function OnboardingCutscene({ onComplete, onClose }: OnboardingCutsceneProps) {
  const [currentStep, setCurrentStep] = useState(0);
  const [selectedOptions, setSelectedOptions] = useState<Record<string, string | string[]>>({});
  const [direction, setDirection] = useState(0);

  const currentQuestion = questions[currentStep];
  const isLastStep = currentStep === questions.length - 1;

  const handleSelect = (value: string) => {
    const question = questions[currentStep];

    if (question.multiSelect) {
      const current = selectedOptions[question.id] as string[] || [];
      const updated = current.includes(value)
        ? current.filter(v => v !== value)
        : [...current, value];
      setSelectedOptions(prev => ({ ...prev, [question.id]: updated }));
    } else {
      setSelectedOptions(prev => ({ ...prev, [question.id]: value }));
    }
  };

  const handleNext = () => {
    const current = questions[currentStep];
    const selected = selectedOptions[current.id];

    if (!selected || (Array.isArray(selected) && selected.length === 0)) {
      return; // Don't proceed if nothing selected
    }

    if (isLastStep) {
      onComplete(selectedOptions as OnboardingData);
    } else {
      setDirection(1);
      setCurrentStep(prev => prev + 1);
    }
  };

  const handleBack = () => {
    if (currentStep > 0) {
      setDirection(-1);
      setCurrentStep(prev => prev - 1);
    }
  };

  const getSelection = () => {
    const current = questions[currentStep];
    return selectedOptions[current.id];
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      {/* Animated Background */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="absolute w-96 h-96 -top-48 -left-48 bg-purple-500/20 rounded-full blur-3xl animate-pulse" />
        <div className="absolute w-96 h-96 -bottom-48 -right-48 bg-blue-500/20 rounded-full blur-3xl animate-pulse delay-1000" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-gradient-to-r from-purple-500/10 to-blue-500/10 rounded-full blur-3xl" />
      </div>

      {/* Mascot Character */}
      <motion.div
        initial={{ x: -200, opacity: 0 }}
        animate={{ x: 0, opacity: 1 }}
        transition={{ duration: 0.8, ease: "easeOut" }}
        className="absolute left-10 top-1/2 -translate-y-1/2 hidden lg:block"
      >
        <div className="relative">
          <div className="w-64 h-64 relative">
            {/* Anime-style scientist mascot */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div className="text-[200px] animate-bounce">👨‍🔬</div>
            </div>
            {/* Speech bubble */}
            <motion.div
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 1, duration: 0.5 }}
              className="absolute -right-4 -top-8 bg-white/10 backdrop-blur-lg rounded-2xl p-4 border border-white/20"
            >
              <p className="text-white text-sm font-medium">
                {currentStep === 0 && "Welcome! Let's set up your profile! 👋"}
                {currentStep === 1 && "You can pick multiple! ✨"}
                {currentStep === 2 && "Great choice! Almost there! 🎯"}
                {currentStep === 3 && "Last question! You're doing great! 💪"}
              </p>
            </motion.div>
          </div>
        </div>
      </motion.div>

      {/* Main Content */}
      <div className="relative z-10 w-full max-w-2xl mx-auto px-6">
        {/* Progress Bar */}
        <div className="mb-8">
          <div className="flex justify-center gap-2 mb-4">
            {questions.map((_, index) => (
              <motion.div
                key={index}
                initial={{ scale: 0 }}
                animate={{ scale: 1 }}
                transition={{ delay: index * 0.1 }}
                className={`h-2 rounded-full transition-all duration-300 ${
                  index <= currentStep ? 'bg-gradient-to-r from-purple-500 to-blue-500 w-12' : 'bg-white/20 w-8'
                }`}
              />
            ))}
          </div>
          <p className="text-center text-white/60 text-sm">
            Step {currentStep + 1} of {questions.length}
          </p>
        </div>

        {/* Question Card */}
        <AnimatePresence mode="wait" initial={false}>
          <motion.div
            key={currentStep}
            initial={{ opacity: 0, x: direction > 0 ? 100 : -100 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: direction > 0 ? -100 : 100 }}
            transition={{ duration: 0.5, ease: [0.25, 0.1, 0.25, 1] }}
            className="bg-white/10 backdrop-blur-xl rounded-3xl p-8 border border-white/20 shadow-2xl"
          >
            {/* Icon & Title */}
            <motion.div
              initial={{ y: 20, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="text-center mb-8"
            >
              <div className="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-purple-500 to-blue-500 rounded-2xl mb-4 text-white">
                {currentQuestion.icon}
              </div>
              <h2 className="text-3xl font-bold text-white mb-2">{currentQuestion.title}</h2>
              <p className="text-white/70">{currentQuestion.subtitle}</p>
            </motion.div>

            {/* Options */}
            <div className="space-y-3 mb-8">
              {currentQuestion.options.map((option, index) => {
                const isSelected = currentQuestion.multiSelect
                  ? (getSelection() as string[])?.includes(option.value)
                  : getSelection() === option.value;

                return (
                  <motion.button
                    key={option.value}
                    initial={{ y: 20, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: 0.3 + index * 0.1 }}
                    onClick={() => handleSelect(option.value)}
                    className={`w-full p-4 rounded-2xl border-2 transition-all duration-300 text-left group relative overflow-hidden ${
                      isSelected
                        ? 'bg-gradient-to-r from-purple-500/30 to-blue-500/30 border-purple-400'
                        : 'bg-white/5 border-white/10 hover:bg-white/10 hover:border-white/20'
                    }`}
                  >
                    <div className="flex items-center gap-4">
                      <span className="text-4xl">{option.emoji}</span>
                      <div className="flex-1">
                        <p className="text-white font-semibold text-lg">{option.label}</p>
                        <p className="text-white/60 text-sm">{option.desc}</p>
                      </div>
                      {isSelected && (
                        <motion.div
                          initial={{ scale: 0 }}
                          animate={{ scale: 1 }}
                          className="w-6 h-6 bg-gradient-to-r from-purple-500 to-blue-500 rounded-full flex items-center justify-center"
                        >
                          <ChevronRight className="w-4 h-4 text-white" />
                        </motion.div>
                      )}
                    </div>

                    {/* Shine effect on hover */}
                    <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/10 to-transparent translate-x-[-100%] group-hover:translate-x-[100%] transition-transform duration-700" />
                  </motion.button>
                );
              })}
            </div>

            {/* Navigation */}
            <div className="flex items-center justify-between">
              <button
                onClick={handleBack}
                disabled={currentStep === 0}
                className={`flex items-center gap-2 px-6 py-3 rounded-xl transition-all duration-300 ${
                  currentStep === 0
                    ? 'opacity-30 cursor-not-allowed'
                    : 'text-white/70 hover:text-white hover:bg-white/10'
                }`}
              >
                <ChevronLeft className="w-5 h-5" />
                Back
              </button>

              <button
                onClick={handleNext}
                className="flex items-center gap-2 px-8 py-3 bg-gradient-to-r from-purple-500 to-blue-500 text-white rounded-xl font-semibold shadow-lg shadow-purple-500/30 hover:shadow-purple-500/50 hover:scale-105 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100"
                disabled={!getSelection() || (Array.isArray(getSelection()) && getSelection().length === 0)}
              >
                {isLastStep ? 'Complete Setup' : 'Continue'}
                <ChevronRight className="w-5 h-5" />
              </button>
            </div>
          </motion.div>
        </AnimatePresence>

        {/* Skip Link */}
        <button
          onClick={onClose}
          className="mt-6 text-white/50 hover:text-white/70 text-sm transition-colors"
        >
          Skip for now
        </button>
      </div>

      {/* Close Button */}
      <button
        onClick={onClose}
        className="absolute top-6 right-6 w-10 h-10 bg-white/10 backdrop-blur-lg rounded-full flex items-center justify-center text-white/70 hover:text-white hover:bg-white/20 transition-all duration-300"
      >
        ✕
      </button>
    </div>
  );
}
