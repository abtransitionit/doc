[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(functional)
[provision howto]: ../howto/provision.md
[res whatis]:      ../whatis/res.md
[env whatis]:      ../whatis/host.md


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
* **Provisioning** a resource make it available and ready for use.
* Depending on the context, **provision** generally means:**install, create, add, define, manage** or **configure**

## Provisioner
- An **Automation** concept
- An [Agent] that provision a resource in an [environment][env whatis]
- Example
  - Infrastructure provisioner creates/configures infrastuctures ready to be provisioned/managed
  - VM provisioner creates/configures VMs ready to be provisioned/managed
  - Bare-metal provisioner creates/configures Bare-metal servers ready to be provisioned/managed

# Example
- **Provision a host** mean according to the context: create a host or install resources on a host


**Bare-Metal provisioning**

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
```
Physical server
        ↓
    Install OS
        ↓
   Ready machine
```

**VM provisioning**

```
Existing physical server
        ↓
     Hypervisor
        ↓
      New VM
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
                      OS
                       │
                       ▼
                 Container tech
                       │
                 ┌─────┴─────┐
                 │           │
                LXC         LXD
                 │           │
             containers   containers/VMs
                 │           │
              shared OS   shared OS
```             

# Todo
**Provisioning a host** could mean
  - create that host
  - install resources on a host
