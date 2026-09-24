@echo off
call config.cmd
cls
echo ==========================================
echo        ADD NEW PHONE MODEL 
echo ==========================================
echo.
set /p brand=Brand: 
set /p model=Model: 
set /p ram=RAM (e.g., 8GB, 12GB): 
set /p storage=Storage (e.g., 256GB): 
set /p color=Color: 
set /p price=Price: 

set price=%price:,=%

"%MYSQL%" -u root %DB% -e "INSERT INTO products (brand, model, ram, storage, color, price) VALUES ('%brand%', '%model%', '%ram%', '%storage%', '%color%', %price%);"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Hindi nai-save ang Model.
) else (
    echo.
    echo Phone Model added successfully to Catalog!
)
pause