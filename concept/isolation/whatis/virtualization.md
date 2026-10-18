[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[hypervisor whatis]: ../whatis/Hypervisor.md
[vm whatis]: #
[isolation whatis]: ../whatis/ep.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is an Hypervisor][hypervisor whatis]|
|[What is a VM][vm whatis]|

<h1 align="center">What is Virtualization</h1>

The concept of Virtualization


# Definition

- An [isolation][isolation whatis] mechanism to create isolated environment
- Based on a [Hypervisor][hypervisor whatis] and [VM][vm whatis]


```text
🖥️  PHYSICAL MACHINE                ← the ROOT environment (owns the real hardware)
 │
 └── 🏠 / ⚙️ [HOST OS +] Hypervisor ← the root OS (Host OS for type 2 or Hypervisor OS for type 1)
      │                              
      │
      ├── 💻 VM 1       ← a NESTED environment - isolated by the hypervisor
      ├── 💻 VM 2       ← a NESTED environment
      └── 💻 VM 3       ← a NESTED environment
      
      └── ⚙️ HYPERVISOR           ← the App that manages the VMs
```
```text
💻 VM N                                            ← a NESTED environment
│
├── 🐧 OWN OS
│
├── 🔒 ISOLATED FROM HOST (own everything)
│    │
│    ├── 📚 Libs        ← own OS libs • per-VM, not host's
│    ├── 🗄️ Data        ← own virtual disk(s) • NOT the host's
│    ├── 🌐 Network     ← own virtual NIC • own IP • own stack (incl. kernel net stack)
│    ├── 🔢 PIDs        ← own kernel's PID table • host can't see inside
│    ├── 👤 User        ← own user space • own UIDs • host sees a different UID
│    ├── 🧠 Memory      ← own guest RAM • mapped to host pages, not shared
│    └── 💽 Devices     ← own virtual HW • emulated or passed-through
│
└── 🐧 Own kernel + OS
     │
     └── 🧩 Apps (processes)
          │
          ├── 🧩 App 1  ──┐
          │               ├── 🔗 SHARED WITHIN VM
          ├── 🧩 App 2  ──┘   (same libs • users • data • network)
          │
          └── 🧩 App 3
```


**Note**
- **pros** = kernel-level separation
- **cons** = heavy, slower to start, more RAM/CPU overhead


## Host
- Provides the resources to the **Guest** that are virtualized by the [Hypervisor][hypervisor whatis].


## Guest/VM
- The Isolated **computing environment**
- Has its own **OS** (aka. **Guest OS**)

# Kind
- Standard Virtualization
- Nested Virtualization

# Implementation
- The mechanism is available and implemented directly in Linux Kernel
- Several Tool known as [Hypervisor][Hypervisor whatis] simplified the management of [VMs][vm whatis]


# Diagrams

## Standard vs Nested

```text
        Standart Virtualization            Nested Virtualization
        ═════════════════════              ═══════════════════════

        ┌───────────────┐                  ┌───────────────┐
        │  PHYSICAL     │                  │  PHYSICAL     │
        │  MACHINE      │                  │  MACHINE      │
        │               │                  │               │
        │ ┌───────────┐ │                  │ ┌───────────┐ │
        │ │    VM     │ │                  │ │    VM     │ │
        │ │  (Guest)  │ │                  │ │  (Host)   │ │
        │ └───────────┘ │                  │ │ ┌───────┐ │ │
        │               │                  │ │ │  VM   │ │ │
        │               │                  │ │ │(Guest)│ │ │
        │               │                  │ │ └───────┘ │ │
        │               │                  │ └───────────┘ │
        └───────────────┘                  └───────────────┘


        🖥️  PHYSICAL MACHINE  (Host)         🖥️  PHYSICAL MACHINE
         │                                   │
         ├── 🔲 Hypervisor                    ├── 🔲 Hypervisor  (L0)
         │                                   │
         └── 💻 VIRTUAL MACHINE  (Guest)      └── 💻 VM  (Host / L1)
              │                                    │
              ├── 📦 Application A                 ├── 🔲 Hypervisor  (L1)
              ├── 📦 Application B                 │
              └── 🐧 Guest OS                      └── 💻 VM  (Guest / L2)
                                                        │
                                                        ├── 📦 Application A
                                                        ├── 📦 Application B
                                                        └── 🐧 Guest OS

```

