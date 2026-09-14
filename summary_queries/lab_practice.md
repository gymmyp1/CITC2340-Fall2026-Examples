# Practice Set – SQL Joins, Functions & Formatting

---

You will need the Aviation and Demo schemas loaded in your database to answer the following questions.

## 1. Display customer account balances with currency formatting.

Show each customer’s name and balance in the format:
`Customer Name owes $X,XXX.XX`

```sql
--FM removes all leading and trailing spaces
SELECT 'Customer ' || cus_fname || ' ' || cus_lname || 
       ' owes ' || TO_CHAR(cus_balance, 'FM$9,999.99') AS balance_info
FROM avia_customer;

```

**Example Output**

```
BALANCE_INFO
-----------------------------------
Customer Jane Roe owes $1,250.50
Customer John King owes $849.99
Customer Maria Chan owes $300.00
```

---

## 2. Show employee birthdays in long written format.

Display each employee’s name and their date of hire:
`David Lee was hired June Twelfth, Nineteen Eighty-Five`
Order by hire date in ascending order.
(see doc in course shell for help on date formatting)

```sql
SELECT emp_fname || ' ' || emp_lname || ' was hired ' ||
       TO_CHAR(emp_hire_date, 'FMMonth DdSPTH, Year') AS hired
FROM avia_employee
ORDER BY emp_hire_date;
```

**Example Output**

```
HIRED       
----------------------------------------------------
David Lee was hired June Twelfth, Nineteen Eighty-Five
Susan Patel was hired October Third, Nineteen Ninety
```

---

## 3. List each employee with their department and salary.

Use the DEMO_EMP and DEMO_DEPT tables from the Demo schema for this question.

Join employees and derpartments so the output looks like:
`Scott is in the Research department and has a salary of $3,000.`

```sql
SELECT INITCAP(ename) || ' is in the ' || INITCAP(dname) || 
    ' department and has a salary of ' || TO_CHAR(sal, 'FM$9,999.99') AS emp_info
FROM demo_emp e JOIN demo_dept d
  USING (deptno);
```

**Example Output**

```
EMP_INFO
---------------------------------------------
Scott is in the Research department and has a salary of $3,000.
Adams is in the Research department and has a salary of $1,100.
```

---

## 4. Show total and average gallons of fuel per charter per day.

Order by charter day.
(Hint: You'll need a GROUP BY clause).

```sql
SELECT EXTRACT(day FROM char_date) AS day,
       SUM(char_fuel_gallons) AS total_gallons,
       ROUND(AVG(char_fuel_gallons), 2) AS avg_gallons
FROM charter
GROUP BY EXTRACT(DAY FROM char_date)
ORDER BY EXTRACT(DAY FROM char_date);
```

**Example Output**

```
       DAY TOTAL_GALLONS AVG_GALLONS
---------- ------------- -----------
         5         766.5       255.5
         6         960.4       240.1
         7         946.6      236.65
         8         389.4       194.7
         9         829.3      276.43
        10         272.9      136.45
```

---

## 5. Count how many employees each department has.

```sql
SELECT d.dname,
       COUNT(e.empno) AS num_employees
FROM demo_dept d LEFT JOIN demo_emp e
  ON d.deptno = e.deptno
GROUP BY d.dname;
```

**Example Output**

```
DNAME          NUM_EMPLOYEES
-------------- -------------
RESEARCH                   5
OPERATIONS                 0
SALES                      6
ACCOUNTING                 3
```
