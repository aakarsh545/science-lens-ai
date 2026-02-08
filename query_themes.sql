SELECT name, rarity, thumbnail_url
FROM public.shop_items
WHERE type = 'theme'
ORDER BY
  CASE
    WHEN rarity = 'common' THEN 1
    WHEN rarity = 'rare' THEN 2
    WHEN rarity = 'epic' THEN 3
    WHEN rarity = 'legendary' THEN 4
    WHEN rarity = 'mythical' THEN 5
  END,
  name;
