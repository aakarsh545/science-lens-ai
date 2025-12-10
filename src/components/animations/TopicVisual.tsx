import { Canvas } from '@react-three/fiber';
import { OrbitControls, Sphere, Box, Torus, MeshDistortMaterial, useTexture } from '@react-three/drei';
import { Suspense, useMemo } from 'react';
import { Loader2, Image as ImageIcon } from 'lucide-react';

interface TopicVisualProps {
  topic: string;
  title?: string;
  type?: 'image' | '3d' | 'auto';
}

// Topic to visual mapping
const TOPIC_VISUALS: Record<string, { type: 'image' | '3d'; imageUrl?: string; model?: string; color?: string }> = {
  // Physics
  'atomic': { type: '3d', model: 'atom', color: '#3B82F6' },
  'atom': { type: '3d', model: 'atom', color: '#3B82F6' },
  'nuclear': { type: '3d', model: 'atom', color: '#EF4444' },
  'force': { type: '3d', model: 'force', color: '#10B981' },
  'motion': { type: '3d', model: 'motion', color: '#8B5CF6' },
  'gravity': { type: '3d', model: 'gravity', color: '#6366F1' },
  'wave': { type: '3d', model: 'wave', color: '#06B6D4' },
  'energy': { type: '3d', model: 'energy', color: '#F59E0B' },
  'electric': { type: '3d', model: 'electric', color: '#EAB308' },
  'magnetic': { type: '3d', model: 'magnetic', color: '#EC4899' },
  'quantum': { type: '3d', model: 'quantum', color: '#7C3AED' },
  
  // Astronomy
  'big bang': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800' },
  'galaxy': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1543722530-d2c3201371e7?w=800' },
  'star': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800' },
  'planet': { type: '3d', model: 'planet', color: '#3B82F6' },
  'solar': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1614732414444-096e5f1122d5?w=800' },
  'black hole': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1634176866089-b633f4aec882?w=800' },
  'nebula': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?w=800' },
  
  // Biology
  'cell': { type: '3d', model: 'cell', color: '#22C55E' },
  'dna': { type: '3d', model: 'dna', color: '#3B82F6' },
  'digestion': { type: '3d', model: 'organ', color: '#F97316' },
  'heart': { type: '3d', model: 'organ', color: '#EF4444' },
  'brain': { type: '3d', model: 'brain', color: '#EC4899' },
  'neuron': { type: '3d', model: 'neuron', color: '#8B5CF6' },
  'evolution': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800' },
  'ecosystem': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800' },
  
  // Chemistry
  'molecule': { type: '3d', model: 'molecule', color: '#06B6D4' },
  'bond': { type: '3d', model: 'molecule', color: '#14B8A6' },
  'reaction': { type: '3d', model: 'reaction', color: '#F59E0B' },
  'periodic': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1532634922-8fe0b757fb13?w=800' },
  'crystal': { type: '3d', model: 'crystal', color: '#A855F7' },
  
  // Earth Science
  'volcano': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1562095241-8c6714fd4178?w=800' },
  'earthquake': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1509099836639-18ba1795216d?w=800' },
  'climate': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1561484930-974554019ade?w=800' },
  'ocean': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=800' },
  'atmosphere': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1534088568595-a066f410bcda?w=800' },
  
  // Technology
  'robot': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800' },
  'circuit': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800' },
  'sensor': { type: '3d', model: 'tech', color: '#22D3EE' },
};

