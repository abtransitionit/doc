[//]: #(home)
[home]: ../../README.md


[//]: #(ref)
[hres whatis]: ../whatis/hres.md
[tool whatis]: ../../../concept/tool/whatis/ep.md
[lifecycle whatis]: ../whatis/lfc.md
[machine whatis]: #machine
[term list]: ../list/term.md



[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[List of terms][term list]|internal|
|[What is a hardware resource][hres whatis]|internal|



<h1 align="center">The Concept of Machine</h1>


# Definition

**Semantic field**: Hardware, Host

| Term | What it represents | Examples |
| - | - | - |
| Machine | A composition of [hardware resources][hres whatis] | Bare-metal server |
| Physical Machine | <li>A machine with real hardware resources <li>Can execute computation | Bare-metal server, workstation, physical host |


```
                    PHYSICAL RESOURCES
                   (CPU / RAM / Disk / NIC)
                          │
            ┌─────────────┴─────────────┐
            │                           │
            ▼                           ▼
┌─────────────────────┐      ┌─────────────────────┐
│  PHYSICAL MACHINE   │      │  PHYSICAL MACHINE   │
│  32 CPU / 128 GB    │      │  12 CPU / 1000 GB   │
└─────────────────────┘      └─────────────────────┘
```


| Term | What it represents | Examples |
| - | - | - |
| Operating System | <li>Low level [program][tool whatis] <li>Manages a **machine**'s hardware resources <li>Provides abstractions and services to programs | Linux, Windows, FreeBSD |
| Hypervisor | <li> Aka. Virtualization Software<li>Low level program <li>Abstracts a **PM**'s hardware resources into virtual hardware resources <li>Provides abstractions and services to **VMs** it creates and manages. | VMware ESXi, KVM, Hyper-V, Xen |
| Virtual Machine | <li>Low level program <li>A machine with **virtual** hardware resources <li>runs its own OS <li> Can execute computation | VMware VM, KVM VM, AWS EC2, OVH VPS |

**Use cases**

```
                                   ┌─────────────────────┐
                                   │  PHYSICAL MACHINE   │
                                   │  32CPU / 128 GB     │
                                   └─────────────────────┘
                                              │
                                ┌─────────────┴─────────────┐
                                │                           │
                          USE CASE 01                 USE CASE 02
                                │                           │
                                ▼                           ▼
                ┌────────────────────────┐      ┌──────────────────────────┐
                │    PHYSICAL MACHINE    │      │      PHYSICAL MACHINE    │
                │                        │      │                          │
                │  ┌───────────────┐     │      │  ┌───────────────────┐   │
                │  │     OS        │     │      │  │    Hypervisor     │   │
                │  │   (Linux)     │     │      │  │   (VMware/KVM)    │   │
                │  │               │     │      │  │                   │   │
                │  │    Manages    │     │      │  │  Manages VMs      │   │
                │  │ Applications  │     │      │  └─────────┬─────────┘   │
                │  └───────────────┘     │      │            │             │
                │                        │      │   ┌────────┴────────┐    │
                │  OS runs directly      │      │   ▼                 ▼    │
                │  on hardware resources │      │ ┌─────────┐  ┌─────────┐ │
                │  resources.            │      │ │  VM 1   │  │  VM 2   │ │
                │                        │      │ │         │  │         │ │
                │                        │      │ │ 8 vCPU  │  │ 4 vCPU  │ │
                └────────────────────────┘      │ │ 32 GB   │  │ 16 GB   │ │
                                                │ └─────────┘  └─────────┘ │
                                                │                          │
                                                │ Hypervisor runs directly │
                                                │ on hardware resources    │
                                                │                          │
                                                │                          │
                                                │ hypervisor abstracts the │
                                                │ hardware and shares      │
                                                │ it between multiple VMs. │
                                                │                          │
                                                └──────────────────────────┘
```

Each VM runs its own OS

# Definition



- **Physical Machine** (PM) is a composition of real [hardware resources][hres whatis].
- **Virtual Machine** (VM) is a composition of virtual [hardware resources][hres whatis]

\

```
Physical resources
        │
        ▼
┌───────────────────────┐
│ Physical Machine      │
│  32 CPU cores         │
│  128 GB RAM           │
│  2 TB NVMe            │
│  25 Gb NIC            │
└───────────────────────┘
        │
        │ virtualization
        ▼
┌───────────────────────┐
│ Virtual Machine       │
│  8 vCPU               │
│  32 GB vRAM           │
│  500 GB virtual disk  │
│  virtual NIC          │
└───────────────────────┘
```


## Layer 01
| Layer | What it represents | Examples |
| - | - | - |
| Machine | A collection of [hardware resources][hres whatis] | Bare-metal server |
| Physical Machine | A machine, with real hardware resources, that can execute computation | Bare-metal server, workstation, physical host |

## Layer 02

| Layer | What it represents | Examples |
| - | - | - |
| Operating System | Low level software that manages a **machine**'s resources and provides abstractions and services to programs | Linux, Windows, FreeBSD |
| Virtualization Software | Low level software that abstracts a **PM**'s hardware resources into virtual resources and provides abstractions and services to **VMs** it creates and manages. | VMware ESXi, KVM, Hyper-V, Xen |
| Virtual Machine | A (software) machine, with virtual hardware resources, that can execute computation | VMware VM, KVM VM, AWS EC2, OVH VPS |

**Use cases**

```
                    PHYSICAL RESOURCES
                   (CPU / RAM / Disk / NIC)
                          │
                          ▼
              ┌─────────────────────┐
              │  PHYSICAL MACHINE   │
              │  32 CPU / 128 GB    │
              └─────────────────────┘
                          │
            ┌─────────────┴─────────────┐
            │                           │
            ▼                           ▼
┌────────────────────────┐     ┌──────────────────────────┐
│    USE CASE 01         │     │      USE CASE 02         │
│                        │     │                          │
│  ┌───────────────┐     │     │  ┌───────────────────┐   │
│  │     OS        │     │     │  │  Virtualization   │   │
│  │   (Linux)     │     │     │  │    Software       │   │
│  │               │     │     │  │   (VMware/KVM)    │   │
│  │ Applications  │     │     │  └─────────┬─────────┘   │
│  └───────────────┘     │     │            │             │
│                        │     │   ┌────────┴────────┐    │
│  OS runs directly      │     │   ▼                 ▼    │
│  on hardware resources │     │ ┌─────────┐  ┌─────────┐ │
│  resources.            │     │ │  VM 1   │  │  VM 2   │ │
│                        │     │ │         │  │         │ │
│                        │     │ │ 8 vCPU  │  │ 4 vCPU  │ │
└────────────────────────┘     │ │ 32 GB   │  │ 16 GB   │ │
                               │ └─────────┘  └─────────┘ │
                               │                          │
                               │ Hypervisor runs directly │
                               │ on hardware.resources    │
                               │                          │
                               │                          │
                               │ hypervisor abstracts the │
                               │ hardware and shares      │
                               │ it between multiple VMs. │
                               │                          │
                               └──────────────────────────┘
```
Each VM runs its own OS

## Layer 03

| Layer | What it represents | Examples |
| - | - | - |
||
| Process | An instance of a **program** with its own OS-managed execution context and resources | `nginx` process, **JVM** process, `Python` process, Container runtime process, VM runtime process |
| Runtime | Software that provides the execution model and services required to run a particular class of programs | JVM, CPython, .NET CLR, Node.js |
| Container | An isolated execution environment for processes that shares the host OS kernel | Docker, OCI container |
| Container | An isolated process environment that shares the host OS kernel while providing filesystem, network, process, and resource isolation | Docker container, OCI container |
| Runtime | Environment that executes a particular computational model| JVM, Python runtime, .NET |
| Container Runtime | A runtime that allows to run container |
| VM Runtime | A runtime that allows to run VMs | Virtualization software
| Execution Environment | The complete environment in which a workload executes, including the runtime, OS/kernel, resources, isolation, and supporting services it depends on | JVM + Linux, Python + container, .NET + Windows |
| System | Machine + mechanisms for executing/managing computation | Computer system |
| System | A coordinated collection of computational components that provides a defined capability or service | Database system, operating system, distributed system |
| Platform | A standardized environment on which applications/systems are built | Kubernetes, AWS, Android |
| Platform | A stable environment and set of capabilities on which other software, services, or systems can be built and operated | Kubernetes, AWS, Android, Azure |
| Framework | Reusable architecture/programming model for building software| Django, Spring, React, PyTorch |
| Framework | A reusable software structure that defines conventions, abstractions, and extension points for building applications or systems | Django, Spring, React, PyTorch |
| Application | Software built to perform a specific user or business function | Gmail, PostgreSQL, Photoshop |
| Application/System | A concrete workload implementing a purpose | PostgreSQL, Gmail, Kubernetes control plane |
| Application | Software that implements a specific user or business purpose | Gmail, PostgreSQL, Photoshop |
| Service | A software capability exposed for consumption by other software, users, or systems | HTTP API, database service, authentication service |
| Distributed System | Multiple independently executing components that cooperate over a network to provide a unified capability | Kubernetes, Cassandra, Kafka |
| Process | An executing program with an isolated execution context and allocated system resources | nginx process, JVM process, Python process |
| Execution Environment | Isolated/managed environment for workloads | Process, container, VM |
| Execution Environment | The resources, OS, isolation, runtime, and supporting components required to execute a workload | Linux + JVM, container + Python |
| OS | System software managing resources and execution | Linux, Windows |





| Layer | What it represents | Examples |
| ------------------------- | ------------------------------------------------------------------ | ------------------------------------------- |
| Resource | Something that can be consumed | CPU cores, RAM, storage, NIC |
| System | Machine + mechanisms for executing/managing computation | Computer system |
| OS | System software managing resources and execution | Linux, Windows |
| Runtime | Environment that executes a particular computational model | JVM, Python runtime, .NET |
| Execution Environment | Isolated/managed environment for workloads | Process, container, VM |
| Platform | A standardized environment on which applications/systems are built | Kubernetes, AWS, Android |
| Framework | Reusable architecture/programming model for building software | Django, Spring, React, PyTorch |
| Application/System | A concrete workload implementing a purpose | PostgreSQL, Gmail, Kubernetes control plane |
| Ecosystem | Collection of mutually reinforcing platforms/tools/frameworks | Java ecosystem, cloud-native ecosystem |
