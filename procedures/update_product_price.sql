-- The update_product_price() procedure multiplies the price of a product by a factor.
-- The product ID and the factor are passed as parameters to the procedure.
-- If the product exists, the procedure multiplies the product price by the factor and commits the change.

PROCEDURE update_product_price (
    p_product_id IN products.product_id%TYPE,
    p_factor     IN NUMBER
)
AS
    v_product_count INTEGER;
BEGIN
    -- Count the number of products with the supplied product_id
    -- (count will be 1 if the product exists)
    SELECT COUNT(*)
    INTO v_product_count
    FROM products
    WHERE product_id = p_product_id;

    -- If the product exists (v_product_count = 1), then update that product's price
    IF v_product_count = 1 THEN
        UPDATE products
        SET price = price * p_factor
        WHERE product_id = p_product_id;

        COMMIT;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END update_product_price;
/