-- Create the standalone procedure to return the minimum 
CREATE OR REPLACE PROCEDURE findMin (
    x IN NUMBER,
    y IN NUMBER,
    z OUT NUMBER
) AS
BEGIN
    IF x < y THEN
        z := x;
    ELSE
        z := y;
    END IF;
END findMin;
/
----------------------

-- Test the procedure
DECLARE
    a NUMBER := 23;
    b NUMBER := 45;
    c NUMBER;
BEGIN
    findMin(a, b, c);
    DBMS_OUTPUT.PUT_LINE('Minimum of (' || a || ', ' || b || ') : ' || c);
END;
/
