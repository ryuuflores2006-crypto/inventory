@echo off
call config.cmd
cls
echo ==========================================
echo             DELETE CELLPHONE
echo ==========================================
echo.
set /p phone_id=Enter Phone ID to delete: 
echo.
echo Cellphone record:
"%MYSQL%" -u root %DB% -e "SELECT * FROM cellphones WHERE phone_id=%phone_id%;"
echo.
set /p confirm=Are you sure you want to delete this record? [Y/N]: 

if /I "%confirm%"=="Y" goto DELETE
if /I "%confirm%"=="N" exit /b

:DELETE
"%MYSQL%" -u root %DB% -e "DELETE FROM cellphones WHERE phone_id=%phone_id%;"
echo.
echo Cellphone deleted successfully!
pause
exit /b