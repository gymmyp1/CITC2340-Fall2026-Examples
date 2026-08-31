--SQL/86 syntax: Inner join Products and Product_Types tables using product_type_id column
SELECT *
FROM orders, addresses
WHERE products.product_type_id = product_types.product_type_id;

--Same query using SQL/92 syntax
SELECT *
FROM products JOIN product_types
ON products.product_type_id = product_types.product_type_id;


--Join Orders and Addresses using ship_address_id
SELECT ship_address_id, address_id
FROM orders, addresses
WHERE ship_address_id = address_id;

--Non-equijoin example: display each employee with respective salary grade
SELECT e.first_name, e.last_name, e.title, e.salary, sg.salary_grade_id
FROM employees e, salary_grades sg
WHERE salary BETWEEN sg.low_salary AND sg.high_salary
ORDER BY salary_grade_id;

--Multi-table join
--Display customer information alongside their purchases (name and qty), with the product type name
SELECT c.first_name, c.last_name, p.name, pr.quantity, pt.name
FROM customers c, purchases pr, products p, product_types pt
WHERE c.customer_id = pr.customer_id 
    AND p.product_id = pr.product_id 
    AND p.product_type_id = pt.product_type_id 
ORDER BY c.last_name;

-----------------------------------------------------------
--SQL/86 vs SQL/92 syntax

--Inner join
-- SQL/86 syntax
SELECT *
FROM products, product_types
WHERE products.product_type_id = product_types.product_type_id;
-- SQL/92 syntax
SELECT *
FROM products [INNER] JOIN product_types
ON products.product_type_id = product_types.product_type_id;


--Left Outer Join
-- SQL/86 syntax
SELECT *
FROM products, product_types
WHERE products.product_type_id = product_types.product_type_id (+);
-- SQL/92 syntax
SELECT *
FROM products LEFT [OUTER] JOIN product_types
ON products.product_type_id = product_types.product_type_id;

--Right Outer Join
-- SQL/86 syntax
SELECT *
FROM products, product_types
WHERE products.product_type_id (+) = product_types.product_type_id;

-- SQL/92 syntax
SELECT *
FROM products RIGHT [OUTER] JOIN product_types
ON products.product_type_id = product_types.product_type_id;

--Full Outer Join
-- SQL/86 syntax
SELECT *
FROM products, product_types
WHERE products.product_type_id = product_types.product_type_id (+)
UNION
SELECT *
FROM products, product_types
WHERE products.product_type_id (+) = product_types.product_type_id;

-- SQL/92 syntax
SELECT *
FROM products FULL [OUTER] JOIN product_types
ON products.product_type_id = product_types.product_type_id;

--SQL/92 synatx: Multi table join
SELECT c.first_name, c.last_name, p.name, pr.quantity, pt.name
FROM customers c
INNER JOIN purchases pr
    ON c.customer_id = pr.customer_id
INNER JOIN products p
    ON p.product_id = pr.product_id
INNER JOIN product_types pt
    ON p.product_type_id = pt.product_type_id
ORDER BY c.last_name;

--JOIN USING
-- SQL/92 syntax
SELECT *
FROM products JOIN product_types
USING(product_type_id);

--SQL/92 syntax: Multi table join with USING
SELECT c.first_name, c.last_name, p.name, pr.quantity, pt.name
FROM customers c
INNER JOIN purchases pr
    USING (customer_id)
INNER JOIN products p
    USING (product_id)
INNER JOIN product_types pt
    USING (product_type_id)
ORDER BY c.last_name;

--Self join
SELECT w.first_name || ' ' || w.last_name || ' works for ' || m.first_name || ' ' || m.last_name
FROM employees w, employees m
WHERE w.manager_id = m.employee_id
ORDER BY w.first_name;

--Include employee with no manager
SELECT w.first_name || ' ' || w.last_name || ' works for ' ||
        NVL(m.first_name, 'no one') || ' ' ||
        NVL(m.last_name, '') AS employee_manager
FROM employees w
LEFT OUTER JOIN employees m
ON w.manager_id = m.employee_id
ORDER BY w.first_name;

