SET SERVEROUTPUT ON;
BEGIN
  FOR product_row IN (SELECT product_id, name, price FROM products ORDER BY product_id) LOOP
        DBMS_OUTPUT.PUT_LINE(
			'product_id = ' || product_row.product_id || 
			', name = ' || product_row.name || 
			', price = ' || product_row.price
		);
  END LOOP;
END;
/