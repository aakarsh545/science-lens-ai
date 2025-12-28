-- Shop expansion with generated images
-- Using actual generated images: 37 themes + 19 avatars = 56 items
-- Distributed evenly across 7 rarity tiers

-- First, delete all existing shop items
DELETE FROM shop_items WHERE type IN ('theme', 'avatar');

-- ============================================================================
-- DISTRIBUTION: ~5-6 themes + ~2-3 avatars per rarity tier
-- ============================================================================

-- COMMON TIER (Level 1) - 5 themes + 3 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Azure Mist', 'Soft blue fog rolling through calm landscapes', 0, false, 1, 'common', '🌫️', '{"primary": "#3b82f6", "secondary": "#1e40af", "background": "#f0f9ff", "text": "#1e3a8a", "accent": "#60a5fa"}'::jsonb),
(gen_random_uuid(), 'theme', 'Calm Waters', 'Peaceful blue ocean on a still morning', 25, false, 1, 'common', '🌊', '{"primary": "#0ea5e9", "secondary": "#0284c7", "background": "#f0fdfa", "text": "#164e63", "accent": "#38bdf8"}'::jsonb),
(gen_random_uuid(), 'theme', 'Simple Slate', 'Clean gray minimal design', 25, false, 1, 'common', '🪨', '{"primary": "#64748b", "secondary": "#475569", "background": "#f8fafc", "text": "#1e293b", "accent": "#94a3b8"}'::jsonb),
(gen_random_uuid(), 'theme', 'Mint Breeze', 'Fresh green wind across open fields', 25, false, 1, 'common', '🌿', '{"primary": "#10b981", "secondary": "#059669", "background": "#f0fdf4", "text": "#14532d", "accent": "#34d399"}'::jsonb),
(gen_random_uuid(), 'theme', 'Sky Blue', 'Clear day atmosphere', 25, false, 1, 'common', '☁️', '{"primary": "#7dd3fc", "secondary": "#0ea5e9", "background": "#f0f9ff", "text": "#0c4a6e", "accent": "#bae6fd"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Jett Riley', 'Curious young explorer', 0, false, 1, 'common', '🔭', '{"category": "discovery", "primary": "#0ea5e9"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Cobalt Blue', 'Steady lab partner', 25, false, 1, 'common', '🔵', '{"category": "chemistry", "primary": "#3b82f6"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Aria Byte', 'Tech-savvy coder', 25, false, 1, 'common', '💻', '{"category": "technology", "primary": "#06b6d4"}'::jsonb);

-- UNCOMMON TIER (Level 5) - 5 themes + 3 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Emerald Forest', 'Deep green woodland sanctuary', 75, false, 5, 'uncommon', '🌲', '{"primary": "#10b981", "secondary": "#059669", "background": "#064e3b", "text": "#ecfdf5", "accent": "#34d399"}'::jsonb),
(gen_random_uuid(), 'theme', 'Sunrise Glow', 'Golden morning light breaking', 75, false, 5, 'uncommon', '🌅', '{"primary": "#fbbf24", "secondary": "#f59e0b", "background": "#fef3c7", "text": "#78350f", "accent": "#fcd34d"}'::jsonb),
(gen_random_uuid(), 'theme', 'Copper Dreams', 'Warm metallic orange elegance', 75, false, 5, 'uncommon', '🧡', '{"primary": "#ea580c", "secondary": "#c2410c", "background": "#fff7ed", "text": "#7c2d12", "accent": "#fb923c"}'::jsonb),
(gen_random_uuid(), 'theme', 'Forest Floor', 'Mossy earth tones', 75, false, 5, 'uncommon', '🌲', '{"primary": "#65a30d", "secondary": "#4d7c0f", "background": "#f7fee7", "text": "#365314", "accent": "#84cc16"}'::jsonb),
(gen_random_uuid(), 'theme', 'Lavender Fields', 'Purple flowers swaying gently', 75, false, 5, 'uncommon', '💜', '{"primary": "#a78bfa", "secondary": "#8b5cf6", "background": "#faf5ff", "text": "#4c1d95", "accent": "#c4b5fd"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Zara Prime', 'Enthusiastic astronomy fan', 75, false, 5, 'uncommon', '🌟', '{"category": "space", "primary": "#6366f1"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Max Flux', 'Dynamic chemistry learner', 75, false, 5, 'uncommon', '⚗️', '{"category": "chemistry", "primary": "#f59e0b"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Piper Glow', 'Bright biology student', 75, false, 5, 'uncommon', '🧬', '{"category": "biology", "primary": "#22c55e"}'::jsonb);

