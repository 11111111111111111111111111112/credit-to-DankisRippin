@echo off
echo ======================================================================
echo Choose an option to launch Black Desert Online:
echo 		Black Desert Client: "C"
echo 			      Steam: "S"
echo            input your choice with keyboard
echo ======================================================================
echo ----------------------------------------------------------------------
echo ######                                ######                           
echo #     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # 
echo #     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # 
echo #     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # 
echo #     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # 
echo #     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## 
echo ######  #    # #    # #    # #  ####  #     # # #      #      # #    #         
echo -----------------------------------------------------------------------
set /p choice=Enter your choice (S/C):

if /i "%choice%"=="S" (
    :: Navigate to Black Desert Online Directory and Launch Game (Steam Version)
    cd /d "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online" || echo Warning: Black Desert Online path not found.
    echo Launching Black Desert Online...
    start /affinity ac /high BlackDesertLauncher.exe -steam || echo Warning: Failed to launch Black Desert Online.
    echo Black Desert Online launched.
) else if /i "%choice%"=="C" (
    :: Navigate to Black Desert Online Directory and Launch Game (client Version)
    cd /d "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online" || echo Warning: Black Desert Online path not found.
    echo Launching Black Desert Online...
    start /affinity ac /high BlackDesertLauncher.exe || echo Warning: Failed to launch Black Desert Online.
    echo Black Desert Online launched.
) else (
    echo Invalid choice. How are you going to play Black Desert if you can't even press the buttons well enough to login?
)
exit