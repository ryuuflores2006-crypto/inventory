@echo off
call config.cmd
cls
echo ==========================================
echo       INVENTORY OVERVIEW 
echo ==========================================
echo.

"%MYSQL%" -u root %DB% -e "SELECT p.product_id AS ID, p.brand AS Brand, p.model AS Model, p.ram AS RAM, p.storage AS Storage, p.color AS Color, p.price AS Price, COUNT(i.imei) AS 'Live Stock' FROM products p LEFT JOIN inventory_units i ON p.product_id = i.product_id AND i.status = 'Available' GROUP BY p.product_id;"

echo.
pause