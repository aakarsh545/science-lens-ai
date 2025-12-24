import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { 
  Telescope, 
  Sparkles, 
  Trophy, 
  Zap, 
  Brain,
  Rocket,
  Star,
  Target,
  BookOpen
} from 'lucide-react';
import SpaceBackground from './SpaceBackground';
import AuthModal from './AuthModal';

const features = [
  {
    icon: Brain,
    title: "AI-Powered Q&A",
    description: "Get instant answers to complex science questions powered by advanced AI",
    color: "primary"
  },
  {
    icon: Trophy,
    title: "Achievement System",
    description: "Unlock badges and celebrate milestones in your learning journey",
    color: "achievement"
  },
  {
    icon: Target,
    title: "Daily Streaks",
    description: "Build consistent learning habits with our streak tracking system",
    color: "success"
  },
  {
    icon: Rocket,
    title: "Progressive Learning",
    description: "Unlock new topics as you master the fundamentals",
    color: "secondary"
  }
];

const stats = [
  { value: "10K+", label: "Questions Answered" },
  { value: "500+", label: "Active Learners" },
  { value: "95%", label: "Success Rate" },
  { value: "24/7", label: "AI Availability" }
];

export default function LandingPage() {
  const [showAuthModal, setShowAuthModal] = useState(false);
  const navigate = useNavigate();

  return (
    <div className="min-h-screen relative overflow-hidden">
      <SpaceBackground />
      
      {/* Navigation */}
      <motion.nav 
        initial={{ y: -100, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.8 }}
        className="relative z-10 flex items-center justify-between p-6 backdrop-blur-sm"
      >
        <div className="flex items-center gap-2">
          <Telescope className="w-8 h-8 text-primary" />
          <span className="text-2xl font-bold bg-gradient-cosmic bg-clip-text text-transparent">
            Science Lens
          </span>
        </div>
        
        <div className="flex gap-4">
          <Button variant="ghostCosmic" onClick={() => setShowAuthModal(true)}>Sign In</Button>
          <Button variant="cosmic" onClick={() => setShowAuthModal(true)}>Get Started</Button>
        </div>
      </motion.nav>

      {/* Hero Section */}
      <section className="relative z-10 text-center py-20 px-6">
        <motion.div
          initial={{ scale: 0.8, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ duration: 1, delay: 0.2 }}
        >
          <div className="inline-flex items-center gap-2 bg-primary/10 border border-primary/20 rounded-full px-4 py-2 mb-8">
            <Sparkles className="w-4 h-4 text-primary animate-glow" />
            <span className="text-sm text-primary font-medium">AI-Powered Science Learning</span>
          </div>
          
          <h1 className="text-6xl md:text-8xl font-bold bg-gradient-to-r from-foreground via-primary to-secondary bg-clip-text text-transparent mb-6">
            Explore Science
            <br />
            <span className="text-primary animate-glow">Like Never Before</span>
          </h1>
          
          <p className="text-xl text-muted-foreground max-w-2xl mx-auto mb-10 leading-relaxed">
            Unlock the mysteries of science with AI-powered learning. Ask questions, 
            track progress, and achieve mastery through our revolutionary platform.
          </p>
          
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button variant="hero" size="xl" className="group" onClick={() => setShowAuthModal(true)}>
              <Zap className="w-5 h-5 group-hover:animate-pulse" />
              Start Learning
            </Button>
            <Button 
              variant="ghostCosmic" 
              size="xl"
              onClick={() => {
                const element = document.getElementById('how-it-works');
                if (element) {
                  const headerOffset = 80;
                  const elementPosition = element.getBoundingClientRect().top;
                  const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                  window.scrollTo({ top: offsetPosition, behavior: 'smooth' });
                }
              }}
            >
              How It Works
              <Sparkles className="w-5 h-5" />
            </Button>
          </div>
        </motion.div>
      </section>

      {/* Stats Section */}
      <section className="relative z-10 py-16 px-6">
        <motion.div 
          initial={{ y: 50, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.5 }}
          className="max-w-4xl mx-auto"
        >
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {stats.map((stat, index) => (
              <motion.div
                key={stat.label}
                initial={{ scale: 0.5, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                transition={{ duration: 0.5, delay: 0.7 + index * 0.1 }}
                className="text-center"
              >
                <Card className="card-cosmic p-6 hover:glow-primary transition-all duration-300">
                  <CardContent className="p-0">
                    <div className="text-3xl font-bold text-primary mb-2">{stat.value}</div>
                    <div className="text-muted-foreground">{stat.label}</div>
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </section>

      {/* How It Works Section */}
      <section id="how-it-works" className="relative z-10 py-20 px-6">
        <motion.div 
          initial={{ y: 100, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.6 }}
          className="max-w-6xl mx-auto"
        >
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold mb-6">
              <span className="bg-gradient-cosmic bg-clip-text text-transparent">
                How It Works
              </span>
            </h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              Your journey to mastering science in three simple steps
            </p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-8 mb-16">
            {[
              { step: '1', title: 'Choose Your Path', desc: 'Browse 18+ science courses from physics to biology', icon: BookOpen },
              { step: '2', title: 'Learn & Practice', desc: 'Interactive lessons with quizzes and AI hints', icon: Brain },
              { step: '3', title: 'Track Progress', desc: 'Earn XP, level up, and unlock achievements', icon: Trophy }
            ].map((item, idx) => {
              const IconComp = item.icon;
              return (
                <Card key={idx} className="card-cosmic p-8 text-center">
                  <CardContent className="p-0">
                    <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-primary/20 flex items-center justify-center text-2xl font-bold text-primary">
                      {item.step}
                    </div>
                    <IconComp className="w-8 h-8 mx-auto mb-4 text-primary" />
                    <h3 className="text-xl font-semibold mb-2">{item.title}</h3>
                    <p className="text-muted-foreground">{item.desc}</p>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </motion.div>
      </section>

      {/* Features Section */}
      <section className="relative z-10 py-20 px-6">
        <motion.div 
          initial={{ y: 100, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.8 }}
          className="max-w-6xl mx-auto"
        >
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold mb-6">
              <span className="bg-gradient-cosmic bg-clip-text text-transparent">
                Powerful Features
              </span>
            </h2>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto">
              Everything you need to accelerate your science learning journey
            </p>
          </div>
          
          <div className="grid md:grid-cols-2 gap-8">
            {features.map((feature, index) => {
              const IconComponent = feature.icon;
              return (
                <motion.div
                  key={feature.title}
                  initial={{ x: index % 2 === 0 ? -50 : 50, opacity: 0 }}
                  animate={{ x: 0, opacity: 1 }}
                  transition={{ duration: 0.6, delay: 1 + index * 0.2 }}
                >
                  <Card className="card-cosmic p-8 h-full hover:scale-105 transition-all duration-300 group">
                    <CardContent className="p-0">
                      <div className={`inline-flex p-3 rounded-lg bg-${feature.color}/10 border border-${feature.color}/20 mb-6 group-hover:glow-primary transition-all duration-300`}>
                        <IconComponent className={`w-6 h-6 text-${feature.color}`} />
                      </div>
                      <h3 className="text-xl font-semibold mb-3">{feature.title}</h3>
                      <p className="text-muted-foreground leading-relaxed">
                        {feature.description}
                      </p>
                    </CardContent>
                  </Card>
                </motion.div>
              );
            })}
          </div>
        </motion.div>
      </section>

      {/* CTA Section */}
      <section className="relative z-10 py-20 px-6">
        <motion.div
          initial={{ scale: 0.9, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          transition={{ duration: 0.8, delay: 1.5 }}
          className="max-w-4xl mx-auto text-center"
        >
          <Card className="card-cosmic p-12 bg-gradient-card border border-primary/20">
            <CardContent className="p-0">
              <div className="flex justify-center mb-6">
                <div className="relative">
                  <Star className="w-16 h-16 text-achievement animate-float" />
                  <div className="absolute inset-0 bg-achievement/20 blur-xl rounded-full animate-glow" />
                </div>
              </div>
              
              <h2 className="text-4xl font-bold mb-6">
                Ready to Begin Your
                <br />
                <span className="bg-gradient-cosmic bg-clip-text text-transparent">
                  Scientific Journey?
                </span>
              </h2>
              
              <p className="text-xl text-muted-foreground mb-10 max-w-2xl mx-auto">
                Join thousands of learners who have already discovered the power of AI-assisted science education.
              </p>
              
              <Button variant="hero" size="xl" className="group" onClick={() => setShowAuthModal(true)}>
                <Zap className="w-5 h-5 group-hover:animate-pulse" />
                Start Learning Now
                <Sparkles className="w-5 h-5 group-hover:animate-pulse" />
              </Button>
            </CardContent>
          </Card>
        </motion.div>
      </section>

      {/* Footer */}
      <footer className="relative z-10 border-t border-border/50 backdrop-blur-sm py-8 px-6 mt-20">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center gap-2 mb-4 md:mb-0">
            <Telescope className="w-6 h-6 text-primary" />
            <span className="font-semibold">Science Lens</span>
          </div>
          
          <div className="text-muted-foreground text-sm">
            © 2024 Science Lens. Powered by AI and curiosity.
          </div>
        </div>
      </footer>

      {/* Auth Modal */}
      <AuthModal open={showAuthModal} onOpenChange={setShowAuthModal} />
    </div>
  );
}