<#
.SYNOPSIS
    Adds ESXi hosts to cluster UCP-Compute01 
.DESCRIPTION
    Adds ESXi hosts to cluster UCP-Compute01 
.NOTES
    File Name      : 01_add_esxi_hosts_compute_cluster.ps1
    Location       : D:\_Administrator\_Scripts\VMware\01_add_esxi_hosts_compute_cluster.ps1
    Content	   	   : D:\_Administrator\_Scripts\VMware\01_esxi_hosts.txt
    Author         : Trim Hajdari
    Date           : 2018.04.04
    Prerequisite   : vSphere 6.5, PowerShell v5+, powercli 6.5,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Hitachi Vantara : https://www.hitachivantara.com
#>

$vCenter="vcenter"
$vCenterUser="administrator@vsphere.local"
$vCenterUserPassword="xxxx"
$Clustername="Compute01"

# Specify the ESXi host you want to add to vCenter Server and the user name and password to be used.
$esxihosts= Get-Content D:\_Administrator\_Scripts\VMware\01-esxi-hosts.txt
$esxihostuser="root"
$esxihostpasswd="xxxx"


write-host --------
write-host Start adding ESXi hosts to the vCenter Server $vCenter
write-host --------

foreach ($esxihost in $esxihosts) {
Add-VMHost $esxihost -Location $Clustername -User $esxihostuser -Password $esxihostpasswd -Force
}
#
write-host --------
write-host ESXi Host added to the vCenter!
write-host --------
