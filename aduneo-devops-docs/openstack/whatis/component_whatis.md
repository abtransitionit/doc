# [Openstack][Topic_Whatis] > [Whatis][Whatis_List] > Component


[//]: #(Reference)
[Topic_Whatis]:       ../README.md
[Whatis_List]:        ../list/whatis_list.md
[Openstack_Whatis]: ../README.md
[Component_List]:   ../list/component_list.md

Voir Aussi:

|Nom|Tag|Description|
|-|-|-|
|Composant|[List][Component_List]
<br>


# Definition
1 composant est 
  - 1 projet OpenSource intégré à/utilisé par OpenStack
  - une brique de l'architecture d'OpenStack


1 component 
  - provide 1 service
  - expose 1 Api
  - have its own
    - Db
    - configuration file

The service at runtime  have 
  - 1..N Thread
  - 1 thread listening for query (Api)

# Component:Type

|Name|Role|Tag|Description|
|-|-|-|-|
|Nova|Compute
|Keystone|Identity|root
|Neutron|Networking
|Glance|Image
||Block Storage
||Object Storage
||Telemetry
||Orchestration
||Database services


# Service:Type
Each service can 
  - have one or many endpoints 
  
Each endpoint can 
  - be one of three types: **admin**, **internal**, **public**. 
## Example  
- The public API network might be visible from the Internet so customers can manage their clouds
- The admin API network might be restricted to operators within the organization that manages cloud infrastructure
- The internal API network might be restricted to the hosts that contain OpenStack services. 

# Toknow
tous les composant communiquent avec les composants suivants:
  - Keystone
  - RabbitMQ


# Node
Est 1 Host qui 
  - est provisionné avec des ops:component spécifique
  - possède un rôle spécifique

Exemple
  - node@controler  
  - node@compute  
  - node@client  

# Node@Controller
The controller node runs
- Identity service, 
- Image service, 
- Placement service, 
- management portions of Compute, 
- management portion of Networking, 
- various Networking agents
- Dashboard.
- services such as an 
  - SQL database, 
  - message queue, and 
  - NTP.

Optionally, the controller node runs
  - portions of the Block Storage
  - portions of the Object Storage, Orchestration, and Telemetry services.
  - portions of the Orchestration, and Telemetry services.
  - portions of the Telemetry services.

The controller node requires a minimum of two network interfaces.

# Node@Compute

The compute node runs 
- the hypervisor portion of Compute (that operates instances). 
- a Networking service agent that connects instances to virtual networks
- a Networking service agent that provides firewalling services to instances via security groups.

By default, Compute uses the KVM hypervisor. 

You can deploy more than one compute node.

The compute node requires a minimum of two network interfaces.

# Node@Client
Node sur lequel est installé la cli:openstack


# Node@Block Storage
it is The optional

the Block Storage node contains the disks that the Block Storage and Shared File System services provision for instances.


For simplicity, service traffic between compute nodes and Block Storage node uses the management network.

Production environments should implement a separate storage network to increase performance and security.

You can deploy more than one block storage node.

The Block Storage node requires a minimum of two network interfaces.


# Node@Object Storage
it is The optional

The Object Storage node contain the disks that the Object Storage service uses for storing 
- accounts, 
- containers, 
- objects.

For simplicity, service traffic between compute nodes and Block Storage uses the management network. 

Production environments should implement a separate storage network to increase performance and security.

This service requires two nodes. 

You can deploy more than two object storage nodes.

The Object Storage node requires a minimum of one network interface. 


# Node@Controller
The controller node runs 
  - the Identity service, 
  - Image service, 
  - Placement service, 
  - management portions of Compute, 
  - management portion of Networking, 
  - various Networking agents, and 
  - Dashboard.
  - SQL database, 
  - message queue, and 
  - NTP.

Optionally, the controller node runs portions of 
- the Block Storage, 
- Object Storage, 
- Orchestration, and 
- Telemetry services.

The controller node requires a minimum of two network interfaces.
