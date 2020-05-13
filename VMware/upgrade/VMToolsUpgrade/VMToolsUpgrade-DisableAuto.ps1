Import-Module VMware.VimAutomation.Core

New-VIProperty -Name ToolsUpgradePolicy -ObjectType VirtualMachine -ValueFromExtensionProperty 'Config.tools.ToolsUpgradePolicy' -Force
New-VIProperty -Name ToolsVersionStatus -ObjectType VirtualMachine -ValueFromExtensionProperty 'Guest.ToolsVersionStatus' -Force

$vCenters = "vCenter1", "vCenter2"

foreach($vCenter in $vCenters)
{
	Connect-VIServer -Server $vCenter
	Write-Host "Connected to vCenter $vCenter"

	$vms = Get-VM | Where-Object {($_.ToolsVersionStatus -eq "guestToolsCurrent") -and ($_.ToolsUpgradePolicy -eq "upgradeAtPowerCycle")} 
	foreach ($vm in $vms)
	{
		Write-Host $vm.name " - Disabling VMTools Update at Power Cycle" 
		$vmConfig = New-Object VMware.Vim.VirtualMachineConfigSpec
		$vmConfig.Tools = New-Object VMware.Vim.ToolsConfigInfo
		$vmConfig.Tools.ToolsUpgradePolicy = "Manual"
		Get-VM $vm.name | Where-Object {$_.ExtensionData.ReconfigVM( $vmconfig )}
	}

	Disconnect-VIServer -Server $vCenter -confirm:$false
	Write-Host "Disonnected from vCenter $vCenter"
}
