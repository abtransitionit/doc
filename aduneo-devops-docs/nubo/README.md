# [&larr;][Home_Readme]Nubo


[//]: #(Reference)
[Home_Readme]:    ../README.md
[Howto_list]:     list/howto_list.md
[List_list]:      list/list_list.md
[Reference_List]: list/reference_list.md
[Maia_Whatis]:    ../_maia/README.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|List|[List][List_list]|
|Nubo|[How-to][Howto_list]|
|Reference|[List][Reference_List]
|Maia|[Whatis][Maia_Whatis]
<br>



# Nubo > C'est quoi


Nubo est
  - 1 projet transverse à tous
    - les ministères (i.e tous les agents de l'état)
    interministère
  - 1 cloud basé sur OpenStack
  - le cloud de l'administration Fr
  - réservé à des user qui sont
     - agents de l'état
  - gérer pr le ministère : Dgfip
 

# Les instance Nubo
|Non|Localisation Geo|Tag|Usage|Description|
|-|-|-|-|-|
|nubo01|0||interne|Ptf RIE
|nubo02|0||publique|Ptf Internet
|nubo11|1||interne|Ptf RIE
|nub12|1||public|Ptf Internet

# App@Nubo
- Test
- HA
- PRA
- PCA
- Supervision (i.e metric)
- Dashboard
- Ticketing
- Alerting
- Backup
  - What (Log, Data)
  - How (Archivage, Retention)
# infra
- Bastion
- Front
- Security Group
# Port
ports autorisés
  - ports Web (80 et 443) - pour l'IHM
  - ports Ssh (22) - pour l’administration
# Fip
- 1 pour le Bastion Ssh
- 1 pour l'app  
# Step 
- create Network 
- create Routeur 
- create Vm 
- create IP@flottante 
# Package
- Os:Package:(Ubuntu, Redhat, are accéssible
- Terrafor:Provider is accéssible but must be activated
# Image@Vm
- ask team:odin to add ubuntu:22.04 with docker and docker-compose 
# Network@public
## Network@adm
- for user@adm@(system, app)
- expose only port:22
- bastion must be in this network
## Network@publication
- allow access to App:Ihm
- expose only port:80,443
## Network@echange
- allow communication between Vm in nuboX1 and nuboX2
- cf Matrice des flux (1.5.2.2) 
# Sg
bastion
  - open port:22

Rp (reverse proxies)
  - open port:22
  - flux vers port 22 uniquement depuis le bastion

Back
  - allow port:22 only from Bastion
  - allow port:8080 only from rp

serveur Postgres
  - allow port:22 only from Bastion
  - allow port:5432 only Back
# Ssh
- Key is added to vm:user:**cloudadm**
- vm:user:cloudadm:pwd=cloudadm
- accés ssh aux Vm via Bastion
# Tool
- Heat
- Ansible
# Todo for app
- Bastion
- Test Auto
- HD
- PRA
- PCA
- Tooling
  - supervision
  - monitoring
  - backup
    - retention
    - externalisation
- Db
  - prefer NoSql
- Tool
  - Heat
  - Terraform
  - Ansible
  
  # Interface / Ihm
   1. Portail de service
       - commander les tenant
       - quotas
       - nb vm
   1. Facturation
   1. Matrice de flux
   1. 
