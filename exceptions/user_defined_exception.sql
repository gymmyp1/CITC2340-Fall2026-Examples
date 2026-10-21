-- User defined Exception example
SET SERVEROUTPUT ON

DECLARE	
	e_exception_name EXCEPTION;
	flag INTEGER := 1;
BEGIN
	IF flag = 1 THEN
		RAISE e_exception_name;
	END IF;
EXCEPTION
	WHEN e_exception_name THEN
		DBMS_OUTPUT.PUT_LINE('Exception caught.');
END;
/