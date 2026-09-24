@echo off
call config.cmd
cls
echo ==========================================
echo        PROCESS WARRANTY / DEFECT
echo ==========================================
echo.
set /p receipt_no=Enter Receipt Number: 
set /p old_imei=Enter Defective Phone IMEI: 
set /p reason=Enter Reason for Return (e.g., Dead Pixel): 
set /p action=Action Taken (Refunded/Replaced): 
set /p new_imei=Enter Replacement IMEI (Leave blank if refunded): 

REM 1. Log the warranty return
"%MYSQL%" -u root %DB% -e "INSERT INTO warranty_returns (receipt_no, return_reason, action_taken, replacement_imei) VALUES (%receipt_no%, '%reason%', '%action%', '%new_imei%');"

REM 2. Mark the returned phone as Defective in your existing inventory
"%MYSQL%" -u root %DB% -e "UPDATE inventory_units SET status='Defective' WHERE imei='%old_imei%';"

REM 3. If a replacement was given, mark the new phone as Sold
if not "%new_imei%"=="" (
    "%MYSQL%" -u root %DB% -e "UPDATE inventory_units SET status='Sold' WHERE imei='%new_imei%';"
)

echo.
echo Warranty processed and inventory updated successfully!
pause
exit /b