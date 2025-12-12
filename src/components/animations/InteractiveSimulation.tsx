import { Canvas, useFrame } from '@react-three/fiber';
import { OrbitControls, Sphere, Box, Torus, MeshDistortMaterial, Cylinder, Cone, Text } from '@react-three/drei';
import { Suspense, useRef, useState, useMemo, useCallback } from 'react';
import * as THREE from 'three';
import { Slider } from '@/components/ui/slider';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { RotateCcw, Play, Pause, ZoomIn, ZoomOut, Eye } from 'lucide-react';

interface SimulationProps {
  type: 'atom' | 'solar' | 'cell' | 'dna' | 'molecule' | 'wave' | 'pendulum' | 'heart' | 'planet';
  title?: string;
}

interface ControlsState {
  speed: number;
  scale: number;
  showLabels: boolean;
  paused: boolean;
  electronCount: number;
  planetCount: number;
  waveFrequency: number;
  waveAmplitude: number;
  pendulumLength: number;
  heartRate: number;
}

// ==================== INTERACTIVE ATOM ====================
function InteractiveAtom({ speed, scale, electronCount, showLabels, paused }: { 
  speed: number; 
  scale: number; 
  electronCount: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const groupRef = useRef<THREE.Group>(null);
  const electronRefs = useRef<THREE.Mesh[]>([]);
  
  useFrame((state) => {
    if (groupRef.current && !paused) {
      groupRef.current.rotation.y = state.clock.elapsedTime * speed * 0.5;
    }
    // Animate electrons
    electronRefs.current.forEach((electron, i) => {
      if (electron && !paused) {
        const orbitRadius = 1.2 + i * 0.4;
        const angle = state.clock.elapsedTime * speed * (1 + i * 0.3) + i * Math.PI * 0.6;
        electron.position.x = Math.cos(angle) * orbitRadius;
        electron.position.z = Math.sin(angle) * orbitRadius;
      }
    });
  });

  return (
    <group ref={groupRef} scale={scale}>
      {/* Nucleus */}
      <Sphere args={[0.35, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[0.1, 0.1, 0]}>
        <meshStandardMaterial color="#3B82F6" />
      </Sphere>
      <Sphere args={[0.28, 32, 32]} position={[-0.08, -0.08, 0.1]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      
      {showLabels && (
        <Text position={[0, -0.8, 0]} fontSize={0.2} color="white">
          Nucleus
        </Text>
      )}
      
      {/* Electron orbits and electrons */}
      {Array.from({ length: Math.min(electronCount, 5) }).map((_, i) => {
        const orbitRadius = 1.2 + i * 0.4;
        return (
          <group key={i} rotation={[i * 0.3, i * 0.2, i * 0.1]}>
            <Torus args={[orbitRadius, 0.015, 16, 100]}>
              <meshStandardMaterial color="#60A5FA" opacity={0.4} transparent />
            </Torus>
            <Sphere 
              ref={(el) => { if (el) electronRefs.current[i] = el; }}
              args={[0.08, 16, 16]} 
              position={[orbitRadius, 0, 0]}
            >
              <meshStandardMaterial color="#fff" emissive="#60A5FA" emissiveIntensity={1} />
            </Sphere>
            {showLabels && i === 0 && (
              <Text position={[orbitRadius + 0.3, 0.2, 0]} fontSize={0.15} color="white">
                Electron
              </Text>
            )}
          </group>
        );
      })}
    </group>
  );
}

// ==================== INTERACTIVE SOLAR SYSTEM ====================
function InteractiveSolarSystem({ speed, scale, planetCount, showLabels, paused }: {
  speed: number;
  scale: number;
  planetCount: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const planetRefs = useRef<THREE.Group[]>([]);
  
  const planets = useMemo(() => [
    { name: 'Mercury', color: '#94A3B8', size: 0.08, distance: 0.8, speed: 4.0 },
    { name: 'Venus', color: '#FCD34D', size: 0.12, distance: 1.1, speed: 1.6 },
    { name: 'Earth', color: '#22C55E', size: 0.13, distance: 1.5, speed: 1.0 },
    { name: 'Mars', color: '#EF4444', size: 0.1, distance: 1.9, speed: 0.5 },
    { name: 'Jupiter', color: '#C4A77D', size: 0.25, distance: 2.5, speed: 0.1 },
    { name: 'Saturn', color: '#D4A574', size: 0.22, distance: 3.2, speed: 0.05 },
    { name: 'Uranus', color: '#67E8F9', size: 0.16, distance: 3.8, speed: 0.02 },
    { name: 'Neptune', color: '#3B82F6', size: 0.15, distance: 4.3, speed: 0.01 },
  ], []);

  useFrame((state) => {
    if (paused) return;
    planetRefs.current.forEach((planet, i) => {
      if (planet && i < planetCount) {
        const angle = state.clock.elapsedTime * speed * planets[i].speed;
        planet.position.x = Math.cos(angle) * planets[i].distance;
        planet.position.z = Math.sin(angle) * planets[i].distance;
      }
    });
  });

  return (
    <group scale={scale * 0.7}>
      {/* Sun */}
      <Sphere args={[0.35, 32, 32]}>
        <meshStandardMaterial color="#FCD34D" emissive="#F59E0B" emissiveIntensity={0.5} />
      </Sphere>
      <pointLight position={[0, 0, 0]} intensity={1.5} color="#FCD34D" />
      
      {showLabels && (
        <Text position={[0, 0.6, 0]} fontSize={0.15} color="white">Sun</Text>
      )}

      {/* Planets */}
      {planets.slice(0, planetCount).map((planet, i) => (
        <group key={planet.name}>
          {/* Orbit ring */}
          <Torus args={[planet.distance, 0.008, 16, 100]} rotation={[Math.PI / 2, 0, 0]}>
            <meshStandardMaterial color="#475569" opacity={0.3} transparent />
          </Torus>
          
          {/* Planet */}
          <group ref={(el) => { if (el) planetRefs.current[i] = el; }}>
            <Sphere args={[planet.size, 32, 32]}>
              <meshStandardMaterial color={planet.color} />
            </Sphere>
            {planet.name === 'Saturn' && (
              <Torus args={[planet.size * 1.5, planet.size * 0.3, 2, 32]} rotation={[Math.PI / 2.5, 0, 0]}>
                <meshStandardMaterial color="#A16207" opacity={0.7} transparent />
              </Torus>
            )}
            {planet.name === 'Earth' && (
              <Sphere args={[planet.size * 0.27, 16, 16]} position={[planet.size * 1.5, 0, 0]}>
                <meshStandardMaterial color="#9CA3AF" />
              </Sphere>
            )}
            {showLabels && (
              <Text position={[0, planet.size + 0.15, 0]} fontSize={0.1} color="white">
                {planet.name}
              </Text>
            )}
          </group>
        </group>
      ))}
    </group>
  );
}

// ==================== INTERACTIVE CELL ====================
function InteractiveCell({ speed, scale, showLabels, paused }: {
  speed: number;
  scale: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current && !paused) {
      groupRef.current.rotation.y = state.clock.elapsedTime * speed * 0.2;
    }
  });

  return (
    <group ref={groupRef} scale={scale}>
      {/* Cell membrane */}
      <Sphere args={[1.5, 64, 64]}>
        <MeshDistortMaterial color="#22C55E" distort={0.15} speed={paused ? 0 : speed * 2} opacity={0.4} transparent />
      </Sphere>
      
      {/* Nucleus */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#3B82F6" />
      </Sphere>
      <Sphere args={[0.2, 16, 16]} position={[0.1, 0.1, 0]}>
        <meshStandardMaterial color="#1E40AF" />
      </Sphere>
      {showLabels && (
        <Text position={[0, -0.8, 0]} fontSize={0.12} color="white">Nucleus</Text>
      )}
      
      {/* Mitochondria */}
      {[0, 1, 2, 3].map((i) => (
        <group key={`mito-${i}`} position={[Math.cos(i * 1.5) * 0.9, Math.sin(i * 1.5) * 0.9, 0]}>
          <Cylinder args={[0.08, 0.12, 0.35, 16]} rotation={[Math.PI / 2, i * 0.5, 0]}>
            <meshStandardMaterial color="#F97316" />
          </Cylinder>
          {showLabels && i === 0 && (
            <Text position={[0.3, 0, 0]} fontSize={0.1} color="white">Mitochondria</Text>
          )}
        </group>
      ))}
      
      {/* Endoplasmic Reticulum */}
      <Torus args={[0.7, 0.06, 8, 32]} position={[-0.3, 0.3, 0.3]} rotation={[0.5, 0.3, 0]}>
        <meshStandardMaterial color="#A855F7" opacity={0.7} transparent />
      </Torus>
      {showLabels && (
        <Text position={[-0.3, 0.7, 0.3]} fontSize={0.08} color="white">ER</Text>
      )}
      
      {/* Ribosomes */}
      {[...Array(10)].map((_, i) => (
        <Sphere 
          key={`ribo-${i}`} 
          args={[0.05, 8, 8]} 
          position={[
            Math.cos(i * 0.6) * 1.1,
            Math.sin(i * 0.6) * 1.1,
            (Math.random() - 0.5) * 0.4
          ]}
        >
          <meshStandardMaterial color="#14B8A6" />
        </Sphere>
      ))}
    </group>
  );
}

// ==================== INTERACTIVE DNA ====================
function InteractiveDNA({ speed, scale, showLabels, paused }: {
  speed: number;
  scale: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current && !paused) {
      groupRef.current.rotation.y = state.clock.elapsedTime * speed * 0.3;
    }
  });

  const basePairColors = useMemo(() => ({
    A: '#EF4444', // Adenine - Red
    T: '#22C55E', // Thymine - Green
    G: '#3B82F6', // Guanine - Blue
    C: '#F59E0B', // Cytosine - Yellow
  }), []);

  return (
    <group ref={groupRef} scale={scale}>
      {[...Array(18)].map((_, i) => {
        const y = i * 0.3 - 2.5;
        const angle = i * 0.55;
        const isAT = i % 2 === 0;
        
        return (
          <group key={i} position={[0, y, 0]} rotation={[0, angle, 0]}>
            {/* Sugar-phosphate backbone */}
            <Sphere args={[0.1, 16, 16]} position={[0.6, 0, 0]}>
              <meshStandardMaterial color="#60A5FA" />
            </Sphere>
            <Sphere args={[0.1, 16, 16]} position={[-0.6, 0, 0]}>
              <meshStandardMaterial color="#60A5FA" />
            </Sphere>
            
            {/* Base pairs */}
            <Box args={[0.45, 0.06, 0.06]} position={[0.27, 0, 0]}>
              <meshStandardMaterial color={isAT ? basePairColors.A : basePairColors.G} />
            </Box>
            <Box args={[0.45, 0.06, 0.06]} position={[-0.27, 0, 0]}>
              <meshStandardMaterial color={isAT ? basePairColors.T : basePairColors.C} />
            </Box>
            
            {showLabels && i === 9 && (
              <>
                <Text position={[0.9, 0, 0]} fontSize={0.08} color="white">Sugar-Phosphate</Text>
                <Text position={[0.27, 0.2, 0]} fontSize={0.06} color="white">{isAT ? 'A' : 'G'}</Text>
                <Text position={[-0.27, 0.2, 0]} fontSize={0.06} color="white">{isAT ? 'T' : 'C'}</Text>
              </>
            )}
          </group>
        );
      })}
      
      {showLabels && (
        <Text position={[0, 3.2, 0]} fontSize={0.15} color="white">DNA Double Helix</Text>
      )}
    </group>
  );
}

// ==================== INTERACTIVE WAVE ====================
function InteractiveWave({ speed, scale, frequency, amplitude, showLabels, paused }: {
  speed: number;
  scale: number;
  frequency: number;
  amplitude: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const waveRef = useRef<THREE.Group>(null);
  const pointRefs = useRef<THREE.Mesh[]>([]);
  const timeRef = useRef(0);
  
  useFrame((state, delta) => {
    if (!paused) {
      timeRef.current += delta * speed;
    }
    
    pointRefs.current.forEach((point, i) => {
      if (point) {
        const x = (i - 25) * 0.15;
        point.position.y = Math.sin(x * frequency + timeRef.current * 3) * amplitude;
      }
    });
  });

  return (
    <group ref={waveRef} scale={scale}>
      {/* Wave points */}
      {Array.from({ length: 50 }).map((_, i) => {
        const x = (i - 25) * 0.15;
        return (
          <Sphere 
            key={i}
            ref={(el) => { if (el) pointRefs.current[i] = el; }}
            args={[0.06, 16, 16]} 
            position={[x, 0, 0]}
          >
            <meshStandardMaterial color="#06B6D4" emissive="#06B6D4" emissiveIntensity={0.3} />
          </Sphere>
        );
      })}
      
      {/* Wave line connecting points */}
      <Box args={[7.5, 0.02, 0.02]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#0891B2" opacity={0.3} transparent />
      </Box>
      
      {showLabels && (
        <>
          <Text position={[0, 1.5, 0]} fontSize={0.15} color="white">Transverse Wave</Text>
          <Text position={[-2.5, -1.2, 0]} fontSize={0.1} color="white">λ (Wavelength)</Text>
          <Text position={[2.5, amplitude + 0.3, 0]} fontSize={0.1} color="white">Amplitude</Text>
        </>
      )}
    </group>
  );
}

// ==================== INTERACTIVE PENDULUM ====================
function InteractivePendulum({ speed, scale, length, showLabels, paused }: {
  speed: number;
  scale: number;
  length: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const pendulumRef = useRef<THREE.Group>(null);
  const timeRef = useRef(0);
  
  useFrame((state, delta) => {
    if (!paused) {
      timeRef.current += delta * speed;
    }
    
    if (pendulumRef.current) {
      // Simple harmonic motion approximation
      const gravity = 9.8;
      const period = 2 * Math.PI * Math.sqrt(length / gravity);
      const angle = 0.5 * Math.sin(timeRef.current * (2 * Math.PI / period) * 2);
      pendulumRef.current.rotation.z = angle;
    }
  });

  return (
    <group scale={scale}>
      {/* Fixed point */}
      <Sphere args={[0.15, 16, 16]} position={[0, 2, 0]}>
        <meshStandardMaterial color="#475569" />
      </Sphere>
      
      {/* Pendulum arm and bob */}
      <group ref={pendulumRef} position={[0, 2, 0]}>
        <Cylinder args={[0.03, 0.03, length, 8]} position={[0, -length / 2, 0]}>
          <meshStandardMaterial color="#94A3B8" />
        </Cylinder>
        <Sphere args={[0.25, 32, 32]} position={[0, -length, 0]}>
          <meshStandardMaterial color="#F59E0B" metalness={0.3} roughness={0.4} />
        </Sphere>
        
        {showLabels && (
          <>
            <Text position={[0.5, -length / 2, 0]} fontSize={0.12} color="white">L = {length.toFixed(1)}m</Text>
            <Text position={[0.5, -length, 0]} fontSize={0.1} color="white">Bob</Text>
          </>
        )}
      </group>
      
      {/* Ground reference */}
      <Box args={[3, 0.05, 0.5]} position={[0, -length + 1.5, 0]}>
        <meshStandardMaterial color="#374151" />
      </Box>
      
      {showLabels && (
        <Text position={[0, 2.5, 0]} fontSize={0.15} color="white">Simple Pendulum</Text>
      )}
    </group>
  );
}

// ==================== INTERACTIVE HEART ====================
function InteractiveHeart({ speed, scale, heartRate, showLabels, paused }: {
  speed: number;
  scale: number;
  heartRate: number;
  showLabels: boolean;
  paused: boolean;
}) {
  const heartRef = useRef<THREE.Group>(null);
  const timeRef = useRef(0);
  
  useFrame((state, delta) => {
    if (!paused) {
      timeRef.current += delta;
    }
    
    if (heartRef.current) {
      // Heartbeat animation based on BPM
      const beatFrequency = heartRate / 60;
      const beatPhase = (timeRef.current * beatFrequency * speed) % 1;
      const beatScale = 1 + Math.sin(beatPhase * Math.PI * 2) * 0.08 * (beatPhase < 0.3 ? 1 : 0);
      heartRef.current.scale.setScalar(scale * (1 + beatScale));
    }
  });

  return (
    <group ref={heartRef} scale={scale}>
      {/* Main chambers */}
      <Sphere args={[0.6, 32, 32]} position={[-0.35, 0.1, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      <Sphere args={[0.6, 32, 32]} position={[0.35, 0.1, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      
      {/* Bottom apex */}
      <Cone args={[0.7, 1, 32]} position={[0, -0.7, 0]} rotation={[Math.PI, 0, 0]}>
        <meshStandardMaterial color="#DC2626" />
      </Cone>
      
      {/* Aorta */}
      <Cylinder args={[0.12, 0.15, 0.5]} position={[-0.2, 0.65, 0]} rotation={[0.2, 0, 0.15]}>
        <meshStandardMaterial color="#B91C1C" />
      </Cylinder>
      
      {/* Pulmonary artery */}
      <Cylinder args={[0.1, 0.12, 0.4]} position={[0.2, 0.6, 0]} rotation={[0.2, 0, -0.2]}>
        <meshStandardMaterial color="#1E40AF" />
      </Cylinder>
      
      {showLabels && (
        <>
          <Text position={[0, 1.3, 0]} fontSize={0.12} color="white">{heartRate} BPM</Text>
          <Text position={[-0.6, 0.8, 0]} fontSize={0.08} color="white">Aorta</Text>
          <Text position={[0.6, 0.75, 0]} fontSize={0.08} color="white">Pulmonary</Text>
          <Text position={[-0.5, 0.1, 0.3]} fontSize={0.08} color="white">Left Atrium</Text>
          <Text position={[0.5, 0.1, 0.3]} fontSize={0.08} color="white">Right Atrium</Text>
        </>
      )}
    </group>
  );
}

// ==================== MAIN SIMULATION COMPONENT ====================
function Scene3D({ type, controls }: { type: SimulationProps['type']; controls: ControlsState }) {
  const renderModel = useCallback(() => {
    switch (type) {
      case 'atom':
        return <InteractiveAtom 
          speed={controls.speed} 
          scale={controls.scale} 
          electronCount={controls.electronCount}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'solar':
        return <InteractiveSolarSystem 
          speed={controls.speed} 
          scale={controls.scale} 
          planetCount={controls.planetCount}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'cell':
        return <InteractiveCell 
          speed={controls.speed} 
          scale={controls.scale}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'dna':
        return <InteractiveDNA 
          speed={controls.speed} 
          scale={controls.scale}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'wave':
        return <InteractiveWave 
          speed={controls.speed} 
          scale={controls.scale}
          frequency={controls.waveFrequency}
          amplitude={controls.waveAmplitude}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'pendulum':
        return <InteractivePendulum 
          speed={controls.speed} 
          scale={controls.scale}
          length={controls.pendulumLength}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      case 'heart':
        return <InteractiveHeart 
          speed={controls.speed} 
          scale={controls.scale}
          heartRate={controls.heartRate}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
      default:
        return <InteractiveAtom 
          speed={controls.speed} 
          scale={controls.scale} 
          electronCount={3}
          showLabels={controls.showLabels}
          paused={controls.paused}
        />;
    }
  }, [type, controls]);

  return (
    <Canvas camera={{ position: [0, 0, 6], fov: 50 }}>
      <ambientLight intensity={0.4} />
      <directionalLight position={[10, 10, 5]} intensity={1} />
      <pointLight position={[-10, -10, -5]} intensity={0.3} />
      <Suspense fallback={null}>
        {renderModel()}
      </Suspense>
      <OrbitControls 
        enableZoom={true} 
        enablePan={true}
        minDistance={2}
        maxDistance={15}
      />
    </Canvas>
  );
}

export default function InteractiveSimulation({ type, title }: SimulationProps) {
  const [controls, setControls] = useState<ControlsState>({
    speed: 1,
    scale: 1,
    showLabels: true,
    paused: false,
    electronCount: 3,
    planetCount: 4,
    waveFrequency: 2,
    waveAmplitude: 0.5,
    pendulumLength: 2,
    heartRate: 72,
  });

  const resetControls = () => {
    setControls({
      speed: 1,
      scale: 1,
      showLabels: true,
      paused: false,
      electronCount: 3,
      planetCount: 4,
      waveFrequency: 2,
      waveAmplitude: 0.5,
      pendulumLength: 2,
      heartRate: 72,
    });
  };

  const getTypeSpecificControls = () => {
    switch (type) {
      case 'atom':
        return (
          <div className="space-y-3">
            <div>
              <Label className="text-xs text-muted-foreground">Electrons: {controls.electronCount}</Label>
              <Slider
                value={[controls.electronCount]}
                onValueChange={([v]) => setControls(c => ({ ...c, electronCount: v }))}
                min={1}
                max={5}
                step={1}
                className="mt-1"
              />
            </div>
          </div>
        );
      case 'solar':
        return (
          <div className="space-y-3">
            <div>
              <Label className="text-xs text-muted-foreground">Planets: {controls.planetCount}</Label>
              <Slider
                value={[controls.planetCount]}
                onValueChange={([v]) => setControls(c => ({ ...c, planetCount: v }))}
                min={1}
                max={8}
                step={1}
                className="mt-1"
              />
            </div>
          </div>
        );
      case 'wave':
        return (
          <div className="space-y-3">
            <div>
              <Label className="text-xs text-muted-foreground">Frequency: {controls.waveFrequency.toFixed(1)}</Label>
              <Slider
                value={[controls.waveFrequency]}
                onValueChange={([v]) => setControls(c => ({ ...c, waveFrequency: v }))}
                min={0.5}
                max={5}
                step={0.1}
                className="mt-1"
              />
            </div>
            <div>
              <Label className="text-xs text-muted-foreground">Amplitude: {controls.waveAmplitude.toFixed(1)}</Label>
              <Slider
                value={[controls.waveAmplitude]}
                onValueChange={([v]) => setControls(c => ({ ...c, waveAmplitude: v }))}
                min={0.1}
                max={1.5}
                step={0.1}
                className="mt-1"
              />
            </div>
          </div>
        );
      case 'pendulum':
        return (
          <div className="space-y-3">
            <div>
              <Label className="text-xs text-muted-foreground">Length: {controls.pendulumLength.toFixed(1)}m</Label>
              <Slider
                value={[controls.pendulumLength]}
                onValueChange={([v]) => setControls(c => ({ ...c, pendulumLength: v }))}
                min={0.5}
                max={4}
                step={0.1}
                className="mt-1"
              />
            </div>
          </div>
        );
      case 'heart':
        return (
          <div className="space-y-3">
            <div>
              <Label className="text-xs text-muted-foreground">Heart Rate: {controls.heartRate} BPM</Label>
              <Slider
                value={[controls.heartRate]}
                onValueChange={([v]) => setControls(c => ({ ...c, heartRate: v }))}
                min={40}
                max={180}
                step={1}
                className="mt-1"
              />
            </div>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <div className="w-full rounded-xl overflow-hidden bg-card border border-border">
      {title && (
        <div className="px-4 py-2 border-b border-border bg-muted/30">
          <h3 className="font-semibold text-sm">{title}</h3>
        </div>
      )}
      
      {/* 3D Canvas */}
      <div className="h-80 bg-gradient-to-b from-background to-muted/20">
        <Scene3D type={type} controls={controls} />
      </div>
      
      {/* Controls Panel */}
      <div className="p-4 border-t border-border bg-muted/10 space-y-4">
        {/* Playback controls */}
        <div className="flex items-center gap-2 flex-wrap">
          <Button
            size="sm"
            variant={controls.paused ? "default" : "secondary"}
            onClick={() => setControls(c => ({ ...c, paused: !c.paused }))}
          >
            {controls.paused ? <Play className="w-4 h-4" /> : <Pause className="w-4 h-4" />}
          </Button>
          <Button
            size="sm"
            variant="outline"
            onClick={resetControls}
          >
            <RotateCcw className="w-4 h-4" />
          </Button>
          <Button
            size="sm"
            variant={controls.showLabels ? "default" : "outline"}
            onClick={() => setControls(c => ({ ...c, showLabels: !c.showLabels }))}
          >
            <Eye className="w-4 h-4 mr-1" />
            Labels
          </Button>
          <div className="flex items-center gap-1 ml-auto">
            <ZoomOut className="w-4 h-4 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">Scroll to zoom</span>
            <ZoomIn className="w-4 h-4 text-muted-foreground" />
          </div>
        </div>
        
        {/* Common controls */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <Label className="text-xs text-muted-foreground">Speed: {controls.speed.toFixed(1)}x</Label>
            <Slider
              value={[controls.speed]}
              onValueChange={([v]) => setControls(c => ({ ...c, speed: v }))}
              min={0.1}
              max={3}
              step={0.1}
              className="mt-1"
            />
          </div>
          <div>
            <Label className="text-xs text-muted-foreground">Scale: {controls.scale.toFixed(1)}x</Label>
            <Slider
              value={[controls.scale]}
              onValueChange={([v]) => setControls(c => ({ ...c, scale: v }))}
              min={0.5}
              max={2}
              step={0.1}
              className="mt-1"
            />
          </div>
        </div>
        
        {/* Type-specific controls */}
        {getTypeSpecificControls()}
        
        <p className="text-xs text-muted-foreground text-center">
          Click and drag to rotate • Scroll to zoom • Right-click to pan
        </p>
      </div>
    </div>
  );
}
