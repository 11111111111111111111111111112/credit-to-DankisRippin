
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
pause
pause