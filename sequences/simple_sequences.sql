-- Because this CREATE SEQUENCE statement omits the 
-- optional parameters, the default values are used. 
-- This specifies that start_num and increment_num are set to the default of 1.
CREATE SEQUENCE s_test;

-- Specify optional parameters
CREATE SEQUENCE s_test2
START WITH 10 INCREMENT BY 5
MINVALUE 10 MAXVALUE 20;

-- Start a 10 and count down to 1
CREATE SEQUENCE s_test3
START WITH 10 INCREMENT BY -1
MINVALUE 1 MAXVALUE 10;