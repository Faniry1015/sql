-- SQLite

-- CREATE TABLE recipes (
--     id INTEGER PRIMARY KEY AUTOINCREMENT,
--     title VARCHAR(150) NOT NULL,
--     slug VARCHAR(50) UNIQUE NOT NULL,
--     content TEXT,
--     duration SMALLINT,
--     online BOOLEAN,
--     created_at DATETIME
-- );

INSERT INTO recipes (title, slug, content, duration, online, created_at)
VALUES (
    'Soupe de poulet',
    'soupe-poulet',
    'La soupe de poulet est simple à faire, verser tous vos ingrédients dans la marmites et attendez 30 minutes.',
    30,
    1,
    DATETIME('now')
), (
    'Soupe de légumes',
    'soupe-legumes',
    'La soupe de légumes est simple à faire, verser tous vos ingrédients dans la marmites et attendez 10 minutes.',
    10,
    0,
    DATETIME('now')
),(
    'gratin de pattes',
    'gratin-pattes',
    'Le gratin de pattes est simple à faire, verser tous vos ingrédients dans la marmites et attendez 50 minutes.',
    50,
    1,
    DATETIME('now')
);
-- EXPLAIN QUERY PLAN SELECT * FROM recipes WHERE slug = 'soupe-poulet'; /* Index Scan on recipes using slug_idx */

-- PRAGMA index_list('recipes');
-- DROP INDEX idx_recipes_slug;

