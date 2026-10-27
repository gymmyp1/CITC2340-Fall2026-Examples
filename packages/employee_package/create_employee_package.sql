CREATE OR REPLACE PACKAGE employee_package AS
  -- Public variable
  --g_ prefix since it's a global package variable
  g_company_name VARCHAR2(50) := 'Tech Solutions Inc.';

  -- Public type (so other procedures can return query results if needed)
  TYPE t_ref_cursor IS REF CURSOR;

  -- Public procedure: add a new employee
  PROCEDURE add_employee(
    p_id      INTEGER,
    p_mgrid   INTEGER DEFAULT NULL,
    p_fname   VARCHAR2,
    p_lname   VARCHAR2,
    p_title   VARCHAR2,
    p_salary  NUMBER
  );

  -- Public function: count total employees
  FUNCTION get_employee_count RETURN NUMBER;

  -- Public function: get all employees (returns REF CURSOR)
  FUNCTION get_all_employees RETURN t_ref_cursor;
END employee_package;
/

CREATE OR REPLACE PACKAGE BODY employee_package AS
  -- Private variable (not visible outside)
  v_employee_count NUMBER := 0;

  -- Private procedure (only used internally), since its header was excluded from the package specification
  PROCEDURE log_action(p_action VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('LOG: ' || p_action);
  END log_action;

  -- Public procedure implementation
  PROCEDURE add_employee(
    p_id INTEGER,
    p_mgrid INTEGER DEFAULT NULL, --optional parameter
    p_fname VARCHAR2,
    p_lname VARCHAR2,
    p_title VARCHAR2,
    p_salary NUMBER) AS
  BEGIN
    INSERT INTO employees (employee_id, manager_id, first_name, last_name, title, salary)
	VALUES (p_id, p_mgrid, p_fname, p_lname, p_title, p_salary);
    COMMIT;
    log_action('Added employee ' || p_fname || ' with salary ' || p_salary);
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
  END add_employee;

  -- Public function implementation
  FUNCTION get_employee_count RETURN NUMBER IS
  BEGIN
	SELECT COUNT(*)
	INTO v_employee_count
	FROM employees;

    RETURN v_employee_count;
  END get_employee_count;

   -- Public function: return all employees as REF CURSOR
  FUNCTION get_all_employees RETURN t_ref_cursor IS
    v_cursor t_ref_cursor;
  BEGIN
    OPEN v_cursor FOR
      SELECT employee_id, manager_id, first_name, last_name, title, salary
      FROM employees
      ORDER BY employee_id;
    RETURN v_cursor;
  END get_all_employees;

END employee_package;