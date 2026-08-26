-- Module 1 Examples SELECTS and DESCRIBE
--Uses Store Schema

--Show metadata/table structure for products table
DESCRIBE products;

-- Returns the current system date and time of the database server
SELECT SYSDATE
FROM dual;

------------------------------------------------------

-- Example: DISTINCT to get unique values
SELECT DISTINCT product_type_id
FROM products;

------------------------------------------------------
--Example: Concatentation
SELECT first_name || ' works as ' || title AS Employees
FROM employees;
--Why wingle quotes for ' works as '?
-- Single quotes '...' are used for string literals (actual text values).
-- Double quotes "..." are used for identifiers (column names, table names, or certain aliases).

------------------------------------------------------

-- ORDER BY, different ways to sort

--Sort by an alias
SELECT last_name || ', ' || first_name,
    salary + (salary*0.1) AS bonus
FROM employees
ORDER BY bonus

--Sort by an expression
SELECT last_name || ', ' || first_name || ' ' || 
        title
FROM employees
ORDER BY last_name || 
         first_name;
		 
-- Sort by column positions, sort by bonus first, then manager_id
SELECT last_name || ', ' || first_name,
    salary + (salary*0.1) AS bonus, manager_id
FROM employees
ORDER BY 2,1
------------------------------------------------------

-- Example: LIKE
-- This query retireves all employees where their first name starts with 'R'
-- followed 0 or more characters OR
-- the empoloyee's title starts with the substring 'Sales' followed by 0 or more characters.
SELECT *
FROM employees
WHERE first_name LIKE 'R%' OR title LIKE 'Sales%';


-- This query retireves all customers where their first name is any 
-- single character followed by an o, then any number of characters.
SELECT *
FROM customers
WHERE first_name LIKE '_o%'


------------------------------------------------------

--Example: COUNT to return the number of total rows in a table regardless of whether they contain missing (NULL) data
SELECT COUNT(*) AS total_products 
FROM products;

-- Counts only the rows where the specific column is not null
SELECT COUNT(product_type_id) AS products_w_type
FROM products;

--Counts the total number of unique, non-null values inside a column
SELECT COUNT(DISTINCT product_type_id) AS number_of_unique_prod_types
FROM products;

------------------------------------------------------
--BETWEEN Usage
SELECT *
FROM orders
WHERE order_date BETWEEN '01-MAR-2022' AND '30-MAR-2022';

-- Get everything not within the specified range
SELECT *
FROM orders
WHERE order_date NOT BETWEEN '01-MAR-2022' AND '30-MAR-2022';

------------------------------------------------------
--IN Usage
SELECT *
FROM employees
WHERE title IN ('CEO', 'Salesperson');

-- Equivalent using OR:
SELECT *
FROM employees
WHERE title = 'CEO' OR title = 'Salesperson';

------------------------------------------------------
--Row Limiting

-- Fetch the first 3 rows of products
SELECT product_id, price
FROM products
FETCH FIRST 3 ROWS ONLY;

-- Skip 2 rows then get the next three rows
SELECT product_id, price
FROM products
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

-- Sort the table before limiting the rows returned
SELECT product_id, price
FROM products
ORDER BY price DESC
FETCH FIRST 5 ROWS ONLY
