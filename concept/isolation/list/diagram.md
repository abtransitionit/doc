[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[containerisation whatis]: ../whatis/containerisation.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is Containerisation][containerisation whatis]|


<h1 align="center">List of Diagram</h1>

The concept of Isolation


# Diagram
```
🖥️  PHYSICAL COMPUTER (Linux)
 │
 ├── ⚙️  HARDWARE                    ← CPU • RAM • Disk
 │
 ├── 🐧 LINUX HOST OS (Kernel)        ← schedules ALL processes on CPU
 │    │                                 manages memory + isolation
 │    │
 │    └── 🐳 DOCKER ENGINE            ← software on the host OS
 │         │                            creates & manages containers
 │         │
 │         └── 📦 WEBSITE CONTAINER   ← isolated env, NO own kernel
 │              │
 │              ├── 🌐 Web server process   ← handles HTTP requests
 │              │
 │              └── 🔧 Worker process       ← background jobs
 │
 └── ⚠️  Key: web + worker are ordinary Linux processes
          running on the HOST kernel — the container is
          just an isolated environment around them.
```

```
🖥️  PHYSICAL MACHINE
 │
 ├── 🔲 Hypervisor                    ← Type 1 or 2
 │
 ├── 💻 VM 1   ── 🐧 Own kernel + OS   ← fully isolated
 │
 ├── 💻 VM 2   ── 🐧 Own kernel + OS   ← fully isolated
 │
 └── 💻 VM 3   ── 🐧 Own kernel + OS   ← fully isolated


🖥️  PHYSICAL MACHINE (Docker)
 │
 ├── 🐧 Host OS (shared kernel)       ← ONE kernel for everything
 │    │
 │    ├── 📦 Container 1  ── 🌐 App processes  ← shares host kernel
 │    │
 │    ├── 📦 Container 2  ── 🌐 App processes  ← shares host kernel
 │    │
 │    └── 📦 Container 3  ── 🌐 App processes  ← shares host kernel
```

You're absolutely right — that's a logical error in my tree. **Hardware is *inside* the physical computer, not a sibling of it.** The physical computer *is* the hardware (plus everything running on it). Let me fix the hierarchy:

```
🖥️  PHYSICAL COMPUTER
 │
 ├── ⚙️  HARDWARE                     ← CPU • RAM • Disk • NIC
 │    │                                 (the physical machine itself)
 │    │
 │    └── 🐧 LINUX HOST OS (Kernel)    ← runs ON the hardware
 │         │                             schedules ALL processes on CPU
 │         │                             manages memory + isolation
 │         │
 │         └── 🐳 DOCKER ENGINE        ← software on the host OS
 │              │                        creates & manages containers
 │              │
 │              └── 📦 WEBSITE CONTAINER  ← isolated env, NO own kernel
 │                   │
 │                   ├── 🌐 Web server process   ← handles HTTP requests
 │                   │
 │                   └── 🔧 Worker process       ← background jobs
 │
 └── ⚠️  Key: web + worker are ordinary Linux processes
          running on the HOST kernel — the container is
          just an isolated environment around them.
```

**The corrected logic of "who is built from what":**

| Layer | Is built from / runs on | Relationship |
|-------|------------------------|--------------|
| 🖥️ Physical computer | ⚙️ Hardware | *is* the hardware |
| 🐧 Host OS | Runs **on** the hardware | uses CPU/RAM/disk |
| 🐳 Docker Engine | Runs **on** the host OS | a process on Linux |
| 📦 Container | Managed **by** Docker | isolated env, no kernel |
| 🌐🔧 Processes | Run **on** the host kernel | ordinary Linux processes |

So the nesting is: **Hardware → Host OS → Docker Engine → Container → Processes**

And here's the **VM version** with the same fix:

```
🖥️  PHYSICAL COMPUTER
 │
 ├── ⚙️  HARDWARE                     ← CPU • RAM • Disk • NIC
 │    │
 │    └── 🔲 HYPERVISOR               ← runs directly on hardware
 │         │                            (Type 1) or on host OS (Type 2)
 │         │
 │         ├── 💻 VM 1  ── 🐧 Own kernel + OS   ← fully isolated
 │         │
 │         ├── 💻 VM 2  ── 🐧 Own kernel + OS   ← fully isolated
 │         │
 │         └── 💻 VM 3  ── 🐧 Own kernel + OS   ← fully isolated
```

Now **Hardware** is correctly the base that everything is built on, not a sibling of the physical computer. Want me to redo the earlier full nested-box diagram with this same correction?

```
⚙️  HARDWARE                     ← the physical stuff (CPU, RAM, disk, NIC)
 │
 └── 🖥️  PHYSICAL COMPUTER       ← the assembled machine
      │
      └── 🐧 LINUX HOST OS (Kernel)
           │
           └── 🐳 DOCKER ENGINE
                │
                └── 📦 WEBSITE CONTAINER
                     │
                     ├── 🌐 Web server process
                     │
                     └── 🔧 Worker process
```

```
🖥️  PHYSICAL COMPUTER
 │
 └── ⚙️  HARDWARE                ← CPU • RAM • Disk • NIC
      │
      └── 🐧 LINUX HOST OS (Kernel)
           │
           └── 🐳 DOCKER ENGINE
                │
                └── 📦 WEBSITE CONTAINER
                     │
                     ├── 🌐 Web server process
                     │
                     └── 🔧 Worker process
```

```
⚙️  Hardware          ← runs on: nothing (the foundation)
 │
 └── 🖥️  Physical computer   ← built from hardware
      │
      └── 🐧 Host OS         ← runs on the hardware
           │
           └── 🐳 Docker     ← runs on the OS
                │
                └── 📦 Container  ← managed by Docker
                     │
                     └── 🌐🔧 Processes  ← run on the host kernel
```
