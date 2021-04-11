C:\Windows\System32\inetsrv\appcmd.exe stop apppool /apppool.name:EnvironmentAPI
Import-Module WebAdministration
Set-ItemProperty -Path IIS:\AppPools\EnvironmentAPI -Name managedRuntimeVersion -Value ''
C:\Windows\System32\inetsrv\appcmd.exe start apppool /apppool.name:EnvironmentAPI
C:\Windows\System32\inetsrv\appcmd.exe recycle apppool /apppool.name:EnvironmentAPI