import { useRef, useState, Suspense, useMemo } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { OrbitControls, Environment, Trail, Text } from '@react-three/drei';
import * as THREE from 'three';

// Color scheme from Wave Interference prototype
const colors = {
  primary: '#00d4ff',
  secondary: '#e040fb',
  accent: '#00ff88',
  background: '#0d1b2a',
  cardBg: 'rgba(15, 25, 45, 0.95)',
  border: 'rgba(0, 212, 255, 0.3)',
};

// ==================== ATOM MODEL ====================
function AtomModel({ protons = 6 }: { protons?: number }) {
  const groupRef = useRef<THREE.Group>(null);
  const electronsRef = useRef<THREE.Mesh[]>([]);
  const electronShells = protons <= 2 ? [protons] : protons <= 10 ? [2, protons - 2] : [2, 8, Math.min(protons - 10, 8)];
  let electronIndex = 0;

  useFrame((state) => {
    electronsRef.current.forEach((electron, i) => {
      if (electron) {
        const shellIndex = i < 2 ? 0 : i < 10 ? 1 : 2;
        const speed = 0.02 / (shellIndex + 1);
        const angle = state.clock.elapsedTime * speed * 50 + (i * Math.PI * 2) / (electronShells[shellIndex] || 1);
        const radius = 1.5 + shellIndex * 1.2;
        electron.position.x = Math.cos(angle) * radius;
        electron.position.z = Math.sin(angle) * radius;
      }
    });
    if (groupRef.current) groupRef.current.rotation.y += 0.002;
  });

  return (
    <group ref={groupRef}>
      {Array.from({ length: protons }).map((_, i) => (
        <mesh key={`p-${i}`} position={[Math.cos(i / protons * Math.PI * 2) * 0.3, Math.sin(i / protons * Math.PI * 2) * 0.3, (Math.random() - 0.5) * 0.2]}>
          <sphereGeometry args={[0.2, 16, 16]} />
          <meshStandardMaterial color="#ff4444" emissive="#441111" />
        </mesh>
      ))}
      {Array.from({ length: protons }).map((_, i) => (
        <mesh key={`n-${i}`} position={[Math.cos((i / protons * Math.PI * 2) + 0.5) * 0.3, (Math.random() - 0.5) * 0.3, Math.sin((i / protons * Math.PI * 2) + 0.5) * 0.3]}>
          <sphereGeometry args={[0.2, 16, 16]} />
          <meshStandardMaterial color="#888888" emissive="#222222" />
        </mesh>
      ))}
      {electronShells.map((count, shellIndex) => (
        <group key={`shell-${shellIndex}`}>
          <mesh rotation={[Math.PI / 2, 0, 0]}>
            <torusGeometry args={[1.5 + shellIndex * 1.2, 0.02, 8, 64]} />
            <meshBasicMaterial color={colors.primary} transparent opacity={0.3} />
          </mesh>
          {Array.from({ length: count }).map((_, i) => {
            const idx = electronIndex++;
            return (
              <mesh key={`e-${shellIndex}-${i}`} ref={(el) => { if (el) electronsRef.current[idx] = el; }}>
                <sphereGeometry args={[0.12, 16, 16]} />
                <meshStandardMaterial color={colors.primary} emissive="#0066aa" />
              </mesh>
            );
          })}
        </group>
      ))}
    </group>
  );
}

// ==================== WAVE MODEL ====================
function WaveModel({ frequency = 2, amplitude = 1 }: { frequency?: number; amplitude?: number }) {
  const meshRef = useRef<THREE.Mesh>(null);

  useFrame((state) => {
    if (meshRef.current) {
      const positions = meshRef.current.geometry.attributes.position.array as Float32Array;
      for (let i = 0; i < positions.length; i += 3) {
        const x = positions[i];
        const z = positions[i + 2];
        const r = Math.sqrt(x * x + z * z);
        positions[i + 1] = amplitude * Math.sin(frequency * r - state.clock.elapsedTime * 3);
      }
      meshRef.current.geometry.attributes.position.needsUpdate = true;
      meshRef.current.geometry.computeVertexNormals();
    }
  });

  return (
    <mesh ref={meshRef} rotation={[-Math.PI / 2, 0, 0]}>
      <planeGeometry args={[8, 8, 50, 50]} />
      <meshStandardMaterial color={colors.primary} side={THREE.DoubleSide} transparent opacity={0.8} />
    </mesh>
  );
}

// ==================== MOLECULE MODEL ====================
const moleculeData: Record<string, { atoms: Array<{ element: string; position: [number, number, number] }>; bonds: [number, number][] }> = {
  water: { atoms: [{ element: 'O', position: [0, 0, 0] }, { element: 'H', position: [0.96, 0, 0] }, { element: 'H', position: [-0.24, 0.93, 0] }], bonds: [[0, 1], [0, 2]] },
  co2: { atoms: [{ element: 'C', position: [0, 0, 0] }, { element: 'O', position: [-1.16, 0, 0] }, { element: 'O', position: [1.16, 0, 0] }], bonds: [[0, 1], [0, 2]] },
  methane: { atoms: [{ element: 'C', position: [0, 0, 0] }, { element: 'H', position: [0.63, 0.63, 0.63] }, { element: 'H', position: [-0.63, -0.63, 0.63] }, { element: 'H', position: [-0.63, 0.63, -0.63] }, { element: 'H', position: [0.63, -0.63, -0.63] }], bonds: [[0, 1], [0, 2], [0, 3], [0, 4]] },
  nacl: { atoms: [{ element: 'Na', position: [-0.8, 0, 0] }, { element: 'Cl', position: [0.8, 0, 0] }], bonds: [[0, 1]] },
};
const atomColors: Record<string, { color: string; radius: number }> = {
  H: { color: '#ffffff', radius: 0.3 }, C: { color: '#333333', radius: 0.5 }, O: { color: '#ff0d0d', radius: 0.45 },
  N: { color: '#3050f8', radius: 0.45 }, Na: { color: '#ab5cf2', radius: 0.55 }, Cl: { color: '#1ff01f', radius: 0.55 },
};

