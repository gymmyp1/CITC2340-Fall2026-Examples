set serveroutput on;

DECLARE
	v_counter INTEGER;
BEGIN
    v_counter := 0;
	
	WHILE v_counter < 6 LOOP
        DBMS_output.put_line('v_counter: ' || v_counter);
		v_counter := v_counter + 1; 
        
	END LOOP;

--v_counter was declared OUTSIDE of the loop, so it persists
    DBMS_output.put_line('v_counter: ' || v_counter);
END;
/