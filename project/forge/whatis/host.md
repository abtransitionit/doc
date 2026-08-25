[//]: #(Home)
[HOME]:  ../whatis/ep.md

[//]: #(functional)
[host list]:           ../list/host.md
[host physical list]:  ../list/host.md#physical-hosts
[host virtual list]:   ../list/host.md#virtual-hosts
[host container list]: ../list/host.md#container-host
[res whatis]:       ../whatis/res.md
[forge whatis]:     ../whatis/ep.md
[os whatis]:        ../whatis/os.md
[provision whatis]: ../whatis/provision.md
[cloud provider whatis]: #
[tool whatis]:      ../whatis/tool.md
[hypervisor whatis]: ../whatis/hypervisor.md
[host howto]: ../howto/host.md

[←][HOME] Related topics
|||
|-|-|
|[what is Forge][forge whatis]|internal
|[what is a resource][res whatis]|internal
|[what is an OS][os whatis]|internal
|[list of host][host list]|internal
|[howto for Host][host howto]|see

<h1 align="center">Forge Host</h1>


# Definition

## Machine
- A **computing system** with hardware resources, including at least: RAM / Disk / NIC.
- ⚠️ A **Machine** becomes a **Host** as soon as it hosts Something (often **VMs** or **Containers**)
```
Machine
 ├── CPU
 ├── RAM
 ├── Disk
 └── NIC
```

# Kind

This section defines a taxonomy

```
System
│
└── Computing System (via CPU)
    │
    └── Machine
        │
        ├── Physical Machine
        │      │
        │      │
        │      ├── Physical Host
        │      │     │
        │      │     ├── hosts Containers (via container runtime)
        │      │     │
        │      │     └── hosts VMs (via hypervisor)
        │      │     
        │      └── Bare-Metal Server
        │            │
        │            └── hosts Applications (via Host OS)
        │       
        └── Virtual Machine
               │
               ├── Virtual Host
               │     │
               │     └── hosts Containers (via container runtime)
               │     
               └── Virtual Server
                     │
                     └── hosts Applications
```

## Physical Machine (PM)
A **Machine** whose hardware resources are **physical**.
```
Physical Machine
├── CPU
├── RAM
├── Disk
└── NIC
```

## Bare-Metal Server
- A **Physical Machine** that has no Hypervisor nor VM layer

**Example**
```
Bare-Metal Server
│
└── Host OS
     │
    ...
```
- If the Host OS is provisioned with a Container runtime or a Hypervisor, the Bare-Metal Server becomes a **Physical Host**

## Virtual Machine (VM)
- A **Machine** whose hardware resources are virtual.
- **Virtual hardware resources**
  - is a software
  - is backed by a **physical** hardware resource.
```
Virtual Machine
├── vCPU
├── vRAM
├── vDisk
└── vNIC
```
## Host
- ⚠️ A **Machine** that hosts something. The thing **being hosted** is called the **guest** or **workload**
  - When the things being hosted are VMs. VMs are called **Guests**
  - When the things being hosted are Containers. Containers are called **Workload**
- can be virtual Host or physical Host


## Physical Host
- A **Host** with physical hardware resources.

**Example**: Bare-metal hypervisor inside a bare-metal server
```
Physical Host
    │
    └── Hypervisor (bare-metal hypervisor)
         │
         ├── VM 1 → Guest OS → Linux
         │           │
         │           └── Application
         │
         ├── VM 2 → Guest OS → Linux
         │           │
         │           └── Application
         │
         └── VM 3 → Guest OS → Windows
                    │
                    └── Application
```
Meaning:
- The [hypervisor][hypervisor whatis] 
  - Runs on the physical host's hardware.
  - Creates/manages the VMs.
- Each VM 
  - is a Guest of the physical host.
  - Provides an isolated environment with its own Guest OS.
- Applications run inside the Guest OS.

**Example**: hosted hypervisor inside a bare-metal server
```
Physical Host
    │
    │
    └── Host OS
         │
         └── Hypervisor (hosted hypervisor)
             │
             ├── VM 1 → Guest OS → Linux
             │           │
             │           └── Application
             │
             ├── VM 2 → Guest OS → Linux
             │           │
             │           └── Application
             │
             └── VM 3 → Guest OS → Windows
                         │
                         └── Application
```
Meaning:
- The Host OS runs on the physical machine's hardware.
- The [hypervisor][hypervisor whatis] 
  - Runs on the Host OS.
  - Creates/manages the VMs.
- Each VM 
  - Is a **Guest** of the physical host.
  - Provides an isolated environment with its own Guest OS.
  - Has its own OS kernel.
- Applications run inside the Guest OS.

**Example**: Container Runtime inside a Bare-Metal Server 
```
Physical Host
    │
    └── Host OS
        │
        └── Container Runtime
            │
            ├── Container A.     ← uses the Host OS Kernel
            │   └── Application
            │
            └── Container B      ← uses the Host OS Kernel
                └── Application
```
Meaning:
- The Host OS runs on the physical machine's hardware.
- The Container Runtime
  - Runs on the Host OS.
  - Creates/manages the Containers.
- Each container
  - Is a **Workload** of the physical host.
  - Shares the Host OS's kernel. 
  - Provides an isolated environment for its processes/applications.


## Virtual Host
- A **Host** with virtual hardware resources.

**Example**: Container Runtime inside a **VM**
```
Virtual Host
    │
    └── Guest OS
        │
        └── Container Runtime
            │
            ├── Container A
            │   └── Application
            │
            └── Container B
                └── Application
```
Semantic
- The Guest OS runs on the virtual machine's hardware (that are virtual).
- The Container Runtime
  - Runs on the Guest OS.
  - Creates/manages the Containers.
- Each container
  - Is a **Workload** of the virtual host.
  - Shares the Guest OS's kernel. 
  - Provides an isolated environment for its processes/applications.


# Todo

## Boundary Cases

Some environments can be interpreted as either a **host** or an **execution environment** depending on the perspective of the provisioning tool.

Examples:

- LXC/LXD
- Solaris zones
- FreeBSD jails
- WSL
* IBM mainframe LPAR
- IBM z/VM guest

Also:
* system containers such as some **LXC/LXD configurations** can look very much like a machine from the inside. 



# Key points
- The OS, hypervisor, cloud provider, or platform are a property/attribute of a host
- hosts can additionally be classified by:
  * Private Cloud, Public Cloud
  * Other properties

This avoids treating **AWS**, **VMware**, **KVM**, etc. as host kinds.

```
Host
├── provider: AWS
├── Type: VM (AWS EC2)
└── Environment: Public Cloud
```




