[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[hypervisor whatis]: ../whatis/Hypervisor.md
[kvm whatis]:  #
[qemu whatis]: #

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a hypervisor][hypervisor whatis]|


<h1 align="center">List of Hypervisor</h1>

The concept of Hypervisor


# List of Virtual Machine Hypervisors

Well-known hypervisors


| Hypervisor | Type | Daemon? | Rootless? | Made by | Typical use |
|---------|------|-----------|---------|-------------|-------------|
| **VMware ESXi** | Type 1 | N/A (bare-metal kernel) | ❌ | VMware/Broadcom | enterprise, vSphere |
| **Microsoft Hyper-V** | Type 1 (microkernelized) | ✅ `vmms` | ❌ | Microsoft | Windows Server, Azure |
| [KVM][kvm whatis] | Type 1 (kernel module) | ❌ (kernel threads) | ✅ | Red Hat/Community | Linux cloud, OpenStack |
| **Xen** | Type 1 (hybrid) | ✅ `xencommons` | ❌ | Xen Project | AWS, security, embedded |
| **Oracle VM Server** | Type 1 | ✅ | ❌ | Oracle | Oracle workloads |
| **Proxmox VE** | Type 1 (Debian + KVM) | ✅ | ❌ | Proxmox | homelab, SMB |
| **XCP-ng** | Type 1 (Xen-based) | ✅ | ❌ | Vates | open-source XenServer replacement |
| **bhyve** | Type 1 (FreeBSD kernel module) | ❌ | — | FreeBSD | FreeBSD jails/VMs |
| **VMware Workstation** | Type 2 | ✅ | ❌ | VMware/Broadcom | desktop dev/test |
| **Oracle VirtualBox** | Type 2 | ✅ | ❌ | Oracle | cross-platform desktop |
| [QEMU][qemu whatis] | Type 2 (with KVM: Type 1) | ❌ | ✅ | Community | emulation, dev, KVM frontend |
| **Parallels Desktop** | Type 2 | ✅ | ❌ | Parallels | macOS desktop |
| **UTM** | Type 2 (QEMU frontend) | ❌ | — | Community | macOS/iOS desktop |


```
🖥️ PHYSICAL HARDWARE (CPU + MMU + VT-x/AMD-V + IOMMU)
 │
 ├── 🏗️ TYPE 1 — BARE METAL (hypervisor IS the kernel)
 │    │
 │    ├── MONOLITHIC (drivers inside hypervisor)
 │    │    ├── VMware ESXi       ← enterprise standard
 │    │    └── Oracle VM Server
 │    │
 │    ├── MICROKERNELIZED (minimal hypervisor, drivers in root partition)
 │    │    ├── Microsoft Hyper-V  ← vmms daemon, parent partition
 │    │    └── KVM (Linux)        ← kernel module, host Linux is root partition
 │    │
 │    └── HYBRID (paravirtualized Dom0 handles I/O)
 │         ├── Xen               ← Dom0 bottleneck architecture
 │         │    ├── XCP-ng
 │         │    ├── Citrix Hypervisor
 │         │    └── Proxmox VE (KVM + LXC hybrid)
 │         └── bhyve (FreeBSD)
 │
 ├── 🎛️ TYPE 2 — HOSTED (runs as process on host OS)
 │    ├── VMware Workstation / Fusion
 │    ├── Oracle VirtualBox
 │    ├── Parallels Desktop
 │    ├── QEMU (standalone, TCG emulation)
 │    └── UTM (QEMU frontend)
 │
 └── ⚠️ HYBRID / AMBIGUOUS
      ├── KVM        ← Type 1 by architecture, but runs inside Linux host
      ├── QEMU + KVM ← QEMU provides device emulation, KVM provides acceleration
      └── bhyve      ← FreeBSD kernel module, type 1 architecture but host OS persists
```

**Key architectural notes:**

- **Type 1 vs Type 2** is not always a clean distinction. KVM is a Linux kernel module that converts the host OS into a Type 1 hypervisor, yet that same Linux OS also runs normal workloads—making it functionally Type 2 as well . Oracle's own docs list KVM under both categories .

- **Xen's Dom0 bottleneck**: Xen requires a privileged "Dom0" control domain that handles all I/O for guest VMs (DomU). This is why IBM called Xen and Hyper-V "Hybrid Type-1" hypervisors—they run bare-metal but route I/O through a single bottleneck partition .

- **Hyper-V is always Type 1**, even when enabled as a role in Windows 10/11 or Windows Server. Installing Hyper-V converts the host Windows installation into the "root partition"—the hypervisor sits below it on the hardware .

- **Hypervisor architecture matters for performance**: 
    - **Monolithic** hypervisors embed device drivers inside the hypervisor itself (ESXi, KVM). Can be simpler for certain workloads
    - **Microkernelized** hypervisors run drivers in a separate root partition (Hyper-V). approach offers better isolation
    - **Hybrid** hypervisors use a Dom0 control domain (Xen). 



