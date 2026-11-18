[//]: # (home)
[home doc]:    ../../../README.md
[home domain]: ../../README.md
[home topic]:  ../whatis/ep.md

[↖ Project][home topic] · [↖ Projects][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project RMS — Terminology


![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>


# The System
- The outcome of the project

# Resource
- Anything that can be provision on a host.
- A single provisioned entity 
- **Example**:
    - 1 host
    - 1 service
    - 1 file

## State of a resource
- what it is : define it for each resource provisioned/managed

## idempotency of an operation on a resource
- what it is : define it for each resource capability
- low-level components handle their own idempotency.

## kind of resource
any resource as a kind defined as a strict specialization tree like `kind/sub-kind/sub-sub-kind` (kind/kind1/kind2). it allows **specialization** and 

### Specialization & Fallback
when a requested operation on `file/txt/json`, match no driver, the engine can automatically fall back up the tree `file/txt` or `file` driver.


### Granular Overrides
A base `file/bin` driver can handle raw byte writing, while a specialized `file/bin/tgz` sub-driver can inherit those write capabilities and add automatic archive extraction.

# ResourceSet
- A collection/set of resources treated as a single logical group.


# Node
- aka. **Host**
- a single container, VM, bare-metal
- local or remote.


# Cluster
- aka. **Env**
- a set/collection/cluster of **host**

