import { Canvas } from '@react-three/fiber';
import { OrbitControls, Sphere, Box, Torus, MeshDistortMaterial, Cylinder, Cone, Ring } from '@react-three/drei';
import { Suspense, useMemo, useRef } from 'react';
import { Image as ImageIcon } from 'lucide-react';
import { useFrame } from '@react-three/fiber';
import * as THREE from 'three';

interface TopicVisualProps {
  topic: string;
  title?: string;
  type?: 'image' | '3d' | 'auto';
}

// Topic to visual mapping with diverse models
const TOPIC_VISUALS: Record<string, { type: 'image' | '3d'; imageUrl?: string; model?: string; color?: string }> = {
  // Physics - Forces & Motion
  'atomic': { type: '3d', model: 'atom', color: '#3B82F6' },
  'atom': { type: '3d', model: 'atom', color: '#3B82F6' },
  'nuclear': { type: '3d', model: 'nucleus', color: '#EF4444' },
  'force': { type: '3d', model: 'pendulum', color: '#10B981' },
  'motion': { type: '3d', model: 'pendulum', color: '#8B5CF6' },
  'gravity': { type: '3d', model: 'solarsystem', color: '#6366F1' },
  'wave': { type: '3d', model: 'wave', color: '#06B6D4' },
  'energy': { type: '3d', model: 'lightning', color: '#F59E0B' },
  'electric': { type: '3d', model: 'circuit', color: '#EAB308' },
  'magnetic': { type: '3d', model: 'magnet', color: '#EC4899' },
  'quantum': { type: '3d', model: 'quantum', color: '#7C3AED' },
  'thermodynamic': { type: '3d', model: 'heat', color: '#EF4444' },
  'light': { type: '3d', model: 'prism', color: '#F59E0B' },
  'optic': { type: '3d', model: 'lens', color: '#06B6D4' },
  'sound': { type: '3d', model: 'soundwave', color: '#8B5CF6' },
  
  // Astronomy
  'big bang': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800' },
  'galaxy': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1543722530-d2c3201371e7?w=800' },
  'star': { type: '3d', model: 'star', color: '#FCD34D' },
  'planet': { type: '3d', model: 'planet', color: '#3B82F6' },
  'saturn': { type: '3d', model: 'saturn', color: '#D4A574' },
  'jupiter': { type: '3d', model: 'jupiter', color: '#C4A77D' },
  'mars': { type: '3d', model: 'mars', color: '#DC2626' },
  'earth': { type: '3d', model: 'earth', color: '#22C55E' },
  'moon': { type: '3d', model: 'moon', color: '#9CA3AF' },
  'solar': { type: '3d', model: 'solarsystem', color: '#F59E0B' },
  'black hole': { type: '3d', model: 'blackhole', color: '#1F2937' },
  'nebula': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?w=800' },
  'comet': { type: '3d', model: 'comet', color: '#60A5FA' },
  'asteroid': { type: '3d', model: 'asteroid', color: '#78716C' },
  
  // Biology - Organs & Systems
  'cell': { type: '3d', model: 'cell', color: '#22C55E' },
  'dna': { type: '3d', model: 'dna', color: '#3B82F6' },
  'digestion': { type: '3d', model: 'digestive', color: '#F97316' },
  'stomach': { type: '3d', model: 'stomach', color: '#F97316' },
  'intestine': { type: '3d', model: 'intestine', color: '#EC4899' },
  'heart': { type: '3d', model: 'heart', color: '#EF4444' },
  'lung': { type: '3d', model: 'lungs', color: '#F472B6' },
  'respiratory': { type: '3d', model: 'lungs', color: '#F472B6' },
  'brain': { type: '3d', model: 'brain', color: '#EC4899' },
  'neuron': { type: '3d', model: 'neuron', color: '#8B5CF6' },
  'nerve': { type: '3d', model: 'neuron', color: '#A855F7' },
  'muscle': { type: '3d', model: 'muscle', color: '#DC2626' },
  'bone': { type: '3d', model: 'skeleton', color: '#F5F5F4' },
  'skeleton': { type: '3d', model: 'skeleton', color: '#E7E5E4' },
  'eye': { type: '3d', model: 'eye', color: '#3B82F6' },
  'kidney': { type: '3d', model: 'kidney', color: '#7C3AED' },
  'liver': { type: '3d', model: 'liver', color: '#92400E' },
  'blood': { type: '3d', model: 'bloodcell', color: '#DC2626' },
  'evolution': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800' },
  'ecosystem': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800' },
  'virus': { type: '3d', model: 'virus', color: '#84CC16' },
  'bacteria': { type: '3d', model: 'bacteria', color: '#22C55E' },
  'plant': { type: '3d', model: 'plant', color: '#16A34A' },
  'photosynthesis': { type: '3d', model: 'leaf', color: '#22C55E' },
  
  // Chemistry
  'molecule': { type: '3d', model: 'molecule', color: '#06B6D4' },
  'bond': { type: '3d', model: 'molecularbond', color: '#14B8A6' },
  'reaction': { type: '3d', model: 'reaction', color: '#F59E0B' },
  'periodic': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1532634922-8fe0b757fb13?w=800' },
  'crystal': { type: '3d', model: 'crystal', color: '#A855F7' },
  'water': { type: '3d', model: 'water', color: '#3B82F6' },
  'carbon': { type: '3d', model: 'carbon', color: '#374151' },
  'oxygen': { type: '3d', model: 'oxygen', color: '#EF4444' },
  'hydrogen': { type: '3d', model: 'hydrogen', color: '#60A5FA' },
  'acid': { type: '3d', model: 'acid', color: '#84CC16' },
  'base': { type: '3d', model: 'base', color: '#8B5CF6' },
  'polymer': { type: '3d', model: 'polymer', color: '#F97316' },
  'metal': { type: '3d', model: 'metalstructure', color: '#9CA3AF' },
  
  // Earth Science
  'volcano': { type: '3d', model: 'volcano', color: '#EF4444' },
  'earthquake': { type: '3d', model: 'tectonicplates', color: '#78716C' },
  'tectonic': { type: '3d', model: 'tectonicplates', color: '#A16207' },
  'climate': { type: 'image', imageUrl: 'https://images.unsplash.com/photo-1561484930-974554019ade?w=800' },
  'ocean': { type: '3d', model: 'oceanwave', color: '#0EA5E9' },
  'atmosphere': { type: '3d', model: 'atmosphere', color: '#60A5FA' },
  'mountain': { type: '3d', model: 'mountain', color: '#78716C' },
  'rock': { type: '3d', model: 'rock', color: '#57534E' },
  'mineral': { type: '3d', model: 'crystal', color: '#7C3AED' },
  'fossil': { type: '3d', model: 'fossil', color: '#A16207' },
  'weather': { type: '3d', model: 'cloud', color: '#94A3B8' },
  'tornado': { type: '3d', model: 'tornado', color: '#64748B' },
  'glacier': { type: '3d', model: 'glacier', color: '#BAE6FD' },
  
  // Technology & Engineering
  'robot': { type: '3d', model: 'robot', color: '#6366F1' },
  'circuit': { type: '3d', model: 'circuit', color: '#22D3EE' },
  'sensor': { type: '3d', model: 'sensor', color: '#22D3EE' },
  'engine': { type: '3d', model: 'engine', color: '#78716C' },
  'gear': { type: '3d', model: 'gears', color: '#9CA3AF' },
  'rocket': { type: '3d', model: 'rocket', color: '#F97316' },
  'satellite': { type: '3d', model: 'satellite', color: '#60A5FA' },
  'computer': { type: '3d', model: 'chip', color: '#10B981' },
  'battery': { type: '3d', model: 'battery', color: '#22C55E' },
  'solar panel': { type: '3d', model: 'solarpanel', color: '#3B82F6' },
  'wind': { type: '3d', model: 'windturbine', color: '#E5E7EB' },
  'nuclear reactor': { type: '3d', model: 'reactor', color: '#84CC16' },
};

