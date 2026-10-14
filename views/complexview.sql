-- Create a view called product_details that contains info from
-- the products and product_types tables
CREATE VIEW product_details AS
SELECT p.product_id, p.name, pt.name AS product_type_name
FROM products p JOIN product_types pt
ON p.product_type_id = pt.product_type_id;

