# Dank BDO Launcher - Ultimate Optimization Suite

A **native Windows Forms application** that provides a beautiful, professional interface for Black Desert Online optimization scripts and system performance tools.

## 🎮 **What This Is**

A modern Windows application that replaces command-line batch files with a beautiful, user-friendly interface. All your existing optimization scripts are preserved and enhanced with:

- **Professional Gaming Theme**: Dark colors, rounded corners, modern design
- **Real Functionality**: Actually executes your batch files and PowerShell scripts
- **Progress Tracking**: Shows real-time execution progress
- **Error Handling**: User-friendly error messages and status updates
- **Your Signature Style**: Maintains "Lahn Lahn Lahn" aesthetic

## 🚀 **Features**

### **Main Launcher**
- Complete system optimization and game launch
- Temporary file cleanup, DNS flush, network refresh
- RAM cleanup, service optimization, GPU settings
- Automatic Black Desert Online launch

### **Network Optimizer**
- Advanced TCP/IP configuration for reduced latency
- DNS cache optimization and Cloudflare DNS setup
- Congestion provider and Nagle's algorithm disable
- SMBv1, NetBIOS, and LLMNR security enhancements

### **System Maintenance**
- DISM component cleanup and restoration
- System file integrity checks (SFC)
- Comprehensive system health assessment

### **Service Manager**
- Windows service control and restoration
- Essential service management after optimization

### **Quick Actions**
- Individual optimization tools
- Temp file cleanup, DNS flush, RAM optimization

## 📋 **Requirements**

- **Windows 10/11** (64-bit)
- **.NET 5.0 SDK** - Download from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download)
- **Your existing batch files** (`launch.bat`, `launcher.ps1`)

## 🛠️ **Quick Start**

1. **Install .NET 5.0 SDK** from Microsoft
2. **Clone this repository** or download the files
3. **Double-click `BaR.bat`** to build and run
4. **Application launches automatically**
5. **Click any optimization button to run your scripts!**

## 📁 **Project Structure**

```
Dank BDO Launcher/
├── DankBDOLauncher.csproj    # C# project file
├── MainForm.cs               # Main application window
├── Program.cs                # Application entry point
├── BaR.bat                  # Build and run script
├── launch.bat                # Batch file launcher
├── launcher.ps1              # PowerShell backend
├── README.md                 # This file
├── WINDOWS_APP_README.md     # Detailed documentation
├── PROJECT_OVERVIEW.md       # Quick overview
└── [Your existing batch files]
```

## 🔧 **How It Works**

1. **Application starts** and displays your optimization tools
2. **Click any button** to execute the corresponding action
3. **Progress bar shows** execution progress
4. **Status updates** display real-time information
5. **Your batch files run** exactly as they would manually

## 🎯 **Why Windows Forms Instead of HTML?**

| Feature | HTML/Web | Windows Forms |
|---------|----------|---------------|
| **Execution** | ❌ Blocked by browsers | ✅ Direct system access |
| **Dependencies** | ❌ Node.js, servers | ✅ Just .NET runtime |
| **Security** | ❌ Browser restrictions | ✅ Full Windows API access |
| **Performance** | ❌ Web overhead | ✅ Native performance |
| **Reliability** | ❌ Network/server issues | ✅ Always works |
| **User Experience** | ❌ Browser limitations | ✅ Professional app |

## 🎨 **Customization**

The application is designed to be easily extensible:
- Add new optimization features to `launcher.ps1`
- Update the `launch.bat` parameter validation
- Add new cards to the interface in `MainForm.cs`

## 🔒 **Security & Trust**

- **Runs locally** on your machine
- **No internet connection** required
- **Direct access** to your batch files
- **No external dependencies** after build
- **Single executable** file

## 🏆 **Credits**

**Dank Tools - Credit to DankisRippin**

Remember to smoke weed and PvP every day! 🎮🌿

---

## 📝 **License**

This tool is provided as-is for educational and personal use. Use at your own risk and ensure you have proper backups before running system optimizations.

## 🔒 **Security Notice**

This tool modifies system settings and registry values. Only run on systems you own and trust. Some optimizations may temporarily disable security features for performance gains.

---

**For detailed documentation, see `WINDOWS_APP_README.md`** # BdoOpti
