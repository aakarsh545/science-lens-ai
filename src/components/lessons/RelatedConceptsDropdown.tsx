import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible";
import { ChevronDown, ChevronRight, BookOpen, Link2, Zap } from "lucide-react";

interface RelatedConcept {
  title: string;
  description: string;
  type: "prerequisite" | "related" | "application";
  lessonSlug?: string;
  courseSlug?: string;
}

interface RelatedConceptsDropdownProps {
  lessonTitle: string;
  courseSlug?: string;
  chapter?: string;
}

// Related concepts mapping based on lesson content
const getRelatedConcepts = (lessonTitle: string, courseSlug?: string, chapter?: string): RelatedConcept[] => {
  const title = lessonTitle.toLowerCase();

  // Chemistry Concepts
  if (courseSlug?.includes("chemistry")) {
    if (title.includes("atom") || title.includes("element")) {
      return [
        {
          title: "Protons, Neutrons, and Electrons",
          description: "The three subatomic particles that make up atoms. Protons have positive charge, neutrons have no charge, and electrons have negative charge.",
          type: "prerequisite"
        },
        {
          title: "Periodic Table Organization",
          description: "Elements are arranged by atomic number and grouped by similar properties. Understanding groups and periods helps predict element behavior.",
          type: "related"
        },
        {
          title: "Why Water is Essential",
          description: "Water's unique properties come from its molecular structure. Essential for all known life forms and most chemical reactions.",
          type: "application"
        }
      ];
    }
    if (title.includes("bonding")) {
      return [
        {
          title: "Electron Shells and Valence",
          description: "Electrons orbit in shells around the nucleus. The outermost shell (valence shell) determines how atoms bond.",
          type: "prerequisite"
        },
        {
          title: "Ionic vs Covalent Bonds",
          description: "Ionic bonds transfer electrons creating ions, while covalent bonds share electrons. This difference explains why salt dissolves but oil doesn't.",
          type: "related"
        },
        {
          title: "Water's Covalent Bonds",
          description: "Water molecules are held together by covalent bonds, but water molecules stick to each other through hydrogen bonds.",
          type: "application"
        }
      ];
    }
    if (title.includes("reaction")) {
      return [
        {
          title: "Conservation of Mass",
          description: "Matter cannot be created or destroyed in chemical reactions. This is why we must balance chemical equations.",
          type: "prerequisite"
        },
        {
          title: "Energy in Reactions",
          description: "Reactions either release energy (exothermic) or absorb energy (endothermic). Your body uses both types.",
          type: "related"
        },
        {
          title: "Digestion: Chemical Reactions in Your Body",
          description: "Digestion breaks down food through hydrolysis reactions, turning complex molecules into simple ones your cells can use.",
          type: "application"
        }
      ];
    }
    if (title.includes("acid") || title.includes("base") || title.includes("ph")) {
      return [
        {
          title: "Ions in Solution",
          description: "Acids and bases work by producing ions when dissolved in water. Understanding ions helps explain their properties.",
          type: "prerequisite"
        },
        {
          title: "The pH Scale",
          description: "pH measures acidity on a scale of 0-14. Each number is 10 times different from the next - a logarithmic scale!",
          type: "related"
        },
        {
          title: "Why Your Stomach Doesn't Digest Itself",
          description: "Your stomach produces very strong acid (pH ~2), but special mucus protects it. Amazing chemical adaptation!",
          type: "application"
        }
      ];
    }
  }

  // Biology Concepts
  if (courseSlug?.includes("biology") || courseSlug?.includes("cell")) {
    if (title.includes("cell")) {
      return [
        {
          title: "Prokaryotes vs Eukaryotes",
          description: "Prokaryotes (bacteria) lack a nucleus, while eukaryotes (plants, animals) have membrane-bound organelles. This difference is fundamental!",
          type: "prerequisite"
        },
        {
          title: "Cell Theory",
          description: "All living things are made of cells, cells are the basic unit of life, and all cells come from pre-existing cells.",
          type: "related"
        },
        {
          title: "Why Cells Are Small",
          description: "Cells stay small because as they grow, volume increases faster than surface area. They need surface area to exchange materials!",
          type: "application"
        }
      ];
    }
    if (title.includes("dna") || title.includes("genetic")) {
      return [
        {
          title: "Nucleotides: DNA Building Blocks",
          description: "DNA is made of nucleotides: sugar, phosphate, and a base (A, T, C, G). The sequence of bases stores genetic information.",
          type: "prerequisite"
        },
        {
          title: "DNA Replication",
          description: "Before cells divide, DNA must copy itself. This semi-conservative process ensures each daughter cell gets a complete set of instructions.",
          type: "related"
        },
        {
          title: "DNA Testing and Forensics",
          description: "Because everyone's DNA is unique (except identical twins), DNA can identify criminals, solve paternity cases, and exonerate the innocent.",
          type: "application"
        }
      ];
    }
    if (title.includes("protein")) {
      return [
        {
          title: "Amino Acids",
          description: "Proteins are chains of 20 different amino acids. The sequence determines how the protein folds and what it does.",
          type: "prerequisite"
        },
        {
          title: "From DNA to Protein",
          description: "The central dogma: DNA → RNA → Protein. This flow of information is how your genes become physical traits.",
          type: "related"
        },
        {
          title: "Enzymes: Biological Catalysts",
          description: "Enzymes are proteins that speed up chemical reactions. Without them, life would be too slow to sustain itself.",
          type: "application"
        }
      ];
    }
    if (title.includes("evolution")) {
      return [
        {
          title: "Natural Selection",
          description: "Individuals with favorable traits survive and reproduce more, passing those traits to offspring. Over time, the population changes.",
          type: "prerequisite"
        },
        {
          title: "Evidence for Evolution",
          description: "Fossils show changes over time. DNA reveals relationships. Homologous structures suggest common ancestry. All evidence points to evolution!",
          type: "related"
        },
        {
          title: "Antibiotic Resistance",
          description: "Bacteria evolve resistance to antibiotics through natural selection. This is why you must finish prescribed antibiotics!",
          type: "application"
        }
      ];
    }
  }

  // Physics Concepts
  if (courseSlug?.includes("physics")) {
    if (title.includes("force") || title.includes("motion")) {
      return [
        {
          title: "Newton's First Law",
          description: "Objects stay at rest or in motion unless acted upon by a force. This inertia explains why seatbelts are necessary!",
          type: "prerequisite"
        },
        {
          title: "F = ma",
          description: "Force equals mass times acceleration. This simple equation explains how everything from rockets to muscles works.",
          type: "related"
        },
        {
          title: "Car Safety Design",
          description: "Crumple zones, airbags, and seatbelts all work by extending the time of impact, reducing the force on passengers.",
          type: "application"
        }
      ];
    }
    if (title.includes("energy")) {
      return [
        {
          title: "Kinetic vs Potential Energy",
          description: "Kinetic energy is energy of motion. Potential energy is stored energy. Energy constantly transforms between these forms.",
          type: "prerequisite"
        },
        {
          title: "Conservation of Energy",
          description: "Energy cannot be created or destroyed, only transformed. This fundamental law governs all physical processes.",
          type: "related"
        },
        {
          title: "Why You Eat Food",
          description: "Your body can't create energy. You must consume food to get the chemical energy your cells need to function.",
          type: "application"
        }
      ];
    }
    if (title.includes("wave") || title.includes("sound") || title.includes("light")) {
      return [
        {
          title: "Wave Properties",
          description: "Waves have wavelength, frequency, and amplitude. These properties determine pitch (sound) and color (light).",
          type: "prerequisite"
        },
        {
          title: "Electromagnetic Spectrum",
          description: "Light is just one tiny part of the EM spectrum. Radio, microwaves, X-rays, and gamma rays are all electromagnetic waves!",
          type: "related"
        },
        {
          title: "Why the Sky is Blue",
          description: "Sunlight contains all colors. The atmosphere scatters blue light more than other colors, making the sky appear blue.",
          type: "application"
        }
      ];
    }
  }

  // Default concepts for any lesson
  return [
    {
      title: "Chapter Context",
      description: chapter
        ? `This lesson is part of "${chapter}" - building your understanding step by step.`
        : "This lesson builds on fundamental concepts to help you understand more complex topics.",
      type: "related"
    },
    {
      title: "How This Connects",
      description: "Everything you learn connects to other topics. Science is interconnected - understanding one concept helps you understand many others!",
      type: "related"
    }
  ];
};

