@echo off
call config.cmd
set MYSQLDUMP=%MYSQLPATH%\mysql\bin\mysqldump.exe
cls
echo ==========================================
echo            DATABASE BACKUP
echo ==========================================
echo.
set backup_file=Inventory_Backup_%random%.sql
echo Backing up the %DB% database...
"%MYSQLDUMP%" -u root %DB% > %backup_file%
echo.
echo Backup successful! Your data is saved as: %backup_file%
pause
exit /b