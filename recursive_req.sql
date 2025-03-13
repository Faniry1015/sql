CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE CASCADE
);

INSERT INTO categories
VALUES (1, 'Mammifère', NULL),
       (2, 'Chien', 1),
       (3, 'Chat', 1),
       (4, 'Singe', 1),
       (5, 'Gorille', 4),
       (6, 'Chimpanzé', 4),
       (7, 'Shiba', 2),
       (8, 'Corgi', 2),
       (9, 'Labrador', 2),
       (10, 'Poisson', NULL),
       (11, 'Requin', 10),
       (12, 'Requin blanc', 11),
       (13, 'Grand requin blanc', 12),
       (14, 'Petit requin blanc', 12),
       (15, 'Requin marteau', 11),
       (16, 'Requin tigre', 11),
       (17, 'Poisson rouge', 10),
       (18, 'Poisson chat', 10);

WITH
  cte1 AS (SELECT a, b FROM table1),
  cte2 AS (SELECT c, d FROM table2)
SELECT b, d FROM cte1 JOIN cte2
WHERE cte1.a = cte2.c;

WITH RECURSIVE categories_tree AS (
    SELECT id, name, parent_id FROM categories WHERE id = 14 /* On récupère la catégorie en profondeur */
    UNION ALL
    SELECT c.id, c.name, c.parent_id FROM categories c, categories_tree WHERE c.id = categories_tree.parent_id
)
SELECT * FROM categories_tree

WITH RECURSIVE children (id, name, parent_id, level, path) AS (
    SELECT id, name, parent_id, 0, name FROM categories WHERE parent_id IS NULL
    UNION ALL
    SELECT 
        c.id,
        c.name, 
        c.parent_id, 
        children.level + 1,
        children.path || " > " || c.name
    FROM categories c, children
    WHERE c.parent_id = children.id
)
SELECT * FROM children