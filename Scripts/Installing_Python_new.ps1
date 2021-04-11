$computername = 'example'
$sourcefile = "\\example\d$\python-2.7.18.amd64.msi"


foreach ($computer in $computername) {
	$destinationFolder = "\\$computer\C$\admin"
	
	if (!(Test-Path -path $destinationFolder)) {
		New-Item $destinationFolder -Type Directory
	}
	Copy-Item -Path $sourcefile -Destination $destinationFolder | Wait-Job
	$c = Invoke-Command -ComputerName $computer -ScriptBlock {Start-Process msiexec.exe -Wait -ArgumentList '/i c:\admin\python-2.7.18.amd64.msi TARGETDIR=c:\python27 ALLUSERS=1 /qn'}
	$d = Invoke-Command -ComputerName $computer -ScriptBlock {Start-Process C:\python27\Scripts\pip.exe -Wait -ArgumentList 'install requests'}
	Write-Output "log"
	$c
	write-host "python installed successfully on" $computer
	write-output $d $c
	}