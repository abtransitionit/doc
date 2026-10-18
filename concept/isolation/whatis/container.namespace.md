[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[container whatis]: ../whatis/container.md
[containerisation whatis]: ../whatis/containerisation.md
[cgroup whatis]: ../whatis/container.cgroup.md
[namespace howto]: ../howto/container.namespace.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[What is a Container][container whatis]|
|[What is a Containerisation][containerisation whatis]|
|[What is a Cgroup][cgroup whatis]|
|[How-to for Namespace][namespace howto]|

<h1 align="center">What is a Namespace</h1>

The concept of Namespace


# Definition

- A mechanism implemented in the Linux OS Kernel
- A mechanisms that give processes separate value/view of Linux Kernel Resources
- Attached to one or more kernel resources


# List of Namespace

The following kernel resources exist as namespaces. 

| # | Namespace | Flag | What it isolates | Since Kernel|
|---|-----------|------|------------------|-------|
| 1 | **mnt** (mount) | `CLONE_NEWNS` | Mount points / filesystem tree | 2.4.19 |
| 2 | **uts** | `CLONE_NEWUTS` | Hostname + NIS domain name | 2.6.19 |
| 3 | **ipc** | `CLONE_NEWIPC` | SysV IPC, POSIX message queues | 2.6.19 |
| 4 | **pid** | `CLONE_NEWPID` | Process IDs (own PID 1, own `/proc`) | 2.6.24 |
| 5 | **net** | `CLONE_NEWNET` | Network interfaces, routes, iptables, sockets | 2.6.24 |
| 6 | **user** | `CLONE_NEWUSER` | UID/GID mappings | 3.8 |
| 7 | **cgroup** | `CLONE_NEWCGROUP` | Visible cgroup hierarchy path | 4.6 |
| 8 | **time** | `CLONE_NEWTIME` | Boottime + monotonic clocks | 5.6 |

1. Each process can have a different value/view for a namespaced resources
1. Several processes can belong to the same namespaced resource and so share the same value/view of tha resoiurce.

# How it works
## Wihout Namepsace

```

                  ONE SHARED LINUX KERNEL
                  (NO NAMESPACES)
                           |
             +-------------+-------------+
             |                           |
         PROCESS A                   PROCESS B
        (Container A)               (Container B)
             |                           |
             +-------------+-------------+
                           |
                SHARED GLOBAL VIEW
             +---------------------------+
             | Hostname: my-server       |
             | PID space: shared         |
             | Network: eth0, lo         |
             | Routing table: shared     |
             | Mount tree: shared        |
             | IPC resources: shared     |
             | User IDs: host mappings   |
             | Cgroup view: shared       |
             | Time namespace: shared    |
             +---------------------------+
                           |
                     HOST KERNEL
               (one shared kernel)
```

> **Without namespaces:** The Linux kernel provides the same view/value of Kernel resources to all processes

## After Namespace
- Any process can point on any of this instance

```
                     ONE SHARED LINUX KERNEL
          (Namespaces isolate what each process sees)
                              |
             +----------------+----------------+
             |                                 |
         PROCESS A                         PROCESS B
       (Container A)                     (Container B)
             |                                 |
    +--------+--------+               +--------+--------+
    | Namespace views |               | Namespace views |
    +-----------------+               +-----------------+
    | UTS: host-A     |               | UTS: host-B     |
    | PID: 1, 2, 3    |               | PID: 1, 2, 3    |
    | NET: eth0, lo   |               | NET: eth0, lo   |
    | MNT: /root-A    |               | MNT: /root-B    |
    | IPC: IPC set A  |               | IPC: IPC set B  |
    | USER: UID map A |               | USER: UID map B |
    | CGROUP: path A  |               | CGROUP: path B  |
    | TIME: offsets A |               | TIME: offsets B |
    +-----------------+               +-----------------+
             |                                 |
             +----------------+----------------+
                              |
                  SAME UNDERLYING KERNEL
                 (shared kernel code and
                  physical machine resources)
```

**With namespaces:** The Linux kernel can provide different view/value of namespaced resource to different processes.



# What namespaces provide

- **Isolation of visibility**: 
    - A process only sees its own view of resources. 
    - A process cannot see other resources on the host.
- **Isolation of IDs**: 
    - The same PID, UID, or hostname can exist in different namespaces without conflict.
    - Each namespace has its own set of IDs.
- Isolation of IDs: The same PID, UID, or hostname can exist in different namespaces without conflict.
- Container basics: Work with other tools to keep containers separate.

# What Namespace provide
- **Isolation of visibility**: a process sees only its namespace's view of the resource
- **Isolation of identifiers**: same PID/UID/hostname can exist in multiple namespaces simultaneously
- **Foundation for containers**: combined with cgroups, caps, seccomp, LSM → a "container"

- Isolate what a container can see

# Configuration

| File / Tool | Type|Simple meaning |
|-|-|-|
| `/proc/[pid]/ns/*` |File| (Symlinks) identify which namespace a process is in |
| `/proc/[pid]/uid_map` |File| UID mapping for the process's user namespace |
| `/proc/[pid]/gid_map` |File| GID mapping for the process's user namespace |
| `/proc/[pid]/setgroups` |File| Allow/deny `setgroups()` in a user namespace |
| `/proc/sys/user/max_*_namespaces` |File| Per-user limits on how many namespaces can be created |
| `unshare(1)` |CLI|Launch a process in new namespaces |
| `nsenter(1)` |CLI|Enter an existing namespace |
| `lsns(1)` |CLI|List all namespaces on the system |
| `ip netns` |CLI| Manage network namespaces (create, list, exec) |
| `clone(2)` / `unshare(2)` / `setns(2)` |Syscall| The underlying syscalls |

**Path**
- Namespaces are exposed as symlinks under `/proc/[pid]/ns/`:
  ```
  /proc/1234/ns/mnt
  /proc/1234/ns/pid
  /proc/1234/ns/net
  /proc/1234/ns/user
  /proc/1234/ns/uts
  /proc/1234/ns/ipc
  /proc/1234/ns/cgroup
  /proc/1234/ns/time
  ```
> Two processes are in the same namespace of a given type if the symlinks point to the **same inode** (`stat -L` / `readlink`)



