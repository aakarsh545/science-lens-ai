import React, { useState } from 'react';
import { useRive } from '@rive-app/react-canvas';
import { motion } from 'framer-motion';

interface RiveMascotProps {
  className?: string;
  size?: number;
  mood?: 'happy' | 'excited' | 'thinking' | 'celebrating';
}

export const RiveMascot: React.FC<RiveMascotProps> = ({
  className = '',
  size = 200,
  mood = 'happy'
}) => {
  const { RiveComponent } = useRive({
    src: 'https://cdn.rive.app/animations/vehicles.riv',
    stateMachines: 'bouncing-drive',
    autoplay: true,
  });

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
      <div className="w-full h-full rounded-full border-2 border-primary/20 bg-gradient-to-br from-primary/10 to-accent/10 flex items-center justify-center shadow-[0_0_30px_var(--glow)]">
        <RiveComponent style={{ width: '100%', height: '100%' }} />
      </div>
    </motion.div>
  );
};

export default RiveMascot;