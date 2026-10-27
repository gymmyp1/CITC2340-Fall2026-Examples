CREATE OR REPLACE FUNCTION get_employees (p_deptno IN NUMBER)
  RETURN SYS_REFCURSOR
IS
  v_cur SYS_REFCURSOR;          -- no TYPE declaration needed
BEGIN
  OPEN v_cur FOR
    SELECT empno, ename, job, sal
    FROM   demo_emp
    WHERE  deptno = p_deptno;

  RETURN v_cur;                 -- caller is responsible for closing it
END get_employees;
/

-- A caller that fetches from it
-- This reuses one cursor variable for two different queries with different shapes, which a static cursor can’t do:
SET SERVEROUTPUT ON
DECLARE
  v_cur    SYS_REFCURSOR;
  v_ename  demo_emp.ename%TYPE;
  v_sal    demo_emp.sal%TYPE;
  v_deptno demo_dept.deptno%TYPE;
  v_dname  demo_dept.dname%TYPE;
  v_loc    demo_dept.loc%TYPE;
BEGIN
  -- First query: employees
  OPEN v_cur FOR SELECT ename, sal FROM demo_emp WHERE sal > 2000;
  LOOP
    FETCH v_cur INTO v_ename, v_sal;
    EXIT WHEN v_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_ename || ' earns ' || v_sal);
  END LOOP;
  CLOSE v_cur;

  -- Same variable, different table and shape
  OPEN v_cur FOR SELECT deptno, dname, loc FROM demo_dept;
  LOOP
    FETCH v_cur INTO v_deptno, v_dname, v_loc;
    EXIT WHEN v_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' - ' || v_dname || ' - ' || v_loc);
  END LOOP;
  CLOSE v_cur;
END;
/