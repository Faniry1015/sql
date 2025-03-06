-- SQLite
DROP TABLE recipes;

DROP TABLE categories;

PRAGMA foreign_keys = ON;

CREATE TABLE
    IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title VARCHAR(50) NOT NULL,
        description TEXT
    );

CREATE TABLE
    IF NOT EXISTS recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title VARCHAR(150) NOT NULL,
        slug VARCHAR(50) UNIQUE NOT NULL,
        content TEXT,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
    );

INSERT INTO
    categories (title, description)
VALUES
    ('Plat', 'Plat principal'),
    ('Dessert', 'Dessert');

INSERT INTO
    recipes (title, slug, content, category_id)
VALUES
    (
        'Soupe de poulet',
        'soupe-poulet',
        'Voici comment on fait de la soupe de poulet',
        1
    ),
    (
        'crème anglaise',
        'creme-anglaise',
        'Voici comment on fait de la crème anglaise',
        2
    ),
    (
        'Salade de pattes',
        'tarte-pommes',
        'Voici comment on fait de la tarte aux pommes',
        1
    );

-- utilisation d'alias et de AS pour renomé l'entête de colonne
    SELECT r.title, r.content, c.title AS category 
    FROM recipes r
    LEFT JOIN categories c ON r.category_id = c.id;

    DELETE FROM categories WHERE id = 2;

    SELECT * FROM recipes r;
    LEFT JOIN categories c ON r.category_id = c.id