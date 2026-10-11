# [Powershell][Topic_Whatis] > [Howto][Howto_List] > Install Active Directory


[//]: #(Reference)
[Topic_Whatis]:    ../README.md
[Howto_List]:      ../list/howto_list.md
[Cmdlet_Whatis]:   ../whatis/cmdlet_whatis.md



# Rename Computer
```powershell
# define var
$MX_COMPUTER_NAME="sand-wapp"
Rename-Computer 
-NewName $MX_COMPUTER_NAME 
-DomainCredential Domain01\Admin01 
-Restart
```

# Install AD
```powershell
Install-WindowsFeature  -name AD-Domain-Services -IncludeManagementTools
```

# Create Pwd:AD
```powershell
# define var
$MyPwd = "MAXlaf@1t01"
# encrypt pwd
$MyPwdEncrypt = ConvertTo-SecureString -String $MyPwd -AsPlainText -Force
```


# Create Forest
```powershell
# needed Module
Import-Module ADDSDeployment

# Create Forest
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "mxdomain.sand" `
-DomainNetbiosName "MXDOMAIN" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$true `
-SysvolPath "C:\Windows\SYSVOL" `
-SafeModeAdministratorPassword:$MyPwdEncrypt `
-Force:$true 

# Install Tool@admin 
ADD-WindowsFeature RSAT-Role-Tools
```


# Todo

```powershell
Install-windowsfeature adfs-federation –IncludeManagementTools
Add-WindowsFeature AD-Domain-Services 
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools“
Install-ADDSForest  -DomainName vdom.local  -InstallDNS 
```