-- Complete Shop Overhaul with Rarity System
-- Each rarity has 5 avatars + 5 themes with progressive requirements

-- First, clear existing shop items
TRUNCATE TABLE public.user_inventory CASCADE;
TRUNCATE TABLE public.shop_items CASCADE;

-- Add level requirement column to shop_items
ALTER TABLE public.shop_items
  ADD COLUMN IF NOT EXISTS level_required INTEGER DEFAULT 1,
  ADD COLUMN IF NOT EXISTS rarity TEXT NOT NULL DEFAULT 'common';

-- Create index for rarity filtering
CREATE INDEX IF NOT EXISTS idx_shop_items_rarity ON public.shop_items(rarity);
CREATE INDEX IF NOT EXISTS idx_shop_items_level ON public.shop_items(level_required);

-- ============================================
-- COMMON (Level 1, Free/Cheap) - 1 Free, Rest 10-50 coins
-- ============================================

-- COMMON THEMES
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, metadata) VALUES
-- 1 Free Theme
('theme', 'Starter Blue', 'Beginner-friendly blue theme', 0, false, 1, 'common',
 '{"primary": "#3b82f6", "secondary": "#1e40af", "background": "#0f172a", "text": "#f1f5f9", "accent": "#60a5fa"}'::jsonb),

-- 4 Paid Common Themes
('theme', 'Basic Green', 'Simple green color scheme', 10, false, 1, 'common',
 '{"primary": "#22c55e", "secondary": "#16a34a", "background": "#14532d", "text": "#f0fdf4", "accent": "#4ade80"}'::jsonb),
('theme', 'Simple Red', 'Clean red accent theme', 20, false, 1, 'common',
 '{"primary": "#ef4444", "secondary": "#dc2626", "background": "#450a0a", "text": "#fef2f2", "accent": "#f87171"}'::jsonb),
('theme', 'Plain Gray', 'Minimalist gray theme', 30, false, 1, 'common',
 '{"primary": "#6b7280", "secondary": "#4b5563", "background": "#1f2937", "text": "#f9fafb", "accent": "#9ca3af"}'::jsonb),
('theme', 'Basic Teal', 'Simple teal colors', 50, false, 1, 'common',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "background": "#134e4a", "text": "#f0fdfa", "accent": "#2dd4bf"}'::jsonb);

-- COMMON AVATARS
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- 1 Free Avatar
('avatar', 'Novice Scientist', 'Starting science avatar', 0, false, 1, 'common', '🔬',
 '{"rarity": "common", "category": "science", "level": "novice"}'::jsonb),

-- 4 Paid Common Avatars
('avatar', 'Lab Assistant', 'Entry-level researcher', 10, false, 1, 'common', '🧪',
 '{"rarity": "common", "category": "chemistry", "level": "beginner"}'::jsonb),
('avatar', 'Book Worm', 'Avid learner avatar', 20, false, 1, 'common', '📚',
 '{"rarity": "common", "category": "study", "level": "starter"}'::jsonb),
('avatar', 'Magnifier', 'Curious explorer', 30, false, 1, 'common', '🔍',
 '{"rarity": "common", "category": "discovery", "level": "basic"}'::jsonb),
('avatar', 'Note Taker', 'Diligent student', 50, false, 1, 'common', '📝',
 '{"rarity": "common", "category": "study", "level": "learner"}'::jsonb);

-- ============================================
-- UNCOMMON (Level 5, 50-100 coins) - All paid
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- UNCOMMON THEMES
('theme', 'Forest Deep', 'Rich forest greens', 50, false, 5, 'uncommon', null,
 '{"primary": "#16a34a", "secondary": "#15803d", "background": "#052e16", "text": "#f0fdf4", "accent": "#22c55e"}'::jsonb),
('theme', 'Ocean Depths', 'Deep ocean blue', 60, false, 5, 'uncommon', null,
 '{"primary": "#0369a1", "secondary": "#075985", "background": "#082f49", "text": "#f0f9ff", "accent": "#0ea5e9"}'::jsonb),
