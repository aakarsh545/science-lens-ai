const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabase = createClient(
  process.env.VITE_SUPABASE_URL,
  process.env.VITE_SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function queryThemes() {
  const { data, error } = await supabase
    .from('shop_items')
    .select('name, rarity, thumbnail_url')
    .eq('type', 'theme')
    .order('name', { ascending: true });

  if (error) {
    console.error('Error:', error);
    process.exit(1);
  }

  // Sort by rarity order
  const rarityOrder = { common: 1, rare: 2, epic: 3, legendary: 4, mythical: 5 };
  const sorted = data.sort((a, b) => {
    const aOrder = rarityOrder[a.rarity] || 99;
    const bOrder = rarityOrder[b.rarity] || 99;
    if (aOrder !== bOrder) return aOrder - bOrder;
    return a.name.localeCompare(b.name);
  });

  console.log('THEME NAME'.padEnd(25) + ' | RARITY'.padEnd(12) + ' | THUMBNAIL URL');
  console.log('-'.repeat(100));

  sorted.forEach(theme => {
    const name = theme.name.padEnd(25);
    const rarity = theme.rarity.padEnd(12);
    const url = theme.thumbnail_url || '(blank)';
    console.log(`${name} | ${rarity} | ${url}`);
  });
}

queryThemes();
