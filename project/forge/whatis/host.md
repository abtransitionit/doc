[//]: #(Reference)
[HOME]:  ../whatis/forge.md

[host list]:           ../list/host.md
[host physical list]:  ../list/host.md#physical-hosts
[host virtual list]:   ../list/host.md#virtual-hosts
[host container list]: ../list/host.md#container-host
[res whatis]:       ../whatis/res.md
[forge whatis]:     ../whatis/forge.md
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

<h1 align="center">Host</h1>


# Definition

- The term **Host** describes a **role** a system can endorse
- A system has the role of **Host** when it **hosts** something.
- Such a system is called a **host** or **machine**
- A so-called **host** 
  - Provides hardware resources (`CPU / RAM / Disk / Network/ ...`) to the thing it **hosts**.
  - Can be **physical** or **virtual**
- The thing **being hosted** is called the **guest** or **workload**, depending on the context.
- A target that can be [provisioned][provision whatis] with [resources][res whatis]
- **where/how** a [resource][res whatis] is made available
- 🚧 Can host an [OS][os whatis] or a [Hypervisor][hypervisor whatis]
- 🚧 runs [tools][tool whatis]
- 🚧 A **CS** with an **EE**


# Kind

```
Host
│
├──> Physical Machine (ready to be provisioned to become a Host)
│      │
│      └──> Physical Host
│            │
│            ├──> provision an Hypervisor ⇨ bare-metal server
│            │          
│            └──> provision an OS image   ⇨ bare-metal server
│      
└──> Virtual Machile (ready to be provisioned to become a Host)
       │
       └──> Virtual Host
             │
             └──> provision an OS image   ⇨ bare-metal server
                    │
                    ├──> provision a container runtime ⇨ 
                    │
                    └──> provision an application      ⇨ 
```

```
Linux OS
│
└── Container Runtime
    │
    ├── Container A
    └── Container B
```

## Physical Machine (PM)
- a machine with **physical** hardware resources (`CPU / RAM / Disk / Network/ ...`)
- can be provisioned with a [hypervisor][hypervisor whatis] or an [OS image][os whatis]

```
Physical host
├── Physical CPU  (24)
├── Physical RAM  (256 GB)
├── Physical DISK (3000 GB)
└── Physical NIC
```
These are **physical** hardware resources (`CPU / RAM / Disk / Network/ ...`):
|Resource|Description|
|-|-|
|CPU|  physical CPU  resources. |
|RAM|  physical MEM  resources. |
|Disk| physical DISK resources. |
|NIC|  physical NIC  resources. |

## Virtual Machine (VM)
- A machine with **virtual** hardware resources (`CPU / RAM / Disk / Network/ ...`)
- Often provisioned with an [OS image][os image whatis] or a [CR][cr whatis]

```
VM
├── vCPU  (4)
├── vRAM  (8 GB)
├── vDisk (100 GB)
└── vNIC
```
These are **virtual** hardware resources (`CPU / RAM / Disk / Network/ ...`)
|Resource|Description|
|-|-|
|vCPU| virtual  CPU  resources. Backed by physical CPU  resources|
|vRAM| virtual  MEM  resources. Backed by physical MEM  resources|
|vDisk| virtual DISK resources. Backed by physical DISK resources|
|vNIC|  virtual NIC  resources. Backed by physical NIC  resources|



## Physical Host
- A PM **hosting guests** 
  - VMs created and managed by Hypervisor OR
  - Containers created and managed by Container runtime
- An hypervisor running on the Physical machine's hardware is not considered a **guest**
- an OS running on the Physical machine's hardware is called **Host OS**


## Virtual Host 
- A VM hosting **guests** 
  - Containers workload managed by a Container runtime
- A container runtime 
  - is not considered a **guest**
  - needs a Host to runs
- an OS running inside a VM is called **Guest OS**
- 🚧 microVM
## Bare Metal Server
- A physical machine remotely allocated on a [cloud provider][cloud provider whatis] 
  - Without a virtualization layer.
  - Running a Host OS.


# Todo Todo Todo Todo Todo Todo Todo Todo
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


## Container
- Containers can be created directly or be an instance of container image. 
- Containers generally **share the host's kernel** rather than running their own OS/kernel. 
- Containers can simultaneously be seen as **Execution Environment** and **Host** (from the tool's perspective).

---

# Boundary Cases

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





# Todo

# Definition


# Provisioning Virtual host
- applications runs on an OS.
```
Machine
│
└── OS
    │
    └── Application
```

```
┌──────────────────────────────────────────────┐
│ Physical Server                              │
│                                              │
│  CPU / RAM / Disk / Network                  │
│                                              │
│  ┌────────────────────────────────────────┐  │
│  │ Host OS                                │  │
│  │                                        │  │
│  │ Hypervisor / virtualization software   │  │
│  │                                        │  │
│  │ ┌──────────┐ ┌──────────┐              │  │
│  │ │   VM 1   │ │   VM 2   │              │  │
│  │ │ Linux    │ │ Windows  │              │  │
│  │ └──────────┘ └──────────┘              │  │
│  └────────────────────────────────────────┘  │
└──────────────────────────────────────────────┘
```

```
┌──────────────────────────────────────────────┐
│ Physical Server                              │
│                                              │
│ Host OS                                      │
│                                              │
│ Container runtime                            │
│                                              │
│ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│ │Container │ │Container │ │Container │       │
│ │ App A    │ │ App B    │ │ App C    │       │
│ └──────────┘ └──────────┘ └──────────┘       │
└──────────────────────────────────────────────┘
```



# Virtual host
- An **isolated** machine with virtual **hardware**: `CPU / RAM / Disk / Network`
- microVM
# VM 
- An **isolated** machine with virtual **hardware**: `CPU / RAM / Disk / Network`
- standard VM (OVH VPS, AWS EC2)
- Managed by an [Hypervisor][hypervisor whatis]
# Container 
- Provide isolation of one group of processes from other processes on the same OS



## todo
- if that something is an OS. it can host software
- if that something is a Hypervisor. it host VMs
- "Host" does not describe what the machine is
- "Host" describes what the machine does.

So 
- physical, VM, bare metal, OS, etc. describe what something is, while host describes its role.
- host describes the role of that host.

