@echo off
:: Dank BDO Launcher Batch File
:: This file launches the PowerShell script with the specified action

setlocal enabledelayedexpansion

:: Check if PowerShell execution policy allows running scripts
powershell -Command "Get-ExecutionPolicy" >nul 2>&1
if %errorlevel% neq 0 (
    echo PowerShell execution policy check failed.
    pause
    exit /b 1
)

:: Get the action parameter
set "ACTION=%1"

:: Validate action parameter
if "%ACTION%"=="" (
    echo Usage: launch.bat [Action]
    echo.
    echo Available actions:
    echo   MainLauncher      - Complete system optimization and game launch
    echo   NetworkOptimizer  - Advanced network optimization
    echo   SystemMaintenance - System maintenance and integrity check
    echo   RestartServices   - Restart essential Windows services
    echo   ClearTemp         - Clear temporary files
    echo   FlushDNS          - Flush DNS cache
    echo   CleanRAM          - Clean RAM cache
    echo.
    echo Example: launch.bat MainLauncher
    pause
    exit /b 1
)

:: Check if the PowerShell script exists
if not exist "launcher.ps1" (
    echo Error: launcher.ps1 not found in the current directory.
    echo Please ensure launcher.ps1 is in the same folder as this batch file.
    pause
    exit /b 1
)

:: Run the PowerShell script with the specified action
echo Starting Dank BDO Launcher with action: %ACTION%
echo.
powershell -ExecutionPolicy Bypass -File "launcher.ps1" -Action "%ACTION%"

:: Check if the PowerShell script executed successfully
if %errorlevel% equ 0 (
    echo.
    echo Action '%ACTION%' completed successfully!
) else (
    echo.
    echo Action '%ACTION%' failed with error code: %errorlevel%
)

echo.
pause 