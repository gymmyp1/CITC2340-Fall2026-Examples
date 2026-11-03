CREATE OR REPLACE TRIGGER products_compound_trg
  FOR INSERT OR UPDATE ON products
  COMPOUND TRIGGER

  BEFORE EACH ROW IS
  BEGIN
    IF :NEW.price < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Price cannot be negative.');
    END IF;
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Products table was changed.');
  END AFTER STATEMENT;

END products_compound_trg;
/

-- Cause Compound Trigger to Fire
SET SERVEROUTPUT ON;

-- works, prints the message
INSERT INTO products (product_id, product_type_id, name, description, price)
VALUES (100, 1, 'Widget', 'A simple widget', 10.00);

-- fails with ORA-20001
INSERT INTO products (product_id, product_type_id, name, description, price)
VALUES (101, 1, 'Gadget', 'A simple gadget', -5.00);