function MoleculeModel({ molecule = 'water' }: { molecule?: string }) {
  const groupRef = useRef<THREE.Group>(null);
  const data = moleculeData[molecule] || moleculeData.water;
  useFrame(() => { if (groupRef.current) groupRef.current.rotation.y += 0.005; });

  return (
    <group ref={groupRef}>
      {data.atoms.map((atom, i) => {
        const info = atomColors[atom.element] || { color: '#888888', radius: 0.4 };
        return (
          <mesh key={i} position={atom.position}>
            <sphereGeometry args={[info.radius, 32, 32]} />
            <meshStandardMaterial color={info.color} />
          </mesh>
        );
      })}
      {data.bonds.map(([a, b], i) => {
        const start = new THREE.Vector3(...data.atoms[a].position);
        const end = new THREE.Vector3(...data.atoms[b].position);
        const mid = start.clone().add(end).multiplyScalar(0.5);
        const dir = end.clone().sub(start);
        const len = dir.length();
        const quat = new THREE.Quaternion().setFromUnitVectors(new THREE.Vector3(0, 1, 0), dir.normalize());
        return (
          <mesh key={`bond-${i}`} position={mid} quaternion={quat}>
            <cylinderGeometry args={[0.08, 0.08, len, 8]} />
            <meshStandardMaterial color="#888888" />
          </mesh>
        );
      })}
    </group>
  );
}

// ==================== PLANET/SOLAR SYSTEM MODEL ====================
function PlanetModel({ planet = 'earth' }: { planet?: string }) {
  const orbitRef = useRef<THREE.Group>(null);
  const planetData: Record<string, { color: string; size: number; rings?: boolean }> = {
    earth: { color: '#4488ff', size: 1 }, mars: { color: '#ff6644', size: 0.8 },
    jupiter: { color: '#ffaa66', size: 2 }, saturn: { color: '#ffdd88', size: 1.8, rings: true },
  };
  const data = planetData[planet] || planetData.earth;

  useFrame((state) => { if (orbitRef.current) orbitRef.current.rotation.y = state.clock.elapsedTime * 0.3; });

  return (
    <group>
      <mesh><sphereGeometry args={[0.5, 32, 32]} /><meshStandardMaterial color="#ffcc00" emissive="#ff6600" emissiveIntensity={0.5} /></mesh>
      <pointLight intensity={1} color="#ffffcc" />
      <mesh rotation={[Math.PI / 2, 0, 0]}><torusGeometry args={[3, 0.02, 8, 64]} /><meshBasicMaterial color="#444466" transparent opacity={0.5} /></mesh>
      <group ref={orbitRef}>
        <mesh position={[3, 0, 0]}><sphereGeometry args={[data.size * 0.3, 32, 32]} /><meshStandardMaterial color={data.color} /></mesh>
        {data.rings && <mesh position={[3, 0, 0]} rotation={[Math.PI / 2.5, 0, 0]}><ringGeometry args={[data.size * 0.4, data.size * 0.6, 64]} /><meshBasicMaterial color="#ccaa77" side={THREE.DoubleSide} transparent opacity={0.7} /></mesh>}
      </group>
    </group>
  );
}

// ==================== ELECTRIC FIELD MODEL ====================
function ElectricFieldModel() {
  const groupRef = useRef<THREE.Group>(null);
  useFrame((state) => {
    if (groupRef.current) {
      groupRef.current.children.forEach((child, i) => {
        if (i > 1) child.scale.setScalar(1 + Math.sin(state.clock.elapsedTime * 2 + i * 0.5) * 0.1);
      });
    }
  });

  return (
    <group ref={groupRef}>
      <mesh position={[-2, 0, 0]}><sphereGeometry args={[0.5, 32, 32]} /><meshStandardMaterial color="#ff6b6b" emissive="#441111" /></mesh>
      <mesh position={[2, 0, 0]}><sphereGeometry args={[0.5, 32, 32]} /><meshStandardMaterial color={colors.primary} emissive="#004455" /></mesh>
      {Array.from({ length: 8 }).map((_, i) => {
        const angle = (i / 8) * Math.PI * 2;
        return (
          <mesh key={i} position={[Math.cos(angle) * 1.5 - 2, Math.sin(angle) * 1.5, 0]} rotation={[0, 0, angle]}>
            <coneGeometry args={[0.1, 0.3, 8]} /><meshStandardMaterial color="#ff6b6b" />
          </mesh>
        );
      })}
    </group>
  );
}