// ==================== 3D MODEL COMPONENTS ====================

function AtomModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.y = state.clock.elapsedTime * 0.5;
    }
  });

  return (
    <group ref={groupRef}>
      {/* Nucleus with protons and neutrons */}
      <Sphere args={[0.3, 32, 32]} position={[0.1, 0.1, 0]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      <Sphere args={[0.25, 32, 32]} position={[-0.1, -0.05, 0.1]}>
        <meshStandardMaterial color="#3B82F6" />
      </Sphere>
      <Sphere args={[0.28, 32, 32]} position={[0, 0.05, -0.1]}>
        <meshStandardMaterial color="#EF4444" />
      </Sphere>
      {/* Electron orbits */}
      {[0, 1, 2].map((i) => (
        <group key={i} rotation={[i * 0.8, i * 0.5, i * 0.3]}>
          <Torus args={[1.2 + i * 0.4, 0.015, 16, 100]}>
            <meshStandardMaterial color={color} opacity={0.4} transparent />
          </Torus>
          <Sphere args={[0.1, 16, 16]} position={[1.2 + i * 0.4, 0, 0]}>
            <meshStandardMaterial color="#fff" emissive={color} emissiveIntensity={0.8} />
          </Sphere>
        </group>
      ))}
    </group>
  );
}

