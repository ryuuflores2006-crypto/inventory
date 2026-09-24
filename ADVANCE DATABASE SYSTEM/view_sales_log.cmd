@echo off
call config.cmd
cls
echo ==========================================
echo             SOLD ITEMS LOG
echo ==========================================
echo.

"%MYSQL%" -u root %DB% -e "SELECT i.imei AS IMEI, p.brand AS Brand, p.model AS Model, p.color AS Color, p.price AS 'Amount', i.supplier AS Supplier FROM inventory_units i JOIN products p ON i.product_id = p.product_id WHERE i.status = 'Sold';"

echo.
pause