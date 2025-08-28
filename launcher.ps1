# Dank BDO Launcher PowerShell Script
# This script provides the backend functionality for the HTML interface

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("MainLauncher", "NetworkOptimizer", "SystemMaintenance", "RestartServices", "ClearTemp", "FlushDNS", "CleanRAM")]
    [string]$Action
)

# Function to write colored output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Function to run main launcher optimization
function Invoke-MainLauncher {
    Write-ColorOutput "Starting Dank BDO Launcher optimization..." "Cyan"
    
    try {
        # Step 1: Clear Temporary Files
        Write-ColorOutput "Clearing temporary files..." "Yellow"
        Get-ChildItem -Path $env:TEMP -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Get-ChildItem -Path "$env:SystemRoot\Temp" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Get-ChildItem -Path "$env:SystemRoot\Prefetch" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-ColorOutput "Temporary files cleared." "Green"
        
        # Step 2: Flush DNS Cache
        Write-ColorOutput "Flushing DNS cache..." "Yellow"
        ipconfig /flushdns | Out-Null
        Write-ColorOutput "DNS cache flushed." "Green"
        
        # Step 3: Release and Renew IP Address
        Write-ColorOutput "Refreshing network connection..." "Yellow"
        Get-NetAdapter | Where-Object {$_.Status -eq "Up" -and $_.InterfaceDescription -like "*Ethernet*"} | ForEach-Object {
            ipconfig /release $_.Name | Out-Null
            ipconfig /renew $_.Name | Out-Null
        }
        Write-ColorOutput "Network connection refreshed." "Green"
        
        # Step 4: Clean RAM Cache
        Write-ColorOutput "Cleaning RAM cache..." "Yellow"
        Start-Process -FilePath "rundll32.exe" -ArgumentList "advapi32.dll,ProcessIdleTasks" -WindowStyle Hidden
        Write-ColorOutput "RAM cache cleanup initiated." "Green"
        
        # Step 5: Stop Unnecessary Windows Services
        Write-ColorOutput "Disabling unnecessary Windows services..." "Yellow"
        $services = @(
            "SysMain", "Spooler", "Fax", "wuauserv", "DiagTrack", "ShellHWDetection", 
            "FDResPub", "FDHost", "iphlpsvc", "TrkWks", "hidserv", "W32Time", 
            "Themes", "wscsvc", "OfflineFiles", "TermService", "RemoteRegistry", 
            "seclogon", "WerSvc", "WpnService", "LicenseManager", "MSIServer", 
            "UserDataSvc_4be6e", "UsoSvc", "TabletInputService", "server", 
            "remoteaccessautoconnectionmanager", "pimindexmaintenancesvc_4be6e", 
            "onesyncsvc_4be6e", "MicrosoftStoreInstallService", 
            "MicrosoftSoftwareShadowCopyProvider", "Hyper-V-VMMS", 
            "Hyper-V-VmSwitchService", "Hyper-V-Host-Compute-Helper", 
            "Hyper-V-Host-Compute-Support", "Hyper-V-Worker-Processor", 
            "Hyper-V-Time Synchronization", "Hyper-V-Integration-Services", 
            "DeliveryOptimization"
        )
        
        foreach ($service in $services) {
            try {
                $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
                if ($svc -and $svc.Status -eq "Running") {
                    Write-ColorOutput "Stopping $service..." "Yellow"
                    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
                    Write-ColorOutput "$service stopped successfully." "Green"
                }
            } catch {
                Write-ColorOutput "Failed to stop $service." "Red"
            }
        }
        
        # Step 6: Apply GPU and Display Settings
        Write-ColorOutput "Optimizing GPU and display settings..." "Yellow"
        try {
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\DirectX" -Name "MaxFRL" -Value 0 -Type DWORD -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "TdrDelay" -Value 10 -Type DWORD -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online\bin64\BlackDesert64.exe" -Value "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" -Type String -Force -ErrorAction SilentlyContinue
            Write-ColorOutput "GPU and display settings optimized." "Green"
        } catch {
            Write-ColorOutput "Warning: Some GPU settings could not be applied." "Yellow"
        }
        
        # Step 7: Set Process Priority and Disable Toast Notifications
        Write-ColorOutput "Setting process priority and disabling notifications..." "Yellow"
        try {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ToastEnabled" -Value 0 -Type DWORD -Force
            Write-ColorOutput "Toast notifications disabled." "Green"
        } catch {
            Write-ColorOutput "Warning: Could not disable toast notifications." "Yellow"
        }
        
        # Step 8: Launch Black Desert Online
        Write-ColorOutput "Launching Black Desert Online..." "Yellow"
        $bdoPath = "C:\Program Files (x86)\Steam\steamapps\common\Black Desert Online"
        if (Test-Path $bdoPath) {
            Set-Location $bdoPath
            Start-Process -FilePath "BlackDesertLauncher.exe" -ArgumentList "-steam" -WindowStyle Normal
            Write-ColorOutput "Black Desert Online launched." "Green"
        } else {
            Write-ColorOutput "Warning: Black Desert Online path not found." "Yellow"
        }
        
        # Display Banner
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "   Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn" "Cyan"
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "######                                ######                           " "Green"
        Write-ColorOutput "#     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # " "Green"
        Write-ColorOutput "#     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # " "Green"
        Write-ColorOutput "#     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # " "Green"
        Write-ColorOutput "#     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # " "Green"
        Write-ColorOutput "#     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## " "Green"
        Write-ColorOutput "######  #    # #    # #    # #  ####  #     # # #      #      # #    # " "Green"
        Write-ColorOutput "=========================================================================" "Green"
        Write-ColorOutput "               Remember to smoke weed and PvP every day." "Yellow"
        Write-ColorOutput "=======================================================================" "Magenta"
        
        Write-ColorOutput "Main launcher optimization completed successfully!" "Green"
        
    } catch {
        Write-ColorOutput "Error during main launcher optimization: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to run network optimization
function Invoke-NetworkOptimizer {
    Write-ColorOutput "Starting network optimization..." "Cyan"
    
    try {
        # DNS Cache Settings
        Write-ColorOutput "Setting DNS Cache Settings..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "CacheHashTableBucketSize" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "CacheHashTableSize" -Value 384 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "MaxCacheEntryTtlLimit" -Value 64000 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "MaxSOACacheEntryTtlLimit" -Value 300 -Type DWORD -Force
        
        # TCP KeepAlive Interval
        Write-ColorOutput "Setting TCP KeepAlive Interval..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "KeepAliveTime" -Value 300000 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "KeepAliveInterval" -Value 2000 -Type DWORD -Force
        
        # TCP/IP Parameters
        Write-ColorOutput "Setting TCP/IP parameters..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxFreeTcbs" -Value 65536 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DefaultTTL" -Value 64 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "SynAttackProtect" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DisableIPSourceRouting" -Value 2 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnablePMTUDiscovery" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnablePMTUBHDetect" -Value 0 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "SackOpts" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "Tcp1323Opts" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpMaxDupAcks" -Value 2 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "GlobalMaxTcpWindowSize" -Value 64240 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpWindowSize" -Value 64240 -Type DWORD -Force
        
        # Network Latency Reduction
        Write-ColorOutput "Setting network latency reduction..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DisableTaskOffload" -Value 1 -Type DWORD -Force
        
        # Enable CTCP Congestion Provider
        Write-ColorOutput "Enabling CTCP Congestion Provider..." "Yellow"
        netsh interface tcp set global congestionprovider=ctcp | Out-Null
        
        # Disable Nagle's Algorithm
        Write-ColorOutput "Disabling Nagle's Algorithm..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpNoDelay" -Value 1 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpDelAckTicks" -Value 0 -Type DWORD -Force
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpAckFrequency" -Value 1 -Type DWORD -Force
        
        # Set DNS to Cloudflare
        Write-ColorOutput "Setting DNS to Cloudflare..." "Yellow"
        try {
            netsh interface ipv4 set dnsservers name="Wi-Fi" source=static addr=1.1.1.1 register=primary | Out-Null
            netsh interface ipv4 add dnsservers name="Wi-Fi" addr=1.0.0.1 index=2 | Out-Null
            netsh interface ipv4 set dnsservers name="Ethernet" source=static addr=1.1.1.1 register=primary | Out-Null
            netsh interface ipv4 add dnsservers name="Ethernet" addr=1.0.0.1 index=2 | Out-Null
            Write-ColorOutput "DNS set to Cloudflare." "Green"
        } catch {
            Write-ColorOutput "Warning: Could not set DNS to Cloudflare." "Yellow"
        }
        
        # Disable SMBv1
        Write-ColorOutput "Disabling SMBv1..." "Yellow"
        try {
            dism /online /norestart /disable-feature /featurename:SMB1Protocol | Out-Null
            Write-ColorOutput "SMBv1 disabled." "Green"
        } catch {
            Write-ColorOutput "Warning: Could not disable SMBv1." "Yellow"
        }
        
        # Disable NetBIOS over TCP/IP
        Write-ColorOutput "Disabling NetBIOS over TCP/IP..." "Yellow"
        try {
            Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true} | ForEach-Object {
                $_.SetTcpipNetbios(2) | Out-Null
            }
            Write-ColorOutput "NetBIOS over TCP/IP disabled." "Green"
        } catch {
            Write-ColorOutput "Warning: Could not disable NetBIOS over TCP/IP." "Yellow"
        }
        
        # Disable LLMNR
        Write-ColorOutput "Disabling LLMNR..." "Yellow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0 -Type DWORD -Force
        
        # Normal Auto-Tuning
        Write-ColorOutput "Setting Auto-Tuning to normal..." "Yellow"
        netsh int tcp set global autotuninglevel=normal | Out-Null
        
        # Apply Changes and Restart Network Services
        Write-ColorOutput "Applying changes and restarting network services..." "Yellow"
        netsh interface ipv4 reset | Out-Null
        netsh interface ipv6 reset | Out-Null
        ipconfig /flushdns | Out-Null
        ipconfig /release | Out-Null
        ipconfig /renew | Out-Null
        
        # Display Banner
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "   Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn" "Cyan"
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "######                                ######                           " "Green"
        Write-ColorOutput "#     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # " "Green"
        Write-ColorOutput "#     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # " "Green"
        Write-ColorOutput "#     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # " "Green"
        Write-ColorOutput "#     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # " "Green"
        Write-ColorOutput "#     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## " "Green"
        Write-ColorOutput "######  #    # #    # #    # #  ####  #     # # #      #      # #    # " "Green"
        Write-ColorOutput "=========================================================================" "Green"
        Write-ColorOutput "               Remember to smoke weed and PvP every day." "Yellow"
        Write-ColorOutput "=======================================================================" "Magenta"
        
        Write-ColorOutput "Network optimization completed successfully!" "Green"
        
    } catch {
        Write-ColorOutput "Error during network optimization: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to run system maintenance
function Invoke-SystemMaintenance {
    Write-ColorOutput "Starting system maintenance..." "Cyan"
    
    try {
        Write-ColorOutput "Performing component cleanup..." "Yellow"
        dism /Online /Cleanup-Image /StartComponentCleanup | Out-Null
        
        Write-ColorOutput "Checking component health..." "Yellow"
        dism /Online /Cleanup-Image /checkHealth | Out-Null
        
        Write-ColorOutput "Scanning system integrity..." "Yellow"
        dism /Online /Cleanup-Image /scanHealth | Out-Null
        
        Write-ColorOutput "Restoring system components..." "Yellow"
        dism /Online /Cleanup-Image /RestoreHealth | Out-Null
        
        Write-ColorOutput "Checking system file integrity..." "Yellow"
        sfc /scannow | Out-Null
        
        # Display Banner
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "   Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn" "Cyan"
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "######                                ######                           " "Green"
        Write-ColorOutput "#     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # " "Green"
        Write-ColorOutput "#     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # " "Green"
        Write-ColorOutput "#     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # " "Green"
        Write-ColorOutput "#     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # " "Green"
        Write-ColorOutput "#     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## " "Green"
        Write-ColorOutput "######  #    # #    # #    # #  ####  #     # # #      #      # #    # " "Green"
        Write-ColorOutput "=========================================================================" "Green"
        Write-ColorOutput "               Remember to smoke weed and PvP every day." "Yellow"
        Write-ColorOutput "=======================================================================" "Magenta"
        
        Write-ColorOutput "System maintenance completed successfully!" "Green"
        
    } catch {
        Write-ColorOutput "Error during system maintenance: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to restart services
function Invoke-RestartServices {
    Write-ColorOutput "Starting essential Windows services..." "Cyan"
    
    try {
        $services = @(
            "ShellHWDetection", "Winmgmt", "SysMain", "WSearch", "Spooler", "Fax", 
            "wuauserv", "DiagTrack", "BthHFSrv", "FDResPub", "FDHost", "iphlpsvc", 
            "TrkWks", "hidserv", "W32Time", "Themes", "wscsvc", "OfflineFiles", 
            "TermService", "RemoteRegistry", "seclogon", "WerSvc", "WpnService", 
            "LicenseManager", "MSIServer", "UserDataSvc_4be6e", "UsoSvc", 
            "TabletInputService", "server", "remoteaccessautoconnectionmanager", 
            "pimindexmaintenancesvc_4be6e", "onesyncsvc_4be6e", 
            "MicrosoftStoreInstallService", "MicrosoftSoftwareShadowCopyProvider", 
            "Hyper-V-VMMS", "Hyper-V-VmSwitchService", "Hyper-V-Host-Compute-Helper", 
            "Hyper-V-Host-Compute-Support", "Hyper-V-Worker-Processor", 
            "Hyper-V-Time Synchronization", "Hyper-V-Integration-Services", 
            "DeliveryOptimization"
        )
        
        foreach ($service in $services) {
            try {
                $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
                if ($svc -and $svc.Status -ne "Running") {
                    Write-ColorOutput "Starting $service..." "Yellow"
                    Start-Service -Name $service -ErrorAction SilentlyContinue
                    Write-ColorOutput "$service started successfully." "Green"
                } else {
                    Write-ColorOutput "$service is already running." "Green"
                }
            } catch {
                Write-ColorOutput "$service could not be started." "Red"
            }
        }
        
        # Display Banner
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "   Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn Lahn" "Cyan"
        Write-ColorOutput "======================================================================" "Magenta"
        Write-ColorOutput "######                                ######                           " "Green"
        Write-ColorOutput "#     #   ##   #    # #    # #  ####  #     # # #####  #####  # #    # " "Green"
        Write-ColorOutput "#     #  #  #  ##   # #   #  # #      #     # # #    # #    # # ##   # " "Green"
        Write-ColorOutput "#     # #    # # #  # ####   #  ####  ######  # #    # #    # # # #  # " "Green"
        Write-ColorOutput "#     # ###### #  # # #  #   #      # #   #   # #####  #####  # #  # # " "Green"
        Write-ColorOutput "#     # #    # #   ## #   #  # #    # #    #  # #      #      # #   ## " "Green"
        Write-ColorOutput "######  #    # #    # #    # #  ####  #     # # #      #      # #    # " "Green"
        Write-ColorOutput "=========================================================================" "Green"
        Write-ColorOutput "               Remember to smoke weed and PvP every day." "Yellow"
        Write-ColorOutput "=======================================================================" "Magenta"
        
        Write-ColorOutput "Essential services started successfully!" "Green"
        
    } catch {
        Write-ColorOutput "Error during service restart: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to clear temporary files
function Invoke-ClearTempFiles {
    Write-ColorOutput "Clearing temporary files..." "Cyan"
    
    try {
        Get-ChildItem -Path $env:TEMP -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Get-ChildItem -Path "$env:SystemRoot\Temp" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Get-ChildItem -Path "$env:SystemRoot\Prefetch" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-ColorOutput "Temporary files cleared successfully!" "Green"
    } catch {
        Write-ColorOutput "Error clearing temporary files: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to flush DNS
function Invoke-FlushDNS {
    Write-ColorOutput "Flushing DNS cache..." "Cyan"
    
    try {
        ipconfig /flushdns | Out-Null
        Write-ColorOutput "DNS cache flushed successfully!" "Green"
    } catch {
        Write-ColorOutput "Error flushing DNS cache: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Function to clean RAM
function Invoke-CleanRAM {
    Write-ColorOutput "Cleaning RAM cache..." "Cyan"
    
    try {
        Start-Process -FilePath "rundll32.exe" -ArgumentList "advapi32.dll,ProcessIdleTasks" -WindowStyle Hidden
        Write-ColorOutput "RAM cache cleaned successfully!" "Green"
    } catch {
        Write-ColorOutput "Error cleaning RAM cache: $($_.Exception.Message)" "Red"
        exit 1
    }
}

# Main execution logic
switch ($Action) {
    "MainLauncher" { Invoke-MainLauncher }
    "NetworkOptimizer" { Invoke-NetworkOptimizer }
    "SystemMaintenance" { Invoke-SystemMaintenance }
    "RestartServices" { Invoke-RestartServices }
    "ClearTemp" { Invoke-ClearTempFiles }
    "FlushDNS" { Invoke-FlushDNS }
    "CleanRAM" { Invoke-CleanRAM }
    default {
        Write-ColorOutput "Invalid action specified. Valid actions are: MainLauncher, NetworkOptimizer, SystemMaintenance, RestartServices, ClearTemp, FlushDNS, CleanRAM" "Red"
        exit 1
    }
} 