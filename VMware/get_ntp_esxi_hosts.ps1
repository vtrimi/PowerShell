<#
.SYNOPSIS
    show ntp on esxi-hosts
.DESCRIPTION
    Create new portgroup on vDS
.NOTES
    File Name      : get_ntp_esxi_hosts.ps1
    Author         : Trim Hajdari
    Date           : 2017.07.17
    Prerequisite   : vSphere 6.0 Update 3, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>


foreach($esxcli in get-vmhost|get-esxcli){""|select @{n='Time';e={$esxcli.system.time.get()}},@{n='hostname';e={$esxcli.system.hostname.get().hostname}} } 
$report | Export-CSV  -NoTypeInformation -UseCulture -Path C:\NTP-$date.csv"

