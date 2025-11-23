import { Canvas } from '@react-three/fiber';
import { OrbitControls, Sphere } from '@react-three/drei';
import { useRef } from 'react';
import { Group } from 'three';
import { useFrame } from '@react-three/fiber';

function MoleculeStructure() {
  const groupRef = useRef<Group>(null);

  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.y = state.clock.elapsedTime * 0.5;
    }
  });

  return (
    <group ref={groupRef}>
      {/* Central atom */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#10B981" />
      </Sphere>
      
      {/* Surrounding atoms */}
      {[0, 1, 2, 3].map((i) => {
        const angle = (i * Math.PI * 2) / 4;
        const radius = 2;
        return (
          <Sphere
            key={i}
            args={[0.3, 32, 32]}
            position={[Math.cos(angle) * radius, 0, Math.sin(angle) * radius]}
          >
            <meshStandardMaterial color="#3B82F6" />
          </Sphere>
        );
      })}
    </group>
  );
}

export default function ChemistryAnimation() {
  return (
    <div className="w-full h-64 rounded-lg overflow-hidden bg-muted/20">
      <Canvas camera={{ position: [0, 2, 6] }}>
        <ambientLight intensity={0.5} />
        <directionalLight position={[10, 10, 5]} intensity={1} />
        <MoleculeStructure />
        <OrbitControls enableZoom={false} />
      </Canvas>
    </div>
  );
}
