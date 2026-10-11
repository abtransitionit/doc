# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Install


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Whatis_List]:      ../list/whatis_list.md
[Kolla_Whatis]:     ../whatis/kolla_whatis.md
[Component_List]:   ../list/component_list.md
[Install_Howto]:    ../howto/install_howto.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Install|[How-to][Install_Howto]
|Composant|[List][Component_List]
|Kolla|[Whatis][Kolla_Whatis]
<br>


# Que signfie : "Installer Openstack"

OpenStack
- est **Open Source** 
- est **Modulaire**
- propose des cas d'usage d'installation



Cependant, 1 install [minimal] d'OpenStack nécéssite :

1. d'installer les composants suivants:

|Component Name|Service Provided|
|-|-|
|Keystone|Identity|
|Nova|Compute|
|Glance|Image|
|Placement|-|
|Neutron|Network|
|Horizon|Dashboard|
|*Cinder/Swift*|*Object Storage*|
<br>

2. de répartir les composants sur au moins 2 Node:
  - 1 Node@Controller
  - 1 Node@Compute


# Installer Openstack sur 2 Node@Vm

## Pourquoi installer Openstack sur des vms
  - Pour tester certains développements/changements effectués sur un composants OpenStack
  - Dans 1 but pédagogique
  - Pour avoir un aperçu de l'ihm et de certaines cli (e.g openstack, keystone, glance, ..)

## Les méthodes
Il existe actuellemnet 3 projets, méthodes qui permettent d'installer OpenStack sur des Vm. (cf. [link@externe][Explore_Whatis]):
- DevStack
- Kolla
- TripleO
- [Custom]
# Les étapes pour la méthode Custom 
## Etapes

- Installer OpenStack sur 2 Vms

|Name|Tag|Desc
|-|-|-|
|Vm1||node@(ops, controler)
|Vm2||node@(ops, compute)

- Installer cli:openstack sur 1 Vm

|Name|Tag|Desc
|-|-|-|
|Vm3||node@(ops, client)



## Todo
|Component Name|Vm|Description
|-|-|-|
|Keystone|Node@Controller|
|Glance|Node@Controller|
|Placement|Node@Controller|
|Horizon|Node@Controller|
|Neutron|Node@Controller|
|Neutron|Node@Controller|Management portion
|Nova|Node@Controller|Management portion
|Db@Sql|Node@Controller|
|Ntp|Node@Controller|
|
|Nova|Node@Compute|
|
|Block Storage|Node@Controller|Optional, Management portion
|Object Storage|Node@Controller|Optional, Management portion
|Orchestration|Node@Controller|Optional, Management portion
|Telemetry|Node@Controller|Optional, Management portion
|*Cinder/Swift*||*Object Storage*|Optional
|*Cinder/Swift*||*Object Storage*|Optional
<br>



# Les étapes pour la méthode DevSatck


- play script
```bash
/tmp/install-openstck.sh
```

