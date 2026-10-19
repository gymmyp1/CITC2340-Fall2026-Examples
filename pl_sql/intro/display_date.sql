-- PL/SQL program to display the current date

--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON

DECLARE
    todays_date DATE;
BEGIN
    todays_date := SYSDATE;
    -- escape a single quote within a string by using doubling it ('')
    DBMS_OUTPUT.PUT_LINE('Today''s date is ');
    DBMS_OUTPUT.PUT_LINE(todays_date);
END;
/