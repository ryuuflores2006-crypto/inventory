@echo off
call config.cmd
:REPORTS_MENU
cls
echo ==========================================
echo           ANALYTICS ^& REPORTS
echo ==========================================
echo.
echo [1] Full Sales Receipt History
echo [2] Warranty ^& Defect Tracking
echo [3] Pending Pre-Orders
echo [4] Back to Main Menu
echo.
set /p report_choice=Enter your choice: 

if "%report_choice%"=="1" goto REPORT_SALES
if "%report_choice%"=="2" goto REPORT_WARRANTY
if "%report_choice%"=="3" goto REPORT_PREORDERS
if "%report_choice%"=="4" exit /b

echo.
echo Invalid choice!
pause
goto REPORTS_MENU

:REPORT_SALES
cls
echo ==========================================
echo        FULL SALES RECEIPT HISTORY
echo ==========================================
echo.
"%MYSQL%" -u root %DB% -e "SELECT sales_receipts.receipt_no AS Receipt, products.model AS Model, customers.customer_name AS Buyer, employees.employee_name AS Cashier, sales_receipts.selling_price AS Price, sales_receipts.sale_date AS Date FROM sales_receipts JOIN inventory_units ON sales_receipts.imei_number = inventory_units.imei JOIN products ON inventory_units.product_id = products.product_id JOIN customers ON sales_receipts.customer_id = customers.customer_id JOIN employees ON sales_receipts.employee_id = employees.employee_id;"
echo.
pause
goto REPORTS_MENU

:REPORT_WARRANTY
cls
echo ==========================================
echo        WARRANTY ^& DEFECT TRACKING
echo ==========================================
echo.
"%MYSQL%" -u root %DB% -e "SELECT warranty_returns.return_id AS ID, sales_receipts.receipt_no AS Receipt, customers.customer_name AS Customer, products.model AS Model, warranty_returns.return_reason AS Reason, warranty_returns.action_taken AS Action FROM warranty_returns JOIN sales_receipts ON warranty_returns.receipt_no = sales_receipts.receipt_no JOIN inventory_units ON sales_receipts.imei_number = inventory_units.imei JOIN products ON inventory_units.product_id = products.product_id JOIN customers ON sales_receipts.customer_id = customers.customer_id;"
echo.
pause
goto REPORTS_MENU

:REPORT_PREORDERS
cls
echo ==========================================
echo           PENDING PRE-ORDERS
echo ==========================================
echo.
"%MYSQL%" -u root %DB% -e "SELECT pre_orders.pre_order_id AS ID, customers.customer_name AS Customer, pre_orders.target_model_name AS Target_Model, pre_orders.deposit_amount AS Deposit, pre_orders.order_status AS Status FROM pre_orders JOIN customers ON pre_orders.customer_id = customers.customer_id WHERE pre_orders.order_status = 'Pending';"
echo.
pause
goto REPORTS_MENU