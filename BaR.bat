@echo off
:: Dank BDO Launcher - Build and Run
:: This batch file builds and runs the C# Windows Forms application

echo ======================================================================
echo           Dank BDO Launcher - Ultimate Optimization Suite
echo ======================================================================
echo.
echo Building and running Dank BDO Launcher...
echo.

:: Check if .NET 5.0 SDK is installed
echo Checking for .NET SDK...
where dotnet >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: .NET 5.0 SDK is not found in PATH!
    echo.
    echo Please install .NET 5.0 SDK from: https://dotnet.microsoft.com/download
    echo Choose the .NET 5.0 version.
    echo.
    echo After installing, you may need to restart your computer.
    echo.
    pause
    exit /b 1
)

dotnet --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: .NET 5.0 SDK is installed but not working properly!
    echo.
    echo Please try restarting your computer or reinstalling .NET 5.0 SDK.
    echo.
    pause
    exit /b 1
)

echo .NET SDK found successfully!
echo Testing dotnet command...
dotnet --info >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: dotnet --info failed, but continuing...
) else (
    echo .NET SDK is working properly!
)
echo.

:: Check if project files exist
if not exist "DankBDOLauncher.csproj" (
    echo ERROR: DankBDOLauncher.csproj not found!
    echo Please ensure all project files are in the same directory.
    echo.
    pause
    exit /b 1
)

if not exist "MainForm.cs" (
    echo ERROR: MainForm.cs not found!
    echo Please ensure all project files are in the same directory.
    echo.
    pause
    exit /b 1
)

if not exist "Program.cs" (
    echo ERROR: Program.cs not found!
    echo Please ensure all project files are in the same directory.
    echo.
    pause
    exit /b 1
)

:: Clean previous builds
echo Cleaning previous builds...
dotnet clean >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: Clean failed, continuing anyway...
    echo.
)

:: Restore packages
echo Restoring NuGet packages...
dotnet restore
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to restore packages!
    echo Please check your internet connection and try again.
    echo.
    pause
    exit /b 1
)

:: Build the application
echo Building application...
dotnet build --configuration Release
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Build failed!
    echo Please check the error messages above.
    echo.
    pause
    exit /b 1
)

echo.
echo Build completed successfully!
echo.

:: Check if executable was created
if not exist "bin\Release\net5.0-windows\DankBDOLauncher.exe" (
    echo ERROR: Executable not found after build!
    echo Please check the build output for errors.
    echo.
    pause
    exit /b 1
)

echo ======================================================================
echo    Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn
echo ======================================================================
echo ######                                ######                           
echo #     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # 
echo #     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # 
echo #     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # 
echo #     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # 
echo #     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## 
echo ######  #    # #    # #    # #  ####  #     # # #      #      # #    #         
echo========================================================================
echo               Remember to smoke weed and PvP every day.
echo =======================================================================
echo.
echo 🚀 Launching Dank BDO Launcher...
echo.

:: Run the application
start "" "bin\Release\net5.0-windows\DankBDOLauncher.exe"

echo Application launched successfully!
echo.
pause 