-- RARE TIER (Level 10) - 6 themes + 3 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Arctic Frost', 'Crisp blue ice crystals', 200, false, 10, 'rare', '❄️', '{"primary": "#67e8f9", "secondary": "#06b6d4", "background": "#ecfeff", "text": "#164e63", "accent": "#a5f3fc"}'::jsonb),
(gen_random_uuid(), 'theme', 'Jade Jungle', 'Lush tropical paradise', 200, false, 10, 'rare', '🌴', '{"primary": "#059669", "secondary": "#047857", "background": "#f0fdf4", "text": "#14532d", "accent": "#10b981"}'::jsonb),
(gen_random_uuid(), 'theme', 'Volcanic Core', 'Magma center depths', 200, false, 10, 'rare', '🌋', '{"primary": "#dc2626", "secondary": "#b91c1c", "background": "#450a0a", "text": "#fef2f2", "accent": "#f87171"}'::jsonb),
(gen_random_uuid(), 'theme', 'Plasma Fields', 'Energy plasma lands', 200, false, 10, 'rare', '💫', '{"primary": "#f97316", "secondary": "#ea580c", "background": "#7c2d12", "text": "#fff7ed", "accent": "#fb923c"}'::jsonb),
(gen_random_uuid(), 'theme', 'Crystal Clear', 'Transparent beauty', 200, false, 10, 'rare', '💎', '{"primary": "#e0f2fe", "secondary": "#bae6fd", "background": "#f0f9ff", "text": "#0c4a6e", "accent": "#7dd3fc"}'::jsonb),
(gen_random_uuid(), 'theme', 'Twilight Blue', 'Evening sky gradient', 200, false, 10, 'rare', '🌆', '{"primary": "#818cf8", "secondary": "#6366f1", "background": "#eef2ff", "text": "#312e81", "accent": "#a5b4fc"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Cyber Kai', 'Cybernetics researcher', 200, false, 10, 'rare', '💾', '{"category": "technology", "primary": "#8b5cf6"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Neon Glow', 'Light physicist', 200, false, 10, 'rare', '💡', '{"category": "physics", "primary": "#fbbf24"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Echo Vector', 'Sound wave researcher', 200, false, 10, 'rare', '🔊', '{"category": "physics", "primary": "#ec4899"}'::jsonb);

-- EPIC TIER (Level 20) - 5 themes + 3 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Shadow Citadel', 'Dark fortress stronghold', 350, false, 20, 'epic', '🏴', '{"primary": "#1f2937", "secondary": "#111827", "background": "#000000", "text": "#f3f4f6", "accent": "#6b7280"}'::jsonb),
(gen_random_uuid(), 'theme', 'Solar Sanctum', 'Sun power temple', 350, false, 20, 'epic', '🌞', '{"primary": "#fbbf24", "secondary": "#f59e0b", "background": "#451a03", "text": "#fef3c7", "accent": "#fde047"}'::jsonb),
(gen_random_uuid(), 'theme', 'Mystic Grove', 'Enchanted nature realm', 350, false, 20, 'epic', '🌿', '{"primary": "#a855f7", "secondary": "#7c3aed", "background": "#2e1065", "text": "#faf5ff", "accent": "#c4b5fd"}'::jsonb),
(gen_random_uuid(), 'theme', 'Cosmic Serpent', 'Space dragon realm', 350, false, 20, 'epic', '🐍', '{"primary": "#c084fc", "secondary": "#a855f7", "background": "#1e1b4b", "text": "#f3e8ff", "accent": "#d8b4fe"}'::jsonb),
(gen_random_uuid(), 'theme', 'Divine Light Sanctuary', 'Holy ground', 350, false, 20, 'epic', '☀️', '{"primary": "#fef3c7", "secondary": "#fde68a", "background": "#1c1917", "text": "#ffffff", "accent": "#fcd34d"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Nebula Stormborn', 'Cosmic energy being', 350, false, 20, 'epic', '🌌', '{"category": "space", "primary": "#7c3aed"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Cosmic Mind', 'Universal consciousness', 350, false, 20, 'epic', '🧠', '{"category": "space", "primary": "#c084fc"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Quantum Leap', 'Quantum computing', 350, false, 20, 'epic', '🔄', '{"category": "physics", "primary": "#a855f7"}'::jsonb);

-- LEGENDARY TIER (Level 40) - 5 themes + 2 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Thunder God Arena', 'Lightning ruler battlefield', 600, false, 40, 'legendary', '⚡', '{"primary": "#818cf8", "secondary": "#6366f1", "background": "#1e3a8a", "text": "#eef2ff", "accent": "#93c5fd"}'::jsonb),
(gen_random_uuid(), 'theme', 'Glacier Titan Palace', 'Ice giant stronghold', 600, false, 40, 'legendary', '🏔️', '{"primary": "#67e8f9", "secondary": "#06b6d4", "background": "#164e63", "text": "#ecfeff", "accent": "#a5f3fc"}'::jsonb),
(gen_random_uuid(), 'theme', 'Autumn Leaf', 'Orange brown warmth', 600, false, 40, 'legendary', '🍂', '{"primary": "#fb923c", "secondary": "#ea580c", "background": "#fff7ed", "text": "#7c2d12", "accent": "#fdba74"}'::jsonb),
(gen_random_uuid(), 'theme', 'Coral Reef', 'Tropical underwater colors', 600, false, 40, 'legendary', '🪸', '{"primary": "#fb7185", "secondary": "#f43f5e", "background": "#fff1f2", "text": "#881337", "accent": "#fda4af"}'::jsonb),
(gen_random_uuid(), 'theme', 'River Stone', 'Smooth gray-blue rocks', 600, false, 40, 'legendary', '🪨', '{"primary": "#94a3b8", "secondary": "#64748b", "background": "#f8fafc", "text": "#1e293b", "accent": "#cbd5e1"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Eternal Void', 'Nothingness guardian', 600, false, 40, 'legendary', '🕳️', '{"category": "divine", "primary": "#1f2937"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Supreme Flame', 'Ultimate fire master', 600, false, 40, 'legendary', '🔥', '{"category": "divine", "primary": "#dc2626"}'::jsonb);

