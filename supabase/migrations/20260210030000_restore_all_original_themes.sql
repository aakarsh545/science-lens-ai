-- Restore ALL original themes with correct rarity distribution
-- Common: 6 themes (top of shop)
-- Rare: 5 themes
-- Epic: 5 themes
-- Legendary: 6 themes
-- Mythical: 3 themes (bottom of shop)
-- Total: 25 themes

-- Clean up existing themes and restore correct set
DELETE FROM public.shop_items WHERE type = 'theme';

-- Insert all themes with proper rarity, pricing, and thumbnails
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, icon_emoji, rarity, thumbnail_url, metadata) VALUES

-- ========== COMMON (6 themes) ==========
('theme', 'Cosmic', 'Classic space theme with blue accents', 0, false, '🌌', 'common',
 'https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=800&q=80',
 '{"primary": "#3b82f6", "secondary": "#1e40af", "accent": "#60a5fa", "background": "#0f172a", "text": "#f1f5f9", "description": "Classic cosmic blue theme with space aesthetics"}'::jsonb),

('theme', 'Nature', 'Peaceful green forest theme', 0, false, '🌿', 'common',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800&q=80',
 '{"primary": "#10b981", "secondary": "#059669", "accent": "#34d399", "background": "#064e3b", "text": "#ecfdf5", "description": "Earthy green tones from natural forests"}'::jsonb),

('theme', 'Minimal', 'Clean and simple minimalist theme', 0, false, '⬜', 'common',
 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?w=800&q=80',
 '{"primary": "#18181b", "secondary": "#27272a", "accent": "#71717a", "background": "#000000", "text": "#fafafa", "description": "Minimalist black and white with stark contrasts"}'::jsonb),

('theme', 'Monochrome', 'Pure grayscale elegance', 0, false, '⬛', 'common',
 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&q=80',
 '{"primary": "#404040", "secondary": "#262626", "accent": "#737373", "background": "#171717", "text": "#fafafa", "description": "Elegant grayscale with subtle gray tones"}'::jsonb),

('theme', 'Pastel', 'Soft pastel color palette', 0, false, '🎨', 'common',
 'https://images.unsplash.com/photo-1541701494587-cb58502866ab?w=800&q=80',
 '{"primary": "#f9a8d4", "secondary": "#a5b4fc", "accent": "#fcd34d", "background": "#fdf4ff", "text": "#1f2937", "description": "Soft, dreamy pastel colors for gentle aesthetics"}'::jsonb),

('theme', 'Forest', 'Dark green ancient woodland', 0, false, '🌲', 'common',
 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800&q=80',
 '{"primary": "#166534", "secondary": "#14532d", "accent": "#22c55e", "background": "#052e16", "text": "#f0fdf4", "description": "Deep forest with ancient trees and mysterious pathways"}'::jsonb),

-- ========== RARE (5 themes) ==========
('theme', 'Sunset', 'Warm orange and pink sunset gradients', 500, false, '🌅', 'rare',
 'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=800&q=80',
 '{"primary": "#f97316", "secondary": "#ea580c", "accent": "#fb923c", "background": "#431407", "text": "#fff7ed", "description": "Beautiful sunset warm colors"}'::jsonb),

('theme', 'Twilight', 'Purple-orange dusk transitions', 500, false, '🌆', 'rare',
 'https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=800&q=80',
 '{"primary": "#a855f7", "secondary": "#f97316", "accent": "#c084fc", "background": "#2d1b69", "text": "#faf5ff", "description": "Magical hour when day meets night"}'::jsonb),

('theme', 'Desert', 'Sandy orange desert landscapes', 500, false, '🏜️', 'rare',
 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800&q=80',
 '{"primary": "#f97316", "secondary": "#ea580c", "accent": "#fb923c", "background": "#431407", "text": "#fff7ed", "description": "Golden desert dunes under scorching sun"}'::jsonb),

('theme', 'Arctic Freeze', 'Icy blue polar landscapes', 500, false, '❄️', 'rare',
 'https://images.unsplash.com/photo-1540979388789-7cee28a1cdc9?w=800&q=80',
 '{"primary": "#67e8f9", "secondary": "#0ea5e9", "accent": "#7dd3fc", "background": "#0c4a6e", "text": "#f0f9ff", "description": "Polar ice caps with crystalline beauty"}'::jsonb),

('theme', 'Underwater World', 'Aqua marine coral reef', 500, false, '🐠', 'rare',
 'https://images.unsplash.com/photo-1544551763-46a013bb70b5?w=800&q=80',
 '{"primary": "#06b6d4", "secondary": "#0891b2", "accent": "#22d3ee", "background": "#083344", "text": "#ecfeff", "description": "Vibrant coral reef with tropical marine life"}'::jsonb),

-- ========== EPIC (5 themes) ==========
('theme', 'Ocean', 'Deep blue oceanic depths', 1000, false, '🌊', 'epic',
 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800&q=80',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "accent": "#2dd4bf", "background": "#134e4a", "text": "#f0fdfa", "description": "Mysterious deep ocean with bioluminescent creatures"}'::jsonb),

