<#
.SYNOPSIS
    Create new portgroup on vDS
.DESCRIPTION
    Create new portgroup on vDS
.NOTES
    File Name      : New-VMHostNetworkAdapter.ps1
    Author         : Trim Hajdari
    Date           : 2017.07.17
    Prerequisite   : vSphere 6.0 Update 3, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>

New-VMHostNetworkAdapter -VMHost "adcezrhcmp003.democenter.zh" -PortGroup "pg-vMO" -VirtualSwitch "vDS-01" -IP 10.48.20.23 -SubnetMask 255.255.255.0 -Mtu 9000 -VMotionEnabled:$true
New-VMHostNetworkAdapter -VMHost "adcezrhcmp003.democenter.zh" -PortGroup "pg-vSAN" -VirtualSwitch "vDS-01" -IP 10.48.21.13 -SubnetMask 255.255.255.0 -Mtu 9000 -VsanTrafficEnabled:$true

