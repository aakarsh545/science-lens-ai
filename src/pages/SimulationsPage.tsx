import { useState } from 'react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import InteractiveSimulation from '@/components/animations/InteractiveSimulation';
import { Atom, Globe2, FlaskConical, Dna, Activity, Waves, Timer, Heart } from 'lucide-react';

type SimulationType = 'atom' | 'solar' | 'cell' | 'dna' | 'wave' | 'pendulum' | 'heart';

const simulations: { id: SimulationType; title: string; description: string; icon: React.ReactNode; category: string }[] = [
  {
    id: 'atom',
    title: 'Atomic Structure',
    description: 'Explore the structure of an atom with electrons orbiting the nucleus',
    icon: <Atom className="w-5 h-5" />,
    category: 'Physics'
  },
  {
    id: 'solar',
    title: 'Solar System',
    description: 'Visualize planetary orbits around the sun with accurate relative sizes',
    icon: <Globe2 className="w-5 h-5" />,
    category: 'Astronomy'
  },
  {
    id: 'cell',
    title: 'Animal Cell',
    description: 'Examine the organelles inside a eukaryotic cell',
    icon: <FlaskConical className="w-5 h-5" />,
    category: 'Biology'
  },
  {
    id: 'dna',
    title: 'DNA Double Helix',
    description: 'Study the structure of DNA with base pair connections',
    icon: <Dna className="w-5 h-5" />,
    category: 'Biology'
  },
  {
    id: 'wave',
    title: 'Wave Motion',
    description: 'Understand wave properties like frequency and amplitude',
    icon: <Waves className="w-5 h-5" />,
    category: 'Physics'
  },
  {
    id: 'pendulum',
    title: 'Simple Pendulum',
    description: 'Explore simple harmonic motion and period relationships',
    icon: <Timer className="w-5 h-5" />,
    category: 'Physics'
  },
  {
    id: 'heart',
    title: 'Human Heart',
    description: 'See how the heart beats and pumps blood through chambers',
    icon: <Heart className="w-5 h-5" />,
    category: 'Biology'
  },
];

export default function SimulationsPage() {
  const [selectedSim, setSelectedSim] = useState<SimulationType>('atom');

  const categories = [...new Set(simulations.map(s => s.category))];

  return (
    <div className="container mx-auto py-8 px-4 max-w-7xl">
      <div className="mb-8">
        <h1 className="text-3xl font-bold mb-2">Interactive Simulations</h1>
        <p className="text-muted-foreground">
          Explore 3D models and manipulate them in real-time to understand scientific concepts
        </p>
      </div>

      <div className="grid lg:grid-cols-[300px_1fr] gap-6">
        {/* Sidebar - Simulation List */}
        <div className="space-y-4">
          <Tabs defaultValue={categories[0]} className="w-full">
            <TabsList className="grid w-full grid-cols-2">
              {categories.map(cat => (
                <TabsTrigger key={cat} value={cat} className="text-xs">
                  {cat}
                </TabsTrigger>
              ))}
            </TabsList>
            
            {categories.map(cat => (
              <TabsContent key={cat} value={cat} className="mt-4 space-y-2">
                {simulations
                  .filter(s => s.category === cat)
                  .map(sim => (
                    <Card 
                      key={sim.id}
                      className={`cursor-pointer transition-all hover:border-primary/50 ${
                        selectedSim === sim.id ? 'border-primary bg-primary/5' : ''
                      }`}
                      onClick={() => setSelectedSim(sim.id)}
                    >
                      <CardHeader className="p-4">
                        <CardTitle className="text-sm flex items-center gap-2">
                          {sim.icon}
                          {sim.title}
                        </CardTitle>
                        <CardDescription className="text-xs">
                          {sim.description}
                        </CardDescription>
                      </CardHeader>
                    </Card>
                  ))}
              </TabsContent>
            ))}
          </Tabs>
        </div>

        {/* Main Content - Simulation */}
        <div>
          <InteractiveSimulation 
            type={selectedSim} 
            title={simulations.find(s => s.id === selectedSim)?.title}
          />
          
          {/* Info Card */}
          <Card className="mt-4">
            <CardHeader>
              <CardTitle className="text-lg flex items-center gap-2">
                {simulations.find(s => s.id === selectedSim)?.icon}
                {simulations.find(s => s.id === selectedSim)?.title}
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <p className="text-muted-foreground text-sm">
                {simulations.find(s => s.id === selectedSim)?.description}
              </p>
              
              <div className="text-sm space-y-2">
                <h4 className="font-medium">How to use:</h4>
                <ul className="list-disc list-inside text-muted-foreground space-y-1">
                  <li>Click and drag to rotate the model</li>
                  <li>Scroll to zoom in/out</li>
                  <li>Right-click and drag to pan</li>
                  <li>Use the sliders to adjust properties</li>
                  <li>Toggle labels to show/hide annotations</li>
                </ul>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}
