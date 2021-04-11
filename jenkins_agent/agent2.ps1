# Install Slaves jar and connect via JNLP
# Jenkins plugin will dynamically pass the server name and vm name.
# If your jenkins server is configured for security , make sure to edit command for how slave executes
$jenkinsserverurl = "http://cetjenkins.cet.ac.il:8080"
$vmname = "devbuild520240"
$secret = "3c6db3dd77a0d486f7cf73f42d29b83dc5ff1ac05ccc8d32763e761315d62d72"
$workFolder = "C:\jenkins"

Write-Output "Executing agent process "
$configExec = "C:\Program Files\Java\jre1.8.0_121\bin\java.exe" 
$configArgs = "-jnlpUrl $jenkinsserverurl/computer/$vmname/slave-agent.jnlp -secret ${secret} -workDir=C:\jenkins" 

write-host $configArgs
write-host $configExec