# Env > Howto > Machine de rebond


[//]: #(Reference)
[Env_Whatis]:              ../README.md
[Container_Devops_Whatis]: ../whatis/cdevops_whatis.md
[Bastion_Whatis]:          ../whatis/bastion_whatis.md
Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Env|[Whatis][Env_Whatis]|
|Container Devops|[Whatis][Container_Devops_Whatis]|
|Bastion|[Whatis][Bastion_Whatis]|
<br>

# Créer 1 machine de rebond

- [Pour aller vite] Créer via l'Ihm VmWare:VSphere 1 vm accéssible en ssh
- scp sur la vm le script d'installation de Docker, Git
- Ssh vm 
- git:pull image devops
- instancier sur la vm, 1 container devops à partir de l'image devops
- provisionner 1 VmWare:VM via Container:(govc, terraform)
- provisionner sur cette vm les outils suivants via Container:(govc, terraform)