// ==================== GRAVITY/FALLING MODEL ====================
function GravityModel() {
  const ballRefs = useRef<THREE.Mesh[]>([]);
  const [positions, setPositions] = useState([0, 0, 0]);

  useFrame((state) => {
    const t = state.clock.elapsedTime % 3;
    const g = 9.8;
    ballRefs.current.forEach((ball, i) => {
      if (ball) {
        const delay = i * 0.3;
        const effectiveT = Math.max(0, t - delay);
        const y = 4 - 0.5 * g * effectiveT * effectiveT * 0.3;
        ball.position.y = Math.max(-2, y);
      }
    });
  });

  return (
    <group>
      {/* Ground */}
      <mesh position={[0, -2.5, 0]} rotation={[-Math.PI / 2, 0, 0]}>
        <planeGeometry args={[10, 10]} />
        <meshStandardMaterial color="#1a1a2e" />
      </mesh>
      {/* Falling balls */}
      {[-2, 0, 2].map((x, i) => (
        <mesh key={i} ref={(el) => { if (el) ballRefs.current[i] = el; }} position={[x, 4, 0]}>
          <sphereGeometry args={[0.3 + i * 0.1, 32, 32]} />
          <meshStandardMaterial color={['#ff6b6b', '#00d4ff', '#00ff88'][i]} />
        </mesh>
      ))}
      {/* Gravity arrow */}
      <mesh position={[4, 0, 0]} rotation={[0, 0, -Math.PI / 2]}>
        <coneGeometry args={[0.2, 0.5, 8]} />
        <meshStandardMaterial color="#e040fb" />
      </mesh>
      <mesh position={[4, 1.5, 0]}>
        <cylinderGeometry args={[0.05, 0.05, 2.5, 8]} />
        <meshStandardMaterial color="#e040fb" />
      </mesh>
    </group>
  );
}

// ==================== PRESSURE MODEL ====================
function PressureModel() {
  const pistonRef = useRef<THREE.Mesh>(null);
  const particlesRef = useRef<THREE.InstancedMesh>(null);
  const dummy = useMemo(() => new THREE.Object3D(), []);
  const particleCount = 50;
  const velocities = useMemo(() => Array.from({ length: particleCount }, () => [
    (Math.random() - 0.5) * 0.1, (Math.random() - 0.5) * 0.1, (Math.random() - 0.5) * 0.1
  ]), []);

  useFrame((state) => {
    const pistonY = 1.5 + Math.sin(state.clock.elapsedTime) * 0.5;
    if (pistonRef.current) pistonRef.current.position.y = pistonY;

    if (particlesRef.current) {
      for (let i = 0; i < particleCount; i++) {
        dummy.position.set(
          (Math.random() - 0.5) * 2,
          -1.5 + Math.random() * (pistonY + 1),
          (Math.random() - 0.5) * 2
        );
        dummy.scale.setScalar(0.1);
        dummy.updateMatrix();
        particlesRef.current.setMatrixAt(i, dummy.matrix);
      }
      particlesRef.current.instanceMatrix.needsUpdate = true;
    }
  });

  return (
    <group>
      {/* Container */}
      <mesh position={[0, -0.5, 0]}>
        <boxGeometry args={[3, 3, 3]} />
        <meshStandardMaterial color="#1a1a3a" transparent opacity={0.3} side={THREE.BackSide} />
      </mesh>
      {/* Piston */}
      <mesh ref={pistonRef} position={[0, 1.5, 0]}>
        <cylinderGeometry args={[1.4, 1.4, 0.3, 32]} />
        <meshStandardMaterial color={colors.primary} />
      </mesh>
      {/* Particles */}
      <instancedMesh ref={particlesRef} args={[undefined, undefined, particleCount]}>
        <sphereGeometry args={[0.1, 8, 8]} />
        <meshStandardMaterial color="#ff6b6b" />
      </instancedMesh>
    </group>
  );
}

// ==================== PENDULUM MODEL ====================
function PendulumModel() {
  const pendulumRef = useRef<THREE.Group>(null);

  useFrame((state) => {
    if (pendulumRef.current) {
      pendulumRef.current.rotation.z = Math.sin(state.clock.elapsedTime * 2) * 0.5;
    }
  });

  return (
    <group>
      {/* Mount point */}
      <mesh position={[0, 3, 0]}>
        <boxGeometry args={[2, 0.2, 0.5]} />
        <meshStandardMaterial color="#444444" />
      </mesh>
      {/* Pendulum */}
      <group ref={pendulumRef} position={[0, 3, 0]}>
        <mesh position={[0, -1.5, 0]}>
          <cylinderGeometry args={[0.03, 0.03, 3, 8]} />
          <meshStandardMaterial color="#888888" />
        </mesh>
        <mesh position={[0, -3.2, 0]}>
          <sphereGeometry args={[0.4, 32, 32]} />
          <meshStandardMaterial color={colors.primary} metalness={0.8} roughness={0.2} />
        </mesh>
      </group>
    </group>
  );
}

