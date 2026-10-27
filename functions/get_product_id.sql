-- A function that returns the product ID that matches a product's name
CREATE OR REPLACE FUNCTION get_product_id (
product_name_param VARCHAR2
) RETURN NUMBER 
AS
	product_id_var NUMBER; 
BEGIN
	SELECT product_id INTO product_id_var 
	FROM products
	WHERE name = product_name_param; 

RETURN product_id_var;
END;

-- A SELECT statement that calls the function
SELECT * 
FROM products
WHERE product_id = get_product_id('Modern Science');