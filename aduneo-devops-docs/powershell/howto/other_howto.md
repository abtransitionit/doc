# [Powershell][Topic_Whatis] > [Howto][Howto_List] > Other


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Install_Howto]:   ../howto/install_howto.md
[Datacenter_List]: ../list/datacenter_list.md
[Vm_Howto]:        ../howto/vm_howto.md

# Get Info on Feature installed or not
```powershell
Get-WindowsFeature 
Get-WindowsFeature -Name RSAT*
```
# Install Feature
```powershell
# check Feature is not installed
Get-WindowsFeature -Name RSAT*
Get-WindowsFeature -Name RSAT-Role-Tools
# install it
ADD-WindowsFeature RSAT-Role-Tools
```


# Get Info
```powershell
# Get Help
Get-Help 
Get-Help Get-Verb

# List Command All
Get-Command
# List Verb All
Get-Verb
```

# Display Table as Set of N KvPair
```powershell
# Key=Colum:Name, value=Item:Value 
# N = Nb of Item in Table
Get-Verb | Group-Object -Property Group | Format-List
Get-Process Explorer
```

# Group Output
```powershell
# List Verb by Category
Get-Verb | Group-Object -Property Group
Get-Verb | Group-Object -Property Group -NoElement 

# List Command by Category
Get-Command | Group-Object -Property CommandType -NoElement
```
# Sort Output
```powershell
Get-ChildItem -Path $PSHOME | Sort-Object -Property Length -Descending
```

# Filter Output:Column
```powershell
Get-ChildItem -Path $PSHOME | Select-Object -Property Length -Descending
Get-Verb | Select-Object -Property Verb | Sort-Object Verb -Descending
```
2b-hY$JTf!5FQh*j5P=yjad;s&Mu&v&P
# List File
```powershell
Get-ChildItem -Path $PSHOME
Get-ChildItem -Path $PSHOME -Recurse
```


# Some cde AD
```powershell
# List Cmdlet info
Get-Help Get-ADComputer

# Info
Get-ADComputer -Identity PROJ-TEST-AMAR1
```

# Some cde
```powershell
(Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name 'PowerShellVersion').PowerShellVersion
```

# todo
```powershell
Get-ADComputer cmdlet, you have to import Active Directory Module for Windows PowerShell with the command:

Import-Module activedirectory

```

# Create 1 Service.Windows
```powershell
$params = @{
    Name = "MyService"
    BinaryPathName = "path/to/exe"
    DisplayName = "My Service"
    StartupType = "Automatic"
    Description = "Description of my service"
}
New-Service @params
```

# Prerequisit
- Allow to excute script
```powershell
# List Cmdlet in 1 Module
Get-ExecutionPolicy
...
Set-ExecutionPolicy RemoteSigned
```

# Play from remote
```powershell
Invoke-Command -ComputerName 192.168.112.69 -ScriptBlock {Get-Host} -Credential $cred

 Invoke-Command -ComputerName 192.168.112.69 -ScriptBlock {$host.Version} -Credential $cred

$scriptBlock = {
    [version](Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name 'PowerShellVersion').PowerShellVersion
}
Invoke-Command -ComputerName 192.168.112.69 -ScriptBlock $scriptBlock -Credential $cred

Invoke-Command -ComputerName 192.168.112.69 -ScriptBlock {$PSVersionTable.PSVersion} -Credential $cred
```

# Rename computer
```powershell
$newName = Read-Host -Prompt "Enter New Computer Name"
Rename-Computer -NewName $newName -LocalCredential admin -Force
Rename-Computer -NewName xxxx -Restart
```

# Join Domain
```powershell
# Method
Add-Computer -DomainName xxxx -ComputerName xxxx -NewName xxxx -Credential Domain\Admin -Restart

Add-Computer -DomainName MYLAB.Local -ComputerName TARGETCOMPUTER -newname NewTARGETCOMPUTER
Add-Computer -options JoinWithNewName

Add-Computer -DomainName xxxx -Credential xxxx\xxxxx -Restart

# Method
## get the credential 
$cred = get-credential

## enter the computer in the right place
Add-Computer -DomainName EPFL -Credential $cred -OUPath "...,DC=epfl,DC=ch"

## rename the computer with credential (because we are in the domain)
$Computer = Get-WmiObject Win32_ComputerSystem
$r = $Computer.Rename("NewComputerName", $cred.GetNetworkCredential().Password, $cred.Username)
```
