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

- key idea: **cgroups** and **namespaces** are two *different* Linux kernel features that do two *different* jobs.


```
🐧 LINUX KERNEL
 │
 ├── 📦 NAMESPACES   → "What can this process SEE?"     (visibility)
 │
 └── ⚖️  CGROUPS     → "How much can this process USE?" (resources)
```
- **Namespaces** = privacy, separation, "I don't know you exist."
- **Cgroups**    = limits, "you can't take more than your share."
- **Namespaces**  → isolation of VIEW
- **Cgroups**     → isolation of RESOURCES

---

## 👁️ NAMESPACES — "what you can see"

```
🐧 LINUX KERNEL
 │
 └── 📦 NAMESPACES                    ← give each process its OWN view
      │
      ├── 🔢 PID namespace            ← "I'm PID 1, I see only my processes"
      │
      ├── 🌐 NET namespace            ← "I have my own IP, ports, interfaces"
      │
      ├── 📁 MNT namespace            ← "I have my own filesystem mounts"
      │
      ├── 🏷️  UTS namespace           ← "I have my own hostname"
      │
      ├── 👤 USER namespace           ← "I have my own users (root inside ≠ root outside)"
      │
      ├── 📡 IPC namespace            ← "I have my own shared memory / queues"
      │
      └── 🕐 TIME namespace           ← "I have my own clock offsets"
```

**Effect:** 
- two processes on the **same kernel** each believe they're **alone on their own machine**. 
- Neither can see the other's PIDs, network, files, or hostname.

```
   Host view                    Container A view         Container B view
┌──────────────────┐         ┌──────────────────┐     ┌──────────────────┐
│ PID 1  systemd   │         │ PID 1  nginx     │     │ PID 1  postgres  │
│ PID 542 nginx    │   →     │ PID 2  worker    │     │ PID 2  writer    │
│ PID 891 postgres │         │                  │     │                  │
│ ...              │         │ (can't see host) │     │ (can't see A)    │
└──────────────────┘         └──────────────────┘     └──────────────────┘
       ↑                              ↑                        ↑
       └────── same kernel, different PID namespace ──────────┘
```

---

## ⚖️ CGROUPS — "how much you can use"

```
🐧 LINUX KERNEL
 │
 └── ⚖️  CGROUPS (control groups)     ← limit + account resource use
      │
      ├── 🔥 cpu       cgroup          ← "max 1 CPU's worth"  → throttle
      │
      ├── 🧠 memory    cgroup          ← "max 512 MB"         → OOM kill
      │
      ├── 💾 blkio     cgroup          ← "max disk IOPS/bandwidth"
      │
      ├── 📶 net_cls / net_prio        ← "tag & prioritize network traffic"
      │
      ├── 🔢 pids      cgroup          ← "max 100 processes"
      │
      └── 📊 cpuacct                   ← "report CPU used" (accounting)
```

**Effect:** 
- the kernel **meters and caps** 
- what the group can consume
- no matter what the processes *try* to do.

```
        CPU (8 cores)
   ┌──────────────────────────────────────┐
   │                                      │
   │  📦 Container A   📦 Container B      │
   │  limit: 1 CPU     limit: 2 CPUs      │
   │  ┌─────────┐      ┌─────────┐        │
   │  │ 1 core  │      │ 2 cores │        │
   │  └─────────┘      └─────────┘        │
   │                                      │
   │  if A asks for more → 🔥 THROTTLED   │
   │  if A exceeds RAM   → 💀 OOM KILLED  │
   └──────────────────────────────────────┘
```

---

## 🧩 Putting it together — one container, both mechanisms

```
🐧 LINUX HOST KERNEL
 │
 ├── 📦 NAMESPACES applied to Container A   → gives it a PRIVATE WORLD
 │    ├── 🔢 own PID space
 │    ├── 🌐 own network
 │    ├── 📁 own filesystem view
 │    └── 🏷️  own hostname
 │
 └── ⚖️  CGROUPS applied to Container A      → gives it a BUDGET
      ├── 🔥 cpu    = max 1 CPU
      ├── 🧠 memory = max 512 MB
      └── 🔢 pids   = max 100

        ┌─────────────────────────────────────┐
        │  📦 CONTAINER A                     │
        │  ┌───────────────────────────────┐  │
        │  │ 🌐 nginx process              │  │
        │  │ 🔧 worker process             │  │
        │  └───────────────────────────────┘  │
        │                                     │
        │  👁️  SEES: only its own stuff       │  ← namespaces
        │  ⚖️  USES: only up to its budget    │  ← cgroups
        └─────────────────────────────────────┘
```

---

## 🆚 Side-by-side summary

| | 📦 NAMESPACES | ⚖️ CGROUPS |
|---|---|---|
| **Question answered** | *What can it **see**?* | *How much can it **use**?* |
| **Type of isolation** | Visibility / identity | Resource / quantity |
| **Examples** | PID, NET, MNT, UTS, USER, IPC, TIME | cpu, memory, blkio, pids, net_cls |
| **If removed** | Container sees the whole host → chaos, no privacy | Container can starve the host → DoS |
| **Enforced by** | Kernel, per-process | Kernel, per-group of processes |
| **Mental model** | 🕶️ *"blinders / separate rooms"* | 🧾 *"meter / budget / quota"* |


---

## ⚠️ The critical takeaway (ties back to your Docker file)

```
🔑 Container = NAMESPACES + CGROUPS + a few extras (capabilities, seccomp, ...)
   │
   ├── No kernel of its own — all enforced by the HOST kernel 🐧
   │
   ├── 📦 Namespaces  → isolation of VIEW
   │
   └── ⚖️  Cgroups    → isolation of RESOURCES
```

The container 
- **feels** like a separate machine → **namespaces**.
- **can't hog the host**            → **cgroups**.
- **Neither one is a security boundary by itself**
     - they isolate visibility and resources
     - Access to data is not isolated

# Mac and cgroup
> The cgroups are active inside that VM, not on macOS itself.