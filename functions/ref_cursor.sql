-- strongly typed REF CURSOR example
DECLARE
  -- The RETURN clause declares the row structure that every query opened through this cursor type must produce.
  TYPE emp_cur_t IS REF CURSOR RETURN demo_emp%ROWTYPE;

  --alternatively, you could use a weakly typed REF CURSOR without the RETURN clause
  -- The weakly typed REF CURSOR can be used to open queries with different row structures, unlike the strongly typed one.
  -- TYPE emp_cur_t IS REF CURSOR;  -- no RETURN clause
  v_cur emp_cur_t;
  v_emp demo_emp%ROWTYPE;
BEGIN
  OPEN v_cur 
    FOR SELECT * 
    FROM demo_emp 
    WHERE deptno = 20;
  FETCH v_cur INTO v_emp;
  DBMS_OUTPUT.PUT_LINE(v_emp.ename);
  CLOSE v_cur;
END;
/