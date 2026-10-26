-- Procedure that accepts an optional parameter

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE my_procedure (
    p_required_param VARCHAR2,
    p_optional_param NUMBER DEFAULT 0 -- Optional parameter with a default value of 0
)
AS
BEGIN
    -- Procedure logic here
    DBMS_OUTPUT.PUT_LINE('Required param: ' || p_required_param);
    DBMS_OUTPUT.PUT_LINE('Optional param: ' || p_optional_param);
END;
/

-- Test procedure by providing optional parameter
BEGIN
    my_procedure('Hello', 10); -- Providing a value for p_optional_param
END;
/

-- Test procedure by providing only required parameter
BEGIN
    my_procedure('Hello');
END;
/