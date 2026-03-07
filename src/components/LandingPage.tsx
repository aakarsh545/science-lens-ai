import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { Button } from '@/components/ui/button';
import {
  Atom,
  Sparkles,
  Trophy,
  Zap,
  Brain,
  Flame,
  Heart,
  Target,
  BookOpen,
  GraduationCap,
  Gift,
  Beaker
} from 'lucide-react';
import AuthModal from './AuthModal';
import { OnboardingCutscene } from './OnboardingCutscene';
import { supabase } from '@/integrations/supabase/client';
import { getHasSeenOnboarding, setHasSeenOnboarding, getHasSeenIntro, setHasSeenIntro } from '@/utils/userStorage';

// Feature cards row (4 cards)
const featureCards = [
  { icon: BookOpen, title: "Physics First", subtitle: "Foundation focused", color: "text-blue-400" },
  { icon: Beaker, title: "All Sciences", subtitle: "Plus university", color: "text-purple-400" },
  { icon: Zap, title: "XP & Streaks", subtitle: "Stay motivated", color: "text-yellow-400" },
  { icon: Gift, title: "Free to Start", subtitle: "No credit card", color: "text-green-400" }
];

// Features grid (6 cards)
const gridFeatures = [
  { icon: Brain, title: "AI-Powered Q&A" },
  { icon: Flame, title: "Daily Streaks" },
  { icon: Zap, title: "XP & Levels" },
  { icon: Heart, title: "Lives System" },
  { icon: Trophy, title: "Leaderboard" },
  { icon: BookOpen, title: "Structured Lessons" }
];

// How it works steps
const howItWorksSteps = [
  { step: "1", title: "Sign up & customize" },
  { step: "2", title: "Pick your track" },
  { step: "3", title: "Learn & earn" }
];

