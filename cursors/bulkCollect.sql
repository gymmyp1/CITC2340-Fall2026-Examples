-- This script displays the product_id, name, and price columns
-- from the products table using BULK COLLECT with LIMIT

SET SERVEROUTPUT ON

DECLARE
  -- Declare the cursor
  CURSOR v_product_cursor IS
    SELECT product_id, name, price
    FROM products
    ORDER BY product_id;

  -- Define a custom collection type that uses the cursor's row type for each element
  TYPE product_table_type IS TABLE OF v_product_cursor%ROWTYPE;
  v_products product_table_type;

  -- How many rows to fetch per batch (try changing this to a low number like 2 or 3 to see the effect)
  c_batch_size INTEGER := 100;
BEGIN
  OPEN v_product_cursor;
  LOOP
    -- Fetch up to 100 rows at a time into the collection
    FETCH v_product_cursor
      BULK COLLECT INTO v_products
      LIMIT c_batch_size;

    -- Display the batch size
    --DBMS_OUTPUT.PUT_LINE('--- batch of ' || v_products.COUNT || ' ---');

    -- Exit when the batch is empty
    EXIT WHEN v_products.COUNT = 0;

    -- Process each row in this batch
    FOR i IN 1 .. v_products.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE(
        'v_product_id = ' || v_products(i).product_id ||
        ', v_name = ' || v_products(i).name ||
        ', v_price = ' || v_products(i).price);
    END LOOP;
  END LOOP;
  CLOSE v_product_cursor;
END;
/