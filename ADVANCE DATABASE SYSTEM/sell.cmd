@echo off
call config.cmd
cls
echo ==========================================
echo             SELL PHONE 
echo ==========================================
echo.
echo LISTAHAN NG MGA AVAILABLE NA IMEI:
"%MYSQL%" -u root %DB% -e "SELECT i.imei AS IMEI, p.brand AS Brand, p.model AS Model, p.color AS Color, p.price AS Price FROM inventory_units i JOIN products p ON i.product_id = p.product_id WHERE i.status = 'Available';"
echo.
echo ==========================================
echo.
set /p imei=Scan or Enter IMEI to Sell: 
echo.

REM I-check muna kung Available ang IMEI
"%MYSQL%" -u root %DB% -e "SELECT p.brand, p.model, p.price, i.status FROM inventory_units i JOIN products p ON i.product_id = p.product_id WHERE i.imei='%imei%';"
echo.

set /p confirm=Confirm Sale? [Y/N]: 
if /I "%confirm%" neq "Y" exit /b

"%MYSQL%" -u root %DB% -e "UPDATE inventory_units SET status='Sold' WHERE imei='%imei%' AND status='Available';"
echo.
echo --- GENERATE RECEIPT ---
set /p customer_id=Enter Customer ID: 
set /p employee_id=Enter Employee ID: 

REM Grabs the price directly from the products table based on the IMEI
"%MYSQL%" -u root %DB% -e "INSERT INTO sales_receipts (imei_number, customer_id, employee_id, selling_price) SELECT '%imei%', %customer_id%, %employee_id%, p.price FROM inventory_units i JOIN products p ON i.product_id = p.product_id WHERE i.imei='%imei%';"

echo Receipt logged in the database!
echo.
echo Item Sold successfully! Status updated in database.
pause