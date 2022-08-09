$vms = Get-VM | Where-Object {$_.PowerState -like "*on*"} | sort-object
$data = @()


foreach ($vm in $vms)
    {
    $net = $vm | Get-Stat -Stat net.usage.average -Start (Get-Date).AddDays(-1) -Finish (Get-Date) -MaxSamples 5000 | Sort-Object -Property value -Descending | Select-Object -First 1
    $disk = $vm | Get-Stat -Stat disk.usage.average -Start (Get-Date).AddDays(-1) -Finish (Get-Date) -MaxSamples 5000 | Sort-Object -Property value -Descending | Select-Object -First 1
    $info = "" | Select-Object vm,max_net_kbps,max_net_time,max_disk_kbps,max_disk_time
    $info.vm = $vm.Name
    $info.max_net_kbps = $net.Value
    $info.max_net_time = $net.Timestamp
    $info.max_disk_kbps = $disk.value
    $info.max_disk_time = $disk.timestamp
    $info | fl
    $data += $info
    }

Clear-Host

$data | Sort-Object -Property max_net_kbps -Descending | Select-Object vm,max_net_kbps,max_net_time  | ft 

$data | Sort-Object -Property max_disk_kbps -Descending | Select-Object vm,max_disk_kbps,max_disk_time  | ft 
