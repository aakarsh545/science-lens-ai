-- Fix theme thumbnails - ensure each theme has unique, fitting image
-- This resolves blank and duplicate thumbnail issues

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1557683316-973673baf926?w=800&q=80' WHERE name = 'Rainbow Vibrant';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1540979388789-7cee28a1cdc9?w=800&q=80' WHERE name = 'Arctic Freeze';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1544551763-46a013bb70b5?w=800&q=80' WHERE name = 'Underwater World';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1557682250-33bd709cbe8b?w=800&q=80' WHERE name = 'Electric Neon';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80' WHERE name = 'Nebula Dream';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80' WHERE name = 'Volcanic Fury';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=800&q=80' WHERE name = 'Starfield';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1553356084-58ef4a67b2a7?w=800&q=80' WHERE name = 'Monochrome';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&q=80' WHERE name = 'Retro';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80' WHERE name = 'Sunset';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&q=80' WHERE name = 'Twilight';

-- Verify thumbnails are set (run this to check)
-- SELECT name, rarity, thumbnail_url FROM public.shop_items WHERE type = 'theme' ORDER BY rarity, name;
