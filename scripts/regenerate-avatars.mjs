import 'dotenv/config';
import OpenAI from 'openai';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

// All avatars with their descriptions
const avatars = [
  { name: 'Novice Scientist', category: 'science', level: 'novice', description: 'young scientist with glasses and lab coat' },
  { name: 'Lab Assistant', category: 'chemistry', level: 'beginner', description: 'entry-level researcher' },
  { name: 'Book Worm', category: 'study', level: 'starter', description: 'avid learner with books' },
  { name: 'Magnifier', category: 'discovery', level: 'basic', description: 'curious explorer with magnifying glass' },
  { name: 'Note Taker', category: 'study', level: 'learner', description: 'diligent student taking notes' },

  { name: 'Researcher', category: 'science', level: 'junior', description: 'dedicated scientist with determined look' },
  { name: 'Astronomer', category: 'space', level: 'enthusiast', description: 'star gazer looking at stars' },
  { name: 'Biologist', category: 'biology', level: 'student', description: 'life scientist with plants' },
  { name: 'Geologist', category: 'earth', level: 'rookie', description: 'earth explorer with rocks' },
  { name: 'Chemistry Pro', category: 'chemistry', level: 'skilled', description: 'chemistry expert with flask' },

  { name: 'Professor', category: 'academia', level: 'professor', description: 'academic expert with graduation cap' },
  { name: 'Rocket Pilot', category: 'space', level: 'pilot', description: 'space pilot in cockpit' },
  { name: 'Quantum Scholar', category: 'physics', level: 'scholar', description: 'quantum enthusiast with atoms' },
  { name: 'Geneticist', category: 'biology', level: 'expert', description: 'DNA expert with helix' },
  { name: 'Particle Physicist', category: 'physics', level: 'researcher', description: 'particle science with particles' },

  { name: 'Nobel Winner', category: 'prestige', level: 'winner', description: 'prestige scientist with medal and crown' },
  { name: 'Time Traveler', category: 'physics', level: 'master', description: 'temporal explorer with clock' },
  { name: 'Dimensional', category: 'physics', level: 'theorist', description: 'multi-dimensional being with portals' },
  { name: 'Alien Life', category: 'biology', level: 'specialist', description: 'exobiologist with alien lifeforms' },
  { name: 'Cyborg Mind', category: 'technology', level: 'enhanced', description: 'enhanced intellect with cybernetics' },

  { name: 'Dragon Master', category: 'mythical', level: 'master', description: 'legendary dragon tamer with dragons' },
  { name: 'Phoenix Rising', category: 'fire', level: 'legend', description: 'rising from flames as phoenix' },
  { name: 'Time Lord', category: 'physics', level: 'controller', description: 'master of time with hourglass' },
  { name: 'God of Science', category: 'prestige', level: 'deity', description: 'deity of knowledge with crown' },
  { name: 'Universe Creator', category: 'cosmos', level: 'creator', description: 'cosmic architect creating universe' },

  { name: 'Celestial Being', category: 'divine', level: 'ascended', description: 'higher entity with glowing aura' },
  { name: 'Void Emperor', category: 'cosmos', level: 'ruler', description: 'master of void with dark power' },
  { name: 'Quantum Deity', category: 'physics', level: 'transcendent', description: 'god of quantum with third eye' },
  { name: 'Titans Wrath', category: 'mythical', level: 'titan', description: 'powerful titan with lightning' },
  { name: 'Primordial One', category: 'divine', level: 'primordial', description: 'ancient god with cosmic power' },

  { name: 'Reality Shaper', category: 'divine', level: 'shaper', description: 'shape existence with hands' },
  { name: 'Eternal Watcher', category: 'divine', level: 'eternal', description: 'eternal being with all-seeing eyes' },
  { name: 'Alpha Omega', category: 'divine', level: 'absolute', description: 'beginning and end symbol' },
  { name: 'Supreme Creator', category: 'divine', level: 'supreme', description: 'supreme god creating worlds' },
  { name: 'The Absolute', category: 'divine', level: 'ultimate', description: 'ultimate being with infinite power' }
];

// Helper function to create avatar prompt
function createAvatarPrompt(avatar) {
  return `A SINGLE anime character portrait for "${avatar.name}".

CRITICAL: SHOW EXACTLY ONE CHARACTER - NO MULTIPLE CHARACTERS, NO GROUPS, NO BACKGROUND CHARACTERS.

Description: ${avatar.description}.
Category: ${avatar.category}, Power level: ${avatar.level}.

Style: One Piece anime style - cartoony, expressive, bold outlines, vibrant colors, exaggerated features, dynamic pose.
Think Eiichiro Oda's art style: energetic expressions, distinctive character designs, comic-book flair.

Create ONE distinctive character with unique features, expressions, and accessories that match their role.
Focus on their face and upper body.
White or simple solid background.
High quality cartoony anime character art.

REMEMBER: ONLY ONE CHARACTER IN THE ENTIRE IMAGE!`;
}

// Generate avatar image
async function generateAvatar(avatar, index) {
  try {
    console.log(`Generating avatar ${index + 1}/${avatars.length}: ${avatar.name}`);

    const prompt = createAvatarPrompt(avatar);
    const response = await openai.images.generate({
      model: "dall-e-3",
      prompt: prompt,
      n: 1,
      size: "1024x1024",
      quality: "standard",
      response_format: "b64_json"
    });

    const imageBase64 = response.data[0].b64_json;
    const buffer = Buffer.from(imageBase64, 'base64');

    // Save image
    const filename = `avatar-${avatar.name.toLowerCase().replace(/\s+/g, '-')}.png`;
    const filepath = path.join(__dirname, '../public/icons/avatars', filename);
    fs.writeFileSync(filepath, buffer);

    console.log(`✓ Saved: ${filename}`);
    await sleep(1000); // Rate limiting
  } catch (error) {
    console.error(`✗ Error generating ${avatar.name}:`, error.message);
  }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Main execution
async function main() {
  console.log('🎨 Regenerating AVATARS with One Piece style...\n');

  for (let i = 0; i < avatars.length; i++) {
    await generateAvatar(avatars[i], i);
  }

  console.log('\n✨ All avatars regenerated successfully!');
  console.log(`📁 Avatars: ${avatars.length} images in public/icons/avatars/`);
}

main().catch(console.error);