-- MYTHICAL TIER (Level 60) - 6 themes + 3 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Timeless Space Continuum', 'Eternal cosmos flow', 1200, false, 60, 'mythical', '⏰', '{"primary": "#8b5cf6", "secondary": "#7c3aed", "background": "#1e1b4b", "text": "#f5f3ff", "accent": "#a78bfa"}'::jsonb),
(gen_random_uuid(), 'theme', 'Divine Prism Palace', 'Holy rainbow fortress', 1200, false, 60, 'mythical', '💎', '{"primary": "#fbbf24", "secondary": "#f472b6", "background": "#1e1b4b", "text": "#fef3c7", "accent": "#fcd34d"}'::jsonb),
(gen_random_uuid(), 'theme', 'Starlight', 'Subtle silver glow', 1200, false, 60, 'mythical', '✨', '{"primary": "#e2e8f0", "secondary": "#cbd5e1", "background": "#f8fafc", "text": "#1e293b", "accent": "#f1f5f9"}'::jsonb),
(gen_random_uuid(), 'theme', 'Rose Garden', 'Soft pink floral beauty', 1200, false, 60, 'mythical', '🌹', '{"primary": "#f9a8d4", "secondary": "#ec4899", "background": "#fdf2f8", "text": "#831843", "accent": "#fbcfe8"}'::jsonb),
(gen_random_uuid(), 'theme', 'Ocean Spray', 'Light teal sea foam', 1200, false, 60, 'mythical', '💧', '{"primary": "#2dd4bf", "secondary": "#14b8a6", "background": "#f0fdfa", "text": "#134e4a", "accent": "#5eead4"}'::jsonb),
(gen_random_uuid(), 'theme', 'Sunny Meadow', 'Bright yellow happiness', 1200, false, 60, 'mythical', '🌻', '{"primary": "#facc15", "secondary": "#eab308", "background": "#fefce8", "text": "#713f12", "accent": "#fde047"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Eternal Stellar', 'Timeless star dweller', 1200, false, 60, 'mythical', '⭐', '{"category": "divine", "primary": "#fbbf24"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Eternal Phoenix', 'Immortal fire spirit', 1200, false, 60, 'mythical', '🔥', '{"category": "divine", "primary": "#fb923c"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Alpha Zenith', 'Peak knowledge holder', 1200, false, 60, 'mythical', '🔝', '{"category": "divine", "primary": "#fbbf24"}'::jsonb);

-- GODLY TIER (Level 100) - 5 themes + 2 avatars
INSERT INTO shop_items (id, type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
(gen_random_uuid(), 'theme', 'Omega Finality', 'Last ending moment', 2000, true, 100, 'godly', '💀', '{"primary": "#000000", "secondary": "#1f2937", "background": "#000000", "text": "#ffffff", "accent": "#6b7280"}'::jsonb),
(gen_random_uuid(), 'theme', 'Peach Fuzz', 'Warm orange and pink tones', 2000, true, 100, 'godly', '🍑', '{"primary": "#fb923c", "secondary": "#f97316", "background": "#fff7ed", "text": "#7c2d12", "accent": "#fdba74"}'::jsonb),
(gen_random_uuid(), 'theme', 'Leafy Green', 'Fresh nature vibes', 2000, true, 100, 'godly', '🍃', '{"primary": "#4ade80", "secondary": "#22c55e", "background": "#f0fdf4", "text": "#14532d", "accent": "#86efac"}'::jsonb),
(gen_random_uuid(), 'theme', 'Cloud White', 'Pure soft minimalism', 2000, true, 100, 'godly', '☁️', '{"primary": "#f1f5f9", "secondary": "#e2e8f0", "background": "#ffffff", "text": "#475569", "accent": "#cbd5e1"}'::jsonb),
(gen_random_uuid(), 'theme', 'Berry Blast', 'Mixed fruit red tones', 2000, true, 100, 'godly', '🍓', '{"primary": "#f87171", "secondary": "#ef4444", "background": "#fef2f2", "text": "#991b1b", "accent": "#fca5a5"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Lunar Tide', 'Tidal researcher', 2000, true, 100, 'godly', '🌊', '{"category": "space", "primary": "#7dd3fc"}'::jsonb),
(gen_random_uuid(), 'avatar', 'Astra Neo', 'Star mapping enthusiast', 2000, true, 100, 'godly', '⭐', '{"category": "space", "primary": "#fbbf24"}'::jsonb);
