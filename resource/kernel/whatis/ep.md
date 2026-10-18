[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Resource][home domain] · [↖ Doc][home doc]

[//]: #(Reference)
[resource whatis]: /concept/resource/whatis/ep.md
[capability howto]: /concept/resource/howto/operation.md

Retated Topics
|||
|-|-|
|[What is a resource][resource whatis]|

<h1 align="center">What is the OS Kernel</h1>


# Definition
- cf. the concept of [Resource][resource whatis]
- cf. howto dicover [Capability][capability howto]

# Example
- A system manages 20 **files**
- Each file has Type `File` and kind `File/...`
- But the system must still distinguish one file from another.

A resource could therefore have:
- a **kind**, such as `File/...`;
- a **identity**, unique ID reagrdless the Kind;
- **attributes**:
  - size
  - Me, group, owner - `chown`
  - mode - `chmod`
  - Location = unique on the Target = eligible for functiunal id

This is the next requirement to settle.

Question: Do you want every resource to have 
- a common identity field, regardless of its kind, or 
- should identity be specific to each resource kind 
  - file path for `File`
  - endpoint for `Service`

# Kind

## 1. Kernel resource taxonomy

```
KernelResource
├── Parameter
│   ├── Sysctl              → read, write, reset
│   │   ├── Kernel          → kernel.*
│   │   ├── Network         → net.*
│   │   ├── VM              → vm.*
│   │   ├── Filesystem      → fs.*
│   │   └── Security        → security.*
│   ├── KernelCommandLine   → inspect, configure
│   └── ModuleParameter     → read, write
│
├── Module
│   ├── Builtin             → inspect
│   ├── Loadable            → inspect, load, unload
│   └── External            → inspect, install, build, load, unload
│
├── Feature
│   ├── KernelConfig        → inspect
│   ├── KconfigOption       → inspect, configure, rebuild
│   └── KernelTaint         → inspect
│
├── Interface
│   ├── Procfs              → read, write
│   ├── Sysfs               → read, write
│   └── Debugfs             → inspect, read, write
│
└── Subsystem
    ├── Networking
    ├── MemoryManagement
    ├── Scheduler
    ├── Filesystem
    └── Security
```

## 2. Separate resource kind from access mechanism

Following your `Host → AccessStrategy` design, kernel resources can have their own access strategies.

```
KernelResource
├── Kind
│   ├── Parameter
│   ├── Module
│   ├── Feature
│   └── Interface
│
├── AccessStrategy
│   ├── SysctlCLI          → sysctl
│   ├── ProcfsFile         → /proc/...
│   ├── SysfsFile          → /sys/...
│   ├── ModuleCLI          → modprobe, insmod, rmmod
│   ├── KernelConfigFile   → .config
│   ├── KernelBuildSystem  → Kbuild
│   └── HostAgent          → agent API / CLI
│
└── Capabilities
    ├── Inspect
    ├── Read
    ├── Write
    ├── Enable
    ├── Disable
    ├── Load
    ├── Unload
    ├── Configure
    └── Rebuild
```

The key is that an access strategy doesn't determine the resource kind. For example, a sysctl parameter can be accessed through the `sysctl` CLI or by reading and writing the corresponding `/proc/sys` file.

## 3. Concrete examples

| Resource                      | Kind                  | Access strategy    | Capabilities                |
| ----------------------------- | --------------------- | ------------------ | --------------------------- |
| `net.ipv4.ip_forward`         | Parameter             | `SysctlCLI`        | Read, write                 |
| `/proc/sys/vm/swappiness`     | Parameter             | `ProcfsFile`       | Read, write                 |
| `nf_conntrack`                | Module                | `ModuleCLI`        | Inspect, load, unload       |
| `CONFIG_PREEMPT`              | Kernel feature/config | `KernelConfigFile` | Inspect, configure, rebuild |
| `/sys/module/kvm/parameters/` | Module parameter      | `SysfsFile`        | Read, sometimes write       |
| `debugfs` tracing controls    | Interface             | `DebugfsFile`      | Read, write                 |

Note that these capabilities are conditional: some parameters are read-only, some module parameters are writable only at load time, and unloading a module may be impossible while it is in use.

