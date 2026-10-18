[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ System][home domain] · [↖ Doc][home doc]

[//]: #(Reference)


<h1 align="center">What is Linux</h1>





# Definition
## Os
- An OS like Windows OS, Apple OS, XXX OS, that have named version.
- **Historically** attach To the CPU a and cpu manufacturer.
- **currently** attach To the **Hypervisor** (some pieces of code that Transcribe Library) :
  - **windows** can play/emulate any linux/Os
  - **linu** can play/emulate any windows/Os

## process
- A running **instance** of a program.

# Terminology

|name|type|extension|comment
|-|-|-|-|
|Linux|acro|**Linu**s torvald Uni**x**|ex: `ls`, `print`, `aws`|


# Todo
A Linux system is commonly divided into two main areas: 
- kernel space
- user space.

The CPU and OS enforce boundaries between these areas.

## 1. Kernel Space
Privileged operating-system code

**Examples**:
- Linux scheduler
- Memory management
- Device drivers
- KVM kernel modules
## 2. User SpaceUserspace
Ordinary programs running outside the kernel

**Examples**:
- qemu-system-x86_64
- virt-install
- virsh
- Web browsers and shells

# How-to run a process
```sh
# starts a process for QEMU. That executes in userspace, with its own virtual address space and restricted privileges.
qemu-system-x86_64 --version

# The shell itself is a userspace process.
echo $$
```

Yes, exactly! In fact, **containers are literally the direct historical evolution of `chroot**`.

# What is `chroot`

- `chroot` (**Ch**ange **Root**) is a classic UNIX command introduced in 1979. 
- Changes the perceived root directory (`/`) for a running process
- Prevents that process from seeing or accessing files outside that **chrooted** directory.

```
┌─────────────────────────── HOST FILESYSTEM ───────────────────────────┐
│                                                                       │
│   /                                                                   │
│   ├── bin/                                                            │
│   ├── etc/                                                            │
│   ├── home/                                                           │
│   ├── usr/                                                            │
│   └── var/                                                            │
│        └── lib/                                                       │
│             └── lxc/                                                  │
│                  └── my-container/                                    │
│                       └── rootfs/  ◄─── chroot("…/rootfs")            │
│                            ├── bin/                                   │
│                            ├── etc/                                   │
│                            ├── home/                                  │
│                            └── usr/                                   │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
                                    │
                                    │  process calls chroot()
                                    ▼
┌─────────────────────────── PROCESS'S VIEW ────────────────────────────┐
│                                                                       │
│   /   ◄─── this is now "…/var/lib/lxc/my-container/rootfs"            │
│   ├── bin/                                                            │
│   ├── etc/                                                            │
│   ├── home/                                                           │
│   └── usr/                                                            │
│                                                                       │
│   ✗ Cannot see /var, /home, /usr of the host anymore                  │
│   ✗ Cannot ".." escape above this new /                                │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘

   Same directory on disk  ──►  two different "roots" depending on
                                which process is looking at it.
```

### Why a container is "chroot on steroids"

While `chroot` restricts file access, it had major security holes and limitations:

1. A root user inside a `chroot` could break out of the directory.
2. It shared the host's process list (`ps`), network interface (`eth0`), and hardware resources without limits.

**LXC fixes all of `chroot`'s weaknesses by adding modern Linux kernel features:**

| Feature | Old `chroot` | LXC Container |
| --- | --- | --- |
| **Filesystem View** | Restricted root path | **Mount Namespace** + `pivot_root` (secure directory jail) |
| **Process List** | Sees all host processes | **PID Namespace** (container process tree starts at `PID 1`) |
| **Network** | Shares host IP/ports | **Network Namespace** (private `eth0`, routing tables, firewall) |
| **Resource Limits** | Can hog 100% host CPU/RAM | **cgroups** (caps RAM, CPU, I/O usage) |
| **User Rights** | Root inside = Root on host | **User Namespace** (Root inside = unprivileged user outside) |

---

### In Short

An LXC container is essentially a **`chroot` folder**, but wrapped in **Namespaces** (so it cannot see the host), **cgroups** (so it cannot hog host resources), and **AppArmor/Seccomp** (so it cannot break out).