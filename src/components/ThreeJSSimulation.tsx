import React, { useRef, useEffect, useState } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls } from '@react-three/drei';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

interface ThreeJSSimulationProps {
  type: 'physics' | 'astronomy' | 'chemistry';
  title?: string;
  onSimulationEnd?: () => void;
}

export const ThreeJSSimulation: React.FC<ThreeJSSimulationProps> = ({ type, title, onSimulationEnd }) => {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [isLoaded, setIsLoaded] = useState(false);

  const handlePhysicsSimulation = () => {
    console.log('[ThreeJSSimulation] Initializing physics simulation');
    // Placeholder for physics simulation
    // In production, this would create 3D physics objects, forces, etc.
  };

  const handleAstronomySimulation = () => {
    console.log('[ThreeJSSimulation] Initializing astronomy simulation');
    // Placeholder for astronomy simulation
    // In production, this would create planets, stars, orbits, etc.
  };

  const handleChemistrySimulation = () => {
    console.log('[ThreeJSSimulation] Initializing chemistry simulation');
    // Placeholder for chemistry simulation
    // In production, this would create molecules, atoms, reactions, etc.
  };

  const getSimulation = () => {
    switch (type) {
      case 'physics':
        return <PhysicsSimulation />;
      case 'astronomy':
        return <AstronomySimulation />;
      case 'chemistry':
        return <ChemistrySimulation />;
      default:
        return null;
    }
  };

  useEffect(() => {
    if (canvasRef.current) {
      const canvas = canvasRef.current;
      if (canvas) {
        const resizeObserver = new ResizeObserver(() => {
          if (canvasRef.current) {
            const container = canvasRef.current.parentElement;
            if (container) {
              canvas.width = container.clientWidth;
              canvas.height = container.clientHeight || 600;
            }
          }
        });

        resizeObserver.observe(canvas.parentElement!);
        return () => resizeObserver.disconnect();
      };
    }
  });

  return (
    <Card className="w-full border-primary/20">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2">
          <span className="text-2xl">🪐</span>
          3D {title || 'Simulation'}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <Canvas
          ref={canvasRef}
          camera={{ position: [0, 0, 5], fov: 50 }}
          onCreated={() => setIsLoaded(true)}
          className="w-full h-[600px] rounded-lg"
        >
          <ambientLight intensity={0.5} />
          <pointLight position={[10, 10, 10]} intensity={1} />
          <OrbitControls enableDamping dampingFactor={0.05} rotateSpeed={0.5} />

          {getSimulation()}
        </Canvas>

        {isLoaded && (
          <div className="mt-4 flex justify-between items-center gap-4">
            <p className="text-sm text-muted-foreground">
              Click and drag to rotate • Scroll to zoom
            </p>
            {onSimulationEnd && (
              <button
                onClick={onSimulationEnd}
                className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 transition-colors"
              >
                End Simulation
              </button>
            )}
          </div>
        )}
      </CardContent>
    </Card>
  );
};

// Placeholder components for different simulation types
const PhysicsSimulation = () => (
  <group>
    <mesh position={[0, 0, 0]} rotation={[Math.PI / 2, 0, 0]}>
      <boxGeometry args={[2, 2, 2]} />
      <meshStandardMaterial color="orange" />
    </mesh>
  </group>
);

const AstronomySimulation = () => (
  <group>
    <mesh position={[0, 0, 0]}>
      <sphereGeometry args={[1, 32, 32]} />
      <meshStandardMaterial color="blue" />
    </mesh>
    <mesh position={[2, 0, 0]} rotation={[Math.PI / 2, 0, 0]}>
      <sphereGeometry args={[0.5, 32, 32]} />
      <meshStandardMaterial color="green" />
    </mesh>
  </group>
);

const ChemistrySimulation = () => (
  <group>
    <mesh position={[0, 0, 0]}>
      <icosahedronGeometry args={[1, 0]} />
      <meshStandardMaterial color="purple" />
    </mesh>
  </group>
);