export default function LandingPage() {
  console.log('[LANDING PAGE] Rendering...');
  const [showAuthModal, setShowAuthModal] = useState(false);
  const [showOnboarding, setShowOnboarding] = useState(false);
  const [showIntro, setShowIntro] = useState(false);
  const navigate = useNavigate();

  // Safely read localStorage after component mounts
  useEffect(() => {
    console.log('[LANDING PAGE] useEffect - checking localStorage');
    try {
      const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
      setShowOnboarding(!hasSeenOnboarding);

      const hasSeenIntro = localStorage.getItem('hasSeenIntro');
      setShowIntro(!hasSeenIntro);
    } catch (error) {
      console.warn('localStorage not available:', error);
    }
  }, []);

  // Check authentication on mount and listen for auth state changes
  useEffect(() => {
    let mounted = true;

    // Apply landing page theme (deep dark navy)
    const root = document.documentElement;
    const landingPageTheme = {
      '--color-background': '#0d0d1a',
      '--color-surface': '#1a1a2e',
      '--color-text-primary': '#ffffff',
      '--color-text-secondary': '#a0a0b0',
      '--color-primary': '#6366f1',
      '--color-secondary': '#8b5cf6',
      '--color-accent': '#06b6d4',
    };

    Object.entries(landingPageTheme).forEach(([key, value]) => {
      root.style.setProperty(key, value);
    });

    // Check initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return;

      if (session) {
        navigate('/dashboard', { replace: true });
      }
    });

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if (!mounted) return;

      if (event === 'SIGNED_IN' && session) {
        navigate('/dashboard', { replace: true });
      }
    });

    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, [navigate]);

  const handleGetStarted = () => {
    navigate('/signup');
  };

  const handleOnboardingComplete = async () => {
    localStorage.setItem('hasSeenOnboarding', 'true');
    localStorage.setItem('hasSeenIntro', 'true');
    setShowOnboarding(false);
    setShowAuthModal(true);
  };

  const scrollToHowItWorks = () => {
    const element = document.getElementById('how-it-works');
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <div className="min-h-screen bg-[#0d0d1a] text-white relative overflow-hidden">
      {/* Starfield background effect */}
      <div className="fixed inset-0 -z-10">
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-blue-900/20 via-transparent to-transparent" />
        {/* Particle dots */}
        <div className="absolute inset-0" style={{
          backgroundImage: `radial-gradient(2px 2px at 20px 30px, rgba(255,255,255,0.3), transparent),
                           radial-gradient(2px 2px at 60px 70px, rgba(255,255,255,0.2), transparent),
                           radial-gradient(1px 1px at 50px 50px, rgba(255,255,255,0.3), transparent),
                           radial-gradient(1px 1px at 130px 80px, rgba(255,255,255,0.2), transparent),
                           radial-gradient(2px 2px at 90px 10px, rgba(255,255,255,0.3), transparent)`,
          backgroundSize: '200px 200px',
          opacity: 0.5
        }} />
      </div>

      {/* Onboarding Cutscene */}
      <AnimatePresence>
        {showOnboarding && (
          <OnboardingCutscene
            onComplete={handleOnboardingComplete}
            onClose={() => {
              localStorage.setItem('hasSeenOnboarding', 'true');
              setShowOnboarding(false);
            }}
          />
        )}
      </AnimatePresence>

      {/* HEADER */}
      <motion.header
        initial={{ y: -100, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.6 }}
        className="relative z-10 flex items-center justify-between px-6 py-4 md:px-12 md:py-6 bg-[#0d0d1a]/80 backdrop-blur-md border-b border-white/10"
      >
        <div className="flex items-center gap-2">
          <Atom className="w-8 h-8 text-blue-500" />
          <span className="text-xl font-bold text-white">Science Lens</span>
        </div>
        <div className="flex items-center gap-4">
          <button
            onClick={() => setShowAuthModal(true)}
            className="text-sm font-medium text-slate-300 hover:text-white transition-colors"
          >
            Sign In
          </button>
          <Button
            onClick={handleGetStarted}
            className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white font-medium px-6 py-2 rounded-full"
          >
            Get Started
          </Button>
        </div>
      </motion.header>

      {/* HERO SECTION */}
      <section className="relative z-10 text-center px-6 py-20 md:py-32 max-w-6xl mx-auto">
        <motion.div
          initial={{ scale: 0.9, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ duration: 0.8 }}
        >
          <h1 className="text-5xl md:text-7xl lg:text-8xl font-bold mb-6 leading-tight">
            <span className="text-white">Explore Science.</span>
            <br />
            <span className="bg-gradient-to-r from-blue-400 via-purple-400 to-cyan-400 bg-clip-text text-transparent">
              One Lesson at a Time.
            </span>
          </h1>

          <p className="text-lg md:text-xl text-slate-400 max-w-3xl mx-auto mb-10 leading-relaxed">
            Gamified science lessons for all ages and beyond. Learn with streaks, XP, and AI-powered tutoring.
          </p>

          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button
              onClick={handleGetStarted}
              className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white font-semibold px-8 py-4 rounded-full text-lg"
            >
              Start Learning Free
            </Button>
            <Button
              onClick={scrollToHowItWorks}
              variant="outline"
              className="border-2 border-slate-700 text-slate-300 hover:text-white hover:border-slate-600 font-semibold px-8 py-4 rounded-full text-lg bg-[#0d0d1a]/50 backdrop-blur-sm"
            >
              See How It Works
            </Button>
          </div>
        </motion.div>
      </section>

      {/* FEATURE CARDS ROW */}
      <section className="relative z-10 px-6 py-16 max-w-7xl mx-auto">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 md:gap-6">
          {featureCards.map((card, index) => (
            <motion.div
              key={card.title}
              initial={{ y: 50, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="bg-[#1a1a2e] border border-white/10 rounded-2xl p-6 text-center hover:border-white/20 transition-all"
            >
              <card.icon className={`w-8 h-8 mx-auto mb-3 ${card.color}`} />
              <h3 className={`font-semibold text-white mb-1 ${card.color}`}>{card.title}</h3>
              <p className="text-sm text-slate-400">{card.subtitle}</p>
            </motion.div>
          ))}
        </div>
      </section>

      {/* FEATURES GRID */}
      <section className="relative z-10 px-6 py-20 max-w-6xl mx-auto">
        <motion.div
          initial={{ y: 50, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8 }}
          className="text-center mb-12"
        >
          <h2 className="text-3xl md:text-5xl font-bold text-white mb-4">
            Everything you need to master science
          </h2>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {gridFeatures.map((feature, index) => (
            <motion.div
              key={feature.title}
              initial={{ y: 50, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="bg-[#1a1a2e] border border-white/10 rounded-2xl p-6 hover:border-white/20 transition-all group"
            >
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-600/20 to-purple-600/20 flex items-center justify-center group-hover:scale-110 transition-transform">
                  <feature.icon className="w-6 h-6 text-blue-400" />
                </div>
                <h3 className="font-semibold text-white text-lg">{feature.title}</h3>
              </div>
            </motion.div>
          ))}
        </div>
      </section>

      {/* HOW IT WORKS */}
      <section id="how-it-works" className="relative z-10 px-6 py-20 max-w-6xl mx-auto">
        <motion.div
          initial={{ y: 50, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8 }}
        >
          <h2 className="text-3xl md:text-5xl font-bold text-white text-center mb-16">
            How It Works
          </h2>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {howItWorksSteps.map((item, index) => (
              <motion.div
                key={item.step}
                initial={{ y: 50, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                transition={{ duration: 0.5, delay: index * 0.2 }}
                className="text-center"
              >
                <div className="w-16 h-16 mx-auto mb-6 rounded-full bg-gradient-to-br from-blue-600 to-blue-700 flex items-center justify-center text-2xl font-bold text-white shadow-lg shadow-blue-500/30">
                  {item.step}
                </div>
                <h3 className="text-xl font-semibold text-white mb-2">{item.title}</h3>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </section>

      {/* CTA SECTION */}
      <section className="relative z-10 px-6 py-20 max-w-4xl mx-auto">
        <motion.div
          initial={{ scale: 0.95, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ duration: 0.8 }}
          className="bg-gradient-to-br from-blue-600/20 via-purple-600/20 to-cyan-600/20 border-2 border-blue-500/30 rounded-3xl p-12 text-center backdrop-blur-sm"
        >
          <h2 className="text-3xl md:text-5xl font-bold text-white mb-8">
            Ready to start your science journey?
          </h2>
          <Button
            onClick={handleGetStarted}
            className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white font-semibold px-10 py-4 rounded-full text-lg"
          >
            Get Started Free
          </Button>
        </motion.div>
      </section>

      {/* FOOTER */}
      <footer className="relative z-10 px-6 py-8 border-t border-white/10">
        <div className="max-w-6xl mx-auto text-center text-slate-500 text-sm">
          © 2025 Science Lens. Built for curious minds.
        </div>
      </footer>

      {/* Auth Modal */}
      <AuthModal open={showAuthModal} onOpenChange={setShowAuthModal} />
    </div>
  );
}
