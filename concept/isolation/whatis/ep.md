[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[virtualization whatis]: ../whatis/virtualization.md
[containerisation whatis]: ../whatis/containerisation.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is Virtualization][virtualization whatis]|
|[What is Containerisation][containerisation whatis]|
<h1 align="center">What is Isolation</h1>

The concept of Isolation

# Definition
- A mechanism to create nested **computing/execution environment**
- made of 1 **root host** and several **guest hosts**

```
 ├── 🏠  HOST OS                      ← the ROOT Host
 │    │                                  (owns the real resources)
 │    │
 │    ├── 📦  GUEST 1                 ← a NESTED environment
 │    │     │                            (isolated from host & siblings)
 │    │     └── 🧩  ...               ← apps • processes • users • data
 │    │
 │    ├── 📦  GUEST 2                 ← a NESTED environment
 │    │     │
 │    │     └── 🧩  ...
 │    │
 │    └── 📦  GUEST 3                 ← a NESTED environment
 │          │
 │          └── 🧩  ...
 │
 └── 🔒  ISOLATION BOUNDARY          ← what keeps them apart
       │
       ├── 🚧  Separation            ← guests can't touch each other
       ├── 🛡️  Protection            ← guests can't harm the host
       └── 🎛️  Control               ← host governs resources
```       


## Host
- The root **computing/execution environment** that host the Isolated **computing environment** (aka. **Guest**).
- host the **Guest**


## Guest
- The nested **computing/execution environment** inside the **root Host**
- The isolated environment


## What it provide ?
- Each **Guest** cannot see, touch, or break another **Guest**.
- Each **Guest** as it own resources

# Kind
- [Virtualization][virtualization whatis] Isolation
- [Containerisation][containerisation whatis] Isolation


## What gets isolated ?

| Resource | Meaning |
|---|---|
| 🧠 **CPU** | Time slices, cores, priority |
| 💾 **Memory** | RAM address space, limits, OOM protection |
| 💽 **Disk / Filesystem** | Files, directories, mount points |
| 🌐 **Network** | IP, ports, interfaces, traffic |
| 👤 **Users / Processes** | PIDs, UIDs, syscalls, signals |
| 🔌 **Devices** | GPU, USB, NIC access |
| 🛡️ **Kernel** | Can it touch the kernel? |



# Containerisation Vs. Virtualization

| | Container | VM |
|---|---|---|
| 🐧 Kernel | **shared** with host | **own** kernel |
| 🧠 Emulated HW | none | virtual CPU/RAM/NIC/disk |
| ⚡ Boot | ms | seconds |
| 📦 Size | MBs | GBs |
| 🔒 Isolation strength | namespaces + cgroups | hypervisor + hardware virt |




# Todo

|Name|Isolation Mechanism|Note|
|-|-|-|
|💻 VM |hypervisor|
|📦 Container |namespaces + cgroups |
|🔒 Sandbox |syscall filtering / LSM |


---

## Side-by-Side

```text
        VIRTUALIZATION                        CONTAINERS
        ══════════════                        ══════════

🖥️  PHYSICAL MACHINE                    🖥️  PHYSICAL/VIRTUAL MACHINE
 │                                       │
 ├── 🔲 Hypervisor                        └── 🐧 Host OS  (shared kernel)
 │                                            │
 ├── 💻 VM 1  ── 🐧 Own kernel                 ├── 📦 Container 1
 │                                            ├── 📦 Container 2
 ├── 💻 VM 2  ── 🐧 Own kernel                 └── 📦 Container 3
 │
 └── 💻 VM 3  ── 🐧 Own kernel

 Isolation = at the HARDWARE level       Isolation = at the KERNEL level
 Boundary  = hypervisor                  Boundary  = namespaces + cgroups
 Strength  = 🔒🔒🔒                      Strength  = 🔒🔒
 Weight    = heavy (GB, secs)            Weight    = light (MB, ms)
```

---

## One-Line Summary

> **Virtualization** isolates by giving each workload its **own kernel and virtual hardware**.
> **Containers** isolate by **sharing one kernel** but fencing processes with **namespaces, cgroups, and security modules**.

**Trade-off:** VMs = stronger isolation, more overhead. Containers = lighter, faster, but isolation depends on the shared kernel staying secure.


# Todo

# List

|Name|Tag|Description|
|-|-|-|
|Lxd||Tool
|Lxd|[Whatis][Lxd_Whatis]|Hyperviseur
|LibVirt|[Whatis][Libvirt_Whatis]|Library

<br>

|Name|Tag|Description|
|-|-|-|
|Qcow2|KVM, Xen||
|Qed|KVM||
|Raw||
|Vdi|VirtualBox|
|Vhd|Hyper-V|
|Vmdk|VMware|
