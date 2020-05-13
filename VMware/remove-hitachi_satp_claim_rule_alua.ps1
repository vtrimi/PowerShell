<#
.SYNOPSIS
    Remove Hitachi SATP Claim Rule Script Alua 
.DESCRIPTION
    Remove Claim Rule Script Alua Hitachis 
.NOTES
    File Name      : remove-hitachi_satp_claim_rule_alua.ps1
    Author         : Trim Hajdari
    Date           : 2018.08.30
    Prerequisite   : vSphere 6.5, PowerShell v4+, powercli 6.3,
    Copyright      : MIT
    Version        : 0.1
.LINK
    Github		   : https://github.com/vtrimi/scripts/tree/master/VMware
#>


$vmhosts = Get-cluster "ADCCZRHMGT001" | get-vmhost
foreach( $ESXHost in $vmhosts) {
Get-VMHost $ESXHost | Get-VMHostHba -Type "FibreChannel" | Get-ScsiLun -LunType "disk" | where{$_.MultipathPolicy -ne "RoundRobin"} | Set-ScsiLun -MultipathPolicy RoundRobin
$esxcli = Get-ESXcli -vmhost $ESXHost

try {
$esxcli.storage.nmp.satp.rule.remove($null,"tpgs_on", 
"HITACHI custom SATP Claimrule", $null, $null, $null, "OPEN-V", 
$null,"VMW_PSP_RR","iops=1", "VMW_SATP_ALUA", $null,
$null,"HITACHI")
Write-host "SATP List Succesfully removed from ESXi Host $ESXHost`n" -ForegroundColor Green
} 
catch {
write-host "SATP Rule for HITACHI OPEN-V already removed on $ESXHost" -ForegroundColor Yellow
}
}

# now reload all claim rules
$esxcli.storage.claimrule.load
$esxcli.storage.claimrule.run
 
# rescan all HBAs
Get-VMHost | Get-VMHostStorage -RescanAllHba
