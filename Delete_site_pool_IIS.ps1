Import-Module WebAdministration
$computer = $Env:Computername
$name = "ActivityApiService"

C:\Windows\System32\inetsrv\appcmd.exe stop apppool /apppool.name:$name
Remove-Item IIS:\Sites\$name -r
Remove-Item IIS:\AppPools\$name -r
write-host "$name deleted in" $computer