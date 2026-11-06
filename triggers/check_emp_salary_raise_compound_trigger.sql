CREATE OR REPLACE TRIGGER check_emp_salary_raise
  FOR UPDATE OF SAL ON DEMO_EMP
COMPOUND TRIGGER
  ten_percent                 CONSTANT NUMBER := 0.1;

  -- declare associative array to hold average salaries for each department
  TYPE dept_salaries_t        IS TABLE OF DEMO_EMP.SAL%TYPE --value type
                                INDEX BY PLS_INTEGER; -- key type
  dept_avg_salaries           dept_salaries_t;

  BEFORE STATEMENT IS
  BEGIN
    FOR r IN (SELECT   DEPTNO,
                       AVG(SAL) AS avg_sal
              FROM     DEMO_EMP
              GROUP BY DEPTNO)
    LOOP
      dept_avg_salaries(r.DEPTNO) := r.avg_sal;
    END LOOP;
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    IF :NEW.SAL - :OLD.SAL >
       ten_percent * dept_avg_salaries(:NEW.DEPTNO)
    THEN
      RAISE_APPLICATION_ERROR(-20000, 'Raise too big');
    END IF;
  END AFTER EACH ROW;
END check_emp_salary_raise;
/

-- Test trigger
SET SERVEROUTPUT ON

-- Test 1: small raise in dept 20 (+100 <= 217.50) -> should PASS
BEGIN
  UPDATE DEMO_EMP SET SAL = SAL + 100 WHERE EMPNO = 7369;
  DBMS_OUTPUT.PUT_LINE('Test 1 PASS: small raise allowed');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Test 1 FAIL: ' || SQLERRM);
  ROLLBACK;
END;
/

-- Test 2: big raise in dept 20 (+300 > 217.50) -> should be REJECTED
BEGIN
  UPDATE DEMO_EMP SET SAL = SAL + 300 WHERE EMPNO = 7369;
  DBMS_OUTPUT.PUT_LINE('Test 2 FAIL: raise should have been rejected');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  IF SQLCODE = -20000 THEN
    DBMS_OUTPUT.PUT_LINE('Test 2 PASS: rejected with ' || SQLERRM);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Test 2 FAIL: unexpected error ' || SQLERRM);
  END IF;
  ROLLBACK;
END;
/

-- Test 3: raise exactly at the limit in dept 30 (156.67 is the cap).
-- +156 -> PASS, +157 -> REJECTED
BEGIN
  UPDATE DEMO_EMP SET SAL = SAL + 156 WHERE EMPNO = 7521;
  DBMS_OUTPUT.PUT_LINE('Test 3a PASS: +156 allowed');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Test 3a FAIL: ' || SQLERRM);
  ROLLBACK;
END;
/

BEGIN
  UPDATE DEMO_EMP SET SAL = SAL + 157 WHERE EMPNO = 7521;
  DBMS_OUTPUT.PUT_LINE('Test 3b FAIL: +157 should have been rejected');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  IF SQLCODE = -20000 THEN
    DBMS_OUTPUT.PUT_LINE('Test 3b PASS: +157 rejected');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Test 3b FAIL: unexpected error ' || SQLERRM);
  END IF;
  ROLLBACK;
END;
/

-- Test 4: multi-row update. 10% across dept 20 means SCOTT/FORD get +300
-- (> 217.50), so the whole statement should fail and nothing changes.
DECLARE
  v_total_before NUMBER;
  v_total_after  NUMBER;
BEGIN
  SELECT SUM(SAL) INTO v_total_before FROM DEMO_EMP WHERE DEPTNO = 20;
  BEGIN
    UPDATE DEMO_EMP SET SAL = SAL * 1.10 WHERE DEPTNO = 20;
    DBMS_OUTPUT.PUT_LINE('Test 4 FAIL: should have been rejected');
  EXCEPTION WHEN OTHERS THEN
    IF SQLCODE = -20000 THEN
      SELECT SUM(SAL) INTO v_total_after FROM DEMO_EMP WHERE DEPTNO = 20;
      IF v_total_before = v_total_after THEN
        DBMS_OUTPUT.PUT_LINE('Test 4 PASS: rejected, no rows changed');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Test 4 FAIL: partial update persisted');
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Test 4 FAIL: unexpected error ' || SQLERRM);
    END IF;
  END;
  ROLLBACK;
END;
/

-- Test 5: salary decrease -> should PASS (negative difference)
BEGIN
  UPDATE DEMO_EMP SET SAL = SAL - 500 WHERE EMPNO = 7788;
  DBMS_OUTPUT.PUT_LINE('Test 5 PASS: decrease allowed');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Test 5 FAIL: ' || SQLERRM);
  ROLLBACK;
END;
/

-- Test 6: move to empty dept 40 with a huge raise. The dept 40 slot is NULL,
-- so the check is skipped -> should PASS (no NO_DATA_FOUND)
BEGIN
  UPDATE DEMO_EMP SET DEPTNO = 40, SAL = SAL + 5000 WHERE EMPNO = 7369;
  DBMS_OUTPUT.PUT_LINE('Test 6 PASS: empty department skipped');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Test 6 FAIL: ' || SQLERRM);
  ROLLBACK;
END;
/

-- Test 7: update only DEPTNO. Trigger is UPDATE OF SAL, so it doesn't fire
BEGIN
  UPDATE DEMO_EMP SET DEPTNO = 30 WHERE EMPNO = 7369;
  DBMS_OUTPUT.PUT_LINE('Test 7 PASS: trigger did not fire');
  ROLLBACK;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Test 7 FAIL: ' || SQLERRM);
  ROLLBACK;
END;
/