('theme', 'Neon', 'Bright electric blue and pink', 1000, false, '⚡', 'epic',
 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80',
 '{"primary": "#3b82f6", "secondary": "#ec4899", "accent": "#f472b6", "background": "#0f172a", "text": "#ffffff", "description": "Vibrant neon lights that pulse with energy"}'::jsonb),

('theme', 'Vibrant', 'Explosive rainbow color palette', 1000, false, '🌈', 'epic',
 'https://images.unsplash.com/photo-1557683316-973673baf926?w=800&q=80',
 '{"primary": "#ec4899", "secondary": "#f97316", "accent": "gradient", "background": "#1a1a2e", "text": "#ffffff", "gradientColors": ["#ec4899", "#f97316", "#fbbf24", "#10b981", "#3b82f6", "#8b5cf6"], "description": "Full spectrum rainbow with vibrant pops of color"}'::jsonb),

('theme', 'Retro', '80s synthwave nostalgia', 1000, false, '📼', 'epic',
 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&q=80',
 '{"primary": "#f472b6", "secondary": "#8b5cf6", "accent": "#ec4899", "background": "#2d1b4e", "text": "#faf5ff", "description": "Neon-soaked 1980s synthwave aesthetics"}'::jsonb),

('theme', 'Starfield', 'Cosmic stars and galaxies', 1000, false, '🌠', 'epic',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80',
 '{"primary": "#8b5cf6", "secondary": "#6366f1", "accent": "#a78bfa", "background": "#030712", "text": "#eef2ff", "description": "Journey through the cosmos with infinite stars"}'::jsonb),

-- ========== LEGENDARY (6 themes) ==========
('theme', 'Cyberpunk', 'Neon pink and cyan futuristic city', 1500, false, '🌃', 'legendary',
 'https://images.unsplash.com/photo-1555680202-c86f0e12f086?w=800&q=80',
 '{"primary": "#ec4899", "secondary": "#0891b2", "accent": "#22d3ee", "background": "#1a1a2e", "text": "#ffffff", "description": "High-tech neon cyberpunk aesthetics with electric vibes"}'::jsonb),

('theme', 'Volcanic Fury', 'Raging lava with fiery red glows', 1500, false, '🌋', 'legendary',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80',
 '{"primary": "#dc2626", "secondary": "#b91c1c", "accent": "#f87171", "background": "#450a0a", "text": "#fef2f2", "description": "Molten lava flows with intense heat and energy"}'::jsonb),

('theme', 'Rainbow Vibrant', 'Explosive rainbow colors', 1500, false, '🌈', 'legendary',
 'https://images.unsplash.com/photo-1557683316-973673baf926?w=800&q=80',
 '{"primary": "#ec4899", "secondary": "#f97316", "accent": "gradient", "background": "#1a1a2e", "text": "#ffffff", "gradientColors": ["#ec4899", "#f97316", "#fbbf24", "#10b981", "#3b82f6", "#8b5cf6"], "description": "Full spectrum rainbow with vibrant pops of color"}'::jsonb),

('theme', 'Electric Neon', 'Bright electric blues and pinks', 1500, false, '⚡', 'legendary',
 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80',
 '{"primary": "#3b82f6", "secondary": "#ec4899", "accent": "#f472b6", "background": "#0f172a", "text": "#ffffff", "description": "Vibrant neon lights that pulse with electric energy"}'::jsonb),

('theme', 'Galaxy', 'Purple nebula cosmic clouds', 1500, false, '🌌', 'legendary',
 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?w=800&q=80',
 '{"primary": "#a855f7", "secondary": "#7c3aed", "accent": "#c084fc", "background": "#1e1b4b", "text": "#faf5ff", "description": "Swirling nebula clouds with purple cosmic energy"}'::jsonb),

('theme', 'Midnight', 'Deepest black with starlight', 1500, false, '🌑', 'legendary',
 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800&q=80',
 '{"primary": "#6366f1", "secondary": "#4f46e5", "accent": "#818cf8", "background": "#000000", "text": "#eef2ff", "description": "Abyssal blackness with distant starlight"}'::jsonb),

-- ========== MYTHICAL (3 themes) ==========
('theme', 'Aurora', 'Magical northern lights with multi-color gradients', 2500, false, '✨', 'mythical',
 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=800&q=80',
 '{"primary": "#a78bfa", "secondary": "#ec4899", "accent": "gradient", "background": "#0f0518", "text": "#ffffff", "gradientColors": ["#8b5cf6", "#ec4899", "#f97316", "#fbbf24", "#10b981"], "description": "Experience the magical aurora borealis with dynamic color shifts"}'::jsonb),

('theme', 'Nebula Dream', 'Cosmic nebula with dreamy purple clouds', 2500, false, '🌠', 'mythical',
 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80',
 '{"primary": "#c084fc", "secondary": "#a855f7", "accent": "#e879f9", "background": "#1e1b4b", "text": "#faf5ff", "description": "Dreamy purple nebula clouds floating in space"}'::jsonb),

('theme', 'Cosmic Infinity', 'Infinite stars and galaxies', 2500, false, '🌌', 'mythical',
 'https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=800&q=80',
 '{"primary": "#818cf8", "secondary": "#6366f1", "accent": "#a78bfa", "background": "#030712", "text": "#eef2ff", "description": "Infinite cosmic expanse with boundless galaxies"}'::jsonb)

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
