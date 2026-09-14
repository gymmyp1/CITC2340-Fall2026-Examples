--Coding summary queries
-- Single Row and Aggregate Functions, GROUP BY, HAVING

--Single Row functions Examples
-- Right pad name up to 30 spaces, pad with .
-- For price, pad 8 spaces and pad with *+
SELECT RPAD(name, 30, '.'), LPAD(price,8,'*+')
FROM products
WHERE product_id < 4;

--Substr functions
SELECT SUBSTR('Mary had a little lamb', 12, 6)
FROM dual;

--Example using column value
SELECT SUBSTR(name, 2, 7)
FROM products
WHERE product_id < 4;

--CAST function
SELECT CAST(12345.67 AS VARCHAR2(10)),       
CAST('9A4F' AS RAW(2)),       
CAST('05-JUL-07' AS DATE),       
CAST(12345.678 AS NUMBER(10,2))
FROM dual;

--TO_CHAR function
SELECT TO_CHAR(12345.67, '$99,999.99') 
FROM dual;

--TO_CHAR using table column
SELECT product_id,
     'The price of the product is ' || TO_CHAR(price, '$99.99')
FROM products 
WHERE product_id < 5;

--TO_DATE function

/*Result: 02/05/2017
-- 02 is month
-- 05 is day
2017 is year*/
SELECT TO_DATE('02/05/2017', 'MM DD YYYY')
FROM dual;

/*Result: 05/02/2017
05 is month
02 is day
2017 is year*/
SELECT TO_DATE('02/05/2017', 'DD MM YYYY')
FROM dual;        

--Complex date formatting using nested functions
SELECT TO_CHAR  
     (TO_DATE('Feb 14 2021’,'MON DD YYYY’), 'Month Day Year')
FROM dual;

--use TO_CHAR to format salary using a specific format mask
--FM will get rid of leading and trailing whitespace
-- L is local currency
SELECT first_name || ' '|| last_name || ' gets paid ' || TO_CHAR(salary, 'FML999,990.00') || '.'
FROM employees;

-- TO_DATE
--Convert string date to a specific DATE format
-- 2nd arg is the expected pattern
SELECT TO_DATE('July 4,2021', 'MONTH DD, YYYY')
FROM dual;

--'Month Day Year' will spell everything out
SELECT TO_CHAR(TO_DATE('July 4,2021', 'MONTH DD, YYYY'), 'Month Day Year')
FROM dual;

--Use the ROUND function to round an average to 2 decimal places
SELECT 'All sales' AS selected_all_sales, ROUND(AVG(amount), 2) AS avg_sale_amt
FROM all_sales

----------------------------------------------------------------
-- Aggregate Functions Examples
--When using aggregate functions, the return value will be 
-- 1 row and 1 column, and the result is 1 value.

--Use the MIN and MAX functions
SELECT COUNT(*) AS number_of_sales, 
	MAX(amount) AS highest_amount, 
	MIN(amount) AS lowest_amount
FROM all_sales

--An error due to a non-aggregate column
SELECT MAX(amount), emp_id
FROM all_sales

--Use the COUNT(*), AVG, and SUM functions
SELECT COUNT(*) AS number_of_sales,
       AVG(amount) AS avg_sales_amt,
       SUM(amount) AS total_sales_amt
FROM all_sales;

--Use the DISTINCT keyword 
ELECT COUNT(DISTINCT vendor_id) AS number_of_vendors, 
	COUNT(vendor_id) AS number_of_all_sales, 
	AVG(amount) AS avg_invoice_amt, 
	SUM(amount) AS total_invoice_amt
FROM all_sales

-- Returns a count of all the rows in that table
-- useful bc you'll always at least get the primary key, 
-- which cannot be null.
--COUNT counts the number of non-null occurences 
-- across the rows in the selection
SELECT COUNT(*)
FROM products;

-- COUNT counts the number of non-null values in product_id column
SELECT COUNT(product_id)
FROM products;

-- Book TIP
--You should avoid using the asterisk character (*) with the 
--COUNT() function, as it might take longer for COUNT() to return 
--the result. Instead, you should use a column in the table or 
--use the ROWID pseudo column, which contains the internal 
--location of a row in the Oracle database.

--This returns 4 rows, since COUNT counts all the non-nulls.
SELECT COUNT(phone)
FROM customers;

--SUM
SELECT SUM(price)
FROM products;

--AVG
SELECT AVG(price)
FROM products;

--Variance- how far are you from the average 
--the square of the diff from the average
SELECT VARIANCE(price)
FROM products;


--STDDEV
SELECT STDDEV(price)
FROM products;

----------------------------------------------------------------
-- GROUP BY Examples

--show what the product_type_id is, count the number of
-- rows, but we're going to do it within each ID, instead of 
-- the entire table.
SELECT product_type_id, COUNT(product_id)
FROM products
GROUP BY product_type_id
ORDER BY product_type_id;

-- Get the average price of all products within each product type,
-- but only if the average price of that type is greater than 20
SELECT product_type_id, AVG(price)
FROM products
GROUP BY product_type_id
HAVING AVG(price) > 20;