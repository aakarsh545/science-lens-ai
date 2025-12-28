// Helper script to generate the complete shop migration SQL
const fs = require('fs');
const path = require('path');

// All 280 items data
const shopItems = [
  // COMMON (Level 1) - Already done
  // UNCOMMON (Level 5) - Already done

  // RARE (Level 10) - 20 Themes + 20 Avatars
  // Theme names
  { type: 'theme', name: 'Deep Ocean Kingdom', colors: ['#1e40af', '#1e3a8a', '#0f172a'], price: 200, level: 10, rarity: 'rare', icon: '🌊', desc: 'Underwater empire depths' },
  { type: 'theme', name: 'Solar Flare Haven', colors: ['#fbbf24', '#f59e0b', '#451a03'], price: 200, level: 10, rarity: 'rare', icon: '☀️', desc: 'Sun sanctuary realm' },
  { type: 'theme', name: 'Twilight Garden', colors: ['#a855f7', '#7c3aed', '#2e1065'], price: 200, level: 10, rarity: 'rare', icon: '🌆', desc: 'Dusk enchanted gardens' },
  { type: 'theme', name: 'Crystal Frost', colors: ['#67e8f9', '#0891b2', '#164e63'], price: 200, level: 10, rarity: 'rare', icon: '❄️', desc: 'Ice crystal paradise' },
  { type: 'theme', name: 'Volcanic Core', colors: ['#dc2626', '#b91c1c', '#450a0a'], price: 200, level: 10, rarity: 'rare', icon: '🌋', desc: 'Magma center depths' },
  { type: 'theme', name: 'Mystic Forest', colors: ['#166534', '#14532d', '#052e16'], price: 220, level: 10, rarity: 'rare', icon: '🌲', desc: 'Ancient enchanted woods' },
  { type: 'theme', name: 'Aurora Skies', colors: ['#06b6d4', '#8b5cf6', '#1e1b4b'], price: 220, level: 10, rarity: 'rare', icon: '🌌', desc: 'Northern lights heavens' },
  { type: 'theme', name: 'Desert Mirage', colors: ['#d97706', '#b45309', '#78350f'], price: 220, level: 10, rarity: 'rare', icon: '🏜️', desc: 'Sand illusion realm' },
  { type: 'theme', name: 'Thunder Valley', colors: ['#6366f1', '#4f46e5', '#312e81'], price: 220, level: 10, rarity: 'rare', icon: '⚡', desc: 'Storm canyon domain' },
  { type: 'theme', name: 'Coral Empire', colors: ['#f43f5e', '#e11d48', '#881337'], price: 220, level: 10, rarity: 'rare', icon: '🪸', desc: 'Reef kingdom depths' },
  { type: 'theme', name: 'Shadow Realm', colors: ['#475569', '#1e293b', '#0f172a'], price: 240, level: 10, rarity: 'rare', icon: '🌑', desc: 'Dark dimension void' },
  { type: 'theme', name: 'Golden Prairie', colors: ['#facc15', '#ca8a04', '#422006'], price: 240, level: 10, rarity: 'rare', icon: '🌾', desc: 'Wheat field expanse' },
  { type: 'theme', name: 'Glacier Peaks', colors: ['#bae6fd', '#0ea5e9', '#0c4a6e'], price: 240, level: 10, rarity: 'rare', icon: '🏔️', desc: 'Ice mountain range' },
  { type: 'theme', name: 'Plasma Fields', colors: ['#f97316', '#ea580c', '#7c2d12'], price: 240, level: 10, rarity: 'rare', icon: '💫', desc: 'Energy plasma lands' },
  { type: 'theme', name: 'Jade Sanctuary', colors: ['#10b981', '#059669', '#064e3b'], price: 240, level: 10, rarity: 'rare', icon: '🏯', desc: 'Sacred green temple' },
  { type: 'theme', name: 'Ruby Fortress', colors: ['#ef4444', '#dc2626', '#991b1b'], price: 250, level: 10, rarity: 'rare', icon: '🏰', desc: 'Red castle stronghold' },
  { type: 'theme', name: 'Sapphire Depths', colors: ['#3b82f6', '#2563eb', '#1e3a8a'], price: 250, level: 10, rarity: 'rare', icon: '💎', desc: 'Blue ocean trenches' },
  { type: 'theme', name: 'Amber Mines', colors: ['#f59e0b', '#d97706', '#78350f'], price: 250, level: 10, rarity: 'rare', icon: '⛏️', desc: 'Fossil treasure caves' },
  { type: 'theme', name: 'Emerald City', colors: ['#22c55e', '#16a34a', '#14532d'], price: 250, level: 10, rarity: 'rare', icon: '🏙️', desc: 'Green metropolis' },
  { type: 'theme', name: 'Diamond Peaks', colors: ['#e0f2fe', '#7dd3fc', '#0284c7'], price: 250, level: 10, rarity: 'rare', icon: '💠', desc: 'Crystal mountain spires' },

  // Avatar names for Rare
  { type: 'avatar', name: 'Quantum Zara', category: 'physics', price: 200, level: 10, rarity: 'rare', icon: '⚛️', desc: 'Quantum mechanics expert' },
  { type: 'avatar', name: 'Nova X-7', category: 'technology', price: 200, level: 10, rarity: 'rare', icon: '🤖', desc: 'Advanced AI scientist' },
  { type: 'avatar', name: 'Cyber Kai', category: 'technology', price: 200, level: 10, rarity: 'rare', icon: '💾', desc: 'Cybernetics researcher' },
  { type: 'avatar', name: 'Luna Stellar', category: 'space', price: 200, level: 10, rarity: 'rare', icon: '🌙', desc: 'Lunar colony director' },
  { type: 'avatar', name: 'Orion Flux', category: 'space', price: 200, level: 10, rarity: 'rare', icon: '🌟', desc: 'Stellar cartographer' },
  { type: 'avatar', name: 'Phoenix Ray', category: 'chemistry', price: 220, level: 10, rarity: 'rare', icon: '🔥', desc: 'Thermodynamics specialist' },
  { type: 'avatar', name: 'Ion Storm', category: 'physics', price: 220, level: 10, rarity: 'rare', icon: '⚡', desc: 'Particle accelerator expert' },
  { type: 'avatar', name: 'Neon Glow', category: 'physics', price: 220, level: 10, rarity: 'rare', icon: '💡', desc: 'Light physicist' },
  { type: 'avatar', name: 'Titan Forge', category: 'technology', price: 220, level: 10, rarity: 'rare', icon: '🔧', desc: 'Engineering mastermind' },
  { type: 'avatar', name: 'Atlas Core', category: 'earth', price: 220, level: 10, rarity: 'rare', icon: '🌍', desc: 'Geological surveyor' },
  { type: 'avatar', name: 'Zephyr Wind', category: 'earth', price: 240, level: 10, rarity: 'rare', icon: '🌬️', desc: 'Atmospheric dynamics' },
  { type: 'avatar', name: 'Crystal Joy', category: 'biology', price: 240, level: 10, rarity: 'rare', icon: '🔬', desc: 'Crystallography expert' },
  { type: 'avatar', name: 'Botanical Blaze', category: 'biology', price: 240, level: 10, rarity: 'rare', icon: '🌺', desc: 'Exotic botanist' },
  { type: 'avatar', name: 'Mars Vanguard', category: 'space', price: 240, level: 10, rarity: 'rare', icon: '🚀', desc: 'Mars mission leader' },
  { type: 'avatar', name: 'Comet Chase', category: 'space', price: 240, level: 10, rarity: 'rare', icon: '☄️', desc: 'Comet tracker' },
  { type: 'avatar', name: 'Solar Flare', category: 'physics', price: 250, level: 10, rarity: 'rare', icon: '🌞', desc: 'Solar physicist' },
  { type: 'avatar', 'name': 'Lunar Tide', category: 'space', price: 250, level: 10, rarity: 'rare', icon: '🌊', desc: 'Tidal researcher' },
  { type: 'avatar', 'name': 'Quantum Leap', category: 'physics', price: 250, level: 10, rarity: 'rare', icon: '🔄', desc: 'Quantum computing' },
  { type: 'avatar', 'name': 'Bio Spark', category: 'biology', price: 250, level: 10, rarity: 'rare', icon: '⚗️', desc: 'Biochemistry genius' },
  { type: 'avatar', 'name': 'Tech Nova', category: 'technology', price: 250, level: 10, rarity: 'rare', icon: '🖥️', desc: 'Systems architect' },
];

// Function to generate SQL INSERT statements
function generateSQL() {
  let sql = '';

  shopItems.forEach(item => {
    const metadata = item.type === 'theme'
      ? `{"primary": "${item.colors[0]}", "secondary": "${item.colors[1]}", "background": "${item.colors[2]}", "text": "#ffffff", "accent": "${item.colors[0]}"}`
      : `{"category": "${item.category}", "primary": "${item.colors[0] || "#3b82f6"}"}`;

    sql += `(gen_random_uuid(), '${item.type}', '${item.name}', '${item.desc}', ${item.price}, false, ${item.level}, '${item.rarity}', '${item.icon}', '${metadata}'::jsonb),\n`;
  });

  return sql;
}

console.log(generateSQL());
