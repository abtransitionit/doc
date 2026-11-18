[//]: # (home)
[home domain]: ./README.md
[home doc]: ../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[whatis term]: ./term.md

<div align="center">

# Project RMS

A universal Resource Provisioning and Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>

# Index
- [Terminology][whatis term]


# The system to build
Can be 
- a CLI/API/SDK
- imperative (sequence of instructions) for ad-hoc commands 
- declarative (YAML/JSON/TOML manifest file) for automation, idempotency

## State of a resource
- what it is : define it for each resource provisioned/managed

## idempotency of an operation on a resource
- what it is : define it for each resource capability
- low-level components handle their own idempotency.

# Design of the system
- Modular: made of components
- Orthogonal: for kind/type/category

# Terminology
## resource 
- Anything that can be provision on a host.


## host
- Can be a single node or a collection/cluster of mixed infrastructure, whether local or remote.

Next question: **When it’s time to provision or manage something on a host, how does your system talk to the host?** (e.g., via SSH, an agent running on the host, an API, etc.)
