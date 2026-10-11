[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Image][home topic] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[hypervisor list]: ../list/hypervisor.md
[tool whatis]: /concept//tool/whatis/ep.md
[vm whatis]: ../whatis/vm.md
[res whatis]: /concept/resource/whatis/hardware.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of hypervisor][hypervisor list]|
|[What is a VM][vm whatis]|

<h1 align="center">What is an Hypervisor</h1>

The concept of Hypervisor

# Definition

## Virtual device
- aka. emulated device
- software code that mimic physical hardware device
- cf. [harware resource][res whatis]

## Hypervisor
- a kind of [Tool][tool whatis] 
- a [VM][vm whatis] provider 
- Create and manage [VMs][vm whatis]
- Provides isolation of VMs from other VMs and from the host OS.


# Kind
-  Bare-Metal Hypervisor
-  Hosted Hypervisor

**Bare-Metal Hypervisor**
- runs directly on the physical host's hardware resources (`CPU / RAM / Disk / Network/ ...`) of the [Physical Machine][host whatis]
- no need an OS on the [Physical Machine][host whatis]

```
Physical Host
    │
    └── Hypervisor
         │
         ├── VM 1 → Guest OS → Linux
         │
         ├── VM 2 → Guest OS → Linux
         │
         └── VM 3 → Guest OS → Windows

```

**Hosted Hypervisor**
- Runs as a [software][tool whatis] application on top of an existing, conventional operating system (like Windows, Linux, or macOS) 
```
Physical Host
    │
    │
    └── Host OS
         │
         └── Hypervisor
             │
             ├── VM 1 → Guest OS → Linux
             │
             ├── VM 2 → Guest OS → Linux
             │
             └── VM 3 → Guest OS → Windows

```


# KVM/QEMU

QEMU (**Q**uick **Emu**lator): **The Hypervisor**
- The process runs in user space.
- Handles the VM's lifecycle.
- Handles hardware devices emulation (disks, NIC, graphics, USB, motherboard chips) - very slow


KVM (*K*ernel-based **VM**): The hardware-acceleration engine
- A Linux kernel module (`kvm.ko` and `kvm-intel.ko` / `kvm-amd.ko`).
- Turns the Linux kernel into a Type-1 hypervisor
- Gives the Linux kernel the ability to talk directly to CPU virtualization extensions (Intel VT-x / AMD-V)
- Allows CPU and memory hardware virtualization at native speeds: Manage guest RAM directly in hardware.
- called by QEMU (optional)

libvirt: The **management framework & API**.
- **Unified C Library:** Offers language bindings (Python, Go, Rust, Java) to interact with hypervisors programmatically.

libvirtd: **Background Daemon** 
- Handles background service management and translates API calls into QEMU/KVM execution commands.

CLI:
- **`virt-install`:** Provisions and creates new virtual machines from ISOs, disk images, or network installs.
- **`virsh`:** Manages existing VMs (start, stop, pause, snapshot, inspect, edit XML configurations, or destroy).


**Launch QEMU without KVM**
```sh
# pure software emulation
qemu-system-x86_64 -m 512 -cdrom ubuntu.iso
```

**Launch QEMU with KVM**
```sh
 # hardware acceleration
qemu-system-x86_64 -m 512 -cdrom ubuntu.iso -enable-kvm
```

# How it works

Here are the **4 distinct use cases**, broken down by speed, hardware requirements, and best scenarios:


## 1. QEMU Without KVM (Software Emulation / TCG)
- QEMU translates guest CPU instructions into host CPU instructions dynamically in software (emulation).
- You can emulate completely different CPU/processor architectures: You can run an **ARM64**, **RISC-V** or **x86_64** VMs
* **Speed Qualification:** **Very Slow (5% – 15% of native speed)**
* **CPU / Memory:** Emulated in software.
* **Devices (vDisk, vNIC, vGPU):** Fully emulated in software.
* **Best Use Cases:**
    * **Cross-Architecture Emulation:** Running an ARM64 (e.g., Raspberry Pi) or RISC-V OS on an x86_64 Intel/AMD host processor.
    * **Legacy Hardware / OS Testing:** Simulating old PowerPC, SPARC, or vintage x86 architectures.
    * **Nested Environments:** Running VMs inside cloud environments or CI/CD pipelines where nested hardware virtualization is disabled.