('theme', 'Sunset Orange', 'Warm sunset colors', 70, false, 5, 'uncommon', null,
 '{"primary": "#ea580c", "secondary": "#c2410c", "background": "#431407", "text": "#fff7ed", "accent": "#f97316"}'::jsonb),
('theme', 'Lavender Fields', 'Calming purple theme', 80, false, 5, 'uncommon', null,
 '{"primary": "#9333ea", "secondary": "#7e22ce", "background": "#3b0764", "text": "#faf5ff", "accent": "#a855f7"}'::jsonb),
('theme', 'Mint Fresh', 'Cool mint colors', 100, false, 5, 'uncommon', null,
 '{"primary": "#10b981", "secondary": "#059669", "background": "#064e3b", "text": "#ecfdf5", "accent": "#34d399"}'::jsonb),

-- UNCOMMON AVATARS
('avatar', 'Researcher', 'Dedicated scientist', 50, false, 5, 'uncommon', '👨‍🔬',
 '{"rarity": "uncommon", "category": "science", "level": "junior"}'::jsonb),
('avatar', 'Astronomer', 'Star gazer', 60, false, 5, 'uncommon', '🌟',
 '{"rarity": "uncommon", "category": "space", "level": "enthusiast"}'::jsonb),
('avatar', 'Biologist', 'Life scientist', 70, false, 5, 'uncommon', '🧬',
 '{"rarity": "uncommon", "category": "biology", "level": "student"}'::jsonb),
('avatar', 'Geologist', 'Earth explorer', 80, false, 5, 'uncommon', '🪨',
 '{"rarity": "uncommon", "category": "earth", "level": "rookie"}'::jsonb),
('avatar', 'Chemistry Pro', 'Chemistry expert', 100, false, 5, 'uncommon', '⚗️',
 '{"rarity": "uncommon", "category": "chemistry", "level": "skilled"}'::jsonb);

-- ============================================
-- RARE (Level 10, 100-250 coins)
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- RARE THEMES
('theme', 'Midnight Galaxy', 'Deep space purple', 100, false, 10, 'rare', null,
 '{"primary": "#7c3aed", "secondary": "#6d28d9", "background": "#1e1b4b", "text": "#f5f3ff", "accent": "#8b5cf6"}'::jsonb),
('theme', 'Volcanic Fire', 'Intense fire theme', 125, false, 10, 'rare', null,
 '{"primary": "#dc2626", "secondary": "#b91c1c", "background": "#450a0a", "text": "#fef2f2", "accent": "#ef4444"}'::jsonb),
('theme', 'Arctic Aurora', 'Northern lights theme', 150, false, 10, 'rare', null,
 '{"primary": "#06b6d4", "secondary": "#0891b2", "background": "#164e63", "text": "#ecfeff", "accent": "#22d3ee"}'::jsonb),
('theme', 'Golden Hour', 'Warm golden tones', 175, false, 10, 'rare', null,
 '{"primary": "#eab308", "secondary": "#ca8a04", "background": "#422006", "text": "#fefce8", "accent": "#facc15"}'::jsonb),
('theme', 'Crystal Cave', 'Geode crystal theme', 250, false, 10, 'rare', null,
 '{"primary": "#a855f7", "secondary": "#9333ea", "background": "#2e1065", "text": "#faf5ff", "accent": "#c084fc"}'::jsonb),

-- RARE AVATARS
('avatar', 'Professor', 'Academic expert', 100, false, 10, 'rare', '🎓',
 '{"rarity": "rare", "category": "academia", "level": "professor"}'::jsonb),
('avatar', 'Rocket Pilot', 'Space pilot', 125, false, 10, 'rare', '🚀',
 '{"rarity": "rare", "category": "space", "level": "pilot"}'::jsonb),
('avatar', 'Quantum Scholar', 'Quantum enthusiast', 150, false, 10, 'rare', '⚛️',
 '{"rarity": "rare", "category": "physics", "level": "scholar"}'::jsonb),
('avatar', 'Geneticist', 'DNA expert', 175, false, 10, 'rare', '🧬',
 '{"rarity": "rare", "category": "biology", "level": "expert"}'::jsonb),
('avatar', 'Particle Physicist', 'Particle science', 250, false, 10, 'rare', '🔮',
 '{"rarity": "rare", "category": "physics", "level": "researcher"}'::jsonb);

