DISABLE PARALLEL DML;

DROP TABLE demo_emp2;

-- make a copy of the demo_emp table
CREATE TABLE demo_emp2 AS
SELECT *
FROM demo_emp;

DROP TABLE dept_transfers;

-- create the log table
CREATE TABLE dept_transfers (
    empno          NUMBER(6),
    ename          VARCHAR2(50),
    old_deptno     NUMBER(4),
    new_deptno     NUMBER(4),
    transfer_date  DATE
);

-- Trigger that logs a row whenever an employee changes departments.
CREATE OR REPLACE TRIGGER log_dept_transfers
AFTER UPDATE OF deptno ON demo_emp2
FOR EACH ROW
WHEN (OLD.deptno != NEW.deptno)
BEGIN
   INSERT INTO dept_transfers (empno, ename, old_deptno, new_deptno, transfer_date)
   VALUES (:OLD.empno, :OLD.ename, :OLD.deptno, :NEW.deptno, SYSDATE);
END;
/

-- Test it
UPDATE demo_emp2 SET deptno = 20 WHERE empno = 7499;
COMMIT;

UPDATE demo_emp2 SET sal = sal + 100 WHERE empno = 7369;  -- should NOT log
COMMIT;

SELECT * FROM dept_transfers;