function NucleusModel({ color }: { color: string }) {
  return (
    <group>
      {/* Dense cluster of protons and neutrons */}
      {[...Array(12)].map((_, i) => (
        <Sphere 
          key={i} 
          args={[0.3, 32, 32]} 
          position={[
            (Math.random() - 0.5) * 1,
            (Math.random() - 0.5) * 1,
            (Math.random() - 0.5) * 1
          ]}
        >
          <meshStandardMaterial color={i % 2 === 0 ? '#EF4444' : '#3B82F6'} />
        </Sphere>
      ))}
      {/* Glow effect */}
      <Sphere args={[1.2, 32, 32]}>
        <meshStandardMaterial color={color} opacity={0.15} transparent />
      </Sphere>
    </group>
  );
}

function MoleculeModel({ color }: { color: string }) {
  return (
    <group>
      {/* Central atom */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color={color} metalness={0.3} roughness={0.4} />
      </Sphere>
      {/* Bonded atoms */}
      <Sphere args={[0.35, 32, 32]} position={[1, 0.5, 0]}>
        <meshStandardMaterial color="#EF4444" metalness={0.3} roughness={0.4} />
      </Sphere>
      <Sphere args={[0.35, 32, 32]} position={[-1, 0.5, 0]}>
        <meshStandardMaterial color="#EF4444" metalness={0.3} roughness={0.4} />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[0, -0.9, 0.5]}>
        <meshStandardMaterial color="#22C55E" metalness={0.3} roughness={0.4} />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[0, -0.9, -0.5]}>
        <meshStandardMaterial color="#22C55E" metalness={0.3} roughness={0.4} />
      </Sphere>
      {/* Bonds */}
      <Cylinder args={[0.05, 0.05, 1]} position={[0.5, 0.25, 0]} rotation={[0, 0, -0.5]}>
        <meshStandardMaterial color="#94A3B8" />
      </Cylinder>
      <Cylinder args={[0.05, 0.05, 1]} position={[-0.5, 0.25, 0]} rotation={[0, 0, 0.5]}>
        <meshStandardMaterial color="#94A3B8" />
      </Cylinder>
    </group>
  );
}

function WaterMoleculeModel({ color }: { color: string }) {
  return (
    <group>
      {/* Oxygen */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#EF4444" metalness={0.3} roughness={0.4} />
      </Sphere>
      {/* Hydrogen atoms */}
      <Sphere args={[0.3, 32, 32]} position={[0.8, 0.6, 0]}>
        <meshStandardMaterial color="#60A5FA" metalness={0.3} roughness={0.4} />
      </Sphere>
      <Sphere args={[0.3, 32, 32]} position={[-0.8, 0.6, 0]}>
        <meshStandardMaterial color="#60A5FA" metalness={0.3} roughness={0.4} />
      </Sphere>
      {/* Bonds */}
      <Cylinder args={[0.06, 0.06, 0.8]} position={[0.4, 0.3, 0]} rotation={[0, 0, -0.7]}>
        <meshStandardMaterial color="#94A3B8" />
      </Cylinder>
      <Cylinder args={[0.06, 0.06, 0.8]} position={[-0.4, 0.3, 0]} rotation={[0, 0, 0.7]}>
        <meshStandardMaterial color="#94A3B8" />
      </Cylinder>
    </group>
  );
}

function CellModel({ color }: { color: string }) {
  return (
    <group>
      {/* Cell membrane */}
      <Sphere args={[1.4, 64, 64]}>
        <MeshDistortMaterial color={color} distort={0.2} speed={2} opacity={0.5} transparent />
      </Sphere>
      {/* Nucleus with nuclear envelope */}
      <Sphere args={[0.5, 32, 32]} position={[0.2, 0, 0]}>
        <meshStandardMaterial color="#3B82F6" />
      </Sphere>
      <Sphere args={[0.2, 16, 16]} position={[0.3, 0.1, 0]}>
        <meshStandardMaterial color="#1E40AF" />
      </Sphere>
      {/* Mitochondria */}
      {[...Array(3)].map((_, i) => (
        <group key={`mito-${i}`} position={[Math.cos(i * 2) * 0.8, Math.sin(i * 2) * 0.8, 0]}>
          <Cylinder args={[0.1, 0.15, 0.4, 16]} rotation={[Math.PI / 2, i, 0]}>
            <meshStandardMaterial color="#F97316" />
          </Cylinder>
        </group>
      ))}
      {/* Endoplasmic reticulum */}
      <Torus args={[0.6, 0.08, 8, 32]} position={[-0.3, 0.2, 0.3]} rotation={[0.5, 0.3, 0]}>
        <meshStandardMaterial color="#A855F7" opacity={0.7} transparent />
      </Torus>
      {/* Ribosomes */}
      {[...Array(8)].map((_, i) => (
        <Sphere 
          key={`ribo-${i}`} 
          args={[0.06, 8, 8]} 
          position={[
            Math.cos(i * 0.8) * 0.9,
            Math.sin(i * 0.8) * 0.9,
            (Math.random() - 0.5) * 0.3
          ]}
        >
          <meshStandardMaterial color="#14B8A6" />
        </Sphere>
      ))}
    </group>
  );
}

function DNAModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.y = state.clock.elapsedTime * 0.3;
    }
  });

  return (
    <group ref={groupRef}>
      {[...Array(16)].map((_, i) => (
        <group key={i} position={[0, i * 0.28 - 2.2, 0]} rotation={[0, i * 0.55, 0]}>
          {/* Sugar-phosphate backbone */}
          <Sphere args={[0.12, 16, 16]} position={[0.6, 0, 0]}>
            <meshStandardMaterial color={color} />
          </Sphere>
          <Sphere args={[0.12, 16, 16]} position={[-0.6, 0, 0]}>
            <meshStandardMaterial color={color} />
          </Sphere>
          {/* Base pairs with different colors */}
          <Box args={[0.5, 0.08, 0.08]} position={[0.25, 0, 0]}>
            <meshStandardMaterial color={i % 4 === 0 ? '#EF4444' : i % 4 === 1 ? '#22C55E' : i % 4 === 2 ? '#3B82F6' : '#F59E0B'} />
          </Box>
          <Box args={[0.5, 0.08, 0.08]} position={[-0.25, 0, 0]}>
            <meshStandardMaterial color={i % 4 === 0 ? '#22C55E' : i % 4 === 1 ? '#EF4444' : i % 4 === 2 ? '#F59E0B' : '#3B82F6'} />
          </Box>
        </group>
      ))}
    </group>
  );
}

