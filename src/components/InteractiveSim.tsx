import React, { useState } from 'react';
import { motion } from 'framer-motion';
import Spline from '@splinetool/react-spline';
import { useRive, useStateMachineInput } from '@rive-app/react-canvas';
import Lottie from 'lottie-react';
import { Button } from './ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from './ui/tabs';
import { Play, ExternalLink } from 'lucide-react';

/**
 * InteractiveSim Component
 *
 * Demonstrates integrations with various interactive visualization tools:
 * - PhET Interactive Simulations (via iframe embeds)
 * - Spline 3D scenes
 * - Rive animations
 * - Lottie animations
 */

// PhET Simulation URLs (examples)
const PHET_SIMULATIONS = {
  'forces-and-motion': 'https://phet.colorado.edu/sims/html/forces-and-motion-basics/latest/forces-and-motion-basics_en.html',
  'energy-skate-park': 'https://phet.colorado.edu/sims/html/energy-skate-park-basics/latest/energy-skate-park-basics_en.html',
  'balancing-act': 'https://phet.colorado.edu/sims/html/balancing-act/latest/balancing-act_en.html',
};

// PhET iframe embed component
const PhETSimulation: React.FC<{ simUrl: string; title: string }> = ({ simUrl, title }) => {
  return (
    <div className="w-full h-[600px] rounded-lg overflow-hidden border-2 border-purple-200 bg-white">
      <iframe
        src={simUrl}
        title={title}
        className="w-full h-full border-0"
        allowFullScreen
        loading="lazy"
      />
    </div>
  );
};

// Spline 3D Scene Component
const SplineScene: React.FC = () => {
  const [isLoaded, setIsLoaded] = useState(false);

  return (
    <div className="w-full h-[500px] rounded-lg overflow-hidden border-2 border-blue-200 bg-gradient-to-br from-blue-50 to-purple-50">
      {!isLoaded && (
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="animate-pulse text-lg text-blue-600">Loading 3D scene...</div>
        </div>
      )}
      <Spline
        scene="https://prod.spline.design/6Wq-1-2xNqYO9eGj/scene.splinecode"
        onLoad={() => setIsLoaded(true)}
        style={{ width: '100%', height: '100%' }}
      />
    </div>
  );
};

// Rive Animation Component using useRive hook
const RiveAnimation: React.FC = () => {
  const { RiveComponent } = useRive({
    src: 'https://cdn.rive.app/animations/vehicles.riv',
    stateMachines: 'bouncing-drive',
    autoplay: true,
  });

  return (
    <div className="w-full h-[300px] rounded-lg overflow-hidden border-2 border-orange-200 bg-orange-50">
      <RiveComponent style={{ width: '100%', height: '100%' }} />
    </div>
  );
};

// Lottie Animation Component (placeholder example)
const LottieAnimation: React.FC = () => {
  // Note: Replace with actual Lottie JSON data or URL
  const animationData = {
    // This is a placeholder - in production, load actual Lottie JSON
    v: "5.5.7",
    fr: 60,
    ip: 0,
    op: 180,
    w: 400,
    h: 400,
    nm: "Placeholder",
    ddd: 0,
    assets: [],
    layers: [],
  };

  return (
    <div className="w-full h-[300px] rounded-lg overflow-hidden border-2 border-green-200 bg-green-50 flex items-center justify-center">
      <Lottie animationData={animationData} loop={true} className="w-full h-full" />
      <p className="absolute text-sm text-green-700">Add Lottie JSON data here</p>
    </div>
  );
};

// Example usage with Framer Motion
const MotionButton: React.FC = () => {
  return (
    <motion.div
      whileHover={{ scale: 1.05 }}
      whileTap={{ scale: 0.95 }}
      transition={{ type: "spring", stiffness: 400, damping: 17 }}
    >
      <Button className="w-full">
        <Play className="mr-2 h-4 w-4" />
        Interactive Example
      </Button>
    </motion.div>
  );
};

// Main InteractiveSim Component
export const InteractiveSim: React.FC = () => {
  const [selectedPhetSim, setSelectedPhetSim] = useState('forces-and-motion');

  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <motion.div
            animate={{ rotate: 360 }}
            transition={{ duration: 2, repeat: Infinity, ease: "linear" }}
            className="w-8 h-8 rounded-full bg-gradient-to-r from-purple-500 to-blue-500"
          />
          Interactive Simulations
        </CardTitle>
        <CardDescription>
          Examples of PhET, Spline 3D, Rive, and Lottie integrations
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Tabs defaultValue="phet" className="w-full">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="phet">PhET Simulations</TabsTrigger>
            <TabsTrigger value="spline">Spline 3D</TabsTrigger>
            <TabsTrigger value="rive">Rive Anim</TabsTrigger>
            <TabsTrigger value="lottie">Lottie</TabsTrigger>
          </TabsList>

          <TabsContent value="phet" className="space-y-4">
            <div className="space-y-2">
              <label className="text-sm font-medium">Select Simulation:</label>
              <select
                value={selectedPhetSim}
                onChange={(e) => setSelectedPhetSim(e.target.value)}
                className="w-full p-2 border rounded-md"
              >
                <option value="forces-and-motion">Forces and Motion Basics</option>
                <option value="energy-skate-park">Energy Skate Park</option>
                <option value="balancing-act">Balancing Act</option>
              </select>
            </div>
            <PhETSimulation
              simUrl={PHET_SIMULATIONS[selectedPhetSim as keyof typeof PHET_SIMULATIONS]}
              title={selectedPhetSim}
            />
            <a
              href="https://phet.colorado.edu/"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-sm text-purple-600 hover:underline"
            >
              <ExternalLink className="h-4 w-4" />
              More simulations at PhET
            </a>
          </TabsContent>

          <TabsContent value="spline" className="space-y-4">
            <div className="text-sm text-gray-600 mb-4">
              Interactive 3D scene powered by Spline
            </div>
            <SplineScene />
            <a
              href="https://spline.design/"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-sm text-blue-600 hover:underline"
            >
              <ExternalLink className="h-4 w-4" />
              Create your own at Spline
            </a>
          </TabsContent>

          <TabsContent value="rive" className="space-y-4">
            <div className="text-sm text-gray-600 mb-4">
              Interactive animation powered by Rive
            </div>
            <RiveAnimation />
            <a
              href="https://rive.app/"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-sm text-orange-600 hover:underline"
            >
              <ExternalLink className="h-4 w-4" />
              Explore animations at Rive
            </a>
          </TabsContent>

          <TabsContent value="lottie" className="space-y-4">
            <div className="text-sm text-gray-600 mb-4">
              Lottie animation (replace with actual Lottie JSON data)
            </div>
            <LottieAnimation />
            <a
              href="https://lottiefiles.com/"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-sm text-green-600 hover:underline"
            >
              <ExternalLink className="h-4 w-4" />
              Find animations at LottieFiles
            </a>
          </TabsContent>
        </Tabs>

        <div className="mt-8 pt-8 border-t">
          <div className="text-sm font-medium mb-4">Framer Motion Button Example:</div>
          <MotionButton />
        </div>
      </CardContent>
    </Card>
  );
};

export default InteractiveSim;
