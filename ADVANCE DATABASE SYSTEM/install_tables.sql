-- Table Structures
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    branch_location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS sales_receipts (
    receipt_no INT AUTO_INCREMENT PRIMARY KEY,
    imei_number VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS warranty_returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    receipt_no INT NOT NULL,
    return_reason TEXT NOT NULL,
    action_taken VARCHAR(50),
    replacement_imei VARCHAR(50),
    return_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pre_orders (
    pre_order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    target_model_name VARCHAR(100) NOT NULL,
    deposit_amount DECIMAL(10,2),
    pre_order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) DEFAULT 'Pending'
);

-- Automation Trigger
DROP TRIGGER IF EXISTS after_warranty_return;

DELIMITER //
CREATE TRIGGER after_warranty_return
AFTER INSERT ON warranty_returns
FOR EACH ROW
BEGIN
    UPDATE inventory_units 
    SET status = 'Defective' 
    WHERE imei = (SELECT imei_number FROM sales_receipts WHERE receipt_no = NEW.receipt_no);
    
    IF NEW.replacement_imei != '' THEN
        UPDATE inventory_units 
        SET status = 'Sold' 
        WHERE imei = NEW.replacement_imei;
    END IF;
END //
DELIMITER ;