[//]: #(Home)
[HOME]:  ../whatis/ep.md

[//]: #(functional)
[tool whatis]:  ../whatis/tool.md
[tool list]:    ../list/tool.md

[←][HOME] Related topics
|||
|-|-|

|[list of tools][tool list]|



<h1 align="center">Other</h1>


# Definition

## System
A set of related components considered as a single entity.

## Computing System
A **system** with computational capabilities, typically provided by CPU(s)
```
Computing System
 ├── CPU
 └── ...
```


# Infrastructure
is physical or virtual
  - Computing infrastructure
  - Load balancer
  - network
  - Virtual machines
  - Storage
  - Networks
  - Databases
  - Load balancers
  - Kubernetes
  - Physical servers
  - Object storage
  - etc.

# OpenStack
- A cloud management [platform][tool whatis] (aka. platform)
- not a cloud provider
- Software for building a private/public cloud infrastructure

# LXC
```
Linux kernel
    │
    ├── Container A
    ├── Container B
    └── Container C
```

# LXD
- manager/orchestrator around containers and VMs

# Container
Instance of container image)

A container **shares** the **host kernel** and have separate 
- process spaces
- filesystems
- Networking
- Users
- etc
- **But share the host kernel**.

A container Provides isolation between groups of processes running on the same OS kernel.

# Container runtime
- Creates and manages containers by using OS-level isolation mechanisms:
  - **namespaces**           → isolate what processes can see
  - **cgroups**              → control resource usage
  - **filesystem isolation** → give the container its own filesystem view
  - **capabilities/security mechanisms** → restrict what processes can do

- Containers can be created directly or be an instance of container image. 
- Containers can simultaneously be seen as **Execution Environment** and **Host** (from the tool's perspective).


# List of concept
|Term|kind|meaning|Example|
|-|-|-|-|
|EE |acro|<li> **where** software programs execute and interact with/operate on resources<li> it does not necessarily have its own OS/kernel|<li>Host <li>Container
|Virtual host |infra| <li>a host implemented virtually <li>has its own OS/kernel|<li>VM <li>microVM
|Operation|concept|<li>is resource-specific <li>a resource-specific action <li>an action exposed by a resource.|
|Role||<li>An entity may fulfill different roles depending on its relationship to other entities.|<li>A resource may fulfill the role of a host.<li>A host may be treated as a resource.

<!-- |Host|<li>Something capable of running an OS<li>anything **physical** or **virtual** capable of running an operating system<li>a **physical** or **virtual** computing |Resource|<li>Something that can be provisioned on/in a host|File, Package, User, Service -->

