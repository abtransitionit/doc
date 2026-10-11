# [Terraform][Topic_Whatis] > [Whatis][Whatis_List] > Application


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Application_Howto]:  ../howto/application_howto.md
[Module_Whatis]:      ../whatis/module_whatis.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Application|[How-to][Application_Howto]
|Module|[Whatis][Module_Whatis]
<br>

# Definition
1 application Terraform est composé de
  - 1..1 module@root qui définit
    - 1..N fichier de configuration
  - 0 .. n module@child

1 application Terraform permet de 
  - créer des infra virtuel sur les cloud standartinfra 
  - provisioner 1 Infra
