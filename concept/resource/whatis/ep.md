[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[model whatis]:     /concept/model/whatis/ep.md
[res list]:         ../list/ep.md
[res hard whatis]:  ../whatis/hardware.md
[host whatis]:      ../whatis/host.md
[repo whatis]:      /concept/repository/whatis/ep.md
[provision whatis]: ../whatis/provision.md
[ope whatis]: ../whatis/operation.md
[env whatis]:       ../whatis/env.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Resource - controlled vocabulary](/_vocabulary/whatis/ep.md)|
|[What is a Model][model whatis]|see|
|[What is a Env][env whatis]|see|
|[What is a Host][host whatis]|see|
|[What is an Operation][ope whatis]|see|
|[What is a Hardware Resource][res hard whatis]|see|
|[List of Resources][res list]|see|


<h1 align="center">What is a Resource</h1>

The concept of resource




# Definition

- Can be [provisioned][provision whatis] in an [Environment][env whatis]
- Can be [operated][ope whatis] on / managed / controlled

# Key idea

- Every resource has properties.
- A resource may have members.
- Each member is itself a resource — so it also has properties. (Recursive.)

*Examples:*
- A machine = CPU + disk + memory. Each is a resource, each has its own properties.
- A repository = files + history + config. Each is a resource, each has its own properties.

# Kind

**Composition**
- **Atomic**     — seen as a whole; no named children (e.g. a file, a VM).
- **Composite**  — member are parts of **different kinds** (each named, distinct).
- **Collection** — member are items of the **same kind** (a set - e.g. a directory, a [repository][repo whatis], a cluster).

**Nature** <a id='nature'></a>
- **Physical** - a physical machine, a physical disk.
- **Virtual**  - a virtual model of a physical resource
- **Abstract** - an abstract model of a software/code

**Individual vs. Collection**


# Example
- See [List of Resources][res list]



# Relationships with other concepts

| subject | predicate | object |
|-|-|-|
| Resource | lives in | Environment |
| Resource | can depend on | Resource |
| Resource | can be provisioned in | Environment |
| Resource | can be operated on | — |


