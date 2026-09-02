[//]: #(doc)
[res whatis]:      ../whatis/resource.md
[operate whatis]:  ../whatis/operate.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource ](../whatis/resource.md) |concept
|[What is operating](../whatis/operate.md)|concept




<h1 align="center">Provision</h1>


# Definition

## Provision
* The action of provisioning a [resource][res whatis].
* **Provisioning a resource**, 
  - make that [resource][res whatis] available and ready for use.
  - Prepares a resource for use
  - Is the very first step to make it available
* Depending on the context, **operate** generally means: 
  - **install, create, add, configure, manage or define**

## Provisioner
- An **Automation** concept
- Something that creates/configures/manages infrastructures/resources
- Example
  - A VM provisioner creates VMs (ready to be provisioned)
  - A Bare-metal provisioner creates Bare-metal servers (ready to be provisioned)

# Example
**Provision a host** could mean
  - create a host
  - install resources on a host

# Example
A provisioning system might interact with:
- VMware
- KVM
- Hyper-V
- OpenStack
- AWS
- OVHcloud

The provisioner doesn't necessarily run the VM. It asks the infrastructure system to create it.

# Bare-Metal provisioner
```
Physical server
       ↓
PXE/network boot
       ↓
Install OS
       ↓
Configure disk
       ↓
Configure network
       ↓
Configure OS
       ↓
Ready server
```
# VM provisioning
```
Existing physical server
        ↓
     Hypervisor
        ↓
      New VM
```
# Bare-metal provisioning
```
Physical server
        ↓
    Install OS
        ↓
   Ready machine
```

# Provisioner vs Hypervisor
- A provisioner creates/configures infrastructure.
- A provisioner may rely on the Hypervisor API
```
             Provisioner
                  │
          "Create a VM"
                  │
                  ▼
              Hypervisor
                  │
                  ▼
                 VM
```                 

```

                         CLOUD PROVIDER  ← AWS / OVHcloud / etc.
                    
                              │
                              ▼
                    Cloud management API
                              │
                         Provisioner
                              │
              ┌───────────────┴───────────────┐
              │                               │
        Bare-metal server                Virtual machine
              │                               │
              │                          Hypervisor
              │                       ┌───────┼───────┐
              │                       │       │       │
              │                      VM      VM      VM
              │                       │       │       │
              │                      OS      OS      OS
              │
              ▼
             OS
```             
```
                 Linux host OS
                       │
                       ▼
                 Container tech
                       │
                 ┌─────┴─────┐
                 │           │
                LXC         LXD
                 │           │
             containers   containers/VMs
```             