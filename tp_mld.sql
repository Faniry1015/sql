-- SQLite
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS categories_recipes;

DROP TABLE IF EXISTS recipes;

DROP TABLE IF EXISTS categories;

DROP TABLE IF EXISTS users;

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
    recipes (title, slug, preparation, user_id)
VALUES
    ('Poulet', 'poulet', 'Cuisiner le poulet', 1),
    ('Steak', 'steak', 'Cuisiner le steak', 1),
    ('Poulet et Steak', 'poulet-et-steak', 'Cuisiner le poulet et le steak', 1),
    ('Poulet et Steak et fromage', 'poulet-et-steak-et-fromage', 'Cuisiner le poulet et le steak et le fromage', 1);

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