function AtomModel({ color }: { color: string }) {
  return (
    <group>
      {/* Nucleus */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color={color} />
      </Sphere>
      {/* Electron orbits */}
      {[0, 1, 2].map((i) => (
        <group key={i} rotation={[i * 0.5, i * 0.3, 0]}>
          <Torus args={[1.5 + i * 0.3, 0.02, 16, 100]}>
            <meshStandardMaterial color={color} opacity={0.5} transparent />
          </Torus>
          <Sphere args={[0.15, 16, 16]} position={[1.5 + i * 0.3, 0, 0]}>
            <meshStandardMaterial color="#fff" emissive={color} emissiveIntensity={0.5} />
          </Sphere>
        </group>
      ))}
    </group>
  );
}

function MoleculeModel({ color }: { color: string }) {
  return (
    <group>
      <Sphere args={[0.4, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color={color} />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[0.8, 0.5, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[-0.8, 0.5, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      <Sphere args={[0.25, 32, 32]} position={[0, -0.8, 0]}>
        <meshStandardMaterial color="#22C55E" />
      </Sphere>
    </group>
  );
}

function CellModel({ color }: { color: string }) {
  return (
    <group>
      <Sphere args={[1.2, 64, 64]}>
        <MeshDistortMaterial color={color} distort={0.3} speed={2} opacity={0.7} transparent />
      </Sphere>
      {/* Nucleus */}
      <Sphere args={[0.4, 32, 32]} position={[0.2, 0, 0]}>
        <meshStandardMaterial color="#3B82F6" />
      </Sphere>
      {/* Organelles */}
      {[...Array(5)].map((_, i) => (
        <Sphere 
          key={i} 
          args={[0.15, 16, 16]} 
          position={[
            Math.cos(i * 1.2) * 0.7,
            Math.sin(i * 1.2) * 0.7,
            (Math.random() - 0.5) * 0.4
          ]}
        >
          <meshStandardMaterial color="#F59E0B" />
        </Sphere>
      ))}
    </group>
  );
}

function PlanetModel({ color }: { color: string }) {
  return (
    <group>
      <Sphere args={[1, 64, 64]}>
        <MeshDistortMaterial color={color} distort={0.1} speed={1} />
      </Sphere>
      {/* Rings */}
      <Torus args={[1.8, 0.15, 2, 100]} rotation={[Math.PI / 2.5, 0, 0]}>
        <meshStandardMaterial color="#F59E0B" opacity={0.6} transparent />
      </Torus>
    </group>
  );
}

function DNAModel({ color }: { color: string }) {
  return (
    <group>
      {[...Array(10)].map((_, i) => (
        <group key={i} position={[0, i * 0.4 - 2, 0]} rotation={[0, i * 0.6, 0]}>
          <Sphere args={[0.15, 16, 16]} position={[0.5, 0, 0]}>
            <meshStandardMaterial color={color} />
          </Sphere>
          <Sphere args={[0.15, 16, 16]} position={[-0.5, 0, 0]}>
            <meshStandardMaterial color="#EF4444" />
          </Sphere>
          <Box args={[1, 0.05, 0.05]} position={[0, 0, 0]}>
            <meshStandardMaterial color="#94A3B8" />
          </Box>
        </group>
      ))}
    </group>
  );
}

function GenericModel({ color, model }: { color: string; model: string }) {
  return (
    <Sphere args={[1, 100, 200]} scale={1.5}>
      <MeshDistortMaterial
        color={color}
        attach="material"
        distort={0.4}
        speed={1.5}
        roughness={0}
      />
    </Sphere>
  );
}

function Scene3D({ model, color }: { model: string; color: string }) {
  const ModelComponent = useMemo(() => {
    switch (model) {
      case 'atom': return () => <AtomModel color={color} />;
      case 'molecule': return () => <MoleculeModel color={color} />;
      case 'cell': return () => <CellModel color={color} />;
      case 'planet': return () => <PlanetModel color={color} />;
      case 'dna': return () => <DNAModel color={color} />;
      default: return () => <GenericModel color={color} model={model} />;
    }
  }, [model, color]);

  return (
    <Canvas camera={{ position: [0, 0, 5] }}>
      <ambientLight intensity={0.5} />
      <directionalLight position={[10, 10, 5]} intensity={1} />
      <pointLight position={[-10, -10, -5]} intensity={0.5} color={color} />
      <Suspense fallback={null}>
        <ModelComponent />
      </Suspense>
      <OrbitControls enableZoom={false} autoRotate autoRotateSpeed={2} />
    </Canvas>
  );
}

export default function TopicVisual({ topic, title, type = 'auto' }: TopicVisualProps) {
  const searchText = `${topic} ${title || ''}`.toLowerCase();
  
  // Find matching visual
  const visual = useMemo(() => {
    for (const [keyword, config] of Object.entries(TOPIC_VISUALS)) {
      if (searchText.includes(keyword)) {
        return config;
      }
    }
    // Default to generic 3D
    return { type: '3d' as const, model: 'generic', color: '#6366F1' };
  }, [searchText]);

  // Override if type is explicitly set
  const displayType = type === 'auto' ? visual.type : type;

  if (displayType === 'image' && visual.imageUrl) {
    return (
      <div className="w-full h-64 rounded-lg overflow-hidden bg-muted/20 relative">
        <img 
          src={visual.imageUrl} 
          alt={title || topic}
          className="w-full h-full object-cover"
          loading="lazy"
          onError={(e) => {
            // Fallback to 3D if image fails
            e.currentTarget.style.display = 'none';
          }}
        />
        <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-background/80 to-transparent p-3">
          <span className="text-sm text-muted-foreground flex items-center gap-1">
            <ImageIcon className="w-3 h-3" />
            {title || topic}
          </span>
        </div>
      </div>
    );
  }

  return (
    <div className="w-full h-64 rounded-lg overflow-hidden bg-muted/20">
      <Scene3D model={visual.model || 'generic'} color={visual.color || '#6366F1'} />
    </div>
  );
}