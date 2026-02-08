-- Restore ALL themes from project history with proper rarity distribution
-- Mythical: Rarest, most premium (2-3 themes)
-- Legendary: High-tech/dynamic (4-6 themes)
-- Epic: Immersive (5-7 themes)
-- Rare: Scenic (6-8 themes)
-- Common: Basic themes (8+ themes)

-- Delete existing themes first
DELETE FROM public.shop_items WHERE type = 'theme';

-- Insert ALL themes with rarity, pricing, and metadata
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, icon_emoji, rarity, thumbnail_url, metadata) VALUES

-- ========== MYTHICAL (2-3 themes) - Rarest, most premium ==========
('theme', 'Aurora Borealis', 'Magical northern lights with shifting rainbow colors', 2500, false, '✨', 'mythical',
 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=1920&q=80',
 '{"primary": "#a78bfa", "secondary": "#ec4899", "accent": "gradient", "background": "#0f0518", "text": "#ffffff", "gradientColors": ["#8b5cf6", "#ec4899", "#f97316", "#fbbf24", "#10b981"], "description": "Experience the magical aurora borealis with dynamic color shifts"}'::jsonb),

('theme', 'Starfield Cosmos', 'Deep space with countless stars and nebulae', 2000, false, '🌌', 'mythical',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1920&q=80',
 '{"primary": "#8b5cf6", "secondary": "#6366f1", "accent": "#a78bfa", "background": "#030712", "text": "#eef2ff", "description": "Journey through the cosmos with infinite stars", "particles": "dense"}'::jsonb),

('theme', 'Galaxy Nebula', 'Swirling purple nebula with cosmic energy', 2000, false, '🌠', 'mythical',
 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?w=1920&q=80',
 '{"primary": "#a855f7", "secondary": "#7c3aed", "accent": "#c084fc", "background": "#1e1b4b", "text": "#faf5ff", "description": "Swirling nebula clouds with purple cosmic energy"}'::jsonb),

-- ========== LEGENDARY (4-6 themes) - High-tech/dynamic ==========
('theme', 'Cyberpunk City', 'Neon pink and cyan futuristic metropolis', 1500, false, '🌃', 'legendary',
 'https://images.unsplash.com/photo-1555680202-c86f0e12f086?w=1920&q=80',
 '{"primary": "#ec4899", "secondary": "#0891b2", "accent": "#22d3ee", "background": "#1a1a2e", "text": "#ffffff", "description": "High-tech neon cyberpunk aesthetics with electric vibes"}'::jsonb),

('theme', 'Volcanic Fury', 'Raging lava with fiery red glows', 1500, false, '🌋', 'legendary',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1920&q=80',
 '{"primary": "#dc2626", "secondary": "#b91c1c", "accent": "#f87171", "background": "#450a0a", "text": "#fef2f2", "description": "Molten lava flows with intense heat and energy"}'::jsonb),

('theme', 'Electric Neon', 'Bright electric blues and pinks', 1500, false, '⚡', 'legendary',
 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=1920&q=80',
 '{"primary": "#3b82f6", "secondary": "#ec4899", "accent": "#f472b6", "background": "#0f172a", "text": "#ffffff", "description": "Vibrant neon lights that pulse with energy"}'::jsonb),

('theme', 'Rainbow Vibrant', 'Explosive rainbow color palette', 1500, false, '🌈', 'legendary',
 'https://images.unsplash.com/photo-1557683316-973673baf926?w=1920&q=80',
 '{"primary": "#ec4899", "secondary": "#f97316", "accent": "gradient", "background": "#1a1a2e", "text": "#ffffff", "gradientColors": ["#ec4899", "#f97316", "#fbbf24", "#10b981", "#3b82f6", "#8b5cf6"], "description": "Full spectrum rainbow with vibrant pops of color"}'::jsonb),

-- ========== EPIC (5-7 themes) - Immersive ==========
('theme', 'Ocean Depths', 'Deep blue underwater exploration', 1000, false, '🌊', 'epic',
 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=1920&q=80',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "accent": "#2dd4bf", "background": "#134e4a", "text": "#f0fdfa", "description": "Mysterious deep ocean with bioluminescent creatures"}'::jsonb),

