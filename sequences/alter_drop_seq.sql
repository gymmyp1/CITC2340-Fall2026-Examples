ALTER SEQUENCE s_test
INCREMENT BY 2;

ALTER SEQUENCE s_order_status2
MAXVALUE 1000;

-- Drop the sequence from the DB
DROP sequence product_id_seq;