// ==================== PROJECTILE MODEL ====================
function ProjectileModel() {
  const ballRef = useRef<THREE.Mesh>(null);
  const trailPoints = useRef<THREE.Vector3[]>([]);

  useFrame((state) => {
    const t = (state.clock.elapsedTime * 0.5) % 2;
    const v0 = 5;
    const angle = Math.PI / 4;
    const g = 9.8;

    const x = v0 * Math.cos(angle) * t * 2 - 3;
    const y = v0 * Math.sin(angle) * t * 2 - 0.5 * g * t * t * 0.5 - 1;

    if (ballRef.current) {
      ballRef.current.position.x = x;
      ballRef.current.position.y = Math.max(-2, y);
    }
  });

  return (
    <group>
      {/* Ground */}
      <mesh position={[0, -2.5, 0]} rotation={[-Math.PI / 2, 0, 0]}>
        <planeGeometry args={[12, 6]} />
        <meshStandardMaterial color="#1a1a2e" />
      </mesh>
      {/* Trajectory path */}
      <mesh position={[0, 0, 0]}>
        <tubeGeometry args={[
          new THREE.CatmullRomCurve3([
            new THREE.Vector3(-3, -2, 0),
            new THREE.Vector3(-1, 1, 0),
            new THREE.Vector3(1, 2, 0),
            new THREE.Vector3(3, 1, 0),
            new THREE.Vector3(5, -2, 0),
          ]),
          64, 0.03, 8, false
        ]} />
        <meshBasicMaterial color={colors.primary} transparent opacity={0.5} />
      </mesh>
      {/* Ball */}
      <mesh ref={ballRef} position={[-3, -2, 0]}>
        <sphereGeometry args={[0.25, 32, 32]} />
        <meshStandardMaterial color="#ff6b6b" />
      </mesh>
    </group>
  );
}

// ==================== FORCE VECTORS MODEL ====================
function ForceVectorModel() {
  const boxRef = useRef<THREE.Mesh>(null);

  useFrame((state) => {
    if (boxRef.current) {
      boxRef.current.position.x = Math.sin(state.clock.elapsedTime) * 0.5;
    }
  });

  const Arrow = ({ position, rotation, color, label }: { position: [number, number, number]; rotation: [number, number, number]; color: string; label: string }) => (
    <group position={position} rotation={rotation}>
      <mesh position={[0, 1, 0]}>
        <cylinderGeometry args={[0.05, 0.05, 2, 8]} />
        <meshStandardMaterial color={color} />
      </mesh>
      <mesh position={[0, 2.2, 0]}>
        <coneGeometry args={[0.15, 0.4, 8]} />
        <meshStandardMaterial color={color} />
      </mesh>
    </group>
  );

  return (
    <group>
      {/* Box */}
      <mesh ref={boxRef} position={[0, 0, 0]}>
        <boxGeometry args={[1.5, 1, 1]} />
        <meshStandardMaterial color="#444466" />
      </mesh>
      {/* Force arrows */}
      <Arrow position={[2, 0, 0]} rotation={[0, 0, -Math.PI / 2]} color="#ff6b6b" label="Applied" />
      <Arrow position={[-2, 0, 0]} rotation={[0, 0, Math.PI / 2]} color={colors.primary} label="Friction" />
      <Arrow position={[0, -1.5, 0]} rotation={[0, 0, Math.PI]} color="#888888" label="Weight" />
      <Arrow position={[0, 1.5, 0]} rotation={[0, 0, 0]} color="#00ff88" label="Normal" />
    </group>
  );
}

// ==================== THERMODYNAMICS MODEL ====================
function ThermodynamicsModel() {
  const particlesRef = useRef<THREE.InstancedMesh>(null);
  const dummy = useMemo(() => new THREE.Object3D(), []);
  const count = 100;
  const velocities = useMemo(() =>
    Array.from({ length: count }, () => [(Math.random() - 0.5) * 0.2, (Math.random() - 0.5) * 0.2, (Math.random() - 0.5) * 0.2]),
  []);
  const positions = useMemo(() =>
    Array.from({ length: count }, () => [(Math.random() - 0.5) * 4, (Math.random() - 0.5) * 4, (Math.random() - 0.5) * 4]),
  []);

  useFrame(() => {
    if (particlesRef.current) {
      for (let i = 0; i < count; i++) {
        positions[i][0] += velocities[i][0];
        positions[i][1] += velocities[i][1];
        positions[i][2] += velocities[i][2];

        for (let j = 0; j < 3; j++) {
          if (Math.abs(positions[i][j]) > 2) velocities[i][j] *= -1;
        }

        const temp = i < count / 2 ? 1 : 0.3;
        dummy.position.set(positions[i][0], positions[i][1], positions[i][2]);
        dummy.scale.setScalar(0.08);
        dummy.updateMatrix();
        particlesRef.current.setMatrixAt(i, dummy.matrix);
      }
      particlesRef.current.instanceMatrix.needsUpdate = true;
    }
  });

  return (
    <group>
      <mesh><boxGeometry args={[5, 5, 5]} /><meshStandardMaterial color="#1a1a3a" transparent opacity={0.2} side={THREE.BackSide} /></mesh>
      <mesh position={[0, 0, 0]} rotation={[0, 0, 0]}><planeGeometry args={[0.05, 5]} /><meshStandardMaterial color="#444444" /></mesh>
      <instancedMesh ref={particlesRef} args={[undefined, undefined, count]}>
        <sphereGeometry args={[0.1, 8, 8]} />
        <meshStandardMaterial color="#ff6b6b" />
      </instancedMesh>
    </group>
  );
}

