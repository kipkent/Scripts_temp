$SecurePWd = ConvertTo-SecureString 'example' -AsPlainText -Force
$DomainJoinCred = New-Object System.Management.Automation.PSCredential ("example", $SecurePWd )
 
Remove-computer -WorkgroupName yourWorkgroup -Credential $DomainJoinCred -Force