# Env > whatis > Container devops


[//]: #(Reference)
[Env_Whatis]:                   ../README.md
[Container_Devops_Dinum_Whatis]: ../whatis/cdevops_dinum_whatis.md
[Bastion_Whatis]:                ../whatis/bastion_whatis.md
[Bastion_Howto]:                 ../howto/bastion_howto.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Env|[Whatis][Env_Whatis]|
|Container Devops Dinum|[Whatis][Container_Devops_Dinum_Whatis]|
|Machine de rebond|[Whatis][Bastion_Whatis], [Howto][Bastion_Howto]|
<br>

# Definition

1 container devops est
  - 1 container Docker
  - 1 instance d'1 image Docker

l'image ainsi que le container docker sont soumis à des **exigences** communes et spécifiques aux environnement à créer

# Exigences communes
- Le container 
  - ne tourne pas sous root
  - est instancié sur une machine de rebond
- Les outils suivants existent
  - Govc
  - Terraform
