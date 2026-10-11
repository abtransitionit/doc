# [Powershell][Topic_Whatis] > [Howto][Howto_List] > Manage > variable


[//]: #(Reference)
[Topic_Whatis]:    ../README.md
[Howto_List]:      ../list/howto_list.md
[Variable_Whatis]: ../whatis/variable_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Variable|[Whatis][Variable_Whatis]

# Display Variable
```powershell
# Example
$PSHOME
$PROFILE
# Display Var@Env
$XXX
$env:XXX
$env:PSModulePath -split ';'
$env:computername
```

# Flip Variable
```powershell
$Var01, $Var02 = $Var02, $Var01
```

# Define Variable
```powershell
# def 1 var
$VarName="xxxx"

# def N var
$Var01, $Var02  = O
$Var01, $Var02  = 'a', 5

```

# Variable.Automatic
```powershell
# Example for Get-Host
$host 
# Example
$PSVersionTable

