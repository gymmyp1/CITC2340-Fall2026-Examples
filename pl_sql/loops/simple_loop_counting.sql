--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON

DECLARE
    v_counter INTEGER;
BEGIN
    v_counter := 0;
         LOOP
	    v_counter := v_counter + 1; 
    	EXIT WHEN v_counter = 5; 
    END LOOP;

    DBMS_output.put_line('v_counter: ' || v_counter);
END;
/