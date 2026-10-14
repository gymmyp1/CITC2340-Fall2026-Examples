CREATE VIEW cheap_products_view AS
SELECT *
FROM products
WHERE price < 15;

CREATE VIEW employees_view AS
SELECT employee_id, manager_id, first_name, last_name,title
FROM employees;

--query a view like you would a regular table
SELECT *
FROM employees_view;

-- You can perform DML statements on simple views

--Because cheap_products_view didn’t use WITH CHECK OPTION, 
-- you can insert, update, and delete rows that aren’t retrievable 
-- by the view. The following example inserts a row whose price 
-- is $16.50 (this is greater than $15 and therefore not retrievable 
-- by the view)
INSERT INTO cheap_products_view (
    product_id, product_type_id, name, price
) VALUES ( 
    13, 1, 'Western Front', 13.50
);


-- The employees_view contains a subquery that 
-- selects every column from employees except salary. 
--When you perform an INSERT using employees_view, 
--the salary column in the employees base table 
-- will be set to null.
INSERT INTO employees_view (
    emplmoyee_id, manager_id, first_name, last_name, title
) VALUES ( 
    5, 1, 'Jeff', 'Jones', 'CTO'
);

--If you try to query that row just inserted, the salary column
--will be null:
SELECT emplmoyee_id, first_name, last_name, salary
FROM employees
WHERE employee_id = 5;