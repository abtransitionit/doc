[//]: #(Reference)
[HOME]:  ../whatis/forge.md

[tool whatis]:  ../whatis/tool.md
[tool list]:    ../list/tool.md

[←][HOME] Related topics
- [list of tools][tool list]



<h1 align="center">Other</h1>


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