```text
🖥️  PHYSICAL MACHINE
 │
 ├── 🔲 (OS +) Hypervisor           ← Type 1 or 2
 │
 ├── 💻 VM 1   ── 🐧 Own kernel + OS   ← fully isolated
 │
 ├── 💻 VM 2   ── 🐧 Own kernel + OS   ← fully isolated
 │
 └── 💻 VM 3   ── 🐧 Own kernel + OS   ← fully isolated
```



## Standard vs Nested

**Use case**: Basic Virtualization 
- Host      = **Physical Machine** = A machine implemented using physical hardware.
- **Guest** = **Virtual Machine**  = A full software-based component that behaves like a machine.

```text
┌─────────────────────────────────────────────────────────────┐
│                      PHYSICAL MACHINE                       │
│                        (Host)                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                    HYPERVISOR                         │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                  VIRTUAL MACHINE                      │  │
│  │                     (Guest)                           │  │
│  │   ┌─────────┐  ┌─────────┐  ┌─────────┐               │  │
│  │   │  App A  │  │  App B  │  │  App C  │               │  │
│  │   └─────────┘  └─────────┘  └─────────┘               │  │
│  │   ┌─────────────────────────────────────┐             │  │
│  │   │         Guest Operating System      │             │  │
│  │   └─────────────────────────────────────┘             │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                   HOST OPERATING SYSTEM               │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              PHYSICAL HARDWARE (CPU, RAM, Disk)       │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘

        ┌─────────────────────────────────┐
        │         APPLICATION             │
        ├─────────────────────────────────┤
        │           GUEST OS              │  ◄── Guest
        ├─────────────────────────────────┤
        │          HYPERVISOR             │
        ├─────────────────────────────────┤
        │            HOST OS              │  ◄── Host
        ├─────────────────────────────────┤
        │       PHYSICAL HARDWARE         │
        └─────────────────────────────────┘


        ╭──────────────────────────╮
        │      VIRTUAL MACHINE     │
        │        (Guest)           │
        ╰────────────┬─────────────╯
                     │  runs inside
                     ▼
        ╭──────────────────────────╮
        │     PHYSICAL MACHINE     │
        │        (Host)            │
        ╰──────────────────────────╯

```





**Use case** = Nested Virtualization
- Host      = **Virtual Machine** inside a Physical Machine
- **Guest** = **Virtual Machine**

