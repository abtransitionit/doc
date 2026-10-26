[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Task][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
<div align="center">

# Project RMS — Task - Architecture - Principes

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>




# Composability

- [Complex operations][ope whatis] should be expressible as [plans][plan whatis] composed of smaller actions. 
- Targets and execution [contexts][target context whatis] should support [composition][target composition whatis] where appropriate.

# Separation of concerns
The following should remain distinct concepts:

- Resource identity
- capabilities
- Operation definitions
- Execution mechanisms
- Interfaces 


# Extensibility

The core model should not depend on a closed list of resource types or mechanisms.

# Explicit execution semantics

use a request lifecycle

Distiinguish
- Request admission
- Execution progress
- Execution outcome

An accepted request is not necessarily a successful operation.

# Capability-aware execution

The system should account for declared capabilities, access restrictions, execution context, and other constraints when determining whether an operation can be performed.

# Observable outcomes

Actions and plans should expose sufficient status and result information to support debugging, automation, and verification.

# Controlled complexity

The architecture should support complex workflows without requiring every simple operation to use unnecessary orchestration layers.

# Technology independence

Technology choices should follow from **requirements** and **validated design decisions**.

