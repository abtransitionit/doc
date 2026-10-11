[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Image][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md
[image whatis]: ../whatis/ep.md
[repo whatis]: /concept/repository/whatis/ep.md
Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Repository][repo whatis]

<h1 align="center">What is a Container</h1>

The concept of Container

# Definition

## Registry
- A service
- Stores and distributes container images
- Contains repositories that contain container images identified by tags or digests

## Container

- Instance of [container image][image whatis]
- **isolated environment** sharing the host **OS kernel**
- **Namespaces** (workspace isolation):
    * **PID**: isolated process tree starting at **PID 1**
    * **Network**: private `eth0`, routing tables, and firewall rules
    * **User**: root inside = unprivileged user outside
    * **Mount**: isolated filesystem root (`/`)
- **cgroups** (resource control). Enforces limits on: CPU, RAM, and Disk I/O usage


## LXC (**L**inu**X** **C**ontainers)

- A wrapper around **Linux kernel features**
- Set of CLIs, C library (`liblxc`), and config files toolset acting as a low-level userspace interface.
- Relies directly on Linux kernel features:
    - **Namespaces:** Process, network, mount, user, and IPC isolation.
    - **cgroups (Control Groups):** Resource limits (CPU, Memory, Disk).
    - **Seccomp / AppArmor / SELinux:** Security filtering and access control.

## LXD (**L**inu**X** daemon)
- written in `go`
- community fork is `incus`
- Manages both system 
    - containers (not OCI-compliant - LXD-specific images)
    - VMs through the same interface and tooling.
- runs as a background service/Daemon listening on a local UNIX socket or HTTPS port.
- CLI example= `lxc launch ubuntu:22.04 my-container` talk to daemon
- Wrapper around LXC and integrate with QEMU
- Mangae Container & VM via API
- Allows local or remote control of containers over a network.
- Behaves like a full VM (boots systemd, init, runs SSH, full Linux OS instance), but shares the host kernel.
- Handles 
    - storage pools
    - network bridges
    - image downloads
    - translates API requests into container or VM execution.
- Provides VM-like operational features:
    - **Image Management:** Centralized hub for official OS image templates.
    * **Profiles & Storage:** 
        - Reusable resource policies
        - storage pools (ZFS, btrfs, LVM)
        - custom virtual networks.
    - **Live Migration & Clustering:** Move running containers across host nodes with zero downtime.
    - **QEMU Integration:** Manages system containers and full Virtual Machines under one unified interface.
- Supports image management, clustering, live migration, and advanced storage/networking backends (ZFS, Ceph, OVN).

 # Incus
 - Fork of **LXD** in 2023
 - Debian has deprecated **LXD** in favor of Incus
 - Hosted by Canonical (Ubuntu)
 - Often described as lightweight VM because or System Container because
    - It manage more like a VM
    - 

```
┌─────────────────────────────────────────────────────────────┐
│                    USER / CLIENT                            │
│         (CLI: lxc ...  |  REST API: HTTPS)                  │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  LXD  —  System daemon + REST API + orchestration           │
│  • Manages containers & VMs as "instances"                  │
│  • Images, storage pools, networks, clustering, projects    │
│  • Talks to liblxc via Go bindings                          │
└──────────────────────────┬──────────────────────────────────┘
                           │  (Go bindings → liblxc)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  LXC  —  Low-level C library + tools (liblxc, lxc-*)        │
│  • Creates & starts containers                              │
│  • Config templates, hooks, C API / bindings                │
└──────────────────────────┬──────────────────────────────────┘
                           │  (syscalls)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│  KERNEL FEATURES                                            │
│  • Namespaces  → isolation (pid, net, mnt, uts, ipc, user)  │
│  • cgroups     → resource limits (CPU, RAM, I/O, devices)   │
│  • Seccomp     → syscall filtering                          │
│  • Capabilities, AppArmor/SELinux, overlayfs, etc.          │
└─────────────────────────────────────────────────────────────┘

LXD → LXC → Kernel
```


