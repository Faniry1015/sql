-- SQLite
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS recipes_ingredients;

DROP VIEW IF EXISTS v_recipes;

DROP TABLE IF EXISTS ingredients;

DROP TABLE IF EXISTS recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS users;

DROP TRIGGER IF EXISTS update_ingredient_count_on_insert;

CREATE TABLE
    users (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username VARCHAR(150) NOT NULL UNIQUE,
        email VARCHAR(150) NOT NULL UNIQUE
    );

CREATE TABLE
    recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(150) NOT NULL,
        slug VARCHAR(50) NOT NULL,
        preparation TEXT DEFAULT 'pas besoin de préparer',
        duration INTEGER DEFAULT 10,
        date DATETIME DEFAULT CURRENT_TIMESTAMP,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    );

CREATE TABLE
    categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title VARCHAR(150) NOT NULL
    );

CREATE TABLE
    categories_recipes (
        recipe_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE,
        PRIMARY KEY (recipe_id, category_id),
        UNIQUE (recipe_id, category_id)
    );

CREATE TABLE
    ingredients (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title VARCHAR(150) NOT NULL
    );

CREATE TABLE
    recipes_ingredients (
        recipe_id INTEGER NOT NULL,
        ingredient_id INTEGER NOT NULL,
        quantity INTEGER,
        unit VARCHAR(20),
        FOREIGN KEY (recipe_id) REFERENCES recipes (id) ON DELETE CASCADE,
        FOREIGN KEY (ingredient_id) REFERENCES ingredients (id) ON DELETE CASCADE,
        PRIMARY KEY (recipe_id, ingredient_id),
        UNIQUE (recipe_id, ingredient_id)
    );

INSERT INTO
    users (username, email)
VALUES
    ('John Doe', 'john@doe.fr');

INSERT INTO
    categories (title)
VALUES
    ('entrée'),
    ('plat'),
    ('dessert');

INSERT INTO
    recipes (title, slug, preparation, duration, user_id)
VALUES
    ('Poulet', 'poulet', 'Cuisiner le poulet', 30, 1),
    ('Steak', 'steak', 'Cuisiner le steak', 50, 1),
    (
        'Poulet et Steak',
        'poulet-et-steak',
        'Cuisiner le poulet et le steak',
        5,
        1
    ),
    (
        'Poulet et Steak et fromage',
        'poulet-et-steak-et-fromage',
        'Cuisiner le poulet et le steak et le fromage',
        30,
        1
    );

INSERT INTO
    ingredients (title)
VALUES
    ('poulet'),
    ('steak'),
    ('fromage'),
    ('laitue'),
    ('pomme'),
    ('farine');

INSERT INTO
    categories_recipes (recipe_id, category_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 1),
    (3, 2),
    (4, 1),
    (4, 2),
    (4, 3);

INSERT INTO
    recipes_ingredients (recipe_id, ingredient_id, quantity, unit)
VALUES
    (1, 1, 2, 'pcs'),
    (2, 2, 3, 'kg'),
    (3, 1, 3, 'kg'),
    (3, 2, 10, 'T'),
    (4, 1, 6, 'pcs'),
    (4, 2, 6, 'pcs'),
    (4, 3, 1, 'kg');

UPDATE recipes_ingredients
SET
    quantity = 111
WHERE
    recipe_id = 2
    AND ingredient_id = 2;

SELECT
    r.title,
    i.title,
    ri.quantity,
    ri.unit
FROM
    recipes r
    JOIN recipes_ingredients ri ON ri.recipe_id = r.id
    JOIN ingredients i ON ri.ingredient_id = i.id
WHERE
    r.title = 'Poulet et Steak et fromage';

SELECT COUNT(id) as count, duration FROM recipes GROUP BY (duration) HAVING count >= 2; /* having c'est comme where mais qui s'éxécute après l'aggrégation si where erreur car s'effectue avant */

SELECT DISTINCT i.title
FROM ingredients i
LEFT JOIN recipes_ingredients ri ON ri.ingredient_id = i.id
LEFT JOIN recipes r ON r.id = ri.recipe_id;
/* DISTINCT: groupant les doublons, interessant sur une seule colonne*/


SELECT r.title, r.duration
FROM recipes r
ORDER BY duration ASC, r.title ASC 
LIMIT 3 OFFSET 3;
/* ORDER BY: duration puis titre, OFFSET: commence à partir de l'élément 3*/

/*Sous requêtes*/
SELECT  *, (
    SELECT COUNT(*)
    FROM recipes_ingredients ri
    WHERE r.id = ri.ingredient_id
) AS nbr_ingredients
FROM recipes r;

SELECT r.count
FROM(
    SELECT COUNT(id) as count FROM recipes
) r;

/* Lister tous les ingredients qui ne sont pas utiliser dans "entrée" et "plat"*/
SELECT i.*
FROM recipes_ingredients ri 
LEFT JOIN ingredients i ON i.id = ri.ingredient_id
WHERE ri.recipe_id IN (
    SELECT cr.recipe_id
    FROM categories c 
    LEFT JOIN categories_recipes cr ON c.id = cr.category_id
    WHERE c.title NOT IN ('entrée', 'plat')
);

BEGIN TRANSACTION;
SELECT * FROM recipes;
DELETE FROM recipes WHERE id = 1;
SELECT * FROM recipes;
COMMIT TRANSACTION;
/*ROOLBACK TRANSACTION si satisfait, il y a un rollback automatique en cas d'erreur*/
SELECT * FROM recipes;

-- Vues
CREATE VIEW v_recipes
AS
    SELECT r.title, GROUP_CONCAT(i.title, ', ') AS liste_ingredients
    FROM recipes r 
    LEFT JOIN recipes_ingredients ri ON ri.recipe_id = r.id
    LEFT JOIN ingredients i ON ri.ingredient_id = i.id
    GROUP BY r.title;

ALTER TABLE ingredients
ADD COLUMN usage_count INTEGER DEFAULT 0;

CREATE TRIGGER update_ingredient_count_on_insert
AFTER INSERT ON recipes_ingredients
BEGIN
    UPDATE ingredients
    SET usage_count = usage_count + 1
    WHERE id = NEW.ingredient_id
END;

SELECT * FROM sqlite_master WHERE type = 'trigger';

WITH temptable AS (
    
)
