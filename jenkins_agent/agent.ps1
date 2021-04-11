# Install Slaves jar and connect via JNLP
# Jenkins plugin will dynamically pass the server name and vm name.
# If your jenkins server is configured for security , make sure to edit command for how slave executes
$jenkinsserverurl = "http://cetjenkins.cet.ac.il:8080"
$vmname = "devbuild520240"
$secret = "3c6db3dd77a0d486f7cf73f42d29b83dc5ff1ac05ccc8d32763e761315d62d72"
$workFolder = "C:\jenkins"
#$javaHome = "C:\Program Files\Java\jre1.8.0_121"

# Downloading jenkins slaves jar
Write-Output "Downloading jenkins slave jar "
mkdir c:\jenkins
$slaveSource = $jenkinsserverurl + "jnlpJars/slave.jar"
$destSource = "c:\jenkins\slave.jar"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($slaveSource, $destSource)

# Download the service wrapper
$wrapperExec = "c:\jenkins\jenkins-slave.exe"
$configFile = "c:\jenkins\jenkins-slave.xml"
#robocopy c:\workspace c:\jenkins jenkins-slave.exe
#$wc.DownloadFile("https://github.com/kohsuke/winsw/releases/download/winsw-v2.1.2/WinSW.NET2.exe", $wrapperExec)
$wc.DownloadFile("http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/2.9.0/winsw-2.9.0-net4.exe", $wrapperExec)
$wc.DownloadFile("https://raw.githubusercontent.com/Azure/jenkins/master/agents_scripts/jenkins-slave.exe.config", "c:\jenkins\jenkins-slave.exe.config")
$wc.DownloadFile("https://raw.githubusercontent.com/Azure/jenkins/master/agents_scripts/jenkins-slave.xml", $configFile)

# Prepare config
Write-Output "Executing agent process "
$configExec = "C:\Program Files\Java\jre1.8.0_121\bin\java.exe"
$configArgs = "-jnlpUrl `"${jenkinsserverurl}/computer/${vmname}/slave-agent.jnlp`" -noReconnect" " -secret `"$secret`"" " -workDir= `"$workFolder`"" 

(Get-Content $configFile).replace('@JAVA@', $configExec) | Set-Content $configFile
(Get-Content $configFile).replace('@ARGS@', $configArgs) | Set-Content $configFile
(Get-Content $configFile).replace('@SLAVE_JAR_URL', $slaveSource) | Set-Content $configFile

# Install the service
& $wrapperExec install
& $wrapperExec start