# PRP-001: Integrate Interactive Simulations into Lessons

## Executive Summary
Integrate the existing `InteractiveSim.tsx` component (which supports PhET, Spline, Rive, and Lottie) into the lesson player so lessons can display interactive science simulations.

## Success Criteria
- [ ] LessonPlayer.tsx displays PhET/Spline/Lottie/Rive simulations when lesson content contains simulation markers
- [ ] PhET/Spline/Lottie/Rive simulations render correctly in lessons
- [ ] User can interact with simulations (rotate, zoom, play controls)
- [ ] No console errors when loading simulations
- [ ] Lessons remain backward compatible (non-simulation lessons still work)

## Pre-Flight Checks
- [x] Check if InteractiveSim.tsx exports required components
- [x] Verify lesson content format supports simulation embedding
- [x] Test PhET simulation URLs load correctly
- [x] Ensure proper error handling for failed simulation loads
- [x] Verify Spline 3D models load correctly
- [x] Verify Rive animations load correctly
- [x] Verify Lottie animations load correctly

## Implementation Tasks

### Phase 1: Add Simulation Support to Lesson Content
1. Update `lesson.content` JSON schema to support simulation type
2. Add `simulation` field to lesson interface
3. Create simulation marker detection regex
4. Update lesson content parser to detect and render simulations

**File**: `src/types/lesson.ts` (UPDATE)
```typescript
export interface Lesson {
  id: string;
  title: string;
  content: string;
  slug?: string;
  animations?: unknown[];
  examples?: LessonExample[];
  quiz?: QuizQuestion[];
  xp_reward: number;
  order_index: number;
  chapter?: string;
  simulation?: {
    type: 'phet' | 'spline' | 'rive' | 'lottie';
    url?: string;
    title?: string;
  config?: any;
  };
}
```

**File**: `src/pages/LessonPlayer.tsx` (UPDATE - add simulation rendering)
```typescript
// Add after line 25:
import { PhETSimulation } from '@/components/lessons/PhETSimulation';

// Update lesson content parsing to detect simulations
const parseLessonContent = (content: string): SimulationInfo[] => {
  if (!content) return [];

  // Try to parse as JSON first
  try {
    const parsed = JSON.parse(content);
    if (parsed.parts && Array.isArray(parsed.parts)) {
      return parsed.parts
        .filter((part: any) => {
          const partContent = typeof part.content === 'string' ? part.content : JSON.stringify(part.content);
          return partContent.includes('sim:') || partContent.includes('simulation');
        })
        .map((part: any, index: number) => ({
          type: 'simulation',
          title: part.title || `Simulation ${index + 1}`,
          content: partContent
        }));
    }
  } catch {
    // If JSON parsing fails, look for simulation markers in plain text
    const simulationMarkers = [
      /\\sim\{[^}]+\}/gi,
      /\[Simulator:([^\]]+)\]/gi,
      /(?:simulation|sim)\s*[:=]\s*([^\]]+)\}/gi
    ];

    const simulations: SimulationInfo[] = [];
    let match;

    for (const marker of simulationMarkers) {
      const regex = new RegExp(marker, 'gi');
      while ((match = regex.exec(content)) !== null) {
        const simType = match[1]?.toLowerCase() || 'phet';
        const simTitle = match[2]?.trim() || `Simulation ${simulations.length + 1}`;
        const simUrl = match[3]?.trim() || '';

        simulations.push({
          type: simType as any,
          title: simTitle,
          url: simUrl,
          content: `{{${match[0]}}}`
        });
      }
    }

    return simulations;
  }
};

// Add to JSX return (after quiz section, around line 820):
{lesson && lesson.content && (
  <>
    {/* Render simulations if present */}
    {parseLessonContent(lesson.content).map((sim, idx) => (
      <PhETSimulation key={idx} {...sim} />
    ))}
  </>
>
```

### Phase 2: Create PhETSimulation Component
**File**: `src/components/lessons/PhETSimulation.tsx` (NEW FILE)
```typescript
import React from 'react';

interface PhETSimulationProps {
  type: 'phet' | 'spline' | 'rive' | 'lottie';
  url?: string;
  title?: string;
  config?: any;
}

export const PhETSimulation: React.FC<PhETSimulationProps> = ({ type, url, title, config }) => {
  const renderSimulation = () => {
    switch (type) {
      case 'phet':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-blue-200 bg-blue-50">
            <iframe
              src={url}
              title={title || 'PHET Simulation'}
              className="w-full h-full"
              allowFullScreen
              loading="lazy"
            />
          </div>
        );

      case 'spline':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-purple-200 bg-purple-50">
            <iframe
              src={url}
              title={title || 'Spline 3D Model'}
              className="w-full h-full"
              allowFullScreen
              loading="lazy"
            />
          </div>
        );

      case 'rive':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-green-200 bg-green-50">
            <iframe
              src={url}
              title={title || 'Rive Animation'}
              className="w-full h-full"
              allowFullScreen
              loading="lazy"
            />
          </div>
        );

      case 'lottie':
        return (
          <div className="w-full h-[600px] rounded-lg border-2 border-orange-200 bg-orange-50">
            <Lottie
              src={url}
              title={title || 'Lottie Animation'}
              className="w-full h-full"
              allowFullScreen
              loading="lazy"
            />
          </div>
        );

    default: null;
  };
};
```

### Phase 3: Testing & Deployment
- Test PhET simulations load in different lesson types
- Test Spline 3D models load correctly
- Test Rive animations load correctly
- Test error handling for failed loads

## Rollout Plan
1. Commit and push changes
2. Test with existing lesson content to verify backward compatibility
3. Add test lessons with simulation content to verify integration
