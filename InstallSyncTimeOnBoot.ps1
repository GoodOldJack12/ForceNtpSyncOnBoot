$Application_Name="ForceNtpSyncOnBoot"
$Application_URL="http://www.github.com/GoodOldJack12/ForceNtpSyncOnBoot/archive/master.zip"
$Startup_Script="SyncTimeOnBoot.ps1"

$Application_Path="$((Get-WmiObject Win32_OperatingSystem).SystemDrive)\Program Files\$($Application_Name)"
$Startup_Folder_Path="$($env:USERPROFILE)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

echo "Creating folder: $Application_Path"
New-Item -ItemType directory -Path $Application_Path -ErrorAction SilentlyContinue

$tempdownloadpath = "$env:TEMP\$($Application_Name).zip"
echo "$tempdownloadpath"
$wc = New-Object System.Net.WebClient

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $Application_URL -Out $tempdownloadpath

function FindActualScriptPath{
    return $(Get-Childitem –Path $Application_Path -Include *$Startup_Script* -File -Recurse -ErrorAction SilentlyContinue).FullName
}
Expand-Archive $tempdownloadpath -DestinationPath $Application_Path -Force
$finalStartScriptPath="$("$Startup_Folder_Path\$Application_Name").bat"
Remove-Item $finalStartScriptPath -ErrorAction SilentlyContinue
New-Item $finalStartScriptPath
Add-Content $finalStartScriptPath 'PowerShell -Command "Set-ExecutionPolicy Unrestricted" >> "%TEMP%\StartupLog.txt" 2>&1' 
Add-Content $finalStartScriptPath "PowerShell $(FindActualScriptPath) >> %TEMP%\StartupLog.txt 2>&1"

