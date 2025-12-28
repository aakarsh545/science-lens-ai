import 'dotenv/config';
import { themeData, avatarData } from './shop-data.js';
import OpenAI from 'openai';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

// Helper function to create theme prompt
function createThemePrompt(theme, rarity) {
  const mainColor = theme.colors[0];
  const secondaryColor = theme.colors[1];

  return `A unique, original abstract wallpaper illustration for a theme called "${theme.name}".
Main colors: ${mainColor} and ${secondaryColor}.
Style: Vibrant cartoony art with anime-inspired aesthetics, bold colors, clean lines.
Description: ${theme.desc}.
Rarity: ${rarity}.
Create a visually stunning background scene that represents this theme using the specified colors.
Make it simple yet elegant, suitable as a website background.
No text, no characters, just abstract art and scenery.
High quality, cartoony digital art with chibi-inspired elements.`;
}

// Helper function to create avatar prompt
function createAvatarPrompt(avatar, rarity) {
  return `A SINGLE chibi-cute anime character portrait for "${avatar.name}".

CRITICAL: SHOW EXACTLY ONE CHARACTER - NO MULTIPLE CHARACTERS, NO GROUPS, NO BACKGROUND CHARACTERS.

Character: ${avatar.desc}
Role: ${avatar.category}, Power level: ${rarity}

Style: Chibi-cute anime style with cartoony elements.
- Large expressive eyes, small body, big head (chibi proportions)
- Bold outlines, vibrant saturated colors
- Cute, adorable, energetic expressions
- Think: mix of One Piece expressiveness + chibi super-deformed cuteness
- Dynamic pose, distinctive accessories matching their role

Focus on face and upper body.
White or simple solid background.
High quality cartoony chibi anime character art.

REMEMBER: ONLY ONE CHARACTER IN THE ENTIRE IMAGE!`;
}

// Generate theme image
async function generateTheme(theme, rarity, index, total) {
  try {
    console.log(`[${index + 1}/${total}] Generating theme: ${theme.name} (${rarity})`);

    const prompt = createThemePrompt(theme, rarity);
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
async function generateAvatar(avatar, rarity, index, total) {
  try {
    console.log(`[${index + 1}/${total}] Generating avatar: ${avatar.name} (${rarity})`);

    const prompt = createAvatarPrompt(avatar, rarity);
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
  console.log('🎨 Starting AI image generation for 280 items...\n');

  // Flatten all themes and avatars
  const allThemes = [];
  const allAvatars = [];

  for (const [rarity, themes] of Object.entries(themeData)) {
    themes.forEach(theme => {
      allThemes.push({ ...theme, rarity });
    });
  }

  for (const [rarity, avatars] of Object.entries(avatarData)) {
    avatars.forEach(avatar => {
      allAvatars.push({ ...avatar, rarity });
    });
  }

  console.log(`📊 Total themes to generate: ${allThemes.length}`);
  console.log(`📊 Total avatars to generate: ${allAvatars.length}`);
  console.log(`💰 Estimated cost: ~$${((allThemes.length + allAvatars.length) * 0.04).toFixed(2)}`);
  console.log(`⏱️  Estimated time: ~${Math.ceil((allThemes.length + allAvatars.length) / 6)} minutes\n`);

  console.log('=== GENERATING THEMES ===');
  for (let i = 0; i < allThemes.length; i++) {
    await generateTheme(allThemes[i], allThemes[i].rarity, i, allThemes.length);
  }

  console.log('\n=== GENERATING AVATARS ===');
  for (let i = 0; i < allAvatars.length; i++) {
    await generateAvatar(allAvatars[i], allAvatars[i].rarity, i, allAvatars.length);
  }

  console.log('\n✨ All images generated successfully!');
  console.log(`📁 Themes: ${allThemes.length} images in public/icons/themes/`);
  console.log(`📁 Avatars: ${allAvatars.length} images in public/icons/avatars/`);
}

main().catch(console.error);
