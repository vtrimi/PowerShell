<#
.SYNOPSIS
    Show RDMs 
.DESCRIPTION
    Show RDMs 
.NOTES
    File Name      : Get-RDMs.ps1
    Author         : Trim Hajdari
    Date           : 2017.07.17
    Prerequisite   : vSphere 6.5, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>

Get-VM | Get-HardDisk | Where-Object {$_.DiskType -like “Raw*”} | Select @{N=”VMName”;E={$_.Parent}},Name,DiskType,@{N=”LUN_ID”;E={$_.ScsiCanonicalName}},@{N=”VML_ID”;E={$_.DeviceName}},Filename,CapacityGB | Export-Csv C:\temp\RDM-list.csv -NoTypeInformation
