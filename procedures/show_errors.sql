--Make intentional mistake  (the parameter should be p_dob, not p_dobs) to
-- use SHOW ERRORS

SET SERVEROUTPUT ON

CREATE PROCEDURE update_customer_dob (
	p_customer _id INTEGER, p_dob DATE
) AS
BEGIN
	UPDATE customers
	SET dob = p_dobs -- mistake here
	WHERE customer_id = p_customer_id;
END update_customer_dob;
/

-- then run SHOW ERRORS