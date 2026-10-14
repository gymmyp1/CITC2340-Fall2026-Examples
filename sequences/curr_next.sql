-- Before retrieving the current value, you must initialize the 
-- sequence by retrieving the next value.
SELECT s_test.NEXTVAL
FROM dual;
-- Sequence is at: 1

SELECT s_test.CURRVAL
FROM dual;
-- Sequence is at: 1

--Retrieving NEXTVAL again will update CURRVAL
SELECT s_test.NEXTVAL
FROM dual;
-- Sequence is at: 2

SELECT s_test.CURRVAL
FROM dual;
-- Sequence is at: 2