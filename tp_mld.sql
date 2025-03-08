-- SQLite
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS recipes;

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
        title VARCHAR(150) NOT NULL,
    );

CREATE TABLE categories_recipes (
    recipe_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE NULL
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE NULL,
);