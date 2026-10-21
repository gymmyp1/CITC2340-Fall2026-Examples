--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON;

DECLARE
    -- 1. Declare the cursor in the declaration section, tying it to a SELECT statement:
    CURSOR c_emp IS
    SELECT empno, ename, sal
    FROM   demo_emp
    WHERE  deptno = 10;

    -- Declare variables (or a %ROWTYPE record) to hold each fetched row:
    v_emp c_emp%ROWTYPE;
BEGIN
    -- Open the cursor. This runs the query and identifies the result set (the “active set”):
    OPEN c_emp;

    LOOP
        /* Fetch rows from the cursor, one at a time, into variables or a record.
        Exit when no more rows are found: */
        FETCH c_emp INTO v_emp;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.ename || ': ' || v_emp.sal);

        -- Close the cursor to release the memory and resources it holds:
        END LOOP;
    CLOSE c_emp;
END;
/