function HeartModel({ color }: { color: string }) {
  return (
    <group scale={0.8}>
      {/* Main heart chambers */}
      <Sphere args={[0.7, 32, 32]} position={[-0.4, 0, 0]}>
        <MeshDistortMaterial color={color} distort={0.15} speed={3} />
      </Sphere>
      <Sphere args={[0.7, 32, 32]} position={[0.4, 0, 0]}>
        <MeshDistortMaterial color={color} distort={0.15} speed={3} />
      </Sphere>
      {/* Bottom point */}
      <Cone args={[0.8, 1.2, 32]} position={[0, -0.8, 0]} rotation={[Math.PI, 0, 0]}>
        <meshStandardMaterial color={color} />
      </Cone>
      {/* Arteries */}
      <Cylinder args={[0.12, 0.15, 0.6]} position={[-0.3, 0.6, 0]} rotation={[0.3, 0, 0.2]}>
        <meshStandardMaterial color="#DC2626" />
      </Cylinder>
      <Cylinder args={[0.12, 0.15, 0.6]} position={[0.3, 0.6, 0]} rotation={[0.3, 0, -0.2]}>
        <meshStandardMaterial color="#1E40AF" />
      </Cylinder>
    </group>
  );
}

function BrainModel({ color }: { color: string }) {
  return (
    <group>
      {/* Left hemisphere */}
      <Sphere args={[0.9, 32, 32]} position={[-0.4, 0, 0]}>
        <MeshDistortMaterial color={color} distort={0.35} speed={1.5} />
      </Sphere>
      {/* Right hemisphere */}
      <Sphere args={[0.9, 32, 32]} position={[0.4, 0, 0]}>
        <MeshDistortMaterial color={color} distort={0.35} speed={1.5} />
      </Sphere>
      {/* Cerebellum */}
      <Sphere args={[0.5, 32, 32]} position={[0, -0.6, -0.3]}>
        <MeshDistortMaterial color="#F472B6" distort={0.3} speed={1} />
      </Sphere>
      {/* Brain stem */}
      <Cylinder args={[0.15, 0.2, 0.5]} position={[0, -1, 0]}>
        <meshStandardMaterial color="#D946EF" />
      </Cylinder>
    </group>
  );
}

function LungsModel({ color }: { color: string }) {
  return (
    <group>
      {/* Left lung */}
      <Sphere args={[0.7, 32, 32]} position={[-0.6, 0, 0]} scale={[0.8, 1.2, 0.6]}>
        <MeshDistortMaterial color={color} distort={0.1} speed={2} opacity={0.85} transparent />
      </Sphere>
      {/* Right lung */}
      <Sphere args={[0.8, 32, 32]} position={[0.6, 0, 0]} scale={[0.9, 1.2, 0.6]}>
        <MeshDistortMaterial color={color} distort={0.1} speed={2} opacity={0.85} transparent />
      </Sphere>
      {/* Trachea */}
      <Cylinder args={[0.12, 0.12, 0.8]} position={[0, 0.9, 0]}>
        <meshStandardMaterial color="#FDA4AF" />
      </Cylinder>
      {/* Bronchi */}
      <Cylinder args={[0.08, 0.1, 0.5]} position={[-0.3, 0.5, 0]} rotation={[0, 0, 0.5]}>
        <meshStandardMaterial color="#FDA4AF" />
      </Cylinder>
      <Cylinder args={[0.08, 0.1, 0.5]} position={[0.3, 0.5, 0]} rotation={[0, 0, -0.5]}>
        <meshStandardMaterial color="#FDA4AF" />
      </Cylinder>
    </group>
  );
}

