Import-Module WebAdministration
$computer = $Env:Computername
$iisAppPoolName = "LearningService"
#$iisAppPoolDotNetVersion = "v4.0"
$iisAppPoolDotNetVersion = ""
$iisAppNameUrl = "example.com"
$iisAppSiteName = $iisAppPoolName
$directoryPath = "D:\Inetpub\example"
$directoryPathCreate = "D:\Inetpub"
$NewPathFolder = "example"

#Check Path folder
if (Test-Path -path $directoryPath)
{
	#New-Item $directoryPath -Type Directory
	write-host "We have PathFolder in" $computer
}
else
{
#create folder
	New-Item -Path $directoryPathCreate -Name $NewPathFolder -ItemType "directory"
	write-host "New PathFolder $NewPathFolder created in" $computer
}
#navigate to the app pools root
cd IIS:\AppPools\

#check if the app pool exists
if (!(Test-Path $iisAppPoolName -pathType container))
{
    #create the app pool
    $appPool = New-Item $iisAppPoolName
    $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
	write-host "New AppPools $iisAppPoolName created in" $computer
}
else
{
	write-host "AppPools $iisAppPoolName exists in" $computer
}

#navigate to the sites root
cd IIS:\Sites\

#check if the site exists
if (Test-Path $iisAppSiteName -pathType container)
{
    write-host "Site $iisAppSiteName exists in" $computer
	write-host "*"
	return
}
#create the site
else
{
$iisApp = New-Item $iisAppSiteName -bindings @{protocol="http";bindingInformation="*:80:" + $iisAppNameUrl} -physicalPath $directoryPath
$iisApp | Set-ItemProperty -Name "applicationPool" -Value $iisAppPoolName
write-host "New Site $iisAppSiteName created in" $computer
write-host "*"
}