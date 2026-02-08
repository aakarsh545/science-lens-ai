-- Update themes with rarity and thumbnails, add Aurora theme
-- Premium theme shop with rarity tiers and pricing

-- Update existing themes with rarity and thumbnails
UPDATE public.shop_items SET
  rarity = 'common',
  thumbnail_url = 'https://img.freepik.com/free-vector/gradient-black-background-with-wavy-lines_52683-76100.jpg',
  price = 0,
  metadata = '{
    "primary": "#3b82f6",
    "secondary": "#1e40af",
    "accent": "#60a5fa",
    "background": "#0f172a",
    "text": "#f1f5f9",
    "description": "Classic cosmic blue theme with space aesthetics"
  }'::jsonb
WHERE name = 'Cosmic Blue';

UPDATE public.shop_items SET
  rarity = 'common',
  thumbnail_url = 'https://nighteye.app/wp-content/uploads/2020/04/edward-paterson-nfA84oYWF6w-unsplash.jpg',
  price = 0,
  metadata = '{
    "primary": "#10b981",
    "secondary": "#059669",
    "accent": "#34d399",
    "background": "#064e3b",
    "text": "#ecfdf5",
    "description": "Earthy green tones inspired by nature"
  }'::jsonb
WHERE name = 'Aurora Green' AND type = 'theme';

-- Delete old themes that don't match our new vision
DELETE FROM public.shop_items
WHERE type = 'theme'
  AND name NOT IN ('Cosmic Blue', 'Aurora Green');

-- Insert new premium themes with rarity
INSERT INTO public.shop_items (type, name, description, price, is_premium_exclusive, icon_emoji, rarity, thumbnail_url, metadata) VALUES
-- Common Themes
('theme', 'Nature', 'Earthy green tones with natural beauty', 0, false, '🌿', 'common',
 'https://nighteye.app/wp-content/uploads/2020/04/edward-paterson-nfA84oYWF6w-unsplash.jpg',
 '{"primary": "#10b981", "secondary": "#059669", "accent": "#34d399", "background": "#064e3b", "text": "#ecfdf5", "description": "Peaceful nature-inspired green theme"}'::jsonb),

-- Rare Theme
('theme', 'Sunset', 'Warm orange and pink sunset gradients', 200, false, '🌅', 'rare',
 'https://miro.medium.com/v2/resize:fit:1400/1*1T_tjGHKjUDfJAnxCI71cg.jpeg',
 '{"primary": "#f97316", "secondary": "#ea580c", "accent": "#fb923c", "background": "#431407", "text": "#fff7ed", "description": "Beautiful sunset warm colors"}'::jsonb),

-- Epic Theme
('theme', 'Ocean', 'Deep blue and teal oceanic depths', 500, false, '🌊', 'epic',
 'https://i.redd.it/for-night-mode-lovers-3840x2160-v0-sczcrod90cod1.jpg',
 '{"primary": "#14b8a6", "secondary": "#0d9488", "accent": "#2dd4bf", "background": "#134e4a", "text": "#f0fdfa", "description": "Mysterious deep ocean theme"}'::jsonb),

-- Legendary Theme
('theme', 'Cyberpunk', 'Neon pink and cyan futuristic vibes', 1000, false, '🌃', 'legendary',
 'https://thumbs.dreamstime.com/b/transform-your-screen-stunning-cyberpunk-cityscape-wallpaper-featuring-vibrant-neon-lights-futuristic-high-tech-vibes-352926865.jpg',
 '{"primary": "#ec4899", "secondary": "#0891b2", "accent": "#22d3ee", "background": "#1a1a2e", "text": "#ffffff", "description": "High-tech neon cyberpunk aesthetics"}'::jsonb),

-- Mythical Theme (NEW!)
('theme', 'Aurora', 'Northern lights multi-color gradients', 2500, false, '✨', 'mythical',
 'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=1920&q=80',
 '{"primary": "#a78bfa", "secondary": "#ec4899", "accent": "gradient", "background": "#0f0518", "text": "#ffffff", "gradientColors": ["#8b5cf6", "#ec4899", "#f97316", "#fbbf24", "#10b981"], "description": "Magical aurora borealis with shifting colors"}'::jsonb)
ON CONFLICT (name) DO UPDATE SET
  rarity = EXCLUDED.rarity,
  thumbnail_url = EXCLUDED.thumbnail_url,
  price = EXCLUDED.price,
  metadata = EXCLUDED.metadata,
  description = EXCLUDED.description;

-- Delete old free themes we're replacing
DELETE FROM public.shop_items
WHERE type = 'theme'
  AND name IN ('Nebula Purple', 'Solar Orange', 'Ocean Teal', 'Quantum Gold', 'Dark Matter', 'Plasma Pink', 'Crystalline', 'Rainbow Quantum');
