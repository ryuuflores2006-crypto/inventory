@echo off
call config.cmd
cls
echo ==========================================
echo             UPDATE PRICE
echo ==========================================
echo.
"%MYSQL%" -u root %DB% -e "SELECT product_id AS ID, brand AS Brand, model AS Model, storage AS Storage, price AS Price FROM products;"
echo.

set /p product_id=Enter Product ID: 
echo.
set /p price=Enter New Price: 
set price=%price:,=%

"%MYSQL%" -u root %DB% -e "UPDATE products SET price=%price% WHERE product_id=%product_id%;"

echo.
echo Price updated successfully!
pause