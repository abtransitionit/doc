# [Powershell][Topic_Whatis] > [Howto][Howto_List] > Manage > Network


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Some cde
```powershell
# List Cmdlet in Module
get-command -Module NetTCPIP
# Info
Get-NetAdaptater
Get-NetAdapter -Name "Ethernet0 2"
Get-NetAdapterHardwareInfo
```
# Display Info.Network
```powershell
Get-NetIPConfiguration -InterfaceAlias "Ethernet0 2" -Detailed
```

# Configure Network
```powershell
# Method
New-NetIPAddress 
  -AddressFamily  IPv4
  –IPAddress      192.168.2.50 
  -DefaultGateway 192.168.112.254
  -PrefixLength   21 
  -InterfaceIndex 11

# Method
$NetworkConf = @{
AddressFamily  = "IPv4"
InterfaceIndex = 11
IPAddress      = "192.168.2.50"
DefaultGateway = "192.168.112.254"
PrefixLength   = 24
}
New-NetIPAddress @NetworkConf
```
## Update IP
```powershell
Set-NetIPAddress -InterfaceIndex 11 -IPAddress 192.168.2.90
```

## Define DNS
```powershell
$DnsConf = @{
InterfaceIndex  = 11
ServerAddresses = ("192.168.101.142","192.168.101.143")
}
Set-DnsClientServerAddress @DnsConf
```

## Disable IPV4
```powershell
Get-NetAdapterBinding -InterfaceAlias "Ethernet0 2" | Set-NetAdapterBinding -Enabled:$false -ComponentID ms_tcpip4
```
