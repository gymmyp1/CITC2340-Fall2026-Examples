-- The following example creates a package named product_package (included in the script that loads the Store Schema).

--Create package specification
CREATE OR REPLACE PACKAGE product_package AS 

	--declare a REF CURSOR type named t_cursor (this has no return
	--type and can therefore be run by any query)
    TYPE t_ref_cursor IS REF CURSOR;
	
    FUNCTION get_products_ref_cursor RETURN t_ref_cursor;
	
    PROCEDURE update_product_price (
        p_product_id IN products.product_id%TYPE,
        p_factor	IN NUMBER 
    );
    
END product_package;
/

--Create package body
CREATE OR REPLACE PACKAGE BODY product_package AS 

-- The get_products_ref_cursor() function returns a t_ref_cursor, 
-- which contains the rows retrieved from the products table.
FUNCTION get_products_ref_cursor 
    RETURN t_ref_cursor 
AS
    c_products_ref_cursor t_ref_cursor;
BEGIN
    -- get the REF CURSOR
    OPEN c_products_ref_cursor FOR 
    SELECT product_id, name, price
    FROM products;
    
    -- return the REF CURSOR
    RETURN c_products_ref_cursor; 
END get_products_ref_cursor;

-- The update_product_price() procedure multiplies the price of a product and commits the change.
PROCEDURE update_product_price ( 
    p_product_id IN products.product_id%TYPE,
    p_factor	IN NUMBER
    )
AS 
    v_product_count INTEGER;
BEGIN 
    -- count the # of products w/ the supplied product_id 
    -- (count will be 1 if the product exists) 
    SELECT COUNT(*) 
    INTO v_product_count 
    FROM products 
    WHERE product_id = p_product_id;

    -- if the product exists (v_product_count = 1) then 
    -- update that product's price 
    IF v_product_count = 1 THEN
        UPDATE products 
        SET price = price * p_factor 
        WHERE product_id = p_product_id; 
        COMMIT;
    END IF; 
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
END update_product_price; 

END product_package;
/