-- Create a table
CREATE TABLE order_status2 (
    id INTEGER CONSTRAINT order_status2_pk PRIMARY KEY,
    status VARCHAR2(10), 
    last_modified DATE DEFAULT SYSDATE
);

-- Create sequence called s_order_status2
CREATE SEQUENCE s_order_status2 NOCACHE;

-- insert rows into order_status2. 
-- Notice that the value for the id column is set using the s_order_status2 sequence.

INSERT INTO order_status2 ( id, status, last_modified) 
VALUES ( s_order_status2.NEXTVAL,'PLACED', '01-01-2006'
);

INSERT INTO order_status2 (id, status, last_modified) 
VALUES (s_order_status2.NEXTVAL,'PENDING', '02-01-2006');
