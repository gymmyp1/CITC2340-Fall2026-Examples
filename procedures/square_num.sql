-- This procedure computes the square of value of a passed value. 
-- This example shows how we can use the same parameter to accept 
-- a value and then return another result.
CREATE OR REPLACE PROCEDURE squareNum (
    x IN OUT NUMBER
)
AS
BEGIN
    x := x * x;
END;
/

-- Block to test the procedure
DECLARE
    a NUMBER := 5;
BEGIN
    squareNum(a);
    DBMS_OUTPUT.PUT_LINE('Square of (5): ' || a);
END;
/
