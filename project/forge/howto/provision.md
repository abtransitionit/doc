[//]: #(Reference)
[HOME]:       ../whatis/forge.md
[res whatis]: ../whatis/res.md
[res list]:  ../list/res.md
[usecase list]: ../list/usecase.md

[←][HOME] Related topics
- [whatis a resource][res whatis]
- [List of resources][res list]
- [List of use case][usecase list]


# Provision a physical host

**Goal**:
1. Provision a physical host on a cloud
1. Provision it with resource (e.g. Hypervisor, Package, VMs, Kubernetes cluster)

**Given**:
* An account or connection to a Bare-metal provider on the cloud (e.g. OpenStack Ironic, MAAS, Amazon EC2 Bare Metal)
* The Bare-metal provider exposes a **CLI** or **API** for creating Physical servers
* The tool uses that CLI/API to provision Physical servers
* once created, the Physical servers itself is used as a provisioning target by the tool


**The flow**
```
Tool
│
├──> provisions → Resource:Physical Host
│                     └──> on a cloud 
│                             └──> provisioning is delegated to → the Bare-Metal Provider
│
│
└──> provisions → Resources: Package, User, File, ... 
                    │
                    └──> on Host: Physical Host
```
**Result**
- A physical host exists.
- The physical host is usable as a provisioning target.
- Resources can be provisioned on the target.


# Provision an existing physical host

**Goal**:
1. provision resources on an existing physical host
1. the physical host itself is not provisioned/created by the tool

**Given**:
* An existing physical host
* An account or connection to that host
  * e.g. SSH

**The flow**

```text
Tool
│
└──> provisions → Resources: Package, User, File, ...
                    │
                    └── on Host: Physical Host
```

**Result**

* An existing physical host is used as a provisioning target.
- Resources are provisioned on the target.




# Provision a container
**Goal**:
* provision a container from a container image
* make existing host resources available to the container

**Given**:
* A container runtime is available on a Host.
* A container image is accessible to the container runtime.
* Files to be served by the container already exist on the host.

# Provision an existing Container

**Goal**:
1. provision resources on an existing container

**Given**:
* An existing container exists on a host
* An account or connection to that container
  * e.g. `docker exec`, `podman exec`, or an agent


# Provision a VM

**Goal**:
1. Provision a VM on a hypervisor, cloud platform, or virtualized infrastructure.
1. Provision resources inside or on top of the VM (e.g., packages, application runtimes, containers, or Kubernetes nodes).

**Given**:

* An account or connection to a VM provider. E.g: 
  - local hypervisor: Hyper-V, VirtualBox, KVM/QEMU, VMware vSphere
  - cloud API
    - OVH API
    - AWS EC2 CLI or AWS API
    - OpenStack Nova
* the VM provider exposes a CLI or API for creating VMs
* The tool rely on that CLI or API to create and boot the VM, using mechanisms like 
  - `cloud-init`
  -  SSH for initial post-boot configuration.
* If needed, a source image or template (e.g., ISO, OVA, QCOW2, cloud-init image).
* If needed, a configuration target (e.g., CPU, RAM, disk size, network interfaces, IP/subnet settings).



> Once created, the VM itself be used as a provisioning target by the tool


# Provision an existing VM

**Goal**:
1. Provision resources or workloads on an already running/created VM.
1. The VM itself is not created or lifecycle-managed by the tool.

**Given**:

* An existing Virtual Machine instance.
* Remote access credentials and a network path to the VM (e.g., SSH keys/passwords, WinRM, or an installed management agent like Ansible/Puppet agent).
* System-level access (e.g., `sudo` or administrative privileges) on the VM guest OS.


# Provision a container

**Goal**:

1. Provision and launch a container from a specified container image.
1. Mount host resources (e.g., persistent volumes, network ports, environment variables, GPU pass-through) into the container runtime environment.

**Given**:

* A container runtime is available on a host (e.g., Docker, containerd, Podman).
* A container image is accessible to the container runtime (e.g., local image cache or remote container registry).
* Files, directories, or persistent volumes to be served by or bound to the container already exist on the host.


# Provision an existing Container

**Goal**:

1. Provision, update, or configure internal resources, files, or services inside an already running container.
1. The container instance lifecycle (creation/deletion) is managed separately or previously completed.

**Given**:

* An active, running container on a host.
* Execution access or a direct connection to the target container (e.g., `docker exec`, `podman exec`, `kubectl exec`, or an internal management agent).
* Necessary privilege levels within the container namespace to apply the desired state or configuration.

## Provision a Kubernetes cluster

**Goal**:
1. Provision a K8s cluster on 4 VMS

**Given**:
* An SSH access to 4 VPS on OVHCloud



## Provision an Openstack cluster
**Goal**:
1. Provision an Openstack cluster on 4 VMS

**Given**:
* An SSH access to 3 Bare-metal server on OVHCloud
* one of them is dedicated to the compute service on which users subsequently VM instances will live.


