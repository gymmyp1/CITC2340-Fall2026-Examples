-- You can specify that DML statements on a view must 
-- satisfy the subquery using a CHECK OPTION constraint. 

CREATE VIEW cheap_products_view2 AS
SELECT *
FROM products
WHERE price < 15
WITH CHECK OPTION CONSTRAINT cheap_products_view2_price;

-- The WITH CHECK option says “If the row wouldn’t appear in the 
-- view’s SELECT…WHERE filter, you’re not allowed to create or modify it through this view.”