[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Image][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[host whatis]: /concept/machine/whatis/host.md
[image whatis]: ../whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |

<h1 align="center">What is a Container</h1>

The concept of Container

# Definition
## Container
- Instance of [container image][image whatis]
- Essentially a **chrooted** folder with security enhanced
  - **Namespaces**: effective chroot folder - cannot see outside
  - **PID Namespace** : container process tree starts at PID 1
  - Network Namespace (private eth0, routing tables, firewall)
  - **Resource Limits**: cgroups (caps RAM, CPU, I/O usage) 
  - **User Namespace**: Root inside = unprivileged user
* An isolated environment sharing the host OS kernel
  - allows **isolation** between **groups of processes** running on the same OS kernel.
* Provides OS-level virtualization (lightweight, near-zero overhead)
- **shares** the **host kernel** and have separate 
    - process spaces
    - filesystems
    - Networking
    - Users
    - etc


## System Container (LXC/LXD) vs. Application Container (Docker)

* **System Container (LXC/LXD):** Behaves like a full virtual machine (boots systemd, init, runs SSH, full Linux OS instance), but shares the host kernel.
* **Application Container (Docker):** Packaging tool designed to run a single process/application statelessly.

# LXC / LXD

LXC (**L**inu**X** **C**ontainers): **The Core Userspace Engine**
LXC (LinuX Containers): Low-Level Container Engine
- A set of CLI and C libraries that build "lightweight sandboxes" directly inside Linux.
* A low-level userspace interface for Linux kernel containment features.
* Relies directly on Linux kernel primitives:
* **cgroups (Control Groups):** Resource limiting (CPU, Memory, I/O).
* **Namespaces:** Process, network, mount, user, and IPC isolation.
* **Seccomp / AppArmor / SELinux:** Security filtering and isolation.
* Operates directly via local configuration files and low-level CLI commands.

LXD (pronounced **L-X-D**): **The Container & VM Management Daemon**

* A modern, REST API-driven container and virtual machine manager built on top of LXC.
* Extends LXC to manage both **system containers** and **full VMs** (via QEMU integration).
* Supports image management, clustering, live migration, and advanced storage/networking backends (ZFS, Ceph, OVN).

lxd / incus: **Background Daemon**

* `lxd` (or its open-source community fork, `incus`) runs as a background service listening on a local UNIX socket or HTTPS port.
* Handles storage pools, network bridges, image downloads, and translates API requests into container or VM execution.

CLI:

* **`lxc-create` / `lxc-start`:** Low-level legacy tools used to interact directly with LXC without the LXD daemon.
* **`lxc`:** The modern unified command-line tool used to control the **LXD** daemon (e.g., `lxc launch ubuntu:22.04 my-container`).

# How it works

Here are the **4 distinct use cases**, broken down by virtualization type, security boundary, and performance:

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