

1 - server manager
3 - rename Host:Name
2 - Install active directory
4 - Promte server to domain controller
 et créer la forêt du DC
 - add forest 
 - name = mxdomain.sand (doamin)
   - C:\Windows\SYSVOL
   - C:\Windows\NTDS


Windows PowerShell script for AD DS Deployment

$Secure = Read-Host -AsSecureString
$Secure = Read-Host -AsSecureString
$Encrypted = ConvertFrom-SecureString -SecureString $Secure
$Encrypted = ConvertFrom-SecureString -SecureString "max01"

Define > var 

5 - install without rebbot)


reference
- https://docs.microsoft.com/en-us/powershell/module/addsdeployment/install-addsforest?view=windowsserver2022-ps

6 - start "Windows Administrative tools"
7 - configure network
  - change adapter options
  - configure DNS (property)
    - manage only Ipv4
  - test nslookup (resolution DNS port 53)


  Add Vm
   - update DNS primaire (DC)
   - pws > pour rejoindre le domaine
   - mapper 1 lecteur réseau
   - Gpo ..


dsa.msc

