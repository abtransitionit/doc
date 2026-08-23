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

[←][HOME] Related topics
- [what is Forge][forge whatis]
- [what is a resource][res whatis]
- [list of concepts][concept list]
- [list of host][host list]
- [concept of Host][host concept]

<h1 align="center">Host</h1>


# Definition
- Can be physical or virtual
- Can host an [OS][os whatis] or a [Hypervisor][hypervisor whatis]
- A target that can be [provisioned][provision whatis] with [resources][res whatis]
- **where/how** a [resource][res whatis] is made available
- runs [tools][tool whatis]
- 🚧 A **CS** with an **EE**

# Kind

* [Physical host][host physical list]
* [Virtual host][host virtual list]
  * VM
  * microVM
* [Container host][host container list] (Instance of container image)


## Physical host
A machine with **physical** hardware: `CPU / RAM / Disk / Network`

## Bare-metal server
  - a physical host
  - remotely allocated on a [cloud provider][cloud provider whatis], 
  - often 
    - without a hypervisor or VM layer.
    - With an OS.

## Virtual host
A machine with **virtual** hardware: `CPU / RAM / Disk / Network`

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


## Container host
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

# Physical host
- A machine with **physical** hardware: `CPU / RAM / Disk / Network`
- Runs
  - a (special) [OS][os whatis] when provisioned with a [Hypervisor][hypervisor whatis]
  - a standard [OS][os whatis] when provisioned with standard tool

# Hypervisor 
- Software provisioned on a physical host
- Creates and manages **isolated** VMs on that host
- Provides isolation of VMs from other and from the host OS.
```
Physical Host
    │
    └── Hypervisor
         │
         ├── VM 1 → OS → Linux
         │
         ├── VM 2 → OS → Linux
         │
         └── VM 3 → OS → Windows

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