// ==================== STAR MODEL ====================
function StarModel({ stage = 'main' }: { stage?: string }) {
  const starRef = useRef<THREE.Mesh>(null);
  const coronaRef = useRef<THREE.Mesh>(null);

  const stageData: Record<string, { color: string; size: number; corona: string }> = {
    main: { color: '#ffdd44', size: 1.5, corona: '#ff8800' },
    giant: { color: '#ff6644', size: 2.5, corona: '#ff4400' },
    dwarf: { color: '#ffffff', size: 0.5, corona: '#aaccff' },
    neutron: { color: '#8888ff', size: 0.3, corona: '#4444ff' },
  };
  const data = stageData[stage] || stageData.main;

  useFrame((state) => {
    if (coronaRef.current) {
      coronaRef.current.scale.setScalar(1 + Math.sin(state.clock.elapsedTime * 3) * 0.1);
    }
  });

  return (
    <group>
      <mesh ref={starRef}>
        <sphereGeometry args={[data.size, 64, 64]} />
        <meshStandardMaterial color={data.color} emissive={data.color} emissiveIntensity={0.8} />
      </mesh>
      <mesh ref={coronaRef}>
        <sphereGeometry args={[data.size * 1.3, 32, 32]} />
        <meshStandardMaterial color={data.corona} transparent opacity={0.3} />
      </mesh>
      <pointLight intensity={2} color={data.color} />
    </group>
  );
}

// ==================== BLACK HOLE MODEL ====================
function BlackHoleModel() {
  const diskRef = useRef<THREE.Mesh>(null);
  const particlesRef = useRef<THREE.Points>(null);

  useFrame((state) => {
    if (diskRef.current) diskRef.current.rotation.z = state.clock.elapsedTime * 0.5;
    if (particlesRef.current) particlesRef.current.rotation.z = -state.clock.elapsedTime * 0.3;
  });

  const particlePositions = useMemo(() => {
    const positions = [];
    for (let i = 0; i < 500; i++) {
      const r = 2 + Math.random() * 3;
      const theta = Math.random() * Math.PI * 2;
      positions.push(Math.cos(theta) * r, (Math.random() - 0.5) * 0.5, Math.sin(theta) * r);
    }
    return new Float32Array(positions);
  }, []);

  return (
    <group>
      {/* Event horizon */}
      <mesh>
        <sphereGeometry args={[1, 64, 64]} />
        <meshBasicMaterial color="#000000" />
      </mesh>
      {/* Accretion disk */}
      <mesh ref={diskRef} rotation={[Math.PI / 3, 0, 0]}>
        <ringGeometry args={[1.5, 4, 64]} />
        <meshStandardMaterial
          color="#ff6600"
          emissive="#ff4400"
          emissiveIntensity={0.5}
          side={THREE.DoubleSide}
          transparent
          opacity={0.8}
        />
      </mesh>
      {/* Particles */}
      <points ref={particlesRef}>
        <bufferGeometry>
          <bufferAttribute attach="attributes-position" args={[particlePositions, 3]} />
        </bufferGeometry>
        <pointsMaterial color="#ffaa00" size={0.05} transparent opacity={0.8} />
      </points>
    </group>
  );
}

// ==================== GALAXY MODEL ====================
function GalaxyModel() {
  const galaxyRef = useRef<THREE.Points>(null);

  const positions = useMemo(() => {
    const pos = [];
    const arms = 2;
    for (let i = 0; i < 3000; i++) {
      const arm = i % arms;
      const r = Math.random() * 4;
      const theta = (arm / arms) * Math.PI * 2 + r * 0.5 + (Math.random() - 0.5) * 0.3;
      pos.push(
        Math.cos(theta) * r + (Math.random() - 0.5) * 0.3,
        (Math.random() - 0.5) * 0.2,
        Math.sin(theta) * r + (Math.random() - 0.5) * 0.3
      );
    }
    return new Float32Array(pos);
  }, []);

  useFrame((state) => {
    if (galaxyRef.current) galaxyRef.current.rotation.y = state.clock.elapsedTime * 0.1;
  });

  return (
    <group>
      {/* Core */}
      <mesh>
        <sphereGeometry args={[0.3, 32, 32]} />
        <meshStandardMaterial color="#ffeecc" emissive="#ffcc00" emissiveIntensity={0.5} />
      </mesh>
      {/* Stars */}
      <points ref={galaxyRef}>
        <bufferGeometry>
          <bufferAttribute attach="attributes-position" args={[positions, 3]} />
        </bufferGeometry>
        <pointsMaterial color="#ffffff" size={0.03} transparent opacity={0.8} />
      </points>
    </group>
  );
}

// ==================== DNA MODEL ====================
function DNAModel() {
  const groupRef = useRef<THREE.Group>(null);

  useFrame((state) => {
    if (groupRef.current) groupRef.current.rotation.y = state.clock.elapsedTime * 0.3;
  });

  const helixPoints = useMemo(() => {
    const points1 = [], points2 = [];
    for (let i = 0; i < 50; i++) {
      const t = i / 10;
      const angle = t * Math.PI;
      points1.push(new THREE.Vector3(Math.cos(angle) * 0.8, t - 2.5, Math.sin(angle) * 0.8));
      points2.push(new THREE.Vector3(Math.cos(angle + Math.PI) * 0.8, t - 2.5, Math.sin(angle + Math.PI) * 0.8));
    }
    return { points1, points2 };
  }, []);

  return (
    <group ref={groupRef}>
      {/* Helix strands */}
      <mesh>
        <tubeGeometry args={[new THREE.CatmullRomCurve3(helixPoints.points1), 64, 0.08, 8, false]} />
        <meshStandardMaterial color={colors.primary} />
      </mesh>
      <mesh>
        <tubeGeometry args={[new THREE.CatmullRomCurve3(helixPoints.points2), 64, 0.08, 8, false]} />
        <meshStandardMaterial color={colors.secondary} />
      </mesh>
      {/* Base pairs */}
      {Array.from({ length: 10 }).map((_, i) => {
        const t = i / 2;
        const angle = t * Math.PI;
        return (
          <mesh key={i} position={[0, t - 2.5, 0]} rotation={[0, angle, Math.PI / 2]}>
            <cylinderGeometry args={[0.05, 0.05, 1.6, 8]} />
            <meshStandardMaterial color={i % 2 === 0 ? '#ff6b6b' : '#00ff88'} />
          </mesh>
        );
      })}
    </group>
  );
}

