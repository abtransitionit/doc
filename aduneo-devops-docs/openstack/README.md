# [&larr;][Home_Readme]OpenStack


[//]: #(Reference)
[Home_Readme]:        ../README.md
[Howto_list]:         list/howto_list.md
[List_list]:          list/list_list.md
[Terminology_List]:   ./_terminology.md
[Component_Whatis]:   whatis/component_whatis.md
[Release_List]:       list/release_list.md
[Reference_List]:     list/reference_list.md
[release_Whatis]:     whatis/release_whatis.md


Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Reference|[List][Reference_List]
|Terminology|[List][Terminology_List]
|List|[List][List_list]|
||
|OpenStack|[How-to][Howto_list]|
|Composant|[Whatis][Component_Whatis]
|Release|[Whatis][release_Whatis]
<br>


# Openstack > C'est quoi


OpenStack est 
  - 1 Projet OpenSource
  - 1 outil
  - écrit majoritairement en Python
  - [historiquement] dévellopé sur l'OS:Ubuntu via Canonical
  - constitué de l'agrégation de plusieus projets OpenSource nomée **composant**


OpenStack propose  et est exploitable comme VmWare, Aws, Azure, Gcp via
  - 1 Cli
  - 1 Api
  - 1 Ihm


OpenStack, comme VmWare
  1. s'**installe** sur des **machines physiques**
  1. **permet**, ensuite, de créer des Vms (mais pas seulement)

OpenStack, comme Aws
  - Partage 1 lexique commun (Security group, ...)
  - **Permet** de créer des infras virtuelles avec des outils intégrés (e.g Heat) ou via d'autres outils Iac (e.g Terraform)

OpenStack, peut être installer sur des **VMs**
  - Pour des besoins spécifiques : env@(test, dev, tutorial)

OpenStack, une fois déployé,  **dénote** 1 datacenter exploitable via
  - sa Cli
  - son Api
  - son Ihm
  - des outils intégrés ou tiers
 
# A savoir
- chaque release OpenStack possède 1 nom, et il en sort 2 par an.
- l'organisation **Canonical** met à disposition la dernière release de Openstack pour la denière Ubuntu LTS via la Ubuntu Clound Archive
- Ubuntu/Debian intègre en natif les répo@package OpenStack
- OpenStack 
  - fournit des standard de deployement pour certains type d'usage de OpenStack
  - utilise Etcd pour stocker
    - des config
    - des infos sur les services
    - ...

# Par ou commencer
- connaitre les composants qui composent OpenStack
- comprendre [succintement] le role de chaque composant
- installer OpenStack sur 2 Vm (controler et Compute)

