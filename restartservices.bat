:: this file is to restart the windows services that the launcher stops without needing to reboot windows,
:: you'll probably never need to use this for anything
@echo off
echo Starting necessary Windows services...
set services=ShellHWDetection Winmgmt
echo SysMain WSearch Spooler Fax wuauserv DiagTrack BthHFSrv FDResPub FDHost iphlpsvc TrkWks hidserv W32Time Themes wscsvc OfflineFiles TermService RemoteRegistry seclogon WerSvc WpnService LicenseManager MSIServer UserDataSvc_4be6e UsoSvc TabletInputService server remoteaccessautoconnectionmanager pimindexmaintenancesvc_4be6e onesyncsvc_4be6e MicrosoftStoreInstallService MicrosoftSoftwareShadowCopyProvider Hyper-V-VMMS Hyper-V-VmSwitchService Hyper-V-Host-Compute-Helper Hyper-V-Host-Compute-Support Hyper-V-Worker-Processor Hyper-V-Time Synchronization Hyper-V-Integration-Services DeliveryOptimization
for %%S in (%services%) do (
    sc query %%S | find "RUNNING" >nul
    if %errorLevel% neq 0 (
        echo Starting %%S...
        net start %%S >nul 2>&1
        if %errorLevel% equ 0 (
            echo %%S started successfully.
        ) else (
            echo %%S could not be started.
        )
    ) else (
        echo %%S is already running.
    )
)
echo Necessary services started.
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
echo.