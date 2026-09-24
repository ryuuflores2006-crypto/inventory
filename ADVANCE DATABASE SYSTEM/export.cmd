@echo off
call config.cmd
cls
echo ==========================================
echo        EXPORT INVENTORY TO EXCEL
echo ==========================================
echo.
set filename=Inventory_Report.xls
echo Exporting data to %filename%...

"%MYSQL%" -u root %DB% -e "SELECT p.product_id AS ID, p.brand AS Brand, p.model AS Model, p.ram AS RAM, p.storage AS Storage, p.color AS Color, p.price AS Price, SUM(IF(i.status='Available', 1, 0)) AS 'Live Stock', SUM(IF(i.status='Sold', 1, 0)) AS 'Sold Units', (p.price * SUM(IF(i.status='Sold', 1, 0))) AS 'Total Revenue' FROM products p LEFT JOIN inventory_units i ON p.product_id = i.product_id GROUP BY p.product_id;" > %filename%

if %errorlevel% neq 0 (
    echo.
    echo ERROR: May naging problema sa pag-export ng data.
) else (
    echo.
    echo Export complete! Maaari mo nang buksan ang "%filename%" sa iyong folder gamit ang MS Excel.
)
echo.
pause
exit /b