[//]: #(Home)
[HOME]: ../whatis/ep.md

[//]: #(functional)
[hypervisor list]: ../list/tool.md#
[hypervisor howto]: ../howto/hypervisor.md
[tool whatis]:     ../whatis/tool.md
[tool list]:       ../list/tool.md
[host whatis]:     ../whatis/host.md
[vm whatis]:       ../whatis/host.md#vm

[←][HOME] 

Related topics

|||
|-|-|
|[List of tool][tool list]|internal|
|[what is a VM][vm whatis]|internal|
|[List of hypervisors][hypervisor list]|see|
|[Howto for hypervisor][hypervisor howto]|see|


<h1 align="center">Forge Hypervisor</h1>


# Definition
- a kind of [Tool][tool whatis] 
- a [VM][vm whatis] provider 
- Create and manage [VMs][vm whatis]
- Provides isolation of VMs from other VMs and from the host OS.


# Kind
-  Bare-Metal Hypervisor
-  Hosted Hypervisor

**Bare-Metal Hypervisor**
- runs directly on the physical host's hardware resources (`CPU / RAM / Disk / Network/ ...`) of the [Physical Machine][host whatis]
- no need an OS on the [Physical Machine][host whatis]

```
Physical Host
    │
    └── Hypervisor
         │
         ├── VM 1 → Guest OS → Linux
         │
         ├── VM 2 → Guest OS → Linux
         │
         └── VM 3 → Guest OS → Windows

```

**Hosted Hypervisor**
- Runs as a [software][tool whatis] application on top of an existing, conventional operating system (like Windows, Linux, or macOS) 
```
Physical Host
    │
    │
    └── Host OS
         │
         └── Hypervisor
             │
             ├── VM 1 → Guest OS → Linux
             │
             ├── VM 2 → Guest OS → Linux
             │
             └── VM 3 → Guest OS → Windows

```

