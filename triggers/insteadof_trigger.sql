--Example adapted from https://www.geeksforgeeks.org/plsql/pl-sql-instead-of-triggers/

-- Create a view called product_details that contains info from
-- the products and product_types tables

CREATE VIEW product_details AS
SELECT p.product_id, p.name, pt.name AS product_type_name
FROM products p JOIN product_types pt
ON p.product_type_id = pt.product_type_id;

-- To allow INSERT operations on the product_details view, create an INSTEAD OF trigger
-- that handles mapping the product type

CREATE OR REPLACE TRIGGER product_details_insert_trigger
INSTEAD OF INSERT ON product_details
FOR EACH ROW
BEGIN
   -- :NEW refers to the values being inserted into the view,
   -- i.e., the data that triggered the event.
   INSERT INTO products (product_id, name, product_type_id)
   VALUES (:NEW.product_id, :NEW.name,
           (SELECT product_type_id FROM product_types WHERE name = :NEW.product_type_name));
END;

--Insert a new product of type Video
INSERT INTO product_details (product_id, name, product_type_name)
VALUES (104, 'Stray Cats Iceberg', 'Video');


/* This results in a row being inserted into the products table with values:
product_id: 104
product_type_id: 2
name: Stray Cats Iceberg

Although the INSERT INTO only provides the product_type_name,
The trigger handles the logic of using the type name to get the 
product type id before inserting the row.
*/