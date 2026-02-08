import { motion } from 'framer-motion';
import { ChevronDown } from 'lucide-react';
import { useState } from 'react';

interface PathLayoutProps {
  children: React.ReactNode;
  currentSection?: string;
  currentUnit?: number;
}

export function PathLayout({ children, currentSection = "Section 1", currentUnit = 1 }: PathLayoutProps) {
  const [scrollY, setScrollY] = useState(0);

  return (
    <div className="relative">
      {/* Section Header Banner */}
      <motion.div
        initial={{ y: -50, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ duration: 0.5 }}
        className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-primary/20 via-purple-500/20 to-blue-500/20 border-2 border-primary/30 mb-8"
      >
        {/* Animated Background Pattern */}
        <div className="absolute inset-0 opacity-20">
          <div className="absolute inset-0 bg-gradient-to-r from-primary via-purple-500 to-blue-500 animate-gradient bg-[length:200%_100%]"></div>
        </div>

        <div className="relative px-8 py-6">
          <div className="flex items-center justify-between">
            <div>
              <motion.div
                initial={{ x: -20, opacity: 0 }}
                animate={{ x: 0, opacity: 1 }}
                transition={{ delay: 0.2 }}
                className="flex items-center gap-2 mb-2"
              >
                <span className="text-sm font-semibold uppercase tracking-wider text-primary">
                  {currentSection}
                </span>
                <span className="text-muted-foreground">•</span>
                <span className="text-sm font-semibold text-primary">
                  Unit {currentUnit}
                </span>
              </motion.div>
              <motion.h2
                initial={{ x: -20, opacity: 0 }}
                animate={{ x: 0, opacity: 1 }}
                transition={{ delay: 0.3 }}
                className="text-3xl font-bold"
              >
                Start your journey
              </motion.h2>
            </div>

            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.5, type: 'spring', stiffness: 200 }}
              className="hidden md:block"
            >
              <ChevronDown className="w-8 h-8 text-primary animate-bounce" />
            </motion.div>
          </div>
        </div>
      </motion.div>

      {/* Path Container */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.3 }}
        className="relative"
      >
        {/* Center Line */}
        <div className="absolute left-1/2 top-0 bottom-0 w-1 -translate-x-1/2 bg-gradient-to-b from-primary/50 via-purple-500/50 to-blue-500/50 rounded-full" />

        {/* Units Path */}
        <div className="flex flex-col items-center space-y-8 py-8">
          {children}
        </div>
      </motion.div>
    </div>
  );
}
