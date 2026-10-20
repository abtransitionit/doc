[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — List of resources

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


| Field            | Value              |
| ---------------- | ------------------ |
| **Doc-ID**       | LIST-REST-01-RMS    |
| **Project**      | RMS                |
| **Path**         | `list/res.md)` |
| **Last Updated** | 2026-10-20         |

# List of resource representations

- Each top-level item is a **Resource Root Kind** and is itself a valid kind.
- Each descendant defines a more specific kind within that hierarchy.
- The full kind is expressed as a path. For example, `file/txt/json` or `host/vm`.

## File

```text
File
├── RegularFile
│   ├── Text
│   │   ├── PlainText
│   │   ├── JSON
│   │   ├── YAML
│   │   ├── CSV
│   │   └── XML
│   └── Binary
│       ├── Archive
│       │   ├── ZIP
│       │   └── TAR
│       ├── Compressed
│       │   ├── GZIP
│       │   └── TAR.GZ
│       └── Executable
└── Folder
```

**Concepts**

- File: An entity that stores data. In this hierarchy, it is the root kind.
- RegularFile: A file containing data rather than a directory.
- TextFile: A regular file whose content is represented as text.
- BinaryFile: A regular file whose content is treated as binary data.
- Archive: A file that groups one or more files or directory entries.
- CompressedFile: A file containing compressed data.
- Folder: An entity that organizes other filesystem entities.

**Remarks**

- Files may be provided by filesystems, HTTP servers, object-storage services such as S3, and other sources.
- JSON, YAML, CSV, and XML describe formats.
- Text and Binary describe content characteristics. We may eventually model these separately.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| File | Read data | Get, read, retrieve |
| File | Write data | Store, write, save |

## Package

```text
Package
├── Package
│   ├── System
│   │   ├── DEB
│   │   ├── RPM
│   │   └── APK
│   ├── Language
│   │   ├── NPM
│   │   ├── GO
│   │   ├── PyPI
│   │   └── Maven
│   └── ApplicationPackage
└── Repository
    ├── APT
    ├── DNF
    └── APK
```

**Concepts**

- Package: An artifact.
- PackageCapability: Install, distribute.
- SystemPackage: A package intended for an operating system's package-management system.
- LanguagePackage: A package belonging to a programming-language ecosystem.
- ApplicationPackage: A package that distributes an application or its components.
- Repository: A source from which packages can be discovered and retrieved.
- Package manager: A tool that resolves dependencies and manages package installation.
  - Examples: `apt` and `dnf`.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Package | Install | Install, deploy |
| Package | Upgrade | Upgrade, update |
| Package | Remove | Remove, uninstall |

```text
Variable
├── Environment
└── Session

Variable
├── UserVariable
└── SystemVariable
```

**Concepts**

- Variable: A named value that can be read or modified.

**Remarks**

- Scope: Defines who or what the variable belongs to. **Examples:** User, System.
- Lifetime: Defines how long the variable exists. **Examples:** Session, Persistent.

Variable

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Variable | Read value | Get, read, retrieve |
| Variable | Modify value | Set, update, write |

## Repository

```text
repo
├── git
├── container-image
└── package
```

**Concepts**

- Repository: A resource that stores and provides artifacts for discovery and retrieval.
- Repository kinds are distinguished by the type of content they store and provide.
- Git: A repository containing version-controlled data.
- ContainerImage: A repository for storing and distributing container images.
- Package: A repository for storing and distributing packages.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Repository | Retrieve artifacts | Get, fetch, download |
| Repository | Publish artifacts | Publish, push, upload |
| Repository | Discover artifacts | Search, list, query |

## Kernel

```text
kernel
├── module
└── parameter
```

**Concepts**

- Kernel: The core component of an operating system that manages system resources and provides services to software.
- Module: A component that extends kernel functionality.
- Parameter: A value that configures kernel behavior.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Kernel | Manage modules | Load, unload |
| Kernel | Manage parameters | Get, set, update |
| Kernel | Provide system services | Execute, schedule, manage |

## Host

```text
Host
├── ExecutionEnvironment
│   ├── Container
│   └── VM
├── PhysicalMachine
│   └── BareMetal
└── ...
```

**Concepts**

- Host: A resource that provides computing capabilities.
- ExecutionEnvironment: An environment in which workloads can execute.
- Container: An isolated execution environment that shares the host operating system's kernel.
- VM: A virtual machine providing a virtualized computing environment.
- PhysicalMachine: A physical computing machine.
- BareMetal: A physical machine used directly, without a virtualization layer providing virtual machines.

**Remarks**

- `ExecutionEnvironment` and `PhysicalMachine` distinguish execution abstractions from physical hardware.
- `BareMetal` may be redundant under `PhysicalMachine` if it simply means a physical machine; its precise meaning should be established before keeping it as a separate kind.
- `...` leaves room for additional host kinds as requirements emerge.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Host | Execute workloads | Run, execute |
| Host | Manage workloads | Start, stop, restart |
| Host | Provide computing resources | Allocate, release |
| Host | Creation | Create, provision |
| Host | Installation | Install, deploy |
| Host | Configuration | Configure, set up |
| Host | Lifecycle | Start, stop, restart, delete |
| Host | Inspect | Query, report |

> Querying for OS and device information.

## Cluster

```text
cluster
├── vm
└── container

cluster
├── kubernetes
└── openstack
```

**Concepts**

- Cluster: A resource composed of multiple computing resources managed as a whole.
- VMCluster: A cluster composed of virtual machines.
- ContainerCluster: A cluster composed of containers.
- BareMetalCluster: A cluster composed of bare-metal machines.
- KubernetesCluster: A provisionable Kubernetes cluster.
- OpenStackCluster: A provisionable OpenStack cluster.

**Remarks**

- Cluster kinds may classify a cluster by its composition or by the platform defining the complete environment.
- A cluster is managed and provisioned as a whole by the system.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Cluster | Provision | Create, deploy |
| Cluster | Manage members | Add, remove |
| Cluster | Inspect state | Get, list, inspect |
| Cluster | Configure | Configure, update |

## Hardware/Device

```text
hardware
├── cpu
├── ram
└── disk
```

**Concepts**

- Hardware: Components of a computing system.
- CPU: A processor that executes instructions.
- RAM: Memory used for temporary data and instructions.
- Disk: A storage device for persistent data.

**Remarks**

- These kinds represent physical hardware resources.
- `CPU`, `RAM`, and `Disk` may be individual components or resources exposed by a larger hardware resource.

**Capability**

| Resource | Capability | Related verbs |
|---|---|---|
| Hardware | Inspect | Get, inspect, query |
| Hardware | Monitor | Monitor, measure |
| Hardware | Configure | Configure, set, update |
