CREATE OR REPLACE FUNCTION factorial(x NUMBER)
  RETURN NUMBER
IS
  f NUMBER;
BEGIN
  IF x = 0 THEN
    f := 1;
  ELSE
    f := x * factorial(x - 1);
  END IF;
  RETURN f;
END;

-- show how a function's return value can be used in an anonymous block
DECLARE
  num NUMBER;
  result NUMBER;
BEGIN
  num := 5;
  result := factorial(num);
  DBMS_OUTPUT.PUT_LINE('Factorial of ' || num || ' is ' || result);
END;


-- Same thing with a procedure:
CREATE OR REPLACE PROCEDURE factorial_p(x IN NUMBER, f OUT NUMBER) IS
BEGIN
  IF x = 0 THEN
    f := 1;
  ELSE
    factorial_p(x - 1, f);
    f := x * f;
  END IF;
END;
/

DECLARE
  result NUMBER;
BEGIN
  factorial_p(5, result);   -- result is assigned *by the procedure*
  DBMS_OUTPUT.PUT_LINE(result);
END;
