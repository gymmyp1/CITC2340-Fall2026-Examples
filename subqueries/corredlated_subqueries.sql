--Correlated Subqueries
--Example: Which employees earn more than the average salary for their department?
SELECT e.deptno, e.ename, e.sal
FROM demo_emp e
WHERE e.sal > 
	(SELECT AVG(d.sal)
    FROM demo_emp d
    WHERE d.deptno = e.deptno)
ORDER BY e.deptno;

--EXISTS/NOT EXISTS examples
--Example: find employees who are also managers
SELECT employee_id, last_name
FROM employees outer
WHERE EXISTS 
	(SELECT *
    FROM employees inner
    WHERE inner.manager_id = outer.employee_id);

-- Example: Find departments with no employees
SELECT deptno, dname
FROM demo_dept d
WHERE NOT EXISTS 
	(SELECT 1
    FROM demo_emp e
    WHERE d.deptno = e.deptno);
