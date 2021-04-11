<#
.SYNOPSIS
	Removes web binding from web site
.DESCRIPTION
	Removes web binding from web site and also its certificate binding from SSL store
.PARAMETER Site
	Name of website to create new web binding
.PARAMETER Type
	Protocol type for web binding (HTTP or HTTPS)
.PARAMETER IP
	IP address to bind to website
.PARAMETER Port
	Port number to bind to website
.PARAMETER HostHeader
	Header name for this web binding
.EXAMPLE
	Remove-IWebSiteBinding -Site "MyNewWebSite" -Type HTTP -IP 192.168.1.1 -Port 8080
	===================================================================================
	Removes web binding from "MyNewWebSite"
.NOTES
	ITaCS GmbH, Berlin 2013
	Author: Waldemar Schmidt
	Mail: scripting@itacs.de
	$LastChangedRevision: 2 $
	Last changed: $LastChangedDate: 2013-09-05 12:42:55 +0200 (Do, 05 Sep 2013) $
.LINK
	www.ITaCS.de
#>

function Remove-IIISSiteBinding
{
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory=$True)]
		[string]$Site,

		[Parameter(Mandatory=$True)]
		[string]$Type,

		[Parameter(Mandatory=$True)]
		[string]$IP,

		[Parameter(Mandatory=$True)]
		[int]$Port,

		[string]$HostHeader
	)

	Begin
	{
		# Import WebAdministration module
		Import-Module WebAdministration
	}
	
	Process
	{
		$location = Get-Location

		# Remove binding form site
		Remove-WebBinding -HostHeader $HostHeader -Name $Site -Port $Port -Protocol $Type -IPAddress $IP

		# Remove binding in SSLBindings store
		Get-Item IIS:\SslBindings\$IP!$Port | Remove-Item
		Write-Output "Binding removed"
	}
	
	End
	{}
}