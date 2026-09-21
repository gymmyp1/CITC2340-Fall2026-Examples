--CASE and DECODE examples

--If 1 == 1 then return 2
Else return 3
SELECT DECODE(1, 1, 2, 3) 
FROM dual;

--In the more_products table, the available column contains 'Y' or 'N' values. 
-- Use DECODE to convert these codes into readable status messages.
SELECT prd_id, available,
DECODE(available, 'Y',
        'Product is available',
        'Product is not available') 
FROM more_products;

--return the product_type_id column as the name of the product type.
SELECT product_id, product_type_id, 
DECODE(product_type_id,
        1, 'Book',
        2, 'Video',
        3, 'DVD',
        4, 'CD',
       'Magazine')
FROM products;

--This CASE expression produces identical results to the DECODE example.
SELECT product_id, product_type_id, 
CASE product_type_id
     WHEN 1 THEN 'Book'
     WHEN 2 THEN 'Video'
     WHEN 3 THEN 'DVD'
     WHEN 4 THEN 'CD'
     ELSE 'Magazine'
END 
FROM products;

--Searched case example
SELECT product_id, product_type_id,
CASE     
WHEN product_type_id = 1 THEN 'Book'
     WHEN product_type_id = 2 THEN 'Video'
     WHEN product_type_id = 3 THEN 'DVD'
      WHEN product_type_id = 4 THEN 'CD'
     ELSE 'Magazine'
END
FROM products;

--I want to indicate which products are low (less than $15), medium ($15 <= x <= $30), and high (above $30) cost. 
SELECT name, price,
CASE
  WHEN price < 15 THEN 'Low Cost'
  WHEN price BETWEEN 15 AND 30 THEN 'Medium Cost'
  ELSE 'High Cost'
END AS price_category
FROM products;
