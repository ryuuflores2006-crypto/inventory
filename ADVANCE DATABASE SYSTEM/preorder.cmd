@echo off
call config.cmd
cls
echo ==========================================
echo           MANAGE PRE-ORDERS
echo ==========================================
echo.
set /p customer_id=Enter Customer ID: 
set /p employee_id=Enter Employee ID: 
set /p target_model=Enter Target Phone Model (e.g., iPhone 18 Pro Max): 
set /p deposit=Enter Deposit Amount: 

"%MYSQL%" -u root %DB% -e "INSERT INTO pre_orders (customer_id, employee_id, target_model_name, deposit_amount) VALUES (%customer_id%, %employee_id%, '%target_model%', %deposit%);"

echo.
echo Pre-order saved successfully!
pause
exit /b