// ==================== CELL MODEL ====================
function CellModel() {
  const cellRef = useRef<THREE.Group>(null);

  useFrame((state) => {
    if (cellRef.current) cellRef.current.rotation.y = state.clock.elapsedTime * 0.2;
  });

  return (
    <group ref={cellRef}>
      {/* Cell membrane */}
      <mesh>
        <sphereGeometry args={[2, 32, 32]} />
        <meshStandardMaterial color={colors.primary} transparent opacity={0.3} side={THREE.DoubleSide} />
      </mesh>
      {/* Nucleus */}
      <mesh position={[0.3, 0, 0]}>
        <sphereGeometry args={[0.7, 32, 32]} />
        <meshStandardMaterial color="#8844ff" />
      </mesh>
      {/* Nucleolus */}
      <mesh position={[0.5, 0.1, 0]}>
        <sphereGeometry args={[0.25, 16, 16]} />
        <meshStandardMaterial color="#aa66ff" />
      </mesh>
      {/* Mitochondria */}
      {[[-1, 0.5, 0.5], [-0.8, -0.7, 0.3], [0.8, 0.8, -0.5]].map((pos, i) => (
        <mesh key={i} position={pos as [number, number, number]} rotation={[Math.random(), Math.random(), 0]}>
          <capsuleGeometry args={[0.15, 0.4, 8, 16]} />
          <meshStandardMaterial color="#ff6b6b" />
        </mesh>
      ))}
      {/* ER */}
      <mesh position={[-0.5, -0.3, 0.8]}>
        <torusGeometry args={[0.4, 0.08, 8, 32]} />
        <meshStandardMaterial color="#00ff88" />
      </mesh>
    </group>
  );
}

// ==================== ECOSYSTEM MODEL ====================
function EcosystemModel() {
  const treeRef = useRef<THREE.Group>(null);

  useFrame((state) => {
    if (treeRef.current) {
      treeRef.current.children.forEach((child, i) => {
        if (child.type === 'Mesh') {
          child.rotation.z = Math.sin(state.clock.elapsedTime + i) * 0.05;
        }
      });
    }
  });

  return (
    <group>
      {/* Ground */}
      <mesh position={[0, -2, 0]} rotation={[-Math.PI / 2, 0, 0]}>
        <circleGeometry args={[5, 32]} />
        <meshStandardMaterial color="#2d5a27" />
      </mesh>
      {/* Sun */}
      <mesh position={[3, 3, -2]}>
        <sphereGeometry args={[0.5, 32, 32]} />
        <meshStandardMaterial color="#ffdd00" emissive="#ff8800" emissiveIntensity={0.8} />
      </mesh>
      {/* Trees */}
      <group ref={treeRef}>
        {[[-1.5, 0], [1, 0.5], [0, -1]].map(([x, z], i) => (
          <group key={i} position={[x, -1, z]}>
            <mesh position={[0, -0.5, 0]}>
              <cylinderGeometry args={[0.1, 0.15, 1, 8]} />
              <meshStandardMaterial color="#4a3728" />
            </mesh>
            <mesh position={[0, 0.3, 0]}>
              <coneGeometry args={[0.5, 1.5, 8]} />
              <meshStandardMaterial color="#228b22" />
            </mesh>
          </group>
        ))}
      </group>
      {/* Water */}
      <mesh position={[2, -1.9, 1]} rotation={[-Math.PI / 2, 0, 0]}>
        <circleGeometry args={[1, 32]} />
        <meshStandardMaterial color="#4488ff" transparent opacity={0.7} />
      </mesh>
    </group>
  );
}

// ==================== ROBOT MODEL ====================
function RobotModel() {
  const armRef = useRef<THREE.Group>(null);

  useFrame((state) => {
    if (armRef.current) {
      armRef.current.rotation.z = Math.sin(state.clock.elapsedTime) * 0.5;
    }
  });

  return (
    <group>
      {/* Base */}
      <mesh position={[0, -1.5, 0]}>
        <cylinderGeometry args={[1, 1.2, 0.5, 32]} />
        <meshStandardMaterial color="#444444" metalness={0.8} roughness={0.2} />
      </mesh>
      {/* Arm segment 1 */}
      <group ref={armRef} position={[0, -1, 0]}>
        <mesh position={[0, 0.75, 0]}>
          <boxGeometry args={[0.3, 1.5, 0.3]} />
          <meshStandardMaterial color={colors.primary} metalness={0.6} roughness={0.3} />
        </mesh>
        {/* Joint */}
        <mesh position={[0, 1.5, 0]}>
          <sphereGeometry args={[0.2, 16, 16]} />
          <meshStandardMaterial color="#666666" metalness={0.8} />
        </mesh>
        {/* Arm segment 2 */}
        <group position={[0, 1.5, 0]} rotation={[0, 0, 0.5]}>
          <mesh position={[0, 0.6, 0]}>
            <boxGeometry args={[0.25, 1.2, 0.25]} />
            <meshStandardMaterial color={colors.secondary} metalness={0.6} roughness={0.3} />
          </mesh>
          {/* Gripper */}
          <mesh position={[0, 1.3, 0]}>
            <boxGeometry args={[0.4, 0.15, 0.3]} />
            <meshStandardMaterial color="#888888" metalness={0.8} />
          </mesh>
        </group>
      </group>
    </group>
  );
}

