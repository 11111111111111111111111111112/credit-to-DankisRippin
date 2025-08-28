@echo off

:: Set "KeyboardDataQueueSize" to decimal 40
echo Updating KeyboardDataQueueSize to 40...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 40 /f >nul 2>&1
if %errorlevel% neq 0 (
    echo Failed to update KeyboardDataQueueSize!
) else (
    echo Successfully updated KeyboardDataQueueSize to 40.
)

:: Check if "Parameters" key exists under "mouclass"
echo Checking if Parameters key exists for mouclass...
reg query "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" >nul 2>&1
if %errorlevel% neq 0 (
    echo Parameters key does not exist. Attempting to create it...
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /f >nul 2>&1
    if %errorlevel% neq 0 (
        echo Failed to create Parameters key for mouclass!
    ) else (
        echo Successfully created Parameters key for mouclass.
    )
) else (
    echo Parameters key already exists for mouclass. Skipping creation.
)

:: Set "MouseDataQueueSize" to decimal 20
echo Setting MouseDataQueueSize to 20...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 20 /f >nul 2>&1
if %errorlevel% neq 0 (
    echo Failed to set MouseDataQueueSize!
) else (
    echo Successfully set MouseDataQueueSize to 20.
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
echo         Script executed successfully, press any key to close..
echo =======================================================================

