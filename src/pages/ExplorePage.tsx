import { Telescope, Microscope, Atom, Dna, FlaskConical, Star } from "lucide-react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";

const scienceCategories = [
  {
    icon: Atom,
    title: "Physics",
    description: "Explore the fundamental laws of the universe",
    color: "text-blue-500",
    topics: ["Classical Mechanics", "Quantum Physics", "Thermodynamics", "Electromagnetism"]
  },
  {
    icon: FlaskConical,
    title: "Chemistry",
    description: "Discover the composition and properties of matter",
    color: "text-green-500",
    topics: ["Organic Chemistry", "Inorganic Chemistry", "Physical Chemistry", "Biochemistry"]
  },
  {
    icon: Dna,
    title: "Biology",
    description: "Understand life and living organisms",
    color: "text-emerald-500",
    topics: ["Cell Biology", "Genetics", "Evolution", "Ecology"]
  },
  {
    icon: Star,
    title: "Astronomy",
    description: "Journey through space and celestial bodies",
    color: "text-purple-500",
    topics: ["Planetary Science", "Stellar Astronomy", "Cosmology", "Astrobiology"]
  },
  {
    icon: Microscope,
    title: "Earth Science",
    description: "Study our planet and its systems",
    color: "text-amber-500",
    topics: ["Geology", "Meteorology", "Oceanography", "Environmental Science"]
  },
  {
    icon: Telescope,
    title: "Advanced Topics",
    description: "Cutting-edge science and research",
    color: "text-pink-500",
    topics: ["Nanotechnology", "AI & Robotics", "Renewable Energy", "Biotechnology"]
  }
];

export default function ExplorePage() {
  const navigate = useNavigate();

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-4xl font-bold bg-gradient-cosmic bg-clip-text text-transparent mb-2">
          Explore Science
        </h1>
        <p className="text-muted-foreground">
          Discover the vast world of scientific knowledge
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {scienceCategories.map((category) => (
          <Card key={category.title} className="hover:shadow-cosmic transition-all duration-300 group">
            <CardHeader>
              <div className="flex items-center gap-3 mb-2">
                <category.icon className={`w-8 h-8 ${category.color} group-hover:scale-110 transition-transform`} />
                <CardTitle className="group-hover:text-primary transition-colors">
                  {category.title}
                </CardTitle>
              </div>
              <CardDescription>{category.description}</CardDescription>
            </CardHeader>
            
            <CardContent>
              <div className="space-y-3">
                <div className="space-y-1">
                  {category.topics.map((topic) => (
                    <div key={topic} className="text-sm text-muted-foreground hover:text-foreground transition-colors cursor-pointer">
                      • {topic}
                    </div>
                  ))}
                </div>
                
                <Button 
                  onClick={() => navigate("/learn-science")}
                  variant="outline"
                  className="w-full mt-4"
                >
                  Start Learning
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
