New-VICredentialStoreItem -User "administrator@vsphere.local" -Password "blabla" -Host 10.16.19.10 -File C:\Temp\vicreds.xml

$user =Get-VICredentialStoreItem -File C:\Temp\vicreds.xml -host 10.16.19.10 

Connect-VIServer -Server 10.16.19.10  -user $user.User -password $user.Password
