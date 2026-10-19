set serveroutput on;

--Numeric FOR loop
BEGIN
--v_counter is destroyed once loop exits
	FOR v_counter IN 1..5 LOOP 
		DBMS_OUTPUT.PUT_LINE(v_counter);
	END LOOP;
END;
/

/* CAUTION: the v_counter2 in the DECLARE section is a different 
variable than the v_counter2 declared in the FOR loop.
PL/SQL resolves a name by looking in the innermost scope first, 
then moving outward until it finds a match.
https://docs.oracle.com/en/database/oracle/oracle-database/26/lnpls/scope-and-visibility-identifiers.html
THIS IS A BAD IDEA TO HAVE IN THE FIRST PLACE.
*/

--Numeric FOR loop
DECLARE
	v_counter2 INTEGER;
BEGIN
	FOR v_counter2 IN 1..5 LOOP 
		DBMS_OUTPUT.PUT_LINE(v_counter2);
	END LOOP;

    DBMS_output.put_line('v_counter2: ' || v_counter2);
END;
/