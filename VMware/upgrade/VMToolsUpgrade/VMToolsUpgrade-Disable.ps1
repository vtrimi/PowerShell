Import-Module VMware.VimAutomation.Core

#####################################################################
#             
#   Purpose:  "Check and upgrade Tools during power cycling"
#
#   Instruction:    1. Create CSV file with list of servers
#                   2. Execute script from PowerCLI
#                   3. Enter vCenter name
#                                                            
#####################################################################

$VIServer = Read-Host "Please enter your vCenter Server"
Connect-VIServer $VIServer
$vms = Import-Csv VMToolsUpgradeList.csv

foreach ($vm in $vms) 
{
    Write-Host $vm.name " - Disabling VMTools Update at Power Cycle" 
    $vmConfig = New-Object VMware.Vim.VirtualMachineConfigSpec
    $vmConfig.Tools = New-Object VMware.Vim.ToolsConfigInfo
    $vmConfig.Tools.ToolsUpgradePolicy = "Manual"
    Get-VM $vm.name | Where-Object {$_.ExtensionData.ReconfigVM( $vmconfig )}
}
