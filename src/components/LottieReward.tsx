import React from 'react';
import Lottie from 'lottie-react';
import { motion } from 'framer-motion';

interface LottieRewardProps {
  className?: string;
  size?: number;
  type?: 'confetti' | 'trophy' | 'star' | 'thumbsup';
  autoplay?: boolean;
  loop?: boolean;
}

// Sample Lottie animation data (in production, these would be loaded from actual JSON files)
const CONFETTI_ANIMATION = {
  v: "5.5.7",
  fr: 60,
  ip: 0,
  op: 120,
  w: 400,
  h: 400,
  nm: "Confetti Celebration",
  ddd: 0,
  assets: [
    {
      id: "image_0",
      w: 100,
      h: 100,
      u: "",
      p: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAYAAADerw=='"
    }
  ],
  layers: [
    {
      ddd: 0,
      ind: 0,
      ty: 4,
      nm: "Confetti Layer",
      sr: 1,
      ks: { o: { a: 0, k: 100 }, r: { a: 0, k: 0 } },
      ao: 0,
      ip: 0,
      op: 120,
      st: 0
    }
  ]
};

const TROPHY_ANIMATION = {
  v: "5.5.7",
  fr: 60,
  ip: 0,
  op: 120,
  w: 400,
  h: 400,
  nm: "Trophy Award",
  ddd: 0,
  layers: [
    {
      ddd: 0,
      ind: 0,
      ty: 4,
      nm: "Trophy Layer",
      sr: 1,
      ks: { o: { a: 0, k: 100 }, r: { a: 0, k: 0 } },
      ao: 0,
      ip: 0,
      op: 120,
      st: 0
    }
  ]
};

export const LottieReward: React.FC<LottieRewardProps> = ({
  className = '',
  size = 200,
  type = 'confetti',
  autoplay = true,
  loop = false
}) => {
  const getAnimationData = () => {
    switch (type) {
      case 'confetti':
        return CONFETTI_ANIMATION;
      case 'trophy':
        return TROPHY_ANIMATION;
      case 'star':
      case 'thumbsup':
      default:
        return CONFETTI_ANIMATION; // Fallback to confetti
    }
  };

  return (
    <motion.div
      className={className}
      initial={{ scale: 0, rotate: -180 }}
      animate={{ scale: 1, rotate: 0 }}
      transition={{
        type: "spring",
        stiffness: 260,
        damping: 20
      }}
      style={{ width: size, height: size }}
    >
      <div className="w-full h-full flex items-center justify-center">
        <Lottie
          animationData={getAnimationData()}
          autoplay={autoplay}
          loop={loop}
          style={{ width: '100%', height: '100%' }}
        />
      </div>
    </motion.div>
  );
};

export default LottieReward;
