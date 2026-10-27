
--using the employee package
BEGIN
  -- Accessing public variable
  DBMS_OUTPUT.PUT_LINE('Company: ' || employee_package.g_company_name);

  -- Calling public procedures/functions
  employee_package.add_employee(40, 3, 'Alice', 'Wonderland', 
								'Rabbit Coordinator', 55000);
  employee_package.add_employee(41, 4, 'Bob', 'Ross',
								'Painter', 60000);

  DBMS_OUTPUT.PUT_LINE('Total employees: ' || employee_package.get_employee_count);
END;
/


--example of using the get_all_employees function
DECLARE
  -- assign v_cursor's type to be the same type as 
  -- the REF CURSOR defined in employee_package
  v_cursor employee_package.t_ref_cursor; 
  
  -- variable to hold each row
  v_emp employees%ROWTYPE;
BEGIN
  -- Call the function and get the cursor
  v_cursor := employee_package.get_all_employees;

  -- Loop through each row
  LOOP
    FETCH v_cursor INTO v_emp;
    EXIT WHEN v_cursor%NOTFOUND;

    -- Print employee info
    DBMS_OUTPUT.PUT_LINE(
      v_emp.employee_id || ': ' || v_emp.first_name || ' ' || v_emp.last_name ||
      ', Title: ' || v_emp.title ||
      ', Salary: ' || NVL(TO_CHAR(v_emp.salary), 'NULL') ||
      ', Manager ID: ' || NVL(TO_CHAR(v_emp.manager_id), 'NULL')
    );
  END LOOP;

  -- Close the cursor
  CLOSE v_cursor;
END;
/

-- These will cause errors (private items!)
/* BEGIN
  DBMS_OUTPUT.PUT_LINE(employee_package.v_employee_count);  -- not visible
  employee_package.log_action('test');                      -- not visible
END;
/
*/