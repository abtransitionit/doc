[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Resource][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[res whatis]: ../whatis/ep.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource][res whatis]|see|


<h1 align="center">List of Environment</h1> <a id='res'></a>

The concept of resource

# List

| Term | What it represents | Examples |
| - | - | - |
||
| Environment | <li>a compute-capable context <li>in which resources are provisioned and executed <li> can be atomic or composite
| Host | <li>a kind of Environment <li>is **singular / atomic** | exactly 1 container, or 1 VM, or 1  bare-metal machine.
| Cluster | <li>a kind of Environment <li>is **composite** <li> a set of hosts| a set of hosts (containers or VMs) treated as one (context).
| Target | <li>a role not a kind <li> the Environment a provisioning action is directed at.

**Edge case**: a Host may in turn contain Hosts (nesting) and considered a cluster.
- a VMs may contains a set of containers (Nominal Use case)
- a containers may contains a set of containers (Docker in Docker)
- a VMs may contains VMs (Often used to test Openstack Use case)

**Edge semantics**: 
- a Host is the *atomic* form of an Environment: 1 container, 1 Vm, 1 bare-metal
- a Host is the thing that **hosts/contains/runs** something: E.g.:
    - 1 container host a root process
    - 1 VM hosts containers
    - 1 Bare-matel hosts a Hypervisor that hosts VMs
    - 1 Cluster hosts platform like kubernetes, Openstack


