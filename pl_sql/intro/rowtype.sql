--Enable display of output from DBMS_OUTPUT.PUT_LINE calls
SET SERVEROUTPUT ON;

--Declare Record using %ROWTYPE
DECLARE
  rec_emp employees%ROWTYPE;
BEGIN
  -- Assign values to fields:
  rec_emp.employee_id   := 1;
  rec_emp.first_name    := 'Alice';
  rec_emp.manager_id    := 2;
  rec_emp.salary        := 50000;
 
  -- Print fields:
 
  DBMS_OUTPUT.PUT_LINE('emp_id:   ' || rec_emp.employee_id);
  DBMS_OUTPUT.PUT_LINE('emp_first_name: ' || rec_emp.first_name);
  DBMS_OUTPUT.PUT_LINE('mgr_id:    ' || rec_emp.manager_id);
  DBMS_OUTPUT.PUT_LINE('salary:    ' || rec_emp.salary);
END;
/
