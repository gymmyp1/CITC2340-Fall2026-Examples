DROP TABLE product_price_audit;

-- Create product_price_audit table
CREATE TABLE product_price_audit ( 
	product_id INTEGER
	CONSTRAINT price_audit_fk_products
	REFERENCES products(product_id), 
	old_price NUMBER(5, 2), 
	new_price NUMBER(5, 2)
);

-- A trigger that records when a product’s price is lowered by more than 25 percent.
-- When this occurs, the trigger will add a row to the product_price_audit table. 

CREATE OR REPLACE TRIGGER before_product_price_update 
BEFORE UPDATE OF price 
ON products 
FOR EACH ROW WHEN (new.price < old.price * 0.75) 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('product_id = ' || :old.product_id); 
  DBMS_OUTPUT.PUT_LINE('Old price = ' || :old.price); 
  DBMS_OUTPUT.PUT_LINE('New price = ' || :new.price); 
  DBMS_OUTPUT.PUT_LINE('The price reduction is more than 25%'); 
 
  -- insert row into the product_price_audit table 
  INSERT INTO product_price_audit ( 
    product_id, old_price, new_price 
  ) VALUES ( 
    :old.product_id, :old.price, :new.price 
  ); 
END before_product_price_update; 
/

-- make the trigger fire for multiple products
UPDATE products
SET price = price * 0.7
WHERE product_id IN (5,10);