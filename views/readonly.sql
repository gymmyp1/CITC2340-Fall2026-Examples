--You can make a view read-only by adding a READ ONLY constraint to the view.
CREATE VIEW cheap_products_view3 AS
SELECT *
FROM products
WHERE price < 15
WITH READ ONLY CONSTRAINT cheap_products_view3_read_only;

--The DB will prevent you from inserting because it's marked as READ ONLY
INSERT INTO cheap_products_view3 (
    product_id, product_type_id, name, price
) VALUES ( 
    16, 1, 'Northern Front', 19.50
);