('theme', 'Underwater World', 'Aqua marine with coral reef colors', 1000, false, '🐠', 'epic',
 'https://images.unsplash.com/photo-1559827291-72ee739d1d9a?w=1920&q=80',
 '{"primary": "#06b6d4", "secondary": "#0891b2", "accent": "#22d3ee", "background": "#083344", "text": "#ecfeff", "description": "Vibrant coral reef with tropical marine life"}'::jsonb),

('theme', 'Arctic Freeze', 'Icy blue polar landscapes', 1000, false, '❄️', 'epic',
 'https://images.unsplash.com/photo-1518182170546-0766ce6fecfa?w=1920&q=80',
 '{"primary": "#67e8f9", "secondary": "#0ea5e9", "accent": "#7dd3fc", "background": "#0c4a6e", "text": "#f0f9ff", "description": "Polar ice caps with crystalline beauty"}'::jsonb),

('theme', 'Twilight Dusk', 'Purple-orange sunset transitions', 1000, false, '🌆', 'epic',
 'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=1920&q=80',
 '{"primary": "#a855f7", "secondary": "#f97316", "accent": "#c084fc", "background": "#2d1b69", "text": "#faf5ff", "description": "Magical hour when day meets night"}'::jsonb),

('theme', 'Midnight Void', 'Deepest black with subtle starlight', 1000, false, '🌑', 'epic',
 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=1920&q=80',
 '{"primary": "#6366f1", "secondary": "#4f46e5", "accent": "#818cf8", "background": "#000000", "text": "#eef2ff", "description": "Abyssal blackness with distant starlight"}'::jsonb),

-- ========== RARE (6-8 themes) - Scenic ==========
('theme', 'Desert Sands', 'Warm sandy orange landscapes', 500, false, '🏜️', 'rare',
 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=1920&q=80',
 '{"primary": "#f97316", "secondary": "#ea580c", "accent": "#fb923c", "background": "#431407", "text": "#fff7ed", "description": "Golden desert dunes under scorching sun"}'::jsonb),

('theme', 'Forest Realm', 'Dark green ancient woodland', 500, false, '🌲', 'rare',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=1920&q=80',
 '{"primary": "#166534", "secondary": "#14532d", "accent": "#22c55e", "background": "#052e16", "text": "#f0fdf4", "description": "Deep forest with ancient trees and mysterious pathways"}'::jsonb),

('theme', 'Retro Wave', '80s synthwave nostalgia', 500, false, '📼', 'rare',
 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=1920&q=80',
 '{"primary": "#f472b6", "secondary": "#8b5cf6", "accent": "#ec4899", "background": "#2d1b4e", "text": "#faf5ff", "description": "Neon-soaked 1980s synthwave aesthetics"}'::jsonb),

('theme', 'Pastel Dreams', 'Soft pastel color palette', 500, false, '🎨', 'rare',
 'https://images.unsplash.com/photo-1541701494587-cb58502866ab?w=1920&q=80',
 '{"primary": "#f9a8d4", "secondary": "#a5b4fc", "accent": "#fcd34d", "background": "#fdf4ff", "text": "#1f2937", "description": "Soft, dreamy pastel colors for gentle aesthetics"}'::jsonb),

('theme', 'Sunset Blaze', 'Intense orange-pink horizon', 500, false, '🌅', 'rare',
 'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=1920&q=80',
 '{"primary": "#f97316", "secondary": "#ea580c", "accent": "#fb923c", "background": "#431407", "text": "#fff7ed", "description": "Dramatic sunset with blazing orange and pink skies"}'::jsonb),

('theme', 'Mountain Peak', 'Majestic mountain heights', 500, false, '⛰️', 'rare',
 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1920&q=80',
 '{"primary": "#78716c", "secondary": "#57534e", "accent": "#a8a29e", "background": "#1c1917", "text": "#fafaf9", "description": "Snow-capped mountain peaks with rocky terrain"}'::jsonb),