-- ============================================
-- EPIC (Level 20, 250-500 coins)
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- EPIC THEMES
('theme', 'Nebula Dreams', 'Vibrant nebula theme', 250, false, 20, 'epic', null,
 '{"primary": "#f472b6", "secondary": "#ec4899", "background": "#831843", "text": "#fdf2f8", "accent": "#f472b6"}'::jsonb),
('theme', 'Solar Flare', 'Intense solar theme', 300, false, 20, 'epic', null,
 '{"primary": "#fbbf24", "secondary": "#f59e0b", "background": "#451a03", "text": "#fef3c7", "accent": "#fcd34d"}'::jsonb),
('theme', 'Void Walker', 'Dark void theme', 350, false, 20, 'epic', null,
 '{"primary": "#1f2937", "secondary": "#111827", "background": "#000000", "text": "#f9fafb", "accent": "#374151"}'::jsonb),
('theme', 'Toxic Glow', 'Radioactive green', 400, false, 20, 'epic', null,
 '{"primary": "#84cc16", "secondary": "#65a30d", "background": "#365314", "text": "#f7fee7", "accent": "#a3e635"}'::jsonb),
('theme', 'Plasma Storm', 'High energy plasma', 500, false, 20, 'epic', null,
 '{"primary": "#f97316", "secondary": "#ea580c", "background": "#7c2d12", "text": "#fff7ed", "accent": "#fb923c", "gradientColors": ["#f97316", "#eab308", "#ef4444"]}'::jsonb),

-- EPIC AVATARS
('avatar', 'Nobel Winner', 'Prestige scientist', 250, false, 20, 'epic', '🏆',
 '{"rarity": "epic", "category": "prestige", "level": "winner"}'::jsonb),
('avatar', 'Time Traveler', 'Temporal explorer', 300, false, 20, 'epic', '⏰',
 '{"rarity": "epic", "category": "physics", "level": "master"}'::jsonb),
('avatar', 'Dimensional', 'Multi-dimensional', 350, false, 20, 'epic', '🌀',
 '{"rarity": "epic", "category": "physics", "level": "theorist"}'::jsonb),
('avatar', 'Alien Life', 'Exobiologist', 400, false, 20, 'epic', '👽',
 '{"rarity": "epic", "category": "biology", "level": "specialist"}'::jsonb),
('avatar', 'Cyborg Mind', 'Enhanced intellect', 500, false, 20, 'epic', '🤖',
 '{"rarity": "epic", "category": "technology", "level": "enhanced"}'::jsonb);

-- ============================================
-- LEGENDARY (Level 40, 500-1000 coins)
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- LEGENDARY THEMES
('theme', 'Dragon Fire', 'Ancient dragon theme', 500, false, 40, 'legendary', null,
 '{"primary": "#dc2626", "secondary": "#991b1b", "background": "#290505", "text": "#fef2f2", "accent": "#f87171", "gradientColors": ["#dc2626", "#ea580c", "#f59e0b"]}'::jsonb),
('theme', 'Phoenix Rebirth', 'Rising from ashes', 600, false, 40, 'legendary', null,
 '{"primary": "#fb923c", "secondary": "#f97316", "background": "#431407", "text": "#fff7ed", "accent": "#fbbf24", "gradientColors": ["#fbbf24", "#f97316", "#dc2626"]}'::jsonb),
('theme', 'Timeless Space', 'Eternal cosmos', 700, false, 40, 'legendary', null,
 '{"primary": "#8b5cf6", "secondary": "#7c3aed", "background": "#1e1b4b", "text": "#f5f3ff", "accent": "#a78bfa", "gradientColors": ["#8b5cf6", "#6366f1", "#3b82f6"]}'::jsonb),
('theme', 'Elemental Chaos', 'All elements combined', 850, false, 40, 'legendary', null,
 '{"primary": "gradient", "secondary": "gradient", "background": "#0f172a", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#ef4444", "#f97316", "#eab308", "#22c55e", "#3b82f6", "#8b5cf6"]}'::jsonb),
