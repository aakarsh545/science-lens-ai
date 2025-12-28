-- Populate Shop with Initial Items
-- This migration adds science-themed themes and avatars

-- Insert Themes (10 total: 5 free, 5 premium)
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, icon_emoji, metadata) VALUES
-- Free Themes
('theme', 'Cosmic Blue', 'Classic space theme with blue accents', 0, false, '🌌',
 '{"primary": "#3b82f6", "secondary": "#1e40af", "background": "#0f172a", "text": "#f1f5f9", "accent": "#60a5fa"}'::jsonb),
('theme', 'Nebula Purple', 'Deep purple nebula colors', 0, false, '🌌',
 '{"primary": "#8b5cf6", "secondary": "#6d28d9", "background": "#1e1b4b", "text": "#f5f3ff", "accent": "#a78bfa"}'::jsonb),
('theme', 'Aurora Green', 'Northern lights inspired theme', 0, false, '🌌',
 '{"primary": "#10b981", "secondary": "#059669", "background": "#064e3b", "text": "#ecfdf5", "accent": "#34d399"}'::jsonb),
('theme', 'Solar Orange', 'Solar energy fiery colors', 0, false, '☀️',
 '{"primary": "#f97316", "secondary": "#ea580c", "background": "#431407", "text": "#fff7ed", "accent": "#fb923c"}'::jsonb),
('theme', 'Ocean Teal', 'Deep ocean exploration theme', 0, false, '🌊',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "background": "#134e4a", "text": "#f0fdfa", "accent": "#2dd4bf"}'::jsonb),

-- Premium Themes
('theme', 'Quantum Gold', 'Advanced physics golden theme', 500, false, '⚛️',
 '{"primary": "#fbbf24", "secondary": "#d97706", "background": "#451a03", "text": "#fef3c7", "accent": "#fcd34d"}'::jsonb),
('theme', 'Dark Matter', 'Mysterious dark void theme', 500, false, '🌑',
 '{"primary": "#6366f1", "secondary": "#4f46e5", "background": "#000000", "text": "#eef2ff", "accent": "#818cf8"}'::jsonb),
('theme', 'Plasma Pink', 'High energy physics theme', 750, false, '⚡',
 '{"primary": "#ec4899", "secondary": "#db2777", "background": "#831843", "text": "#fdf2f8", "accent": "#f472b6"}'::jsonb),
('theme', 'Crystalline', 'Crystallography inspired theme', 1000, false, '💎',
 '{"primary": "#06b6d4", "secondary": "#0891b2", "background": "#083344", "text": "#ecfeff", "accent": "#22d3ee"}'::jsonb),
('theme', 'Rainbow Quantum', 'Quantum superposition colors', 1500, false, '🌈',
 '{"primary": "#a78bfa", "secondary": "#ec4899", "background": "#1a1a2e", "text": "#ffffff", "accent": "gradient", "gradientColors": ["#8b5cf6", "#ec4899", "#f97316", "#fbbf24"]}'::jsonb)
ON CONFLICT (name) DO NOTHING;

-- Insert Avatars (15 total: 8 free, 7 premium)
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, icon_emoji, metadata) VALUES
-- Free Avatars (Beginner Scientists)
('avatar', 'Atom Scientist', 'Starting scientist avatar', 0, false, '⚛️', '{"rarity": "common", "category": "physics"}'::jsonb),
('avatar', 'Rocket Explorer', 'Space exploration enthusiast', 0, false, '🚀', '{"rarity": "common", "category": "space"}'::jsonb),
('avatar', 'Lab Researcher', 'Biology research starter', 0, false, '🔬', '{"rarity": "common", "category": "biology"}'::jsonb),
('avatar', 'Planet Discoverer', 'Astronomy beginner', 0, false, '🪐', '{"rarity": "common", "category": "astronomy"}'::jsonb),
('avatar', 'Stargazer', 'Observation focused astronomer', 0, false, '🔭', '{"rarity": "common", "category": "astronomy"}'::jsonb),
('avatar', 'Magnet Master', 'Physics magnetism expert', 0, false, '🧲', '{"rarity": "common", "category": "physics"}'::jsonb),
('avatar', 'Test Tube Chemist', 'Chemistry starter avatar', 0, false, '🧪', '{"rarity": "common", "category": "chemistry"}'::jsonb),
('avatar', 'Microscope Pro', 'Discovery and biology', 0, false, '🔍', '{"rarity": "common", "category": "biology"}'::jsonb),

-- Premium Avatars (Advanced Scientists)
('avatar', 'Einstein Legend', 'Physics mastery avatar', 300, false, '👨‍🔬', '{"rarity": "rare", "category": "physics", "level": "expert"}'::jsonb),
('avatar', 'Quantum Genius', 'Advanced quantum physicist', 400, false, '🎓', '{"rarity": "rare", "category": "physics", "level": "advanced"}'::jsonb),
('avatar', 'Space Cosmonaut', 'Space exploration expert', 500, false, '👨‍🚀', '{"rarity": "rare", "category": "space", "level": "expert"}'::jsonb),
('avatar', 'AI Researcher', 'Artificial intelligence expert', 600, false, '🤖', '{"rarity": "epic", "category": "technology", "level": "advanced"}'::jsonb),
('avatar', 'DNA Master', 'Genetics and DNA expert', 700, false, '🧬', '{"rarity": "epic", "category": "biology", "level": "expert"}'::jsonb),
('avatar', 'Black Hole Expert', 'Cosmology master', 1000, false, '🌌', '{"rarity": "legendary", "category": "astronomy", "level": "master"}'::jsonb),
('avatar', 'Nuclear Genius', 'Nuclear physics expert', 1500, false, '☢️', '{"rarity": "legendary", "category": "physics", "level": "master"}'::jsonb)
ON CONFLICT (name) DO NOTHING;

-- Give all users free themes and avatars by default
INSERT INTO public.user_inventory (user_id, item_id)
SELECT DISTINCT
  p.user_id,
  si.id
FROM public.profiles p
CROSS JOIN public.shop_items si
WHERE si.price = 0
  AND si.type = 'avatar'
ON CONFLICT (user_id, item_id) DO NOTHING;
