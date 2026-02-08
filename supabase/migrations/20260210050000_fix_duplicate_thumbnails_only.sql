-- Fix ONLY thumbnails for themes with issues
-- NO rarity changes, NO theme rearrangement

-- Blank themes - add thumbnails
UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1557683316-973673baf926?w=800&q=80'
WHERE name = 'Rainbow Vibrant';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1518182170546-0766ce6fecfa?w=800&q=80'
WHERE name = 'Arctic Freeze';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1544551763-46a013bb70b5?w=800&q=80'
WHERE name = 'Underwater World';

-- Electric Neon and Neon have same thumbnail - give Neon its own
UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1563089145-599997674d42?w=800&q=80'
WHERE name = 'Neon' AND type = 'theme';

-- Nebula Dream, Volcanic Fury, Starfield have same thumbnail - fix each
UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800&q=80'
WHERE name = 'Nebula Dream';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
WHERE name = 'Volcanic Fury';

UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=800&q=80'
WHERE name = 'Starfield';

-- Monochrome and Retro have same thumbnail - fix Retro
UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&q=80'
WHERE name = 'Retro' AND type = 'theme';

-- Sunset and Twilight have same thumbnail - fix Twilight
UPDATE public.shop_items SET thumbnail_url = 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800&q=80'
WHERE name = 'Twilight' AND type = 'theme';
