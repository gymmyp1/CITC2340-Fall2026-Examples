--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON

--Declare Record type
DECLARE
  TYPE EmpRecTyp IS RECORD (
    emp_id     NUMBER := 1,
    emp_fname  VARCHAR2(10) := 'Alice',
    mgr_id     NUMBER NOT NULL := 2,
    sal     NUMBER(6,0) NOT NULL := 50000
  );
 
  rec_emp EmpRecTyp;
BEGIN
  DBMS_OUTPUT.PUT_LINE('emp_id:   ' || rec_emp.emp_id);
  DBMS_OUTPUT.PUT_LINE('emp_name: ' || rec_emp.emp_fname);
  DBMS_OUTPUT.PUT_LINE('mgr_id:    ' || rec_emp.mgr_id);
  DBMS_OUTPUT.PUT_LINE('salary:    ' || rec_emp.sal);
END;
/