-- Trigger Example #1

DROP TABLE dept_budget;

-- Create the department budget table
CREATE TABLE dept_budget (
    deptno    NUMBER(2) NOT NULL,
    total_sal NUMBER(10,2)
);

-- Insert the total salary of all employees per department
INSERT INTO dept_budget (deptno, total_sal)
SELECT deptno, SUM(sal)
FROM demo_emp
GROUP BY deptno;

-- Verify the data
SELECT * FROM dept_budget;

-- Create or replace trigger to maintain total salary in dept_budget
CREATE OR REPLACE TRIGGER total_salary
AFTER DELETE OR INSERT OR UPDATE OF deptno, sal
ON demo_emp2
FOR EACH ROW
BEGIN
    /* 
       Deduct salary from old department if deleting a row
       or updating department
    */
    IF DELETING OR (UPDATING AND (:OLD.deptno != :NEW.deptno)) THEN
        UPDATE dept_budget
        SET total_sal = total_sal - :OLD.sal
        WHERE deptno = :OLD.deptno;
    END IF;

    /*
       Add salary to new department if inserting a row
       or updating department
    */
    IF INSERTING OR (UPDATING AND (:OLD.deptno != :NEW.deptno)) THEN
        UPDATE dept_budget
        SET total_sal = total_sal + :NEW.sal
        WHERE deptno = :NEW.deptno;
    END IF;

    /*
       Adjust total salary if only salary changes within same department
    */
    IF UPDATING AND (:OLD.deptno = :NEW.deptno AND :OLD.sal != :NEW.sal) THEN
        UPDATE dept_budget
        SET total_sal = total_sal + (:NEW.sal - :OLD.sal)
        WHERE deptno = :OLD.deptno;
    END IF;
END;
/

--Verify dept_budget is calculated correctly
SELECT *
FROM dept_budget;

SELECT deptno, SUM(sal)
FROM demo_emp
GROUP BY deptno
ORDER BY deptno;

-- Test the trigger by inserting an employee
INSERT INTO demo_emp2 (empno, ename, sal, deptno)
VALUES (9999, 'CHARLES', 1300, 10);

COMMIT;

--If you don't COMMIT, you may encounter SQL Error: 
-- ORA-12838: cannot read/modify an object after modifying it in parallel
