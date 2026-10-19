SET SERVEROUTPUT ON

DECLARE
  v_count INTEGER := 42;
  v_message VARCHAR(30);
BEGIN
  
  IF v_count > 0 THEN
    v_message := 'v_count is positive';
  ELSIF v_count = 0 THEN
    v_message := 'v_count is zero';
  ELSE
    v_message := 'v_count is negative';
  END IF;
  DBMS_OUTPUT.PUT_LINE (v_message);
END;
/
