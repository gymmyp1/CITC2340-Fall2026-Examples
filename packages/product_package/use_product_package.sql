-- Demo how to use product_package functionality

DECLARE 
	-- step 1: declare the variables to fetch product data into
	v_product_id products.product_id%TYPE; 
	v_name	products.name%TYPE; 
	v_price	products.price%TYPE;

	-- step 2: declare the cursor variable
	-- t_ref_cursor is a weak REF CURSOR type (a pointer to any query’s result set) 
	-- defined in product_package.
	c_product_cursor product_package.t_ref_cursor;

BEGIN
	-- step 3: get the cursor from the package function.
	-- The function opens the cursor, so there is no need to open it here.
	c_product_cursor := product_package.get_products_ref_cursor;

	LOOP 
		-- step 4: fetch the rows from the cursor, one row at a time
		FETCH c_product_cursor 
		INTO v_product_id, v_name, v_price;
		EXIT WHEN c_product_cursor%NOTFOUND;
		
		-- use DBMS_OUTPUT.PUT_LINE() to display the variables 
		DBMS_OUTPUT.PUT_LINE(
			'v_product_id = ' || v_product_id || ', v_name = ' || 
			 v_name || ', v_price = ' || v_price );
	END LOOP;

	-- step 5: close the cursor (the caller is responsible for closing it,
	-- since the function had to leave it open to return it)
	CLOSE c_product_cursor; 
END;
/

-- Example of calling the update_product_price() procedure inside the package.
-- This multiplies the price of product 3 by 1.25 (a 25% increase):
CALL product_package.update_product_price(3, 1.25);