-- ========== COMMON (8+ themes) - Basic/free ==========
('theme', 'Cosmic Blue', 'Classic space theme with blue accents', 0, false, '🌌', 'common',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1920&q=80',
 '{"primary": "#3b82f6", "secondary": "#1e40af", "accent": "#60a5fa", "background": "#0f172a", "text": "#f1f5f9", "description": "Classic cosmic blue theme with space aesthetics"}'::jsonb),

('theme', 'Nature Green', 'Earthy green tones from forests', 0, false, '🌿', 'common',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=1920&q=80',
 '{"primary": "#10b981", "secondary": "#059669", "accent": "#34d399", "background": "#064e3b", "text": "#ecfdf5", "description": "Peaceful nature-inspired green theme"}'::jsonb),

('theme', 'Minimal Mono', 'Clean black and white', 100, false, '⬜', 'common',
 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?w=1920&q=80',
 '{"primary": "#18181b", "secondary": "#27272a", "accent": "#71717a", "background": "#000000", "text": "#fafafa", "description": "Minimalist monochrome with stark contrasts"}'::jsonb),

('theme', 'Midnight Zone', 'Dark blue late night theme', 100, false, '🌃', 'common',
 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=1920&q=80',
 '{"primary": "#1e3a8a", "secondary": "#1e40af", "accent": "#3b82f6", "background": "#0f172a", "text": "#dbeafe", "description": "Late night theme with calming dark blues"}'::jsonb),

('theme', 'Nebula Purple', 'Deep purple cosmic clouds', 100, false, '🔮', 'common',
 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?w=1920&q=80',
 '{"primary": "#8b5cf6", "secondary": "#6d28d9", "background": "#1e1b4b", "text": "#f5f3ff", "description": "Mysterious purple nebula floating in space"}'::jsonb),

('theme', 'Solar Flare', 'Bright yellow-orange energy', 100, false, '☀️', 'common',
 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1920&q=80',
 '{"primary": "#fbbf24", "secondary": "#d97706", "background": "#451a03", "text": "#fef3c7", "description": "Solar energy with bright yellow and orange"}'::jsonb),

('theme', 'Ocean Teal', 'Calming blue-green ocean', 100, false, '💧', 'common',
 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=1920&q=80',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "background": "#134e4a", "text": "#f0fdfa", "description": "Serene ocean waters with calming teal tones"}'::jsonb),

('theme', 'Crimson Red', 'Bold red passion theme', 100, false, '❤️', 'common',
 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=1920&q=80',
 '{"primary": "#dc2626", "secondary": "#b91c1c", "accent": "#f87171", "background": "#450a0a", "text": "#fef2f2", "description": "Bold crimson red with passionate energy"}'::jsonb),

('theme', 'Amber Gold', 'Rich golden elegance', 100, false, '🏆', 'common',
 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=1920&q=80',
 '{"primary": "#fbbf24", "secondary": "#d97706", "accent": "#fcd34d", "background": "#451a03", "text": "#fef3c7", "description": "Luxurious golden theme with elegance"}'::jsonb)

ON CONFLICT (name) DO UPDATE SET
  rarity = EXCLUDED.rarity,
  price = EXCLUDED.price,
  thumbnail_url = EXCLUDED.thumbnail_url,
  metadata = EXCLUDED.metadata,
  description = EXCLUDED.description,
  icon_emoji = EXCLUDED.icon_emoji;

-- Grant free themes to all existing users
INSERT INTO public.user_inventory (user_id, item_id)
SELECT DISTINCT
  p.user_id,
  si.id
FROM public.profiles p
CROSS JOIN public.shop_items si
WHERE si.price = 0
  AND si.type = 'theme'
  AND NOT EXISTS (
    SELECT 1 FROM public.user_inventory ui
    WHERE ui.user_id = p.user_id AND ui.item_id = si.id
  )
ON CONFLICT (user_id, item_id) DO NOTHING;
