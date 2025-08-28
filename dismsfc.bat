
@echo off

echo Performing component cleanup... 
Dism /Online /Cleanup-Image /StartComponentCleanup

echo. 
echo Restoring components... 
Dism /Online /Cleanup-Image /checkHealth

echo. 
echo Restoring components... 
Dism /Online /Cleanup-Image /scanHealth

echo. 
echo Restoring components... 
Dism /Online /Cleanup-Image /RestoreHealth

echo. 
echo Checking system file integrity... 
SFC /scannow


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
pause