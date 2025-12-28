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

// All themes with their colors and descriptions
const themes = [
  { name: 'Starter Blue', colors: ['#3b82f6', '#1e40af', '#0f172a'], description: 'beginner-friendly blue theme' },
  { name: 'Basic Green', colors: ['#22c55e', '#16a34a', '#14532d'], description: 'simple green color scheme' },
  { name: 'Simple Red', colors: ['#ef4444', '#dc2626', '#450a0a'], description: 'clean red accent theme' },
  { name: 'Plain Gray', colors: ['#6b7280', '#4b5563', '#1f2937'], description: 'minimalist gray theme' },
  { name: 'Basic Teal', colors: ['#14b8a6', '#0d9488', '#134e4a'], description: 'simple teal colors' },

  { name: 'Forest Deep', colors: ['#16a34a', '#15803d', '#052e16'], description: 'rich forest greens' },
  { name: 'Ocean Depths', colors: ['#0369a1', '#075985', '#082f49'], description: 'deep ocean blue' },
  { name: 'Sunset Orange', colors: ['#ea580c', '#c2410c', '#431407'], description: 'warm sunset colors' },
  { name: 'Lavender Fields', colors: ['#9333ea', '#7e22ce', '#3b0764'], description: 'calming purple theme' },
  { name: 'Mint Fresh', colors: ['#10b981', '#059669', '#064e3b'], description: 'cool mint colors' },

  { name: 'Midnight Galaxy', colors: ['#7c3aed', '#6d28d9', '#1e1b4b'], description: 'deep space purple' },
  { name: 'Volcanic Fire', colors: ['#dc2626', '#b91c1c', '#450a0a'], description: 'intense fire theme' },
  { name: 'Arctic Aurora', colors: ['#06b6d4', '#0891b2', '#164e63'], description: 'northern lights theme' },
  { name: 'Golden Hour', colors: ['#eab308', '#ca8a04', '#422006'], description: 'warm golden tones' },
  { name: 'Crystal Cave', colors: ['#a855f7', '#9333ea', '#2e1065'], description: 'geode crystal theme' },

  { name: 'Nebula Dreams', colors: ['#f472b6', '#ec4899', '#831843'], description: 'vibrant nebula theme' },
  { name: 'Solar Flare', colors: ['#fbbf24', '#f59e0b', '#451a03'], description: 'intense solar theme' },
  { name: 'Void Walker', colors: ['#1f2937', '#111827', '#000000'], description: 'dark void theme' },
  { name: 'Toxic Glow', colors: ['#84cc16', '#65a30d', '#365314'], description: 'radioactive green' },
  { name: 'Plasma Storm', colors: ['#f97316', '#ea580c', '#7c2d12'], description: 'high energy plasma' },

  { name: 'Dragon Fire', colors: ['#dc2626', '#991b1b', '#290505'], description: 'ancient dragon theme' },
  { name: 'Phoenix Rebirth', colors: ['#fb923c', '#f97316', '#431407'], description: 'rising from ashes' },
  { name: 'Timeless Space', colors: ['#8b5cf6', '#7c3aed', '#1e1b4b'], description: 'eternal cosmos' },
  { name: 'Elemental Chaos', colors: ['#ef4444', '#f97316', '#0f172a'], description: 'all elements combined' },
  { name: 'Cosmic Ascension', colors: ['#c084fc', '#a855f7', '#1e1b4b'], description: 'transcendent theme' },

  { name: 'Astral Plane', colors: ['#a855f7', '#9333ea', '#0f172a'], description: 'higher dimension' },
  { name: 'Dream Reality', colors: ['#f0abfc', '#e879f9', '#2e1065'], description: 'surreal dreamscape' },
  { name: 'Inferno Core', colors: ['#ef4444', '#dc2626', '#0a0a0a'], description: 'magma depths' },
  { name: 'Celestial Harmony', colors: ['#fbbf24', '#f472b6', '#0f172a'], description: 'cosmic balance' },
  { name: 'Divine Light', colors: ['#fef3c7', '#fde68a', '#1c1917'], description: 'radiant theme' },

  { name: 'Reality Bender', colors: ['#ff0000', '#ff7f00', '#000000'], description: 'bend reality itself' },
  { name: 'Omnipotent Dark', colors: ['#000000', '#000000', '#000000'], description: 'absolute dark' },
  { name: 'Universal Mind', colors: ['#ff6b6b', '#feca57', '#000000'], description: 'cosmic consciousness' },
  { name: 'Creator Essence', colors: ['#ffd700', '#ffed4e', '#0a0a0a'], description: 'creator theme' },
  { name: 'Absolute Infinity', colors: ['#ffffff', '#ffffff', '#000000'], description: 'infinite theme' }
];

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

// Helper function to create theme prompt
function createThemePrompt(theme) {
  const mainColor = theme.colors[0];
  const secondaryColor = theme.colors[1];

  return `A unique, original abstract wallpaper illustration for a theme called "${theme.name}".
Main colors: ${mainColor} and ${secondaryColor}.
Style: Modern, artistic, 2D flat design, science-inspired aesthetic.
Description: ${theme.description}.
Create a visually stunning background scene that represents this theme using the specified colors.
Make it simple yet elegant, suitable as a website background.
No text, no characters, just abstract art and scenery.
High quality, professional digital art.`;
}

// Helper function to create avatar prompt
function createAvatarPrompt(avatar) {
  return `A unique anime-style character portrait for "${avatar.name}".
Description: ${avatar.description}.
Category: ${avatar.category}, Power level: ${avatar.level}.
Style: Clean anime/manga art style, vibrant colors, professional digital illustration.
Create a distinctive character with unique features, expressions, and accessories that match their role.
Make them visually appealing and memorable.
Face and shoulders portrait, white background, high quality character art.`;
}

// Generate theme image
async function generateTheme(theme, index) {
  try {
    console.log(`Generating theme ${index + 1}/${themes.length}: ${theme.name}`);

    const prompt = createThemePrompt(theme);
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
    const filename = `theme-${theme.name.toLowerCase().replace(/\s+/g, '-')}.png`;
    const filepath = path.join(__dirname, '../public/icons/themes', filename);
    fs.writeFileSync(filepath, buffer);

    console.log(`✓ Saved: ${filename}`);
    await sleep(1000); // Rate limiting
  } catch (error) {
    console.error(`✗ Error generating ${theme.name}:`, error.message);
  }
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
  console.log('🎨 Starting AI image generation...\n');

  console.log('=== GENERATING THEMES ===');
  for (let i = 0; i < themes.length; i++) {
    await generateTheme(themes[i], i);
  }

  console.log('\n=== GENERATING AVATARS ===');
  for (let i = 0; i < avatars.length; i++) {
    await generateAvatar(avatars[i], i);
  }

  console.log('\n✨ All images generated successfully!');
  console.log(`📁 Themes: ${themes.length} images in public/icons/themes/`);
  console.log(`📁 Avatars: ${avatars.length} images in public/icons/avatars/`);
}

main().catch(console.error);