## 2. QEMU With KVM (Standard Emulation)
- QEMU passes guest CPU instructions directly to the host CPU via Linux kernel virtualization features (Intel VT-x / AMD-V).
- Guest and Host must have the same CPU architecture (e.g., x86_64 guest on an x86_64 host).
* **Speed Qualification:** **Fast CPU/RAM (95%+ native), Slow Devices (20% – 40% native)**
* **CPU / Memory:** Hardware-accelerated at native speed.
* **Devices (vDisk, vNIC, vGPU):** Fully emulated in software.
* **Best Use Cases:**
    * **Maximum Guest OS Compatibility:** Installing legacy OSs (like Windows XP, older Linux distros, or installer ISOs) that lack VirtIO drivers out-of-the-box.
    * **Quick Testing & Rescue ISOs:** Booting live Linux ISOs or recovery tools without needing custom driver configurations.




## 3. QEMU With KVM + VirtIO (Paravirtualization)

- CPU/RAM run on KVM. 
- The guest OS uses dedicated **VirtIO drivers** that communicate directly with QEMU via optimized shared-memory queues, skipping legacy hardware emulation.
* **CPU / Memory:** Hardware-accelerated at native speed.
* **Devices (vDisk, vNIC, vGPU):** Paravirtualized (`virtio-blk`, `virtio-net`, `virtio-gpu`).
* **Speed Qualification:** **Near-Native Speed (90% – 98% of native performance across all components)**
    * **Best Use Cases:**
    * **Standard Cloud & Server Workloads:** The industry standard for production environments (AWS, Proxmox, OpenStack, Kubernetes/KubeVirt).
    * **Database & High-I/O Workloads:** High-throughput Linux/Windows web servers, file servers, and databases needing minimal disk and network latency.




## 4. QEMU With KVM + VFIO (PCI Passthrough)

- CPU/RAM run on KVM. 
- Specific physical PCIe devices on the host motherboard (GPU, NVMe drive, network card) are detached from the host and assigned directly to the VM via VFIO.
* **CPU / Memory:** Hardware-accelerated at native speed.
* **Devices (vDisk, vNIC, vGPU):** Direct physical hardware control (bypasses QEMU entirely for those devices).
* **Speed Qualification:** **100% Native Speed (Zero hypervisor overhead for passed-through hardware)**
* **Best Use Cases:**
    * **Gaming VMs (VFIO GPU Passthrough):** Running Windows in a VM on Linux to play games with full graphics card performance and anti-cheat compatibility.
    * **AI / Deep Learning Workloads:** Passing host NVIDIA GPUs directly to guest VMs for PyTorch/CUDA workloads.
    * **High-Frequency Trading & SR-IOV Networking:** Passing dedicated physical NIC channels directly to VMs for microsecond network latency.


## Comparison Matrix

| Use Case | CPU / RAM | vDisk / vNIC | Best For |
| --- | --- | --- | --- |
| **1. Pure QEMU (TCG)** | Very Slow (Software) | Very Slow (Emulated) | Cross-architecture (e.g., ARM on x86) |
| **2. KVM (Standard)** | Native Speed | Slow (Emulated) | Out-of-the-box compatibility for legacy OSs |
| **3. KVM + VirtIO** | Native Speed | **Near-Native Speed** | Production servers, Cloud, VMs, Databases |
| **4. KVM + VFIO** | Native Speed | **100% Native Hardware** | Gaming GPUs, Machine Learning, Direct NVMe |



# TODO




# LXC
```
Linux kernel
    │
    ├── Container A
    ├── Container B
    └── Container C
```

# LXD
- manager/orchestrator around containers and VMs






# Lxd > C'est quoi


Lxd est 
  - 1 outils linux
  - le successuer de Lxc (d'ou son nom)
  - est basé sur Lxc

Lxd permet de
  - créer des container
  - créer des vm
