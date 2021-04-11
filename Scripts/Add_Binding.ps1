#Assigining the URL which need to bind
$_WebsiteUrl = "ar.mybag.mytestbox.cet.ac.il"
#Name of the WEB SITE name created under Sites Folder(IIS)
$_TargetIISWebsite ="MyBag"

New-WebBinding -Name $_TargetIISWebsite -IPAddress "*" -Port 80 -protocol http -HostHeader $_WebsiteUrl
#  New-WebBinding -Name $_TargetIISWebsite -IPAddress "*" -Port 443 -protocol https -HostHeader $Website -sslflags  
write-host $_WebsiteUrl "Binding created successfully on" $_TargetIISWebsite  "in" $env:COMPUTERNAME
