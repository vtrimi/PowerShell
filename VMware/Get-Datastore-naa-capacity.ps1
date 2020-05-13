<#
.SYNOPSIS
    Get the NAA and capacity
.DESCRIPTION
    Get the NAA and capacity
.NOTES
    File Name      : Get-Datastore-naa-capacity.ps1
    Author         : Trim Hajdari
    Date           : 2017.07.17
    Prerequisite   : vSphere 6.0 Update 3, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>


$AllDS = Get-Datastore
$results = @()
foreach ($ds in $AllDS) {
$dsview = $ds | Get-View
$resultsarray = "" | Select "DatastoreName","CanonicalName","CapacityGB","FreeSpaceGB"
$resultsarray."DatastoreName" = $ds.Name
$resultsarray."CanonicalName" = $dsview.info.vmfs.extent
$resultsarray."CapacityGB" = $ds.CapacityGB
$resultsarray."FreeSpaceGB" = $ds.FreeSpaceGB
$results += $resultsarray
}
$results | Sort-Object DatastoreName | ft -autosize
