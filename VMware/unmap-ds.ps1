<#
.SYNOPSIS
    Perform VMFSUnmap
.DESCRIPTION
    Create new portgroup on vDS
.NOTES
    File Name      : unmap-ds.ps1
    Author         : Trim Hajdari
    Date           : 2017.07.17
    Prerequisite   : vSphere 6.0 Update 3, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>

Function Perform-VMFSUnmap {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true)]
            [String[]]$Datastore,
            [String]$ESXiHost
        )
Set-PowerCLIConfiguration -WebOperationTimeoutSeconds -1 -Scope Session -Confirm:$false
$ESXHost = Get-VMHost $ESXiHost
$DatastoreName = Get-Datastore $Datastore
Write-Host 'Using ESXCLI and connecting to $VMHost' -ForegroundColor Green
$esxcli = Get-EsxCli -VMHost $ESXHost
Write-Host 'Unmapping $Datastore on $VMHost' -ForegroundColor Green
$esxcli.storage.vmfs.unmap($null,$DatastoreName,$null)
}

Perform-VMFSUnmap -ESXiHost adcezrhmgt001.democenter.zh -Datastore ds_58068_200E
