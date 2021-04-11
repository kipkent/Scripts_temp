#Assigining the URL which need to bind
$_WebsiteUrl = "test.com"
#Name of the WEB SITE name created under Sites Folder(IIS)
$_TargetIISWebsite ="example"

New-WebBinding -Name $_TargetIISWebsite -IPAddress "*" -Port 80 -protocol http -HostHeader $_WebsiteUrl
#  New-WebBinding -Name $_TargetIISWebsite -IPAddress "*" -Port 443 -protocol https -HostHeader $Website -sslflags  
write-host $_WebsiteUrl "Binding created successfully on" $_TargetIISWebsite  "in" $env:COMPUTERNAME
