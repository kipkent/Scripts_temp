$file = Get-Content D:\JenkinsSlave\jenkins-slave.xml;
$olduri = "http://172.16.0.51:8080/computer/test/slave-agent.jnlp"
$newuri = Get-Content D:\utils\JenkinsTools\slavepath.txt
$newsecret = Get-Content D:\utils\JenkinsTools\slavepath.txt
$oldsecret = "ff865bd53f27f44ea51bb46ebfd76792d9c29cc5364148cbed5d87f7abe4a76e"
$file -Replace '$olduri', '$newuri'
$file -Replace '$oldsecret', '$newsecret'
Restart-Service jenkinsslave-D__JenkinsSlave




_____________________________________________________________________________________________
C:\Windows\System32\sc.exe stop jenkinsslave-c__jenkins
$configFile = "C:\Jenkins\jenkins-slave.xml"
$configExec = "$vmname"
$configExec2 = "$secret"
(Get-Content $configFile).replace('AutomationExecutor-azure-vm', $configExec) | Set-Content $configFile
(Get-Content $configFile).replace('50fdd9e0ba2708d48df000b36331c8b82ec9ccf3f4c638c394dc2f1a138d0dad', $configExec2) | Set-Content $configFile
C:\Windows\System32\sc.exe start jenkinsslave-c__jenkins
