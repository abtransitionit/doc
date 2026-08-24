[//]: #(Reference)
[HOME]:  ../whatis/forge.md

[provision howto]: ../howto/provision.md
[res whatis]:      ../whatis/res.md
[forge whatis]:    ../whatis/forge.md
[host whatis]:     ../whatis/host.md

[←][HOME] Related topics
|||
|-|-|
|[what is Forge][forge whatis]|internal
|[what is a resource][res whatis]|internal
|[what is a host][host whatis]|internal
|[Howto provision][provision howto]|see




<h1 align="center">Provision</h1>


# Definition

## Provision
* The action of provisioning a [resource][res whatis].
* *Provisioning a resource* make that [resource][res whatis] available and ready for use.
* Depending on the context, **provision** generally means: 
  - **install, create, add, configure, manage or define**

## Provisioner
- An **Automation** concept
- Something that creates/configures/manages infrastructure
- By extension: something that creates/configures/manages resources
- Example
  - VM provisioner creates/configures VMs ready to be provisioned
  - Bare-metal provisioner creates/configures Bare-metal servers ready to be provisioned

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