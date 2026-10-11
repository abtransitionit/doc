# [Terraform][Topic_Whatis] > [Howto][Howto_List] > Manage > Module


[//]: #(Reference)
[Topic_Whatis]: ../README.md
[Howto_List]:  ../list/howto_list.md
[Module_Whatis]:  ../whatis/module_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Module|[Whatis][Module_Whatis]
<br>

# Créer 1 Module@Root

- create 1 forder
```bash
mkdir myapp
cd    myapp
```
- create the followning file
```bash
touch main.tf
```

- update file **main.tf** with following contents
```bash

```

# Appeler 1 Module@Child
```bash
module "MyModule" {
  source  = "Module_Url_or_Path"
  version = "Module_Version"
  ...
}

module "module_01" {
  source  = "./local"
}
module "module_01" {
  source  = "./local"
}
module "module_01" {
  source  = "./local"
}
```