function DigestiveSystemModel({ color }: { color: string }) {
  return (
    <group scale={0.7}>
      {/* Stomach */}
      <Sphere args={[0.6, 32, 32]} position={[0, 0.5, 0]} scale={[1, 0.8, 0.6]}>
        <MeshDistortMaterial color={color} distort={0.15} speed={1.5} />
      </Sphere>
      {/* Small intestine (coiled) */}
      {[...Array(5)].map((_, i) => (
        <Torus key={i} args={[0.3 + i * 0.1, 0.08, 16, 32]} position={[0, -0.3 - i * 0.2, 0]} rotation={[Math.PI / 2, i * 0.3, 0]}>
          <meshStandardMaterial color="#F472B6" />
        </Torus>
      ))}
      {/* Large intestine */}
      <Torus args={[0.9, 0.12, 16, 32]} position={[0, -0.5, 0]} rotation={[Math.PI / 2, 0, 0]}>
        <meshStandardMaterial color="#EC4899" />
      </Torus>
      {/* Esophagus */}
      <Cylinder args={[0.08, 0.08, 0.6]} position={[0, 1, 0]}>
        <meshStandardMaterial color="#FDA4AF" />
      </Cylinder>
    </group>
  );
}

function NeuronModel({ color }: { color: string }) {
  return (
    <group>
      {/* Cell body (soma) */}
      <Sphere args={[0.4, 32, 32]} position={[0, 0, 0]}>
        <MeshDistortMaterial color={color} distort={0.2} speed={2} />
      </Sphere>
      {/* Nucleus */}
      <Sphere args={[0.15, 16, 16]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#1E40AF" />
      </Sphere>
      {/* Axon */}
      <Cylinder args={[0.06, 0.04, 2]} position={[1.2, 0, 0]} rotation={[0, 0, Math.PI / 2]}>
        <meshStandardMaterial color={color} />
      </Cylinder>
      {/* Dendrites */}
      {[...Array(6)].map((_, i) => (
        <group key={i} rotation={[0, 0, i * 0.8 + 0.5]}>
          <Cylinder args={[0.04, 0.02, 0.6]} position={[-0.5, 0.2, 0]} rotation={[0, 0, 0.6]}>
            <meshStandardMaterial color={color} />
          </Cylinder>
        </group>
      ))}
      {/* Synaptic terminals */}
      {[...Array(3)].map((_, i) => (
        <Sphere key={i} args={[0.08, 16, 16]} position={[2.1, (i - 1) * 0.2, 0]}>
          <meshStandardMaterial color="#F59E0B" emissive="#F59E0B" emissiveIntensity={0.3} />
        </Sphere>
      ))}
    </group>
  );
}

function EyeModel({ color }: { color: string }) {
  return (
    <group>
      {/* Eyeball */}
      <Sphere args={[1, 64, 64]}>
        <meshStandardMaterial color="#F5F5F4" />
      </Sphere>
      {/* Iris */}
      <Sphere args={[0.4, 32, 32]} position={[0, 0, 0.85]}>
        <meshStandardMaterial color={color} />
      </Sphere>
      {/* Pupil */}
      <Sphere args={[0.2, 32, 32]} position={[0, 0, 0.95]}>
        <meshStandardMaterial color="#1F2937" />
      </Sphere>
      {/* Cornea */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0.7]}>
        <meshStandardMaterial color="#DBEAFE" opacity={0.3} transparent />
      </Sphere>
      {/* Optic nerve */}
      <Cylinder args={[0.15, 0.15, 0.5]} position={[0, 0, -1.1]} rotation={[Math.PI / 2, 0, 0]}>
        <meshStandardMaterial color="#FCD34D" />
      </Cylinder>
    </group>
  );
}

function PlanetModel({ color }: { color: string }) {
  return (
    <group>
      <Sphere args={[1, 64, 64]}>
        <MeshDistortMaterial color={color} distort={0.08} speed={0.8} />
      </Sphere>
      {/* Atmosphere glow */}
      <Sphere args={[1.1, 32, 32]}>
        <meshStandardMaterial color="#60A5FA" opacity={0.15} transparent />
      </Sphere>
    </group>
  );
}

