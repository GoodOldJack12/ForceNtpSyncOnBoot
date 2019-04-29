PowerShell -Command "Set-ExecutionPolicy Unrestricted" >> "%TEMP%\StartupLog.txt" 2>&1 
PowerShell D:\Code\Powershell\Personal\SyncTimeOnBoot.ps1 >> "%TEMP%\StartupLog.txt" 2>&1