// ==================== QUANTUM CLOUD MODEL ====================
function QuantumCloudModel() {
  const cloudRef = useRef<THREE.Points>(null);

  const positions = useMemo(() => {
    const pos = [];
    for (let i = 0; i < 2000; i++) {
      const r = Math.random() * 2;
      const theta = Math.random() * Math.PI * 2;
      const phi = Math.acos(2 * Math.random() - 1);
      // s-orbital shape
      const density = Math.exp(-r * 2);
      if (Math.random() < density) {
        pos.push(
          r * Math.sin(phi) * Math.cos(theta),
          r * Math.sin(phi) * Math.sin(theta),
          r * Math.cos(phi)
        );
      }
    }
    return new Float32Array(pos);
  }, []);

  useFrame((state) => {
    if (cloudRef.current) {
      cloudRef.current.rotation.y = state.clock.elapsedTime * 0.1;
      cloudRef.current.rotation.x = Math.sin(state.clock.elapsedTime * 0.5) * 0.1;
    }
  });

  return (
    <group>
      {/* Nucleus */}
      <mesh>
        <sphereGeometry args={[0.15, 16, 16]} />
        <meshStandardMaterial color="#ff4444" />
      </mesh>
      {/* Probability cloud */}
      <points ref={cloudRef}>
        <bufferGeometry>
          <bufferAttribute attach="attributes-position" args={[positions, 3]} />
        </bufferGeometry>
        <pointsMaterial color={colors.primary} size={0.03} transparent opacity={0.6} />
      </points>
    </group>
  );
}

// ==================== SPACETIME MODEL (Relativity) ====================
function SpacetimeModel() {
  const gridRef = useRef<THREE.Mesh>(null);

  useFrame((state) => {
    if (gridRef.current) {
      const positions = gridRef.current.geometry.attributes.position.array as Float32Array;
      for (let i = 0; i < positions.length; i += 3) {
        const x = positions[i];
        const z = positions[i + 2];
        const dist = Math.sqrt(x * x + z * z);
        positions[i + 1] = dist < 0.5 ? -2 : -1 / (dist + 0.5);
      }
      gridRef.current.geometry.attributes.position.needsUpdate = true;
    }
  });

  return (
    <group>
      {/* Spacetime grid */}
      <mesh ref={gridRef} rotation={[-Math.PI / 4, 0, 0]}>
        <planeGeometry args={[8, 8, 40, 40]} />
        <meshStandardMaterial color={colors.primary} wireframe side={THREE.DoubleSide} />
      </mesh>
      {/* Mass causing curvature */}
      <mesh position={[0, 0.5, 0]}>
        <sphereGeometry args={[0.4, 32, 32]} />
        <meshStandardMaterial color="#ffaa00" emissive="#ff6600" emissiveIntensity={0.3} />
      </mesh>
    </group>
  );
}

// ==================== MAIN COMPONENT ====================
export type ModelType =
  | 'atom' | 'wave' | 'molecule' | 'planet' | 'electric-field'
  | 'gravity' | 'pressure' | 'pendulum' | 'projectile' | 'force-vectors'
  | 'thermodynamics' | 'star' | 'black-hole' | 'galaxy' | 'dna' | 'cell'
  | 'ecosystem' | 'robot' | 'quantum' | 'spacetime';

interface ModelConfig {
  atom: { protons: number };
  wave: { frequency: number; amplitude: number };
  molecule: { molecule: string };
  planet: { planet: string };
  star: { stage: string };
  [key: string]: Record<string, unknown>;
}

const modelOptions: Record<ModelType, { label: string; options: Array<{ value: string; label: string }> }> = {
  atom: { label: 'Element', options: [{ value: '6', label: 'Carbon (6)' }, { value: '8', label: 'Oxygen (8)' }, { value: '10', label: 'Neon (10)' }, { value: '11', label: 'Sodium (11)' }] },
  wave: { label: 'Pattern', options: [{ value: 'low', label: 'Low Frequency' }, { value: 'medium', label: 'Medium' }, { value: 'high', label: 'High Frequency' }] },
  molecule: { label: 'Molecule', options: [{ value: 'water', label: 'Water (H₂O)' }, { value: 'co2', label: 'CO₂' }, { value: 'methane', label: 'Methane (CH₄)' }, { value: 'nacl', label: 'Salt (NaCl)' }] },
  planet: { label: 'Planet', options: [{ value: 'earth', label: 'Earth' }, { value: 'mars', label: 'Mars' }, { value: 'jupiter', label: 'Jupiter' }, { value: 'saturn', label: 'Saturn' }] },
  star: { label: 'Stage', options: [{ value: 'main', label: 'Main Sequence' }, { value: 'giant', label: 'Red Giant' }, { value: 'dwarf', label: 'White Dwarf' }, { value: 'neutron', label: 'Neutron Star' }] },
  'electric-field': { label: 'Config', options: [{ value: 'dipole', label: 'Dipole' }] },
  gravity: { label: 'View', options: [{ value: 'default', label: 'Falling Objects' }] },
  pressure: { label: 'View', options: [{ value: 'default', label: 'Gas Pressure' }] },
  pendulum: { label: 'View', options: [{ value: 'default', label: 'Simple Pendulum' }] },
  projectile: { label: 'View', options: [{ value: 'default', label: 'Projectile Motion' }] },
  'force-vectors': { label: 'View', options: [{ value: 'default', label: 'Force Diagram' }] },
  thermodynamics: { label: 'View', options: [{ value: 'default', label: 'Particle Motion' }] },
  'black-hole': { label: 'View', options: [{ value: 'default', label: 'Black Hole' }] },
  galaxy: { label: 'View', options: [{ value: 'default', label: 'Spiral Galaxy' }] },
  dna: { label: 'View', options: [{ value: 'default', label: 'DNA Helix' }] },
  cell: { label: 'View', options: [{ value: 'default', label: 'Animal Cell' }] },
  ecosystem: { label: 'View', options: [{ value: 'default', label: 'Forest Ecosystem' }] },
  robot: { label: 'View', options: [{ value: 'default', label: 'Robot Arm' }] },
  quantum: { label: 'View', options: [{ value: 'default', label: 'Electron Cloud' }] },
  spacetime: { label: 'View', options: [{ value: 'default', label: 'Curved Spacetime' }] },
};

