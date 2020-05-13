Import-Module VMware.VimAutomation.Core

$VIServer = Read-Host "Please enter your vCenter Server"
Connect-VIServer $VIServer
$vms = Import-Csv VMHWUpgrade.csv

foreach ($vm in $vms) 
{
	Write-Host $vm.name " - Enabling VM HW Update at Soft Power Off (Version 10)" 
	$vmConfig = New-Object VMware.Vim.VirtualMachineConfigSpec
	$vmConfig.ScheduledHardwareUpgradeInfo = New-Object -TypeName VMware.Vim.ScheduledHardwareUpgradeInfo
	$vmConfig.ScheduledHardwareUpgradeInfo.UpgradePolicy = "onSoftPowerOff"
	$vmConfig.ScheduledHardwareUpgradeInfo.VersionKey = "vmx-10"
	Get-VM $vm.name | Where-Object {$_.Extensiondata.ReconfigVM_Task($vmconfig)}
}

