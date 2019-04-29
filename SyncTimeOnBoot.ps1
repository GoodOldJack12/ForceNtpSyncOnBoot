while(!(Test-Connection -ComputerName pool.ntp.org -Quiet)){
    echo "no internet connection, retrying in 5 seconds"
    Start-Sleep -Seconds 5
}
echo "attempting to sync time"
Set-Service 'w32time' -StartupType Automatic
Net start w32time
w32tm /config /manualpeerlist:"pool.ntp.org" /syncfromflags:manual /reliable:yes /update
W32tm /resync /force