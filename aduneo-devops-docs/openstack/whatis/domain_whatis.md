# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Domain


[//]: #(Reference)
[Topic_Whatis]:     ../README.md
[Whatis_List]:      ../list/whatis_list.md
[Kolla_Whatis]:     ../whatis/kolla_whatis.md
[Component_List]:   ../list/component_list.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[List][Component_List]
|Kolla|[Whatis][Kolla_Whatis]
<br>


# Definition
## Domain
is1 set of
- user, group, project 

## Project

- is synonym for **account**, **Tenant**
- is1 set of 0..N user

<hr>

- In Compute, a project owns Vms
- In Object Storage, a project owns containers. 

<hr>


## User 
- is member of 1..N project
## Role 
- is associated to 1 pair of user/prj
- define which actions user can perform in the project

# Toknow
- Each group and project is owned by exactly one domain
- You can define actions for OpenStack service roles in file:**/etc/${PROJECT}/policy.json**
  - Example: define actions for Compute service roles in the /etc/nova/policy.json file.
