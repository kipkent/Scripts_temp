$jenkinsserverurl = $args[0]
$vmname = $args[1]
$secret = $args[2]
$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address
$ip = $ipV4.IPAddressToString

#wins server
netsh interface ip set wins name="Ethernet" source=static addr=172.16.1.58
netsh interface ip set wins name="Ethernet 2" source=static addr=172.16.1.58
tzutil /s "Israel Standard Time"
C:\Windows\System32\sc.exe stop jenkinsslave-c__jenkins
timeout /t 5

#Add data for jenkins agent
$configFile = "C:\jenkins\run.bat"
$configExec = "$vmname"
$configExec2 = "$secret"
(Get-Content $configFile).replace('vnm2323232323', $configExec) | Set-Content $configFile
(Get-Content $configFile).replace('sec3123123123123123', $configExec2) | Set-Content $configFile

#regedit Disable_Privacy_settings for first log on user
regedit.exe /S "C:\jenkins\Disable_Privacy_settings.reg"

#triger job RDP in jenkins
timeout /t 5
java -jar c:\jenkins\jenkins-cli.jar -auth alexk:111be566883e31cd15260d91a94190486 -s http://cetjenkins-jobs.cet.ac.il:8080/ -webSocket build RDP_connection -p ServerIP=$ip

#Change Hosts file
cmdkey /add:hps /user:cetil\aut /pass:assafm123321!
timeout /t 2
#\\hps\ICT\KB\System\SwitchHosts\SWITCH_TO_HOTFIX.cmd


