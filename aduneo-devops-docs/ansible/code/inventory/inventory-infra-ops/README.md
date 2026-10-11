# [&larr;][Home_Readme] dinum-ansible > Inventory > Inventory-Infra



[//]: #(Reference)
[Home_Readme]:  ../README.md

[Inventory_Infra_Howto]: ./howto.md
[Groupvar_Ep]:           ./group_vars/README.md



# Purpose
This repo@git:Folder is 1 Ansible:inventory that is
  - used to 
    - provision 1..N cloud@openstack:project
  - designed to allow Ansible:var:value to be
    - inherit from parent
    - override by child

# Folder : content

|Nom|Tag|Description|
|-|-|-|
|Readme|File|This file|
|[group-vars][Groupvar_Ep]|Folder|Ansible:Resource|
|hosts|File|Ansible:Resource|
|[How-to][Inventory_Infra_Howto]|File@(txt, doc, md)
<br>


# Dependency

|Name|Type|Description
|-|-|-|
|mx-ops-env-set|script@bash|set var@env for each cloud@openstack:project
|mx-ansible-ops-play-tag|script@bash|wrapper for cli:ansible-playbook 


# Terminology
provision 1..N cloud@openstack:project mean
  1. Some openstack:project belong to Aduneo
  1. Some openstack:project belong to Dinum
  1. In each openstack:project some var 
     - are shared by all openstack:project
     - are specific to 1..N openstack:project
  1. Provision mean
     - install
     - configure




