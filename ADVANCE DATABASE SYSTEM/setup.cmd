@echo off
call config.cmd
cls
echo ==========================================
echo      SYSTEM SETUP ^& INITIALIZATION
echo ==========================================
echo.
echo Installing new tables and automation triggers...

"%MYSQL%" -u root %DB% < install_tables.sql

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install tables. Check if MySQL is running.
) else (
    echo.
    echo Setup complete! The database structure is fully installed.
)
echo.
pause
exit /b