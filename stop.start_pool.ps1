param($iisAppPool)
$computer = $Env:Computername
C:\Windows\System32\inetsrv\appcmd.exe stop apppool /apppool.name:$iisAppPool
write-host "$iisAppPool in $computer"
sleep 10
C:\Windows\System32\inetsrv\appcmd.exe start apppool /apppool.name:$iisAppPool
write-host "$iisAppPool in $computer"