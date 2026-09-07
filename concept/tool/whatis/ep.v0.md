[//]: #(home)
[home]: ../../README.md

[//]: #(ref)
[lifecycle whatis]: ../whatis/lfc.md



[↖][home]


<h1 align="center">Concept of Tool</h1>


# Lexical field
- Server
- Client / Server
- Software
- Application
- System
- Platform
- Task
- Action
- Operation

# Definition
Something that helps to do things


# Taxonomy

**extra Low level**
- Os

**Low level**

- Sentence
- Instruction
- Procedure
- Function
- Progarm

# Kind
- Client
- Server
- CLI, CDE
- Interactive, Shell, REPL
- Batch
- GUI

# Taxonomy

| Layer | What it represents | Examples |
| - | - | - |
| **Resource** | A physical or virtualizable unit of computational capacity or I/O | CPU core, RAM, disk, SSD, NIC, GPU |
| **Physical Machine** | A physical system composed of hardware resources that can execute computation | Bare-metal server, workstation, physical host |
| **Virtual Machine** | A software-defined machine that presents virtualized hardware resources as a machine to a guest system | VMware VM, KVM VM, AWS EC2, OVH VPS |
| **Operating System** | software that manages machine resources and provides abstractions and services to programs | Linux, Windows, FreeBSD |
| **Virtualization Software** | software that abstracts the real hardware resources of a (**PM**) as virtual resources and manages /creates **VMs**. | VMware ESXi, KVM, Hyper-V, Xen || **Process** | An executing instance of a program with its own OS-managed execution context and resources | `nginx` process, JVM process, Python process |
| **Runtime** | Software that provides the execution model and services required to run a particular class of programs | JVM, CPython, .NET CLR, Node.js |
| **Container** | An isolated execution environment for processes that shares the host OS kernel | Docker, OCI container |
| **Container** | An isolated process environment that shares the host OS kernel while providing filesystem, network, process, and resource isolation | Docker container, OCI container |
| **Container Runtime** | A runtime that allows to run container |
| **VM Runtime** | A runtime that allows to run VMs | Virtualization software
| **Execution Environment** | The complete environment in which a workload executes, including the runtime, OS/kernel, resources, isolation, and supporting services it depends on | JVM + Linux, Python + container, .NET + Windows |
| **System** | A coordinated collection of computational components that provides a defined capability or service | Database system, operating system, distributed system |
| **Platform** | A stable environment and set of capabilities on which other software, services, or systems can be built and operated | Kubernetes, AWS, Android, Azure |
| **Framework** | A reusable software structure that defines conventions, abstractions, and extension points for building applications or systems | Django, Spring, React, PyTorch |
| **Application** | Software built to perform a specific user or business function | Gmail, PostgreSQL, Photoshop |
| **Service** | A software capability exposed for consumption by other software, users, or systems | HTTP API, database service, authentication service |
| **Distributed System** | Multiple independently executing components that cooperate over a network to provide a unified capability | Kubernetes, Cassandra, Kafka |
| **Process** | An executing program with an isolated execution context and allocated system resources | nginx process, JVM process, Python process |
| **Execution Environment** | The resources, OS, isolation, runtime, and supporting components required to execute a workload | Linux + JVM, container + Python |
| **Application** | Software that implements a specific user or business purpose | Gmail, PostgreSQL, Photoshop |
| **System** | Machine + mechanisms for executing/managing computation | Computer system |
| **OS** | System software managing resources and execution | Linux, Windows |
| **Runtime**| Environment that executes a particular computational model| JVM, Python runtime, .NET |
| **Execution Environment** | Isolated/managed environment for workloads | Process, container, VM |
| **Platform** | A standardized environment on which applications/systems are built | Kubernetes, AWS, Android |
| **Framework** | Reusable architecture/programming model for building software| Django, Spring, React, PyTorch |
| **Application/System** | A concrete workload implementing a purpose | PostgreSQL, Gmail, Kubernetes control plane |



