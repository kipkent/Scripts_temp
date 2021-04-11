$computername = 'example'

foreach ($computer in $computername) {
	
	$d = Invoke-Command -ComputerName $computer -ScriptBlock {Start-Process msiexec.exe -Wait -ArgumentList '/x C:\admin\python-2.7.18.amd64.msi /qb'}
	write-host "python Uninsulated successfully on" $computer
	write-output $d
	}





