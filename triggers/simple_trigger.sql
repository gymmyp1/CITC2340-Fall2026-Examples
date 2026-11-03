SET SERVEROUTPUT ON

DROP TABLE sample;

-- Create a table to play around with
CREATE TABLE sample (
    id INTEGER
);

-- Create a trigger that will fire after inserting into the table.
CREATE OR REPLACE TRIGGER after_sample_insert
AFTER INSERT ON sample
BEGIN
    DBMS_OUTPUT.PUT_LINE('You inserted a row in the table!');
END after_sample_insert;
/

--insert some a row into the table to make the trigger fire
INSERT INTO sample (id) VALUES (1);