const getTypeColor = (type: string) => {
  switch (type) {
    case "prerequisite":
      return "bg-blue-500/20 text-blue-300 border-blue-500/30";
    case "related":
      return "bg-purple-500/20 text-purple-300 border-purple-500/30";
    case "application":
      return "bg-green-500/20 text-green-300 border-green-500/30";
    default:
      return "bg-gray-500/20 text-gray-300 border-gray-500/30";
  }
};

const getTypeIcon = (type: string) => {
  switch (type) {
    case "prerequisite":
      return BookOpen;
    case "related":
      return Link2;
    case "application":
      return Zap;
    default:
      return BookOpen;
  }
};

const getTypeLabel = (type: string) => {
  switch (type) {
    case "prerequisite":
      return "Foundation";
    case "related":
      return "Related";
    case "application":
      return "Real World";
    default:
      return "Info";
  }
};

export default function RelatedConceptsDropdown({
  lessonTitle,
  courseSlug,
  chapter,
}: RelatedConceptsDropdownProps) {
  const [isOpen, setIsOpen] = useState(false);
  const concepts = getRelatedConcepts(lessonTitle, courseSlug, chapter);

  if (concepts.length === 0) {
    return null;
  }

  return (
    <Card
      className="border-primary/30 bg-gradient-to-br from-primary/5 to-purple-500/5"
      style={{
        backdropFilter: "blur(10px)",
      }}
    >
      <Collapsible open={isOpen} onOpenChange={setIsOpen}>
        <CollapsibleTrigger asChild>
          <CardHeader className="cursor-pointer hover:bg-primary/5 transition-colors">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div
                  className="p-2 rounded-lg bg-gradient-to-br from-blue-500/20 to-purple-500/20"
                  style={{ color: "#00d4ff" }}
                >
                  <BookOpen className="w-5 h-5" />
                </div>
                <div className="text-left">
                  <CardTitle className="text-lg">Related Concepts</CardTitle>
                  <p className="text-sm text-muted-foreground">
                    {concepts.length} {concepts.length === 1 ? "connection" : "connections"} to explore
                  </p>
                </div>
              </div>
              {isOpen ? (
                <ChevronDown className="w-5 h-5 text-muted-foreground" />
              ) : (
                <ChevronRight className="w-5 h-5 text-muted-foreground" />
              )}
            </div>
          </CardHeader>
        </CollapsibleTrigger>

        <CollapsibleContent>
          <CardContent className="space-y-4 pt-0">
            <p className="text-sm text-muted-foreground mb-4">
              Explore how this lesson connects to other concepts and real-world applications
            </p>

            <div className="space-y-3">
              {concepts.map((concept, index) => {
                const Icon = getTypeIcon(concept.type);
                return (
                  <div
                    key={index}
                    className="p-4 rounded-lg border bg-card/50 hover:bg-card transition-colors"
                  >
                    <div className="flex items-start gap-3">
                      <div className="mt-0.5">
                        <Icon className="w-4 h-4 text-primary" />
                      </div>
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center gap-2 flex-wrap">
                          <h4 className="font-semibold text-foreground">
                            {concept.title}
                          </h4>
                          <Badge
                            variant="outline"
                            className={`text-xs ${getTypeColor(concept.type)}`}
                          >
                            {getTypeLabel(concept.type)}
                          </Badge>
                        </div>
                        <p className="text-sm text-muted-foreground">
                          {concept.description}
                        </p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>

            <div className="pt-2 border-t border-border/50">
              <p className="text-xs text-muted-foreground italic">
                💡 Tip: Understanding these related concepts will help you master the
                material and see how everything connects!
              </p>
            </div>
          </CardContent>
        </CollapsibleContent>
      </Collapsible>
    </Card>
  );
}
