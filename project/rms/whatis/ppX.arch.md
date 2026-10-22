[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ The System][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[agent whatis]: ../whatis/pp1.term.md

<div align="center">

# Project RMS — Phase1: Architecture

RMS. A unified Resource Management System

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

</div>



# Architecture Principles
## Separation of Responsibilities

The system shall defines a clear separation between **resource definitions** the **mechanisms used to access** resources.

## Common Resource Model

The system shall provides a common model for representing and managing resources across the system.


## Modularity

The system shall be modular at core with clearly defined responsibilities and interfaces between components.

## Extensibility

The system shall supports extensions through a plugin mechanism. 





# System Components and Responsibilities

Describe what each component does:

- Agent: Expresses intent and provides input.
- System: Validates and resolves requests, selects mechanisms, and coordinates execution.
- Execution Mechanisms: Perform operations on resources.


- Request Lifecycle focuses on the stages a request passes through
- How RMS Works describes the system's overall operating model.


# How RMS Works

1. **Agent Input**\
   The Agent supplies its intent and input to the System.
2. **Request Preparation**\
   The System builds a request using the standard process: parsing, creation, normalization, and validation.
3. **Execution**\
   The System executes the request using the appropriate mechanism.
4. **Result**\
   The System returns the execution result to the Agent.

- use How RMS Works for a high-level explanation of the overall process. 
- Use Request Lifecycle only if you later need to document the request's states, transitions, or detailed processing stages.


<details>
<summary><h1>Document Metadata</h1></summary>

**Information**

| Property | Value |
|:--|:--|
| **Doc-ID**       | PP-ARCH-01-RMS    |
| **Project**      | RMS                |
| **Path**         | `ppX.arch.md)` |
| **Last Updated** | 2026-10-20         |

**Revision History**

| Date | Version | Author | Summary |
|:--|:--|:--|:--|
| 2026-10-18 | `v0.1` | amar | Initial draft |

</details>
