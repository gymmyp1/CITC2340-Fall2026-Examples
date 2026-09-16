-- Subqueries examples
-- Requires Store Schema, Demo tables

--return products with above-average prices
SELECT product_id, name, price
FROM products
WHERE price >     
	(SELECT AVG(price)      
	FROM products);

--  Example: Find coworkers in the same department as a particular employee.
SELECT ename
FROM demo_emp
WHERE deptno = 
	(SELECT deptno
	FROM demo_emp
	WHERE ename = 'TURNER');

-- How subqueries compare to joins

--Query that uses an inner join
SELECT product_id, p.name, price
FROM products p JOIN product_types pt
    ON p.product_type_id = pt.product_type_id
WHERE p.product_type_id = 2
ORDER BY p.name;

--The same query restated with a subquery
SELECT product_id, name, price
FROM products
WHERE product_type_id IN
	(SELECT product_type_id
    FROM product_types
    WHERE product_type_id = 2)
ORDER BY name;

--Multi-row subqueries
--Basic IN Usage
SELECT product_id, name, product_type_id
FROM products
WHERE product_type_id IN (1, 2, 3);
--Basic NOT IN Usage
SELECT product_id, name, product_type_id
FROM products
WHERE product_type_id NOT IN (1, 2, 3);

--Basic ANY Usage
SELECT product_id, name, price
FROM products
WHERE name = ANY ('Alpacas','Pop 3', 'Modern Science');

--Basic ALL Usage
SELECT product_id, name, price
FROM products
WHERE price > ALL (15, 20, 25);

-- Example: Return customers who have never placed an order using subquery + NOT IN
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM purchases
    WHERE customer_id IS NOT NULL
)
ORDER BY customer_id;

--A query that uses the NOT IN operator with a subquery can typically be restated using an outer join.
--The query restated without a subquery
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c LEFT JOIN purchases p
ON c.customer_id = p.customer_id
WHERE p.customer_id IS NULL
ORDER BY customer_id;

--Subqueries with the IN operator – Another example
-- return the product_id and name for products whose name contains the word ‘Science’
SELECT product_id, name
FROM products
WHERE product_id IN 
    (SELECT product_id
    FROM products
    WHERE name LIKE '%Science%');

--subquery + ANY
-- Example: find products that have been ordered at least once
SELECT product_id, name
FROM products
WHERE product_id = ANY
     (SELECT product_id  
	 FROM purchases) 
ORDER BY product_id;

--subquery + ALL
--Example: Find products that cost more than any item in the ‘Books' category.
SELECT name, price 
FROM products
WHERE price > ALL 
	(SELECT price 
	FROM products 
	WHERE product_type_id = 1);

--Incorrect Usage: The equals operator (=) can only compare against a single value, 
-- but the subquery returns multiple product_ids.
/*SELECT product_id, name
FROM products
WHERE product_id =     
	(SELECT product_id FROM products      
WHERE name LIKE '%e%');*/

--List all aircraft that have never been chartered using a subquery.
SELECT ac_number
FROM aircraft
WHERE product_id NOT IN    
	(SELECT ac_number 
	 FROM charter)
ORDER BY ac_number;

	
