@echo off
call config.cmd
cls
echo ==========================================
echo         RECEIVE STOCK 
echo ==========================================
echo.
echo LIST OF AVAILABLE PHONE MODELS:
"%MYSQL%" -u root %DB% -e "SELECT product_id AS ID, brand AS Brand, model AS Model, ram AS RAM, storage AS Storage, color AS Color FROM products;"
echo.

set /p product_id=Enter Product ID from the list above: 
set /p imei=Enter / Scan IMEI Number: 
set /p supplier=Supplier Name: 

"%MYSQL%" -u root %DB% -e "INSERT INTO inventory_units (imei, product_id, supplier, status) VALUES ('%imei%', %product_id%, '%supplier%', 'Available');"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Baka na-add na ang IMEI na ito. Ang IMEI ay dapat unique!
) else (
    echo.
    echo Stock received! IMEI added successfully.
)
pause