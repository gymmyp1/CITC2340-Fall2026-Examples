-- Example for specifying a default column value using a sequence.

-- DROP TABLE test_with_sequence;
-- DROP SEQUENCE s_default_value_for_column;

CREATE SEQUENCE s_default_value_for_column;

CREATE TABLE test_with_sequence (
        id INTEGER CONSTRAINT test_with_sequence_pk PRIMARY KEY,
        sequence_value INTEGER DEFAULT s_default_value_for_column.NEXTVAL
);

--Inserting a row with no sequence_value will auto populate with the sequence
INSERT INTO test_with_sequence (id) VALUES(1);
INSERT INTO test_with_sequence (id) VALUES(2);
INSERT INTO test_with_sequence (id) VALUES(3);