-- Update ALL theme metadata with exact color values
-- These will be applied when a user equips a theme

-- COMMON
UPDATE shop_items SET metadata = '{"primary": "#1a2c3d", "secondary": "#2b3e50", "accent": "#3c4f61", "background": "#0d1f30", "text": "#4e6172", "description": "Classic cosmic blue theme with space aesthetics"}'::jsonb WHERE name = 'Cosmic';

UPDATE shop_items SET metadata = '{"primary": "#5d6e3f", "secondary": "#7a8b5c", "accent": "#384a1e", "background": "#9aa879", "text": "#1b2d03", "description": "Earthy green tones from natural forests"}'::jsonb WHERE name = 'Nature';

UPDATE shop_items SET metadata = '{"primary": "#5d6e3f", "secondary": "#7a8b5c", "accent": "#384a1e", "background": "#9aa879", "text": "#1b2d03", "description": "Minimalist black and white with stark contrasts"}'::jsonb WHERE name = 'Minimal';

UPDATE shop_items SET metadata = '{"primary": "#6d6d6d", "secondary": "#4e4e4e", "accent": "#8c8c8c", "background": "#2f2f2f", "text": "#ababab", "description": "Elegant grayscale with subtle gray tones"}'::jsonb WHERE name = 'Monochrome';

UPDATE shop_items SET metadata = '{"primary": "#a5b4c3", "secondary": "#c4d3e2", "accent": "#86a5b4", "background": "#e3f2ff", "text": "#678495", "description": "Soft, dreamy pastel colors for gentle aesthetics"}'::jsonb WHERE name = 'Pastel';

UPDATE shop_items SET metadata = '{"primary": "#5d6e3f", "secondary": "#7a8b5c", "accent": "#384a1e", "background": "#9aa879", "text": "#1b2d03", "description": "Deep forest with ancient trees and mysterious pathways"}'::jsonb WHERE name = 'Forest';

-- RARE
UPDATE shop_items SET metadata = '{"primary": "#b45f06", "secondary": "#d97f0a", "accent": "#8f3f02", "background": "#fe9f0e", "text": "#6a1f00", "description": "Beautiful sunset warm colors"}'::jsonb WHERE name = 'Sunset';

UPDATE shop_items SET metadata = '{"primary": "#5d4f6b", "secondary": "#7c6e8a", "accent": "#3e304c", "background": "#9b8da9", "text": "#1f112d", "description": "Magical hour when day meets night"}'::jsonb WHERE name = 'Twilight';

UPDATE shop_items SET metadata = '{"primary": "#c08f5e", "secondary": "#dfb09f", "accent": "#a16e3d", "background": "#fecfdf", "text": "#824d1c", "description": "Golden desert dunes under scorching sun"}'::jsonb WHERE name = 'Desert';

UPDATE shop_items SET metadata = '{"primary": "#a5b4c3", "secondary": "#c4d3e2", "accent": "#86a5b4", "background": "#e3f2ff", "text": "#678495", "description": "Polar ice caps with crystalline beauty"}'::jsonb WHERE name = 'Arctic Freeze';

UPDATE shop_items SET metadata = '{"primary": "#3d6a7f", "secondary": "#5c89a0", "accent": "#1e4b60", "background": "#7ba8c1", "text": "#002c41", "description": "Vibrant coral reef with tropical marine life"}'::jsonb WHERE name = 'Underwater World';

-- EPIC
UPDATE shop_items SET metadata = '{"primary": "#3d6a7f", "secondary": "#5c89a0", "accent": "#1e4b60", "background": "#7ba8c1", "text": "#002c41", "description": "Mysterious deep ocean with bioluminescent creatures"}'::jsonb WHERE name = 'Ocean';

UPDATE shop_items SET metadata = '{"primary": "#ff00ff", "secondary": "#00ffff", "accent": "#ffff00", "background": "#000000", "text": "#ffffff", "description": "Vibrant neon lights that pulse with energy"}'::jsonb WHERE name = 'Neon';

UPDATE shop_items SET metadata = '{"primary": "#ff00ff", "secondary": "#00ffff", "accent": "#ffff00", "background": "#000000", "text": "#ffffff", "description": "Neon-soaked 1980s synthwave aesthetics"}'::jsonb WHERE name = 'Retro';

UPDATE shop_items SET metadata = '{"primary": "#1a2c3d", "secondary": "#2b3e50", "accent": "#3c4f61", "background": "#0d1f30", "text": "#4e6172", "description": "Journey through the cosmos with infinite stars"}'::jsonb WHERE name = 'Starfield';

-- LEGENDARY
UPDATE shop_items SET metadata = '{"primary": "#ff00ff", "secondary": "#00ffff", "accent": "#ffff00", "background": "#000000", "text": "#ffffff", "description": "High-tech neon cyberpunk aesthetics with electric vibes"}'::jsonb WHERE name = 'Cyberpunk';

UPDATE shop_items SET metadata = '{"primary": "#b45f06", "secondary": "#d97f0a", "accent": "#8f3f02", "background": "#fe9f0e", "text": "#6a1f00", "description": "Molten lava flows with intense heat and energy"}'::jsonb WHERE name = 'Volcanic Fury';

UPDATE shop_items SET metadata = '{"primary": "#ff00ff", "secondary": "#00ffff", "accent": "#ffff00", "background": "#000000", "text": "#ffffff", "description": "Full spectrum rainbow with vibrant pops of color"}'::jsonb WHERE name = 'Rainbow Vibrant';

UPDATE shop_items SET metadata = '{"primary": "#ff00ff", "secondary": "#00ffff", "accent": "#ffff00", "background": "#000000", "text": "#ffffff", "description": "Vibrant neon lights that pulse with electric energy"}'::jsonb WHERE name = 'Electric Neon';

UPDATE shop_items SET metadata = '{"primary": "#5d4f6b", "secondary": "#7c6e8a", "accent": "#3e304c", "background": "#9b8da9", "text": "#1f112d", "description": "Swirling nebula clouds with purple cosmic energy"}'::jsonb WHERE name = 'Galaxy';

UPDATE shop_items SET metadata = '{"primary": "#1a2c3d", "secondary": "#2b3e50", "accent": "#3c4f61", "background": "#0d1f30", "text": "#4e6172", "description": "Abyssal blackness with distant starlight"}'::jsonb WHERE name = 'Midnight';

-- MYTHICAL
UPDATE shop_items SET metadata = '{"primary": "#5d6e3f", "secondary": "#7a8b5c", "accent": "#384a1e", "background": "#9aa879", "text": "#1b2d03", "description": "Experience the magical aurora borealis with dynamic color shifts"}'::jsonb WHERE name = 'Aurora';

UPDATE shop_items SET metadata = '{"primary": "#5d4f6b", "secondary": "#7c6e8a", "accent": "#3e304c", "background": "#9b8da9", "text": "#1f112d", "description": "Dreamy purple nebula clouds floating in space"}'::jsonb WHERE name = 'Nebula Dream';

UPDATE shop_items SET metadata = '{"primary": "#3d6a7f", "secondary": "#5c89a0", "accent": "#1e4b60", "background": "#7ba8c1", "text": "#002c41", "description": "Infinite cosmic expanse with boundless galaxies"}'::jsonb WHERE name = 'Cosmic Infinity';