| Layer | Role | Adds |
|-------|------|------|
| **Kernel** | Primitives | Isolation & resource control |
| **LXC** | C library | Easy, programmatic use of those primitives |
| **LXD** | Daemon/API | Multi-host orchestration, images, networking |

# LXD containe vs OCI container



# How it works


## 1. Low-Level LXC (Standalone / Direct Engine)

* Interacts directly with Linux kernel cgroups and namespaces without a management daemon.
* Configured manually via file paths and low-level commands (`lxc-start`, `lxc-attach`).
* **Speed Qualification:** **100% Native Speed (Zero hypervisor overhead)**
* **CPU / Memory:** Direct host execution managed by host kernel scheduler/cgroups.
* **Storage / Network:** Standard Linux veth pairs, host directory mounts, or simple bridges.
* **Best Use Cases:**
* **Minimalist/Embedded Systems:** Running isolated environments on routers, single-board computers, or lightweight Linux nodes without daemon overhead.
* **Deep Custom System Integration:** Building custom container orchestration tools directly on Linux kernel features.



## 2. LXD System Containers (Unprivileged)

* Managed by the LXD daemon using kernel User Namespaces (UID/GID mapping).
* The root user inside the container maps to an unprivileged non-root UID on the host.
* **Speed Qualification:** **100% Native Speed (Near-zero performance penalty)**
* **CPU / Memory:** Native execution; restricted by cgroups quotas.
* **Storage / Network:** Advanced backends managed by LXD (ZFS, Btrfs, LVM, OVN, macvlan).
* **Best Use Cases:**
* **Multi-Tenant Linux Infrastructure:** Hosting hundreds of isolated Linux servers (Ubuntu, Debian, Arch) on a single physical host with high density.
* **Lightweight Development Environments:** Replacing heavy virtual machines with instant-booting full OS instances.



## 3. LXD Privileged Containers

* Container root (`UID 0`) is directly mapped to host `UID 0`.
* Lacks full user namespace isolation, relying primarily on AppArmor/SELinux and cgroups for boundaries.
* **Speed Qualification:** **100% Native Speed (Direct hardware access abilities)**
* **CPU / Memory:** Native execution without translation layers.
* **Storage / Network:** Direct access to host block devices, raw mounts, and hardware interfaces.
* **Best Use Cases:**
* **Hardware & Device Access Workloads:** Containers requiring direct access to host GPU, USB, or raw block devices without VFIO configuration.
* **Nested Containerization:** Running Docker or LXC inside an LXD container without complex user namespace mapping restrictions.



## 4. LXD Virtual Machines (QEMU / KVM Managed via LXD)

* LXD orchestrates a full QEMU/KVM Virtual Machine under the hood instead of a container.
* Uses strict hardware-level virtualization boundaries with its own isolated kernel.
* **Speed Qualification:** **Near-Native Speed (90% – 98% via automatic KVM + VirtIO tuning)**
* **CPU / Memory:** KVM hardware acceleration (Intel VT-x / AMD-V).
* **Storage / Network:** VirtIO-based disks and network interfaces managed seamlessly by LXD.
* **Best Use Cases:**
* **Non-Linux & Custom Kernels:** Running Windows guest OSs or custom Linux kernel builds that cannot share the host kernel.
* **Strict Security Boundaries:** Workloads requiring complete hardware isolation guarantees beyond kernel namespace separation.



## Comparison Matrix

| Use Case | OS Kernel | Isolation Boundary | Best For |
| --- | --- | --- | --- |
| **1. Pure LXC** | Shared Host Kernel | Basic Kernel Namespaces | Embedded systems, low-level scripts |
| **2. LXD Container (Unprivileged)** | Shared Host Kernel | User Namespaces + cgroups | Secure multi-tenant Linux OS hosting |
| **3. LXD Container (Privileged)** | Shared Host Kernel | Weak (Direct Host Root) | Nested Docker, raw hardware access |
| **4. LXD VM (KVM Integration)** | Dedicated Guest Kernel | Hardware Hypervisor (KVM) | Non-Linux OSs (Windows), untrusted workloads |