@echo off
echo ==================================================================
echo           Network Optimization for Black Desert Online
echo ==================================================================
echo.

:: Set DNS Cache Settings
echo Setting DNS Cache Settings...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 384 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 64000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxSOACacheEntryTtlLimit" /t REG_DWORD /d 300 /f

:: Set TCP KeepAlive Interval
echo Setting TCP KeepAlive Interval...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveTime" /t REG_DWORD /d 300000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveInterval" /t REG_DWORD /d 2000 /f

:: Set TCP/IP MaxFreeTcbs
echo Setting TCP/IP MaxFreeTcbs...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65536 /f

:: Set TCP/IP MaxUserPort
echo Setting TCP/IP MaxUserPort...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f

:: Set TCP/IP TcpTimedWaitDelay
echo Setting TCP/IP TcpTimedWaitDelay...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f

:: Set TCP/IP Default TTL
echo Setting TCP/IP Default TTL...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f

:: Set TCP/IP SynAttackProtect
echo Setting TCP/IP SynAttackProtect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect" /t REG_DWORD /d 1 /f

:: Set TCP/IP DisableIPSourceRouting
echo Setting TCP/IP DisableIPSourceRouting...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableIPSourceRouting" /t REG_DWORD /d 2 /f

:: Set TCP/IP EnablePMTUDiscovery
echo Setting TCP/IP EnablePMTUDiscovery...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f

:: Set TCP/IP EnablePMTUBHDetect
echo Setting TCP/IP EnablePMTUBHDetect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUBHDetect" /t REG_DWORD /d 0 /f

:: Set TCP/IP SackOpts
echo Setting TCP/IP SackOpts...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f

:: Set TCP/IP Tcp1323Opts
echo Setting TCP/IP Tcp1323Opts...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f

:: Set TCP/IP TcpMaxDupAcks
echo Setting TCP/IP TcpMaxDupAcks...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d 2 /f

:: Set TCP/IP GlobalMaxTcpWindowSize
echo Setting TCP/IP GlobalMaxTcpWindowSize...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d 64240 /f

:: Set TCP/IP TcpWindowSize
echo Setting TCP/IP TcpWindowSize...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d 64240 /f

:: Set TCP/IP MaxConnectionsPer1_0Server
echo Setting TCP/IP MaxConnectionsPer1_0Server...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" /v "iexplore.exe" /t REG_DWORD /d 10 /f

:: Set TCP/IP MaxConnectionsPerServer
echo Setting TCP/IP MaxConnectionsPerServer...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" /v "iexplore.exe" /t REG_DWORD /d 10 /f

:: Set Network Latency Reduction
echo Setting Network Latency Reduction...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 1 /f

:: Enable Compound TCP (CTCP) Congestion Provider
echo Enabling CTCP Congestion Provider...
netsh interface tcp set global congestionprovider=ctcp

:: Disable Nagle's Algorithm Globally
echo Disabling Nagle's Algorithm...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpNoDelay" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpDelAckTicks" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f

:: Disable Nagle's Algorithm on Specific Interfaces
echo Disabling Nagle's Algorithm on interfaces...
for /f "tokens=*" %%A in ('netsh interface ipv4 show interfaces ^| findstr /C:"Connected"') do (
    set "interface=%%A"
    set "interface=!interface:~3,50!"
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\!interface!" /v TcpAckFrequency /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\!interface!" /v TCPNoDelay /t REG_DWORD /d 1 /f
)
echo Nagle's Algorithm disabled on interfaces.

:: Set DNS to Cloudflare
echo Setting DNS to Cloudflare...
netsh interface ipv4 set dnsservers name="Wi-Fi" source=static addr=1.1.1.1 register=primary
netsh interface ipv4 add dnsservers name="Wi-Fi" addr=1.0.0.1 index=2
netsh interface ipv4 set dnsservers name="Ethernet" source=static addr=1.1.1.1 register=primary
netsh interface ipv4 add dnsservers name="Ethernet" addr=1.0.0.1 index=2
echo DNS set to Cloudflare.

:: Disable SMBv1
echo Disabling SMBv1...
dism /online /norestart /disable-feature /featurename:SMB1Protocol
echo SMBv1 disabled.

:: Disable NetBIOS over TCP/IP
echo Disabling NetBIOS over TCP/IP...
wmic nicconfig where "IPEnabled = True" call SetTcpipNetbios 2
echo NetBIOS over TCP/IP disabled.

:: Disable LLMNR
echo Disabling LLMNR...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 0 /f
echo LLMNR disabled.

:: Normal Auto-Tuning
echo Normal Auto-Tuning...
netsh int tcp set global autotuninglevel=normal
echo Auto-Tuning disabled.

:: Disable Task Offload
echo Disabling Task Offload...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 1 /f
echo Task Offload disabled.

:: Set TCP/IP Connection Timeout
echo Setting TCP/IP Connection Timeout...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpInitialRtt" /t REG_DWORD /d 30 /f

:: Apply Changes and Restart Network Services
echo Applying changes and restarting network services...
netsh interface ipv4 reset
netsh interface ipv6 reset
ipconfig /flushdns
ipconfig /release
ipconfig /renew

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