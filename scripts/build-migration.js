import { themeData, avatarData, rarityLevels } from './shop-data.js';
import fs from 'fs';

let sql = `-- Expand shop from 70 items to 280+ items
-- Complete replacement with 140+ themes and 140+ avatars
-- 20+ items per rarity tier

-- First, delete all existing shop items
DELETE FROM shop_items WHERE type IN ('theme', 'avatar');

`;

// Generate themes for each rarity tier
for (const [rarity, themes] of Object.entries(themeData)) {
  const level = rarityLevels[rarity].level;

  sql += `-- ============================================================================
-- ${rarity.toUpperCase()} TIER (Level ${level}) - ${themes.length} Themes
-- ============================================================================

`;

  sql += `-- ${rarity.toUpperCase()} THEMES (${themes.length} items)
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
`;

  themes.forEach((theme, index) => {
    const metadata = JSON.stringify({
      primary: theme.colors[0],
      secondary: theme.colors[1],
      background: theme.colors[2],
      text: '#ffffff',
      accent: theme.colors[0],
    });

    const isPremium = theme.premium ? 'true' : 'false';
    const comma = index < themes.length - 1 ? ',' : '';

    sql += `(gen_random_uuid(), 'theme', '${theme.name}', '${theme.desc}', ${theme.price}, ${isPremium}, ${level}, '${rarity}', '${theme.icon}', '${metadata}'::jsonb)${comma}\n`;
  });

  sql += '\n';
}

// Generate avatars for each rarity tier
for (const [rarity, avatars] of Object.entries(avatarData)) {
  const level = rarityLevels[rarity].level;

  sql += `-- ============================================================================
-- ${rarity.toUpperCase()} TIER (Level ${level}) - ${avatars.length} Avatars
-- ============================================================================

`;

  sql += `-- ${rarity.toUpperCase()} AVATARS (${avatars.length} items)
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
`;

  avatars.forEach((avatar, index) => {
    const metadata = JSON.stringify({
      category: avatar.category,
      primary: '#3b82f6',
    });

    const isPremium = avatar.premium ? 'true' : 'false';
    const comma = index < avatars.length - 1 ? ',' : '';

    sql += `(gen_random_uuid(), 'avatar', '${avatar.name}', '${avatar.desc}', ${avatar.price}, ${isPremium}, ${level}, '${rarity}', '${avatar.icon}', '${metadata}'::jsonb)${comma}\n`;
  });

  sql += '\n';
}

// Write the SQL file
fs.writeFileSync('./../supabase/migrations/20251229010000_expand_shop_to_280_items.sql', sql);

console.log('✅ Migration file generated successfully!');
console.log(`📊 Total themes: ${Object.values(themeData).flat().length}`);
console.log(`📊 Total avatars: ${Object.values(avatarData).flat().length}`);
console.log(`📊 Total items: ${Object.values(themeData).flat().length + Object.values(avatarData).flat().length}`);
