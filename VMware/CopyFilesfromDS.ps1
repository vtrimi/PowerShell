<#
.SYNOPSIS
    Copy from one Datastore in the other Datastore
.DESCRIPTION
    Get the NAA and capacity
.NOTES
    Author         : Trim Hajdari
    Date           : 2025.05.19
    Prerequisite   : vSphere 8
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>


$datacenterName = "DC_XX"
$datastoreName1 = "DS01"
$datastoreName2 = "DS02"

# Build the path
$path1 = "vmstore:\$datacenterName\$datastoreName1\ISO\*"
$path2 = "vmstore:\$datacenterName\$datastoreName2\TEST1"

Copy-DatastoreItem -Item "$path1" -Destination "$path2" -Force -Verbose
-------------------
Get-ChildItem -Path $path1 | Where-Object { $_.PSIsContainer }
Get-ChildItem -Path $path2 | Where-Object { $_.PSIsContainer }
