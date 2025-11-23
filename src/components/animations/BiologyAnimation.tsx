import { Canvas } from '@react-three/fiber';
import { OrbitControls, Torus } from '@react-three/drei';
import { useRef } from 'react';
import { Group } from 'three';
import { useFrame } from '@react-three/fiber';

function DNAHelix() {
  const groupRef = useRef<Group>(null);

  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.y = state.clock.elapsedTime * 0.3;
    }
  });

  return (
    <group ref={groupRef}>
      {Array.from({ length: 20 }).map((_, i) => {
        const y = (i - 10) * 0.3;
        const angle = i * 0.5;
        const radius = 1;
        
        return (
          <group key={i}>
            <Torus
              args={[0.1, 0.05, 16, 32]}
              position={[Math.cos(angle) * radius, y, Math.sin(angle) * radius]}
              rotation={[Math.PI / 2, angle, 0]}
            >
              <meshStandardMaterial color={i % 2 === 0 ? "#EC4899" : "#8B5CF6"} />
            </Torus>
          </group>
        );
      })}
    </group>
  );
}

export default function BiologyAnimation() {
  return (
    <div className="w-full h-64 rounded-lg overflow-hidden bg-muted/20">
      <Canvas camera={{ position: [3, 3, 5] }}>
        <ambientLight intensity={0.5} />
        <directionalLight position={[10, 10, 5]} intensity={1} />
        <DNAHelix />
        <OrbitControls enableZoom={false} />
      </Canvas>
    </div>
  );
}