function SaturnModel({ color }: { color: string }) {
  return (
    <group rotation={[0.3, 0, 0]}>
      <Sphere args={[0.8, 64, 64]}>
        <MeshDistortMaterial color={color} distort={0.05} speed={0.5} />
      </Sphere>
      {/* Rings */}
      <Ring args={[1.2, 1.8, 64]} rotation={[Math.PI / 2, 0, 0]}>
        <meshStandardMaterial color="#D4A574" opacity={0.7} transparent side={THREE.DoubleSide} />
      </Ring>
      <Ring args={[1.9, 2.2, 64]} rotation={[Math.PI / 2, 0, 0]}>
        <meshStandardMaterial color="#A16207" opacity={0.5} transparent side={THREE.DoubleSide} />
      </Ring>
    </group>
  );
}

function SolarSystemModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.y = state.clock.elapsedTime * 0.1;
    }
  });

  return (
    <group ref={groupRef}>
      {/* Sun */}
      <Sphere args={[0.5, 32, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#FCD34D" emissive="#F59E0B" emissiveIntensity={0.5} />
      </Sphere>
      {/* Planets and orbits */}
      {[
        { distance: 0.8, size: 0.08, color: '#9CA3AF', speed: 4 },
        { distance: 1.1, size: 0.12, color: '#F97316', speed: 3 },
        { distance: 1.5, size: 0.15, color: '#3B82F6', speed: 2 },
        { distance: 1.9, size: 0.1, color: '#DC2626', speed: 1.5 },
      ].map((planet, i) => (
        <group key={i}>
          <Torus args={[planet.distance, 0.01, 8, 64]}>
            <meshStandardMaterial color="#4B5563" opacity={0.3} transparent />
          </Torus>
          <Sphere args={[planet.size, 16, 16]} position={[planet.distance, 0, 0]}>
            <meshStandardMaterial color={planet.color} />
          </Sphere>
        </group>
      ))}
    </group>
  );
}

function BlackHoleModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.z = state.clock.elapsedTime * 0.5;
    }
  });

  return (
    <group ref={groupRef}>
      {/* Event horizon */}
      <Sphere args={[0.5, 32, 32]}>
        <meshStandardMaterial color="#030712" />
      </Sphere>
      {/* Accretion disk */}
      <Ring args={[0.7, 2, 64]} rotation={[Math.PI / 2.5, 0, 0]}>
        <meshStandardMaterial color="#F97316" opacity={0.8} transparent side={THREE.DoubleSide} />
      </Ring>
      <Ring args={[0.6, 0.75, 64]} rotation={[Math.PI / 2.5, 0, 0]}>
        <meshStandardMaterial color="#FCD34D" emissive="#F59E0B" emissiveIntensity={0.5} side={THREE.DoubleSide} />
      </Ring>
    </group>
  );
}

function VolcanoModel({ color }: { color: string }) {
  return (
    <group>
      {/* Mountain cone */}
      <Cone args={[1.5, 2, 32]} position={[0, -0.5, 0]}>
        <meshStandardMaterial color="#57534E" />
      </Cone>
      {/* Crater */}
      <Cylinder args={[0.4, 0.5, 0.3, 32]} position={[0, 0.7, 0]}>
        <meshStandardMaterial color="#1C1917" />
      </Cylinder>
      {/* Lava */}
      <Sphere args={[0.35, 16, 16]} position={[0, 0.6, 0]}>
        <meshStandardMaterial color="#EF4444" emissive="#DC2626" emissiveIntensity={0.5} />
      </Sphere>
      {/* Lava flow */}
      <Cylinder args={[0.1, 0.2, 1]} position={[0.5, 0, 0.5]} rotation={[0.5, 0, 0.3]}>
        <meshStandardMaterial color="#F97316" emissive="#EF4444" emissiveIntensity={0.3} />
      </Cylinder>
    </group>
  );
}

