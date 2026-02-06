// Temporarily disabled Three.js imports due to WebGL compatibility issues
// import { Canvas } from '@react-three/fiber';
// import { OrbitControls, Sphere } from '@react-three/drei';
// import { useRef } from 'react';
// import { Group } from 'three';
// import { useFrame } from '@react-three/fiber';

import { FlaskConical } from 'lucide-react';

export default function ChemistryAnimation() {
  return (
    <div className="w-full h-64 rounded-lg overflow-hidden bg-muted/20 flex items-center justify-center">
      <div className="text-center">
        <FlaskConical className="w-12 h-12 mx-auto mb-2 text-blue-500" />
        <p className="text-sm text-muted-foreground">Chemistry Animation</p>
        <p className="text-xs text-muted-foreground/60 mt-1">3D visualization temporarily disabled</p>
      </div>
    </div>
  );
}
