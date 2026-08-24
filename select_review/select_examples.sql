--example of using dual table
SELECT 7+8
FROM dual;

-- select all columns from products table
SELECT *
FROM products;

-- order by ASCENDING (default)
SELECT *
FROM products
ORDER BY price;

-- order by DESCENDING
SELECT *
FROM products
ORDER BY price DESC;

-- select specific columns from products table
SELECT name, description
FROM products;

-- alias
SELECT name, description AS d
FROM products;

-- alias w/ messy arithmetic expression
SELECT name, price * (10+23) - 29837 AS e
FROM products;

--WHERE example: get only products with price > 15 AND product is a book
SELECT *
FROM products
WHERE price > 15 AND product_type_id = 1;

--WHERE example: get only products with price > 15 OR product is a book
SELECT *
FROM products
WHERE price > 15 OR product_type_id = 1;

--check if value is NULL
SELECT *
FROM products
WHERE product_type_id IS NULL;