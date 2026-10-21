-- demos usage of NO_DATA_FOUND exception.
--this exception is raised when a SELECT INTO statement returns no rows
DECLARE
    v_employee_name VARCHAR2(100);
BEGIN
    SELECT first_name || ' ' || last_name
        INTO v_employee_name
        FROM employees
        WHERE employee_id = 9999; -- Assuming employee_id 9999 does not exist
        
    DBMS_OUTPUT.PUT_LINE('Employee found: ' || v_employee_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with the given ID.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred.');
END;
/