```text
╔═══════════════════════════════════════════════════════════════════════╗
║                         PHYSICAL MACHINE                              ║
║                                                                       ║
║  ┌─────────────────────────────────────────────────────────────────┐  ║
║  │                      HYPERVISOR (L0)                            │  ║
║  └─────────────────────────────────────────────────────────────────┘  ║
║                                                                       ║
║  ┌─────────────────────────────────────────────────────────────────┐  ║
║  │              VIRTUAL MACHINE  (HOST / L1)                       │  ║
║  │                                                                 │  ║
║  │   ┌─────────────────────────────────────────────────────────┐   │  ║
║  │   │                  HYPERVISOR (L1)                        │   │  ║
║  │   └─────────────────────────────────────────────────────────┘   │  ║
║  │                                                                 │  ║
║  │   ┌─────────────────────────────────────────────────────────┐   │  ║
║  │   │           VIRTUAL MACHINE  (GUEST / L2)                 │   │  ║
║  │   │                                                         │   │  ║
║  │   │    ┌─────────┐  ┌─────────┐  ┌─────────┐                │   │  ║
║  │   │    │  App A  │  │  App B  │  │  App C  │                │   │  ║
║  │   │    └─────────┘  └─────────┘  └─────────┘                │   │  ║
║  │   │    ┌───────────────────────────────────────┐            │   │  ║
║  │   │    │       Guest Operating System          │            │   │  ║
║  │   │    └───────────────────────────────────────┘            │   │  ║
║  │   └─────────────────────────────────────────────────────────┘   │  ║
║  │                                                                 │  ║
║  │   ┌─────────────────────────────────────────────────────────┐   │  ║
║  │   │              Host Operating System (L1)                 │   │  ║
║  │   └─────────────────────────────────────────────────────────┘   │  ║
║  └─────────────────────────────────────────────────────────────────┘  ║
║                                                                       ║
║  ┌─────────────────────────────────────────────────────────────────┐  ║
║  │                    PHYSICAL HARDWARE                            │  ║
║  │                   (CPU, RAM, Disk, NIC)                         │  ║
║  └─────────────────────────────────────────────────────────────────┘  ║
╚═══════════════════════════════════════════════════════════════════════╝


╭─────────────────────────────────────────────────────────────╮
│                    PHYSICAL MACHINE                         │
│                                                             │
│  ╭───────────────────────────────────────────────────────╮  │
│  │                HYPERVISOR  (L0)                       │  │
│  ╰───────────────────────────────────────────────────────╯  │
│                                                             │
│  ╭───────────────────────────────────────────────────────╮  │
│  │           VM  ──  HOST  (L1)                          │  │
│  │                                                       │  │
│  │   ╭───────────────────────────────────────────────╮   │  │
│  │   │           HYPERVISOR  (L1)                    │   │  │
│  │   ╰───────────────────────────────────────────────╯   │  │
│  │                                                       │  │
│  │   ╭───────────────────────────────────────────────╮   │  │
│  │   │       VM  ──  GUEST  (L2)                     │   │  │
│  │   │                                               │   │  │
│  │   │   ╭───────────────────────────────────────╮   │   │  │
│  │   │   │           APPLICATION                 │   │   │  │
│  │   │   ╰───────────────────────────────────────╯   │   │  │
│  │   ╰───────────────────────────────────────────────╯   │  │
│  ╰───────────────────────────────────────────────────────╯  │
│                                                             │
│  ╭───────────────────────────────────────────────────────╮  │
│  │              PHYSICAL HARDWARE                        │  │
│  ╰───────────────────────────────────────────────────────╯  │
╰─────────────────────────────────────────────────────────────╯


    ┌──────────────────────────────────────┐
    │  PHYSICAL MACHINE                    │
    │  ┌────────────────────────────────┐  │
    │  │  VM  (Host / L1)               │  │
    │  │  ┌──────────────────────────┐  │  │
    │  │  │  VM  (Guest / L2)        │  │  │
    │  │  │  ┌────────────────────┐  │  │  │
    │  │  │  │   Application      │  │  │  │
    │  │  │  └────────────────────┘  │  │  │
    │  │  └──────────────────────────┘  │  │
    │  └────────────────────────────────┘  │
    └──────────────────────────────────────┘



```




## Emoji / Styled Version

```text
🖥️  PHYSICAL MACHINE  (Host)
 │
 ├── 🔲 Hypervisor
 │
 └── 💻 VIRTUAL MACHINE  (Guest)
      │
      ├── 📦 Application A
      ├── 📦 Application B
      └── 🐧 Guest OS
```

## Nested — Emoji Version

```text
🖥️  PHYSICAL MACHINE
│
├── 🔲 Hypervisor
│
└── 💻 VM  (Host / L1)
      │
      ├── 🔲 Hypervisor
    │
      └── 💻 VM  (Guest / L2)
           │
           ├── 📦 Application A
           ├── 📦 Application B
           └── 🐧 Guest OS
```

