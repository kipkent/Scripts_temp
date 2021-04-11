$computername = 'example'

foreach ($computer in $computername) {
	$destinationFolder = "\\$computer\C$\python24\Tools"
	if (Test-Path -path $destinationFolder){
	Invoke-Command -ComputerName $computer -ScriptBlock {Start-Process msiexec.exe -Wait -ArgumentList '/x C:\admin\python-2.7.18.amd64.msi /qb'}
	write-host "python Uninsulated successfully on" $computer}
	else {
		write-host "python Uninsulated later on" $computer}
	}