<#
.SYNOPSIS
    Get all user account in ESXi-Hosts
.DESCRIPTION
    Get all user account in ESXi-Hosts
.NOTES
    File Name      : Get-localusersesxi.ps1
    Author         : Trim Hajdari
    Date           : 2018.05.28
    Prerequisite   : vSphere 6.5, PowerShell v4+, powercli 10
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>

$esxcred = Get-Credential
$vcentercred = Get-Credential

Connect-VIServer -server vcenterserver -Credential $vcentercred

Get-VMHost  | %{
  $esx = Connect-VIServer $_.Name -Credential $esxcred
  Get-VMHostAccount -Server $esx |
  Select @{N="Host";E={$esx.Name}},@{N="Name";E={$_.ExtensionData.FullName}}
  Disconnect-VIServer -Server $esx -Confirm:$false
} | sort Host | export-csv C:\Temp\localusersesxi.csv
