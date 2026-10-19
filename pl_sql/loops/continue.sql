--CONTINUE example
DECLARE
	v_counter INTEGER;
    a_counter INTEGER;
BEGIN
    v_counter := 0;
    a_counter := 0;
    LOOP
	    -- after the CONTINUE statement is executed, control returns here 
	    v_counter := v_counter + 1; 
	    IF v_counter = 3 THEN
		    CONTINUE; -- end current iteration unconditionally 
	    END IF;
        a_counter := a_counter + 1;
    	EXIT WHEN v_counter = 5; 
    END LOOP;

    DBMS_output.put_line('v_counter: ' || v_counter);
    DBMS_output.put_line('a_counter: ' || a_counter);
END;
/

