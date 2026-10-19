--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON

\--Record with VARRAY example
DECLARE
  TYPE full_name IS VARRAY(2) OF VARCHAR2(20);
 
  TYPE emp_name IS RECORD (
    name  full_name := full_name('John', 'Smith')  -- varray field
  );
 
  emp_rec emp_name;
BEGIN

  DBMS_OUTPUT.PUT_LINE (
    emp_rec.name(1) || ' ' || emp_rec.name(2)
    );
END;
/
