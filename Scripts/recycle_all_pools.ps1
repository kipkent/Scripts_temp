Write-Host "App Pool Recycling Started...." -ForegroundColor Magenta 
& $env:windir\system32\inetsrv\appcmd list apppools /state:Started /xml | & $env:windir\system32\inetsrv\appcmd recycle apppools /in
Write-Host "App Pool Recycling Completed" -ForegroundColor Magenta