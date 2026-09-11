-- ============================================================
/* 
DELIMITER //
CREATE TRIGGER [trigger_name] 
BEFORE | AFTER  
INSERT | UPDATE | DELETE 
ON [table_name]  
FOR EACH ROW | FOR EACH STATEMENT
BEGIN
 **********
END //
DELIMITER ;

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS [trigger_name] ;
*/
-- ============================================================

-- Creating products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    stock_quantity INT
);

-- Creating orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_ordered INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserting sample data into products
INSERT INTO products (product_id, product_name, stock_quantity) VALUES
(1, 'Laptop', 50),
(2, 'Wireless Mouse', 150),
(3, 'Mechanical Keyboard', 80);

-- creating the trigger
DELIMITER //
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity_ordered
    WHERE product_id = NEW.product_id;
END//
DELIMITER ;

-- Place an order for 10 laptops and 20 Wireless Mouse
INSERT INTO orders (product_id, quantity_ordered) VALUES (1, 5), (2, 10);

-- Check the updated stock quantities in the products table
SELECT * FROM products;


