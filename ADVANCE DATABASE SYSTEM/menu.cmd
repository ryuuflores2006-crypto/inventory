@echo off
title POS System - IMEI Tracking Edition
color 0B

call config.cmd

:MENU
cls
echo ==========================================
echo    CELLPHONE INVENTORY SYSTEM
echo ==========================================
echo.
echo [1] Add New Phone Model
echo [2] Receive Stock 
echo [3] View Inventory ^& Stocks
echo [4] Sell Phone 
echo [5] View Sold Items
echo [6] Search by IMEI
echo [7] Update Phone Price
echo [8] Export Inventory Report 
echo [9] Process Warranty Return
echo [10] Manage Pre-Orders
echo [11] Analytics ^& Reports
echo [12] Exit
echo.

set /p choice=Enter your choice: 

if "%choice%"=="1" call add_model.cmd
if "%choice%"=="2" call add_stock.cmd
if "%choice%"=="3" call view.cmd
if "%choice%"=="4" call sell.cmd
if "%choice%"=="5" call view_sold.cmd
if "%choice%"=="6" call search.cmd
if "%choice%"=="7" call update.cmd
if "%choice%"=="8" call export.cmd
if "%choice%"=="9" call warranty.cmd
if "%choice%"=="10" call preorder.cmd
if "%choice%"=="11" call reports.cmd
if "%choice%"=="12" exit

goto MENU