('theme', 'Cosmic Ascension', 'Transcendent theme', 1000, false, 40, 'legendary', null,
 '{"primary": "#c084fc", "secondary": "#a855f7", "background": "#1e1b4b", "text": "#faf5ff", "accent": "#e9d5ff", "gradientColors": ["#c084fc", "#8b5cf6", "#6366f1", "#3b82f6"]}'::jsonb),

-- LEGENDARY AVATARS
('avatar', 'Dragon Master', 'Legendary dragon tamer', 500, false, 40, 'legendary', '🐉',
 '{"rarity": "legendary", "category": "mythical", "level": "master"}'::jsonb),
('avatar', 'Phoenix Rising', 'Reborn from flames', 600, false, 40, 'legendary', '🔥',
 '{"rarity": "legendary", "category": "fire", "level": "legend"}'::jsonb),
('avatar', 'Time Lord', 'Master of time', 700, false, 40, 'legendary', '⌛',
 '{"rarity": "legendary", "category": "physics", "level": "controller"}'::jsonb),
('avatar', 'God of Science', 'Deity of knowledge', 850, false, 40, 'legendary', '👑',
 '{"rarity": "legendary", "category": "prestige", "level": "deity"}'::jsonb),
('avatar', 'Universe Creator', 'Cosmic architect', 1000, false, 40, 'legendary', '🌌',
 '{"rarity": "legendary", "category": "cosmos", "level": "creator"}'::jsonb);

-- ============================================
-- MYTHICAL (Level 60, 1000-2000 coins) - 50% Premium
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- MYTHICAL THEMES (3 free, 2 premium)
('theme', 'Astral Plane', 'Higher dimension', 1000, false, 60, 'mythical', null,
 '{"primary": "#a855f7", "secondary": "#9333ea", "background": "#0f172a", "text": "#faf5ff", "accent": "#d8b4fe", "gradientColors": ["#a855f7", "#6366f1", "#8b5cf6", "#d8b4fe"]}'::jsonb),
('theme', 'Dream Reality', 'Surreal dreamscape', 1200, false, 60, 'mythical', null,
 '{"primary": "#f0abfc", "secondary": "#e879f9", "background": "#2e1065", "text": "#fdf4ff", "accent": "#f5d0fe", "gradientColors": ["#f0abfc", "#d946ef", "#a855f7", "#8b5cf6"]}'::jsonb),
('theme', 'Inferno Core', 'Magma depths', 1500, false, 60, 'mythical', null,
 '{"primary": "#ef4444", "secondary": "#dc2626", "background": "#0a0a0a", "text": "#fef2f2", "accent": "#fca5a5", "gradientColors": ["#fbbf24", "#f97316", "#ef4444", "#dc2626"]}'::jsonb),
('theme', 'Celestial Harmony', 'Premium cosmic balance', 1750, true, 60, 'mythical', null,
 '{"primary": "gradient", "secondary": "gradient", "background": "#0f172a", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#fbbf24", "#f472b6", "#a855f7", "#6366f1", "#06b6d4", "#22c55e"]}'::jsonb),
('theme', 'Divine Light', 'Premium radiant theme', 2000, true, 60, 'mythical', null,
 '{"primary": "#fef3c7", "secondary": "#fde68a", "background": "#1c1917", "text": "#ffffff", "accent": "#fef08a", "gradientColors": ["#fef3c7", "#fde68a", "#fcd34d", "#fbbf24"]}'::jsonb),

-- MYTHICAL AVATARS (3 free, 2 premium)
('avatar', 'Celestial Being', 'Higher entity', 1000, false, 60, 'mythical', '✨',
 '{"rarity": "mythical", "category": "divine", "level": "ascended"}'::jsonb),
('avatar', 'Void Emperor', 'Master of void', 1200, false, 60, 'mythical', '🌑',
 '{"rarity": "mythical", "category": "cosmos", "level": "ruler"}'::jsonb),
('avatar', 'Quantum Deity', 'God of quantum', 1500, false, 60, 'mythical', '🔱',
 '{"rarity": "mythical", "category": "physics", "level": "transcendent"}'::jsonb),
