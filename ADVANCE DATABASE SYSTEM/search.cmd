@echo off
call config.cmd
:SEARCH
cls
echo ==========================================
echo        SEARCH CELLPHONE (LIVE STOCK)
echo ==========================================
echo.
echo [1] Search by Brand
echo [2] Search by Model
echo [3] Search by IMEI
echo [4] Back to Dashboard
echo.
set /p search_choice=Enter your choice:

if "%search_choice%"=="1" goto SEARCH_BRAND
if "%search_choice%"=="2" goto SEARCH_MODEL
if "%search_choice%"=="3" goto SEARCH_IMEI
if "%search_choice%"=="4" exit /b

:SEARCH_BRAND
cls
set /p brand=Enter Brand: 
echo.
"%MYSQL%" -u root %DB% -e "SELECT p.product_id AS ID, p.brand AS Brand, p.model AS Model, p.ram AS RAM, p.storage AS Storage, p.color AS Color, p.price AS Price, COUNT(i.imei) AS 'Live Stock' FROM products p LEFT JOIN inventory_units i ON p.product_id = i.product_id AND i.status = 'Available' WHERE p.brand LIKE '%%%brand%%%' GROUP BY p.product_id;"
echo.
pause
goto SEARCH

:SEARCH_MODEL
cls
set /p model=Enter Model: 
echo.
"%MYSQL%" -u root %DB% -e "SELECT p.product_id AS ID, p.brand AS Brand, p.model AS Model, p.ram AS RAM, p.storage AS Storage, p.color AS Color, p.price AS Price, COUNT(i.imei) AS 'Live Stock' FROM products p LEFT JOIN inventory_units i ON p.product_id = i.product_id AND i.status = 'Available' WHERE p.model LIKE '%%%model%%%' GROUP BY p.product_id;"
echo.
pause
goto SEARCH

:SEARCH_IMEI
cls
set /p imei=Enter IMEI: 
echo.
"%MYSQL%" -u root %DB% -e "SELECT i.imei AS IMEI, p.brand AS Brand, p.model AS Model, p.ram AS RAM, p.storage AS Storage, p.color AS Color, i.status AS Status FROM inventory_units i JOIN products p ON i.product_id = p.product_id WHERE i.imei='%imei%';"
echo.
pause
goto SEARCH