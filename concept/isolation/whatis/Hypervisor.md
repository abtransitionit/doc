[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Isolation][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[virtualization whatis]: ../whatis/virtualization.md
[hypervisor list]: ../list/hypervisor.md

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is Virtualization][virtualization whatis]|
|[List of Hypervisor][hypervisor list]|

<h1 align="center">What is A Hypervisor</h1>

The concept of Hypervisor


# Definition
- A system
- Low level VMs manager
- Virtualize the harware resource of th **Host** 

# Kind
**Type 1 — Bare-Metal (Native)**
- Runs **directly on hardware**
- No host OS underneath
- Purpose: data centers, servers, performance
- Examples: `VMware ESXi`, `Microsoft Hyper-V`, `Xen`, `KVM`

**Type 2 — Hosted**
- Runs **on top of a OS**
- Host OS sits between hypervisor and hardware
- Purpose: desktops, dev/testing, convenience
- System: `VirtualBox`, `VMware Workstation`, `Parallels`, `QEMU`

# Diagram


## Type 1 Hypervisor (Bare-Metal)

```
🖥️  PHYSICAL COMPUTER
 │
 ├── ⚙️  HARDWARE                     ← CPU • RAM • Disk • NIC
 │    │
 │    └── 🔲 HYPERVISOR (TYPE 1)      ← runs DIRECTLY on hardware
 │         │                            (bare-metal / native)
 │         │                            no host OS underneath
 │         │
 │         ├── 💻 VM 1  ── 🐧 Own kernel + OS   ← fully isolated
 │         │
 │         ├── 💻 VM 2  ── 🐧 Own kernel + OS   ← fully isolated
 │         │
 │         └── 💻 VM 3  ── 🐧 Own kernel + OS   ← fully isolated
 │
 └── 📝 Examples: VMware ESXi • Microsoft Hyper-V • Xen • KVM
```

**Key point:** 
- The hypervisor **is** the operating system layer. 
- It talks straight to the hardware.
- **usage**: production, servers, clouds (performance + security matter).
---

## Type 2 Hypervisor (Hosted)

```
🖥️  PHYSICAL COMPUTER
 │
 ├── ⚙️  HARDWARE                     ← CPU • RAM • Disk • NIC
 │    │
 │    └── 🪟 HOST OPERATING SYSTEM    ← e.g. Windows / macOS / Linux
 │         │                            runs on the hardware
 │         │
 │         └── 🔲 HYPERVISOR (TYPE 2)  ← runs as an APP on the host OS
 │              │                        (hosted)
 │              │
 │              ├── 💻 VM 1  ── 🐧 Own kernel + OS   ← fully isolated
 │              │
 │              ├── 💻 VM 2  ── 🐧 Own kernel + OS   ← fully isolated
 │              │
 │              └── 💻 VM 3  ── 🐧 Own kernel + OS   ← fully isolated
 │
 └── 📝 Examples: VirtualBox • VMware Workstation • Parallels • QEMU
```

**Key point:** 
- The hypervisor is just another program running on top of a normal host OS
- it adds an extra layer between VMs and hardware.
- **usage**: learning, testing, desktops (convenience matters).


## Pros/Cons

```
   TYPE 1 (Bare-Metal)              TYPE 2 (Hosted)
   ───────────────────              ───────────────

   ┌─────────────┐                  ┌─────────────┐
   │    VMs      │                  │    VMs      │
   ├─────────────┤                  ├─────────────┤
   │ HYPERVISOR  │                  │ HYPERVISOR  │
   ├─────────────┤                  ├─────────────┤
   │  HARDWARE   │                  │  HOST OS    │
   └─────────────┘                  ├─────────────┤
                                    │  HARDWARE   │
                                    └─────────────┘

   ✅ Faster / less overhead        ✅ Easier to install/use
   ✅ More secure & isolated        ✅ Runs on your laptop
   ✅ Used in data centers          ❌ Slower (extra OS layer)
   ❌ Needs dedicated machine       ❌ Less secure (host = attack surface)                                    
```