function RocketModel({ color }: { color: string }) {
  return (
    <group rotation={[0, 0, 0.3]}>
      {/* Body */}
      <Cylinder args={[0.3, 0.3, 2, 32]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#E5E7EB" metalness={0.5} roughness={0.3} />
      </Cylinder>
      {/* Nose cone */}
      <Cone args={[0.3, 0.6, 32]} position={[0, 1.3, 0]}>
        <meshStandardMaterial color={color} metalness={0.5} roughness={0.3} />
      </Cone>
      {/* Fins */}
      {[0, 1, 2, 3].map((i) => (
        <Box key={i} args={[0.4, 0.5, 0.05]} position={[Math.cos(i * Math.PI / 2) * 0.35, -0.8, Math.sin(i * Math.PI / 2) * 0.35]} rotation={[0, i * Math.PI / 2, 0]}>
          <meshStandardMaterial color={color} />
        </Box>
      ))}
      {/* Flame */}
      <Cone args={[0.25, 0.8, 16]} position={[0, -1.3, 0]} rotation={[Math.PI, 0, 0]}>
        <meshStandardMaterial color="#F59E0B" emissive="#EF4444" emissiveIntensity={0.8} />
      </Cone>
    </group>
  );
}

function RobotModel({ color }: { color: string }) {
  return (
    <group>
      {/* Head */}
      <Box args={[0.8, 0.6, 0.6]} position={[0, 1.2, 0]}>
        <meshStandardMaterial color="#9CA3AF" metalness={0.7} roughness={0.3} />
      </Box>
      {/* Eyes */}
      <Sphere args={[0.12, 16, 16]} position={[-0.2, 1.3, 0.32]}>
        <meshStandardMaterial color={color} emissive={color} emissiveIntensity={0.5} />
      </Sphere>
      <Sphere args={[0.12, 16, 16]} position={[0.2, 1.3, 0.32]}>
        <meshStandardMaterial color={color} emissive={color} emissiveIntensity={0.5} />
      </Sphere>
      {/* Body */}
      <Box args={[1, 1.2, 0.6]} position={[0, 0.2, 0]}>
        <meshStandardMaterial color="#6B7280" metalness={0.6} roughness={0.3} />
      </Box>
      {/* Arms */}
      <Cylinder args={[0.12, 0.12, 0.8]} position={[-0.7, 0.2, 0]} rotation={[0, 0, Math.PI / 6]}>
        <meshStandardMaterial color="#9CA3AF" metalness={0.6} />
      </Cylinder>
      <Cylinder args={[0.12, 0.12, 0.8]} position={[0.7, 0.2, 0]} rotation={[0, 0, -Math.PI / 6]}>
        <meshStandardMaterial color="#9CA3AF" metalness={0.6} />
      </Cylinder>
      {/* Antenna */}
      <Cylinder args={[0.03, 0.03, 0.4]} position={[0, 1.7, 0]}>
        <meshStandardMaterial color="#4B5563" />
      </Cylinder>
      <Sphere args={[0.08, 16, 16]} position={[0, 1.95, 0]}>
        <meshStandardMaterial color="#EF4444" emissive="#EF4444" emissiveIntensity={0.5} />
      </Sphere>
    </group>
  );
}

function GearsModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.children[0].rotation.z = state.clock.elapsedTime;
      groupRef.current.children[1].rotation.z = -state.clock.elapsedTime * 1.2;
    }
  });

  return (
    <group ref={groupRef}>
      {/* Large gear */}
      <group position={[-0.6, 0, 0]}>
        <Cylinder args={[0.8, 0.8, 0.2, 12]}>
          <meshStandardMaterial color={color} metalness={0.7} roughness={0.3} />
        </Cylinder>
        <Cylinder args={[0.2, 0.2, 0.3, 16]} position={[0, 0, 0]}>
          <meshStandardMaterial color="#374151" metalness={0.8} />
        </Cylinder>
      </group>
      {/* Small gear */}
      <group position={[0.7, 0.5, 0]}>
        <Cylinder args={[0.5, 0.5, 0.2, 10]}>
          <meshStandardMaterial color="#9CA3AF" metalness={0.7} roughness={0.3} />
        </Cylinder>
        <Cylinder args={[0.15, 0.15, 0.3, 16]} position={[0, 0, 0]}>
          <meshStandardMaterial color="#374151" metalness={0.8} />
        </Cylinder>
      </group>
    </group>
  );
}

function CrystalModel({ color }: { color: string }) {
  return (
    <group>
      {/* Main crystal */}
      <Cone args={[0.5, 2, 6]} position={[0, 0, 0]}>
        <meshStandardMaterial color={color} opacity={0.8} transparent metalness={0.3} roughness={0.1} />
      </Cone>
      <Cone args={[0.5, 0.8, 6]} position={[0, -0.9, 0]} rotation={[Math.PI, 0, 0]}>
        <meshStandardMaterial color={color} opacity={0.8} transparent metalness={0.3} roughness={0.1} />
      </Cone>
      {/* Smaller crystals */}
      <Cone args={[0.25, 1, 6]} position={[0.6, -0.5, 0.3]} rotation={[0, 0, -0.3]}>
        <meshStandardMaterial color={color} opacity={0.7} transparent />
      </Cone>
      <Cone args={[0.2, 0.8, 6]} position={[-0.5, -0.6, -0.2]} rotation={[0, 0, 0.4]}>
        <meshStandardMaterial color={color} opacity={0.7} transparent />
      </Cone>
    </group>
  );
}

function PendulumModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.rotation.z = Math.sin(state.clock.elapsedTime * 2) * 0.5;
    }
  });

  return (
    <group>
      {/* Support bar */}
      <Box args={[2, 0.1, 0.1]} position={[0, 1.5, 0]}>
        <meshStandardMaterial color="#78716C" metalness={0.6} />
      </Box>
      {/* Pendulum */}
      <group ref={groupRef} position={[0, 1.5, 0]}>
        <Cylinder args={[0.03, 0.03, 1.5]} position={[0, -0.75, 0]}>
          <meshStandardMaterial color="#9CA3AF" />
        </Cylinder>
        <Sphere args={[0.25, 32, 32]} position={[0, -1.5, 0]}>
          <meshStandardMaterial color={color} metalness={0.5} roughness={0.3} />
        </Sphere>
      </group>
    </group>
  );
}

function VirusModel({ color }: { color: string }) {
  return (
    <group>
      {/* Capsid */}
      <Sphere args={[0.6, 32, 32]}>
        <MeshDistortMaterial color={color} distort={0.15} speed={2} />
      </Sphere>
      {/* Spike proteins */}
      {[...Array(20)].map((_, i) => {
        const theta = Math.acos(1 - 2 * (i + 0.5) / 20);
        const phi = Math.PI * (1 + Math.sqrt(5)) * (i + 0.5);
        return (
          <group key={i} position={[
            Math.sin(theta) * Math.cos(phi) * 0.6,
            Math.sin(theta) * Math.sin(phi) * 0.6,
            Math.cos(theta) * 0.6
          ]}>
            <Cone args={[0.08, 0.3, 8]} rotation={[theta, 0, phi]}>
              <meshStandardMaterial color="#EF4444" />
            </Cone>
          </group>
        );
      })}
    </group>
  );
}

function WaveModel({ color }: { color: string }) {
  const groupRef = useRef<THREE.Group>(null);
  
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.children.forEach((child, i) => {
        child.position.y = Math.sin(state.clock.elapsedTime * 2 + i * 0.5) * 0.3;
      });
    }
  });

  return (
    <group ref={groupRef}>
      {[...Array(12)].map((_, i) => (
        <Sphere key={i} args={[0.15, 16, 16]} position={[i * 0.3 - 1.5, 0, 0]}>
          <meshStandardMaterial color={color} />
        </Sphere>
      ))}
    </group>
  );
}

function GenericModel({ color }: { color: string }) {
  return (
    <Sphere args={[1, 100, 200]} scale={1.3}>
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

// ==================== SCENE COMPONENT ====================

function Scene3D({ model, color }: { model: string; color: string }) {
  const ModelComponent = useMemo(() => {
    switch (model) {
      case 'atom': return () => <AtomModel color={color} />;
      case 'nucleus': return () => <NucleusModel color={color} />;
      case 'molecule': return () => <MoleculeModel color={color} />;
      case 'molecularbond': return () => <MoleculeModel color={color} />;
      case 'water': return () => <WaterMoleculeModel color={color} />;
      case 'cell': return () => <CellModel color={color} />;
      case 'dna': return () => <DNAModel color={color} />;
      case 'heart': return () => <HeartModel color={color} />;
      case 'brain': return () => <BrainModel color={color} />;
      case 'lungs': return () => <LungsModel color={color} />;
      case 'digestive': return () => <DigestiveSystemModel color={color} />;
      case 'stomach': return () => <DigestiveSystemModel color={color} />;
      case 'neuron': return () => <NeuronModel color={color} />;
      case 'eye': return () => <EyeModel color={color} />;
      case 'planet': return () => <PlanetModel color={color} />;
      case 'saturn': return () => <SaturnModel color={color} />;
      case 'solarsystem': return () => <SolarSystemModel color={color} />;
      case 'blackhole': return () => <BlackHoleModel color={color} />;
      case 'volcano': return () => <VolcanoModel color={color} />;
      case 'rocket': return () => <RocketModel color={color} />;
      case 'robot': return () => <RobotModel color={color} />;
      case 'gears': return () => <GearsModel color={color} />;
      case 'crystal': return () => <CrystalModel color={color} />;
      case 'pendulum': return () => <PendulumModel color={color} />;
      case 'virus': return () => <VirusModel color={color} />;
      case 'wave': return () => <WaveModel color={color} />;
      default: return () => <GenericModel color={color} />;
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
  
  const visual = useMemo(() => {
    for (const [keyword, config] of Object.entries(TOPIC_VISUALS)) {
      if (searchText.includes(keyword)) {
        return config;
      }
    }
    return { type: '3d' as const, model: 'generic', color: '#6366F1' };
  }, [searchText]);

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
