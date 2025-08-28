# Dank BDO Launcher - Windows Forms Application

## 📋 **Requirements**

- **Windows 10/11** (64-bit)
- **.NET 5.0 SDK** - Download from [https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-5.0.408-windows-x64-installer](https://dotnet.microsoft.com/download)
- **Your existing batch files** (`launch.bat`, `launcher.ps1`)

## 🛠️ **How to Build and Run**

### **Option 1: Automatic Build (Recommended)**
1. **Place "credit to DankisRippin" folder in the c:\ location: c:\credit to DankisRippin**
2. **Right click `BaR.bat` and select "Run as administrator"**
3. **Wait for build to complete**
4. **Application launches automatically**

### **Option 2: Manual Build**
1. **Open Command Prompt** in this directory
2. **Run commands:**
   ```cmd
   dotnet restore
   dotnet build --configuration Release
   dotnet run
   ```

