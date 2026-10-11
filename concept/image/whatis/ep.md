[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[registry list]: ../list/registry.md
[hypervisor list]: ../list/hypervisor.md
[vm whatis]: ../list/registry.md
[container whatis]: ../whatis/vm.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[List of registries][registry list]|
|[List of hypervisor][hypervisor list]|

<h1 align="center">What is an Image</h1>

The concept of Image

# Definition

## Image
- Static binary file
- Can be versioned
- SHA-256 hash of the file

## Registry
- where images are stored and versioned 

# Key characteristics:

**Immutable** 
- once built, an image does not change
- modifications produce a new image (or a writable layer on top).

**Portable**
- can be moved between hosts, environments, and clouds.

**Reproducible** 
- guarantees the same contents everywhere it runs.

**Layered/structured** 
- often composed of stacked layers or partitions (base OS, dependencies, app, config).

# Kind

## Container Image

- Versioning of the file is implemented using **tag**
- the file are stored in a [registry][registry list]
- Lightweight, layered package: app + dependencies + runtime.
- Composed of read-only layers; a writable layer is added at runtime.
- **Instanciated** into **container** by the **container runtime**.
- file size range from from 1 to 30 MBs
- **Formats**:
    - **OCI** Image (open standard) — application/vnd.oci.image.*
    - **Docker** Image (Docker's format; now OCI-compatible)
    - **Apptainer/Singularity** Image (.sif, for HPC)
- **Formats**:
    - **OCI Image** (open standard) — `application/vnd.oci.image.*`
    - **Docker Image** (Docker's format; now OCI-compatible)
    - **Apptainer/Singularity Image** (`.sif`, for HPC)
- **Operations**:
    - **Build**  → create from a spec (Dockerfile, Containerfile).
    - **Push / Pull** → move to/from a registry.
    - **Instantiate** → runtime creates a container from the image.
    - **Tag / Version** → label variants (e.g., `app:1.0`).


## Disk Image
- Contains copy of a storage device or filesystem.
- file size range  from 1O to 100 GBs
- Preserves the exact structure and contents of the source device, including
  - partition tables
  - filesystems
  - data
- **Operations**:
    - **Attach**  → presented to a VM as a vDISK.
    - **Mount**   → exposed to the host OS as a filesystem (loopback).
    - **Restore** → written back to a physical or virtual device.
    - **Clone**   → copied to create an identical device.
- **Formats**:
    | Format | Extension | Description |
    | ------ | --------- | ----------- |
    | RAW    | `.img`, `.dd` | Plain byte-for-byte copy. |
    | ISO    | `.iso`    | Optical disc image. |
    | QCOW2  | `.qcow2`  | QEMU/KVM, supports snapshots. |
    | VMDK   | `.vmdk`   | VMware. |
    | VHD    | `.vhd`    | Microsoft Hyper-V. |
    | VHDX   | `.vhdx`   | Microsoft Hyper-V (newer format). |
    | DMG    | `.dmg`    | Apple. |



## VM Image
- A bootable **Disk Image**: Contains a full OS + bootloader.
- size range from from 10 to 20 GBs
- **Instantiated** into a **VM** by the **hypervisor**.
- **Formats**:
    | Name  | Extension | Tag                        | Description                                                                  |
    | ----- | --------- | -------------------------- | ---------------------------------------------------------------------------- |
    | QCOW2 | .qcow2    | KVM, QEMU, Xen             | Copy-on-write disk image format supporting snapshots and thin provisioning.  |
    | QED   | .qed      | KVM, QEMU                  | QEMU Enhanced Disk; an older format superseded by QCOW2.                     |
    | RAW   | .raw, .img| Hypervisor-agnostic        | Plain disk image format with minimal overhead.                               |
    | VDI   | .vdi      | VirtualBox                 | Native VirtualBox virtual disk format.                                       |
    | VHD   | .vhd      | Hyper-V, VirtualBox, Xen   | Microsoft Virtual Hard Disk format.                                          |
    | VHDX  | .vhdx     | Hyper-V                    | Newer VHD format supporting larger disks and improved resilience.            |
    | VMDK  | .vmdk     | VMware, VirtualBox, QEMU   | Virtual Machine Disk format, commonly used by VMware.                        |
    | AMI   | .ami      | AWS EC2                    | Amazon Machine Image used to launch EC2 instances.                           |
    | OVA   | .ova      | VMware, VirtualBox, others | Archive packaging a virtual machine and its associated files.                |
    | OVF   | .ovf      | VMware, VirtualBox, others | Open Virtualization Format for describing and distributing virtual machines. |  
- **Operations**:
    - **Instantiate** → hypervisor attaches the image as the VM's vDISK and boots the VM from it.
    - **Convert**    → reformat between hypervisor disk formats( e.g., VMDK ↔ QCOW2 ↔ VHDX, or → AMI)..
    - **Clone**      → create an identical bootable template.
    - **Customize**  → inject config, credentials, or software before first boot (cloud-init, sysprep, Packer).
    - **Export**     → package for distribution or archival (e.g., OVA/OVF).

# Other images

## 1. Golden Image
- A **standardized template**
- a VM image + updates + preinstalled software + cleaned of machine-specific identity

## 2. Snapshot
- A **point-in-time capture**.
- Used for recovery, cloning, or preserving a state before changes.
- May retain machine-specific configuration and data.
- Can sometimes be converted or exported into a VM image. 
- 

# Reference
- https://docs.openstack.org/glance/yoga/user/formats.html