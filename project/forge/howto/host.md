[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(functional)
[hypervisor whatis]: ../whatis/hypervisor.md
[hypervisor list]:   ../list/tool.md#list

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Hypervisor](../whatis/hypervisor.md)|internal
|[What is a Host](../whatis/host.md)|see


<h1 align="center">Host</h1>

# Use case
[Provisioning physical Host](#provisioning-a-virtual-host)
  - [With a bare-metal Hypervisor](#with-a-bare-metal-hypervisor)
  - [With a hosted Hypervisor](#with-a-hosted-hypervisor)
  - [with an OS running a container runtime](#with-an-os-running-a-container-runtime)

[Provisioning a Virtual Host](#provisioning-a-virtual-host)
  - [With an OS running a container runtime](#with-an-os-running-a-container-runtime-1)

# Provisioning physical Host
## With a bare-metal Hypervisor
```
Physical Host
    │
    └── Hypervisor (bare-metal hypervisor)
         │
         ├── VM 1 → Guest OS → Linux
         │           │
         │           └── Application
         │
         ├── VM 2 → Guest OS → Linux
         │           │
         │           └── Application
         │
         └── VM 3 → Guest OS → Windows
                    │
                    └── Application
```
Semantic:
- The physical machine 
  - plays the role of Host for the **VMs** (it hosts VMs).
  - So it is a Physical host.
- The [hypervisor][hypervisor whatis] 
  - runs on the physical host's hardware.
  - The creates/manages the VMs.
- Each VM 
  - is a Guest of the physical host.
  - Provides an isolated environment with its own Guest OS.
- Applications run inside the Guest OS.

## With a hosted Hypervisor

```
Physical Host
    │
    │
    └── Host OS
         │
         └── Hypervisor (hosted hypervisor)
             │
             ├── VM 1 → Guest OS → Linux
             │           │
             │           └── Application
             │
             ├── VM 2 → Guest OS → Linux
             │           │
             │           └── Application
             │
             └── VM 3 → Guest OS → Windows
                         │
                         └── Application
```
Semantic
- The physical machine 
  - plays the role of Host for the **VMs** (it hosts VMs).
  - So it is a Physical host.
- The Host OS runs on the physical machine's hardware.
- The [hypervisor][hypervisor whatis] 
  - Creates/manages the VMs.
  - Runs on the Host OS.
- Each VM 
  - Provides an isolated environment with its own Guest OS.
  - is a Guest of the physical host.
- Applications run inside the Guest OS.

## with an OS running a container runtime
```
Physical Host
    │
    └── Host OS
        │
        └── Container Runtime
            │
            ├── Container A.     ← uses the Host OS Kernel
            │   └── Application
            │
            └── Container B      ← uses the Host OS Kernel
                └── Application
```
Semantic
- The physical machine 
  - is a bare-metal server because there is no Hypervisor or VM layer
  - The physical machine plays the role of Host for the workloads/containers (it hosts containers).
  - So it is a Physical host.
- The Host OS runs on the physical machine's hardware.
- The container runtime runs on the Host OS.
- Each container
  - shares the Host OS's kernel. 
  - Provides an isolated environment for its processes/applications.

## With KVM/QEMU
```
Cloud Provider
    │
    ├── PH 01
    │    │
    │    └── KVM/QEMU
    │            │
    │            ├── VM 1 → Guest OS → Linux
    │            │           │
    │            │           └── Application
    │            │
    │            ├── VM 2 → Guest OS → Linux
    │            │           │
    │            │           └── Application
    │            │
    │            └── VM N → Guest OS → Windows
    │                        │
    │                        └── Application
    ├── PH 02
    │    │
    │    └── KVM/QEMU
    │            │
    │            ...
    ├── ...
    │    │
    │    └── KVM/QEMU
    │          │
    │          ...
    └── PH 10
         │
         └── KVM/QEMU
               │
               ...
```
Semantic
- The cloud provider provides CLI/API to 
  - Creates Bare-Metal server using a Bare-Metal provisioner
  - Install a Host OS (Linux) 
  - Install KVM/QEMU a Linux kernel module that turns the Kernel into a Hypervisor
- Each VM
  - Provides an isolated environment with its own Guest OS.
  - is a Guest of the physical host.
# Provisioning a Virtual Host
## With an OS running a container runtime

```text
Virtual Host (VM)
    │
    └── Guest OS
        │
        └── Container Runtime
            │
            ├── Container A
            │   └── Application
            │
            └── Container B
                └── Application
```
Semantic
* The VM 
  - Is a **Virtual Host** for containers (it hosts Containerss).
  - Plays the role of **Host** for the workloads/containers running on it.
  - Has its own **Guest OS** 
* The Host OS runs on the VM's hardware (that are virtual).
* The container runtime runs on the Guest OS.
* Each container
  - Shares the Guest OS kernel.
  - Provides an isolated environment for its processes/applications.
  - Is a workload hosted by the VM.

**Example**
```text
Cloud Provider
      │
      └── VM
          │
          └── Ubuntu
              │
              └── Docker
                  │
                  ├── Web container
                  │   └── Nginx
                  │
                  └── API container
                      └── Application
```
