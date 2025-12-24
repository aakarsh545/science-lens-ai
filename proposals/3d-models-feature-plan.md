# 3D Interactive Models Feature Plan

## Overview
Add lesson-specific 3D interactive models that enhance learning through visual manipulation and exploration. Each lesson gets a contextually relevant 3D model that students can rotate, zoom, and interact with.

## Architecture

### Data Model
```sql
ALTER TABLE lessons ADD COLUMN model_config JSONB;
-- model_config: {
--   type: "atom" | "wave" | "planet" | "molecule" | "field" | "custom",
--   params: { ... type-specific parameters },
--   interactions: ["rotate", "zoom", "explode", "animate", "slice"],
--   annotations: [{ position: [x,y,z], label: "...", description: "..." }]
-- }
```

### Component Structure
```
src/components/3d/
├── ModelViewer.tsx          # Main wrapper component
├── models/
│   ├── AtomModel.tsx        # Bohr model, electron clouds
│   ├── WaveModel.tsx        # Wave interference, standing waves
│   ├── PlanetaryModel.tsx   # Solar system, orbits
│   ├── MoleculeModel.tsx    # Chemical structures
│   ├── FieldModel.tsx       # Electric/magnetic fields
│   └── CustomModel.tsx      # GLTF/GLB loader
├── controls/
│   ├── OrbitControls.tsx    # Camera rotation
│   ├── SliceControls.tsx    # Cross-section views
│   └── AnimationControls.tsx # Play/pause/speed
└── annotations/
    └── ModelAnnotation.tsx  # 3D labels and tooltips
```

## Technology Stack
- **Three.js** via @react-three/fiber
- **@react-three/drei** for controls and helpers
- **@react-spring/three** for animations
- **cannon-js** for physics simulations (optional)

## Lesson-Model Mapping Examples

| Lesson | Model Type | Interactions |
|--------|-----------|--------------|
| Atomic Structure | Atom (Bohr) | Rotate, zoom, toggle electron shells |
| Waves | Wave interference | Adjust frequency, amplitude, phase |
| Light & Optics | Ray tracing | Move light source, adjust angles |
| Molecular Bonds | Molecule | Rotate, explode to see bonds |
| Planetary Motion | Solar system | Time slider, orbit traces |
| Electric Fields | Field lines | Place charges, see field changes |
| Quantum Concepts | Probability clouds | Toggle orbitals, energy levels |

## Implementation Phases

### Phase 1: Foundation (Week 1-2)
- [ ] Set up Three.js with React Three Fiber
- [ ] Create ModelViewer wrapper component
- [ ] Implement basic orbit controls
- [ ] Add lighting and environment

### Phase 2: Core Models (Week 3-4)
- [ ] AtomModel - configurable electron shells
- [ ] WaveModel - adjustable parameters
- [ ] MoleculeModel - common molecules library

### Phase 3: Advanced Models (Week 5-6)
- [ ] PlanetaryModel with Kepler motion
- [ ] FieldModel for E&M visualization
- [ ] Physics simulations

### Phase 4: Integration (Week 7)
- [ ] Database migration for model_config
- [ ] LessonPlayer integration
- [ ] Mobile touch controls
- [ ] Performance optimization

### Phase 5: Content (Week 8)
- [ ] Configure models for all physics lessons
- [ ] Add models to chemistry lessons
- [ ] Add models to astronomy lessons

## API Design

```typescript
interface Model3DConfig {
  type: ModelType;
  params: ModelParams;
  interactions: Interaction[];
  annotations: Annotation3D[];
  initialCamera: CameraPosition;
}

// Usage in LessonPlayer
<ModelViewer
  config={lesson.model_config}
  onInteraction={(event) => trackLearning(event)}
/>
```

## Performance Considerations
- Lazy load Three.js bundle (~500KB)
- Use instanced meshes for particles
- LOD (Level of Detail) for complex models
- WebGL context management
- Fallback images for unsupported browsers

## Accessibility
- Keyboard controls for rotation/zoom
- Screen reader descriptions
- Reduced motion option
- High contrast mode for annotations
