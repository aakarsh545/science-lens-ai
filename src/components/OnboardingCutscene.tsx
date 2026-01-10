import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ChevronRight, Sparkles, BookOpen, Target, Trophy } from "lucide-react";

interface OnboardingCutsceneProps {
  onComplete: () => void;
  onClose: () => void;
}

const welcomeSlides = [
  {
    title: "Welcome to Science Lens AI!",
    subtitle: "Your intelligent science companion",
    icon: <Sparkles className="w-16 h-16" />,
    description: "Explore the wonders of science through interactive lessons, AI-powered Q&A, and engaging challenges."
  },
  {
    title: "Learn at Your Own Pace",
    subtitle: "Comprehensive science courses",
    icon: <BookOpen className="w-16 h-16" />,
    description: "Access expertly crafted lessons across physics, chemistry, biology, and more. Track your progress as you go."
  },
  {
    title: "Test Your Knowledge",
    subtitle: "Interactive challenges & quizzes",
    icon: <Target className="w-16 h-16" />,
    description: "Put your learning to the test with adaptive challenges. Earn XP, level up, and unlock achievements!"
  },
  {
    title: "Stay Motivated",
    subtitle: "Gamified learning experience",
    icon: <Trophy className="w-16 h-16" />,
    description: "Earn badges, maintain streaks, and compete on leaderboards. Science learning has never been this fun!"
  }
];

export function OnboardingCutscene({ onComplete, onClose }: OnboardingCutsceneProps) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [direction, setDirection] = useState(0);

  const isLastSlide = currentSlide === welcomeSlides.length - 1;

  const handleNext = () => {
    if (isLastSlide) {
      onComplete();
    } else {
      setDirection(1);
      setCurrentSlide(prev => prev + 1);
    }
  };

  const handleBack = () => {
    if (currentSlide > 0) {
      setDirection(-1);
      setCurrentSlide(prev => prev - 1);
    } else {
      onClose();
    }
  };

  const handleSkip = () => {
    onComplete();
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 z-50 flex items-center justify-center bg-slate-900/95 backdrop-blur-sm p-4"
    >
      <motion.div
        initial={{ scale: 0.9, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        className="w-full max-w-2xl"
      >
        <div className="bg-gradient-to-br from-primary/10 to-purple-500/10 border border-primary/20 rounded-2xl p-8 md:p-12 shadow-2xl relative">
          {/* Skip Button */}
          <div className="absolute top-4 right-4">
            <button
              onClick={handleSkip}
              className="text-sm text-muted-foreground hover:text-foreground transition-colors"
            >
              Skip
            </button>
          </div>

          {/* Progress Indicators */}
          <div className="flex justify-center gap-2 mb-8">
            {welcomeSlides.map((_, idx) => (
              <div
                key={idx}
                className={`h-1.5 rounded-full transition-all ${
                  idx === currentSlide
                    ? 'w-8 bg-primary'
                    : idx < currentSlide
                    ? 'w-2 bg-primary/50'
                    : 'w-2 bg-primary/20'
                }`}
              />
            ))}
          </div>

          {/* Slide Content */}
          <AnimatePresence mode="wait" initial={false}>
            <motion.div
              key={currentSlide}
              initial={{ opacity: 0, x: direction > 0 ? 50 : -50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: direction < 0 ? 50 : -50 }}
              transition={{ duration: 0.3 }}
              className="text-center"
            >
              <div className="flex justify-center mb-6 text-primary">
                {welcomeSlides[currentSlide].icon}
              </div>

              <h2 className="text-3xl md:text-4xl font-bold mb-3 bg-gradient-to-r from-primary to-purple-500 bg-clip-text text-transparent">
                {welcomeSlides[currentSlide].title}
              </h2>

              <p className="text-lg text-muted-foreground mb-4">
                {welcomeSlides[currentSlide].subtitle}
              </p>

              <p className="text-base text-foreground/80 mb-8 max-w-md mx-auto">
                {welcomeSlides[currentSlide].description}
              </p>

              {/* Navigation Buttons */}
              <div className="flex items-center justify-center gap-4">
                <button
                  onClick={handleBack}
                  className="px-6 py-2.5 rounded-lg border border-border hover:bg-accent transition-colors"
                >
                  {currentSlide === 0 ? 'Close' : 'Back'}
                </button>

                <button
                  onClick={handleNext}
                  className="px-6 py-2.5 rounded-lg bg-primary text-primary-foreground hover:bg-primary/90 transition-colors font-medium flex items-center gap-2"
                >
                  {isLastSlide ? 'Get Started' : 'Next'}
                  {!isLastSlide && <ChevronRight className="w-4 h-4" />}
                </button>
              </div>
            </motion.div>
          </AnimatePresence>
        </div>
      </motion.div>
    </motion.div>
  );
}