interface LessonModelProps {
  type: ModelType;
  config?: Record<string, unknown>;
  title?: string;
  className?: string;
}

export function LessonModel({ type, config = {}, title, className = '' }: LessonModelProps) {
  const [selectedOption, setSelectedOption] = useState(0);
  const options = modelOptions[type] || { label: 'View', options: [{ value: 'default', label: 'Default' }] };

  const getModelConfig = () => {
    const opt = options.options[selectedOption]?.value || 'default';
    switch (type) {
      case 'atom': return { protons: parseInt(opt) || 6 };
      case 'wave': return { frequency: opt === 'low' ? 1 : opt === 'high' ? 4 : 2, amplitude: 1 };
      case 'molecule': return { molecule: opt };
      case 'planet': return { planet: opt };
      case 'star': return { stage: opt };
      default: return {};
    }
  };

  const renderModel = () => {
    const modelConfig = { ...config, ...getModelConfig() };
    switch (type) {
      case 'atom': return <AtomModel {...modelConfig} />;
      case 'wave': return <WaveModel {...modelConfig} />;
      case 'molecule': return <MoleculeModel {...modelConfig} />;
      case 'planet': return <PlanetModel {...modelConfig} />;
      case 'electric-field': return <ElectricFieldModel />;
      case 'gravity': return <GravityModel />;
      case 'pressure': return <PressureModel />;
      case 'pendulum': return <PendulumModel />;
      case 'projectile': return <ProjectileModel />;
      case 'force-vectors': return <ForceVectorModel />;
      case 'thermodynamics': return <ThermodynamicsModel />;
      case 'star': return <StarModel {...modelConfig} />;
      case 'black-hole': return <BlackHoleModel />;
      case 'galaxy': return <GalaxyModel />;
      case 'dna': return <DNAModel />;
      case 'cell': return <CellModel />;
      case 'ecosystem': return <EcosystemModel />;
      case 'robot': return <RobotModel />;
      case 'quantum': return <QuantumCloudModel />;
      case 'spacetime': return <SpacetimeModel />;
      default: return <AtomModel protons={6} />;
    }
  };

  return (
    <div className={`relative rounded-2xl overflow-hidden ${className}`} style={{ background: colors.cardBg, border: `1px solid ${colors.border}` }}>
      {title && (
        <div className="px-5 py-4 border-b" style={{ borderColor: colors.border }}>
          <h3 className="text-lg font-semibold" style={{ color: colors.primary }}>{title}</h3>
          <p className="text-sm text-gray-400">Interactive 3D Model</p>
        </div>
      )}
      <div className="h-[300px] relative">
        <Canvas camera={{ position: [0, 2, 6], fov: 50 }}>
          <Suspense fallback={null}>
            <ambientLight intensity={0.4} />
            <directionalLight position={[5, 5, 5]} intensity={0.8} />
            <directionalLight position={[-5, -5, 5]} intensity={0.3} color={colors.primary} />
            {renderModel()}
            <OrbitControls enableZoom enablePan={false} />
            <Environment preset="night" />
          </Suspense>
        </Canvas>
        <div className="absolute bottom-2 left-1/2 -translate-x-1/2 px-3 py-1 rounded-full text-xs" style={{ background: 'rgba(0,0,0,0.6)', color: '#90caf9' }}>
          Drag to rotate
        </div>
      </div>
      <div className="p-4 border-t" style={{ borderColor: colors.border }}>
        <p className="text-sm mb-3" style={{ color: colors.primary }}>{options.label}</p>
        <div className="flex flex-col gap-2">
          {options.options.map((opt, i) => (
            <button key={i} onClick={() => setSelectedOption(i)}
              className="w-full text-left px-4 py-3 rounded-xl transition-all duration-200"
              style={{
                background: selectedOption === i ? `linear-gradient(135deg, ${colors.primary}33, ${colors.secondary}22)` : 'rgba(255,255,255,0.03)',
                border: selectedOption === i ? `2px solid ${colors.primary}` : '2px solid transparent',
                color: selectedOption === i ? colors.primary : '#ffffff',
              }}>
              <span className="font-medium">{opt.label}</span>
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}

export default LessonModel;
