-- Displays the product_id, name, and price columns 
-- from the products table using a cursor and a FOR loop

-- Explicit Cursor with FOR Loop.

SET SERVEROUTPUT ON;

DECLARE 
	CURSOR v_product_cursor IS
		SELECT product_id, name, price
		FROM products
		ORDER BY product_id; 
BEGIN
	--The FOR ... IN cursor loop handles open, fetch, and close automatically
	FOR v_product IN v_product_cursor LOOP 
		DBMS_OUTPUT.PUT_LINE(
			'product_id = ' || v_product.product_id || 
			', name = ' || v_product.name || 
			', price = ' || v_product.price
		); 
	END LOOP;
END; 
/