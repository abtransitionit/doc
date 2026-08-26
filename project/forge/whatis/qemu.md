[//]: #(Home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[qemu howto]:   ../howto/qemu.md
[vm whatis]:   ../howto/qemu.md

[←][home] 

Related topics
|||
|-|-|
|[howto for QEMU][qemu howto]|see




<h1 align="center">Forge QEMU/KVM</h1>


# Definition
- KVM is a tool that manages the **virtualization**
- QEMU is a tool that manages the **emulation**: 
  - Creates **software** that acts like **hardware**. 
  - Manages communication between virtual hardware and physical hardware by translating to and from virtual ←→ physical. 

# How it works

|Tool| Operation | Description | Comment |
|-| :--- | :--- | :--- |
|KVM| **Virtualization** | <li>**Shares** real physical hardware resources (`CPU / RAM`) among multiple VMs. <li>The hardware are **real**, but **divided** and **allocated**. |Fast|
|QEMU| **Emulation** | <li>Creates virtual hardware: vNIC, vHDD, vGPU, vUSB, vBIOS <li>Exposes them to VMs|very slow|

# QEMU without KVM
- It is possible to have [VMs][vm whatis] under `QEMU` without `KVM`. 
- QEMU simply creates **vCPU** and **vRAM** like it does with **vNIC, vHDD, vGPU, vUSB, vBIOS**. 
- So, it is much slower (10x, 100x), because of the translation **vCPU** ←→ **CPU** for each instruction


