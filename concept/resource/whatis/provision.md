[//]: #(home)
[home]:  ../whatis/ep.md

[//]: #(functional)
[provision howto]: ../howto/provision.md
[res whatis]:      ../whatis/res.md
[env whatis]:      ../whatis/host.md

[←][home] 

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a resource][res whatis]|internal
|[What is a host][env whatis]|internal
|[What is a operation ][operate whatis] |
|[How-to provision][provision howto]|see




<h1 align="center">What is Provisioning</h1>


# Definition

## Provision
* Depending on the context, **provision** generally means:**install, create, add, define, manage** and **configure**
* **Provisioning** a resource make that [resource][res whatis] available and ready for use.

## Provisioner
- An **Automation** concept
- Something that do the provisioning creates/configures/manages infrastructure
- Something that do the provisioning of a resource in an [environment][env whatis]
- By extension: something that provision a resource creates/configures/manages resources
- Example
  - VM provisioner creates/configures VMs ready to be provisioned
  - Bare-metal provisioner creates/configures Bare-metal servers ready to be provisioned

# Example
**Provision a host** could mean
  - create a host
  - install resources on a host


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