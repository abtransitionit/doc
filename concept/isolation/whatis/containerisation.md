[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[Container runtime whatis]: ../whatis/container.runtime.md
[Container whatis]: ../whatis/container.md
[isolation whatis]: ../whatis/ep.md
[cgroup whatis]: ../whatis/container.cgroup.md
[namespace whatis]: ../whatis/container.namespace.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Container Runtime][container runtime whatis]|


<h1 align="center">What is Containerisation</h1>

The concept of Container Isolation


# Definition
- An [isolation][isolation whatis] mechanism to create isolated environment (aka. [container][container whatis])
- **Guests** are named **containers**
- The mechanism is available and implemented directly in Linux Kernel
- The mechanism uses the concept of [cgroups][cgroup whatis] and [namespacess][namespace whatis]
- [container runtime][container runtime whatis] simplified the management of [containers][container whatis]

```text
🖥️  PHYSICAL/VIRTUAL MACHINE    ← the ROOT environment (owns the resources hardware)
 │
 └── 🐧 Host OS                 ← the root OS - kernel is shared by all containers
      │                           (kernel • libs • users • fs)
      │                           kernel only is shared by all containers
      │
      │
      └── ⚙️ CONTAINER RUNTIME  ← the App that manage the containers
                │
                │
                │
                ├── 📦 Container 1   ← a NESTED environment - isolated by namespaces + cgroups
                ├── 📦 Container 2   ← a NESTED environment
                └── 📦 Container 3   ← a NESTED environment
```
```
📦 CONTAINER N                                       ← a NESTED environment
│
├── 🐧 KERNEL  ──────────────── 🔗 SHARED WITH HOST  ← the ONLY thing shared
│
├── 🔒 ISOLATED FROM HOST (own namespaces)
│    │
│    ├── 📚 Libs        ← shipped in the image • shared by apps that link them
│    ├── 🗄️ Data        ← own overlay filesystem • NOT the host's
│    ├── 🌐 Network     ← own netns • own IP • own ports
│    ├── 🔢 PIDs        ← own pidns • apps see each other, not host procs
│    └── 👤 User        ← UID mapped • host sees a different UID
│
└── 🧩 Apps (processes)
     │
     ├── 🧩 App 1  ──┐
     │               ├── 🔗 SHARED WITHIN CONTAINER
     ├── 🧩 App 2  ──┘   (same libs • users • data • network)
     │
     └── 🧩 App 3
```

```
 🔒  ISOLATION BOUNDARY      ← what keeps them apart
 │
 ├── 🚧  Separation        ← containers can't touch each other
 ├── 🛡️  Protection        ← containers can't harm the host
 └── 🎛️  Control           ← host governs resources

 ```

# Guest/Container
- The Isolated **computing environment**
- Shares the Host **OS**


# The mechanism

The main building blocks of the mechanism are:

| Tool | What it isolates |
|---|---|
| **Namespaces** | What a process can **see** (PIDs, network, mounts, users, hostname) |
| **cgroups** | What a process can **use** (CPU, RAM, I/O limits) |
| **Capabilities** | What a process is **allowed to do** (drop root powers) |
| **seccomp** | Which **syscalls** a process can make |
| **LSM (SELinux/AppArmor)** | Extra mandatory access rules |

- **Boundary** = kernel features (namespaces, cgroups, etc.)
- **Strength** = 🔒🔒 **Strong**, but **weaker than VMs** — a kernel exploit can escape
- **Weakness** = shared kernel = shared risk surface

# Todo


# Todo
