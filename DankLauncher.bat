@echo off
:: ########## START OF SCRIPT ##########

:: STEP 1: Clear Temporary Files
echo Clearing temporary files...
for /d %%D in ("%temp%\*") do rd /s /q "%%D" 2>nul
for %%F in ("%temp%\*") do del /q /f "%%F" 2>nul
del /q /s /f "%SystemRoot%\Temp\*" >nul 2>&1
del /q /s /f "%SystemRoot%\Prefetch\*" >nul 2>&1
echo Temporary files cleared.
echo.

:: STEP 2: Flush DNS Cache
echo Flushing DNS cache...
ipconfig /flushdns >nul
echo DNS cache flushed.
echo.

:: STEP 3: Release and Renew IP Address (for Ethernet adapters only)
echo Refreshing network connection...
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr "Ethernet"') do (
    ipconfig /release "%%A" >nul 2>&1
    ipconfig /renew "%%A" >nul 2>&1
)
echo Network connection refreshed.
echo.

:: STEP 5: Clean RAM Cache
echo Cleaning RAM cache...
start /b rundll32.exe advapi32.dll,ProcessIdleTasks
echo RAM cache cleanup initiated.
echo.

:: STEP 6: Stop Unnecessary Windows Services
echo Disabling unnecessary Windows services...

set services=SysMain Spooler Fax wuauserv DiagTrack  ShellHWDetection FDResPub FDHost iphlpsvc TrkWks hidserv W32Time Themes wscsvc OfflineFiles TermService RemoteRegistry seclogon WerSvc WpnService LicenseManager MSIServer UserDataSvc_4be6e UsoSvc TabletInputService server remoteaccessautoconnectionmanager pimindexmaintenancesvc_4be6e onesyncsvc_4be6e MicrosoftStoreInstallService MicrosoftSoftwareShadowCopyProvider Hyper-V-VMMS Hyper-V-VmSwitchService Hyper-V-Host-Compute-Helper Hyper-V-Host-Compute-Support Hyper-V-Worker-Processor Hyper-V-Time Synchronization Hyper-V-Integration-Services DeliveryOptimization

for %%S in (%services%) do (
    echo Checking status of %%S...
    for /f "tokens=3 delims=: " %%A in ('sc query %%S ^| find "STATE"') do (
        if "%%A"=="RUNNING" (
            echo Stopping %%S...
            net stop %%S >nul 2>&1
            if %errorLevel% equ 0 (
                echo %%S stopped successfully.
            ) else (
                echo Failed to stop %%S.
            )
        ) else (
            echo %%S is already stopped.
        )
    )
)
echo All unnecessary services have been processed.
echo.

:: STEP 7: Apply GPU and Display Settings
echo Optimizing GPU and display settings...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX" /v MaxFRL /t REG_DWORD /d 0 /f >nul
if %errorLevel% neq 0 echo Warning: Failed to set MaxFRL registry key.

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 10 /f >nul
if %errorLevel% neq 0 echo Warning: Failed to set TdrDelay registry key.

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online\bin64\BlackDesert64.exe" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f

)
echo GPU and display settings optimized.
echo.

wmic process where name="BlackDesert64.exe" CALL setpriority 128
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ToastEnabled /t REG_DWORD /d 0 /f


:: STEP 10: Navigate to Black Desert Online Directory and Launch Game
cd /d "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online" || echo Warning: Black Desert Online path not found.
echo Launching Black Desert Online...
start /affinity ac /high BlackDesertLauncher.exe -steam || echo Warning: Failed to launch Black Desert Online.
echo Black Desert Online launched.


:: STEP 11: Display Banner
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
echo -----------------------------------------------------------------------
echo =======================================================================