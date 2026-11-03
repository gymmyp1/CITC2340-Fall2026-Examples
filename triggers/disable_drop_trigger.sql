-- disable triger from firing
ALTER TRIGGER before_product_price_update DISABLE;

-- drop trigger permananently from database
DROP TRIGGER before_product_price_update;