('avatar', 'Titans Wrath', 'Premium titan', 1750, true, 60, 'mythical', '⚡',
 '{"rarity": "mythical", "category": "mythical", "level": "titan", "premium": true}'::jsonb),
('avatar', 'Primordial One', 'Premium ancient god', 2000, true, 60, 'mythical', '🌟',
 '{"rarity": "mythical", "category": "divine", "level": "primordial", "premium": true}'::jsonb);

-- ============================================
-- GODLY (Level 100, 2000-5000 coins) - 90% Premium
-- ============================================

INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, level_required, rarity, icon_emoji, metadata) VALUES
-- GODLY THEMES (1 free, 4 premium)
('theme', 'Reality Bender', 'Bend reality itself', 2000, false, 100, 'godly', null,
 '{"primary": "gradient", "secondary": "gradient", "background": "#000000", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#ff0000", "#ff7f00", "#ffff00", "#00ff00", "#0000ff", "#4b0082", "#9400d3"], "special": "rainbow"}'::jsonb),
('theme', 'Omnipotent Dark', 'Premium absolute dark', 2500, true, 100, 'godly', null,
 '{"primary": "#000000", "secondary": "#000000", "background": "#000000", "text": "#ffffff", "accent": "#ffffff", "special": "pure_dark"}'::jsonb),
('theme', 'Universal Mind', 'Premium cosmic consciousness', 3000, true, 100, 'godly', null,
 '{"primary": "gradient", "secondary": "gradient", "background": "#000000", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#ff6b6b", "#feca57", "#48dbfb", "#ff9ff3", "#54a0ff", "#5f27cd"], "special": "universal"}'::jsonb),
('theme', 'Creator Essence', 'Premium creator theme', 4000, true, 100, 'godly', null,
 '{"primary": "gradient", "secondary": "gradient", "background": "#0a0a0a", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#ffd700", "#ffed4e", "#fff3cd"], "special": "golden", "premium": true}'::jsonb),
('theme', 'Absolute Infinity', 'Premium infinite theme', 5000, true, 100, 'godly', null,
 '{"primary": "#ffffff", "secondary": "#ffffff", "background": "#000000", "text": "#ffffff", "accent": "#ffffff", "special": "infinite", "premium": true}'::jsonb),

-- GODLY AVATARS (1 free, 4 premium)
('avatar', 'Reality Shaper', 'Shape existence', 2000, false, 100, 'godly', '🌀',
 '{"rarity": "godly", "category": "divine", "level": "shaper", "special": "reality"}'::jsonb),
('avatar', 'Eternal Watcher', 'Premium eternal being', 2500, true, 100, 'godly', '👁️',
 '{"rarity": "godly", "category": "divine", "level": "eternal", "premium": true}'::jsonb),
('avatar', 'Alpha Omega', 'Premium beginning and end', 3000, true, 100, 'godly', '🔰',
 '{"rarity": "godly", "category": "divine", "level": "absolute", "premium": true}'::jsonb),
('avatar', 'Supreme Creator', 'Premium supreme god', 4000, true, 100, 'godly', '⭐',
 '{"rarity": "godly", "category": "divine", "level": "supreme", "premium": true}'::jsonb),
('avatar', 'The Absolute', 'Premium ultimate being', 5000, true, 100, 'godly', '💫',
 '{"rarity": "godly", "category": "divine", "level": "absolute", "premium": true, "special": "ultimate"}'::jsonb);

-- Give all users the 1 free common theme and avatar
INSERT INTO public.user_inventory (user_id, item_id)
SELECT DISTINCT
  p.user_id,
  si.id
FROM public.profiles p
CROSS JOIN public.shop_items si
WHERE si.price = 0
  AND si.rarity = 'common'
ON CONFLICT (user_id, item_id) DO NOTHING;

-- Update comment
COMMENT ON TABLE public.shop_items IS 'Virtual shop items with progressive rarity system. Only 1 free item per rarity tier.';
COMMENT ON COLUMN public.shop_items.rarity IS 'Rarity tier: common, uncommon, rare, epic, legendary, mythical, godly';
COMMENT ON COLUMN public.shop_items.level_required IS 'Minimum user level required to purchase this item';
