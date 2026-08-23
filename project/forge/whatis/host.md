[//]: #(Reference)
[HOME]:  ../whatis/forge.md
[concept list]:   ../list/concept.md
[host list]:   ../list/host.md
[host concept]: ../list/concept.md#
[host physical list]: ../list/host.md#physical-hosts
[host virtual list]:  ../list/host.md#virtual-hosts
[host container list]:  ../list/host.md#container-host
[res whatis]:    ../whatis/res.md
[forge whatis]:  ../whatis/forge.md

[←][HOME] Related topics
- [what is Forge][forge whatis]
- [what is a resource][res whatis]
- [list of concepts][concept list]
- [list of host][host list]
- [concept of Host][host concept]

<h1 align="center">Host</h1>

# Definition
- Can be physical or virtual
- A target that can be provisioned with [resources][res whatis]
- **where/how** a [resource][res whatis] is made available

# Classification

* [Physical host][host physical list]
* [Virtual host][host virtual list]
  * VM
  * microVM
* [Container][host container list] (Instance of container image)


## Physical host
- Physical host
  - → a physical machine with CPU/RAM/DISK/NETWORK
  - → a local machine 
- Bare-metal server
  - → a physical machine with CPU/RAM/DISK/NETWORK
  - → a remote machine allocated directly to you, 
  - → without a hypervisor/VM layer between you and the hardware.
## Virtual host

The hypervisor, cloud provider, or platform are a property/attribute of a host, not a separate host category.




A virtual host can additionally be classified by its environment:
* Private Cloud
* Public Cloud
* Other Virtualized Environment

This avoids treating **AWS**, **VMware**, **KVM**, etc. as host kinds.

example:
```
AWS EC2
├── Host type: Virtual Host
├── Environment: Public Cloud
└── Provider: AWS
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

